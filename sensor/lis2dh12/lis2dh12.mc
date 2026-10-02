# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// =============================================================================
//  LIS2DH12 — ST 3-axis accelerometer, "femto" family, LGA-12 (2x2mm)
//  Datasheet: ST LIS2DH12 Rev6, DocID025056 (same directory)
//
//  LGA-12 pin shape, verified pin-by-pin against Rev6 Table 2:
//    1  = SPC     I2C serial clock (SCL) / SPI serial port clock
//    2  = CS      SPI enable / mode select: 1 = I2C enabled, 0 = SPI
//    3  = SA0     SPI SDO / I2C address LSB (internally pulled up);
//                 tied GND -> 7-bit address 0x18 (SAD = 001100xb)
//    4  = SDI     I2C SDA / SPI data input
//    5  = RES     reserved — connect to GND per datasheet
//    6  = GND     7 = GND   8 = GND
//    9  = VDD     power supply, 1.7V-3.6V
//    10 = VDD_IO  I/O supply
//    11 = INT2    interrupt output 2
//    12 = INT1    interrupt output 1
//  NOTE: pin 11 is INT2 and pin 12 is INT1 — easy to swap from memory.
// =============================================================================

component LIS2DH12
{
    partno = "LIS2DH12"       // orderables: LIS2DH12TR (tape&reel) etc.
    package = PKG.FLGA        // LGA-12 2x2mm fine-pitch land grid array
    voltage = 3.3V            // Vdd range 1.7V-3.6V (datasheet §3)

    name = "LIS2DH12 3-axis accelerometer"
    description = "Ultra-low-power 3-axis MEMS accelerometer, I2C/SPI (LGA-12)"

    pins = [
        psnk [[9, 10], [6, 7, 8]] = [VDD, VSS]::DC(3.3V), "Vdd/Vdd_IO; GND x3"
        io 1 = SPC, "I2C SCL / SPI SPC"
        io 2 = CS, "SPI enable; high = I2C mode"
        io 3 = SA0, "SDO/SA0 address bit, internal pull-up"
        io 4 = SDI, "I2C SDA / SPI SDI"
        io 5 = RES, "Reserved, tie to GND"
        io 11 = INT2, "Interrupt output 2"
        io 12 = INT1, "Interrupt output 1"
    ]
}
