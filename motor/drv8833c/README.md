# drv8833c

Real dual brushed-DC H-bridge driver (DRV8833CPWP, HTSSOP-16 with PowerPAD),
transcribed from TI SLVSCP9 (p.3 package drawing; pinout page-verified,
Pin Functions table cross-checked against the figure pin-by-pin).
Pin 11 is NC in the PWP; the unnumbered PowerPAD is grounded per the GND
row description. VM operating range 2.7-11.8V.
Pins ride the mclibs dual H-bridge shape.

- 厂商: TI
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: motor-driver, h-bridge, dual, pwm
- 附件: drv8833c.pdf, drv8833c.txt

## 使用

```text
use drv8833c.drv8833c    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack drv8833c          # 出 .mcl + .thin.mcl
mcc lib install --from drv8833c-0.1.0.mcl   # 装入 ~/.mcode/
```
