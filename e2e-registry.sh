#!/bin/bash
# End-to-end exercise of the registry P2 local closure (registry-design.md
# §4/§6) plus the P3 HTTP/publish face (registry-p3-protocol.md).
#
#   pack -> registry tree -> project build (auto-install) -> mcode.lock ->
#   lock-first rebuild -> offline rebuild -> partno alias solve ->
#   fetch-docs -> lib update -> lib install --here (vendoring) ->
#   build over HTTP (P3) -> search --remote -> keygen/sign/publish round trip
#
# The run is fully sandboxed: a scratch MCC_SYSTEM_ROOT carries an mcode
# sibling symlink (libmgr's bare-mcode fallback resolves root/../mcode), so
# the real ~/.mcode data root (and its trust store) is never touched.
#
# Stages (each fails hard on the first violated expectation):
#   0. sandbox   scratch data root + mcode sibling symlink
#   1. pack      `mcc lib pack <device-dir>` -> thin+full .mcl artifacts
#   2. registry  mcpub/mkregistry.sh over the artifacts (the real server tree:
#                lib/<name>.json + lib/<PARTNO>.json aliases + dl/ artifacts)
#   3. project   scratch project.toml: [dependencies] <name> = "<req>" plus
#                [config.registry] url = "file://<tree>"
#   4. build     first build must install the pack (stderr "installed
#                <name>@<ver>"), land it as <root>/<name>@<ver>/ and write
#                mcode.lock with the pin
#   5. rebuild   second build must be lock-first: no reinstall, lock
#                byte-identical (build never rewrites the lock)
#   6. offline   registry tree deleted; the lock + the installed copy must
#                carry the rebuild (lock-first zero-network)
#   7. partno    the alias dependency form ("<PARTNO>" = "*") re-solves in
#                full and the lock records the partno face
#   8. docs      `lib fetch-docs` pulls bundled attachments missing from the
#                installed thin pack out of the sha256-verified full tier
#   9. update    `lib update <key>` re-solves and rewrites the lock (the ONLY
#                lock-rewrite authority)
#  10. vendor    `lib install <name> --here` places the pack in
#                <project>/deps/ (explicit-placement law)
#  11. http      the same tree served by `python3 -m http.server`; a fresh
#                project builds against url = http://127.0.0.1:<port> and
#                installs through the P3 fetch face (ETag cache, /dl/ stream);
#                rebuild is lock-first with the server dead
#  12. search    `lib search --remote` reads /search.json over HTTP and
#                reports the pack
#  13. publish   `lib keygen` mints an Ed25519 key into the sandbox trust
#                store; a version-bumped copy of the pack is `lib publish`ed
#                (dry run first, then --go, signed): the delta merges into the
#                tree in place (immutable law holds for same-version), the
#                partno alias rows follow, search.json is regenerated, and a
#                fresh project installs the new version through the verified
#                signature
#  15. cond      ETag/If-None-Match against mock-registry.py (a static host
#                with real-server behaviors): the second search is answered
#                304 and the client serves from its cache; the .etag sidecar
#                is asserted in the cache dir
#  16. errors    mock --fail-500: a failing registry surfaces "HTTP 500" by
#                name and exits — never a hang, never a silent empty result
#  17. rsync     publish with transport = rsync ships the delta to a second
#                tree (the "remote" host form); the published version then
#                installs from that tree, signature verified
#  18. trunc     mock --truncate-at: the cut /dl/ body fails the checksum by
#                name and nothing lands in the data root (client-side twin of
#                the shard7 in-process truncation test)
#
# Usage: ./e2e-registry.sh [mcc-binary] [device-dir]
#   mcc-binary  default: /Users/dan/work/mo/mcc/target/debug/mcc
#   device-dir  default: ./power/ams1117 (a known-green pack; must not be on
#               mkregistry.sh's known-red list)
set -eu
cd "$(dirname "$0")"

MCC="${1:-/Users/dan/work/mo/mcc/target/debug/mcc}"
DEVICE="${2:-power/ams1117}"
BASE="$(mktemp -d /tmp/mcpub-e2e-registry.XXXXXX)"
ROOT="$BASE/root"          # the sandbox data root (MCC_SYSTEM_ROOT)
ART="$BASE/artifacts"      # packed .mcl artifacts (stands in for build/)
REG="$BASE/reg"            # the static registry tree (stands in for the server)
PROJ="$BASE/proj"          # the consuming scratch project

