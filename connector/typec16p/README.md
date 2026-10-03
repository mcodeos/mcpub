# typec16p

=============================================================================
 TYPE-C-20-V receptacle (16P, horizontal; A1/A12 + 15-18 = shell ground,
 A8/B8 = SBU unused on this board).
=============================================================================

Transcribed from the `mcs/120w` board project (component
`CONN.TYPEC16P` inlined there); consumers keep instantiating the same
namespaced component name after `use typec16p.typec16p`.

## Source documents

- none


## Use

```toml
# project.toml
[dependencies]
typec16p = "0.1"
```

```text
use typec16p.typec16p

// instantiate: CONN.TYPEC16P
```
