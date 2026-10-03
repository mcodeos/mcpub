# amc1200

Real isolation amplifier (AMC1200, TI SBAS542D), sampled from the datasheet
(U226 b3878). Pins are the verified device face (DUB / DWV share the
pinout): pin 1 VDD1, 2 VINP, 3 VINN, 4 GND1, 5 GND2, 6 VOUTN, 7 VOUTP,
8 VDD2.

Family-shape debt (device-shape law: no force-binding): the pwrint board abstract
AMP.ISO_SOIC8 is the idealized board face (one supply pair on [1,4],
OUTP/OUTN member names, pin 5 unbound). The true face carries BOTH supply
pairs (high side 1/4, low side 8/5) and names the outputs VOUTP/VOUTN, so
the real part does not bind `:` to that abstract this batch. Open a
true-face mclibs base when a second consumer appears.

- Vendor: TI
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: isolation, isolated-amplifier, current-sense, motor
- Attachments: amc1200.pdf, amc1200.txt

## Usage

```text
use amc1200.amc1200    # use by the entry part name after installing the pack (variant surface: see pack.toml [variants])
```

```bash
mcc lib pack amc1200          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
