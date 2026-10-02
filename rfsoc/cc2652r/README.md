# cc2652r

本包无头注释面；说明以 entry `.mc` 与附件 datasheet 为准。

- 厂商: TI
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: soc, cortex-m4, zigbee, thread, 2.4ghz, rf
- 附件: cc2652r.cn.pdf, cc2652r.pdf, cc2652r.txt

## 使用

```text
use cc2652r.cc2652r    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack cc2652r          # 出 .mcl + .thin.mcl
mcc lib install --from cc2652r-0.1.0.mcl   # 装入 ~/.mcode/
```
