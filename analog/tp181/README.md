# tp181

=============================================================================
 TP181 — 3PEAK zero-drift bidirectional current-sense amplifier, SC70-6
 (gain 50/100/200 depending on grade)
 Datasheet: TP181 (bundled)

 The datasheet pin names V+/IN+/IN- contain characters that are illegal in
 identifiers, so they are carried as VCC/INP/INN (datasheet names kept in
 the row comments).
=============================================================================

Transcribed from the `mcs/120w` board project (component
`AMP.TP181` inlined there); consumers keep instantiating the same
namespaced component name after `use tp181.tp181`.

## Source documents

- `tp181.pdf` (datasheet)
- `tp181.txt` (doc)


## Use

```toml
# project.toml
[dependencies]
tp181 = "0.1"
```

```text
use tp181.tp181

// instantiate: AMP.TP181
```