cleanup() {
    [ -n "${HTTP_PID:-}" ] && kill "$HTTP_PID" 2>/dev/null || true
    # E2E_KEEP=1 preserves the sandbox for post-mortem inspection.
    [ -n "${E2E_KEEP:-}" ] || rm -rf "$BASE"
}
trap cleanup EXIT

step() { printf '\n== %s\n' "$*"; }
expect() {  # expect <what> <command...> — run, fail the stage if it exits non-zero
    local what="$1"; shift
    if ! "$@" >/dev/null 2>&1; then
        echo "FAIL: $what" >&2
        "$@" 2>&1 | tail -20 >&2 || true
        exit 1
    fi
    echo "ok: $what"
}

mkdir -p "$ROOT" "$ART" "$PROJ/src"
ln -s /Users/dan/work/mo/mcode "$BASE/mcode"

# Every mcc call below runs against the sandbox root.
export MCC_SYSTEM_ROOT="$ROOT"

step "0. sandbox: $BASE (mcc: $MCC, device: $DEVICE)"

step "1. pack: mcc lib pack $DEVICE"
expect "pack succeeds (compile-gate passed)" \
    "$MCC" lib pack "$DEVICE" --out "$ART"
# The canonical artifact names come from pack.toml (mkregistry.sh reads the
# same faces); take whatever the pack step actually produced.
THIN="$(ls "$ART"/*.thin.mcl | head -1)"
FULL="$(ls "$ART"/*.mcl | grep -v '\.thin\.mcl' | head -1)"
echo "   thin: $(basename "$THIN")  full: $(basename "$FULL")"

step "2. registry tree: mkregistry.sh (the real server-side generator)"
BUILD="$ART" ./mkregistry.sh "$REG" | grep -v '^SKIP' || true
PKG_NAME="$(basename "$DEVICE" | tr -d '/')"
[ -f "$REG/lib/$PKG_NAME.json" ] || { echo "FAIL: no metadata for $PKG_NAME in the tree" >&2; exit 1; }
echo "ok: metadata + partno aliases + dl/ artifacts present"

step "3. project: [dependencies] $PKG_NAME + [config.registry] file://"
cat > "$PROJ/project.toml" <<EOF
[project]
name = "e2e-reg"
version = "0.1"
entry = "src/main.mc"

[dependencies]
mcode = "*"
$PKG_NAME = "*"

[config.registry]
url = "file://$REG"
EOF
printf 'module main()\n{\n}\n' > "$PROJ/src/main.mc"

step "4. first build: solve -> install -> lock"
( cd "$PROJ" && "$MCC" build 2>&1 >/dev/null ) | grep -q "installed $PKG_NAME@" \
    || { echo "FAIL: first build did not install $PKG_NAME" >&2; exit 1; }
[ -d "$ROOT/$PKG_NAME@"* ] || { echo "FAIL: pack did not land in the data root" >&2; exit 1; }
grep -q "$PKG_NAME" "$PROJ/mcode.lock" || { echo "FAIL: lock does not record the pack" >&2; exit 1; }
echo "ok: installed into the data root, mcode.lock written"

step "5. second build: lock-first (no reinstall, lock byte-stable)"
cp "$PROJ/mcode.lock" "$BASE/lock.before"
( cd "$PROJ" && "$MCC" build 2>&1 >/dev/null ) | grep -qi 'installed' \
    && { echo "FAIL: second build reinstalled" >&2; exit 1; }
cmp -s "$PROJ/mcode.lock" "$BASE/lock.before" \
    || { echo "FAIL: build rewrote the lock" >&2; exit 1; }
echo "ok: no reinstall, lock untouched"

step "6. offline rebuild: registry tree removed, lock + installed copy carry it"
rm -rf "$REG"
( cd "$PROJ" && "$MCC" build 2>&1 >/dev/null ) | grep -qi 'installed' \
    && { echo "FAIL: offline rebuild reinstalled" >&2; exit 1; }
echo "ok: offline rebuild green (lock-first zero-network)"

step "7. partno alias: \"$PKG_NAME\" = \"*\" -> \"<PARTNO>\" = \"*\""
BUILD="$ART" ./mkregistry.sh "$REG" >/dev/null 2>&1
PARTNO="$(python3 -c "import json;m=json.load(open('$REG/lib/$PKG_NAME.json'));print(m['versions'][sorted(m['versions'])[0]]['variants'][0])")"
sed -i '' "s|^$PKG_NAME = \"\*\"$|\"$PARTNO\" = \"*\"|" "$PROJ/project.toml"
rm "$PROJ/mcode.lock"
( cd "$PROJ" && "$MCC" build >/dev/null 2>&1 ) \
    || { echo "FAIL: partno-key build failed" >&2; exit 1; }
