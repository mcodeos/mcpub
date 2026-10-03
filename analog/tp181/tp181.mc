// Copyright (c) 2026 MCode
//
// Licensed under the Apache License, Version 2.0.

// =============================================================================
//  TP181 — 3PEAK zero-drift bidirectional current-sense amplifier, SC70-6
//  (gain 50/100/200 depending on grade)
//  Datasheet: TP181 (bundled)
//
//  The datasheet pin names V+/IN+/IN- contain characters that are illegal in
//  identifiers, so they are carried as VCC/INP/INN (datasheet names kept in
//  the row comments).
// =============================================================================
component AMP.TP181
{
    partno = "TP181"
    package = PKG.SC_88A              // SC-70-6 (SOT-363)

    pins = [
        psnk [[3], [2]] = [VCC, GND]::DC(3.3V)
        in 1 = REF                    // reference pin (grounded on this board)
        in 4 = INP                    // datasheet IN+
        in 5 = INN                    // datasheet IN-
        out 6 = OUT
    ]
}
