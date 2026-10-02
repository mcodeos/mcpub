# mcp3204

Real 4-channel 12-bit SPI ADC (MCP3204, 14-pin PDIP/SOIC/TSSOP),
transcribed from DS21298E (bullet specs p.1; SPI timing table p.16;
pinout page-verified). Pins ride the mclibs SPI ADC shape.

- 厂商: Microchip
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: adc, spi, 12-bit, 4ch
- 附件: mcp3204.pdf, mcp3204.txt

## 使用

```text
use mcp3204.mcp3204    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack mcp3204          # 出 .mcl + .thin.mcl
mcc lib install --from mcp3204-0.1.0.mcl   # 装入 ~/.mcode/
```
