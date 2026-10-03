// Copyright (c) 2026 MCode
//
// Licensed under the Apache License, Version 2.0.

// =============================================================================
//  WRLSB80M — SMD bridge rectifier: 1/2 = AC, 3 = +, 4 = -.
// =============================================================================
component BRIDGE.WRLSB80M
{
    partno = "WRLSB80M"

    pins = [
        psrc [1, 2] = [AC1, AC2]        // AC inputs (1=LF1.4, 2=MAINS)
        io 3 = DCP                      // DC +
        in 4 = DCN                      // DC - (PGND)
    ]
}
