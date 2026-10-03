// Copyright (c) 2026 MCode
//
// Licensed under the Apache License, Version 2.0.

// =============================================================================
//  JMUP jumper (0.6mm pitch, 2 pins). On the source board: J1 in series with
//  the LLC output to VBUS; J2's both pins tied to VSS.
// =============================================================================
component CONN.JMUP2
{
    partno = "JMUP-0.6mm"

    pins = [
        io 1 = 1
        io 2 = 2
    ]
}
