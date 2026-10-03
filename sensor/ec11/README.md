# ec11

Incremental rotary encoder — ALPS EC11 series, detail model **EC11E15244B2**
(11 mm metal shaft, vertical, flat 20 mm actuator, with push-on switch).

## Transcription source

ALPS "EC11 Series" 4-page detail sheet (`ec11.pdf`, © 1995-2008 ALPS Electric;
Pollin mirror `D240339D` — the alps.com canonical URL is bot-walled). All
faces page-verified: terminal end-view and internal circuit p.2, ratings
p.1, output wave and sliding-noise test circuit p.3, shaft variety p.4.

## Faces

- **Encoder element** A/B quadrature contacts + common C — adopts the mclibs
  `ENC.INC` shape, which in turn adopts the mcode ifs `ENC` interface
  (TRANSMITTER side). Pad enumeration: A,C,B → 1,2,3 (abstract convention,
  left-to-right end-view reading).
- **Push-on switch** D/E — passive normally-open contact, bare row, no
  interface adoption (ruling-19 census A1). Pads 4,5.

## Key ratings (DS p.1)

10 mA 5 VDC element rating; 30 detents / 15 pulses per revolution; torque
10±7 mN·m; switch 0.5 A 16 VDC, travel 1.5±0.5 mm, force 4±2 N; −30 °C to
+85 °C; 15 000 cycles rotational life (switch 20 000 ops min).

No index (Z) lane: the document names only terminals A, C, B, D, E and
"Output of A and B signals" — the EC11 is 2-phase A/B only.
