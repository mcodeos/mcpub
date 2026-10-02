# tle7368

本包无头注释面；说明以 entry `.mc` 与附件 datasheet 为准。

- 厂商: Infineon
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: power-ic, automotive, sbc, linear-regulator
- 附件: tle7368-3E.pdf

## 使用

```text
use tle7368.tle7368    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack tle7368          # 出 .mcl + .thin.mcl
mcc lib install --from tle7368-0.1.0.mcl   # 装入 ~/.mcode/
```
