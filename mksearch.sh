#!/bin/bash
# Generate the catalog faces of the static registry (registry-p3-protocol.md
# §1, /search.json + /index/<category>.json) from the metadata tree:
#
#   <reg>/search.json               {"packages": [{name, category, description, latest}]}
#   <reg>/index/<category>.json     the same rows, restricted to one category
#
# Rows come from <reg>/lib/<name>.json — partno alias entries (they carry
# "package") are excluded, they are the resolution face, not the catalog.
# `latest` is the greatest non-yanked version by numeric ordering. Run after
# mkregistry.sh (or after every publish that lands in the tree).
#
# Usage: ./mksearch.sh [reg-dir]   (default: build/registry/)
set -eu
cd "$(dirname "$0")"

REG="${1:-build/registry}"

python3 - "$REG" <<'PY'
import json, re, sys
from pathlib import Path

reg = Path(sys.argv[1])
lib = reg / "lib"
rows = {}
for p in sorted(lib.glob("*.json")):
    try:
        meta = json.loads(p.read_text())
    except json.JSONDecodeError:
        continue
    if "package" in meta:
        continue  # partno alias, not a catalog row

    def vkey(v):
        # canonical two-segment law; tolerate three for safety
        parts = [int(x) for x in re.match(r"^(\d+)\.(\d+)(?:\.(\d+))?$", v).groups("0")]
        return tuple(parts)

    live = [v for v, row in meta.get("versions", {}).items() if not row.get("yanked")]
    rows[meta["name"]] = {
        "name": meta["name"],
        "category": meta.get("category", ""),
        "description": meta.get("description"),
        "latest": max(live, key=vkey) if live else None,
    }

packages = [rows[k] for k in sorted(rows)]
(reg / "search.json").write_text(json.dumps({"packages": packages}, ensure_ascii=False) + "\n")

idx = reg / "index"
idx.mkdir(exist_ok=True)
by_cat = {}
for r in packages:
    by_cat.setdefault(r["category"], []).append(r)
for cat, items in by_cat.items():
    (idx / f"{cat}.json").write_text(json.dumps({"packages": items}, ensure_ascii=False) + "\n")

print(f"catalog: {len(packages)} packages, {len(by_cat)} categories -> {reg}/search.json")
PY
