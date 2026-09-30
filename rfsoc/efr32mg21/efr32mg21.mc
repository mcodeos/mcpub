# EFR32MG21 (Wireless Gecko multiprotocol 2.4 GHz SoC) -- corpus twin of
# cc2530.mc, written under the same ruling set so the form can be compared
# across vendors:
#   ruling 25  axis words carry parameters: tx(10dBm), em(2), rx(250kbps)
#   ruling 26  value lists are kvalue dicts [typ: ..., max: ...]
#   ruling 27  hot/return pins share one face: [RAIL, GND] pair form, pin
#              groups ordered by rail name
#   ruling 28  single call form: key = Meta(axis..., value = literal)
#   ruling 29  drive-class axis is one word ma with a current argument:
#              ma(20mA) -- compound tokens (ma4 / ma20) are retired
# Source: EFR32MG21 Family Data Sheet Rev 1.2 (SiLabs), pages cited per row.
# QFN32 4x4 mm pinout, Table 6.1 p.130-131. FAMILY-level file: the OPN picks
# flash size and the PA class (x010 = 10 dBm PA, x020 = 20 dBm PA, Table 2.1
# p.4) -- the PA class is not a pin fact and only survives as a @ds cond on
# the PAVDD idraw rows (open gap, see the comment there).
# Ground return for the non-RF rails is the center die pad (Figure 6.1
# p.130; 2x2 stencil array per the layout note) -- not a numbered pin.

@source(efr32mg21.pdf, "EFR32MG21 Family Data Sheet Rev 1.2", vendor = SiLabs)

# -- §1 metas --------------------------------------------------------------
# The schema lives in mcode/meta/ (ruling 13: one authority face per
# domain) -- this file only REFERENCES it (one value one source):
#   core.mc   receiver / absmax / temp_range / rc_osc
#   power.mc  supply_range / current_draw / wake_time
#   level.mc  drive_level (kind = ma(N mA), ruling 29) / io_pull
#   radio.mc  radio_band / radio_rate / rf_maxin

