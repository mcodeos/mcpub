# esp32h2

This pack has no header-comment face; the entry `.mc` and the attached
datasheet are authoritative.

- Vendor: Espressif
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: soc, ble, thread, zigbee, ieee802.15.4, riscv
- Attachments: esp32h2.pdf, esp32h2.txt, esp32h2_paged.txt

## Usage

```text
use esp32h2.esp32h2    # after installing the pack, use by the entry part name (see pack.toml [variants] for the variant face)
```

```bash
mcc lib pack esp32h2          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
