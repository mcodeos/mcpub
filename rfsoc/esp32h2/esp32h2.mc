# ESP32-H2 (2.4 GHz IEEE 802.15.4 / Bluetooth LE 5.3 SoC) -- corpus twin of
# efr32mg21.mc and cc2530.mc, written under the same ruling set so the form
# can be compared across vendors:
#   ruling 25  axis words carry parameters: tx(20dBm), modem_sleep(96MHz)
#   ruling 26  value lists are kvalue dicts [typ: ..., max: ...]; axis points
#              and test conditions ride the value as value@condition
#   ruling 27  hot/return pins share one face: [RAIL, GND] pair form, pin
#              groups ordered by rail name
#   ruling 28  single call form: key = Meta(axis..., value = literal)
#   ruling 29  drive-class axis is one word ma with a current argument:
#              ma(20mA) -- compound tokens (ma20 / ma40) are retired
# Source: ESP32-H2 Series Datasheet v1.3 (Espressif, 2026-07-03, Chinese
# edition), extracted with pdftotext -layout (cache: esp32h2.txt, page-indexed
# esp32h2_paged.txt). Datasheet page number = PDF page number for this
# document (footer cross-checked on pp.40-49); pages cited per row.
# QFN32 4x4 mm, 33 terminals: pin 33 is the GND center pad (Fig 2-1 p.12,
# Table 2-1 p.13-14, Appendix A p.60). FAMILY-level file: the OPN picks the
# in-package flash (2 MB / 4 MB, Table 1-1 p.11) -- not a pin fact, survives
# only as this comment. Ident note: the part name carries a hyphen, so the
# component id is spelled ESP32_H2.

@source(esp32h2.pdf, "ESP32-H2 Series Datasheet v1.3", vendor = Espressif)

