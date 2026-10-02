# ps1240p02bt

Real externally-driven piezo sounder (TDK PS1240P02BT), transcribed from
the TDK PS-series catalog (007-01/20110508/ef532_ps; part detail catalog
p.3, page-verified from rendered page images — the catalog has no text
layer). Two PCB pins, 12.7mm pitch, body 12.2 x 6.5mm; 4kHz at 3 Vo-p
rectangular wave, 70dBA/10cm min, max input 30 Vo-p (without DC bias).
The catalog documents no polarity for the pin-terminal parts.
Pins ride the mclibs passive piezo sounder shape.

- 厂商: TDK
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: buzzer, piezo, magnetic, smd
- 附件: ps1240.pdf

## 使用

```text
use ps1240p02bt.ps1240p02bt    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack ps1240p02bt          # 出 .mcl + .thin.mcl
mcc lib install --from ps1240p02bt-0.1.0.mcl   # 装入 ~/.mcode/
```
