# dst310s

Real 2-pin passive crystal (DST310S, 3215 package), extracted verbatim
from the verified hbl board (U192 crystal batch).

Ruling U192-2 keeps the parameterized crystal face in mcode (XTAL2(freq,
cload) already carries it; concrete values flow through the formals).
This file stays a standalone real part: a `:` binding against an mcode/
mclibs abstract waits for the U187 xtal naming-law debt to clear first
(bind-after-debt order, U192 table).

- Vendor: unknown
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: crystal, oscillator, 32.768khz
- Attachments: dst310s.pdf, dst310s.txt

## Usage

```text
use dst310s.dst310s    # use by the entry part name after installing the pack (variant surface: see pack.toml [variants])
```

```bash
mcc lib pack dst310s          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
