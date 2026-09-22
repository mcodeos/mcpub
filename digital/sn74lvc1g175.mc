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

use mc.ttl

component TTL.D.SN74LVC1G175(partno)
{
    vender = "TI"
    desc = "Single D-Type Flip-Flop With Asynchronous Clear"

    if (partno == "SN74LVC1G175DBV") package = "SOT23-6"
    else if (partno == "SN74LVC1G175DCK") package = "SC70-6"
    else if (partno == "SN74LVC1G175DRY") package = "SON-6"
    else if (partno == "SN74LVC1G175YZP") package = "DSBGA-6"

    standard_signal_level = volt: [low: 0V ~ 0.7V, high:0.7V ~ 5.5V]

    pins = [
        in [5,2] = [VCC, GND]::DC(1.65V ~ 5.5V)

        in 1 = CLK, standard_signal_level
        in 3 = D,   standard_signal_level
        out 4 = Q,  standard_signal_level
        in 6 = _CLR, standard_signal_level
    ]

    func SN74LVC1G175(pwr)
    {
        pwr -> DC[VCC, GND]
    }

    func Cap()
    {
        CAP(100nF,10V).Cap([VCC, GND])
    }

    SN74LVC1G175.desc.features = ["Availabel in the Texas Instruments NanoFreeTM Package",
                "Supports 5-V VCC Operation",
                "Inputs Accept Voltages to 5.5V",
                "Supports Down Translation to VCC",
                "Maxtpd of 4.3ns at 3.3V",
                "Low Power Consumption, 10-μA Max ICC",
                "±24-mA Output Drive at 3.3V",
                "Ioff Supports Live Insertion, Partial-Power-Down Mode, and Back-Drive Protection",
                "Latch-Up Performance Exceeds 100 mA Per JESD 78, Class II"
                //{"ESD Protection Exceeds JESD 22", {
                // "2000-V Human-Body Model (A114-A)",
                // "200-V Machine Model (A115-A)",
                // "1000-V Charged-Device Model (C101)"}}
                ]

    SN74LVC1G175.desc.applications = ["TV/Set Top Box/Audio", 
                        "EPOS (Electronic Point-of-Sale)",
                        "Motor Drives",
                        "PC/Notebook",
                        "Servers",
                        "Factory Automation and Control",
                        "Tablets",
                        "Medical Healthcare and Fitness",
                        "Smart Grid",
                        "Telecom Infrastructure",
                        "Enterprise Switching",
                        "Projectors",
                        "Storage"
                    ]

    SN74LVC1G175.desc.overall = "This single D-type flip-flop is designed for 1.65-V to 5.5-V VCC operation.
                The SN74LVC1G175 device has an asynchronous clear (CLR) input. When CLR is high, 
                data from the input pin (D) is transferred to the output pin (Q) on the clock\"s (CLK) 
                rising edge. When CLR is low, Q is forced into the low state, regardless of the clock 
                edge or data on D.
                NanoFreeTM package technology is a major breakthrough in IC packaging concepts, using 
                the die as the package.
                This device is fully specified for partial-power-down applications using Ioff. The Ioff 
                circuitry disables the outputs, preventing damaging current backflow through the device 
                when it is powered down."

}

