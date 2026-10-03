# atq237

=============================================================================
 LLC transformer ATQ23.7 (700uH; primary 4->1, pin 3 = shield/core to AGND,
 two secondary windings 16-17 and 11-12).
=============================================================================

Transcribed from the `mcs/120w` board project (component
`TRAN.ATQ237` inlined there); consumers keep instantiating the same
namespaced component name after `use atq237.atq237`.

## Source documents

- none


## Use

```toml
# project.toml
[dependencies]
atq237 = "0.1"
```

```text
use atq237.atq237

// instantiate: TRAN.ATQ237
```