component EFR32MG21 {
    pins = [
        # -- Digital rail DVDD (pin 25), return = die pad. MCU rows are
        #    PER-MEGAHERTZ slopes (uA/MHz), not flat currents: total =
        #    slope x fHCLK -- a linear model the eval engine owes (same
        #    debt family as the 0.3 * iovdd relative windows below).
        #    em words are the vendor-neutral twin of cc2530's pm(1..3).
        psnk [[25], [pad]] = [DVDD, GND]::DC(
            vin  = supply_range(1.71V ~ 3.8V)                @ds(p=19, trust=max)
            vmax = absmax(-0.3V ~ 3.8V)                      @ds(p=18, trust=max)
            iabsmax = absmax(200mA)                          @ds(p=18, trust=max)   # IVDDMAX, all VDD lines
            idraw = [
                current_draw(mode = em(0), value = [typ: 45.6uA/MHz, max: 55.5uA/MHz])
                                @ds(p=23, trust=max, cond="80 MHz HFRCO, while loop from flash")
                current_draw(mode = em(1), value = [typ: 28.7uA/MHz, max: 37.6uA/MHz])
                                @ds(p=23, trust=max, cond="80 MHz HFRCO")
                current_draw(mode = em(2), value = [typ: 5.1uA])
                                @ds(p=23, trust=max, cond="full RAM retention, RTC from LFXO")
                current_draw(mode = em(3), value = [typ: 4.8uA, max: 11.4uA])
                                @ds(p=23, trust=max, cond="full RAM retention, RTC from ULFRCO")
                current_draw(mode = em(4), value = [typ: 0.21uA, max: 0.5uA])
                                @ds(p=23, trust=max, cond="no BURTC, no LF oscillator")
                current_draw(mode = em(4), value = [typ: 0.61uA])
                                @ds(p=23, trust=max, cond="BURTC with LFXO")
            ]   # -> Pass D (per-mode slots against capacity)
        )

        # -- Analog rail AVDD (pin 26), return = die pad. The ADC row
        #    reuses the SAME `adc` word as cc2530's peri_current table --
        #    second-vendor witness for one shared peri-unit enum
        #    (words = enum, single source).
        psnk [[26], [pad]] = [AVDD, GND]::DC(
            vin  = supply_range(1.71V ~ 3.8V)                @ds(p=19, trust=max)
            vmax = absmax(-0.3V ~ 3.8V)                      @ds(p=18, trust=max)
            iperi = [
                peri_current(unit = adc, value = [typ: 290uA, max: 385uA])
                                @ds(p=49, trust=max, cond="1 Msps continuous, OSR=2, all supplies")
            ]   # -> Pass D (additive onto the rail budget, next to idraw)
        )

        # -- IO rail IOVDD (pin 27), return = die pad. ONE IO rail feeds
        #    all 20 GPIO on this package (cc2530 had one GPIO bank too;
        #    the 0.3/0.7 thresholds below are the real coupling).
        psnk [[27], [pad]] = [IOVDD, GND]::DC(
            vin  = supply_range(1.71V ~ 3.8V)                @ds(p=19, trust=max)
            vmax = absmax(-0.3V ~ iovdd + 0.3V)              @ds(p=18, trust=max)   # VDIGPIN, rail-relative
        )

        # -- PA rail PAVDD (pin 14), return = RFVSS (pin 11). Radio rows
        #    are measured with ALL supplies tied (p.25 preamble); the
        #    budget lands here because the PA dominates. The same output
        #    power appears under two PA classes (10 dBm vs 20 dBm part):
        #    the PA class is an OPN-variant AXIS, expressible only as a
        #    @ds cond today -- a word cannot carry two axis arguments
        #    under ruling 25's one-arg form (open gap).
        psnk [[14], [11]] = [PAVDD, GND]::DC(
            vin  = supply_range(1.71V ~ 3.8V)                @ds(p=19, trust=max)
            vmax = absmax(-0.3V ~ 3.8V)                      @ds(p=18, trust=max)
            idraw = [
                current_draw(mode = rx(250kbps), value = [typ: 9.5mA])
                                @ds(p=25, trust=max, cond="802.15.4 frame, all supplies tied")
                current_draw(mode = rx(250kbps), value = [typ: 9.2mA])
                                @ds(p=25, trust=max, cond="listening for packet")
                current_draw(mode = tx(0dBm), value = [typ: 10.5mA])
                                @ds(p=25, trust=max, cond="0 dBm PA")
                current_draw(mode = tx(0dBm), value = [typ: 16.7mA])
                                @ds(p=25, trust=max, cond="10 dBm PA")
                current_draw(mode = tx(10dBm), value = [typ: 34.0mA])
                                @ds(p=25, trust=max, cond="10 dBm PA")
                current_draw(mode = tx(10dBm), value = [typ: 60.8mA])
                                @ds(p=25, trust=max, cond="20 dBm PA")
                current_draw(mode = tx(20dBm), value = [typ: 185mA])
                                @ds(p=25, trust=max, cond="20 dBm PA, PAVDD = 3.3V")
            ]   # -> Pass D
        )

        # -- RF rail RFVDD (pin 10), return = RFVSS (pin 11). The UPPER
        #    BOUND IS RAIL-RELATIVE (VPAVDD, p.19) and the board must hold
        #    PAVDD >= RFVDD and DVDD >= DECOUPLE (p.18 supply notes): an
        #    inter-rail ordering constraint no face can carry today --
        #    cc2530 had no rail ordering at all (new shape candidate).
        psnk [[10], [11]] = [RFVDD, GND]::DC(
            vin  = supply_range(1.71V ~ pavdd)               @ds(p=19, trust=max)   # rail-relative max
        )

        # -- GPIO: 20 pins, ONE drive class -- the datasheet gives a
        #    single VOH/VOL pair at 20 mA (p.48), no 4 mA/20 mA split
        #    like cc2530. Thresholds are PROPORTIONS of IOVDD (0.3/0.7):
        #    relative windows straight from the datasheet, transcribed
        #    as expressions -- eval-engine debt (specimen gap 5).
        io [1, 2, 3, 4, 5, 6, 15, 16, 17, 18, 19, 20, 21, 22, 23, 28, 29, 30, 31, 32] =
                GPIO::GPIO(
                    vin  = receiver([low: 0V ~ 0.3 * iovdd, high: 0.7 * iovdd ~ iovdd])
                                @ds(p=48, trust=max, cond="VIL max / VIH min, scale to IOVDD")
                    vout = drive_level(kind = ma(20mA),
                               value = [low: 0V ~ 0.2 * iovdd, high: 0.8 * iovdd ~ iovdd])
                                @ds(p=48, trust=max, cond="20 mA sink/source, IOVDD = 3.0 V")
                    iabsmax = absmax(50mA)                   @ds(p=18, trust=max)   # per I/O pin
                )   # -> Pass C (E4124 level window)

        # -- Antenna: TWO SINGLE-ENDED pins with diversity (p.10: either
        #    pin is the active path) -- not a differential pair like
        #    cc2530's RF_P/RF_N. The face TYPE is the pairing key
        #    (ruling 19), so RF_SE and RF_DIFF never conflate.
        rf [12, 13] = RF2G4{ANT0, ANT1}::RF_SE(
            band = radio_band(2400MHz ~ 2483.5MHz)           @ds(p=26)   # FRANGE
            rate = radio_rate(250kbps)     @ds(p=35, cond="802.15.4, sensitivity -104.5 dBm at 1% PER")
            rfmax = absmax(+10dBm)                           @ds(p=18)   # PRFMAX2G4, RF pins
            maxin = rf_maxin(10dBm)                          @ds(p=35, trust=max, cond="RXSAT, max strong signal input, packet")   # -> Pass C-2
        )

        # -- RESETn (pin 9): thresholds and the internal pull-up scale to
        #    DVDD, NOT IOVDD (p.48 notes 1-2) -- a level face bound to a
        #    DIFFERENT rail than the IO rail: per-pin supply binding,
        #    which the GPIO face above cannot express.
        [9] = RESET_N(
            vin = receiver([low: 0V ~ 0.3 * dvdd, high: 0.7 * dvdd ~ dvdd])
                          @ds(p=48, trust=max, cond="thresholds scale to DVDD")
        )   # tRESET min 100 ns low (p.48)

        # -- 38.4 MHz crystal (radio clock; the ONLY supported HFXO
        #    frequency, p.19 note 5). The tolerance requirement depends on
        #    PROTOCOL (Zigbee 40 ppm, BLE 50 ppm, p.43 notes): a
        #    mode-dependent requirement on a crystal face -- same xtal
        #    family gap cc2530 deferred ("another part's turn").
        [7, 8] = XOSC{Q1, Q2}    # 38.4 MHz, ESR <= 40 ohm, CL = 10 pF (p.43)
        [32, 31] = LFOSC{LFXO}   # PD00/PD01, 32.768 kHz crystal (p.130-131)

        # -- DECOUPLE (pin 24): on-chip regulator decoupling cap. Unlike
        #    cc2530's DCOUPL (no value in the datasheet), MG21 SPECS it:
        #    0.75 ~ 2.75 uF across temperature and DC bias (p.19). Still
        #    a BOM-side value (G12 family) -- the face stays bare.
        psnk [24] = DECOUPLE    # CDECOUPLE 0.75 ~ 2.75 uF @ds(p=19, trust=max)
    ]

    spec = [   # whole-part facts only (ruling 19, third sentence)
        ta   = temp_range(-40C ~ 125C)                          @ds(p=19)   # -I grade
        wake = wake_time([1.43us@em(1), 3.92us@em(2), 3.92us@em(3),
                          17.8ms@em(4)])
                          @ds(p=42, cond="code from RAM; EM4 wakes to flash reboot")
    ]   # wake -> Pass C-2 (require.boot_latency pulls the EM rows in)
}

