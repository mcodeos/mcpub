# pl3085a

This pack has no header comment face; the entry `.mc` and the attached
datasheet are authoritative.

- Vendor: Belling
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: rs485, transceiver, uart
- Attachments: BL3085(I47).pdf, BL3085A.pdf

## Usage

```text
use pl3085a.pl3085a    # use by the entry part name after installing the pack (variant surface: see pack.toml [variants])
```

```bash
mcc lib pack pl3085a          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
