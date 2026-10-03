# sgm2019

Real 3.3V LDO (SGM2019-3.3YN5G/TR, SOT23-5), extracted from the verified
hbl board (U192 power batch). Pins ride the mclibs SOT23-5 LDO shape;
grade spec windows live here (outside the variant data lock).

- Vendor: SGMICRO
- Category/entry: see pack.toml (`mcc lib inspect <name>-*.mcl`)
- Search tags: ldo, linear-regulator, sot-23-5
- Attachments: sgm2019_33yn5g.pdf

## Usage

```text
use sgm2019.sgm2019    # after installing the pack, use by the entry part name (see pack.toml [variants] for the variant face)
```

```bash
mcc lib pack sgm2019          # produces .mcl + .thin.mcl
mcc lib install --from <name>-<version>.mcl    # vendors into <project>/libs/
```
