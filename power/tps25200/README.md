# tps25200

TI **TPS25200** — 5V eFuse with precision adjustable current limit and
overvoltage clamp, WSON-6 (DRV) 2x2 mm.

## Faces

- Binds the mclibs `EFUSE` abstract (adjustable-limit eFuse form):
  input pair IN/GND (pins 6/5), protected output pair OUT/GND sharing the
  same ground pad (pins 1/5), resistor-programmed current limit (ILIM
  pin 2, R_ILIM 33 kΩ ~ 1100 kΩ), active-high EN (pin 4, must not float),
  active-low open-drain FAULT (pin 3, pull up to the logic rail).
- PowerPAD is internally connected to GND; solder it to the ground plane.

## Key ratings (page-verified)

- VIN 2.5 V - 6.5 V (withstands 20 V transient); I_OUT max 2.6 A
- Current limit programmable 85 mA - 2.9 A (R_ILIM 33 kΩ -> 2952 mA typ)
- Fixed overvoltage clamp 5.4 V typ (5.25 - 5.55 V); OVLO shutoff 7.6 V typ
- rDS(on) 60 mΩ typ; FAULT deglitch 8 ms typ (overcurrent only)
- UL 2367 recognized

## Datasheet

`tps25200.pdf` - TI SLVSCJ0F, March 2014 - Revised July 2025.
Text extraction in `tps25200.txt`.
