# ct1019

=============================================================================
 CT1019 — optocoupler, SOP4
 The original schematic drew two symbols sharing refdes U2; mapped here as
 1=A 2=K 3=C 4=E.
=============================================================================

Transcribed from the `mcs/120w` board project (component
`OPTO.CT1019` inlined there); consumers keep instantiating the same
namespaced component name after `use ct1019.ct1019`.

## Source documents

- none


## Use

```toml
# project.toml
[dependencies]
ct1019 = "0.1"
```

```text
use ct1019.ct1019

// instantiate: OPTO.CT1019
```
