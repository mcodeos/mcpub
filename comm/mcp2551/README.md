# mcp2551

Real high-speed CAN transceiver (MCP2551, 8-pin PDIP/SOIC),
transcribed from DS21667D (bullet specs p.1; DC characteristics p.8;
pinout page-verified: 1 TXD, 2 VSS, 3 VDD, 4 RXD, 5 VREF, 6 CANL,
7 CANH, 8 Rs). Pins ride the mclibs CAN transceiver shape.

- 厂商: Microchip
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: can, transceiver, 2.0b
- 附件: mcp2551.pdf, mcp2551.txt

## 使用

```text
use mcp2551.mcp2551    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack mcp2551          # 出 .mcl + .thin.mcl
mcc lib install --from mcp2551-0.1.0.mcl   # 装入 ~/.mcode/
```
