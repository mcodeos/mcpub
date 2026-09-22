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

// Real 2-pin passive crystal (DST310S, 3215 package), extracted verbatim
// from the verified hbl board (U192 crystal batch).
//
// Ruling U192-2 keeps the parameterized crystal face in mcode (XTAL2(freq,
// cload) already carries it; concrete values flow through the formals).
// This file stays a standalone real part: a `:` binding against an mcode/
// mclibs abstract waits for the U187 xtal naming-law debt to clear first
// (bind-after-debt order, U192 table).

component Crystal2.DST310S   // 2-pin passive crystal
{
    partno = "DST310S"       // 型号是DST310S
    package = PKG.Xtal_3215  // 封装是3215，即32mm*15mm
    spec = [
        frequency = 32kHz    // 晶振频率是32kHz
    ]

    pins = [
        [1, 2] = XTAL::XTAL(Resonator)  // 管脚1和2，对应晶振接口XTAL的X1和X2（无源谐振体侧）
    ]

    func setup(GND) {
        XTAL - R442::RES(1MΩ, ±1%)'  // 生成一个电阻1MΩ，精度1%，封装尺寸R0402，缺省NC不焊接，声明实例名字为R442，与晶振并联
        - [                          // 串联谐振电容18pF，精度5%，50V耐压，封装尺寸C0402，缺省NC不焊接
            CAP(18pF, ±5%, CAP.C0G, 50V),
            CAP(18pF, ±5%, CAP.C0G, 50V)
        ]
        - [GND, GND]                 // 串联接到GND
    }
}
