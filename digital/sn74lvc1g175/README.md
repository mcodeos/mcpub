# sn74lvc1g175

This pack has no head comment surface; the entry `.mc` and the attached
datasheet are authoritative.

- Vendor: TI
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: logic, flip-flop, d-type, sot-23, single-gate
- Attachments: sn74lvc1g175.pdf, sn74lvc1g175.txt

## Usage

```text
use sn74lvc1g175.sn74lvc1g175    # use by the entry part name after installing the pack (variant surface: see pack.toml [variants])
```

```bash
mcc lib pack sn74lvc1g175          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
