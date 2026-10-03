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

- Vendor: Microchip
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: rtc, i2c, sram, timestamp
- Attachments: mcp7940m.pdf, mcp7940m.txt

## Usage

```text
use mcp7940m.mcp7940m    # use by the entry part name after installing the pack (variant surface: see pack.toml [variants])
```

```bash
mcc lib pack mcp7940m          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
