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

// Real MEMS silicon microphone (analog), extracted from the verified hbl
// board (U192, C7 electroacoustic batch). Pins ride the mclibs abstract shape.

use mclibs.audio/microphone.mc

component MICROPHONE.WM7121P : MICROPHONE.MEMS
{
    partno = "WM7121P"
    package = PKG.MIC_WM7121P
    voltage = "3.3V"                // VCC fed from the quiet VMIC rail
}
