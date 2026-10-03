// Copyright (c) 2026 MCode
//
// Licensed under the Apache License, Version 2.0.

// =============================================================================
//  10D471 metal-oxide varistor (across L-N on the source board).
//  Pack name follows the part number, lowercased; digit-leading `use` segments
//  are accepted by the mcode parser.
// =============================================================================
component VARISTOR.MOV
{
    partno = "10D471"

    pins = [
        io 1 = 1
        io 2 = 2
    ]
}
