# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// Real incremental rotary encoder (ALPS EC11 series, detail model
// EC11E15244B2: 11mm metal shaft, vertical, flat 20mm actuator),
// transcribed from the ALPS "EC11 Series" 4-page detail sheet (ec11.pdf in
// this directory; copyright 1995-2008 ALPS ELECTRIC; Pollin mirror
// D240339D -- the alps.com canonical PDF URL is bot-walled).
// Page-verified faces: terminal end-view + internal circuit p.2 (bottom
// row A C B, top row D E; D-E drawn as a single normally-open contact);
// ratings p.1 (10mA 5VDC; 30 detents / 15 pulses; push-on switch SPST);
// output wave + sliding-noise test circuit p.3 (A and B each through R to
// +5V, C grounded; chatter 3ms max / bounce 2ms max at R=5k); shaft
// variety p.4 (knurled / flat / slotted, ø6 shaft).
// Terminal letters are the datasheet's own; numeric pads follow the
// abstract's left-to-right enumeration (A,C,B -> 1,2,3; switch D,E -> 4,5).
// The switch pair is a passive normally-open contact: no direction words,
// no interface adoption (ruling-19 census A1, BUZZER.PIEZO form).

use mclibs.sensor/encoder.mc

component EC11E15244B2 : ENC.INC.SW
{
    partno = "EC11E15244B2"
    package = PKG.ENC_RAD5     // vertical through-hole, 5 radial ø1 leads, 11.7 x 9.2mm body (DS p.2 mounting drawing)

    spec = [
        rating = 10mA@5VDC, "encoder element contact rating, resistive load (max operating current)"  // p.1
        detents = 30, "detents per revolution; 15 A/B pulses per revolution (B lags A, CW)"            // p.1 / p.3
        torque = 3mN*m ~ 17mN*m, "rotational torque 10±7 mN·m"                                          // p.1
        switch_rating = 0.5A@16VDC, "push-on switch contact (min usable rating 1mA 16VDC)"              // p.1
        temp = -30°C ~ +85°C, "operating temperature range"                                             // p.1
        life = 15000, "rotational life cycles; push switch 20000 operations min"                        // p.1
    ]
}
