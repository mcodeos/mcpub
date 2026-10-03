# drv8833c

Real dual brushed-DC H-bridge driver (DRV8833CPWP, HTSSOP-16 with PowerPAD),
transcribed from TI SLVSCP9 (p.3 package drawing; pinout page-verified,
Pin Functions table cross-checked against the figure pin-by-pin).
Pin 11 is NC in the PWP; the unnumbered PowerPAD is grounded per the GND
row description. VM operating range 2.7-11.8V.
Pins ride the mclibs dual H-bridge shape.

- Vendor: TI
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: motor-driver, h-bridge, dual, pwm
- Attachments: drv8833c.pdf, drv8833c.txt

## Usage

```text
use drv8833c.drv8833c    # use by entry part name after installing (variant face in pack.toml [variants])
```

```bash
mcc lib pack drv8833c          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
