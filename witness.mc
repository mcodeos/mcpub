# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// U357 grammar-witness file: part-identity faces that had zero corpus
// witness -- a power spec typed by the composite multiply unit
// UV.VOLT*UV.AMP (the divide form is witnessed by mcode res.tc), the
// dropout = _ undetermined spec value, and a single-quoted string note.
// Standalone witness: nothing in the library consumes this file; it loads
// only when a project references it directly.

use $::mcode.ifs

component WITNESS_LDO(vin::UV.VOLT, pd::UV.VOLT*UV.AMP = 1W)
{
    name = "LDO grammar witness"
    pins = [
        [1,3] = DC{VIN, GND}::DC(vin), ["Power input", "Ground"]
        2 = OUT                # Regulated output
    ]
    spec = [
        power = pd
        dropout = _
        note = 'dropout pending datasheet capture'
    ]
}
