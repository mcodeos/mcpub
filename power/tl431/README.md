# tl431

=============================================================================
 TL431 — adjustable shunt voltage reference, SOT-23
 1=REF 2=ANODE 3=CATHODE.
=============================================================================

Transcribed from the `mcs/120w` board project (component
`REF.TL431` inlined there); consumers keep instantiating the same
namespaced component name after `use tl431.tl431`.

## Source documents

- none


## Use

```toml
# project.toml
[dependencies]
tl431 = "0.1"
```

```text
use tl431.tl431

// instantiate: REF.TL431
```
