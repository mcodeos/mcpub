# tps3824

TI **TPS3824** — voltage supervisor with watchdog timer, detail grade
**TPS3824-33DBVR** (3.3 V rail), SOT-23-5.

## Faces

- Standalone concrete (family-shape debt, lm66100 law): the mclibs
  `SUP.WDG` shape is VCC/GND/WDI/RESET on pads 1-4; this part adds the
  active-high RESET on pad 3 with its own pad order, so it cannot inherit
  the shape (E5060). The family shape remains uninstantiated; this is the
  corpus' first concrete SOURCE-side part on the ifs `RST` face — both
  reset outputs (pin 1 active-low push-pull, pin 3 active-high) adopt
  `RST(SOURCE)`.
- WDI (pin 4): retrigger with a falling edge within 1.6 s; left floating
  it auto-disables the watchdog (internal pulses), optional 1 kΩ to GND
  defeats that.

## Key ratings (page-verified)

- VDD 1.1 V - 5.5 V; VIT- 2.93 V nom (-33 grade), hysteresis 30 mV
- Reset delay 200 ms; watchdog timeout 1.6 s typ
- IDD 15 µA typ; grade siblings -25/-30/-50 = threshold spec rows only

## Datasheet

`tps3824.pdf` - TI SLVS165O, April 1998 - Revised March 2025 (TPS382x
family: TPS3820/3823/3823A/3824/3825/3828).
Text extraction in `tps3824.txt`.
