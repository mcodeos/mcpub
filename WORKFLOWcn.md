# WORKFLOW（中文版）—— 从芯片资料到装包验证的全流程

说明 `mcpub/` 下一个器件包怎么从芯片资料生成、打包、提交、本地安装测试。
设计正典在 `mcd/doc/libmgr/registry-design.md`（§2 清单 schema、§4 装时三查）；
本文是操作者视角的走查。下面每道闸都是工具强制的，不靠人工自觉。

```
datasheet ──▶ 转写 entry .mc ──▶ 组包（pack.toml/README）──▶ mcc lib pack
                                                                │ 闸：编译不过不出包
                                                                ▼
            工程 use+check ◀── lib install --from *.mcl ◀── 提交（mcpub 仓 / P3 registry）
```

## 1. 资料

- datasheet PDF 直接放进包目录（会成为 bundled 附件）。
- 资料面正典在 mcd：**库规范总清单 §2.5 器件资料归包律**——工程内 datasheet
  目录只是临时转写工作区；每份手册严格归入各自 lib 包，包齐即删临时目录。
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
- 头注释就是证据行：datasheet 文档号/版次、逐项核对过的表格页码、封装、
  决定引脚簿的绝对极限参数。README 由这些行生成——按这个用途写。
- entry 必须对 `mclibs`/`mcode` 独立编译通过——不引用包外任何文件。

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
