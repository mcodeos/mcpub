# mcp7940m

Real low-cost I2C RTCC (MCP7940M, Microchip DS20002292C), rewritten from
the datasheet. Pins are the verified device face (pin function table 2-1,
shared by all five 8-lead packages): 1 X1, 2 X2, 3 NC, 4 VSS, 5 SDA,
6 SCL, 7 MFP, 8 VCC. The TDFN exposed pad ties to VSS or floats.

The M member has NO battery backup: an earlier revision of this book
carried the MCP7940N description (battery backup, power-fail time-stamp,
backup voltage range) — that text belongs to the N and is dropped.

The MFP row keeps a plain `out`: @drive is witnessed on interface pin rows
only, and the open-drain note stays in the row description (lm66100 ST
precedent).

- 厂商: Microchip
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: rtc, i2c, sram, timestamp
- 附件: mcp7940m.pdf, mcp7940m.txt

## 使用

```text
use mcp7940m.mcp7940m    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack mcp7940m          # 出 .mcl + .thin.mcl
mcc lib install --from mcp7940m-0.1.0.mcl   # 装入 ~/.mcode/
```
