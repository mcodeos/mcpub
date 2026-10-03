# fs8611b

=============================================================================
 FS8611B — FastSOC Type-C PD controller, SSOP10
 Datasheet: FS8611B V1.x (bundled). No SSOP10 member exists in the PKG
 enum, so `package` is left unset rather than forced to a wrong value.
=============================================================================

Transcribed from the `mcs/120w` board project (component
`PDCTL.FS8611B` inlined there); consumers keep instantiating the same
namespaced component name after `use fs8611b.fs8611b`.

## Source documents

- `fs8611b.pdf` (datasheet)
- `fs8611b.txt` (doc)


- `FS8611A.pdf`/`FS8611A.txt` (doc) — family order-code FS8611A, same die as FS8611B
- `FS8611G.pdf`/`FS8611G.txt` (doc) — family order-code FS8611G

## Use

```toml
# project.toml
[dependencies]
fs8611b = "0.1"
```

```text
use fs8611b.fs8611b

// instantiate: PDCTL.FS8611B
```
