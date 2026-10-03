# drv8889

Real automotive stepper driver (DRV8889QPWPRQ1, HTSSOP-24 with PowerPAD),
transcribed from TI ZHCSJO5 (Chinese datasheet, p.3 package drawing; pinout
page-verified, Pin Functions table cross-checked against the figure
pin-by-pin). The thermal pad carries no pin number and is grounded per the
PAD row. VM operating range 4.5-45V. The RGE (VQFN-24) variant keys
differently and is a separate face.
Pins ride the mclibs stepper driver shape.

- Vendor: TI
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: stepper-driver, microstepping, spi
- Attachments: drv8889.pdf, drv8889.txt

## Usage

```text
use drv8889.drv8889    # use by entry part name after installing (variant face in pack.toml [variants])
```

```bash
mcc lib pack drv8889          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
