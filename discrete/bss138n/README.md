# bss138n

本包无头注释面；说明以 entry `.mc` 与附件 datasheet 为准。

- 厂商: onsemi
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: mosfet, n-channel, sot-23, level-shift
- 附件: bss138n.pdf, bss138n.txt

## 使用

```text
use bss138n.bss138n    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack bss138n          # 出 .mcl + .thin.mcl
mcc lib install --from bss138n-0.1.0.mcl   # 装入 ~/.mcode/
```
