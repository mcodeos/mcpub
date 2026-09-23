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

component TLE7368 (partno)
{
    desc = "TLE7368 multifunctional power supply"

    if (partno == "TLE7368E")
    {    package = "PG-DSO-36"; FB_EXT = 1.5V }
    else if (partno == "TLE7368-2E")
    {    package = "PG-DSO-36"; FB_EXT = 1.2V }
    else if (partno == "TLE7368-3E")
    {    package = "PG-DSO-36"; FB_EXT = 1.3V }

    pins = [
        in [[20:22], 17] = [VCC,GND]::DC(-0.3V ~ 45V), ["Buck regulator input", "Power ground, Exclusive GND connection of charge pump"]
        in [1,18,19,36] = GNDA, "Connect to exposed pad"

        in 9 = EN_UC, volt: -0.3V~ 5.5V, "Enable input microcontroller, high level enables / low level disables the IC except the stand-by regulators; Integrated pull-down resistor"
        in 10 = EN_IGN, volt: -0.3V ~45V, "Enable input ignition line, high level enables / low level disables the IC except the stand-by regulators; Integrated pull-down resistor"

        // VSW
        io 14 = C1\+, "Charge pump,  ceramic capacitor 100 nF"
        io 12 = C1\- 
        io 15 = C2\+, "Charge pump,  ceramic capacitor 100 nF"
        io 13 = C2\-
        io 16 = CCP, "Charge pump output, a ceramic capacitor, 220 nF, to GND"
        in 28 = BST, "Bootstrap driver supply input"
        out [26,27] = SW, "Buck power stage’s output, to the Buck converter circuit, the catch diode and the Buck inductance"

        // LDO1, QT1/2
        in 29 = FBL_IN, "Buck converter feedback input plus input for LDO1 and trackers"
        out [30,17] = [Q_LDO1,GND]::DC(5V, 800mA), "Voltage regulator 1 output, 5V, 800mA current limitition"
        out [7,17] = [Q_T1,GND]::DC(-5V ~ 40V), "Tracking regulator 1 output"
        out [8,17] = [Q_T2,GND]::DC(-5V ~ 40V), "Tracking regulator 2 output"

        // LDO2
        in [5,17] = [IN_LDO2, GND]::DC(), "LDO2 input"
        in 23 = SEL_LDO2, "[VSS, Q_LDO2]: GND to select 2.6 V, to Q_LDO2 to select 3.3 V"
        out [6,17] = [Q_LDO2,GND]::DC(2.6V,700mA)|[Q_LDO2,GND]::DC(3.3V,700mA), "Voltage regulator 2 output, 700mA current limitition"

        // LDO3
        out 32 = DRV_EXT, "Bipolar power stage driver output, Connect the base of an external NPN transistor"
        io 31 = FB_EXT, voltage:[1.2V, 1.3V, 1.5V], "External regulator feedback input, and drive to LDO3"

        // STBY
        in [34,17] = [VIN_STBY, GND]::DC(-0.3V ~ 45V), "Power Input to stand-by regulator"
        in 11 = SEL_STBY, "[VSS, Q_STBY]: Selection input for stand-by regulator,  GND to 2.6V, to Q_STBY to select 1.0V"
        out [33,17] = [Q_STBY,GND]::DC(1.0V)|[Q_STBY,GND]::DC(2.6V), "Stand-by regulator output"
        out 35 = MON_STBY, "Monitoring output for stand-by regulator"

        // Status
        in 2 = RT, "Reset and watchdog timing pin"
        out 3 = RO_1, "Reset output Q_LDO1"
        out 4 = RO_2, "Reset output Q_LDO2 and FB_EXT"
        in 24 = WDI, volt: -0.3V ~ 5.5V, "Window Watchdog input, Apply a watchdog trigger signal to this pin"
        out 25 = WDO, volt: -0.3V ~ 5.5V, "Window Watchdog output, Open drain output, active low"
    ]

    layout = [
        left = [1:18] 
        right = [36:19]
    ]

    // Power entry (b3874): the raw input pair runs a pi-filter onto VCC.
    // The old 'func TLE7368(pwr)' conflated the partno constructor with the
    // supply binding and the 'Net.Pai' macro class does not exist, so the
    // filter is restated with library parts.
    func PaiIn([vin, vret]::DC(12V))
    {
        vret -> GND
        vret -> GNDA
        vin - INDUCT(10uH, 2.1A) - VCC
        [vin, vret] => CAP(0.1uF, 50V).Cap(_)
        VCC - CAP.ELEC(10uF, 50V) - vret
        VCC - CAP.ELEC(47uF, 50V) - vret
        [VCC, vret] => CAP(0.1uF, 50V).Cap(_)
    }

    func Reset()
    {
        CAP cReset(1nF, 10V).Cap([RT, GND])
    }

    func Charge()
    {
        // The charge-pump reservoir sits on CCP; the C1/C2 flying ceramics
        // are external parts on the C1+/C1-/C2+/C2- pins (b3874 dropped the
        // disabled in-book wiring sketch).
        CAP ccp(220nF, 25V).Cap([CCP, GND])
    }

    func QT12LDO1()
    {
        CAP ct1(4.7μF,10V).Cap([Q_T1, GND])
        CAP ct2(4.7μF,10V).Cap([Q_T1, GND])
        CAP cldo1(1μF,10V).Cap([Q_LDO1, GND])
    }

    func LDO2(vLdo2::UV.VOLT)
    {
        CAP cldo2(1μF,10V).Cap([Q_LDO2, GND])

        SW -> IN_LDO2    // LDO2 is fed from the buck switch node

        // Strap table: SEL_LDO2 to GND selects 2.6 V, to Q_LDO2 selects 3.3 V
        if (vLdo2 == 2.6V){
            SEL_LDO2 + GND
        }
        else{
            SEL_LDO2 + Q_LDO2
        }
    }

    func STDBY(vStdby)
    {
        // Strap table: SEL_STBY to Q_STBY selects 1.0 V, to GND selects 2.6 V
        if (vStdby == 1V){
            SEL_STBY + Q_STBY
        }
        else{
            SEL_STBY + GND
        }

        CAP cstby(2μF,10V).Cap([Q_STBY, GND])
    }

    func PullUp_RO1()
    {
        RES(10kΩ).Pullup([RO_1, VCC]) // LDO1 reset output to MCU
    }

    func PullUp_RO2_FBEXT()
    {
        RES(10kΩ).Pullup([RO_2, VCC]) // LDO2/FB_EXT reset output to MCU
    }
}

