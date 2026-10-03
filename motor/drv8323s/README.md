# drv8323s

Real SPI-configured three-phase smart gate driver (DRV8323SRTAT, RTA: 40-pin
WQFN with exposed thermal pad), transcribed from TI ZHCSG01C (Chinese
datasheet, p.7 package drawing; pinout page-verified, Pin Functions table
cross-checked against the figure pin-by-pin). The S variant keys pins 1-25
and 31-40 identically to the DRV8304H; pins 26-29 carry the SPI face
(SDO/SDI/SCLK/nSCS) instead of the resistor-set configuration. The H
variant keeps MODE/IDRIVE/VDS/GAIN on 26-29 and rides GATEDRV.H6 instead.
The thermal pad is unnumbered and must be grounded. VM range 6-60V.
Pins ride the mclibs SPI-configured three-phase gate driver shape.

- Vendor: TI
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: gate-driver, 3-phase, spi, current-sense, motor
- Attachments: drv8323s.pdf, drv8323s.txt

## Usage

```text
use drv8323s.drv8323s    # use by entry part name after installing (variant face in pack.toml [variants])
```

```bash
mcc lib pack drv8323s          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
