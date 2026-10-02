# drv8323s

Real SPI-configured three-phase smart gate driver (DRV8323SRTAT, RTA: 40-pin
WQFN with exposed thermal pad), transcribed from TI ZHCSG01C (Chinese
datasheet, p.7 package drawing; pinout page-verified, Pin Functions table
cross-checked against the figure pin-by-pin). The S variant keys pins 1-25
and 31-40 identically to the DRV8304H; pins 26-29 carry the SPI face
(SDO/SDI/SCLK/nSCS) instead of the resistor-set configuration. The H
variant keeps MODE/IDRIVE/VDS/GAIN on 26-29 and rides GATEDRV.H6 instead.
The thermal pad is unnumbered and must be grounded. VM range 6-60V.
Pins ride the mclibs SPI-configured three-phase gate driver shape.

- 厂商: TI
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: gate-driver, 3-phase, spi, current-sense, motor
- 附件: drv8323s.pdf, drv8323s.txt

## 使用

```text
use drv8323s.drv8323s    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack drv8323s          # 出 .mcl + .thin.mcl
mcc lib install --from drv8323s-0.1.0.mcl   # 装入 ~/.mcode/
```
