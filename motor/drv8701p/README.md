# drv8701p

Real brushed-DC full-bridge gate driver (DRV8701P, RGE: 24-pin VQFN with
exposed pad), transcribed from TI ZHCSDO0A (Chinese datasheet, p.3 package
drawing; pinout page-verified, Pin Functions table cross-checked against
the figure pin-by-pin). The P variant uses IN1/IN2 PWM control; the E
variant (PH/EN) swaps pins 14/15 and is a different shape family. The
ground group is pins 5 / 16 plus the unnumbered exposed pad (PPAD).
VM operating range 5.9-45V.
Pins ride the mclibs brushed-DC full-bridge gate driver shape.

- 厂商: TI
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: gate-driver, h-bridge, spi, motor
- 附件: drv8701.pdf, drv8701.txt

## 使用

```text
use drv8701p.drv8701p    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack drv8701p          # 出 .mcl + .thin.mcl
mcc lib install --from drv8701p-0.1.0.mcl   # 装入 ~/.mcode/
```
