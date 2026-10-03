# WORKFLOW — from chip datasheet to installed, verified pack

How a chip's materials become a device pack under `mcpub/`, get packed,
submitted, installed, and tested locally. The canonical design is
`mcd/doc/libmgr/registry-design.md` (§2 schema, §4 install checks); this
document is the operator's walk-through. Every gate below is enforced by
tooling — nothing here relies on reviewer diligence.

Rule sources under `mcd/doc` that govern the transcription steps (global canon,
this file only summarizes):

- `mcd/doc/library/mcode-authoring-checklist.md` — the library rule table
  (§2 file rules incl. English-only; §4 pin-face rules, incl. 4.14 "pins adopt
  interfaces wherever one fits; supplement `mcode/ifs` first when missing").
- `mcd/doc/library/library-ecosystem-design.md` — the four-layer ecosystem and
  the home-library test (what belongs in mcpub vs mclibs vs mcode).
- `mcd/doc/library/interface-inventory-design.md` — the `ifs/` interface
  inventory and gap plan; consult before inventing or supplementing interfaces.

```
datasheet ──▶ transcribe entry .mc ──▶ scaffold pack (pack.toml/README) ──▶ mcc lib pack
                                                                              │ gate: compiles clean
                                                                              ▼
              project use+check ◀── lib install --from *.mcl ◀── commit/publish (mcpub)
```

## 1. Materials

- Datasheet PDF goes into the pack directory (it will be a bundled attachment).
- **LAW (2026-10-03): a project-local datasheet folder is temporary staging
  only.** Every manual gathered during transcription lands strictly in its own
  lib pack — no loose copies stay behind in the project. When the packs are
  done, the staging folder is deleted (120w precedent).
- **Collect the materials as completely as you can**: beyond the datasheet, pull
  application notes, typical application circuits, test data (measurements /
  CSVs / reports) and supporting docs (user / reference manuals, errata sheets)
  into the pack directory; each becomes a `[[attachments]]` row with its sha256,
  and whatever genuinely cannot be obtained is recorded honestly — no placeholder
  material, an honest gap beats a fake (rule table §6.8).
- Extract a text layer once for evidence work: `pdftotext <part>.pdf <part>.txt`
  (keep the `.txt` in the pack as `kind = "doc"` — it is the searchable face).
- If the catalog page has no text layer, verify from rendered page images and say
  so in the entry header comments (see `ps1240p02bt` for the exemplar phrasing).

## 2. Transcribe the entry `.mc`

- One pack per part; **the pack name, directory name, and entry basename are all
  the part number**, lowercased, in the corpus's spelling (`ps1240p02bt`,
  `cmc6027_32t`, `drv8323s`). Function-prefixed names (`microphone_sip2`) are
  not accepted — rename before packing.
- Abstract base carries the pin face shared by all orderable SKUs; each orderable
  variant is a concrete inheriting it. Separate roles (e.g. fixed vs ADJ) get
  separate bases.
- Pins ride the `mclibs` abstraction shapes where one exists (adoption, not
  derivation — a library file cannot inherit an mcode base).
- **Pins adopt interfaces wherever one fits — this is a baseline requirement,
  not a nice-to-have.** A chip pin with a defined function (crystal, UART, SPI,
  I2C, SWD, power pair, …) adopts the corresponding `ifs` interface
  (`XTAL::XTAL(OSCILLATOR)`, `UART.TTL(DCE)`, `DBG.SWD(TARGET)`, `psnk…::DC`).
  Leave bare `io N = NAME` only for genuinely role-less pins (GPIO mux banks
  whose interface use is board-chosen; keep the datasheet alternate names as
  aliases). Pin addressing then goes through the interface member
  (`uC.XTAL.X1`); the brace form renames the members to the datasheet names
  (`RST{NRST}::RST(RECEIVER)` is addressed as `uC.RST.NRST`) — the trailing
  name list is display labels only, it does not rename.
  If the interface a pin needs does not exist in `mcode/ifs` yet, add it to the
  library first — do not silently transcribe the pin bare. Beyond adoption,
  pin rows carry pin-row attributes wherever the datasheet gives evidence
  (`@class`, `@pair`, `@exposed`, `@barrier`, `volt`); no evidence, no key
  — the rule table is `mcd/doc/library/mcode-authoring-checklist.md`
  §4.14–4.15 and the canon anchor is ee design-axioms **B7** (pin identity
  rides the interface family).
- Header comments are evidence lines: datasheet doc ID/rev, the tables/pages
  cross-checked, package, absolute maximums that shaped the pin book. The pack
  README is generated from these lines — write them for that purpose.
- Entry must compile standalone against `mclibs`/`mcode` — no references to
  files outside the pack.
- **Before adding a new part, ask whether a common abstract shape can be
  merged out — if yes, abstract it into `mclibs`; abstract wherever possible**
  (rule table §6.7; precedent: the RST source-side vacuum produced
  `mclibs/power/sup.mc`, the voltage-supervisor family, in the same batch as
  the first pack that needed it).