# -- §1 metas --------------------------------------------------------------
# The schema lives in mcode/meta/ (ruling 13: one authority face per
# domain) -- this file only REFERENCES it (one value one source):
#   core.mc   receiver / absmax / temp_range / temp_sense / rc_osc
#   power.mc  supply_range / current_draw
#   level.mc  drive_level (kind = ma(N mA), ruling 29) / io_leak / io_pull
#   radio.mc  radio_band / radio_rate / rf_sens / rf_pout / rf_maxin /
#             rf_reject / rf_block / rf_evm / rf_phase
component ESP32_H2 {
    pins = [

        # -- Battery/analog rail VBAT (pin 18), return = GND pad (pin 33).
        #    Analog domain OR direct battery feed (Table 2-7, p.20); also
        #    feeds pins 14-16 together with VDDA_PMU (see that face).
        psnk [[18], [33]] = [VBAT, GND]::DC(
            vin  = supply_range(3V ~ 3.6V)                   @ds(p=49, trust=max)   # Table 5-2, typ 3.3 V
            vmax = absmax(-0.3V ~ 3.6V)                      @ds(p=49, trust=max)   # Table 5-1 supply pins
            # FLAG: the absmax ceiling (3.6 V, Table 5-1) EQUALS the
            # recommended ceiling (Table 5-2) -- zero absolute-maximum
            # headroom, transcribed as printed.
        )

        # -- Main analog/RF rail VDD3P3 (pins 1, 2, 27, 30, 31), return =
        #    GND pad. Whole-chip current budget rides THIS face: Espressif
        #    gives no per-rail draw split (every table is measured on the
        #    3.3 V single supply), so splitting the modes across rails would
        #    be invention -- the conservative whole-budget-on-one-rail shape
        #    cc2530 used (same honest gap, not repeated on the other faces).
        #    FLAG: Table 2-7 (p.20) lists only pins 1/2/27 as VDD3P3 while
        #    Fig 2-1 (p.12), Table 2-1 (p.13) and Appendix A (p.60) show five
        #    VDD3P3 pins -- 30/31 flank the ANT pin and are transcribed as
        #    VDD3P3 per the pin tables; Table 2-7's omission is unexplained
        #    in the datasheet.
        psnk [[1, 2, 27, 30, 31], [33]] = [VDD3P3, GND]::DC(
            vin  = supply_range(3V ~ 3.6V)                   @ds(p=49, trust=max)   # Table 5-2, typ 3.3 V
            vmax = absmax(-0.3V ~ 3.6V)                      @ds(p=49, trust=max)   # Table 5-1
            idraw = [
                # -- Active, RF on: BLE (Table 5-6, p.51). The table column
                #    is "peak (mA)" -- one value per row, so the dict slot
                #    is the QUANTITY word peak, not a trust ladder.
                current_draw(mode = tx(20dBm), value = [peak: 140mA])
                                @ds(p=51, trust=max, cond="BLE, 3.3 V, 25 C, measured at RF interface, TX 100% duty")
                current_draw(mode = tx(9dBm), value = [peak: 60mA])
                                @ds(p=51, trust=max, cond="BLE")
                current_draw(mode = tx(0dBm), value = [peak: 36mA])
                                @ds(p=51, trust=max, cond="BLE")
                current_draw(mode = tx(-24dBm), value = [peak: 24mA])
                                @ds(p=51, trust=max, cond="BLE")
                current_draw(mode = rx, value = [peak: 24mA])
                                @ds(p=51, trust=max, cond="BLE")
                # -- Active, RF on: IEEE 802.15.4 (Table 5-7, p.51). Same
                #    axis words as the BLE rows, protocol rides the cond --
                #    partial axis binding (protocol is not an axis
                #    argument), the same collapse cc2530 filed as 1a2.
                current_draw(mode = tx(20dBm), value = [peak: 140mA])
                                @ds(p=51, trust=max, cond="802.15.4")
                current_draw(mode = tx(9dBm), value = [peak: 60mA])
                                @ds(p=51, trust=max, cond="802.15.4")
                current_draw(mode = tx(0dBm), value = [peak: 36mA])
                                @ds(p=51, trust=max, cond="802.15.4")
                current_draw(mode = tx(-24dBm), value = [peak: 24mA])
                                @ds(p=51, trust=max, cond="802.15.4")
                current_draw(mode = rx, value = [peak: 25mA])
                                @ds(p=51, trust=max, cond="802.15.4")
                # -- Modem-sleep (Table 5-8, p.51). THREE conditions per
                #    frequency (CPU working/idle, peripheral clocks all
                #    off/on): the frequency rides the axis word, the other
                #    two ride value@condition envelope points -- more
                #    partial axis binding, same 1a2 debt.
                current_draw(mode = modem_sleep(96MHz), value = [10mA@periph-clk-off, 17mA@periph-clk-on])
                                @ds(p=51, trust=max, cond="CPU working")
                current_draw(mode = modem_sleep(96MHz), value = [6mA@periph-clk-off, 13mA@periph-clk-on])
                                @ds(p=51, trust=max, cond="CPU idle")
                current_draw(mode = modem_sleep(64MHz), value = [8mA@periph-clk-off, 13mA@periph-clk-on])
                                @ds(p=51, trust=max, cond="CPU working")
                current_draw(mode = modem_sleep(64MHz), value = [5mA@periph-clk-off, 10mA@periph-clk-on])
                                @ds(p=51, trust=max, cond="CPU idle")
                current_draw(mode = modem_sleep(48MHz), value = [7mA@periph-clk-off, 11mA@periph-clk-on])
                                @ds(p=51, trust=max, cond="CPU working")
                current_draw(mode = modem_sleep(48MHz), value = [5mA@periph-clk-off, 9mA@periph-clk-on])
                                @ds(p=51, trust=max, cond="CPU idle")
                current_draw(mode = modem_sleep(32MHz), value = [4mA@periph-clk-off, 8mA@periph-clk-on])
                                @ds(p=51, trust=max, cond="CPU working")
                current_draw(mode = modem_sleep(32MHz), value = [3mA@periph-clk-off, 7mA@periph-clk-on])
                                @ds(p=51, trust=max, cond="CPU idle")
                # -- Low-power modes (Table 5-9, p.52).
                current_draw(mode = light_sleep, value = [typ: 85uA])
                                @ds(p=52, trust=max, cond="CPU and radio power off, peripheral clocks off, all GPIO high-Z")
                current_draw(mode = deep_sleep, value = [typ: 25uA])
                                @ds(p=52, trust=max, cond="CPU, radio, peripherals off, all GPIO high-Z")
                current_draw(mode = deep_sleep, value = [typ: 7uA])
                                @ds(p=52, trust=max, cond="LP timer and LP memory powered")
                current_draw(mode = off, value = [typ: 1uA])
                                @ds(p=52, trust=max, cond="CHIP_EN low, chip off")
            ]   # -> Pass D (per-mode slots against capacity)
            # p.49 Table 5-2 note 3: on a SINGLE supply the source must
            # deliver >= 0.35 A (IVDD row, printed as a MINIMUM) -- a demand
            # on the EXTERNAL regulator, which has no peer face in this file
            # (same BOM-side shape as cc2530's DCOUPL; the pairing face
            # belongs in mclibs/regulator/).
            # iperi: NO peripheral-current table exists in this datasheet
            # (the ADC and temp-sensor sections print no supply rows) -- the
            # iperi rows cc2530/efr32mg21 carry have no counterpart here
            # (honest gap).
        )

        # -- PMU analog rail VDDA_PMU (pin 19), return = GND pad. Feeds
        #    pins 14-16 (GPIO12/GPIO13/GPIO14) TOGETHER WITH VBAT (Table 2-7,
        #    p.20) -- the either-rail feed is flagged on the GPIO face below.
        psnk [[19], [33]] = [VDDA_PMU, GND]::DC(
            vin  = supply_range(3V ~ 3.6V)                   @ds(p=49, trust=max)   # Table 5-2
            vmax = absmax(-0.3V ~ 3.6V)                      @ds(p=49, trust=max)   # Table 5-1
        )

        # -- IO rail VDDPST1 (pin 9), return = GND pad. IO power domain:
        #    feeds the digital IO and the LP IO (Table 2-7, p.20), i.e. pins
        #    3-13 below.
        psnk [[9], [33]] = [VDDPST1, GND]::DC(
            vin  = supply_range(3V ~ 3.6V)                   @ds(p=49, trust=max)   # Table 5-2
            vmax = absmax(-0.3V ~ 3.6V)                      @ds(p=49, trust=max)   # Table 5-1
        )

        # -- IO rail VDDPST2 (pin 20), return = GND pad. IO power domain,
        #    digital IO (pins 21-26 below).
        psnk [[20], [33]] = [VDDPST2, GND]::DC(
            vin  = supply_range(3V ~ 3.6V)                   @ds(p=49, trust=max)   # Table 5-2
            vmax = absmax(-0.3V ~ 3.6V)                      @ds(p=49, trust=max)   # Table 5-1
            # FLAG (Table 5-2 note 2, p.49): while BURNING eFuses this rail
            # must not exceed 3.3 V (the eFuse write circuit is sensitive) --
            # a mode-conditional ceiling no face row carries today; it would
            # be vmax@efuse-write, an envelope point on vmax.
        )

        # -- GPIO: 19 IO pins, split by POWER DOMAIN because the DC windows
        #    are proportions of the pin's OWN domain rail (p.50 note 1: VDD
        #    = the voltage of each power domain's supply pin) -- the
        #    per-pin-supply-binding shape efr32mg21 filed for its RESETn.
        #    Windows are RELATIVE (0.25/0.75 receiver, 0.1/0.8 driver),
        #    transcribed as expressions -- eval-engine debt (same family as
        #    efr32mg21's 0.3 * iovdd).
        #    p.49 Table 5-1 has no per-pin current row: Ioutput 1.3 A is the
        #    TOTAL across all IO pins (p.49 note 2, all pins held 24 h at
        #    25 C) -- aggregate fact, honest gap at pin level.
        #    Pin capacitance CIN typ 2 pF (p.49) -- no capacitance meta in
        #    the corpus yet, kept as data here.
        io [3, 4, 5, 6, 7, 8, 10, 11, 12, 13] =
                GPIO::GPIO(
                    vin  = receiver([low: -0.3V ~ 0.25 * vddpst1, high: 0.75 * vddpst1 ~ vddpst1 + 0.3V])
                                @ds(p=49, trust=max, cond="VIL max / VIH min, VDD = own domain rail")
                    vout = drive_level(kind = ma(20mA),
                               value = [low: 0V ~ 0.1 * vddpst1, high: 0.8 * vddpst1 ~ vddpst1])
                                @ds(p=50, trust=max, cond="VOH/VOL at high-Z load; default drive 20 mA (Table 2-1 note 2, p.14)")
                    ileak = io_leak([max: 50nA])
                                @ds(p=49, cond="IIH / IIL")           # → doc
                    rpu   = io_pull([typ: 45kΩ])
                                @ds(p=50)                             # → doc
                    rpd   = io_pull([typ: 45kΩ])
                                @ds(p=50)                             # → doc
                )   # → Pass C (E4124 level window)
                # pins 3-8 = GPIO0-5, 10-13 = GPIO8-11; GPIO8-11 are LP pins
                # (work in every power mode, p.13). Default functions: JTAG
                # MTMS/MTDO/MTCK/MTDI on pins 5-8, ADC1_CH0-4 on pins 4-8
                # (Tables 2-3/2-5, p.15-17). Pin 10 (GPIO8) straps the ROM
                # print and, with pin 11 (GPIO9), the boot mode -- it floats
                # at reset (Table 3-1, p.22; boot Table 3-3, p.23: SPI Boot
                # with GPIO9 = 1, Joint Download Boot with GPIO8 = 1 and
                # GPIO9 = 0).
        io [14, 15, 16] =
                GPIO::GPIO(
                    vin  = receiver([low: -0.3V ~ 0.25 * vdd, high: 0.75 * vdd ~ vdd + 0.3V])
                                @ds(p=49, trust=max, cond="VIL max / VIH min; VDD = own domain rail (p.50 note 1)")
                    vout = drive_level(kind = ma(20mA),
                               value = [low: 0V ~ 0.1 * vdd, high: 0.8 * vdd ~ vdd])
                                @ds(p=50, trust=max, cond="VOH/VOL at high-Z load")
                    ileak = io_leak([max: 50nA])
                                @ds(p=49, cond="IIH / IIL")           # → doc
                    rpu   = io_pull([typ: 45kΩ])
                                @ds(p=50)                             # → doc
                    rpd   = io_pull([typ: 45kΩ])
                                @ds(p=50)                             # → doc
                )   # → Pass C (E4124 level window)
                # pins 14-16 = GPIO12/GPIO13/GPIO14, LP pins. FLAG: the feed
                # is "VDDA_PMU / VBAT" (Table 2-1 p.13, Table 2-7 p.20) --
                # either rail -- so the window basis above is the datasheet's
                # generic VDD; an either-of-two-rails basis is not
                # expressible on a face today. Pins 15/16 double as
                # XTAL_32K_P/N (Table 2-5, p.17) -- dual-face debt, same
                # shape as cc2530's P2_3/P2_4 (alias-grade face pending).
        io [21, 22, 23, 24] =
                GPIO::GPIO(
                    vin  = receiver([low: -0.3V ~ 0.25 * vddpst2, high: 0.75 * vddpst2 ~ vddpst2 + 0.3V])
                                @ds(p=49, trust=max, cond="VIL max / VIH min, VDD = own domain rail")
                    vout = drive_level(kind = ma(20mA),
                               value = [low: 0V ~ 0.1 * vddpst2, high: 0.8 * vddpst2 ~ vddpst2])
                                @ds(p=50, trust=max, cond="VOH/VOL at high-Z load; default drive 20 mA (Table 2-1 note 2, p.14)")
                    ileak = io_leak([max: 50nA])
                                @ds(p=49, cond="IIH / IIL")           # → doc
                    rpu   = io_pull([typ: 45kΩ])
                                @ds(p=50)                             # → doc
                    rpd   = io_pull([typ: 45kΩ])
                                @ds(p=50)                             # → doc
                )   # → Pass C (E4124 level window)
                # pins 21-24 = GPIO22, U0RXD (pin 22), U0TXD (pin 23),
                # GPIO25. UART0 defaults on 22/23 with weak pull-ups enabled
                # at reset (Table 2-1, p.14). Pin 24 (GPIO25) straps the
                # JTAG signal source (p.22) -- floats at reset. Strap
                # sampling: setup >= 0 ms before CHIP_EN high, hold >= 3 ms
                # after (Table 3-2, p.22).                  # → doc
        io [25, 26] =
                GPIO::GPIO(
                    vin  = receiver([low: -0.3V ~ 0.25 * vddpst2, high: 0.75 * vddpst2 ~ vddpst2 + 0.3V])
                                @ds(p=49, trust=max, cond="VIL max / VIH min, VDD = own domain rail")
                    vout = drive_level(kind = ma(40mA),
                               value = [low: 0V ~ 0.1 * vddpst2, high: 0.8 * vddpst2 ~ vddpst2])
                                @ds(p=50, trust=max, cond="VOH/VOL at high-Z load; default drive 40 mA (Table 2-1 note 2, p.14)")
                    ileak = io_leak([max: 50nA])
                                @ds(p=49, cond="IIH / IIL")           # → doc
                    rpu   = io_pull([typ: 45kΩ])
                                @ds(p=50)                             # → doc
                    rpd   = io_pull([typ: 45kΩ])
                                @ds(p=50)                             # → doc
                )   # → Pass C (E4124 level window)
                # pins 25/26 = GPIO26/GPIO27: default drive 40 mA (Table 2-1
                # note 2, p.14) and default function USB D-/D+ under the USB
                # pull-up (p.14 note 3); as plain GPIO the internal pulls
                # default OFF. Drive rows behind the class: IOH typ 40 mA at
                # VDD = 3.3 V with VOH >= 2.64 V, IOL typ 28 mA at
                # VOL = 0.495 V, PAD_DRIVER = 3 (p.49-50).

        # -- CHIP_EN (pin 17): chip enable AND hardware reset (low = off).
        #    Analog type, fed from VBAT (Table 2-1, p.13; Table 2-6, p.19).
        #    Must never float (p.19).
        [17] = CHIP_EN(
            vin = receiver([low: -0.3V ~ 0.25 * vbat, high: 0.75 * vbat ~ vbat + 0.3V])
                          @ds(p=50, trust=max, cond="VIH_nRST / VIL_nRST, VDD = VBAT domain")
        )   # → Pass C (E4124 level window)
        # tRST >= 50 us low resets the chip; tSTBL >= 50 us rail settle
        # before CHIP_EN may go high (Table 2-9, p.21) # → doc

        # -- RF: ONE single-ended antenna pin (ANT, pin 32, RF in/out,
        #    Table 2-6, p.19), carrying BOTH protocol stacks (BLE 5.3 and
        #    802.15.4) on one radio. The face TYPE is the pairing key
        #    (ruling 19); protocol rides value@condition points because it
        #    is not an axis argument. Test conditions throughout: 3.3 V
        #    +/-5%, 25 C, conducted at the antenna port through a 0 Ω RF
        #    front end (p.53 preamble). No RF-pin absolute maximum exists --
        #    Table 5-1 covers supply pins only (honest gap).
        rf [32] = RF2G4{ANT}::RF_SE(
            band  = radio_band([2402MHz ~ 2480MHz@ble, 2405MHz ~ 2480MHz@154])
                            @ds(p=53, trust=max, cond="BLE, Table 6-1")
                            @ds(p=57, trust=max, cond="802.15.4, Table 6-10; 16 channels ch11-26, 5 MHz spacing")   # → Pass C
            rate  = radio_rate([1Mbps@ble, 2Mbps@ble, 125kbps@ble-coded, 500kbps@ble-coded, 250kbps@154])
                            @ds(p=47, cond="PHY list, sections 4.3.2.1 / 4.3.3.1")   # → Pass C
            sens  = rf_sens([-99dBm@ble-1Mbps, -96dBm@ble-2Mbps,
                             -106.5dBm@ble-125kbps, -102.5dBm@ble-500kbps,
                             -102.5dBm@154])
                            @ds(p=55, trust=max, cond="BLE 1M/2M, 30.8% PER, Tables 6-6/6-7")
                            @ds(p=56, trust=max, cond="BLE coded 125k/500k, Tables 6-8/6-9")
                            @ds(p=57, trust=max, cond="802.15.4, 1% PER, Table 6-12")   # → Pass C-2 (link budget)
            maxin = rf_maxin(8dBm)
                            @ds(p=55, cond="BLE, 30.8% PER, Table 6-6")
                            @ds(p=57, cond="802.15.4, 1% PER -- Table 6-12 prints the same 8 dBm")   # → Pass C-2
            rej   = rf_reject([4dB@cochan, 2dB@+1M, 0dB@-1M,
                               -29dB@+2M, -29dB@-2M, -35dB@+3M, -36dB@-3M,
                               -30dB@>=+4M, -36dB@<=-4M,
                               -35dB@image, -30dB@image+1M, -29dB@image-1M])
                            @ds(p=55, cond="BLE 1 Mbps C/I, Table 6-6; signs as printed -- co-channel positive, adjacent negative")
                            # → doc
            rej154 = rf_reject([31dB@+5M, 43dB@-5M, 49dB@+10M, 54dB@-10M])
                            @ds(p=57, cond="802.15.4 relative interference, Table 6-12; printed asymmetric (+5 vs -5), transcribed literally")
                            # → doc
            blk   = rf_block([-16dBm@30M-2000M, -12dBm@2003M-2399M,
                              -16dBm@2484M-2997M, 0dBm@3000M-12.75G])
                            @ds(p=55, cond="BLE 1 Mbps out-of-band blocking, Table 6-6")   # → doc
            imd   = rf_reject(-35dBm)
                            @ds(p=55, cond="BLE 1 Mbps intermodulation, Table 6-6")   # → doc
            ibe   = rf_spur([-28dBm@+2M, -28dBm@-2M, -32dBm@+3M, -32dBm@-3M,
                             -34dBm@>3M])
                            @ds(p=53, cond="BLE 1 Mbps in-band emission, Table 6-2; measured at 15 dBm TX per the note on p.54 (still compliant at 20 dBm); 2M/125k/500k ladders in Tables 6-3..6-5, pp.53-54")
                            # → doc
            pout  = rf_pout(-24dBm ~ 20dBm)
                            @ds(p=53, trust=max, cond="BLE TX power range, Table 6-1")
                            @ds(p=57, trust=max, cond="802.15.4, Table 6-11 (min -24 / max 20, no typ printed)")   # → Pass C-2
            evm   = rf_evm(3.5%)
                            @ds(p=57, cond="802.15.4 O-QPSK 250 Kbps, Table 6-11")   # → doc
            drft  = rf_phase([1.5kHz@fn, 2.8kHz@f0-fn, 2.3kHz@f1-f0,
                              251.8kHz@df1avg, 217kHz@df2max])
                            @ds(p=53, cond="BLE 1 Mbps carrier offset/drift and modulation, Table 6-2; full ladder incl. 2 Mbps in Tables 6-2/6-3")   # → doc
        )
        # BLE 2M/125k/500k RX selectivity and blocking ladders (Tables 6-7
        # through 6-9, pp.55-56) are the same face at other rates -- not
        # repeated row-per-row; the 1 Mbps ladder above fixes the shape.

        # -- 32 MHz crystal (pins 28/29 XTAL_N/XTAL_P, differential P/N,
        #    Table 2-6, p.19). REQUIRED: the chip cannot work without it
        #    (p.30). The crystal spec table (ESR/CL/tolerance) is NOT in
        #    this datasheet -- it lives in the hardware design guide, so the
        #    xtal_* demand rows cc2530 carries have no counterpart here
        #    (honest gap; R9: demand side has no peer until a crystal part
        #    face exists).                            # → Pass C once paired
        [28, 29] = XOSC{XTAL_N, XTAL_P}    # 32 MHz, differential, required

        # -- 32.768 kHz crystal (pins 15/16 XTAL_32K_P/N): OPTIONAL low-speed
        #    clock -- otherwise an external slow clock can drive XTAL_32K_P
        #    (default 32 kHz) or the internal RCs run (p.30). Pins double as
        #    GPIO13/GPIO14 -- see the GPIO face above (dual-face debt).
        [15, 16] = LFOSC{XTAL_32K_P, XTAL_32K_N}
    ]

    # -- §4 body spec: what NO single pin owns --------------------------------
    spec = [
        ta   = temp_range(-40C ~ 105C)                          @ds(p=49)   # Table 5-2; both OPNs, Table 1-1 p.11
        # storage TSTORE is a separate -40C ~ 150C window (Table 5-1, p.49);
        # derating walk absent -- first semantic ruling candidate.  # → doc?
        # wake: NO wake-up/resume timing table exists in this datasheet (the
        # PMU timings live in the TRM) -- the wake = wake_time([...]) row
        # efr32mg21 carries has no ESP32-H2 counterpart (honest gap).

        # internal regulators (Table 2-8, p.20): digital 1.1 V, LP 1.1 V --
        # internal outputs, no external endpoint (R9: no landing).
        reg  = rc_osc([digital: 1.1V, lp: 1.1V])                @ds(p=20)   # → doc

        # internal RC oscillators (p.30): fast RC adjustable, default
        # 8 MHz; slow RC 130 kHz -- accuracy figures not in this datasheet
        # (TRM material, honest gap).
        clkr = rc_osc([fast: 8MHz, slow: 130kHz])               @ds(p=30)   # → doc

        # SAR ADC (Tables 5-4/5-5, p.50; features p.45): conditions -- 100 nF
        # on the ADC pin, DC input, 3.3 V, 25 C, modem off; error rows apply
        # to date-code 342023 and later (p.50 note).
        adc  = rc_osc([bits: 12bit, chans: 5, dnl: -8LSB ~ 12LSB,
                       inl: -10LSB ~ 10LSB, rate: 0 ~ 100kSPS,
                       err-atten0: -7mV ~ 7mV, err-atten1: -8mV ~ 8mV,
                       err-atten2: -12mV ~ 12mV, err-atten3: -23mV ~ 23mV])
                @ds(p=50, cond="Tables 5-4/5-5; total error per attenuation 0-3")   # → doc

        # temperature sensor (p.45): measurement range only -- accuracy rows
        # not in this datasheet (TRM material, honest gap).
        tsens = temp_sense(-40C ~ 125C)                         @ds(p=45)   # → doc

        # reliability / ESD (Table 5-10, p.52) -- whole-device survival:
        esd  = rc_osc([hbm: 2kV, cdm: 1kV])
                @ds(p=52, cond="JS-001 / JS-002; latch-up JESD78 +/-200 mA, HTOL 125 C 1000 h")   # → doc
    ]
}

# -- open points this transcription files ----------------------------------
# - power split: whole-chip budget rides VDD3P3 (no per-rail data); the
#   repetition debt cc2530 paid is avoided by NOT copying the rows.
# - partial axis binding: protocol (BLE vs 802.15.4) and the modem-sleep
#   CPU/peripheral conditions ride cond/envelope points, not axis arguments
#   -- same 1a2 collapse cc2530 filed.
# - relative windows (0.25/0.75/0.1/0.8 * domain rail) still lack a
#   meta-era literal (eval-engine debt, shared with efr32mg21).
# - either-of-two-rails feed on pins 14-16 (VDDA_PMU / VBAT) and Table 2-7's
#   unexplained VDD3P3 pin omission -- flagged at the rows.
# - dual-function pins (15/16 = GPIO13/14 = XTAL_32K; 25/26 = USB) wait for
#   the alias-grade pin face (pin-profile draft 2).
# - crystal specs, wake timings, RC-oscillator accuracy, temp-sensor accuracy:
#   not in this datasheet -- honest gaps, they live in the TRM / hardware
#   design guide.
# - CHIP_EN eFuse-write ceiling (VDDPST2 <= 3.3 V while writing) wants a
#   vmax@efuse-write envelope point -- literal not landed yet.
