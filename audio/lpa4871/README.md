# lpa4871

Real analog audio power amplifier, extracted from the verified hbl board
(U192, C7 electroacoustic batch). Pins ride the mclibs abstract shape.

- 厂商: unknown
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: audio, amplifier, class-d
- 附件: LPA4871.pdf, lm4871.pdf

## 使用

```text
use lpa4871.lpa4871    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack lpa4871          # 出 .mcl + .thin.mcl
mcc lib install --from lpa4871-0.1.0.mcl   # 装入 ~/.mcode/
```
