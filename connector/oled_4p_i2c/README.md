# oled_4p_i2c

=============================================================================
 OLED display header — 4P (SCL/SDA/VDD/GND), board-level anonymous part
 (part number OLED-4P-I2C, a generic 4-pin I2C OLED module header).
=============================================================================

Transcribed from the `mcs/120w` board project (component
`OLED.HDR4` inlined there); consumers keep instantiating the same
namespaced component name after `use oled_4p_i2c.oled_4p_i2c`.

## Source documents

- none


## Use

```toml
# project.toml
[dependencies]
oled_4p_i2c = "0.1"
```

```text
use oled_4p_i2c.oled_4p_i2c

// instantiate: OLED.HDR4
```
