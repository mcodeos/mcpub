# bzt52c

=============================================================================
 BZT52C — Zener diode family, SOD-323 (symbol: 2=K, 1/3 = common anode)
 The breakdown voltage follows the order-code suffix (Z4/Z3/Z6 = 3V3,
 Z5 = 12V, Z1/Z1A/Z1B = 6V2; see the instance rows on the source board).
=============================================================================

Transcribed from the `mcs/120w` board project (component
`ZENER.BZT52C` inlined there); consumers keep instantiating the same
namespaced component name after `use bzt52c.bzt52c`.

## Source documents

- none


## Use

```toml
# project.toml
[dependencies]
bzt52c = "0.1"
```

```text
use bzt52c.bzt52c

// instantiate: ZENER.BZT52C
```
