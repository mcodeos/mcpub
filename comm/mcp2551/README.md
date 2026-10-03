# mcp2551

Real high-speed CAN transceiver (MCP2551, 8-pin PDIP/SOIC),
transcribed from DS21667D (bullet specs p.1; DC characteristics p.8;
pinout page-verified: 1 TXD, 2 VSS, 3 VDD, 4 RXD, 5 VREF, 6 CANL,
7 CANH, 8 Rs). Pins ride the mclibs CAN transceiver shape.

- Vendor: Microchip
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: can, transceiver, 2.0b
- Attachments: mcp2551.pdf, mcp2551.txt

## Usage

```text
use mcp2551.mcp2551    # use by the entry part name after installing the pack (variant surface: see pack.toml [variants])
```

```bash
mcc lib pack mcp2551          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
