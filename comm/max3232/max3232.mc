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

// Real two-channel RS232 line driver/receiver (MAX3232, 16-pin SOIC/SSOP/
// TSSOP/PDIP), transcribed from TI SLLS410O (p.3 Figure 5-1 package drawing;
// pinout page-verified: DOUT/DIN/RIN/ROUT spellings per the TI face,
// 1 C1+, 2 V+, 3 C1-, 4 C2+, 5 C2-, 6 V-, 15 GND, 16 VCC).
// Pins ride the mclibs RS232 transceiver shape.

use mclibs.comm/rs232.mc

component MAX3232 : UARTtoRS232
{
    partno = "MAX3232"
}
