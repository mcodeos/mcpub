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

    func TLE7368(pwr)
    {
        pwr -> [VCC, GND + GNDA]
    }

    func PaiIn(vin)
    {
        Net.Pai pi([CAP(0.1uF, 50V), ECAP(10uF, 50V), ECAP(47uF, 50V), CAP(0.1uF, 50V)], INDUCT(10uH, 2.1A))
        pi.filter(vin, GND) -> DC
    }

    func Reset()
    {
        CAP cReset(1nF, 10V).Cap([RT, VSS])
    }

    func Charge()
    {
        CAP ccp(220nF, 25V), cc1(100nF, 16V), cc2(100nF, 16V)
        ccp.Cap([CCP, VSS])
        //.. pins.C1\+ - cc1 - pins.C1\-
        //.. pins.C2\+ - cc2 - pins.C2\-
    }

    func Buck()
    {
        /*DC.Booster(
            CAP cboost(100nF, 10V),
            DIO dstb(),
            INDUCT lboost( 8uH~220uH, 2.1A, esr<150mΩ),
            CAP cfilter(4.7uF, 16V)
        )
        .boost(BST, SW, GNDA, VSW)*/
    }

    func QT12LDO1()
    {
        CAP ct1(4.7μF,10V), ct2(4.7μF,10V), cldo1(1μF,10V)
        
        //.. VSW -> pins.FBL_IN
        ct1.Cap([Q_T1, VSS])
        ct2.Cap([Q_T1, VSS])
        cldo1.Cap([Q_LDO1, VSS])
    }

    func LDO2(vLdo2)
    {
        CAP cldo2(1μF,10V)

        VSW -> IN_LDO2    // LDO2

        // Strap table: SEL_LDO2 to GND selects 2.6 V, to Q_LDO2 selects 3.3 V
        if (vLdo2 == 2.6V){
            SEL_LDO2 + VSS
        }
        else{
            SEL_LDO2 + Q_LDO2
        }
        
        cldo2.Cap([Q_LDO2, VSS])
    }

    func LDO3(ldo3)
    {
        if (ldo3 == "YES"){
            DC.LDO(TRANS(), CAP(22uF,10V,"Tantalum")) ld
            ld.ldrop(VSW, DRV_EXT, FB_EXT, GND_A, Q_LDO3)
        }
        else
            DRV_EXT + FB_EXT // no ldo3 configuration
    }

    func STDBY(vStdby)
    {
        CAP cstby(2μF,10V)

        // Strap table: SEL_STBY to Q_STBY selects 1.0 V, to VSS selects 2.6 V
        if (vStdby == 1V){
            SEL_STBY + Q_STBY
        }
        else{
            SEL_STBY + VSS
        }

        cstby.Cap([Q_STBY, VSS])
    }

    func PullUp_RO1()
    {
        RES(10kΩ).Pullup([RO_1, VCC.MCU]) // LDO1 reset output to MCU
    }

    func PullUp_RO2_FBEXT()
    {
        RES(10kΩ).Pullup([RO_2, VCC.MCU]) // LDO2/FB_EXT reset output to MCU
    }

    func Ignite()
    {
        //X RES r(100kΩ), TRANS.NMOS q, Switch s
        RES r(100kΩ)
        TRANS.NMOS q
        Switch s
    }

    func AutoReset()
    {
        TTL.D dTrigger.Cap()
        VEXT + dTrigger.VCC + dTrigger.D
        VSS + dTrigger.GND

        _PORST -> dTrigger.CLK
        dTrigger.Q -> EN_UC

        return dTrigger._CLR
    }

    func StandByTimer(vstby)
    {
        SYS.Calendar timer
        timer(vstby, GND).Cap().Timer()
        return timer.I2C
    }
}

module TLE7368E(pwr, VIN_STBY, EN_IGN, EN_UC, WDI)
{
    TLE7368("TLE7368E") tle
    .PaiIn(pwr)
    .Reset()
    .Ignite(EN_IGN)
    .AutoReset()
    .Charge().Buck().QT12LDO1().LDO2().LDO3().STBY()
    .StandByTimer(VIN_STBY)

    // =========================================================================
    // Exporting ports: module-body return is deprecated (unsupported) — use declarative io ports + `<-` binding instead.
    // Consumers access them externally as .member of <inst>.<port-name> (e.g. pwr.V3V3 in tc275knl.mc).
    // =========================================================================
    io QT1
    io QT2
    io V5V
    io V3V3
    io V1V3
    io VEXT
    io VDD_STBY
    io MON_STBY
    io WDO
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
