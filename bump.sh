#!/bin/bash
# bump.sh — the mcpub auto-versioning law.
#
# Pack versions are two-segment `MAJOR.MINOR`. Any committed content change
# to a pack bumps that pack's MINOR segment (0.1 -> 0.2 -> ...) and refreshes
# the sha256 of every bundled attachment against the current file content.
# Packs new in this change keep their initial 0.1. A breaking interface-face
# change (pins/variants removed or reshaped) is a MAJOR bump and stays a
# human call — see WORKFLOW.md, "Versioning".
#
# Usage:
#   bump.sh              # worktree mode: bump packs with changes vs HEAD
#   bump.sh --staged     # staged mode: for the pre-commit hook; re-stages
#                        # pack.toml after editing so the bump rides the commit
set -euo pipefail
cd "$(dirname "$0")"

MODE="${1:-}"

# Changed paths: staged+unstaged vs HEAD plus untracked (worktree mode), or
# the staged set only (hook mode).
if [ "$MODE" = "--staged" ]; then
    NAMES="$(git diff --cached --name-only)"
else
    NAMES="$( (git diff --name-only HEAD; git ls-files --others --exclude-standard) )"
fi

# Pack dirs: depth-2 directories that carry a pack.toml and exist in HEAD
# (new packs start at 0.1, nothing to bump).
DIRS="$(printf '%s\n' "$NAMES" | while read -r f; do
    [ -n "$f" ] || continue
    d="$(dirname "$f")"
    case "$d" in
        */*) [ -f "$d/pack.toml" ] && git cat-file -e "HEAD:$d/pack.toml" 2>/dev/null && echo "$d" ;;
    esac
done | sort -u)"

[ -n "$DIRS" ] || exit 0

export BUMP_STAGED="$MODE"
printf '%s\n' "$DIRS" | python3 - <<'EOF'
import os, re, hashlib, subprocess, sys

staged = os.environ.get("BUMP_STAGED") == "--staged"
for d in sys.stdin.read().split():
    pt = os.path.join(d, "pack.toml")
    s = open(pt, encoding="utf-8").read()

    # refresh every bundled attachment checksum against current content
    # ([[attachments]] blocks are walked line-wise: track the current path,
    # rewrite the checksum line that follows it)
    lines = s.split("\n")
    cur_path = None
    for i, ln in enumerate(lines):
        pm = re.match(r'path = "([^"]+)"', ln.strip())
        if pm:
            cur_path = pm.group(1)
            continue
        cm = re.match(r'checksum = "sha256:([0-9a-f]{64})"', ln.strip())
        if cm and cur_path:
            ap = os.path.join(d, cur_path)
            if os.path.isfile(ap):
                h = hashlib.sha256(open(ap, "rb").read()).hexdigest()
                lines[i] = ln.replace(cm.group(1), h)
        elif not ln.strip():
            cur_path = None
    s = "\n".join(lines)

    # bump the MINOR segment of the two-segment [package] version (exactly
    # one version line; a legacy three-segment value is normalized first)
    m = re.search(r'^version = "(\d+)\.(\d+)(?:\.(\d+))?"$', s, re.M)
    if not m:
        print(f"SKIP {d}: no MAJOR.MINOR version line", file=sys.stderr)
        continue
    maj, mino = m.group(1), m.group(2)
    new = f"{maj}.{int(mino) + 1}"
    s = s[:m.start()] + f'version = "{new}"' + s[m.end():]
    open(pt, "w", encoding="utf-8").write(s)
    print(f"bumped {d}: {maj}.{mino} -> {new}")
    if staged:
        subprocess.run(["git", "add", pt], check=True)

sys.exit(0)
EOF
