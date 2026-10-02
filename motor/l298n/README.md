# l298n

Real dual full-bridge driver (L298N, Multiwatt15), transcribed from the
ST L298 datasheet (p.2 PIN CONNECTIONS drawing; pinout page-verified,
Pin Functions table p.3 cross-checked pin-by-pin). The metal tab is
connected to pin 8 (GND). Vs abs max 46V (42V in characteristics),
Vss 5V logic supply.
Pins ride the mclibs classic dual full-bridge shape.

- 厂商: STMicroelectronics
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: motor-driver, h-bridge, dual, multiwatt
- 附件: l298.pdf, l298.txt

## 使用

```text
use l298n.l298n    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack l298n          # 出 .mcl + .thin.mcl
mcc lib install --from l298n-0.1.0.mcl   # 装入 ~/.mcode/
```
