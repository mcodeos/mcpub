// Copyright (c) 2026 MCode
//
// Licensed under the Apache License, Version 2.0.

// =============================================================================
//  USB-A receptacle (4P). Schematic pin labels "+/D+/D-/-" are mapped to the
//  standard TYPE-A pin numbers 1/3/2/4.
// =============================================================================
component CONN.USBA4
{
    partno = "USB-A-4P-QC"

    pins = [
        psrc 1 = VBUS                  // schematic "+"
        io 2 = DM                      // schematic "D-"
        io 3 = DP                      // schematic "D+"
        in 4 = GND                     // schematic "-" (returns via R70 10mOhm =
                                       //   QC current shunt)
    ]
}
