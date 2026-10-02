# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// Real three-phase gate driver with integrated buck regulator (DRV8302,
// DCA: 56-pin HTSSOP with PowerPAD numbered 57 = GND), transcribed from TI
// ZHCS138C (Chinese datasheet, p.3 package drawing; pinout page-verified,
// Pin Functions table cross-checked against the figure pin-by-pin).
// Two supply domains: PVDD1 (gate driver) and PVDD2 (buck). The exposed
// PowerPAD carries pin number 57 and the name GND.
// PVDD operating range 8-60V.
// Pins ride the mclibs three-phase gate driver with buck shape.

use mclibs.motor/gatedrv.mc

component DRV8302 : GATEDRV.H6B
{
    partno = "DRV8302DCAR"
}
