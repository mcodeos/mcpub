# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

#  BSS138N
#

component TRANS.NMOS.BSS138N
{
    partno = "BSS138N"      // model NO. BSS138N
    package = PKG.SOT_23_3     // package is SOT23-3

    pins = [
        1 = G, "Gate"
        2 = D, "Drain"
        3 = S, "Source"
    ]

    spec = [
        vgs = -20V ~ +20V, "Gate-Source Voltage"      // pin Gate to Source Voltage could be +/-20V
        vds = 0V ~ 60V, "Drain-Source Voltage"        // pin Drain to Source Voltage could be up to 60V
        id  = 0A ~ 0.23A, "Continuous Drain Current"
        rdson = [                                     //"Drain-Source on-resistance"
            case1 = 60mΩ, vgs:-10V, id:-4.1A          // rdson[1]=60mΩ, under condition vgs:-10V, id:-4.1A
            case2 = 87mΩ, vgs:-4.5V, id:-3A           // rdson[2]=87mΩ, under condition vgs:-10V, id:-4.1A
        ]
    ]
}