grep -q "package = \"$PKG_NAME\"" "$PROJ/mcode.lock" \
    || { echo "FAIL: lock does not record the partno form in full" >&2; exit 1; }
echo "ok: partno $PARTNO solved through the alias entry, lock records it"

step "8. fetch-docs: bundled attachments pulled from the full tier"
( cd "$PROJ" && "$MCC" lib fetch-docs "$PKG_NAME" 2>&1 ) | grep -q '✓' \
    || { echo "FAIL: fetch-docs failed" >&2; exit 1; }
echo "ok: thin pack completed from the full tier"

step "9. lib update: the only lock-rewrite authority"
( cd "$PROJ" && "$MCC" lib update "$PARTNO" >/dev/null 2>&1 ) \
    || { echo "FAIL: lib update failed" >&2; exit 1; }
grep -q "\"$PARTNO\"" "$PROJ/mcode.lock" \
    || { echo "FAIL: lock lost the refreshed key" >&2; exit 1; }
echo "ok: lock rewritten with the key re-pinned"

step "10. vendoring: lib install --here -> <project>/deps/"
# The data-root copy from stage 4 would be reused as-is (--here is a placement
# face, not a re-fetch); drop it first so the vendoring path is the one taken.
rm -rf "$ROOT/$PKG_NAME@"*
( cd "$PROJ" && "$MCC" lib install "$PKG_NAME" --here >/dev/null 2>&1 ) \
    || { echo "FAIL: lib install --here failed" >&2; exit 1; }
[ -d "$PROJ/deps/$PKG_NAME@"* ] \
    || { echo "FAIL: pack did not land in <project>/deps" >&2; exit 1; }
echo "ok: vendored into deps/"

# ── P3 (registry-p3-protocol.md): HTTP fetch, remote search, publish ──

step "11. http: build against python3 -m http.server (the P3 fetch face)"
HTTP_LOG="$BASE/http.log"
python3 -u -m http.server 0 --bind 127.0.0.1 --directory "$REG" >"$HTTP_LOG" 2>&1 &
HTTP_PID=$!
PORT=""
for _ in $(seq 1 100); do
    PORT="$(sed -n 's/Serving HTTP on .* port \([0-9]*\).*/\1/p' "$HTTP_LOG" | head -1)"
    [ -n "$PORT" ] && break
    sleep 0.1
done
[ -n "$PORT" ] || { echo "FAIL: http server did not start" >&2; cat "$HTTP_LOG" >&2; exit 1; }
echo "   serving $REG on 127.0.0.1:$PORT"

PROJ2="$BASE/proj-http"
mkdir -p "$PROJ2/src"
cat > "$PROJ2/project.toml" <<EOF
[project]
name = "e2e-reg-http"
version = "0.1"
entry = "src/main.mc"

[dependencies]
mcode = "*"
$PKG_NAME = "*"

[config.registry]
url = "http://127.0.0.1:$PORT"
EOF
printf 'module main()\n{\n}\n' > "$PROJ2/src/main.mc"
# The data-root copy was vendored away in stage 10, so this build must take
# the HTTP download path, not reuse a local copy.
( cd "$PROJ2" && "$MCC" build 2>&1 >/dev/null ) | grep -q "installed $PKG_NAME@" \
    || { echo "FAIL: HTTP build did not install $PKG_NAME" >&2; exit 1; }
[ -d "$ROOT/$PKG_NAME@"* ] || { echo "FAIL: HTTP install did not land in the data root" >&2; exit 1; }
echo "ok: installed over HTTP (metadata ETag cache + /dl/ stream)"

kill "$HTTP_PID" 2>/dev/null || true
wait "$HTTP_PID" 2>/dev/null || true
HTTP_PID=""
( cd "$PROJ2" && "$MCC" build 2>&1 >/dev/null ) | grep -qi 'installed' \
    && { echo "FAIL: serverless rebuild reinstalled" >&2; exit 1; }
echo "ok: lock-first rebuild green with the server dead"

