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

// Real high-speed CAN transceiver (MCP2551, 8-pin PDIP/SOIC),
// transcribed from DS21667D (p.1 package drawing; pinout page-verified:
// 1 TXD, 2 VSS, 3 VDD, 4 RXD, 5 VREF, 6 CANL, 7 CANH, 8 Rs).
// Pins ride the mclibs CAN transceiver shape.

use mclibs.comm/can.mc

component MCP2551 : UARTtoCAN
{
    partno = "MCP2551"
}
