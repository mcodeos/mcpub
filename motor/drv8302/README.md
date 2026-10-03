# drv8302

Real three-phase gate driver with integrated buck regulator (DRV8302,
DCA: 56-pin HTSSOP with PowerPAD numbered 57 = GND), transcribed from TI
ZHCS138C (Chinese datasheet, p.3 package drawing; pinout page-verified,
Pin Functions table cross-checked against the figure pin-by-pin).
Two supply domains: PVDD1 (gate driver) and PVDD2 (buck). The exposed
PowerPAD carries pin number 57 and the name GND.
PVDD operating range 8-60V.
Pins ride the mclibs three-phase gate driver with buck shape.

- Vendor: TI
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: gate-driver, 3-phase, buck, current-sense, motor
- Attachments: drv8302.pdf, drv8302.txt

## Usage

```text
use drv8302.drv8302    # use by entry part name after installing (variant face in pack.toml [variants])
```

```bash
mcc lib pack drv8302          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
