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

// Real 4-channel 12-bit SPI ADC (MCP3204, 14-pin PDIP/SOIC/TSSOP),
// transcribed from DS21298E (bullet specs p.1; SPI timing table p.16;
// pinout page-verified). Pins ride the mclibs SPI ADC shape.

use mclibs.analog/adc.mc

component ADC.MCP3204 : ADC.C4SPI
{
    partno = "MCP3204"
    package = PKG.SOIC14     // 14-pin PDIP / SOIC / TSSOP (DS21298E p.1);
                             // the SOIC-14 body is stated as the default

    spec = [
        vdd = 2.7V ~ 5.5V, "single-supply operating voltage"      // p.1 bullet
        resolution = 12, "bits of resolution"                     // p.1
        dnl = 1, "DNL error max, LSb (pm 1)"                      // p.1 bullet: +/- 1 LSB max DNL
        inl = 1, "INL error max, LSb, B grade (pm 1; C grade pm 2)"  // p.1 bullet
        fsample = 100ksps, "max sampling rate at VDD = 5V (50 ksps at 2.7V)"  // p.1 bullet
        fclk = 2MHz, "SPI clock max at VDD = 5V (1 MHz at 2.7V)"  // SPI timing: fCLK 2.0/1.0 MHz
        istandby = 2uA, "standby current, max (typ 500nA)"        // p.1 bullet
        iactive = 400uA, "active current, max at VDD = 5V (typ 320uA)"  // p.1 bullet
        temp = -40°C ~ +85°C, "operating temperature range"       // p.1 bullet: industrial
    ]
}
