# ndp1460qb

=============================================================================
 NDP1460QB — 40V 6A synchronous step-down DC/DC, QFN 5x5-20
 Datasheet: NDP1460 (bundled)

 The schematic symbol brings out 9 pins only (1=GND 6=VIN 10=BST 12=SW
 16=VFB 17=CSP 18=CSN1 19=CSN2 20=FS). The remaining datasheet pins
 (2/3=GND, 4/5=NC, 7/8=VIN, 9/11/15=NC, 13/14=SW) are not drawn on the
 schematic and get no instance connections — see the board's analyze
 notes. FS(20) floating selects the 130-300kHz range: legal no-connect.
=============================================================================

Transcribed from the `mcs/120w` board project (component
`BUCK.NDP1460QB` inlined there); consumers keep instantiating the same
namespaced component name after `use ndp1460qb.ndp1460qb`.

## Source documents

- `ndp1460.pdf` (datasheet)
- `ndp1460.txt` (doc)


## Use

```toml
# project.toml
[dependencies]
ndp1460qb = "0.1"
```

```text
use ndp1460qb.ndp1460qb

// instantiate: BUCK.NDP1460QB
```
