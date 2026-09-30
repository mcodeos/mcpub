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

// Real 3.3V LDO (SGM2019-3.3YN5G/TR, SOT23-5), extracted from the verified
// hbl board (U192 power batch). Pins ride the mclibs SOT23-5 LDO shape;
// grade spec windows live here (outside the variant data lock).

use mclibs.power/ldo.mc

component LDO.SGM2019_33YN5G_TR : LDO.SOT23_5
{
    partno = "SGM2019-3.3YN5G/TR"

    spec = [
        input_req = 3.6V ~ 5.5V   // input operating window (pre-condition)
        output = 3.234V ~ 3.366V  // guaranteed output window incl. load reg
    ]

    layout = [
        left   = [1, 3]
        bottom = [2]
        right  = [4, 5]
    ]
}
