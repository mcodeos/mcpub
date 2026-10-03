#!/bin/bash
# Build every device pack in mcpub: run `mcc lib pack` on each
# <category>/<part>/ directory and emit the full/thin .mcl artifacts
# into build/mcl/ (the sweep half of build/; mkregistry.sh regenerates
# the registry tree into build/registry/ from it).
#
# The known-red list (rfsoc grammar debts) is tolerated and reported;
# any NEW red fails the sweep (exit 1) so the red set cannot grow
# silently. Override the binary with MCC=...; override the known-red
# list with KNOWN_RED="dir1 dir2 ...".
set -u
cd "$(dirname "$0")"

MCC="${MCC:-$(command -v mcc || echo /Users/dan/work/mo/mcc/target/debug/mcc)}"
OUT="${OUT:-build/mcl}"
KNOWN_RED="${KNOWN_RED:-rfsoc/cc2530 rfsoc/cc2652r rfsoc/cst92f32 rfsoc/efr32mg21 rfsoc/esp32h2 comm/pl3085a}"

mkdir -p "$OUT"

green=0 knownred=0 newred=0
for toml in */*/pack.toml; do
    dir="$(dirname "$toml")"
    if "$MCC" lib pack "$dir" --out "$OUT" >/dev/null 2>&1; then
        green=$((green + 1))
    else
        case " $KNOWN_RED " in
            *" $dir "*)
                knownred=$((knownred + 1))
                echo "RED (known): $dir"
                ;;
            *)
                newred=$((newred + 1))
                echo "RED (NEW):   $dir"
                "$MCC" lib pack "$dir" --out "$OUT" 2>&1 | tail -5
                ;;
        esac
    fi
done

echo "packs: $green green, $knownred known-red, $newred new-red -> $OUT/"
[ "$newred" -eq 0 ]