# -- pairing story (what the engine actually walks) ------------------------
# 1. Power net (regulator --- DVDD/AVDD/IOVDD/PAVDD):
#      covers: vout window inside supply_range(1.71 ~ 3.8 V)       -> Pass C
#      leq: every idraw slot <= capacity on the source face        -> Pass D
# 2. GPIO net: drive_level covers the peer receiver window         -> Pass C
# 3. RF link: band covers the channel demand, rate floors          -> Pass C
#    throughput; link budget: peer pout - path loss >= sens,
#    pout <= maxin.                                                -> Pass C-2
# 4. Reset/crystal: RESETn thresholds bind to DVDD (per-pin supply
#    binding); crystal tolerance binds per protocol                -> Pass C
#    (xtal_acc value@condition).
#
# -- open points this transcription files ----------------------------------
# - MCU current rows are PER-MEGAHERTZ slopes (uA/MHz): total = slope x
#   fHCLK -- a linear model the eval engine owes.
# - inter-rail ordering (PAVDD >= RFVDD, DVDD >= DECOUPLE, p.18): no face
#   carries a rail-to-rail constraint yet (cst92f32 VDD_RF = second
#   witness).
# - OPN PA-variant axis: the same tx word carries two PA classes only as
#   @ds cond (a word cannot carry two axis arguments under ruling 25).
# - RESETn thresholds bind to DVDD, NOT IOVDD -- per-pin supply binding
#   the GPIO face cannot express.
# - 38.4 MHz crystal tolerance depends on PROTOCOL (Zigbee 40 ppm / BLE
#   50 ppm, p.43): value@condition until an axis home exists.
# - ONE drive class (ma(20mA) only): the axis is dropped, not defaulted
#   (ruling 29).