step "12. search --remote: the /search.json catalog face"
BUILD="$ART" ./mksearch.sh "$REG" >/dev/null
python3 -u -m http.server 0 --bind 127.0.0.1 --directory "$REG" >"$HTTP_LOG" 2>&1 &
HTTP_PID=$!
PORT=""
for _ in $(seq 1 100); do
    PORT="$(sed -n 's/Serving HTTP on .* port \([0-9]*\).*/\1/p' "$HTTP_LOG" | head -1)"
    [ -n "$PORT" ] && break
    sleep 0.1
done
[ -n "$PORT" ] || { echo "FAIL: http server (search) did not start" >&2; exit 1; }
# The stage-11 server died; point the project at this instance's port.
sed -i '' "s|url = \"http://127.0.0.1:[0-9]*\"|url = \"http://127.0.0.1:$PORT\"|" "$PROJ2/project.toml"
( cd "$PROJ2" && "$MCC" lib search --remote "$PKG_NAME" 2>&1 ) | grep -q "$PKG_NAME" \
    || { echo "FAIL: remote search did not report $PKG_NAME" >&2; exit 1; }
echo "ok: remote search reported $PKG_NAME [community]"

step "13. publish: keygen -> sign -> stage -> apply in place -> verified install"
KEY="$BASE/keys/reg.ed25519"
KEYGEN_OUT="$( cd "$PROJ2" && "$MCC" lib keygen "$KEY" 2>&1 )"
echo "$KEYGEN_OUT" | grep -q 'signing key written' \
    || { echo "FAIL: keygen failed: $KEYGEN_OUT" >&2; exit 1; }
