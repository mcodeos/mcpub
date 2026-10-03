# pfc150uh

=============================================================================
 PFC inductor, 150uH (symbol: winding on 3-4 plus pin 1 = core/shield pin
 to AGND; verified against the datasheet PDF during transcription).
=============================================================================

Transcribed from the `mcs/120w` board project (component
`IND.PFC150UH` inlined there); consumers keep instantiating the same
namespaced component name after `use pfc150uh.pfc150uh`.

## Source documents

- none


## Use

```toml
# project.toml
[dependencies]
pfc150uh = "0.1"
```

```text
use pfc150uh.pfc150uh

// instantiate: IND.PFC150UH
```
