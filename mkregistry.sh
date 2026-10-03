#!/bin/bash
# Generate the static registry tree (registry-design.md §3) from build/:
#
#   <reg>/lib/<name>.json                      package metadata (one per pack)
#   <reg>/lib/<PARTNO>.json                    partno alias entries (package face,
#                                              versions restricted to carriers)
#   <reg>/dl/<category>/<name>/<ver>/*.mcl     dual artifacts, canonical names
#
# The tree is the whole P2 server: dumb storage, all selection client-side.
# Checksums are computed over the artifacts; the metadata `variants` lists
# the *partno strings* read out of the entry source (§3.1 — pack.toml's
# [variants] keys are the identifier face and are never compared against a
# partno). Rerunning over historical artifact batches would merge versions
# into the same entries; this first cut regenerates per batch (one version
# per pack). Packs on the known-red list are skipped, same law as build.sh.
#
# Usage: ./mkregistry.sh [reg-dir]   (default: registry/)
set -eu
cd "$(dirname "$0")"

REG="${1:-registry}"
BUILD="${BUILD:-build}"
KNOWN_RED="${KNOWN_RED:-rfsoc/cc2530 rfsoc/cc2652r rfsoc/cst92f32 rfsoc/efr32mg21 rfsoc/esp32h2}"

sha() { shasum -a 256 "$1" | cut -d' ' -f1; }

# toml scalar read: get_toml <key> <file>  (plain `key = "value"` lines only)
get_toml() { sed -n "s/^$1 = \"\(.*\)\"$/\1/p" "$2" | head -1; }

# canonical two-segment version (the repo's write law): x.y.z -> x.y
canon_ver() { case "$1" in *.*.*) echo "${1%.*}" ;; *) echo "$1" ;; esac; }

mkdir -p "$REG/lib"

green=0 skipped=0
for toml in */*/pack.toml; do
    dir="$(dirname "$toml")"
    case " $KNOWN_RED " in *" $dir "*) skipped=$((skipped + 1)); continue ;; esac

    name="$(get_toml name "$toml")"
    ver="$(canon_ver "$(get_toml version "$toml")")"
    category="$(get_toml category "$toml")"
    entry="$(get_toml entry "$toml")"

    thin="$BUILD/$name-$ver.thin.mcl"
    full="$BUILD/$name-$ver.mcl"
    if [ ! -f "$thin" ] || [ ! -f "$full" ]; then
        echo "SKIP (no artifacts in $BUILD): $dir — run ./build.sh first"
        skipped=$((skipped + 1))
        continue
    fi

    # dl/<category>/<name>/<ver>/
    dl="$REG/dl/$category/$name/$ver"
    mkdir -p "$dl"
    cp "$thin" "$dl/$name-$ver.thin.mcl"
    cp "$full" "$dl/$name-$ver.mcl"
    thin_sum="sha256:$(sha "$dl/$name-$ver.thin.mcl")"
    full_sum="sha256:$(sha "$dl/$name-$ver.mcl")"

    # partno strings, straight off the entry source — never guessed from the
    # variant keys.
    partnos="$(sed -n 's/^[[:space:]]*partno = "\([^"]*\)"$/\1/p' "$dir/$entry" | sort -u)"

    # package metadata: versions{ver:{checksum, thin_checksum, size, deps, variants}}
    deps_json=""
    if sed -n '/^\[dependencies\]/,/^\[/p' "$toml" | grep -q '='; then
        deps_json=$(sed -n '/^\[dependencies\]/,/^\[/{s/^\([^[][^=]*\) *= *"\(.*\)"$/"\1": "\2",/p;}' "$toml" | sed '$s/,$//')
        deps_json=", \"deps\": {$deps_json}"
    fi
    variants_json=$(echo "$partnos" | sed 's/.*/"&"/' | paste -sd, -)
    printf '{"name": "%s", "category": "%s", "versions": {"%s": {"checksum": "%s", "thin_checksum": "%s", "size": %s%s, "variants": [%s]}}}\n' \
        "$name" "$category" "$ver" "$full_sum" "$thin_sum" \
        "$(stat -f%z "$dl/$name-$ver.thin.mcl")" "$deps_json" "$variants_json" \
        > "$REG/lib/$name.json"

    # partno alias entries: the package face is authoritative, the version
    # table restricted to where the partno exists (this batch = this version).
    for p in $partnos; do
        printf '{"name": "%s", "category": "%s", "package": "%s", "versions": {"%s": {"checksum": "%s", "thin_checksum": "%s", "size": %s, "variants": ["%s"]}}}\n' \
            "$p" "$category" "$name" "$ver" "$full_sum" "$thin_sum" \
            "$(stat -f%z "$dl/$name-$ver.thin.mcl")" "$p" \
            > "$REG/lib/$p.json"
    done
    green=$((green + 1))
done

echo "registry: $green packs registered, $skipped skipped -> $REG/"
