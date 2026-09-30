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

// Real isolation amplifier (AMC1200, TI SBAS542D), sampled from the datasheet
// (U226 b3878). Pins are the verified device face (DUB / DWV share the
// pinout): pin 1 VDD1, 2 VINP, 3 VINN, 4 GND1, 5 GND2, 6 VOUTN, 7 VOUTP,
// 8 VDD2.
//
// Family-shape debt (device-shape law: no force-binding): the pwrint board abstract
// AMP.ISO_SOIC8 is the idealized board face (one supply pair on [1,4],
// OUTP/OUTN member names, pin 5 unbound). The true face carries BOTH supply
// pairs (high side 1/4, low side 8/5) and names the outputs VOUTP/VOUTN, so
// the real part does not bind `:` to that abstract this batch. Open a
// true-face mclibs base when a second consumer appears.

use $::mcode.ifs

component AMP.AMC1200
{
    partno = "AMC1200"
    package = PKG.SOIC8    // TI DUB (gullwing SOP-8) / DWV (wide-body SOIC-8), same pinout

    spec = [
        vdd1_req = 4.5V ~ 5.5V      // high-side supply operating window
        vdd2_req = 2.7V ~ 5.5V      // low-side supply operating window
        input_range = -250mV ~ 250mV  // ensured linear differential input (gain 8)
    ]

    pins = [
        psnk [1,4] = [VDD1, GND1]::DC()     // high-side (input circuit) supply sink
        io [2,3]  = [VINP, VINN] @pair(inp)   // differential analog input (high side)
        psnk [8,5] = [VDD2, GND2]::DC()     // low-side (output circuit) supply sink
        io [7,6]  = [VOUTP, VOUTN] @pair(outp)  // differential analog output (low side)
    ]
}
