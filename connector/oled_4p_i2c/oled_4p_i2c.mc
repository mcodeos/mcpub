// Copyright (c) 2026 MCode
//
// Licensed under the Apache License, Version 2.0.

// =============================================================================
//  OLED display header — 4P (SCL/SDA/VDD/GND), board-level anonymous part
//  (part number OLED-4P-I2C, a generic 4-pin I2C OLED module header).
// =============================================================================
component OLED.HDR4
{
    partno = "OLED-4P-I2C"

    pins = [
        in 1 = SCL
        io 2 = SDA
        psnk [[3], [4]] = [VDD, GND]::DC(3.3V)
    ]
}
