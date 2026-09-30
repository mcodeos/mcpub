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

// Real three-phase smart gate driver (DRV8304H, RHA: 40-pin VQFN with exposed
// thermal pad), transcribed from TI ZHCSI91B (Chinese datasheet, p.3 package
// drawing; pinout page-verified, Pin Functions table cross-checked against
// the figure pin-by-pin). The H variant is hardware-controlled: pins 26-29
// carry MODE/IDRIVE/VDS/GAIN resistor-set configuration; the S variant swaps
// them for the SPI face (nSCS/SCLK/SDI/SDO) and is a different shape family.
// The exposed thermal pad is unlabeled in the figure (no net name).
// Pins ride the mclibs three-phase gate driver shape.

use mclibs.motor/gatedrv.mc

component DRV8304 : GATEDRV.H6
{
    partno = "DRV8304H"
}
