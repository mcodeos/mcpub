# drv8304

Real three-phase smart gate driver (DRV8304H, RHA: 40-pin VQFN with exposed
thermal pad), transcribed from TI ZHCSI91B (Chinese datasheet, p.3 package
drawing; pinout page-verified, Pin Functions table cross-checked against
the figure pin-by-pin). The H variant is hardware-controlled: pins 26-29
carry MODE/IDRIVE/VDS/GAIN resistor-set configuration; the S variant swaps
them for the SPI face (nSCS/SCLK/SDI/SDO) and is a different shape family.
The exposed thermal pad is unlabeled in the figure (no net name).
Pins ride the mclibs three-phase gate driver shape.

- 厂商: TI
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: gate-driver, 3-phase, spi, motor
- 附件: drv8304.pdf, drv8304.txt

## 使用

```text
use drv8304.drv8304    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack drv8304          # 出 .mcl + .thin.mcl
mcc lib install --from drv8304-0.1.0.mcl   # 装入 ~/.mcode/
```
