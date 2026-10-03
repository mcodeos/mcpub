# lpa4871

Real analog audio power amplifier, extracted from the verified hbl board
(U192, C7 electroacoustic batch). Pins ride the mclibs abstract shape.

- Vendor: unknown
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: audio, amplifier, class-d
- Attachments: LPA4871.pdf, lm4871.pdf

## Usage

```text
use lpa4871.lpa4871    # use by the entry part name after installing the pack (variant surface: see pack.toml [variants])
```

```bash
mcc lib pack lpa4871          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
