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

// Real Mini USB B receptacle (HUM011D-5-S). The pin book adopts the mcode
// USB.MINIB interface (checklist 4.10): 1=VBUS, 2=D-, 3=D+ (@pair(d)), 4=ID,
// 5=GND; pads 6/7 are GND return; the two shield pads are exposed boundary
// electrodes (4.9). The pin book matches the mcode USB.SOCK_MINIB base —
// a library file cannot inherit an mcode component base (the `:` base only
// resolves in board scope), so the shapes agree by adoption, not derivation.

component USB.HUM011D_5_S
{
    partno = "HUM011D-5-S"
    package = PKG.USB_MINI
    voltage = "5V"                    // VBUS is a 5V power rail

    pins = [
        [1:5] = USB::USB.MINIB(Device)   // interface adoption: 1=VBUS, 2=D\-, 3=D\+, 4=ID, 5=GND
        [6,7] = GND                      // USB GND return pads
        8 = SHIELD3 @exposed(esd_contact)  // shield: exposed boundary electrode
        9 = SHIELD4 @exposed(esd_contact)  // shield: exposed boundary electrode
    ]

    layout = [
        right  = [4, 3, 2, 5, 1]
        bottom = [6:9]
    ]
}

// Usage Examples:
// component USB.HUM011D_5_S usbsock
// usbsock.USB.VBUS -> RES(0R) -> vin.V5V          // interface adoption pins are addressed by group name
// usbsock.SHIELD3 -> ESDGND                        // exposed shield pad to the protective island
