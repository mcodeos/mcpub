# 10d471

=============================================================================
 10D471 metal-oxide varistor (across L-N on the source board).
 Pack name follows the part number, lowercased; digit-leading `use` segments
 are accepted by the mcode parser.
=============================================================================

Transcribed from the `mcs/120w` board project (component
`VARISTOR.MOV` inlined there); consumers keep instantiating the same
namespaced component name after `use 10d471.10d471`.

## Source documents

- none


## Use

```toml
# project.toml
[dependencies]
10d471 = "0.1"
```

```text
use 10d471.10d471

// instantiate: VARISTOR.MOV
```
