# jmup_0_6mm

=============================================================================
 JMUP jumper (0.6mm pitch, 2 pins). On the source board: J1 in series with
 the LLC output to VBUS; J2's both pins tied to VSS.
=============================================================================

Transcribed from the `mcs/120w` board project (component
`CONN.JMUP2` inlined there); consumers keep instantiating the same
namespaced component name after `use jmup_0_6mm.jmup_0_6mm`.

## Source documents

- none


## Use

```toml
# project.toml
[dependencies]
jmup_0_6mm = "0.1"
```

```text
use jmup_0_6mm.jmup_0_6mm

// instantiate: CONN.JMUP2
```
