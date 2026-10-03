# a4950

Real full-bridge DMOS PWM motor driver (A4950ELJTR-T, 8-pin SOICN with
exposed thermal pad), transcribed from Allegro A4950-DS rev.2 (p.2 terminal
list table + pin-out diagram, page-verified pin-by-pin). The exposed PAD
carries no net name in the terminal list ("exposed pad for enhanced thermal
dissipation"); the application note permits tying it to the star ground.
VBB operating range 8-40V, peak output current 3.5A.
Pins ride the mclibs single full-bridge shape.

- Vendor: Allegro
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: motor-driver, h-bridge, dmos, pwm
- Attachments: a4950.pdf, a4950.txt

## Usage

```text
use a4950.a4950    # use by entry part name after installing (variant face in pack.toml [variants])
```

```bash
mcc lib pack a4950          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
