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

#  BSS138N
#

component TRANS.NMOS.BSS138N
{
    partno = "BSS138N"      // model NO. BSS138N
    package = "SOT23-3"     // package is SOT23-3

    pins = [
        1 = G, "Gate"
        2 = D, "Drain"
        3 = S, "Source"
    ]

    spec = [
        Vgs = -20V ~ +20V, "Gate-Source Voltage"      // pin Gate to Source Voltage could be +/-20V
        Vds = 0V ~ 60V, "Drain-Source Voltage"        // pin Drain to Source Voltage could be up to 60V
        Id  = 0A ~ 0.23A, "Continuous Drain Current"
        Rdson = [                                     //"Drain-Source on-resistance"
            case1 = 60mΩ, Vgs:-10V, Id:-4.1A          // Rdson[1]=60mΩ, under condition Vgs:-10V, Id:-4.1A
            case2 = 87mΩ, Vgs:-4.5V, Id:-3A           // Rdson[2]=87mΩ, under condition Vgs:-10V, Id:-4.1A
        ]
    ]
}
