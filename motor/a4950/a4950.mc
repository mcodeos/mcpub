# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// Real full-bridge DMOS PWM motor driver (A4950ELJTR-T, 8-pin SOICN with
// exposed thermal pad), transcribed from Allegro A4950-DS rev.2 (p.2 terminal
// list table + pin-out diagram, page-verified pin-by-pin). The exposed PAD
// carries no net name in the terminal list ("exposed pad for enhanced thermal
// dissipation"); the application note permits tying it to the star ground.
// VBB operating range 8-40V, peak output current 3.5A.
// Pins ride the mclibs single full-bridge shape.

use mclibs.motor/hbridge.mc

component A4950 : HBRIDGE.SINGLE
{
    partno = "A4950ELJTR-T"
}
