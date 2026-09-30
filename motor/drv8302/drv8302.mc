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

// Real three-phase gate driver with integrated buck regulator (DRV8302,
// DCA: 56-pin HTSSOP with PowerPAD numbered 57 = GND), transcribed from TI
// ZHCS138C (Chinese datasheet, p.3 package drawing; pinout page-verified,
// Pin Functions table cross-checked against the figure pin-by-pin).
// Two supply domains: PVDD1 (gate driver) and PVDD2 (buck). The exposed
// PowerPAD carries pin number 57 and the name GND.
// PVDD operating range 8-60V.
// Pins ride the mclibs three-phase gate driver with buck shape.

use mclibs.motor/gatedrv.mc

component DRV8302 : GATEDRV.H6B
{
    partno = "DRV8302DCAR"
}
