# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// Real 64-pin general-purpose MCU (ST STM32F205RET6, LQFP64 10x10),
// transcribed from the ST datasheet (DS6329 Rev 18; Figure 10 LQFP64
// pinout p.41 cross-checked pin by pin against the Table 5/6 LQFP64
// pin-definitions columns, 64/64 agree). Part number per the ordering
// scheme (R = 512KB flash, E = 512KB, T = LQFP, 6 = -40 to 85C).
// Standalone real part (ruling as us513_20_f): no LQFP64 abstract shape
// exists in mclibs yet -- summarize the cluster before basing.
//
// Pin names are the datasheet port names (PH0_OSC_IN / PH1_OSC_OUT per
// DS6329; some third-party boards label pins 5/6 "PD0/PD1", an F103
// carry-over -- the pin NUMBERS 5/6 agree everywhere). GPIO rows carry
// the board-facing alternate names only (USB/SWD); the full AF map is
// out of transcription scope. VCAP_1/VCAP_2 (pins 31/47) are the core
// regulator capacitor terminals -- each needs its own 2.2uF to GND,
// they are NOT extra VSS returns.

component STM32F205RET6                                                  // MCU controller, LQFP64
{
    partno = "STM32F205RET6"                                            // ST STM32F205RET6（Cortex-M3, 512KB flash）
    package = PKG.LQFP64                                                // 封装是LQFP64

    spec = [
        vdd = 1.8V ~ 3.6V, "VDD/VDDA operating supply window"           // DS6329 Table 12, p.50（VDDA>=VDD；ADC 用时 VDDA 2.4V~3.6V）
        vbat = 1.65V ~ 3.6V, "VBAT operating window"                    // DS6329 Table 12, p.50
        freq = 120MHz, "CPU clock, max"                                 // DS6329 p.1 feature bullet
        temp = -40°C ~ +85°C, "operating temperature, suffix 6"         // DS6329 ordering scheme Table 3, p.19
    ]

    pins = [                                                            // 管脚定义（LQFP64，脚号依 DS6329 Figure 10, p.41）

        // -- 电源面（数字）：VDD 19/32/48/64，回流 VSS 18/63
        psnk [[19, 32, 48, 64], [18, 63]] = [VDD, VSS]::DC(3.3V)        // 数字电源对（汇）
        // -- 电源面（模拟）：VDDA 13，回流 VSSA 12（VDDA >= VDD）
        psnk [13, 12] = [VDDA, VSSA]::DC(3.3V)                          // 模拟电源对（汇）
        // -- 备用电池域：VBAT 1（与 VDD 同轨使用时接同一 3.3V）
        psnk [1, 18] = [VBAT, VSS]::DC(3.3V)                            // VBAT 电源输入（汇）
        // -- 内核稳压电容脚：各接 2.2uF 至 GND（非电源回流！）
        in 31 = VCAP_1                                                  // 内核 LDO 电容脚 1（外接 2.2uF）
        in 47 = VCAP_2                                                  // 内核 LDO 电容脚 2（外接 2.2uF）

        // -- 时钟：主振荡器端子（振荡器侧，承载维持放大器）；采纳 XTAL 接口
        //    供配对面 ERC（RESONATOR 恰接一个 OSCILLATOR），引脚名仍循数据手册
        in [5, 6] = XTAL::XTAL(OSCILLATOR), ["PH0_OSC_IN", "PH1_OSC_OUT"]  // 主晶振输入/输出（部分板标注 PD0/PD1-OSC，F103 沿袭）
        io 7 = RST{NRST}::RST(RECEIVER)                                 // 双向系统复位（低有效；采纳 RST 接口，复位体侧）
        in 60 = BOOT0                                                   // 启动选择（弱上拉/下拉决定启动区）

        // -- GPIOA（脚号依 Figure 10）
        io 14 = PA0                                                     // WKUP/ADC12_IN0
        io 15 = PA1                                                     // ADC12_IN1
        io 16 = PA2                                                     // ADC12_IN2
        io 17 = PA3                                                     // ADC12_IN3
        io 20 = PA4                                                     // ADC12_IN4/SPI1_NSS
        io 21 = PA5                                                     // ADC12_IN5/SPI1_SCK
        io 22 = PA6                                                     // ADC12_IN6/SPI1_MISO
        io 23 = PA7                                                     // ADC12_IN7/SPI1_MOSI
        io 41 = PA8                                                     // USART1_CK/TIM1_CH1
        io 42 = PA9                                                     // USART1_TX/TIM1_CH2
        io 43 = PA10                                                    // USART1_RX/TIM1_CH3
        io 44 = PA11 | USB_DM                                           // CAN_RX/USB_DM/USART1_CTS
        io 45 = PA12 | USB_DP                                           // CAN_TX/USB_DP/USART1_RTS
        io 46 = PA13 | SWDIO | JTMS                                     // SWD 数据（FT 脚）
        io 49 = PA14 | SWCLK | JTCK                                     // SWD 时钟（FT 脚）
        io 50 = PA15                                                    // JTDI/SPI1_NSS

        // -- GPIOB
        io 26 = PB0                                                     // ADC12_IN8/TIM3_CH3
        io 27 = PB1                                                     // ADC12_IN9/TIM3_CH4
        io 28 = PB2                                                     // BOOT1/ADC12_IN12
        io 55 = PB3                                                     // JTDO/SPI1_SCK
        io 56 = PB4                                                     // NJTRST/SPI1_MISO
        io 57 = PB5                                                     // SPI1_MOSI/TIM3_CH2
        io 58 = PB6                                                     // I2C1_SCL/TIM4_CH1
        io 59 = PB7                                                     // I2C1_SDA/TIM4_CH2
        io 61 = PB8                                                     // CAN_RX/TIM4_CH3
        io 62 = PB9                                                     // CAN_TX/TIM4_CH4
        io 29 = PB10                                                    // I2C2_SCL/USART3_TX
        io 30 = PB11                                                    // I2C2_SDA/USART3_RX
        io 33 = PB12                                                    // SPI2_NSS/I2C2_SMBA
        io 34 = PB13                                                    // SPI2_SCK/USART3_CTS
        io 35 = PB14                                                    // SPI2_MISO/USART3_RTS
        io 36 = PB15                                                    // SPI2_MOSI/TIM1_CH3N

        // -- GPIOC
        io 8  = PC0                                                     // ADC123_IN10
        io 9  = PC1                                                     // ADC123_IN11
        io 10 = PC2                                                     // ADC123_IN12
        io 11 = PC3                                                     // ADC123_IN13
        io 24 = PC4                                                     // ADC12_IN14
        io 25 = PC5                                                     // ADC12_IN15
        io 37 = PC6                                                     // TIM3_CH1/I2S2_MCK
        io 38 = PC7                                                     // TIM3_CH2/USART6_RX
        io 39 = PC8                                                     // TIM3_CH3/USART6_TX
        io 40 = PC9                                                     // TIM3_CH4/USART6_RX
        io 51 = PC10                                                    // UART4_TX/SDIO_D2
        io 52 = PC11                                                    // UART4_RX/SDIO_D3
        io 53 = PC12                                                    // UART5_TX/SDIO_CK
        io 2  = PC13                                                    // RTC_AF1/TAMPER（RTC 复用）
        io 3  = PC14                                                    // OSC32_IN（32K 晶振复用）
        io 4  = PC15                                                    // OSC32_OUT（32K 晶振复用）

        // -- GPIOD（LQFP64 上仅 PD2 引出）
        io 54 = PD2                                                     // UART5_RX/SDIO_CMD
    ]

    // ── 典型应用封装（mcd checklist §6.9；提取自 DS6329 typical application）──

    // 电路块级：电源/去耦组。数字与模拟两域分开传（VDDA 分轨滤波的板子传不同域）；
    // VBAT 按同轨接法（DS6329：不用备份电池时接 VDD），电池备份板改接电池。
    func Power([VDD_3V3, GND]::DC(3.3V), [VDDA_3V3, GND]::DC(3.3V)) {
        VDD_3V3 - VDD                                                   // 数字电源汇 19/32/48/64
        GND - VSS                                                       // 数字回流汇 18/63
        VDDA_3V3 - VDDA                                                 // 模拟电源 13（VDDA >= VDD）
        GND - VSSA                                                      // 模拟回流 12
        VDD_3V3 - VBAT                                                  // VBAT 同轨（脚 1）
        VCAP_1 - CAP(2.2uF, ±10%, CAP.X5R, 6.3V) - GND                  // 内核 LDO 电容 1（DS6329：各 2.2uF 陶瓷）
        VCAP_2 - CAP(2.2uF, ±10%, CAP.X5R, 6.3V) - GND                  // 内核 LDO 电容 2
    }

    // 电路块级：复位 RC。DS6329 typical：NRST 对地 0.1uF（片内自带上拉，
    // 外部上拉/复位按键是板级选择，不进本宏）。
    func Reset(gnd) {
        RST.NRST - CAP(100nF, ±10%, CAP.X5R, 25V) - gnd                 // 复位噪声滤波
    }
}

// 模块级封装（§6.9）：最小系统 = MCU + 主晶振（含负载电容）+ 复位 RC + BOOT0 strap。
// 模拟域按同轨传（VDDA 分轨滤波的板子跳过本模块、自行调 uC.Power 双域）。
// BOOT0 按 10k 上拉＝主闪存启动（DS6329 BOOT 值表；串口 bootloader 板改接地）。
module STM32F205_MINI(psnk pwr{V3V3, GND}::DC(3.3V), freq::UV.HZ, cl::UV.CAP)
{
    STM32F205RET6 uC
    .Power(pwr, pwr)                                                    // 两域同轨
    .Reset(pwr.GND)

    XTAL2(freq, cl) y1                                                  // 主晶振（mcode comp/xtal.mc）
    y1.Setup(pwr.GND) -> uC.XTAL{X1, X2}                                // 负载电容落在晶振脚，归属判 U200
    uC.BOOT0 - RES(10kΩ, ±1%) - pwr.V3V3                                // 主闪存启动 strap
}
