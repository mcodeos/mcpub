# nhd0216

Newhaven Display **NHD-0216K1Z-NSW-BBW-L** — 16x2 character LCD module,
STN blue negative, transmissive, side white LED backlight, 5V logic.

## Faces

- Binds the mclibs `LCD.CHR` 16-pad family shape (HD44780-compatible):
  supply pair VDD/VSS, contrast node V0, control lines RS/RW/E, the
  bi-directional three-state DB0..DB7 bus (lower byte unused in 4-bit
  operation), and the backlight pair LED+/LED- (pads 15/16, named A/K in
  the mechanical drawing).
- Controller **ST7066U** (HD44780-equivalent), 1/16 duty / 1/5 bias,
  4/8-bit bus selected by the Function-set DL bit; write-only boards
  strap R/W low.
- Contrast node sits at 3.7V typ when VDD = 5.0V — drive it with a
  potentiometer (or DAC) between VDD and VSS.

## Key ratings (page-verified)

- VDD 4.5 - 5.5 V; IDD 1.0 mA typ (0.5 - 2.0 mA) at 25°C
- Contrast node 3.6 - 3.8 V at VDD = 5.0 V
- Backlight VLED 4.9 - 5.1 V; ILED 32 mA typ (10 - 40 mA) via the
  on-board series resistor
- Operating -20 - +70 °C (storage -30 - +80 °C)
- Module 80.0 x 36.0 mm, 13.5 mm max; viewing area 66.0 x 16.0 mm;
  16-pin 2.54 mm single row

## Datasheet

`nhd0216.pdf` — Newhaven product specification rev 11, 07/01/2022
(NHD-0216K1Z-NSW-BBW-L; the document does not decode the suffix
letters, and the printed p.5 symbol column is shifted one row — the
values are the trustworthy part). Text extraction in `nhd0216.txt`.
