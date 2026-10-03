// Copyright (c) 2026 MCode
//
// Licensed under the Apache License, Version 2.0.

// =============================================================================
//  CT1019 — optocoupler, SOP4
//  The original schematic drew two symbols sharing refdes U2; mapped here as
//  1=A 2=K 3=C 4=E.
// =============================================================================
component OPTO.CT1019
{
    partno = "CT1019"

    pins = [
        io 1 = A
        io 2 = K
        io 3 = C
        io 4 = E
    ]
}
