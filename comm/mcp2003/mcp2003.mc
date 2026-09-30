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

// Real LIN J2602 transceiver (MCP2003, 8-pin PDIP/SOIC; Microchip marks the
// part Not Recommended for New Designs in favor of MCP2003B -- kept as the
// industry-standard LIN pinout specimen), transcribed from DS20002230G
// (p.1 package drawing; pinout page-verified:
// 1 RXD, 2 CS, 3 WAKE, 4 TXD, 5 VSS, 6 LBUS, 7 VBB, 8 VREN).
// Pins ride the mclibs LIN transceiver shape.

use mclibs.comm/lin.mc

component MCP2003 : UARTtoLIN
{
    partno = "MCP2003"
}
