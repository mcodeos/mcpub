# esp32h2

本包无头注释面；说明以 entry `.mc` 与附件 datasheet 为准。

- 厂商: Espressif
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: soc, ble, thread, zigbee, ieee802.15.4, riscv
- 附件: esp32h2.pdf, esp32h2.txt, esp32h2_paged.txt

## 使用

```text
use esp32h2.esp32h2    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack esp32h2          # 出 .mcl + .thin.mcl
mcc lib install --from esp32h2-0.1.0.mcl   # 装入 ~/.mcode/
```
