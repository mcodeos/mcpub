# wm7121p

Real MEMS silicon microphone (analog), extracted from the verified hbl
board (U192, C7 electroacoustic batch). Pins ride the mclibs abstract shape.

- 厂商: Cirrus Logic
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: microphone, mems, digital, pdm
- 附件: wm7121p.pdf, wm7121p.txt

## 使用

```text
use wm7121p.wm7121p    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack wm7121p          # 出 .mcl + .thin.mcl
mcc lib install --from wm7121p-0.1.0.mcl   # 装入 ~/.mcode/
```
