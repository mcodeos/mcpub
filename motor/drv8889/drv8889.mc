# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// Real automotive stepper driver (DRV8889QPWPRQ1, HTSSOP-24 with PowerPAD),
// transcribed from TI ZHCSJO5 (Chinese datasheet, p.3 package drawing; pinout
// page-verified, Pin Functions table cross-checked against the figure
// pin-by-pin). The thermal pad carries no pin number and is grounded per the
// PAD row. VM operating range 4.5-45V. The RGE (VQFN-24) variant keys
// differently and is a separate face.
// Pins ride the mclibs stepper driver shape.

use mclibs.motor/stepper.mc

component DRV8889 : STEPDRV
{
    partno = "DRV8889QPWPRQ1"
}
