// Copyright (c) 2026 MCode
//
// Licensed under the Apache License, Version 2.0.

// =============================================================================
//  TEA1995T — NXP GreenChip dual-channel synchronous rectifier controller, SO8
//  Datasheet: TEA1995T Rev3 (bundled)
// =============================================================================
component SR.TEA1995T
{
    partno = "TEA1995T"
    package = PKG.SOIC8

    pins = [
        psnk [2] = GND
        out 1 = GDA                     // channel A gate drive (T1 winding A, 16-17)
        io 3 = DSB                      // channel B drain sense (R31 <- Q8.DB)
        io 4 = SSB                      // channel B source sense (grounded)
        io 5 = SSA                      // channel A source sense (grounded)
        io 6 = DSA                      // channel A drain sense (R19 <- Q8.DA)
        in 7 = VCC                      // supply (VBUS domain, C20 decoupling)
        out 8 = GDB                     // channel B gate drive (T1 winding B, 11-12)
    ]
}
