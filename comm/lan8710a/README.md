# lan8710a

Real Ethernet 10/100 PHY transceiver (LAN8710A / LAN8710Ai, 32-QFN 5x5mm),
transcribed from Microchip DS00002164B Rev. B (pinout Table 2-8 p.14
page-verified against the package drawing p.6; pin multiplexing Table 3-2
p.26; signal directions §3.4 p.25; straps §3.7 p.29; power Table 2-7 p.13;
external components Figure 3-13 p.39; twisted-pair interface Figure 3-15
p.41). Pins ride the mclibs `XCVR.ETH` Ethernet PHY shape.

- Vendor: Microchip
- Category / entry: see pack.toml (`mcc lib inspect lan8710a-*.mcl`)
- Keywords: ethernet, phy, rmii, mii, auto-mdix, qfn32
- Attachments: lan8710a.pdf, lan8710a.txt

## Highlights

- 10BASE-T / 100BASE-TX PHY, MII or RMII MAC interface, mode selected by the
  RXD2/RMIISEL strap at reset.
- HP Auto-MDIX (crossover sensing), internal 1.2V core regulator
  (REGOFF disables it for boards with an external 1.2V rail).
- Single 3.3V supply for the analog port (VDD1A/VDD2A 3.0-3.6V); variable
  I/O ring VDDIO 1.6-3.6V.
- 25MHz crystal (MII); RMII requires 50MHz REF_CLK into XTAL1/CLKIN — the
  DS does not document a 25-to-50MHz multiplier, so boards must source the
  50MHz clock externally in RMII mode.
- SMI management (MDC/MDIO, PHYAD[2:0] straps) with pull-up on MDIO.

## Use

```text
use lan8710a.lan8710a    # after install; orderable faces in pack.toml [variants]
```

```bash
mcc lib pack lan8710a                        # emit .mcl + .thin.mcl
mcc lib install --from lan8710a-0.1.mcl      # install inside a consumer project
```
