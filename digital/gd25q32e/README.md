# gd25q32e

Real 32Mbit SPI NOR flash (GD25Q32ESIG, SOP8), extracted from the verified
hbl board (U192 flash batch). Pins ride the mclibs SPI NOR shape.

- 厂商: GigaDevice
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: spi-flash, nor-flash, 32mbit, spi, qspi
- 附件: gd25q32e.pdf, gd25q32e.txt

## 使用

```text
use gd25q32e.gd25q32e    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack gd25q32e          # 出 .mcl + .thin.mcl
mcc lib install --from gd25q32e-0.1.0.mcl   # 装入 ~/.mcode/
```
