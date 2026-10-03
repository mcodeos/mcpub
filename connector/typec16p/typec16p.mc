// Copyright (c) 2026 MCode
//
// Licensed under the Apache License, Version 2.0.

// =============================================================================
//  TYPE-C-20-V receptacle (16P, horizontal; A1/A12 + 15-18 = shell ground,
//  A8/B8 = SBU unused on this board).
// =============================================================================
component CONN.TYPEC16P
{
    partno = "TYPE-C-20-V"

    pins = [
        psnk [[A1, A12], [15, 16, 17, 18]] = [GND_A, SHELL]::DC(0V)
        psrc [A4, A9] = VBUS           // power pins (two pins, same potential)
        io A5 = CC1
        io B5 = CC2
        io A6 = DP1                    // shorted to B6 on the board (N$4)
        io B6 = DP2
        io A7 = DN1                    // shorted to B7 on the board (N$7)
        io B7 = DN2
        io A8 = SBU1                   // left floating
        io B8 = SBU2                   // left floating
    ]
}
