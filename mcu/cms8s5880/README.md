# cms8s5880

=============================================================================
 CMS8S5880 — Cmsemicon enhanced 1T 8051 MCU, 2.1V-4.5V, SSOP20
 Datasheet: CMS8S588x Rev1.01 (bundled)

 SSOP20 pin shape, transcribed from the 120W board's MCU page and verified
 against the datasheet. Row comments record the source-board nets.
=============================================================================

Transcribed from the `mcs/120w` board project (component
`MCU.CMS8S5880` inlined there); consumers keep instantiating the same
namespaced component name after `use cms8s5880.cms8s5880`.

## Source documents

- `cms8s588x.pdf` (datasheet)
- `cms8s588x.txt` (doc)


## Use

```toml
# project.toml
[dependencies]
cms8s5880 = "0.1"
```

```text
use cms8s5880.cms8s5880

// instantiate: MCU.CMS8S5880
```
