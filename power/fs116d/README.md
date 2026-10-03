# fs116d

=============================================================================
 FS116D — FastSOC multi-protocol Type-A quick-charge controller, SSOP10
 Datasheet: FS116D V1.1 202410 (bundled)
=============================================================================

Transcribed from the `mcs/120w` board project (component
`PDQC.FS116D` inlined there); consumers keep instantiating the same
namespaced component name after `use fs116d.fs116d`.

## Source documents

- `fs116d.pdf` (datasheet)
- `fs116d.txt` (doc)


## Use

```toml
# project.toml
[dependencies]
fs116d = "0.1"
```

```text
use fs116d.fs116d

// instantiate: PDQC.FS116D
```
