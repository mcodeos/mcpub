# bss138n

This pack has no head comment surface; the entry `.mc` and the attached
datasheet are authoritative.

- Vendor: onsemi
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: mosfet, n-channel, sot-23, level-shift
- Attachments: bss138n.pdf, bss138n.txt

## Usage

```text
use bss138n.bss138n    # use by the entry part name after installing the pack (variant surface: see pack.toml [variants])
```

```bash
mcc lib pack bss138n          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
