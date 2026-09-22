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

// Real MCU (US513_20_F, QFN20), extracted verbatim from the verified hbl
// board (U192 mcu batch). Ruling U192-3: the MCU stays a standalone real
// part for now - no abstract base until an industry-naming abstract cluster
// is summarized later (mux branch pins are the part's private face).

component MCU.US513_20_F                                                  // MCU controller, QFN20
{
    partno = "US513_20_F"                                                 // 型号是US513_20_F
    package = PKG.QFN20                                                   // 封装是QFN20

    pins = [                                                              // 管脚定义
        io [1, 2] = I2C0::I2C(Master)                                     // 管脚1和2可以配置为I2C接口
                    | GPIO[3, 4]::GPIO(Controller)                        // 也可以配置为GPIO

        in [3, 4] = XTAL::XTAL(32kHz)                                     // 32K晶振输入/输出管脚
        psnk [5, 21] = [VDD, GND]::DC(3.3V)                               // VDD电源输入, 电压3.3V（汇）
        io [6, 7] = UART0::UART.TTL(DCE)                                  // 管脚[6,7]可以配置为串口UART0
                    | I2C1::I2C(Master)                                   // 管脚[6,7]可以配置为I2C接口
                    | GPIO[5, 6]::GPIO(Controller)                        // 管脚[6,7]也可以配置为GPIO

        io [8, 9] = PDM[CLK, DATA]
                    | PBus{CLK, DATA}
                    | GPIO[7, 8]::GPIO(Controller)                        // 管脚[8,9]可以配置为PDM接口，也可以配置为GPIO

        io [10, 11] = I2C1::I2C(Master) | GPIO[9, 10]::GPIO(Controller),  // 管脚[10,11]可以配置为I2C接口, 也可以配置为GPIO
        ["I2C接口", "GPIO"], volt:1.2V, amp:100mA

        // Master 线序 [CS, SCLK, MISO, MOSI]：书写序=线序（b3648），故脚号为 [10, 8, 11, 9]
        io [10, 8, 11, 9] = SPI{CSN, SCLK, MISO, MOSI}::SPI(Master)       // 管脚10=CSN, 8=SCLK, 11=MISO, 9=MOSI，按 Master 线序书写
        io [12, 13] = UART1::UART.TTL(DCE)                                // 管脚[12,13]可以配置为串口UART1
                      | GPIO[5, 6]::GPIO(Controller)                      // 也可以配置为GPIO

        psnk [14, 21] = [VDD_CORE, GND]::DC(1.2V)                         // 电源1.2v输入（汇）
        in 15 = AVDD09_CAP                                                // AD电源降噪电容输入管脚
        io [16, 17] = ADC::ADC.DIFF(Receiver) @class(analog)              // 模拟差分输入接口P/N（ADC.DIFF 只有 P/N 两根线）
        io [18, 19] = JTAG::DBG.JTAG.2(TAP)                               // 管脚18和19可以配置为JTAG接口
                      | GPIO[0,1]::GPIO(Controller)                       // 也可以配置为GPIO
        // | I2S::I2S()                         // 也可以配置为I2S接口

        io 20 = GPIO[2] | EXT_CLK_IN                                      // 管脚20，可以配置为GPIO, 也可以配置为外部时钟输入
    ]

    // 端子级带参接线宏：把两个域绑到 MCU 电源脚（每个入对在该对延续处放一只本地去耦）
    func power([VDD_3V3, GND]::DC(3.3V), [VCC_1V2, GND]::DC(1.2V)) {
        [VDD_3V3, GND] => CAP(1uF, ±10%, CAP.X5R, 10V).Cap(_) -> [VDD, GND]       // VDD去耦：VDD_3V3给this.VDD输入供电
        [VCC_1V2, GND] => CAP(1uF, ±10%, CAP.X5R, 10V).Cap(_) -> [VDD_CORE, GND]  // VDD_CORE去耦：VCC_1V2给this.VDD_CORE输入供电
        CAP(1uF, ±10%, CAP.X5R, 10V).Cap([AVDD09_CAP, GND])                       // AVDD09_CAP去耦（模拟参考去耦到数字 GND）
    }

    func i2c(address) {
        //通过设置GPIO.02的电平，来确定I2C0的地址。GPIO.02高电平，I2C0的地址为 addr:0X36；GPIO.02低电平，I2C0的地址为 addr:0X35

        if address == 0x36
            VDD - RES(100kΩ) - GPIO[2]     // GPIO.02通过100K电阻接电源VDD_3V3，设置GPIO.02高电平（被动上拉，无向——与库 Pullup 助手 `net - this - vcc` 一致；psnk 汇脚不作有向源端）
        else                               //if address == 0x35
            GPIO[2] - RES(100kΩ) -> GND    // GPIO.02通过100K电阻接地。

        // I2C接口I2C0的两个信号线各接一颗上拉电阻到VDD，以稳定信号。
        RES(10kΩ).Pullup([I2C0.SCL, VDD])  // I2C0.SCL 上拉到 VDD
        RES(10kΩ).Pullup([I2C0.SDA, VDD])  // I2C0.SDA 上拉到 VDD
    }
}
