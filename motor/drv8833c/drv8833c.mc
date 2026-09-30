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

// Real dual brushed-DC H-bridge driver (DRV8833CPWP, HTSSOP-16 with PowerPAD),
// transcribed from TI SLVSCP9 (p.3 package drawing; pinout page-verified,
// Pin Functions table cross-checked against the figure pin-by-pin).
// Pin 11 is NC in the PWP; the unnumbered PowerPAD is grounded per the GND
// row description. VM operating range 2.7-11.8V.
// Pins ride the mclibs dual H-bridge shape.

use mclibs.motor/hbridge.mc

component DRV8833C : HBRIDGE.DUAL
{
    partno = "DRV8833CPWP"
}
