# max3232

Real two-channel RS232 line driver/receiver (MAX3232, 16-pin SOIC/SSOP/
TSSOP/PDIP), transcribed from TI SLLS410O (bullet specs p.1; recommended
operating conditions p.4; pinout page-verified: DOUT/DIN/RIN/ROUT spellings
per the TI face, 1 C1+, 2 V+, 3 C1-, 4 C2+, 5 C2-, 6 V-, 15 GND, 16 VCC).
Pins ride the mclibs RS232 transceiver shape.

- 厂商: Maxim Integrated
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: rs232, transceiver, uart, level-shift
- 附件: max3232.pdf, max3232.txt

## 使用

```text
use max3232.max3232    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack max3232          # 出 .mcl + .thin.mcl
mcc lib install --from max3232-0.1.0.mcl   # 装入 ~/.mcode/
```
