# tc275

本包无头注释面；说明以 entry `.mc` 与附件 datasheet 为准。

- 厂商: Infineon
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: mcu, aurix, tricore, automotive, lqfp-176
- 附件: tc275.pdf

## 使用

```text
use tc275.tc275    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack tc275          # 出 .mcl + .thin.mcl
mcc lib install --from tc275-0.1.0.mcl   # 装入 ~/.mcode/
```
