// Copyright (c) 2026 MCode
//
// Licensed under the Apache License, Version 2.0.

// =============================================================================
//  INN650D02 — GaN HEMT, DFN 8x8
//  No DFN8x8 member exists in the PKG enum, so `package` is left unset rather
//  than forced to a wrong value.
// =============================================================================
component NMOS.INN650D02
{
    partno = "INN650D02"

    pins = [
        io 1 = G
        io 2 = D
        io 3 = S
    ]
}
