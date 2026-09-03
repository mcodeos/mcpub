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

# PL3085A cn.ireader-opto

use ./uart2rs485.mc

component PL3085A : UARTtoRS485
{
    name = "PL3085A"
    desc = "UART/RS485 Tranciever"

    partno = "PL3085A"
    package = PKG.SOIC8

    spec.HBM = ±15kV
    spec.workingtemperature = -40°C ~ +85°C
}

module PL3085A_MDL(pwr::DC(5V))
{
    in UART{TX, RX}
    out RS485{A, B}

    PL3085A PL3085(pwr)
    CAP(100nF,10V).Cap(PL3085{VCC, GND})
    DIO.TVS(13.5~15V, 14V).Protect([PL3085.RS485.A, pwr.GND]) //SMBJ12CA
    DIO.TVS(13.5~15V, 14V).Protect([PL3085.RS485.B, pwr.GND]) //SMBJ12CA
    PL3085.IPDMatch().AutoTrans()

    UART -> PL3085{UART | RS485} -> RS485
}
