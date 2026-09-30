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

// Real dual full-bridge driver (L298N, Multiwatt15), transcribed from the
// ST L298 datasheet (p.2 PIN CONNECTIONS drawing; pinout page-verified,
// Pin Functions table p.3 cross-checked pin-by-pin). The metal tab is
// connected to pin 8 (GND). Vs abs max 46V (42V in characteristics),
// Vss 5V logic supply.
// Pins ride the mclibs classic dual full-bridge shape.

use mclibs.motor/hbridge.mc

component L298N : HBRIDGE.DUAL.E
{
    partno = "L298N"
}
