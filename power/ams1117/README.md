# ams1117

AMS1117 — 1A low-dropout linear regulator (LDO), SOT-223 (Advanced Monolithic Systems).

本包是 mcpub 器件包的示范面：一包一件、名随件走，抽象基座 `AMS1117` 固定引脚面，
订购面以 `[variants]` 表达（1.2/1.5/1.8/2.5/2.85/3.0/3.3/5.0 固定压 ＋ `AMS1117_ADJ` 独立基座）。

## 引脚要点（头注释实证）

固定压版（SOT-223）：`1=GND`、`2=Vout`、`3=Vin`、`TAB=Vout` —— 散热片**内部连 Vout，不是 GND**（常见错接）。
ADJ 版独立基座：pin 1 是反馈采样 `ADJ`（1.25V 基准），不是 GND。

## 使用

```text
use ams1117.ams1117      # 装包后按入口件名 use；具体压取变体件名
```

```text
component psu_3v3 : AMS1117_3_3 { }
```

## 出包/装包

```bash
mcc lib pack power/ams1117                 # 出 ams1117-0.1.0.mcl + .thin.mcl
mcc lib install --from ams1117-0.1.0.mcl   # 落 ~/.mcode/ams1117@0.1.0/，index 重建
```

thin 档＝清单＋entry＋本 README（编译面不需要 datasheet）；full 档另带 `ams1117.pdf`（装时三查 sha256 对账）。

## 检索

ldo · linear-regulator · sot-223 · adj · 1a（pack.toml `keywords`，检索面排序原料）
