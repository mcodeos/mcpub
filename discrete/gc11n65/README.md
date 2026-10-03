# gc11n65

=============================================================================
 GC11N65D5 — 650V NMOS, DFN 5x6
 No DFN5x6 member exists in the PKG enum, so `package` is left unset rather
 than forced to a wrong value.
=============================================================================

Transcribed from the `mcs/120w` board project (component
`NMOS.GC11N65` inlined there); consumers keep instantiating the same
namespaced component name after `use gc11n65.gc11n65`.

## Source documents

- none


## Use

```toml
# project.toml
[dependencies]
gc11n65 = "0.1"
```

```text
use gc11n65.gc11n65

// instantiate: NMOS.GC11N65
```
