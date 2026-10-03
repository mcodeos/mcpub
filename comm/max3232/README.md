# max3232

Real two-channel RS232 line driver/receiver (MAX3232, 16-pin SOIC/SSOP/
TSSOP/PDIP), transcribed from TI SLLS410O (bullet specs p.1; recommended
operating conditions p.4; pinout page-verified: DOUT/DIN/RIN/ROUT spellings
per the TI face, 1 C1+, 2 V+, 3 C1-, 4 C2+, 5 C2-, 6 V-, 15 GND, 16 VCC).
Pins ride the mclibs RS232 transceiver shape.

- Vendor: Maxim Integrated
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: rs232, transceiver, uart, level-shift
- Attachments: max3232.pdf, max3232.txt

## Usage

```text
use max3232.max3232    # use by the entry part name after installing the pack (variant surface: see pack.toml [variants])
```

```bash
mcc lib pack max3232          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
