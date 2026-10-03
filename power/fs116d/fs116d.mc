// Copyright (c) 2026 MCode
//
// Licensed under the Apache License, Version 2.0.

// =============================================================================
//  FS116D — FastSOC multi-protocol Type-A quick-charge controller, SSOP10
//  Datasheet: FS116D V1.1 202410 (bundled)
// =============================================================================
component PDQC.FS116D
{
    partno = "FS116D"

    pins = [
        out 1 = GATE                    // external PMOS (Q15) gate drive
        in 2 = VIN                      // QCIS1N domain via R107 750R + C73 + Z6 clamp
        io 3 = FUNC                     // QCPER plug-in indication (R104 pull-up to V3V3, R105 NC)
        io 4 = FB                       // regulation feedback (merged into the U8 FB node)
        io 5 = PLUGIN                   // floating on the schematic (no LED fitted) — legal
        psnk [6] = GND
        in 7 = CSN                      // sense - (after the R70 10mOhm shunt, VSS domain here)
        io 8 = CSP                      // sense + (USB1.- via R106 300R + C90)
        io 9 = DP
        io 10 = DM
    ]
}
