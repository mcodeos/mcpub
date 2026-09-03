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

// =============================================================================
//  AMS1117 — 1A low-dropout linear regulator (LDO), SOT-223
//  Datasheet: Advanced Monolithic Systems AMS1117
//
//  Pins (SOT-223, fixed output version):
//    1   = GND      Ground
//    2   = Vout     Regulated output
//    3   = Vin      Unregulated input
//    TAB = Vout     SOT-223 heat pad — internally connected to Vout(2), NOT GND (common misconnection)
//
//  Key parameters:
//    Iout max 1A;  Dropout typ 1.1V / max 1.3V @ 1A
//    Vin max 15V (abs max 18V);  Line reg 0.2% max, Load reg 0.4% max
//    Output accuracy ±2%;  Fixed output options: 1.2/1.5/1.8/2.5/2.85/3.0/3.3/5.0V;  ADJ adjustable version also available
//    Typical application: Vin 4.7uF/16V decoupling, Vout 4.7uF/16V decoupling (see LDO_SUPPLY below)
// =============================================================================

component AMS1117(v_out::UV.VOLT = 3.3V)
{
    partno = "AMS1117"
    package = PKG.SOT_223
    voltage = v_out

    name = "AMS1117 Low-Dropout Regulator"
    description = "1A fixed-output LDO linear regulator (SOT-223)"

    spec = [
        output_voltage = v_out
        output_current = 1A
        input_voltage = 15V
        dropout_voltage = 1.1V
        output_accuracy = 2%
    ]

    pins = [
        ps 1 = GND, "Ground (fixed) / ADJ (adjustable)"
        ps 2 = Vout, "Regulated output"
        ps 3 = Vin, "Unregulated input"
        tab = TAB, "SOT-223 heat tab, tied to Vout (NOT GND)"
    ]

    func Regulate([vin, gnd]::DC(12V), [vout]::DC(v_out))
    {
        vin -> Vin
        gnd -> GND
        Vout -> vout
        return vout
    }
}