- **When typical-application-circuit material exists, additionally ship
  wrappers in the entry — both levels**: ① **circuit-block level**, the common
  peripheral blocks every project would otherwise re-type (decoupling groups,
  reset RC, crystal + load caps, BOOT strap, pull-up groups) as parameterized
  `func` wiring macros (precedent: us513_20_f `func Power` / `func I2C`);
  ② **module level**, typical-application `module` wrappers (minimal system,
  power tree, debug-port group) declaring the component and its surrounding
  wiring as one unit (precedent: the `module TLE7368E(psnk pwr…)` in the
  tle7368 entry). They ship with the pack so consumers call them in one line.
  Test = "appears in the typical application circuit + common"; wrappers come
  from the material, never invented (rule table §6.9).

## 3. Scaffold the pack

Directory contents: `pack.toml`, `<part>.mc`, `README.md`, datasheet pdf/txt.

`pack.toml` rules (full schema: registry-design.md §2):

- `[package]`: `format = "1"`, `name` == entry basename, `category`, `entry`.
- `version` is two-segment `MAJOR.MINOR` (three-segment legacy values still
  read; new writes are canonical two). **Every committed content change to a
  pack bumps its MINOR segment automatically** — the repo's pre-commit hook
  (`.githooks/pre-commit` → `bump.sh --staged`) does the bump and refreshes
  the bundled attachments' sha256, so a version always answers "which content
  is this?". A breaking interface-face change (pins/variants removed or
  reshaped) is a MAJOR bump and stays a human call. New packs start at `0.1`.
- `vendor` from evidence (`.mc` header / datasheet first page / txt cache);
  undocumented provenance is honestly `vendor = "unknown"`. `publisher = "mcode"`.
- `readme = "README.md"`. **README.md is English by default; a Chinese edition
  is a separate `<name>cn.md`** — the `readme` pointer names one entry document.
- `keywords`: lowercase short tokens (device family / package / function), e.g.
  `["ldo", "linear-regulator", "sot-223"]`. These feed registry search (P3).
- `[variants]`: one row per orderable face, `base` = a component name that
  exists in the entry source, `since` = the pack version that introduced it.
- `[[attachments]]`: one entry per bundled file with its true `sha256`
  (`shasum -a 256 <file>`). Comments in `pack.toml` are **English only**.
- `README.md` generation: the header comment block of the entry is the README's
  body; append vendor/keywords/attachment lines and the use/pack/install
  snippets. `power/ams1117/README.md` is the hand-written exemplar.

## 4. Pack (the gates)

```bash
mcc lib pack mcpub/<category>/<part>        # emits <part>-<ver>.mcl + .thin.mcl
```

Refuses to emit unless **all** hold:

1. entry compiles clean (in-process check gate — 编译不过不出包);
2. every `[variants]` base name is present on the entry source face;
3. every bundled attachment exists and its sha256 matches the manifest;
4. manifest structure is valid (format gate, 包名律, semver, …).

`mcc lib inspect <part>-<ver>.mcl` dumps the manifest from the archive
without touching disk — use it to eyeball coordinates/attachments before
submitting. Corpus-wide regression: sweep-pack every `*/*/pack.toml` dir;
the known-red set (rfsoc grammar debts) must not grow.

## 5. Submit

- Today (transitional): commit the pack to the `mcpub` repository — the
  corpus repo is the distribution source; consumers install from a packed
  `.mcl` or a checkout path.
- P3 (registry, not yet built): `mcc lib publish` uploads the `.mcl` to the
  registry, which serves `/lib/<name>.json` and thin/full tiers with
  publisher signatures. Until that lands, "submit to server" == git push.

## 6. Install and test locally

> **Law update (2026-10-03, registry P2 / b4506)**: third-party packs no
> longer land in the global data root — `--global` is refused for third
> party (the global root is official-mcode territory). Install runs
> **inside a consumer project** and vendors into
> `<project>/libs/<name>@<ver>/` (cargo-style, committable with the project).

```bash
cd <consumer-project>                        # must run inside a project
mcc lib install --from <part>-<ver>.mcl      # → <project>/libs/<part>@<ver>/
```

Install performs the three checks (§4.2): manifest present · entry present ·
sha256 per present attachment; unlisted archive files are refused. A thin
`.mcl` installs without attachments — the compile face never needs the
datasheet.

Verify in a project:

```toml
# project.toml — keep name/version/entry complete (a partial [project] makes
# the manifest load fail silently and dependencies go missing → E2051)
[project]
name = "try"
version = "0.1"
entry = "src/main.mc"

[dependencies]
<part> = "0.1"          # two-segment pin; resolved at load time, libs/ tier first
```

```text
// src/main.mc
use <part>.<part>        // dotted form follows the shared tier law: libs/
                         // first, then the global root (mc_use 4b, same
                         // face as the load side's resolve_lib_root_req)

module t
{
    <Variant> u1         // instantiate an orderable face
}
```

`mcc check` must report 0 errors / 0 warnings. That — plus one variant
instantiated per new `[variants]` row — is the acceptance bar for a pack.

## 7. Checklist

| # | item | gate |
|---|------|------|
| 1 | dir/entry/pack name == part number | 包名律 (manifest validation) |
| 2 | vendor evidence-based or `unknown` | corpus rule |
| 3 | README.md English default, `pack.toml` comments English | corpus rule |
| 4 | entry compiles clean | pack gate |
| 5 | variants' bases on entry face | pack gate |
| 6 | attachment sha256 true | pack + install check ③ |
| 7 | install lands, `use` resolves, check 0/0 | local loop |
