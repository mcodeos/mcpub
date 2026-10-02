# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// Real electret capsule microphone, extracted from the verified hbl board
// (U192, C7 electroacoustic batch). Pins ride the mclibs abstract shape.

use mclibs.audio/microphone.mc

component MICROPHONE.SIP2_1_25MM_WA : MICROPHONE.ELECTRET
{
    partno = "CMC-6027-32T"       // CUI Devices / Same Sky electret capsule
    package = PKG.MIC_SIP2
}
