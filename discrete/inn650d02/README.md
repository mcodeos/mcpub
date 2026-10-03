# inn650d02

=============================================================================
 INN650D02 — GaN HEMT, DFN 8x8
 No DFN8x8 member exists in the PKG enum, so `package` is left unset rather
 than forced to a wrong value.
=============================================================================

Transcribed from the `mcs/120w` board project (component
`NMOS.INN650D02` inlined there); consumers keep instantiating the same
namespaced component name after `use inn650d02.inn650d02`.

## Source documents

- none


## Use

```toml
# project.toml
[dependencies]
inn650d02 = "0.1"
```

```text
use inn650d02.inn650d02

// instantiate: NMOS.INN650D02
```
