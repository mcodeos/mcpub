# drv8701p

Real brushed-DC full-bridge gate driver (DRV8701P, RGE: 24-pin VQFN with
exposed pad), transcribed from TI ZHCSDO0A (Chinese datasheet, p.3 package
drawing; pinout page-verified, Pin Functions table cross-checked against
the figure pin-by-pin). The P variant uses IN1/IN2 PWM control; the E
variant (PH/EN) swaps pins 14/15 and is a different shape family. The
ground group is pins 5 / 16 plus the unnumbered exposed pad (PPAD).
VM operating range 5.9-45V.
Pins ride the mclibs brushed-DC full-bridge gate driver shape.

- Vendor: TI
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: gate-driver, h-bridge, spi, motor
- Attachments: drv8701.pdf, drv8701.txt

## Usage

```text
use drv8701p.drv8701p    # use by entry part name after installing (variant face in pack.toml [variants])
```

```bash
mcc lib pack drv8701p          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
