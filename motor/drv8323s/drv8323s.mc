# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// Real SPI-configured three-phase smart gate driver (DRV8323SRTAT, RTA: 40-pin
// WQFN with exposed thermal pad), transcribed from TI ZHCSG01C (Chinese
// datasheet, p.7 package drawing; pinout page-verified, Pin Functions table
// cross-checked against the figure pin-by-pin). The S variant keys pins 1-25
// and 31-40 identically to the DRV8304H; pins 26-29 carry the SPI face
// (SDO/SDI/SCLK/nSCS) instead of the resistor-set configuration. The H
// variant keeps MODE/IDRIVE/VDS/GAIN on 26-29 and rides GATEDRV.H6 instead.
// The thermal pad is unnumbered and must be grounded. VM range 6-60V.
// Pins ride the mclibs SPI-configured three-phase gate driver shape.

use mclibs.motor/gatedrv.mc

component DRV8323S : GATEDRV.H6S
{
    partno = "DRV8323SRTAT"
}
