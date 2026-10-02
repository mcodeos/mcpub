# a4950

Real full-bridge DMOS PWM motor driver (A4950ELJTR-T, 8-pin SOICN with
exposed thermal pad), transcribed from Allegro A4950-DS rev.2 (p.2 terminal
list table + pin-out diagram, page-verified pin-by-pin). The exposed PAD
carries no net name in the terminal list ("exposed pad for enhanced thermal
dissipation"); the application note permits tying it to the star ground.
VBB operating range 8-40V, peak output current 3.5A.
Pins ride the mclibs single full-bridge shape.

- 厂商: Allegro
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: motor-driver, h-bridge, dmos, pwm
- 附件: a4950.pdf, a4950.txt

## 使用

```text
use a4950.a4950    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack a4950          # 出 .mcl + .thin.mcl
mcc lib install --from a4950-0.1.0.mcl   # 装入 ~/.mcode/
```
