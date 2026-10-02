# sgm2019

Real 3.3V LDO (SGM2019-3.3YN5G/TR, SOT23-5), extracted from the verified
hbl board (U192 power batch). Pins ride the mclibs SOT23-5 LDO shape;
grade spec windows live here (outside the variant data lock).

- 厂商: SGMICRO
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: ldo, linear-regulator, sot-23-5
- 附件: sgm2019_33yn5g.pdf

## 使用

```text
use sgm2019.sgm2019    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack sgm2019          # 出 .mcl + .thin.mcl
mcc lib install --from sgm2019-0.1.0.mcl   # 装入 ~/.mcode/
```
