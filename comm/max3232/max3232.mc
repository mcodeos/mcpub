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

// Real two-channel RS232 line driver/receiver (MAX3232, 16-pin SOIC/SSOP/
// TSSOP/PDIP), transcribed from TI SLLS410O (bullet specs p.1; recommended
// operating conditions p.4; pinout page-verified: DOUT/DIN/RIN/ROUT spellings
// per the TI face, 1 C1+, 2 V+, 3 C1-, 4 C2+, 5 C2-, 6 V-, 15 GND, 16 VCC).
// Pins ride the mclibs RS232 transceiver shape.

use mclibs.comm/rs232.mc

component MAX3232 : UARTtoRS232
{
    partno = "MAX3232"
    package = PKG.SOIC16    // 16-pin SOIC (D) / SSOP (DB) / SOIC (DW) /
                            // TSSOP (PW) / PDIP share one pinout (p.1 Device
                            // Information); the SOIC-16 body is stated first

    spec = [
        vdd = 3V ~ 5.5V, "single-supply operating voltage"        // p.1 bullet
        rate = 250kbps, "max data signaling rate"                 // p.1 bullet; Section 6.7: 250 kbit/s
        esd = 15kV, "RS-232 bus-terminal ESD (pm 15 kV), HBM"     // p.1 bullet
        icc = 300uA, "supply current, typ"                        // p.1 bullet
        slew = 30V/us, "driver output slew rate, max"             // p.1 Description
        temp = -40°C ~ +85°C, "operating free-air temperature, I grade (C grade 0°C ~ +70°C)"  // p.4 Section 6.3: MAX3232I / MAX3232C
    ]
}
