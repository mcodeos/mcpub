# tle7368

This pack has no header-comment face; the entry `.mc` and the attached
datasheet are authoritative.

- Vendor: Infineon
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: power-ic, automotive, sbc, linear-regulator
- Attachments: tle7368-3E.pdf

## Usage

```text
use tle7368.tle7368    # after installing the pack, use by the entry part name (see pack.toml [variants] for the variant face)
```

```bash
mcc lib pack tle7368          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
