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

// Real SPI-configured three-phase smart gate driver (DRV8323SRTAT, RTA: 40-pin
// WQFN with exposed thermal pad), transcribed from TI ZHCSG01C (Chinese
// datasheet, p.7 package drawing; pinout page-verified, Pin Functions table
// cross-checked against the figure pin-by-pin). The S variant keys pins 1-25
// and 31-40 identically to the DRV8304H; pins 26-29 carry the SPI face
// (SDO/SDI/SCLK/nSCS) instead of the resistor-set configuration. The H
// variant keeps MODE/IDRIVE/VDS/GAIN on 26-29 and rides GATEDRV.H6 instead.
// The thermal pad is unnumbered and must be grounded. VM range 6-60V.
// Pins ride the mclibs SPI-configured three-phase gate driver shape.

use mclibs.motor/gatedrv.mc

component DRV8323S : GATEDRV.H6S
{
    partno = "DRV8323SRTAT"
}
