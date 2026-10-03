# l298n

Real dual full-bridge driver (L298N, Multiwatt15), transcribed from the
ST L298 datasheet (p.2 PIN CONNECTIONS drawing; pinout page-verified,
Pin Functions table p.3 cross-checked pin-by-pin). The metal tab is
connected to pin 8 (GND). Vs abs max 46V (42V in characteristics),
Vss 5V logic supply.
Pins ride the mclibs classic dual full-bridge shape.

- Vendor: STMicroelectronics
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: motor-driver, h-bridge, dual, multiwatt
- Attachments: l298.pdf, l298.txt

## Usage

```text
use l298n.l298n    # use by entry part name after installing (variant face in pack.toml [variants])
```

```bash
mcc lib pack l298n          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
