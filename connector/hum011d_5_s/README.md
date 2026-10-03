# hum011d_5_s

Real Mini USB B receptacle (HUM011D-5-S). The pin book adopts the mcode
USB.MINIB interface (checklist 4.10): 1=VBUS, 2=D-, 3=D+ (@pair(d)), 4=ID,
5=GND; pads 6/7 are GND return; the two shield pads are exposed boundary
electrodes (4.9). The pin book matches the mcode USB.SOCK_MINIB base —
a library file cannot inherit an mcode component base (the `:` base only
resolves in board scope), so the shapes agree by adoption, not derivation.

- Vendor: unknown
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: connector, usb, mini-b, receptacle

## Usage

```text
use hum011d_5_s.hum011d_5_s    # use by the entry part name after installing the pack (variant surface: see pack.toml [variants])
```

```bash
mcc lib pack hum011d_5_s          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
