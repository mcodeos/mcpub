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

// Real buck converter (LP3220AB5F, SOT23-5), extracted from the verified hbl
// board (U192 power batch). Pins ride the mclibs SOT23-5 buck shape; grade
// spec windows live here (outside the variant data lock).

use mclibs.power/dcdc.mc

component DCDC.LP3220AB5F : DCDC.SOT23_5
{
    partno = "LP3220AB5F"
    input_voltage = "2.5V~5.5V"  // Vin operating range per datasheet

    spec = [
        input_req = 2.5V ~ 5.5V  // input operating window
        output = 1.14V ~ 1.26V   // guaranteed output window incl. load reg
    ]

    layout = [
        left   = [4, 1]
        bottom = [2]
        right  = [5, 3]
    ]
}
