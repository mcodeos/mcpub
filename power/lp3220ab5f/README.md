# lp3220ab5f

Real buck converter (LP3220AB5F, SOT23-5), extracted from the verified hbl
board (U192 power batch). Pins ride the mclibs SOT23-5 buck shape; grade
spec windows live here (outside the variant data lock).

- 厂商: unknown
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: dcdc, converter, sot-23

## 使用

```text
use lp3220ab5f.lp3220ab5f    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack lp3220ab5f          # 出 .mcl + .thin.mcl
mcc lib install --from lp3220ab5f-0.1.0.mcl   # 装入 ~/.mcode/
```
