# us513u6

Real MCU (Unisound US513U61 voice SoC, QFN20; board marking US513_20_F (renamed US513U6 2026-10-03)),
extracted verbatim from the verified hbl
board (U192 mcu batch). Ruling U192-3: the MCU stays a standalone real
part for now - no abstract base until an industry-naming abstract cluster
is summarized later (mux branch pins are the part's private face).

- Vendor: Unisound
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: mcu, ai, voice, soc

## Usage

```text
use us513u6.us513u6    # use by entry part name after installing (variant face in pack.toml [variants])
```

```bash
mcc lib pack us513u6          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
