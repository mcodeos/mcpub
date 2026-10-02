# pl3085a

本包无头注释面；说明以 entry `.mc` 与附件 datasheet 为准。

- 厂商: Belling
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: rs485, transceiver, uart
- 附件: BL3085(I47).pdf, BL3085A.pdf

## 使用

```text
use pl3085a.pl3085a    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack pl3085a          # 出 .mcl + .thin.mcl
mcc lib install --from pl3085a-0.1.0.mcl   # 装入 ~/.mcode/
```
