# nsi814x

This pack has no head comment surface; the entry `.mc` and the attached
datasheet are authoritative.

- Vendor: NOVOSENSE
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: digital-isolator, isolation, uart
- Attachments: nsi814x.pdf, nsi814x.txt

## Usage

```text
use nsi814x.nsi814x    # use by the entry part name after installing the pack (variant surface: see pack.toml [variants])
```

```bash
mcc lib pack nsi814x          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
