# WORKFLOW — from chip datasheet to installed, verified pack

How a chip's materials become a device pack under `mcpub/`, get packed,
submitted, installed, and tested locally. The canonical design is
`mcd/doc/libmgr/registry-design.md` (§2 schema, §4 install checks); this
document is the operator's walk-through. Every gate below is enforced by
tooling — nothing here relies on reviewer diligence.

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
- Header comments are evidence lines: datasheet doc ID/rev, the tables/pages
  cross-checked, package, absolute maximums that shaped the pin book. The pack
  README is generated from these lines — write them for that purpose.
- Entry must compile standalone against `mclibs`/`mcode` — no references to
  files outside the pack.

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

```bash
mcc lib install --from <part>-<ver>.mcl      # → ~/.mcode/<part>@<ver>/, index rebuilt
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
<part> = "0.1.0"
```

```text
// src/main.mc
use <part>.<part>        // dotted form resolves <part>@<ver> in ~/.mcode

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
