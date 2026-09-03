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

# PCA9555

component PCA9555(partno)
{
    desc = "I2C GPIO Expansion"

    if (partno == "PCA9555N")
        package = "DIP24"
    else if(partno == "PCA9555D")
        package = "SO24"
    else if(partno == "PCA9555DB")
        package = "SSOP24"
    else if(partno == "PCA9555PW")
        package = "TSSOP24"
    else if(partno == "PCA9555BS")
        package = "HVQFN24"
    else if(partno == "PCA9555HF")
        package = "HWQFN24"
    else
        package = "DIP24"

    pins = [
        ps [24,12] = DC{VCC,GND}::DC() | [VDD, VSS]

        in [21,2,3] = A[0:2]
        io [23, 22, 1] = I2C{SDA, SCL, INTR}::I2C()

        io [4:11] = IO0{0:7}
        io [13:20] = IO1{0:7}
    ]

    func Address(address)
    {
        if (address & 0x01) RES(10kΩ).Pullup([A0, VDD]) else RES(10kΩ).Pulldown([A0, VSS])
        if (address & 0x02) RES(10kΩ).Pullup([A1, VDD]) else RES(10kΩ).Pulldown([A1, VSS])
        if (address & 0x04) RES(10kΩ).Pullup([A2, VDD]) else RES(10kΩ).Pulldown([A2, VSS])
    }
}
