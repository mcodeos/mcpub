# WORKFLOW（中文版）—— 从芯片资料到装包验证的全流程

说明 `mcpub/` 下一个器件包怎么从芯片资料生成、打包、提交、本地安装测试。
设计正典在 `mcd/doc/libmgr/registry-design.md`（§2 清单 schema、§4 装时三查）；
本文是操作者视角的走查。下面每道闸都是工具强制的，不靠人工自觉。

转写各步受 `mcd/doc` 下的全局规则约束（正典在 mcd，本文只摘要）：

- `mcd/doc/library/mcode-authoring-checklist.md` —— 库规范总清单
  （§2 文件面含英文律；§4 引脚面撰写律，含 4.14「能用接口全用接口、
  缺接口先补库」）；
- `mcd/doc/library/library-ecosystem-design.md` —— 四层生态与归库判据
  （什么进 mcpub、什么归 mclibs/mcode）；
- `mcd/doc/library/interface-inventory-design.md` —— `ifs/` 接口清单与缺口
  规划；补接口之前先查这本账。

```
datasheet ──▶ 转写 entry .mc ──▶ 组包（pack.toml/README）──▶ mcc lib pack
                                                                │ 闸：编译不过不出包
                                                                ▼
            工程 use+check ◀── lib install --from *.mcl ◀── 提交（mcpub 仓 / P3 registry）
```

## 1. 资料

- datasheet PDF 直接放进包目录（会成为 bundled 附件）。
- **律（2026-10-03）：工程内 datasheet 目录只是临时转写工作区。** 转写期间
  收集的每一份手册落地时严格归入各自的 lib 包——工程里不留散本；包齐即删
  临时目录（120w 先例）。
- **建新芯片包，资料尽量收集全**：datasheet 之外，application note、
  **典型应用电路**、测试数据（实测记录/csv/报告）、说明文档（用户手册/
  参考手册/勘误）等一并收进包目录；每件进 `[[attachments]]` 带 sha256，
  拿不到的如实留痕（不造假、不占位——证据面宁可诚实缺口）。
- 先抽一次文本层做证据工作：`pdftotext <part>.pdf <part>.txt`
  （`.txt` 留在包里，`kind = "doc"`——它是可检索面）。
- 目录页没有文本层的，用渲染页图逐页核对，并在 entry 头注释里如实注明
  （范例措辞见 `ps1240p02bt`）。

## 2. 转写 entry `.mc`

- 一包一件；**包名、目录名、entry 文件名三者都是料号**，小写、按语料拼法
  （`ps1240p02bt`、`cmc6027_32t`、`drv8323s`）。功能前缀名
  （`microphone_sip2`）不收——出包前先改名。
- 抽象基座承载全部订购 SKU 共享的引脚面；每个订购变体是一个继承它的具体件。
  角色级差异（如固定压 vs ADJ）另立基座。
- 引脚随 `mclibs` 抽象形走（是"采纳"不是"继承"——库文件不能继承 mcode 基座）。
- **引脚能用接口就全用接口——这是基本要求，不是加分项。** 有确定功能的芯片脚
  （晶振、UART、SPI、I2C、SWD、电源对……）一律采纳对应 `ifs` 接口
  （`XTAL::XTAL(OSCILLATOR)`、`UART.TTL(DCE)`、`DBG.SWD(TARGET)`、`psnk…::DC`）。
  只有真正无角色的脚才留裸 `io N = NAME`（板级才定用途的 GPIO 复用组，
  数据手册复用名留作别名）。采纳后引脚经接口成员寻址（`uC.XTAL.X1`），
  数据手册脚名作成员名用**花括号形**（`RST{NRST}::RST(RECEIVER)` 寻址为
  `uC.RST.NRST`）——行尾名称列表只是显示标签，不改名。若所需的接口在
  `mcode/ifs` 还没定义，先补库，再转写——不许悄悄裸抄。采纳之外，**引脚行 @attr 能加尽加**：
  数据手册给得出证据的 PinRow 键（`@class`/`@pair`/`@exposed`/`@barrier`/`volt`）
  全带上；无证据不硬加——律表见 `mcd/doc/library/mcode-authoring-checklist.md`
  §4.14–4.15，正典锚点＝ee/design-axioms **B7**（引脚身份接口化律）。
- 头注释就是证据行：datasheet 文档号/版次、逐项核对过的表格页码、封装、
  决定引脚簿的绝对极限参数。README 由这些行生成——按这个用途写。
- entry 必须对 `mclibs`/`mcode` 独立编译通过——不引用包外任何文件。
- **新增器件先判抽象：能合并出底层通用抽象形的，抽象出来放 `mclibs`，
  能做尽做**（律表 §6.7；先例：RST SOURCE 侧零语料 ⇒ 同批落地
  `mclibs/power/sup.mc` 电压监督族）。
