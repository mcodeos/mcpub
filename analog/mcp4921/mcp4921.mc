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

// Real single-channel 12-bit write-only SPI DAC (MCP4921, 8-pin PDIP/SOIC/
// MSOP), transcribed from DS22248A (p.1 package drawing + Table 3-1 p.17;
// pinout page-verified). Pins ride the mclibs SPI DAC shape.

use mclibs.analog/dac.mc

component DAC.MCP4921 : DAC.C1SPI
{
    partno = "MCP4921"
}
