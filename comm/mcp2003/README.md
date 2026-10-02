# mcp2003

Real LIN J2602 transceiver (MCP2003, 8-pin PDIP/SOIC; Microchip marks the
part Not Recommended for New Designs in favor of MCP2003B -- kept as the
industry-standard LIN pinout specimen), transcribed from DS20002230G
(bullet specs p.1; pinout page-verified:
1 RXD, 2 CS, 3 WAKE, 4 TXD, 5 VSS, 6 LBUS, 7 VBB, 8 VREN).
Pins ride the mclibs LIN transceiver shape.

- 厂商: Microchip
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: lin, transceiver, uart, automotive
- 附件: mcp2003.pdf, mcp2003.txt

## 使用

```text
use mcp2003.mcp2003    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack mcp2003          # 出 .mcl + .thin.mcl
mcc lib install --from mcp2003-0.1.0.mcl   # 装入 ~/.mcode/
```