module TLE7368E(psnk pwr{VIN, GND}::DC(12V))
{
    TLE7368("TLE7368E") tle
    .PaiIn(pwr)
    .Reset()
    .Charge()
    .QT12LDO1()
    .LDO2(3.3V)   // the V3V3 export selects the 3.3 V tap

    // No LDO3 fitted: with the external NPN solution dropped, DRV_EXT
    // straps to FB_EXT (b3874 removed the func - boards that fit LDO3
    // wire the two pins directly).
    tle.DRV_EXT + tle.FB_EXT

    // (b3874) Out of the chain, per the adopting board: the ignition
    // switch (Ignite), the PORST trigger (AutoReset; TTL.D lives in mclibs
    // and the fragment referenced board nets), the buck booster sketch
    // (Buck) and the stand-by configuration (STDBY / StandByTimer) are
    // unconsumed faces of the part book.

    // =========================================================================
    // Exporting ports: module-body return is deprecated (unsupported) — use declarative io ports + `<-` binding instead.
    // Consumers access them externally as .member of <inst>.<port-name> (e.g. pwr.V3V3 in tc275knl.mc).
    // =========================================================================
    io QT1
    io QT2
    io V5V
    io V3V3
    // (b3874) io V1V3 and io VEXT dropped: both exports traced to pins that
    // do not exist on the part (Q_LOD3 was a typo, there is no VEXT pin).
    // The part makes no 1.3 V core rail; boards source the TC275 VDD/VEXT
    // pad supplies themselves.
    io VDD_STBY
    io MON_STBY
    io WDO
    io WDI
    io _PORST

    QT1 <- tle.Q_T1
    QT2 <- tle.Q_T2
    V5V <- tle.Q_LDO1
    V3V3 <- tle.Q_LDO2
    // V1V3 <- tle.Q_LOD3   // X pin 'Q_LOD3' not defined on TLE7368 (LDO3 is an external NPN solution, no internal output pin)
    // VEXT <- tle.VEXT     // X pin 'VEXT' not defined on TLE7368
    VDD_STBY <- tle.Q_STBY
    MON_STBY <- tle.MON_STBY
    WDO <- tle.WDO
    WDI <- tle.WDI
    _PORST <- tle.RO_1 + tle.RO_2

    /* module-body return is deprecated (unsupported): export via the io port declarations + `<-` bindings above
    return [ 
        QT1 <- tle.Q_T1,   
        QT2 <- tle.Q_T2,
        V5V <- tle.Q_LDO1,
        V3V3 <- tle.Q_LDO2 ,
        V1V3 <- tle.Q_LOD3,
        VEXT <- tle.VEXT,

        VDD_STBY <- tle.Q_STBY,
        MON_STBY <- tle.MON_STBY,

        WDO <- tle.WDO,
        _PORST <- tle.RO_1 + tle.RO_2
    ]
    */
}
