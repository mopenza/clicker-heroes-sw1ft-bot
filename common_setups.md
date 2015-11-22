# Common Setups

## Global Settings

    optimalLevel := 1250

    autoAscend := true
    saveBeforeAscending := true

## Speed Run

    useImageSearch := false
    gildedRanger := 3 ; Lilin

#### Idle

    irisLevel := 35
    speedRunTime := 36

    activateSkillsAtStart := true
    deepRunClicks := false
    hybridMode := false

    speedRunStartCombo := comboStart

#### Hybrid

    irisLevel := 35
    speedRunTime := 23
    deepRunTime := 6

    activateSkillsAtStart := true
    deepRunClicks := true
    hybridMode := true

    speedRunStartCombo := comboHybridIdle
    deepRunCombo := comboHybridActive

## Deep Run

    deepRunTime := 60 * 8
    deepRunClicks := true

    deepRunCombo := comboEDR

## Vision Run

    useImageSearch := true
    gildedRanger := 3 ; Lilin

    clickableHuntDelay := 8
    stopHuntThreshold := 0

    useMidasStart := true
    midasZoneConfig := [56, 6, 0, 0, 76, 0]

#### Idle

    irisLevel := 35
    endLvlIdle := optimalLevel
    endLvlActive := 0

    activateSkillsAtStart := false
    deepRunClicks := false

#### Hybrid

    irisLevel := 35
    endLvlIdle := optimalLevel
    endLvlActive := 2200

    activateSkillsAtStart := true
    deepRunClicks := true

    speedRunStartCombo := comboHybridIdle
    deepRunCombo := comboHybridActive

#### Active

    gildedRanger := 3 ; Cadmia

    irisLevel := 1669
    endLvlIdle := 0
    endLvlActive := irisLevel + 630

    activateSkillsAtStart := false
    deepRunClicks := true

    deepRunCombo := comboMidas

## Skill combos

    comboEDR := [2.5*60, "2-3-4-5-7-8-6-9", "", "", "", "", "", "8-9-2-3-4-5-7", "2", "2", "2-3-4", "2", "2"]

    00:00 : 2-3-4-5-7-8-6-9
    15:00 : 8-9-2-3-4-5-7
    17:30 : 2
    20:00 : 2
    22:30 : 2-3-4
    25:00 : 2
    27:30 : 2
    30:00 : repeat

    comboHybridIdle := [15*60, "1-2-3-4-5-7-6-9-8"] ; energize >
   
    comboHybridActive := [30, "5-2-4-6-7", "", "", "3-8-9", "", "", "2", "", "", "3-7", "", "1-2"] ; > golden clicks, 6 minutes active

    00:00 : 5-2-4-6-7
    01:30 : 3-8-9
    03:00 : 2
    04:30 : 3-7
    05:30 : 1-2

    ; ~18 minutes active
    comboMidas := [30, "9-3-8-6", "2", "", "", "", "", "2", "", "", "", "", "2", "", "", "", "", "2", "", "4", "", "", "2-5", "", "", "", "", "", "3", "", "", "8-9-3-5", "", "", "2-4-7", "", "1", "", ""]

    00:00 : 9-3-8-6
    00:30 : 2
    03:00 : 2
    05:30 : 2
    08:00 : 2
    09:00 : 4
    10:30 : 2-5
    13:30 : 3
    15:00 : 8-9-3-5
    16:30 : 2-4-7
    17:30 : 1

## Do not disturb

    autoAscendDelay := 0
    displayRelicsDuration := 0

    screenShotRelics := false
    saveBeforeAscending := false

    global playNotificationSounds := false
    global playWarningSounds := false
    global showSplashTexts := false
    global showProgressBar := false

## Dual monitors

#### Left monitor

    xSplash := A_ScreenWidth // 2 - wSplash // 2 - A_ScreenWidth
    xProgressBar := 20 - A_ScreenWidth

#### Right monitor

    xSplash := A_ScreenWidth // 2 - wSplash // 2 + A_ScreenWidth
    xProgressBar := 20 + A_ScreenWidth
