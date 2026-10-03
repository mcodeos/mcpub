# cst92f32

This pack has no header-comment face; the entry `.mc` and the attached
datasheet are authoritative.

- Vendor: ChipSea
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: soc, ble, 2.4ghz, rf, cortex-m0
- Attachments: cst92f32.pdf, cst92f32.txt

## Usage

```text
use cst92f32.cst92f32    # after installing the pack, use by the entry part name (see pack.toml [variants] for the variant face)
```

```bash
mcc lib pack cst92f32          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
