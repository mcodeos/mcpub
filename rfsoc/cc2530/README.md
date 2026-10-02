# cc2530

本包无头注释面；说明以 entry `.mc` 与附件 datasheet 为准。

- 厂商: TI
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: soc, 8051, zigbee, 2.4ghz, rf
- 附件: cc2530.pdf, cc2530.txt

## 使用

```text
use cc2530.cc2530    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack cc2530          # 出 .mcl + .thin.mcl
mcc lib install --from cc2530-0.1.0.mcl   # 装入 ~/.mcode/
```
