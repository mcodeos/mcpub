# phb2awb

Real 2-pole wire-to-board terminal (LHE PHB-2AWB, A2005-SR02), transcribed
from the two source documents beside this file (PHB.txt = series spec
sheet, PHB2.txt = series approval drawing). A terminal block, not an
electroacoustic part: the board's speaker drive reaches the speaker wire
through these two solder pads.

Series ratings (PHB.txt): 100V AC/DC rated voltage, 2A rated current,
contact resistance 20mOhm max, insulation resistance 1000MOhm min,
withstand 800V AC for one minute, ambient -25 to +85 degC, wire range
AWG#30-#22 (UL E217379). Construction (PHB2.txt): housing LCP beige,
wafer and solder pads brass tin-plated; pole count is per order
(PHB-2..18AWB); the 2P size ships without a polarizing key, so the two
poles carry no documented polarity.

The leaf stays a passive two-terminal: no direction words, no interface
adoption (ruling-19 census A1: passive pairing data is carried by the
net's other side), neutral pole names after the mclibs passive-leaf form.

- 厂商: LHE
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: connector, ph2.0, header, horizontal
- 附件: PHB.pdf, PHB.txt, PHB2.pdf, PHB2.txt

## 使用

```text
use phb2awb.phb2awb    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack phb2awb          # 出 .mcl + .thin.mcl
mcc lib install --from phb2awb-0.1.0.mcl   # 装入 ~/.mcode/
```
