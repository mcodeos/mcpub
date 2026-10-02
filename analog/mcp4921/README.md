# mcp4921

Real single-channel 12-bit write-only SPI DAC (MCP4921, 8-pin PDIP/SOIC/
MSOP), transcribed from DS22248A (bullet specs p.1; DC accuracy Table 3-1
p.3; AC characteristics p.4; pinout page-verified). Pins ride the mclibs
SPI DAC shape.

- 厂商: Microchip
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: dac, spi, 12-bit
- 附件: mcp4921.pdf, mcp4921.txt

## 使用

```text
use mcp4921.mcp4921    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack mcp4921          # 出 .mcl + .thin.mcl
mcc lib install --from mcp4921-0.1.0.mcl   # 装入 ~/.mcode/
```
