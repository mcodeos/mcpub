# mcp4921

Real single-channel 12-bit write-only SPI DAC (MCP4921, 8-pin PDIP/SOIC/
MSOP), transcribed from DS22248A (bullet specs p.1; DC accuracy Table 3-1
p.3; AC characteristics p.4; pinout page-verified). Pins ride the mclibs
SPI DAC shape.

- Vendor: Microchip
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: dac, spi, 12-bit
- Attachments: mcp4921.pdf, mcp4921.txt

## Usage

```text
use mcp4921.mcp4921    # use by the entry part name after installing the pack (variant surface: see pack.toml [variants])
```

```bash
mcc lib pack mcp4921          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
