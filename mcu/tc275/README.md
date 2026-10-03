# tc275

This package has no header-comment face; see the entry `.mc` and the attached datasheet for details.

- Vendor: Infineon
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: mcu, aurix, tricore, automotive, lqfp-176
- Attachments: tc275.pdf

## Usage

```text
use tc275.tc275    # use by entry part name after installing (variant face in pack.toml [variants])
```

```bash
mcc lib pack tc275          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
