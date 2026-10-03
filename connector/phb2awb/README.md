# phb2awb

Real 2-pole wire-to-board terminal (LHE PHB-2AWB, A2005-SR02), transcribed
from the two source documents beside this file (PHB.txt = series spec
sheet, PHB2.txt = series approval drawing). A terminal block, not an
electroacoustic part: the board's speaker drive reaches the speaker wire
through these two solder pads.

Series ratings (PHB.txt): 100V AC/DC rated voltage, 2A rated current,
contact resistance 20mOhm max, insulation resistance 1000MOhm min,
withstand 800V AC for one minute, ambient -25 to +85 degC, wire range
AWG#30-#22 (UL E217379). Construction (PHB2.txt): housing LCP beige,
wafer and solder pads brass tin-plated; pole count is per order
(PHB-2..18AWB); the 2P size ships without a polarizing key, so the two
poles carry no documented polarity.

The leaf stays a passive two-terminal: no direction words, no interface
adoption (ruling-19 census A1: passive pairing data is carried by the
net's other side), neutral pole names after the mclibs passive-leaf form.

- Vendor: LHE
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: connector, ph2.0, header, horizontal
- Attachments: PHB.pdf, PHB.txt, PHB2.pdf, PHB2.txt

## Usage

```text
use phb2awb.phb2awb    # use by the entry part name after installing the pack (variant surface: see pack.toml [variants])
```

```bash
mcc lib pack phb2awb          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