- **有典型应用电路资料的，entry 额外写封装，两级都要**：① **电路块级**——
  常用外围电路块（去耦组、复位 RC、晶振＋负载电容、BOOT strap、上拉组……）
  提取成带参 `func` 接线宏（先例＝us513_20_f `func Power`/`func I2C`）；
  ② **模块级**——典型 `module` 封装（最小系统、电源树、调试口组……），
  组件＋外围接法一体声明（先例＝tle7368 的 `module TLE7368E`）。随包分发，
  消费者一行调用、不再逐项目重抄。判据＝「典型应用电路里出现＋公用」；
  封装从资料来，不发明电路（律表 §6.9）。

## 3. 组包

目录内容：`pack.toml`、`<part>.mc`、`README.md`、datasheet pdf/txt。

`pack.toml` 规则（全 schema 见 registry-design.md §2）：

- `[package]`：`format = "1"`，`name` == entry basename，`category`、`entry`。
- `version` 为两段 `MAJOR.MINOR`（旧三段读取兼容，新写入归一化为两段）。
  **包的每次内容变更，MINOR 段自动加一**——仓内 pre-commit 钩子
  （`.githooks/pre-commit` → `bump.sh --staged`）负责递增并刷新 bundled
  附件的 sha256，版本号始终回答"这是哪份内容"。破坏接口面的变更
  （引脚/变体删除或改形）是 MAJOR 位，由人裁。新包从 `0.1` 起步。
- `vendor` 从证据来（`.mc` 头 / datasheet 首页 / txt 缓存）；无实证的如实
  `vendor = "unknown"`。`publisher = "mcode"`。
- `readme = "README.md"`。**README.md 缺省英文；中文版另立 `<name>cn.md`**——
  `readme` 指针只指一个入口文档。
- `keywords`：小写短词（器件族/封装/功能），如
  `["ldo", "linear-regulator", "sot-223"]`。检索面（P3）的排序原料。
- `[variants]`：每个订购面一行，`base` = entry 源面在位的 component 名，
  `since` = 引入该变体的包版本。
- `[[attachments]]`：每个 bundled 文件一条，带真实 `sha256`
  （`shasum -a 256 <file>`）。**pack.toml 内注释一律英文**。
- README 生成：entry 的头注释块即 README 正文；追加厂商/标签/附件行和
  use/pack/install 片段。`power/ams1117/README.md` 是手写示范面。

## 4. 打包（各道闸）

```bash
mcc lib pack mcpub/<category>/<part>        # 出 <part>-<ver>.mcl + .thin.mcl
```

以下**全部**成立才出档，否则拒：

1. entry 编译干净（进程内 check 闸——编译不过不出包）；
2. `[variants]` 每行 base 名在 entry 源面在位；
3. bundled 附件逐个在位且 sha256 与清单相符；
4. 清单结构合法（format 闸、包名律、semver……）。

`mcc lib inspect <part>-<ver>.mcl` 纯检视档内清单（不落盘）——提交前过目
坐标/附件面。全仓回归：对每个 `*/*/pack.toml` 目录跑一遍 pack；
已知红名单（rfsoc 语法债）不得扩大。

## 5. 提交

- 现在（过渡期）：把包提交进 `mcpub` 仓——语料仓就是分发源；消费者从
  `.mcl` 档或 checkout 路径安装。
- P3（registry，未建）：`mcc lib publish` 把 `.mcl` 传 registry，由它出
  `/lib/<name>.json` 与 thin/full 分档＋发布者签名。落地之前，"提交服务器"
  就是 git push。

## 6. 本地安装测试

```bash
mcc lib install --from <part>-<ver>.mcl      # → ~/.mcode/<part>@<ver>/，index 重建
```

装时三查（§4.2）：清单在场 · entry 在场 · sha256 逐在场附件对账；
档内未列名文件拒收。thin 档无附件也能装——编译面不需要 datasheet。

工程验证：

```toml
# project.toml —— name/version/entry 三字段要齐（[project] 残缺会让清单
# 静默加载失败、依赖丢失 → 误报 E2051）
[project]
name = "try"
version = "0.1"
entry = "src/main.mc"

[dependencies]
<part> = "0.1.0"
```

```text
// src/main.mc
use <part>.<part>        // 点形式解析 ~/.mcode 下的 <part>@<ver>

module t
{
    <Variant> u1         // 实例化一个订购面
}
```

`mcc check` 须 0 错 0 警。这——加上每个新 `[variants]` 行至少实例化一个
变体——就是一个包的验收线。

## 7. 核对单

| # | 项 | 闸 |
|---|------|------|
| 1 | 目录/entry/包名 == 料号 | 包名律（清单校验） |
| 2 | vendor 有实证或如实 `unknown` | 语料规则 |
| 3 | README.md 缺省英文、pack.toml 注释英文 | 语料规则 |
| 4 | entry 编译干净 | pack 闸 |
| 5 | variants 的 base 在 entry 源面 | pack 闸 |
| 6 | 附件 sha256 真值 | pack ＋ 装时三查③ |
| 7 | 装得上、use 得到、check 0/0 | 本地闭环 |
