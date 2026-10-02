# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// Real 48-pin motor-control MCU (STM32F103C8T6, LQFP48 7x7), transcribed
// from the ST medium-density datasheet (DocID13587 Rev 17; Table 5 pin
// definitions pp.28-33 cross-checked pin by pin against the Figure 8
// LQFP48 pinout drawing p.26, 48/48 agree). Part number constructed per
// the ordering scheme (Table 63: C = 48 pins, 8 = 64KB flash, T = LQFP,
// 6 = -40 to 85C). Operating VDD 2.0-3.6V; Run-mode max 50.3mA at 72MHz.
// Pins ride the mclibs LQFP48 motor-control shape.

use mclibs.mcu/mcu48.mc

component STM32F103C8T6 : MCU.LQFP48
{
    partno = "STM32F103C8T6"
    package = PKG.LQFP48
}
