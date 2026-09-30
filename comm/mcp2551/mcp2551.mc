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
// transcribed from DS21667D (bullet specs p.1; DC characteristics p.8;
// pinout page-verified: 1 TXD, 2 VSS, 3 VDD, 4 RXD, 5 VREF, 6 CANL,
// 7 CANH, 8 Rs). Pins ride the mclibs CAN transceiver shape.

use mclibs.comm/can.mc

component MCP2551 : UARTtoCAN
{
    partno = "MCP2551"
    package = PKG.SOIC8      // 8-pin PDIP / SOIC share one pinout (p.1)

    spec = [
        vdd = 4.5V ~ 5.5V, "operating supply voltage, both grades"        // p.8 DC: VDD = 4.5V to 5.5V
        rate = 1Mbps, "max bus speed"                                     // p.1 bullet
        nodes = 112, "max nodes on the bus"                               // p.1 bullet
        istandby = 365uA, "standby current, max, I grade (E grade 465uA)" // p.8 DC: standby, note 2
        temp = -40°C ~ +85°C, "industrial grade (E: -40°C ~ +125°C)"      // p.1 bullet
    ]
}
