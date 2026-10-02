# nsi814x

本包无头注释面；说明以 entry `.mc` 与附件 datasheet 为准。

- 厂商: NOVOSENSE
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: digital-isolator, isolation, uart
- 附件: nsi814x.pdf, nsi814x.txt

## 使用

```text
use nsi814x.nsi814x    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack nsi814x          # 出 .mcl + .thin.mcl
mcc lib install --from nsi814x-0.1.0.mcl   # 装入 ~/.mcode/
```
