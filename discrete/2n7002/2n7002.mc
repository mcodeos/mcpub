// Copyright (c) 2026 MCode
//
// Licensed under the Apache License, Version 2.0.

// =============================================================================
//  2N7002 — small-signal NMOS, SOT-23
//  1=G 2=D 3=S.
// =============================================================================
component NMOS.2N7002
{
    partno = "2N7002"
    package = PKG.SOT_23

    pins = [
        io 1 = G
        io 2 = D
        io 3 = S
    ]
}
