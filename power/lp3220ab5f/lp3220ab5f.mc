# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// Real buck converter (LP3220AB5F, SOT23-5), extracted from the verified hbl
// board (U192 power batch). Pins ride the mclibs SOT23-5 buck shape; grade
// spec windows live here (outside the variant data lock).

use mclibs.power/dcdc.mc

component DCDC.LP3220AB5F : DCDC.SOT23_5
{
    partno = "LP3220AB5F"
    input_voltage = "2.5V~5.5V"  // Vin operating range per datasheet

    spec = [
        input_req = 2.5V ~ 5.5V  // input operating window
        output = 1.14V ~ 1.26V   // guaranteed output window incl. load reg
    ]

    layout = [
        left   = [4, 1]
        bottom = [2]
        right  = [5, 3]
    ]
}
