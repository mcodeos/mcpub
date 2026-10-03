# stm32f103c8t6

Real 48-pin motor-control MCU (STM32F103C8T6, LQFP48 7x7), transcribed
from the ST medium-density datasheet (DocID13587 Rev 17; Table 5 pin
definitions pp.28-33 cross-checked pin by pin against the Figure 8
LQFP48 pinout drawing p.26, 48/48 agree). Part number constructed per
the ordering scheme (Table 63: C = 48 pins, 8 = 64KB flash, T = LQFP,
6 = -40 to 85C). Operating VDD 2.0-3.6V; Run-mode max 50.3mA at 72MHz.
Pins ride the mclibs LQFP48 motor-control shape.

- Vendor: STMicroelectronics
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: mcu, cortex-m3, stm32f1, lqfp48, 72mhz
- Attachments: stm32f103c8t6.pdf, stm32f103c8t6.txt

## Usage

```text
use stm32f103c8t6.stm32f103c8t6    # use by the entry part name after installing the pack (variant surface: see pack.toml [variants])
```

```bash
mcc lib pack stm32f103c8t6          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
