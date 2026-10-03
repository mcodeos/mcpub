# cc2652r

This pack has no header-comment face; the entry `.mc` and the attached
datasheet are authoritative.

- Vendor: TI
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: soc, cortex-m4, zigbee, thread, 2.4ghz, rf
- Attachments: cc2652r.cn.pdf, cc2652r.pdf, cc2652r.txt

## Usage

```text
use cc2652r.cc2652r    # after installing the pack, use by the entry part name (see pack.toml [variants] for the variant face)
```

```bash
mcc lib pack cc2652r          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
