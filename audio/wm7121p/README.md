# wm7121p

Real MEMS silicon microphone (analog), extracted from the verified hbl
board (U192, C7 electroacoustic batch). Pins ride the mclibs abstract shape.

- Vendor: Cirrus Logic
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: microphone, mems, digital, pdm
- Attachments: wm7121p.pdf, wm7121p.txt

## Usage

```text
use wm7121p.wm7121p    # use by the entry part name after installing the pack (variant surface: see pack.toml [variants])
```

```bash
mcc lib pack wm7121p          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
