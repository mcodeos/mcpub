# efr32mg21

This pack has no header-comment face; the entry `.mc` and the attached
datasheet are authoritative.

- Vendor: Silicon Labs
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: soc, ble, mesh, 2.4ghz, rf, cortex-m33
- Attachments: efr32mg21.pdf, efr32mg21.txt

## Usage

```text
use efr32mg21.efr32mg21    # after installing the pack, use by the entry part name (see pack.toml [variants] for the variant face)
```

```bash
mcc lib pack efr32mg21          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
