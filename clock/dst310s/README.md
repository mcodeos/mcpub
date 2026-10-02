# dst310s

Real 2-pin passive crystal (DST310S, 3215 package), extracted verbatim
from the verified hbl board (U192 crystal batch).

Ruling U192-2 keeps the parameterized crystal face in mcode (XTAL2(freq,
cload) already carries it; concrete values flow through the formals).
This file stays a standalone real part: a `:` binding against an mcode/
mclibs abstract waits for the U187 xtal naming-law debt to clear first
(bind-after-debt order, U192 table).

- 厂商: unknown
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: crystal, oscillator, 32.768khz
- 附件: dst310s.pdf, dst310s.txt

## 使用

```text
use dst310s.dst310s    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack dst310s          # 出 .mcl + .thin.mcl
mcc lib install --from dst310s-0.1.0.mcl   # 装入 ~/.mcode/
```
