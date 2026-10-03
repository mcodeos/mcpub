// Copyright (c) 2026 MCode
//
// Licensed under the Apache License, Version 2.0.

// =============================================================================
//  TYPE-C-20-V receptacle (16P, horizontal; A1/A12 = power return, 15-18 =
//  shell shield, A8/B8 = SBU unused on this board).
// =============================================================================
component CONN.TYPEC16P
{
    partno = "TYPE-C-20-V"

    pins = [
        psnk [[A4, A9], [A1, A12]] = [VBUS, GND_A]::DC(5V~20V)   // power pair
                                        //   (A4/A9 same-potential hot, A1/A12
                                        //   return)
        io [15, 16, 17, 18] = SHELL    // shell shield pins — no electrical face
                                        //   declared (board ties them to ground)
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
