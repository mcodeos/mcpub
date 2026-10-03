# tea2016aat

=============================================================================
 TEA2016AAT — NXP digital configurable LLC + PFC combo controller, SO16
 Datasheet: TEA2016AAT Rev1.3 (bundled)
 Pin names follow the datasheet.
=============================================================================

Transcribed from the `mcs/120w` board project (component
`LLC.TEA2016AAT` inlined there); consumers keep instantiating the same
namespaced component name after `use tea2016aat.tea2016aat`.

## Source documents

- `tea2016aat.pdf` (datasheet)
- `tea2016aat.txt` (doc)


## Use

```toml
# project.toml
[dependencies]
tea2016aat = "0.1"
```

```text
use tea2016aat.tea2016aat

// instantiate: LLC.TEA2016AAT
```
