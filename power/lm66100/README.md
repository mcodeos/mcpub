# lm66100

Real ideal-diode / load switch (LM66100, TI SLVSEZ8A), sampled from the
datasheet (U226 b3878). Pins are the verified device face: SC-70 (DCK,
6-pin) only — pin 1 VIN, 2 GND, 3 CE (active low), 4 N/C, 5 ST
(active-low open-drain status), 6 VOUT. There is no SOT-23 variant.

Family-shape debt (device-shape law: no force-binding): the pwrint board abstract
ORING.IDEAL is the 2:1 composite ORing face (two power inputs, six power
pins, SOT-23-6). The real part is a single channel with control/status
pins in SC-70, so it does not bind `:` to that abstract this batch. Open a
single-channel true-face mclibs base when a second consumer appears.

The VOUT row states the datasheet operating window as a range nominal
(nsi814x precedent): the part is a pass-through switch and guarantees no
single output voltage. A nominal-less psrc is blocked by the source
decode law; moving the nominal to the variant is applied-nominal ruling 2
(case A), another batch.

- Vendor: TI
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: ideal-diode, power-mux, protection, sc-70
- Attachments: lm66100.pdf, lm66100.txt

## Usage

```text
use lm66100.lm66100    # after installing the pack, use by the entry part name (see pack.toml [variants] for the variant face)
```

```bash
mcc lib pack lm66100          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
