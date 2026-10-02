# pca9555

本包无头注释面；说明以 entry `.mc` 与附件 datasheet 为准。

- 厂商: NXP
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: io-expander, i2c, 16-bit, gpio
- 附件: pca9555.pdf, pca9555.txt

## 使用

```text
use pca9555.pca9555    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack pca9555          # 出 .mcl + .thin.mcl
mcc lib install --from pca9555-0.1.0.mcl   # 装入 ~/.mcode/
```
