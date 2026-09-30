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

// Real brushed-DC full-bridge gate driver (DRV8701P, RGE: 24-pin VQFN with
// exposed pad), transcribed from TI ZHCSDO0A (Chinese datasheet, p.3 package
// drawing; pinout page-verified, Pin Functions table cross-checked against
// the figure pin-by-pin). The P variant uses IN1/IN2 PWM control; the E
// variant (PH/EN) swaps pins 14/15 and is a different shape family. The
// ground group is pins 5 / 16 plus the unnumbered exposed pad (PPAD).
// VM operating range 5.9-45V.
// Pins ride the mclibs brushed-DC full-bridge gate driver shape.

use mclibs.motor/gatedrv.mc

component DRV8701P : GATEDRV.H1
{
    partno = "DRV8701PRGER"
}
