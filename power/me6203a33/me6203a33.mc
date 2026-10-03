// Copyright (c) 2026 MCode
//
// Licensed under the Apache License, Version 2.0.

// =============================================================================
//  ME6203A33M3G — SOT-89 LDO, 3.3V fixed
//  1=GND 2=VIN 3=VOUT, matching the schematic symbol and netlist.
// =============================================================================
component LDO.ME6203A33
{
    partno = "ME6203A33M3G"
    package = PKG.SOT_89

    pins = [
        in 2 = VIN
        io 1 = GND
        out 3 = VOUT
    ]
}
