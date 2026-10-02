# sn74lvc1g175

本包无头注释面；说明以 entry `.mc` 与附件 datasheet 为准。

- 厂商: TI
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: logic, flip-flop, d-type, sot-23, single-gate
- 附件: sn74lvc1g175.pdf, sn74lvc1g175.txt

## 使用

```text
use sn74lvc1g175.sn74lvc1g175    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack sn74lvc1g175          # 出 .mcl + .thin.mcl
mcc lib install --from sn74lvc1g175-0.1.0.mcl   # 装入 ~/.mcode/
```
