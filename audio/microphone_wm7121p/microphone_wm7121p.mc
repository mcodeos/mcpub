# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// Real MEMS silicon microphone (analog), extracted from the verified hbl
// board (U192, C7 electroacoustic batch). Pins ride the mclibs abstract shape.

use mclibs.audio/microphone.mc

component MICROPHONE.WM7121P : MICROPHONE.MEMS
{
    partno = "WM7121P"
    package = PKG.MIC_WM7121P
    voltage = "3.3V"                // VCC fed from the quiet VMIC rail
}
