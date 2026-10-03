# mcp2003

Real LIN J2602 transceiver (MCP2003, 8-pin PDIP/SOIC; Microchip marks the
part Not Recommended for New Designs in favor of MCP2003B -- kept as the
industry-standard LIN pinout specimen), transcribed from DS20002230G
(bullet specs p.1; pinout page-verified:
1 RXD, 2 CS, 3 WAKE, 4 TXD, 5 VSS, 6 LBUS, 7 VBB, 8 VREN).
Pins ride the mclibs LIN transceiver shape.

- Vendor: Microchip
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: lin, transceiver, uart, automotive
- Attachments: mcp2003.pdf, mcp2003.txt

## Usage

```text
use mcp2003.mcp2003    # use by the entry part name after installing the pack (variant surface: see pack.toml [variants])
```

```bash
mcc lib pack mcp2003          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
