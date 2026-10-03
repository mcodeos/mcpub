# mcpub
some public components libs.

## Pack conventions (public corpus rules)

- One pack per part, one directory each: `pack.toml` + entry `.mc` + datasheet attachments.
  The pack name equals the entry file basename (pack-name law).
- **English only, everywhere** — pack.toml comments, in-pack `README.md`, `.mc` comments
  and string text included. No Chinese editions (`<name>cn.md`); this is a public corpus.
- `keywords` are lowercase short tokens (device family / package / function) feeding
  registry-side search ranking (P3).
- Vendors are evidence-based (`.mc` headers / datasheets / txt caches); parts without
  documented provenance carry `vendor = "unknown"` honestly.
- Build gates: `mcc lib pack <dir>` refuses to emit unless the entry compiles clean,
  variants' bases exist on the entry face, and every bundled attachment's sha256 matches.
