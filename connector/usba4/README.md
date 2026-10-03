# usba4

=============================================================================
 USB-A receptacle (4P). Schematic pin labels "+/D+/D-/-" are mapped to the
 standard TYPE-A pin numbers 1/3/2/4.
=============================================================================

Transcribed from the `mcs/120w` board project (component
`CONN.USBA4` inlined there); consumers keep instantiating the same
namespaced component name after `use usba4.usba4`.

## Source documents

- none


## Use

```toml
# project.toml
[dependencies]
usba4 = "0.1"
```

```text
use usba4.usba4

// instantiate: CONN.USBA4
```
