# drv8302

Real three-phase gate driver with integrated buck regulator (DRV8302,
DCA: 56-pin HTSSOP with PowerPAD numbered 57 = GND), transcribed from TI
ZHCS138C (Chinese datasheet, p.3 package drawing; pinout page-verified,
Pin Functions table cross-checked against the figure pin-by-pin).
Two supply domains: PVDD1 (gate driver) and PVDD2 (buck). The exposed
PowerPAD carries pin number 57 and the name GND.
PVDD operating range 8-60V.
Pins ride the mclibs three-phase gate driver with buck shape.

- 厂商: TI
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: gate-driver, 3-phase, buck, current-sense, motor
- 附件: drv8302.pdf, drv8302.txt

## 使用

```text
use drv8302.drv8302    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack drv8302          # 出 .mcl + .thin.mcl
mcc lib install --from drv8302-0.1.0.mcl   # 装入 ~/.mcode/
```
