# ams1117

AMS1117 — 1A low-dropout linear regulator (LDO), SOT-223 (Advanced Monolithic Systems).

This package is the showcase face of an mcpub device package: one part per package, name follows the part; the abstract base `AMS1117` fixes the pin face, and the ordering face is expressed via the `[variants]` table (fixed-voltage 1.2/1.5/1.8/2.5/2.85/3.0/3.3/5.0 plus `AMS1117_ADJ` as a separate base).

## Pin essentials (verified from header comments)

Fixed-voltage version (SOT-223): `1=GND`, `2=Vout`, `3=Vin`, `TAB=Vout` — the thermal tab is **internally connected to Vout, not GND** (a common miswiring).
ADJ version as a separate base: pin 1 is the feedback sense `ADJ` (1.25V reference), not GND.

## Usage

```text
use ams1117.ams1117      # use by entry part name after installing; pick a specific voltage via its variant part name
```

```text
component psu_3v3 : AMS1117_3_3 { }
```

## Pack/install

```bash
mcc lib pack power/ams1117                 # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```

thin tier = manifest + entry + this README (the compilation face does not need the datasheet); the full tier additionally carries `ams1117.pdf` (sha256 cross-checked with three queries at install time).

## Search

ldo · linear-regulator · sot-223 · adj · 1a (pack.toml `keywords`, raw material for search-face ranking)
