# lp3220ab5f

Real buck converter (LP3220AB5F, SOT23-5), extracted from the verified hbl
board (U192 power batch). Pins ride the mclibs SOT23-5 buck shape; grade
spec windows live here (outside the variant data lock).

- Vendor: unknown
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: dcdc, converter, sot-23

## Usage

```text
use lp3220ab5f.lp3220ab5f    # after installing the pack, use by the entry part name (see pack.toml [variants] for the variant face)
```

```bash
mcc lib pack lp3220ab5f          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
