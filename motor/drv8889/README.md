# drv8889

Real automotive stepper driver (DRV8889QPWPRQ1, HTSSOP-24 with PowerPAD),
transcribed from TI ZHCSJO5 (Chinese datasheet, p.3 package drawing; pinout
page-verified, Pin Functions table cross-checked against the figure
pin-by-pin). The thermal pad carries no pin number and is grounded per the
PAD row. VM operating range 4.5-45V. The RGE (VQFN-24) variant keys
differently and is a separate face.
Pins ride the mclibs stepper driver shape.

- 厂商: TI
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: stepper-driver, microstepping, spi
- 附件: drv8889.pdf, drv8889.txt

## 使用

```text
use drv8889.drv8889    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack drv8889          # 出 .mcl + .thin.mcl
mcc lib install --from drv8889-0.1.0.mcl   # 装入 ~/.mcode/
```
