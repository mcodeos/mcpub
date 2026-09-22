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

// Real electret capsule microphone, extracted from the verified hbl board
// (U192, C7 electroacoustic batch). Pins ride the mclibs abstract shape.

use mclibs.audio/microphone.mc

component MICROPHONE.SIP2_1_25MM_WA : MICROPHONE.ELECTRET
{
    partno = "SIP2-1.25MM-WA"     // electret mic capsule
    package = PKG.MIC_SIP2
}
