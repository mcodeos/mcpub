# hc32l110

HC32L110 — HDSC (Xiaohua) ultra-low-power Cortex-M0+ MCU, up to 32MHz
Datasheet: DS_HC32L110SeriesDatasheet Rev2.70 (same directory)

QFN20 (HC32L110C6UA/C4UA) pin shape, verified pin-by-pin against Rev2.70 §3:
1  = P00/RESETB   reset input, low active
2  = P01/XTHI     (also AIN7/VCIN7)
3  = P02/XTHO     (also AIN8)
4  = VSS          AVSS/DVSS
5  = VCAP         core LDO output decoupling — datasheet: 4.7uF to GND,
no external load
6  = VDD          AVCC/DVCC, 1.8V-5.5V
7  = P03/LVDIN1
8  = P15/XTLO     9 = P14/XTLI   10 = P23   11 = P24   12 = P25
13 = P26          14 = P27/SWDIO 15 = P31/SWCLK
16-20 = P32 P33 P34 P35 P36
NOTE: exposed thermal pad must be tied to DVSS on the PCB (datasheet §3
note); schematic symbols usually omit it.
CAUTION: TSSOP20/TSSOP16/CSP16 pin numbers differ entirely — re-verify
against §3 before reusing this shape for another package.

Other grades (U180 binding-base pattern): the QFN20 shape here is the
verified base; other packages get their own base when a project needs them.

- Vendor: HDSC
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: mcu, cortex-m0, low-power, hdsc
- Attachments: hc32l110.pdf, hc32l110.txt

## Usage

```text
use hc32l110.hc32l110    # use by the entry part name after installing the pack (variant surface: see pack.toml [variants])
```

```bash
mcc lib pack hc32l110          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
