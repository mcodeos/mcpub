// Copyright (c) 2026 MCode
//
// Licensed under the Apache License, Version 2.0.

// =============================================================================
//  PFC inductor, 150uH (symbol: winding on 3-4 plus pin 1 = core/shield pin
//  to AGND; verified against the datasheet PDF during transcription).
// =============================================================================
component IND.PFC150UH
{
    partno = "PFC-150UH"

    pins = [
        io 3 = IN
        psrc 4 = OUT
        io 1 = SHLD
    ]
}
