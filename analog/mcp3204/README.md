# mcp3204

Real 4-channel 12-bit SPI ADC (MCP3204, 14-pin PDIP/SOIC/TSSOP),
transcribed from DS21298E (bullet specs p.1; SPI timing table p.16;
pinout page-verified). Pins ride the mclibs SPI ADC shape.

- Vendor: Microchip
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: adc, spi, 12-bit, 4ch
- Attachments: mcp3204.pdf, mcp3204.txt

## Usage

```text
use mcp3204.mcp3204    # use by the entry part name after installing the pack (variant surface: see pack.toml [variants])
```

```bash
mcc lib pack mcp3204          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
