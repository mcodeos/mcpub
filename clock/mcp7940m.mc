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

# MCP7940M microchip.com

component SYS.Clock.MCP7940M(partno)
{
    desc = "MCP7940M Battery-Backed I2CTM Real-Time Clock/Calendar with SRAM"

    if (partno == "MCP7940MT") package = PKG.SOIC8
    else if (partno == "7940MT") package = PKG.MSOP8
    else if (partno == "940M") package = PKG.TSSOP8
    else if (partno == "MCP7940M") package = PKG.DIP8
    else if (partno == "AU1") package = PKG.TDFN8_2x3
    else package = PKG.SOIC8

    pins = [
        ps [8,4] = [VCC,VSS]::DC()
        in [1,2] = XTAL{X1,X2}::XTAL(), ["Crystal X1", "Crystal X2"]
        io [5,6] = I2C{SDA,SCL}::I2C(), ["I2C data", "I2C clock"]
        out 7 = MFP, "used for alarm and square wave output, or GPIO"
        nc 3 = NC
    ]

    func MCP7940M(pwr)
    {
        pwr -> [VCC,VSS]
    }

    func Cap()
    {
        CAP(100nF, 10V).Cap([VCC, VSS])
    }

    func Xtal()
    {
        XTAL2(32.768kHz, 10nF).Setup(VSS) - XTAL
    }

    desc.features = ["
            Timekeeping Features:
            • Real-Time Clock/Calendar (RTCC):
              - Hours, Minutes, Seconds, DayofWeek, Day, Month, Year
              - Leap year compensated to 2399
              - 12/24 hour modes
            • Oscillatorfor 32.768kHz Crystals: - Optimized for 6-9pF crystals
            • On-Chip Digital Trimming/Calibration: 
              - ±1PPM resolution
              - ±129 PPM range
            • Dual Programmable Alarms
            • Versatile Output Pin:
              - Clock output with selectable frequency
              - Alarm output
              - General purpose output
            • Power-FailTime-Stamp:
              - Time logged on switch over to and from Battery mode

            Low-Power Features:
            • WideVoltageRange:
              - Operating voltage range of 1.8V to 5.5V - Backup voltage range of 1.3V to 5.5V
            • LowTypicalTimekeepingCurrent:
              - Operating from VCC: 1.2μA at 3.3V
              - Operatingfrombatterybackup: 925nA at 3.0V
            • Automatic Switch over to Battery Backup

            User Memory:
            • 64-byte Battery-Backed SRAM
        "]

    desc.overall =   "The MCP7940N Real-Time Clock/Calendar (RTCC) tracks time using internal counters for 
            hours, minutes, seconds, days, months, years, and day of week. Alarms can be configured 
            on all counters up to and including months. For usage and configuration, the MCP7940N 
            supports I2C communications up to 400 kHz.
            The open-drain, multi-functional output can be configured to assert on an alarm match, 
            to output a selectable frequency square wave, or as a general purpose output.
            The MCP7940N is designed to operate using a 32.768 kHz tuning fork crystal with external
            crystal load capacitors. On-chip digital trimming can be used to adjust for frequency 
            variance caused by crystal tolerance and temperature.
            SRAM and timekeeping circuitry are powered from the back-up supply when main power is 
            lost, allowing the device to maintain accurate time and the SRAM contents. The times 
            when the device switches over to the back-up supply and when primary power returns 
            are both logged by the power-fail time-stamp."

}
