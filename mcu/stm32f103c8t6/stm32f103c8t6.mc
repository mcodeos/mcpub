# Copyright 2026 MCode
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
