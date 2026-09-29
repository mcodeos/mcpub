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

use $::mcode.ifs
use mclibs.isolation/digitalio.mc

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
            in [3:6] = IN[A,B,C,D]::GPIO(CONSUMER)      // 1 Mbps digital channels (logic side)
            out [14:11] = OUT[A,B,C,D]::GPIO(PROVIDER)  // 1 Mbps digital channels (logic side)
        ]

    func NSI8140(ps1, ps2)
    {
        ps1 -> DC1
        ps2 -> DC2
    }

    func Cap()
    {
        DC1 - CAP cap1(100nF, 10V) - DC2
        DC1 - CAP cap2(100nF, 10V) - DC2
    }

    // The strap helpers Pull/Pullup/Pulldown were removed (b4135): their
    // bodies compared against HIGH/LOW, which no library defines, and the
    // local names colliding with the RES pull family silently zeroed every
    // member call inside them (U331 face 1) while merely instantiating the
    // component poisoned .Pull resolution world-wide (U331 face 2, probe
    // bforms/nsi P1/P2/P3). Zero consumers repo-wide at removal time.
}
