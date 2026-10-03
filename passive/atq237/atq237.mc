// Copyright (c) 2026 MCode
//
// Licensed under the Apache License, Version 2.0.

// =============================================================================
//  LLC transformer ATQ23.7 (700uH; primary 4->1, pin 3 = shield/core to AGND,
//  two secondary windings 16-17 and 11-12).
// =============================================================================
component TRAN.ATQ237
{
    partno = "ATQ3212002-700UH"

    pins = [
        io 4 = P_HI                     // primary (dotted end, to L3)
        io 2 = AUX                      // auxiliary winding (R32 -> D9 -> VCC1)
        io 1 = P_LO                     // primary (to the LLCCS resonant node)
        io 3 = SHLD                     // shield/core pin (AGND)
        io 17 = SA_D                    // secondary A (dotted end 16)
        psrc 16 = SA_CT                 // secondary A common (output N$26)
        io 11 = SB_D
        psrc 12 = SB_CT                 // secondary B common (output N$26)
    ]
}
