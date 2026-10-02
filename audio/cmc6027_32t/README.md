# cmc6027_32t

Real electret capsule microphone, extracted from the verified hbl board
(U192, C7 electroacoustic batch). Pins ride the mclibs abstract shape.

- 厂商: CUI Devices
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: microphone, electret, analog, capsule
- 附件: cmc6027-32t.pdf, cmc6027-32t.txt

## 使用

```text
use cmc6027_32t.cmc6027_32t    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack cmc6027_32t          # 出 .mcl + .thin.mcl
mcc lib install --from cmc6027_32t-0.1.0.mcl   # 装入 ~/.mcode/
```
