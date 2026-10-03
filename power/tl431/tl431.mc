// Copyright (c) 2026 MCode
//
// Licensed under the Apache License, Version 2.0.

// =============================================================================
//  TL431 — adjustable shunt voltage reference, SOT-23
//  1=REF 2=ANODE 3=CATHODE.
// =============================================================================
component REF.TL431
{
    partno = "TL431"
    package = PKG.SOT_23

    pins = [
        in 1 = REF
        io 2 = ANODE
        io 3 = CATHODE
    ]
}
