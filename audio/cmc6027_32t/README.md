# cmc6027_32t

Real electret capsule microphone, extracted from the verified hbl board
(U192, C7 electroacoustic batch). Pins ride the mclibs abstract shape.

- Vendor: CUI Devices
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: microphone, electret, analog, capsule
- Attachments: cmc6027-32t.pdf, cmc6027-32t.txt

## Usage

```text
use cmc6027_32t.cmc6027_32t    # use by the entry part name after installing the pack (variant surface: see pack.toml [variants])
```

```bash
mcc lib pack cmc6027_32t          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
