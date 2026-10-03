# me6203a33

=============================================================================
 ME6203A33M3G — SOT-89 LDO, 3.3V fixed
 1=GND 2=VIN 3=VOUT, matching the schematic symbol and netlist.
=============================================================================

Transcribed from the `mcs/120w` board project (component
`LDO.ME6203A33` inlined there); consumers keep instantiating the same
namespaced component name after `use me6203a33.me6203a33`.

## Source documents

- none


## Use

```toml
# project.toml
[dependencies]
me6203a33 = "0.1"
```

```text
use me6203a33.me6203a33

// instantiate: LDO.ME6203A33
```
