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

# TC275 32-Bit Single-Chip Micocontroller

component TC275
{
    vender = "Infinieon"
    desc = "TC275 32-Bit Single-Chip TriCore Micocontroller"
    
    partno = "TC275"
    package = "PG-LQFP-176-22" // LF-BGA-292-6 / LF-BGA-292-10

    pins = [ 
        // supply
        101 = VSS::DC.GND(), "Digital Ground" //.. is there still a need for separate definitions?
        
        10 = DC.VDD::DC(1.3V), "Production Device is VDD" 
            //.. | DC.VDDSB::DC(1.3V), "Emulation SRAM Standby Power Supply"
        10 = DC.VDDSB::DC(1.3V), "Emulation SRAM Standby Power Supply"

        [24,68,123] = DC.VDD::DC(1.3V), "Digital Core Power Supply (1.3V)"
        100 = VDD, "Digital Core Power Supply (1.3V), The supply pin inturn supplies the main XTAL Oscillator/PLL (1.3V)"
        
        [25, 69, 99, 153] = VEXT, "External Power Supply (5V / 3.3V)"
        104 = VDDP3, "Digital Power Supply for Oscillator, LVDSH and A2 pads (3.3V)"
        154 = VDDP3, "Digital Power Supply for Flash (3.3V)"
        155 = VDDFL3, "Flash Power Supply (3.3V)"
        164 = VFLEX, "Digital Power Supply for Flex Port Pads (5V / 3.3V)"

        52 = VAREF1, "Positive Analog Reference Voltage 1"
        51 = VAGND1, "Negative Analog Reference Voltage 1"
        26 = VAREF2 | AN49, ["Positive Analog Reference Voltage 2", "AN49"]   
        27 = VAGND2 | AN48, ["Negative Analog Reference Voltage 2", "AN48"]
        54 = VDDM, "ADC Analog Power Supply", [3.3V, 5V]
        53 = VSSM, "Analog Ground for VDDM"

        [1:9] = P02[0:8]
        [11:23] = P00[0:12]

        [28:31] = AN[47:44]
        [32:35] = AN[39:36]  | P40[9:6]
        36 = AN35
        [37:38] = AN[33:32]  | P40[5:4]
        [39:40] = AN[29:28]
        [41:44] = AN[27:24]  | P40[3:0]

        [45:50] = AN[21:16]
        [55:67] = AN[13:0]
        [70:83] = P33[0:13]
        [84,86:88] = P32[0,2:4]

        [89:94] = P23[0:5]
        [95:98] = P22[0:3]
        [105:111,113] = P21[0:6,7]
        [116:119] = P20[0:3]
        [124:132] = P20[6:14]

        [133:141] = P15[0:8]
        [142:152] = P14[0:10]
        [156:159] = P13[0:3]
        [160:163] = P11[2:3,6,9]
        [165:167] = P11[10:12]
        [168:176] = P10[0:8]

        // system I/O
        [102:103] = XTAL{X1,X2}

        121 = _PORST
        122 = _ESR0
        120 = _ESR1

        84 = VGATE1N
        85 = VGATE1P

        [111:115] = JTAG{TDI,TMS,TDO,_TRST,TCK}
        [115,112,113] = DAP{DAP0, DAP1, DAP2}

        118 = _TESTMODE
    ]

    layout = [ // direction:"anti-clockwise"
        left = [1:44]
        down = [45:88]
        right = [89:132]
        up = [133:176]
    ]  

    func TC275_3E(v3v3, v1v3, vext, gnd, va1, va2, vddm)
    {
        gnd  -> VSS //101
        v1v3 -> VDD //[10,24,68,100,123]
        vext -> VEXT //[25,69,99,153]
        v3v3 -> (VDDP3, VDDFL3, VFLEX)
        va1  -> (VAREF1, VAGND1)
        va2  -> (VAREF2, VAGND2)
        vddm -> (VDDM, VSSM)
    }

    func CapDigital(gnd)
    {
        //..
        CAP(100nF).Cap([this{10,24,68,100,123}, gnd])
        CAP(100nF).Cap([this{25,69,99,153}, gnd])
        CAP(100nF).Cap([[pins{104,154}, pins.155, pins.164], gnd])
    }

    func CapAnalog(vag1, vag2, vddm)
    {
        CAP(100nF).Cap([VAREF1, vag1])
        CAP(100nF).Cap([VAREF2, vag2])
        CAP(100nF).Cap([VDDM, vddm])
    }

    func Xtal(gnd)
    {
        //Crystal y(20MHz)
        //CAP c[1:2](10pF, 10V)
        //XTAL + y.Cap([c[1:2], gnd])

        XTAL <- Crystal(20MHz).Cap([c[1:2]::CAP(10pF, 10V), gnd])
    }

    func HwReset()
    {
        Switch s
        Transistor q
        PORST_IN <- Cap([(R108 - q.g) + R109 + C105, VSS]) + (s - VEXT) 
        PORST_OUT <- (R105 - _PORST) + q.d + (R106 - VEXT)
    }
}
