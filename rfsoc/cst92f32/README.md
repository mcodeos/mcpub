# cst92f32

本包无头注释面；说明以 entry `.mc` 与附件 datasheet 为准。

- 厂商: ChipSea
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: soc, ble, 2.4ghz, rf, cortex-m0
- 附件: cst92f32.pdf, cst92f32.txt

## 使用

```text
use cst92f32.cst92f32    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack cst92f32          # 出 .mcl + .thin.mcl
mcc lib install --from cst92f32-0.1.0.mcl   # 装入 ~/.mcode/
```
