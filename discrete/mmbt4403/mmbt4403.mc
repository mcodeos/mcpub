// Copyright (c) 2026 MCode
//
// Licensed under the Apache License, Version 2.0.

// =============================================================================
//  MMBT4403 — PNP bipolar transistor, SOT-23
//  Symbol pinout: 1=B 2=E 3=C.
// =============================================================================
component PNP.MMBT4403
{
    partno = "MMBT4403"
    package = PKG.SOT_23

    pins = [
        io 1 = B
        io 2 = E
        io 3 = C
    ]
}
