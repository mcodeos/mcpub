// Copyright (c) 2026 MCode
//
// Licensed under the Apache License, Version 2.0.

// =============================================================================
//  Common-mode choke TD1212-15mH (two windings 1-2 / 3-4). No matching member
//  exists in the PKG enum — board-level part.
// =============================================================================
component CMCH.TD1212
{
    partno = "TD1212-15mH"

    pins = [
        io 1 = W1A                      // mains N side
        io 2 = W1B                      // mains L side (via F1)
        io 3 = W2A                      // rectified MAINS side
        io 4 = W2B                      // rectified AC2 side (BD1.1)
    ]
}
