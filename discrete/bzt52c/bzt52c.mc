// Copyright (c) 2026 MCode
//
// Licensed under the Apache License, Version 2.0.

// =============================================================================
//  BZT52C — Zener diode family, SOD-323 (symbol: 2=K, 1/3 = common anode)
//  The breakdown voltage follows the order-code suffix (Z4/Z3/Z6 = 3V3,
//  Z5 = 12V, Z1/Z1A/Z1B = 6V2; see the instance rows on the source board).
// =============================================================================
component ZENER.BZT52C
{
    partno = "BZT52C"                  // BZT52C family (breakdown voltage follows
                                       //   the instance suffix: Z4/Z3/Z6=3V3,
                                       //   Z5=12V, Z1/Z1A/Z1B=6V2)

    pins = [
        io [1, 3] = A                  // common anode (symbol drawing: 1/3 at the
                                       //   same potential)
        io 2 = K
    ]
}
