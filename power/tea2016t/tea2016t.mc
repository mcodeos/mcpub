// Copyright (c) 2026 MCode
//
// Licensed under the Apache License, Version 2.0.

// =============================================================================
//  TEA2016AAT — NXP digital configurable LLC + PFC combo controller, SO16
//  Datasheet: TEA2016AAT Rev1.3 (bundled)
//  Pin names follow the datasheet.
// =============================================================================
component LLC.TEA2016T
{
    partno = "TEA2016AAT"
    package = PKG.SOIC16

    pins = [
        in 1 = SNSMAINS                 // mains sense (high-impedance divider + clamp)
        in 2 = SNSBOOST                 // PFC bus-voltage feedback (HV divider)
        in 3 = SNSCURPFC                // PFC current sense (R9 2.7R)
        out 5 = GATEPFC                 // PFC gate drive
        out 6 = GATELS                  // LLC low-side gate drive
        io 7 = HVS1                     // high-voltage spacer pin (left floating here)
        psrc 8 = DRAINPFC               // PFC drain (Q2 + D1)
        out 9 = GATEHS                  // LLC high-side gate drive
        in 10 = SUPHS                   // high-side driver floating supply (D4 bootstrap + C5)
        io 11 = HB                      // half-bridge midpoint (Q3/Q6 leg)
        io 12 = HVS2                    // high-voltage spacer pin (left floating here)
        psnk [13, 4] = [SUPIC, GND]::DC(12V)   // supply pair: 13 = SUPIC (VCC1
                                        //   domain), 4 = GND return
        in 14 = SNSCAP                  // resonant-capacitor sense
        in 15 = SNSCURLLC               // LLC current sense (resonant-cap divider)
        in 16 = SNSFB                   // optocoupler feedback input
    ]
}
