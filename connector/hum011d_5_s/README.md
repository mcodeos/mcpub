# hum011d_5_s

Real Mini USB B receptacle (HUM011D-5-S). The pin book adopts the mcode
USB.MINIB interface (checklist 4.10): 1=VBUS, 2=D-, 3=D+ (@pair(d)), 4=ID,
5=GND; pads 6/7 are GND return; the two shield pads are exposed boundary
electrodes (4.9). The pin book matches the mcode USB.SOCK_MINIB base —
a library file cannot inherit an mcode component base (the `:` base only
resolves in board scope), so the shapes agree by adoption, not derivation.

- 厂商: unknown
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: connector, usb, mini-b, receptacle

## 使用

```text
use hum011d_5_s.hum011d_5_s    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack hum011d_5_s          # 出 .mcl + .thin.mcl
mcc lib install --from hum011d_5_s-0.1.0.mcl   # 装入 ~/.mcode/
```
