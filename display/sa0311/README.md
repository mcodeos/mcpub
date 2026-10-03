# sa0311

Kingbright **SA03-11EWA** — single-digit 7.62 mm (0.30") 7-segment LED
display, high-efficiency red (GaAsP/GaP), common anode, right-hand
decimal point, gray face / white segment.

## Faces

- Binds the mclibs `SEG7.CA` family shape. Pin map is not sequential
  (read off the internal-circuit figure p.1): a=1, f=2, e=7, d=8,
  DP2=9, c=10, g=11, b=13; the common-anode rail rides two pads
  (3 and 14); pin 6 exists and is N/C; pins 4, 5, 12 are molded off.
- Segments are passive LED junctions: one external series resistor per
  segment; the common anode is the supply-side power sink.

## Key ratings (page-verified)

- VF 1.9 V typ / 2.3 V max at IF = 10 mA; DC forward current 30 mA
  absolute max (peak 160 mA at 1/10 duty, 0.1 ms)
- Iv 3600 µcd min / 8100 µcd typ at 10 mA (CIE 127-2007 traceable)
- λ dominant 617 nm typ (peak 627 nm); VR 5 V (IR ≤ 10 µA)
- Operating -40 - +85 °C; 75 mW; ESD 8 kV HBM; wave-solder only

## Datasheet

`sa0311.pdf` — Kingbright spec DSAP8320 rev V.1A, 03/05/2020.
Text extraction in `sa0311.txt` (the pin map is a figure and does not
text-extract — read it off the PDF).
