# td1212

=============================================================================
 Common-mode choke TD1212-15mH (two windings 1-2 / 3-4). No matching member
 exists in the PKG enum — board-level part.
=============================================================================

Transcribed from the `mcs/120w` board project (component
`CMCH.TD1212` inlined there); consumers keep instantiating the same
namespaced component name after `use td1212.td1212`.

## Source documents

- none


## Use

```toml
# project.toml
[dependencies]
td1212 = "0.1"
```

```text
use td1212.td1212

// instantiate: CMCH.TD1212
```
