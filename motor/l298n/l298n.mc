# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// Real dual full-bridge driver (L298N, Multiwatt15), transcribed from the
// ST L298 datasheet (p.2 PIN CONNECTIONS drawing; pinout page-verified,
// Pin Functions table p.3 cross-checked pin-by-pin). The metal tab is
// connected to pin 8 (GND). Vs abs max 46V (42V in characteristics),
// Vss 5V logic supply.
// Pins ride the mclibs classic dual full-bridge shape.

use mclibs.motor/hbridge.mc

component L298N : HBRIDGE.DUAL.E
{
    partno = "L298N"
}
