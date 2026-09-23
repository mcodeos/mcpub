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

// Real ideal-diode / load switch (LM66100, TI SLVSEZ8A), sampled from the
// datasheet (U226 b3878). Pins are the verified device face: SC-70 (DCK,
// 6-pin) only — pin 1 VIN, 2 GND, 3 CE (active low), 4 N/C, 5 ST
// (active-low open-drain status), 6 VOUT. There is no SOT-23 variant.
//
// Family-shape debt (device-shape law: no force-binding): the pwrint board abstract
// ORING.IDEAL is the 2:1 composite ORing face (two power inputs, six power
// pins, SOT-23-6). The real part is a single channel with control/status
// pins in SC-70, so it does not bind `:` to that abstract this batch. Open a
// single-channel true-face mclibs base when a second consumer appears.
//
// The VOUT row states the datasheet operating window as a range nominal
// (nsi814x precedent): the part is a pass-through switch and guarantees no
// single output voltage. A nominal-less psrc is blocked by the source
// decode law; moving the nominal to the variant is applied-nominal ruling 2
// (案 A), another batch.

use $::mcode.ifs

component ORING.LM66100
{
    partno = "LM66100"
    package = PKG.SC_70_6    // TI DCK (SC-70, 6-pin) — only package offered

    spec = [
        vin_req = 1.5V ~ 5.5V      // input operating window
        switch_current = 1.5A      // continuous switch current
        ron_typ = 79mΩ             // on-resistance (typ)
    ]

    pins = [
        psnk [1,2] = [VIN, GND]::DC()              // input sink (window in spec)
        psrc [6,2] = [VOUT, GND]::DC(1V ~ 5.5V)    // pass-through output (datasheet VOUT window)
        in 3 = CE                                  // chip enable, active low (may tie to VOUT; do not float)
        out 5 = ST                                 // status output, active-low open-drain
        nc 4 = NC
    ]
}
