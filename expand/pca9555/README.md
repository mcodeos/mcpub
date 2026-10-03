# pca9555

This pack has no head comment surface; the entry `.mc` and the attached
datasheet are authoritative.

- Vendor: NXP
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: io-expander, i2c, 16-bit, gpio
- Attachments: pca9555.pdf, pca9555.txt

## Usage

```text
use pca9555.pca9555    # use by the entry part name after installing the pack (variant surface: see pack.toml [variants])
```

```bash
mcc lib pack pca9555          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
