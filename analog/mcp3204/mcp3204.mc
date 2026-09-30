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
// transcribed from DS21298E (p.1 package drawing; pinout page-verified).
// Pins ride the mclibs SPI ADC shape.

use mclibs.analog/adc.mc

component ADC.MCP3204 : ADC.C4SPI
{
    partno = "MCP3204"
}
