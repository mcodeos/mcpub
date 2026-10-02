# stm32f205ret6

Real 64-pin general-purpose MCU (ST STM32F205RET6, LQFP64 10x10),
transcribed from the ST datasheet (DS6329 Rev 18; Figure 10 LQFP64
pinout p.41 cross-checked pin by pin against the Table 5/6 LQFP64
pin-definitions columns, 64/64 agree). Part number per the ordering
scheme (R = 512KB flash, E = 512KB, T = LQFP, 6 = -40 to 85C).
Standalone real part (ruling as us513_20_f): no LQFP64 abstract shape
exists in mclibs yet -- summarize the cluster before basing.

Pin names are the datasheet port names (PH0_OSC_IN / PH1_OSC_OUT per
DS6329; some third-party boards label pins 5/6 "PD0/PD1", an F103
carry-over -- the pin NUMBERS 5/6 agree everywhere). GPIO rows carry
the board-facing alternate names only (USB/SWD); the full AF map is
out of transcription scope. VCAP_1/VCAP_2 (pins 31/47) are the core
regulator capacitor terminals -- each needs its own 2.2uF to GND,
they are NOT extra VSS returns.

- 厂商: STMicroelectronics
- 类目/入口: 见 pack.toml（`mcc lib inspect <name>-*.mcl`）
- 检索标签: mcu, cortex-m3, stm32f2, lqfp64, 120mhz
- 附件: stm32f205ret6.pdf, stm32f205ret6.txt

## 使用

```text
use stm32f205ret6.stm32f205ret6    # 装包后按入口件名 use（变体面见 pack.toml [variants]）
```

```bash
mcc lib pack stm32f205ret6          # 出 .mcl + .thin.mcl
mcc lib install --from stm32f205ret6-0.1.0.mcl   # 装入 ~/.mcode/
```
