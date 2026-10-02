# us513_20_f

Real MCU (Unisound US513U61 voice SoC, QFN20; board marking US513_20_F),
extracted verbatim from the verified hbl
board (U192 mcu batch). Ruling U192-3: the MCU stays a standalone real
part for now - no abstract base until an industry-naming abstract cluster
is summarized later (mux branch pins are the part's private face).

- 厂商: Unisound
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: mcu, ai, voice, soc

## 使用

```text
use us513_20_f.us513_20_f    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack us513_20_f          # 出 .mcl + .thin.mcl
mcc lib install --from us513_20_f-0.1.0.mcl   # 装入 ~/.mcode/
```
