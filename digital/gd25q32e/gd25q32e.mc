# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// Real 32Mbit SPI NOR flash (GD25Q32ESIG, SOP8), extracted from the verified
// hbl board (U192 flash batch). Pins ride the mclibs SPI NOR shape.

use mclibs.digital/flash.mc

component FLASH.GD25Q32E : FLASH.SPI_NOR
{
    partno = "GD25Q32ESIG"
}
