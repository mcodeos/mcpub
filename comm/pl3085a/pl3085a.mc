# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

# PL3085A cn.ireader-opto

use mclibs.comm/uart2rs485.mc

component PL3085A : UARTtoRS485
{
    name = "PL3085A"
    description = "UART/RS485 Tranciever"

    partno = "PL3085A"
    package = PKG.SOIC8

    spec.HBM = ±15kV
    spec.workingtemperature = -40°C ~ +85°C
}

module PL3085A_MDL(psnk pwr::DC(5V))
{
    in UART{TX, RX}
    out RS485{A, B}

    PL3085A PL3085(pwr)
    pwr.VCC - CAP(100nF,10V) - pwr.GND
    DIO.TVS(13.3V, 19.9V, 600W) tvs_a
    tvs_a.Protect(PL3085.RS485.A, pwr.GND) //SMBJ12CA (VBR min 13.3V, VC 19.9V @ IPP, 600W)
    DIO.TVS(13.3V, 19.9V, 600W) tvs_b
    tvs_b.Protect(PL3085.RS485.B, pwr.GND) //SMBJ12CA (VBR min 13.3V, VC 19.9V @ IPP, 600W)
    PL3085.IPDMatch().AutoTrans()

    UART -> PL3085{UART | RS485} -> RS485
}
