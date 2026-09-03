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

# NSI814x 

use mc.ifs.power
use mc.std.isolation

component ISO.NSI8140(partno)
{
    desc = "Quad-Channel Digital Isolators"

    if (partno == "NSI8140N0")
    {    package = "SOIC16 NB"; spec.Isolation_Rating = 3.75kV; spec.Default_Ouput = low }
    else if (partno == "NSI8140N1")
    {    package = "SOIC16 NB"; spec.Isolation_Rating = 3.75kV; spec.Default_Ouput = high }
    else if (partno == "NSI8140W0")
    {    package = "SOIC16 WB"; spec.Isolation_Rating = 5kV; spec.Default_Ouput = low }
    else if (partno == "NSI8140W1")
    {    package = "SOIC16 WB"; spec.Isolation_Rating = 5kV; spec.Default_Ouput = high }
    else if (partno == "NSI8140W0Q")
    {    package = "SOIC16 WB"; spec.Isolation_Rating = 5kV; spec.Default_Ouput = low; spec.Automotive = "YES" }
    else if (partno == "NSI8140W1Q")
    {    package = "SOIC16 WB"; spec.Isolation_Rating = 5kV; spec.Default_Ouput = high; spec.Automotive = "YES" }

    pins = [
        in [1,[2,8]] = DC1[VDD1,GND1]::DC(3V~5V)
        nc 7 = NC
        in [16,[15,9]] = DC2[VDD2,GND2]::DC(3V~5V)
        in 10 = EN2
    ]

    if (partno in ["NSI8140N0", "NSI8140N1", "NSI8140W0", "NSI8140W1", "NSI8140W0Q", "NSI8140W1Q"])
        pins += [
            in [3:6] = IN[A,B,C,D]::DIO(1Mbps)
            out [14:11] = OUT[A,B,C,D]::DIO(1Mbps)
        ]

    func NSI8140(ps1, ps2)
    {
        ps1 -> DC1
        ps2 -> DC2
    }

    func Cap()
    {
        CAP(100nF, 10V) cap[1:2].Cap([DC1,DC2])
    }

    func pull(sin[1:4])
    {
        if sin[1]==HIGH RES(10kΩ).Pullup([IN.A, DC1.VDD1]) else if sin[1]==LOW RES(10kΩ).Pulldown([IN.A, DC1.GND1])
        if sin[2]==HIGH RES(10kΩ).Pullup([IN.B, DC1.VDD1]) else if sin[2]==LOW RES(10kΩ).Pulldown([IN.B, DC1.GND1])
        if sin[3]==HIGH RES(10kΩ).Pullup([IN.C, DC1.VDD1]) else if sin[3]==LOW RES(10kΩ).Pulldown([IN.C, DC1.GND1])
        if sin[4]==HIGH RES(10kΩ).Pullup([IN.D, DC1.VDD1]) else if sin[4]==LOW RES(10kΩ).Pulldown([IN.D, DC1.GND1])
    }
    func Pullup(vdd)
    {
        RES(10kΩ).Pullup([IN, vdd])
    }
    func Pulldown(gnd)
    {
        RES(10kΩ).Pulldown([IN, gnd])
    }
}
