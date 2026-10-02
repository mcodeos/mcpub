# lis2dh12

LIS2DH12 — ST 3-axis accelerometer, "femto" family, LGA-12 (2x2mm)
Datasheet: ST LIS2DH12 Rev6, DocID025056 (same directory)

LGA-12 pin shape, verified pin-by-pin against Rev6 Table 2:
1  = SPC     I2C serial clock (SCL) / SPI serial port clock
2  = CS      SPI enable / mode select: 1 = I2C enabled, 0 = SPI
3  = SA0     SPI SDO / I2C address LSB (internally pulled up);
tied GND -> 7-bit address 0x18 (SAD = 001100xb)
4  = SDI     I2C SDA / SPI data input
5  = RES     reserved — connect to GND per datasheet
6  = GND     7 = GND   8 = GND
9  = VDD     power supply, 1.7V-3.6V
10 = VDD_IO  I/O supply
11 = INT2    interrupt output 2
12 = INT1    interrupt output 1
NOTE: pin 11 is INT2 and pin 12 is INT1 — easy to swap from memory.

- 厂商: STMicroelectronics
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: accelerometer, 3-axis, imu, i2c, spi, mems
- 附件: lis2dh12.pdf, lis2dh12.txt

## 使用

```text
use lis2dh12.lis2dh12    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack lis2dh12          # 出 .mcl + .thin.mcl
mcc lib install --from lis2dh12-0.1.0.mcl   # 装入 ~/.mcode/
```
