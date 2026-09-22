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

// Real 32Mbit SPI NOR flash (GD25Q32ESIG, SOP8), extracted from the verified
// hbl board (U192 flash batch). Pins ride the mclibs SPI NOR shape.

use mclibs.digital/flash.mc

component FLASH.GD25Q32E : FLASH.SPI_NOR
{
    partno = "GD25Q32ESIG"
}
