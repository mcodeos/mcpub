# tea2016t

=============================================================================
 TEA2016AAT — NXP digital configurable LLC + PFC combo controller, SO16
 Datasheet: TEA2016AAT Rev1.3 (bundled)
 Pin names follow the datasheet.
=============================================================================

Transcribed from the `mcs/120w` board project (component
`LLC.TEA2016T` inlined there); consumers keep instantiating the same
namespaced component name after `use tea2016t.tea2016t`.

## Source documents

- `tea2016aat.pdf` (datasheet)
- `tea2016aat.txt` (doc)


## Use

```toml
# project.toml
[dependencies]
tea2016t = "0.1"
```

```text
use tea2016t.tea2016t

// instantiate: LLC.TEA2016T
```
