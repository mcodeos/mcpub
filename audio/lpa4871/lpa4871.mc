# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// Real analog audio power amplifier, extracted from the verified hbl board
// (U192, C7 electroacoustic batch). Pins ride the mclibs abstract shape.

use mclibs.analog/amp.mc

component AMP.LPA4871 : AMP.AUDIO_BTL
{
    partno = "LPA4871"
    package = PKG.SOP8
}
