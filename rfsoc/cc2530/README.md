# cc2530

This pack has no header-comment face; the entry `.mc` and the attached
datasheet are authoritative.

- Vendor: TI
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: soc, 8051, zigbee, 2.4ghz, rf
- Attachments: cc2530.pdf, cc2530.txt

## Usage

```text
use cc2530.cc2530    # after installing the pack, use by the entry part name (see pack.toml [variants] for the variant face)
```

```bash
mcc lib pack cc2530          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
