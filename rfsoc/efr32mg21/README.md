# efr32mg21

本包无头注释面；说明以 entry `.mc` 与附件 datasheet 为准。

- 厂商: Silicon Labs
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: soc, ble, mesh, 2.4ghz, rf, cortex-m33
- 附件: efr32mg21.pdf, efr32mg21.txt

## 使用

```text
use efr32mg21.efr32mg21    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack efr32mg21          # 出 .mcl + .thin.mcl
mcc lib install --from efr32mg21-0.1.0.mcl   # 装入 ~/.mcode/
```