PUBKEY="$(echo "$KEYGEN_OUT" | sed -n 's/.*public = "\([^"]*\)".*/\1/p' | tail -1)"
KEYID="$(echo "$KEYGEN_OUT" | sed -n 's/.*keyid: \(.*\)/\1/p' | head -1)"
[ -n "$PUBKEY" ] && [ -n "$KEYID" ] || { echo "FAIL: keygen output unparsable: $KEYGEN_OUT" >&2; exit 1; }
# Consumers trust the key via the sandbox trust store (datadir::config_dir
# follows MCC_SYSTEM_ROOT, so the real ~/.mcode store is untouched).
mkdir -p "$ROOT/config"
cat > "$ROOT/config/trust.toml" <<EOF
[[keys]]
keyid = "$KEYID"
public = "$PUBKEY"
EOF
# The publisher config is global-only (mcc.yaml); the registry url itself
# comes from the project the publish runs in.
cat > "$ROOT/config/mcc.yaml" <<EOF
registry:
  publish:
    key: "$KEY"
    transport: "none"
EOF

# A version-bumped copy of the pack source; publish packs it itself.
PUBDIR="$BASE/pubsrc"
cp -R "$DEVICE" "$PUBDIR"
PUBVER="1.$(printf '%d' $((RANDOM % 9 + 1)))"
sed -i '' "s|^version = \".*\"|version = \"$PUBVER\"|" "$PUBDIR/pack.toml"

# The publish commands run against the FILE face (transport none + file:// is
# the apply-in-place combination); the HTTP face only stages (the generator
# runs at the target). The install of the published version reuses this
# project afterwards.
PROJ3="$BASE/proj-pub"
mkdir -p "$PROJ3/src"
cat > "$PROJ3/project.toml" <<EOF
[project]
name = "e2e-reg-pub"
version = "0.1"
entry = "src/main.mc"

[config.registry]
url = "file://$REG"
EOF
printf 'module main()\n{\n}\n' > "$PROJ3/src/main.mc"

# Dry run: stages under ./publish-delta/, moves nothing.
rm -rf "$PROJ3/publish-delta"
( cd "$PROJ3" && "$MCC" lib publish "$PUBDIR" 2>&1 ) | grep -q 'dry run' \
    || { echo "FAIL: publish dry run did not stop at the listing" >&2; exit 1; }
[ -f "$PROJ3/publish-delta/lib/$PKG_NAME.json" ] \
    || { echo "FAIL: dry run staged no metadata" >&2; exit 1; }
grep -q "\"$PUBVER\"" "$REG/lib/$PKG_NAME.json" \
    && { echo "FAIL: dry run mutated the tree" >&2; exit 1; }
echo "ok: dry run staged the delta, tree untouched"

# --go: signed, merged in place (file:// + transport none), aliases + search.json.
( cd "$PROJ3" && "$MCC" lib publish "$PUBDIR" --go 2>&1 ) | tee "$BASE/publish-go.log" | grep -q ', signed' \
    || { echo "FAIL: publish --go did not sign" >&2; tail -20 "$BASE/publish-go.log" >&2; exit 1; }
python3 - "$REG" "$PKG_NAME" "$PUBVER" <<'PY'
import json, sys
meta = json.load(open(f"{sys.argv[1]}/lib/{sys.argv[2]}.json"))
assert sys.argv[3] in meta["versions"], f"version missing after --go: {meta['versions'].keys()}"
row = meta["versions"][sys.argv[3]]
assert row.get("sig", "").startswith("ed25519:") and row.get("keyid"), "unsigned row"
alias = json.load(open(f"{sys.argv[1]}/lib/{row['variants'][0]}.json"))
assert sys.argv[3] in alias["versions"], "alias row not extended"
idx = json.load(open(f"{sys.argv[1]}/search.json"))
hit = [p for p in idx["packages"] if p["name"] == sys.argv[2]]
assert hit and hit[0]["latest"] >= sys.argv[3], f"search.json not regenerated: {hit}"
print("   merged: version + signed row + alias + regenerated search.json")
PY
# The immutable law: republishing the same version refuses.
if ( cd "$PROJ3" && "$MCC" lib publish "$PUBDIR" --go >/dev/null 2>&1 ); then
    echo "FAIL: immutable law violated — same version re-published" >&2
    exit 1
fi
echo "ok: same-version republish refused"

# The same project then installs the published version; the signature
# verifies against the sandbox trust store.
rm -rf "$PROJ3/publish-delta"
cat >> "$PROJ3/project.toml" <<EOF

[dependencies]
mcode = "*"
$PKG_NAME = "=$PUBVER"
EOF
( cd "$PROJ3" && "$MCC" build 2>&1 >/dev/null ) | grep -q "installed $PKG_NAME@$PUBVER" \
    || { echo "FAIL: verified-signature install of $PUBVER failed" >&2; exit 1; }
echo "ok: published version installed, signature verified"

# ── P3 client vs a real-server-shaped host: mock-registry.py adds ETag/304
#    and fault injection over the same static tree (stages 11/12 keep the
#    dumb static host as the plain-static coverage) ──

start_mock() {  # start_mock <logfile> <extra args...> — sets HTTP_PID and PORT
    local out="$BASE/mock-$1.out"; shift
    python3 ./mock-registry.py --root "$REG" --port 0 "$@" >"$out" 2>&1 &
    HTTP_PID=$!
    PORT=""
    for _ in $(seq 1 100); do
        PORT="$(sed -n 's/MOCK port \([0-9]*\).*/\1/p' "$out" | head -1)"
        [ -n "$PORT" ] && break
        sleep 0.1
    done
    [ -n "$PORT" ] || { echo "FAIL: mock did not start" >&2; cat "$out" >&2; exit 1; }
}

stop_http() {
    [ -n "${HTTP_PID:-}" ] && kill "$HTTP_PID" 2>/dev/null || true
    [ -n "${HTTP_PID:-}" ] && wait "$HTTP_PID" 2>/dev/null || true
    HTTP_PID=""
}

step "15. conditional: the 304 arm (ETag + If-None-Match) against the mock"
stop_http   # retire the stage-12 static server; PROJ2 gets repointed below
COND_LOG="$BASE/http-cond.log"
start_mock cond --log "$COND_LOG"
sed -i '' "s|url = \"http://127.0.0.1:[0-9]*\"|url = \"http://127.0.0.1:$PORT\"|" "$PROJ2/project.toml"
# Search #1 stores the ETag beside the cached meta; search #2 must hit the
# conditional arm and be answered 304 (the client serves from cache).
for _ in 1 2; do
    ( cd "$PROJ2" && "$MCC" lib search --remote "$PKG_NAME" >/dev/null 2>&1 ) \
        || { echo "FAIL: remote search (conditional) failed" >&2; exit 1; }
done
grep -q ' 304$' "$COND_LOG" \
    || { echo "FAIL: no 304 served — the conditional arm never ran" >&2; cat "$COND_LOG" >&2; exit 1; }
[ -n "$(find "$ROOT/cache/meta" -name '*.etag' -print -quit)" ] \
    || { echo "FAIL: no .etag sidecar parked beside the cached meta" >&2; exit 1; }
echo "ok: 304 on revalidation, ETag parked in the cache"

step "16. error face: a failing registry is named, not hung and not silent"
# The catalog (/search.json) has no cache — a 500 there must fail by name.
# (Metadata rows already cached survive a 500 by the offline law; that face
# is stages 6/11's, not this one's.)
ERR_LOG="$BASE/http-err.log"
start_mock err --log "$ERR_LOG" --fail-500 "search.json"
sed -i '' "s|url = \"http://127.0.0.1:[0-9]*\"|url = \"http://127.0.0.1:$PORT\"|" "$PROJ2/project.toml"
OUT="$( cd "$PROJ2" && "$MCC" lib search --remote "$PKG_NAME" 2>&1 )" \
    && { echo "FAIL: search --remote succeeded against a 500 registry" >&2; exit 1; }
echo "$OUT" | grep -q 'HTTP 500' \
    || { echo "FAIL: the 500 was not named: $OUT" >&2; exit 1; }
echo "ok: HTTP 500 surfaced by name"

step "17. transport rsync: publish ships the delta to the remote-form tree"
stop_http
REG2="$BASE/reg-remote"
cp -R "$REG" "$REG2"          # the "remote host" starts from the published state
PUBVER2="9.$(printf '%d' $((RANDOM % 9 + 1)))"   # 9.x cannot collide with PUBVER
sed -i '' "s|^version = \".*\"|version = \"$PUBVER2\"|" "$PUBDIR/pack.toml"
cat > "$ROOT/config/mcc.yaml" <<EOF
registry:
  publish:
    key: "$KEY"
    transport: "rsync"
    target: "$REG2/"
EOF
PROJ4="$BASE/proj-rsync"
mkdir -p "$PROJ4/src"
cat > "$PROJ4/project.toml" <<EOF
[project]
name = "e2e-reg-rsync"
version = "0.1"
entry = "src/main.mc"

[config.registry]
url = "file://$REG2"
EOF
printf 'module main()\n{\n}\n' > "$PROJ4/src/main.mc"
( cd "$PROJ4" && "$MCC" lib publish "$PUBDIR" --go 2>&1 ) | grep -q 'transported' \
    || { echo "FAIL: rsync transport did not ship the delta" >&2; exit 1; }
grep -q "\"$PUBVER2\"" "$REG2/lib/$PKG_NAME.json" \
    || { echo "FAIL: version row absent from the remote tree" >&2; exit 1; }
grep -q '"sig":"ed25519:' "$REG2/lib/$PKG_NAME.json" \
    || { echo "FAIL: the shipped row lost its signature" >&2; exit 1; }
cat >> "$PROJ4/project.toml" <<EOF

[dependencies]
mcode = "*"
$PKG_NAME = "=$PUBVER2"
EOF
( cd "$PROJ4" && "$MCC" build 2>&1 >/dev/null ) | grep -q "installed $PKG_NAME@$PUBVER2" \
    || { echo "FAIL: install from the rsync-published tree failed" >&2; exit 1; }
echo "ok: delta shipped by rsync, published version installed from the remote tree"

step "18. truncation: a cut artifact fails the checksum with no half install"
# The client-side twin of shard7's in-process truncation test (which also
# pinned the fix: the download scratch is process-unique, so concurrent
# installs of the same name never share a .part sibling).
stop_http
start_mock trunc --log "$BASE/http-trunc.log" --truncate-at 64
PROJ5="$BASE/proj-trunc"
mkdir -p "$PROJ5/src"
cat > "$PROJ5/project.toml" <<EOF
[project]
name = "e2e-reg-trunc"
version = "0.1"
entry = "src/main.mc"

[dependencies]
mcode = "*"
$PKG_NAME = "*"

[config.registry]
url = "http://127.0.0.1:$PORT"
EOF
printf 'module main()\n{\n}\n' > "$PROJ5/src/main.mc"
# Remove every installed copy so the build must download afresh (a later
# stage's 9.x install would otherwise satisfy `*` without the network).
rm -rf "$ROOT/$PKG_NAME@"*
OUT="$( cd "$PROJ5" && "$MCC" build 2>&1 >/dev/null )" \
    && { echo "FAIL: a truncated artifact must fail the build" >&2; exit 1; }
echo "$OUT" | grep -q 'checksum mismatch' \
    || { echo "FAIL: the truncation was not named: $OUT" >&2; exit 1; }
ls -d "$ROOT/$PKG_NAME@"* 2>/dev/null \
    && { echo "FAIL: half install landed in the data root" >&2; exit 1; }
echo "ok: truncated download refused by checksum, nothing installed"

printf '\nALL GREEN — registry P2 + P3 verified end to end\n'
