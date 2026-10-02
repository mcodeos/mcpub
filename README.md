# mcpub
some public components libs.

## Pack conventions (public corpus rules)

- One pack per part, one directory each: `pack.toml` + entry `.mc` + datasheet attachments.
  The pack name equals the entry file basename (包名律).
- `pack.toml` comments are **English only** — this is a public corpus; no bilingual comments.
- In-pack `README.md` is **English by default**; a Chinese edition lives in a separate
  `<name>cn.md` file. The `readme` field points at the single entry document.
- `keywords` are lowercase short tokens (device family / package / function) feeding
  registry-side search ranking (P3).
- Vendors are evidence-based (`.mc` headers / datasheets / txt caches); parts without
  documented provenance carry `vendor = "unknown"` honestly.
- Build gates: `mcc lib pack <dir>` refuses to emit unless the entry compiles clean,
  variants' bases exist on the entry face, and every bundled attachment's sha256 matches.
