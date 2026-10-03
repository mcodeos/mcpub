# iso7721

TI ISO7721 dual-channel digital isolator, detail model **ISO7721D**
(SOIC-8 D package, reinforced insulation grade, outputs default HIGH).

## Faces

- Binds the mclibs abstract `ISO.DIG2.REVA` (dual-channel digital
  isolator, channel A reversed): channel B forward (INB pin 3 side 1 ->
  OUTB pin 6 side 2), channel A reversed (INA pin 7 side 2 -> OUTA pin 2
  side 1). Separate per-side supply pairs (VCC1/GND1 pins 1/4,
  VCC2/GND2 pins 8/5), no enable pin.
- Channel legs carry the per-side GPIO views (CONSUMER on the receiving
  side, PROVIDER on the driving side). The ifs `ISOLATION` face is the
  quad barrier-body shape (IN[A..D]/OUT[A..D] + EN2) and is not adopted
  by dual parts.

## Key ratings (D-8 package, page-verified)

- 100 Mbps max data rate; 11 ns typ propagation delay; CMTI 100 kV/us typ
- VCC1/VCC2 2.25 V - 5.5 V, independently settable (5V/3V3/3V3/2V5 mixes fine)
- UL 1577 withstand 3000 VRMS (D-8); VIORM 450 VRMS working; surge 10 kVPK
- Creepage/clearance 4 mm, DTI 17 um; outputs default HIGH when the input
  side is unpowered (F-suffix siblings default LOW, same footprint)

## Datasheet

`iso7721.pdf` - TI SLLSEP3G, November 2016 - Revised May 2024
(ISO7720/ISO7721 dual-channel family). Text extraction in `iso7721.txt`.
