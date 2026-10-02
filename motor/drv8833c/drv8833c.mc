# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// Real dual brushed-DC H-bridge driver (DRV8833CPWP, HTSSOP-16 with PowerPAD),
// transcribed from TI SLVSCP9 (p.3 package drawing; pinout page-verified,
// Pin Functions table cross-checked against the figure pin-by-pin).
// Pin 11 is NC in the PWP; the unnumbered PowerPAD is grounded per the GND
// row description. VM operating range 2.7-11.8V.
// Pins ride the mclibs dual H-bridge shape.

use mclibs.motor/hbridge.mc

component DRV8833C : HBRIDGE.DUAL
{
    partno = "DRV8833CPWP"
}
