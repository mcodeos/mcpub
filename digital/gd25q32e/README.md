# gd25q32e

Real 32Mbit SPI NOR flash (GD25Q32ESIG, SOP8), extracted from the verified
hbl board (U192 flash batch). Pins ride the mclibs SPI NOR shape.

- Vendor: GigaDevice
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: spi-flash, nor-flash, 32mbit, spi, qspi
- Attachments: gd25q32e.pdf, gd25q32e.txt

## Usage

```text
use gd25q32e.gd25q32e    # use by the entry part name after installing the pack (variant surface: see pack.toml [variants])
```

```bash
mcc lib pack gd25q32e          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
