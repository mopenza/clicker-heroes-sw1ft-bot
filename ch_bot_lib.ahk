; -----------------------------------------------------------------------------------------
; Clicker Heroes Sw1ft Bot Lib
; by Sw1ftb
; -----------------------------------------------------------------------------------------

CoordMode, Pixel, Screen

libVersion=1.4

winName := "Clicker Heroes"

global ProgressBar, ProgressBarTime ; progress bar controls

exitThread := false
exitDRThread := false

chWinId := ""

; All the script coordinates are based on these four default dimensions.
chWidth := 1136
chHeight := 640
chMargin := 8
chTopMargin := 30

chTotalWidth := chWidth + chMargin * 2
chTotalHeight := chHeight + chMargin + chTopMargin

; Calculated
xScreenL := 0
yScreenT := 0
xScreenR := 0
yScreenB := 0

; Calculated
leftMarginOffset := 0
topMarginOffset := 0

; Calculated
aspectRatio := 1
hBorder := 0
vBorder := 0

zzz := 175 ; sleep delay (in ms) after a click
lvlUpDelay := 4 ; time (in seconds) between lvl up clicks
barUpdateDelay := 30 ; time (in seconds) between progress bar updates
coinPickUpDelay := 5 ; time (in seconds) needed to pick up all coins from a clickable
nextHeroDelay := 5 ; extra gold farm delay (in seconds) between heroes

scrollDelay := 275 ; base delay (in ms)
scrollClickDelay := 20 ; delay per click (in ms)

dialogBoxClass := "#32770"

blueColor := 0x60BEFF
yellowColor := 0xFECB00
dimmedYellowColor := 0x7E6500
goldColor := 0xFFB423
brightGoldColor := 0xFFD911

; -- Images -------------------------------------------------------------------------------

; Combat zone offsets
CZTO := 170
CZLO := 500
CZBO := CZTO - chHeight
CZRO := CZLO - chWidth

imageFilePath := "images\"

imgSmile := {file:"smile.png", topOffset:0, leftOffset:1090, bottomOffset:0, rightOffset:0}
imgQuality := {file:"quality.png", topOffset:0, leftOffset:1090, bottomOffset:0, rightOffset:0}
imgProgression := {file:"progression.png", topOffset:0, leftOffset:1090, bottomOffset:0, rightOffset:0}

imgClickable := {file:"clickable.png", topOffset:CZTO, leftOffset:CZLO, bottomOffset:0, rightOffset:0}

imgSkillBar := {file:"skill_bar.png", topOffset:0, leftOffset:575, bottomOffset:0, rightOffset:-496}
imgSkillLocked := {file:"skill_locked.png", topOffset:0, leftOffset:575, bottomOffset:0, rightOffset:-496}

imgCombat := {file:"combat.png", topOffset:0, leftOffset:0, bottomOffset:CZBO, rightOffset:CZRO}

imgHire := {file:"hire.png", topOffset:CZTO, leftOffset:0, bottomOffset:0, rightOffset:CZRO}
imgCoin := {file:"coin.png", topOffset:CZTO, leftOffset:0, bottomOffset:0, rightOffset:CZRO}

imgDimmedSkill := {file:"skill_dimmed.png", topOffset:CZTO, leftOffset:0, bottomOffset:0, rightOffset:CZRO}
imgSkill := {file:"skill.png", topOffset:CZTO, leftOffset:0, bottomOffset:0, rightOffset:CZRO}
imgClickstorm := {file:"clickstorm.png", topOffset:CZTO, leftOffset:0, bottomOffset:0, rightOffset:CZRO}
imgMetalDetector := {file:"metal_detector.png", topOffset:CZTO, leftOffset:0, bottomOffset:0, rightOffset:CZRO}
imgGoldenClicks := {file:"golden_clicks.png", topOffset:CZTO, leftOffset:0, bottomOffset:0, rightOffset:CZRO}
imgAscension := {file:"ascension.png", topOffset:CZTO, leftOffset:0, bottomOffset:0, rightOffset:CZRO}
imgFrigidEnchant := {file:"frigid_enchant.png", topOffset:CZTO, leftOffset:0, bottomOffset:0, rightOffset:CZRO}

imgCid := {file:"cid.png", topOffset:CZTO, leftOffset:0, bottomOffset:0, rightOffset:CZRO}
imgMercedes := {file:"mercedes.png", topOffset:CZTO, leftOffset:0, bottomOffset:0, rightOffset:CZRO}
imgReferi := {file:"referi.png", topOffset:CZTO, leftOffset:0, bottomOffset:0, rightOffset:CZRO}
imgBeastlord := {file:"beastlord.png", topOffset:CZTO, leftOffset:0, bottomOffset:0, rightOffset:CZRO}
imgDK := {file:"dk.png", topOffset:CZTO, leftOffset:0, bottomOffset:0, rightOffset:CZRO}
imgSolomon := {file:"solomon.png", topOffset:CZTO, leftOffset:0, bottomOffset:0, rightOffset:CZRO}

imgGilded := {file:"gilded.png", topOffset:CZTO, leftOffset:0, bottomOffset:0, rightOffset:CZRO}

imgBuyUpgrades := {file:"upgrades.png", topOffset:CZTO, leftOffset:0, bottomOffset:0, rightOffset:CZRO}

imgClanRaid := {file:"clan_raid.png", topOffset:CZTO, leftOffset:0, bottomOffset:0, rightOffset:CZRO}
imgClanFight := {file:"clan_fight.png", topOffset:CZTO, leftOffset:0, bottomOffset:0, rightOffset:CZRO}
imgClanFightAgain := {file:"clan_fight_again.png", topOffset:CZTO, leftOffset:0, bottomOffset:0, rightOffset:CZRO}
imgClanCollect := {file:"clan_collect.png", topOffset:CZTO, leftOffset:0, bottomOffset:0, rightOffset:CZRO}

imgYes := {file:"yes.png", topOffset:CZTO, leftOffset:0, bottomOffset:0, rightOffset:0}

; -- Coordinates --------------------------------------------------------------------------

; Top LVL UP button when scrolled to the bottom
xLvl := 80
yLvl := 285
oLvl := 107 ; offset to next button

buttonSize := 34

; Ascend Yes button
xYes := 500
yYes := 445

xCombatTab := 50
xStatsTab := 212
xAncientTab := 296
xRelicTab := 380 + 10 ; Halloween fix
xClanTab := 464
yTab := 130

xRelic := 103
yRelic := 380

xSalvageJunk := 280
ySalvageJunk := 470

xDestroyYes := 500
yDestroyYes := 430

; Scrollbar
xScroll := 554
yUp := 219
yDown := 653
top2BottomClicks := 45

xGilded := 135
yGilded := 582

xGildedDown := 1060
yGildedDown := 493

xGildedClose := 1090
yGildedClose := 54

rangers := ["Dread Knight", "Atlas", "Terra", "Phthalo", "Banana", "Lilin", "Cadmia", "Alabaster", "Astraea"]

rangerPositions := {}
rangerPositions[1] := {x:445, y:355}
rangerPositions[2] := {x:675, y:355}
rangerPositions[3] := {x:900, y:355}
rangerPositions[4] := {x:220, y:425}
rangerPositions[5] := {x:445, y:425}
rangerPositions[6] := {x:675, y:425}
rangerPositions[7] := {x:900, y:425}
rangerPositions[8] := {x:220, y:490}
rangerPositions[9] := {x:445, y:490}

; Buy Available Upgrades button
xBuy := 370
yBuy := 582

xFocus := 564
yFocus := 69

xMonster := 920
yMonster := 164

; Safety zones (script will pause when entering)
safetyZones := {}
safetyZones[1] := {x1:8, y1:104, x2:506, y2:153} ; tabs
safetyZones[2] := {x1:1096, y1:29, x2:1144, y2:74} ; settings
safetyZones[3] := {x1:773, y1:600, x2:949, y2:670} ; shop
safetyZones[4] := {x1:79, y1:554, x2:194, y2:612} ; gilded

; The wrench
xSettings := 1121
ySettings := 52

xSettingsClose := 961
ySettingsClose := 52

xSave := 286
ySave := 112

xSkill := 201
oSkill := 36 ; offset to next skill
ySkillTop := 279 ; at top
ySkill2nd := 410 ; at bottom

xPrevZone := 679
xMiddleZone := 858
xNextZone := 1044
yZone := 70

xNewGild := 1105
yNewGild := 560
xOpenGild := 570
yOpenGild := 360
xCloseGild := 924
yCloseGild := 133

; -----------------------------------------------------------------------------------------

; Load system default settings
#Include system\ch_bot_lib_default_settings.ahk

IfNotExist, ch_bot_lib_settings.ahk
{
	FileCopy, system\ch_bot_lib_default_settings.ahk, ch_bot_lib_settings.ahk
}

#Include *i ch_bot_lib_settings.ahk

; -----------------------------------------------------------------------------------------
; -- Functions
; -----------------------------------------------------------------------------------------

getClickable(idle:=0) {
	global
	local xPos, yPos
	if (idle = 0) {
		; Break idle on purpose to get the same amount of gold every run
		loop 3 {
			clickPos(xMonster, yMonster)
		}
		clickPos(524, 487)
		clickPos(747, 431)
		clickPos(760, 380)
		clickPos(873, 512)
		clickPos(1005, 453)
		clickPos(1053, 443)
	} else if (locateImage(imgClickable, xPos, yPos)) {
		clickPos(xPos, yPos, 1, 1) ; absolute pos
	}
}

clientCheck() {
	global
	if (A_TitleMatchMode = 3) {
		calculateSteamAspectRatio() ; Steam
	} else {
		local xPos, yPos
		calculateBrowserOffsets() ; Browser
		fullScreenOption := false

		if (useImageSearch and locateImage(imgQuality, xPos, yPos)) {
			showDebugSplash("Switching to low quality...")
			clickPos(xPos, yPos, 1, 1)
		}
	}
}

calculateBrowserOffsets() {
	global
	local w, h
	winName := "Lvl.*Clicker Heroes.*" . browser
	IfWinExist, % winName
	{
		showSplash("Calculating browser offsets...", 1, 0)
		WinActivate
		WinGetPos, xWinPos, yWinPos, w, h
		WinGet, chWinId, ID, A

		local leftMargin := (w - chWidth) // 2
		leftMarginOffset := leftMargin - chMargin
		topMarginOffset := browserTopMargin - chTopMargin

		xScreenL := xWinPos + leftMargin
		yScreenT := yWinPos + browserTopMargin
		xScreenR := xScreenL + chWidth
		yScreenB := yScreenT + chHeight
	} else {
		showWarningSplash("Clicker Heroes started in " . browser . "?")
	}
}

calculateSteamAspectRatio() {
	global
	local w, h
	IfWinExist, % winName
	{
		WinActivate
		WinGetPos, xWinPos, yWinPos, w, h
		WinGet, chWinId, ID, A

		; Fullscreen sanity checks
		if (fullScreenOption) {
			if (w <> A_ScreenWidth || h <> A_ScreenHeight) {
				showWarningSplash("Set the fullScreenOption to false in the bot lib file.")
				return
			}
		} else if (w = A_ScreenWidth && h = A_ScreenHeight) {
			showWarningSplash("Set the fullScreenOption to true in the bot lib file.")
			return
		}

		if (w != chTotalWidth || h != chTotalHeight) {
			showSplash("Calculating Steam aspect ratio...", 1, 0)

			local winWidth := fullScreenOption ? w : w - 2 * chMargin
			local winHeight := fullScreenOption ? h : h - chTopMargin - chMargin
			local horizontalAR := winWidth/chWidth
			local verticalAR := winHeight/chHeight

			; Take the lowest aspect ratio and calculate border size
			if (horizontalAR < verticalAR) {
				aspectRatio := horizontalAR
				vBorder := (winHeight - chHeight * aspectRatio) // 2
			} else {
				aspectRatio := verticalAR
				hBorder := (winWidth - chWidth * aspectRatio) // 2
			}
		}

		xScreenL := fullScreenOption ? xWinPos : xWinPos + chMargin
		yScreenT := fullScreenOption ? yWinPos : yWinPos + chTopMargin
		xScreenR := fullScreenOption ? xWinPos + w : xWinPos + w - chMargin
		yScreenB := fullScreenOption ? yWinPos + h : yWinPos + h - chMargin
	} else {
		showWarningSplash("Clicker Heroes started in Steam?")
	}
}

switchToCombatTab() {
	global
	clickPos(xCombatTab, yTab)
	sleep % zzz * 4
}

switchToAncientTab() {
	global
	clickPos(xAncientTab, yTab)
	sleep % zzz * 2
}

switchToRelicTab() {
	global
	clickPos(xRelicTab, yTab)
	sleep % zzz * 2
}

switchToClanTab() {
	global
	clickPos(xClanTab, yTab)
	sleep % zzz * 2
}

scrollToTop() {
	global
	clickPos(xScroll, yUp, top2BottomClicks)
	sleep % scrollDelay + top2BottomClicks * scrollClickDelay
}

scrollToBottom() {
	global
	clickPos(xScroll, yDown, top2BottomClicks)
	sleep % scrollDelay + top2BottomClicks * scrollClickDelay
}

scrollUp(clickCount:=1) {
	global
	clickPos(xScroll, yUp, clickCount)
	sleep % scrollDelay + clickCount * scrollClickDelay
}

scrollDown(clickCount:=1) {
	global
	clickPos(xScroll, yDown, clickCount)
	sleep % scrollDelay + clickCount * scrollClickDelay
}

; Scroll down fix when at bottom and scroll bar don't update correctly
scrollWayDown(clickCount:=1) {
	global
	scrollUp()
	scrollDown(clickCount + 1)
	sleep % nextHeroDelay * 1000
}

maxClick(xCoord, yCoord, clickCount:=1, absolute:=0) {
	global
	ControlSend,, {shift down}{sc010 down}, ahk_id %chWinId% ; {q}, {vk51} or {sc010}
	clickPos(xCoord, yCoord, clickCount, absolute)
	ControlSend,, {sc010 up}{shift up}, ahk_id %chWinId%
	sleep % zzz
}

ctrlClick(xCoord, yCoord, clickCount:=1, sleepSome:=1, absolute:=0) {
	global
	ControlSend,, {ctrl down}, ahk_id %chWinId%
	clickPos(xCoord, yCoord, clickCount, absolute)
	ControlSend,, {ctrl up}, ahk_id %chWinId%
	if (sleepSome) {
		sleep % zzz
	}
}

zClick(xCoord, yCoord, clickCount:=1, absolute:=0) {
	global
	ControlSend,, {sc02C down}, ahk_id %chWinId% ; {z}, {vk5A} or {sc02C}
	clickPos(xCoord, yCoord, clickCount, absolute)
	ControlSend,, {sc02C up}, ahk_id %chWinId%
	sleep % zzz
}

clickPos(xCoord, yCoord, clickCount:=1, absolute:=0) {
	global
	local xAdj := absolute ? xCoord : getAdjustedX(xCoord)
	local yAdj := absolute ? yCoord : getAdjustedY(yCoord)
 	ControlClick, x%xAdj% y%yAdj%, ahk_id %chWinId%,,, %clickCount%, NA
}

getAdjustedX(x) {
	global
	local leftMargin := fullScreenOption ? 0 : chMargin + leftMarginOffset
	return round(aspectRatio*(x - chMargin) + leftMargin + hBorder)
}

getAdjustedY(y) {
	global
	local topMargin := fullScreenOption ? 0 : chTopMargin + topMarginOffset
	return round(aspectRatio*(y - chTopMargin) + topMargin + vBorder)
}

playNotificationSound() {
	if (playNotificationSounds) {
		SoundPlay, %A_WinDir%\Media\Windows User Account Control.wav
	}
}

playWarningSound() {
	if (playWarningSounds) {
		SoundPlay, %A_WinDir%\Media\tada.wav
	}
}

showDebugSplash(text, seconds:=1) {
	if (debug) {
		showSplash(text, seconds, 0)
	}
}

showSplashAlways(text, seconds:=2) {
	showSplash(text, seconds, 1, 1)
}

showWarningSplash(text, seconds:=5) {
	showSplash(text, seconds, 2, 1)
}

showSplash(text, seconds:=2, sound:=1, showAlways:=0) {
	global
	if (seconds > 0) {
		if (showSplashTexts or showAlways) {
			progress,% "w" wSplash " x" xSplash " y" ySplash " zh0 fs10", %text%,,% script
		}
		if (sound = 1) {
			playNotificationSound()
		} else if (sound = 2) {
			playWarningSound()
		}
		sleep % seconds * 1000
		progress, off
	}
}

startProgress(title, min:=0, max:=100) {
	global
	if (showProgressBar) {
		gui, new
		gui, margin, 0, 0
		gui, font, s18
		gui, add, progress,% "w" wProgressBar " h28 range" min "-" max " -smooth vProgressBar"
		gui, add, text, w92 vProgressBarTime x+2
		gui, show,% "na x" xProgressBar " y" yProgressBar,% script " - " title
	}
}

updateProgress(position, remainingTime, showLvl:=0) {
	if (showProgressBar) {
		guicontrol,, ProgressBar,% position
		if (showLvl) {
			guicontrol,, ProgressBarTime,% remainingTime
		} else {
			guicontrol,, ProgressBarTime,% formatSeconds(remainingTime)
		}
	}
}

stopProgress() {
	if (showProgressBar) {
		gui, destroy
	}
}

formatSeconds(s) {
	time := 19990101 ; *Midnight* of an arbitrary date.
	time += %s%, seconds
	FormatTime, timeStr, %time%, HH:mm:ss
	return timeStr
}

secondsSince(startTime) {
	return (A_TickCount - startTime) // 1000
}

toggleFlag(flagName, byref flag) {
	flag := !flag
	flagValue := flag ? "On" : "Off"
	showSplashAlways("Toggled " . flagName . " " . flagValue)
}

screenShot() {
	global
	local activeWinId
	if (A_TitleMatchMode = 3) { ; Steam only
		WinGet, activeWinId, ID, A ; remember current active window...
		WinActivate, ahk_id %chWinId%
		send {f12 down}{f12 up} ; screenshot
		sleep % zzz
		WinActivate, ahk_id %activeWinId% ; ... and restore focus back
	}
}

scrollToZone(fromZone, toZone) {
	global
	local currentZone := getCurrentZone()
	local zones := currentZone > 0 ? toZone - currentZone : toZone - fromZone
	local xZone := zones > 0 ? xNextZone : xPrevZone

	if (zones != 0) {
		clickPos(xZone, yZone, abs(zones))
		sleep % scrollDelay + 25 + abs(zones) * scrollClickDelay
		clickPos(xMiddleZone, yZone)
		sleep % zzz
	}
}

horizontalSkills(x, y, skills, absolute:=0) {
	global

	loop % skills
	{
		clickPos(x, y, 1, absolute)
		sleep 25
		x += oSkill
	}
	sleep % zzz * 2
}

verticalSkills(x) {
	global
	local y := 215

	loop 14
	{
		clickPos(x, y)
		sleep 25
		y += buttonSize
	}
}

getCurrentZone() {
	global
	local title, currentZone
	if (A_TitleMatchMode = "regex") {
		WinGetTitle, title, ahk_id %chWinId%
		currentZone := SubStr(title, 5, InStr(title, "-") - 6)
		return currentZone
	} else {
		return 0
	}
}

reFocus() {
	global
	clickPos(xFocus, yFocus)
	sleep 25
}

; -----------------------------------------------------------------------------------------
; Note that all image/pixel searches are done with absolute coordinates relative to the
; screen. The CH window is required to be visible and in default size for this to work.
; -----------------------------------------------------------------------------------------

upLocator(image, what, byref xPos, byref yPos, clickCount:=5, retries:=-1, absolute:=0, startAt:=0) {
	return locator(image, what, xPos, yPos, clickCount, retries, absolute, startAt, 1)
}

; Try to locate the given image one screen at a time
locator(image, what, byref xPos, byref yPos, clickCount:=5, retries:=-1, absolute:=0, startAt:=0, directionUp:=0) {
	global

	local attempts := ceil(45 / clickCount)
	local attempt := 0

	while (!locateImage(image, xPos, yPos, absolute, startAt, directionUp)) {
		if (++attempt <= attempts) {
			if (directionUp) {
				scrollUp(clickCount)
				startAt := 0 ; only offset once
			} else {
				scrollDown(clickCount)
			}
		} else if (retries < 0 or --retries > 0) {
			showDebugSplash("Could not locate " . what . "! Trying again...")
			clientCheck()
			clickerInitialize()
			if (directionUp) {
				scrollToBottom()
			} else {
				scrollToTop()
			}
			attempt := 0
		} else {
			return 0
		}
	}
	return 1
}

locateImage(image, byref xPos:="", byref yPos:="", absolute:=0, startAt:=0, directionUp:=0) {
	if (directionUp) {
		return locateImageUp(image, xPos, yPos, absolute, startAt)
	} else {
		return locateImageDown(image, xPos, yPos, absolute, startAt)
	}
}

; Bottom up image search in chunks (size equal to the distance between two lvl up buttons)
locateImageUp(image, byref xPos:="", byref yPos:="", absolute:=0, startAt:=0) {
	global

	local yT := yScreenT + image.topOffset
	local searchCount := ceil((yScreenB - yT) / oLvl)
	local offset := 0
	if (startAt > 0) {
		offset := startAt - yScreenB
		searchCount := ceil((startAt - yT) / oLvl)
	}
	local topOffset := offset + yScreenB - yScreenT - oLvl
	local bottomOffset := offset

	; msgbox % "searchCount=" . searchCount . ", offset=" . offset . ", topOffset=" . topOffset . ", bottomOffset=" . bottomOffset

	loop % searchCount
	{
		if (locateImageDown(image, xPos, yPos, absolute, topOffset,, bottomOffset)) {
			return 1
		} else {
			topOffset -= oLvl
			if (A_Index > 1) { ; don't offset bottom until round two
				bottomOffset -= oLvl
			}
		}
	}
	return 0
}

; Top down image search
locateImageDown(image, byref xPos:="", byref yPos:="", absolute:=0, topOffset:=0, leftOffset:=0, bottomOffset:=0, rightOffset:=0) {
	global
	local imageFile := imageFilePath . image.file

	if (yScreenB = 0) {
		return 0 ; CH not started
	}

	local xL := xScreenL
	local yT := yScreenT
	local xR := xScreenR
	local yB := yScreenB

	xL += leftOffset ? leftOffset : image.leftOffset
	yT += topOffset ? topOffset : image.topOffset
	xR += rightOffset ? rightOffset : image.rightOffset
	yB += bottomOffset ? bottomOffset : image.bottomOffset

	; msgbox % "file=" . image.file . ", topOffset=" . image.topOffset . ", leftOffset=" . image.leftOffset . ", bottomOffset=" . image.bottomOffset . ", rightOffset=" . image.rightOffset
	; msgbox % "Searching from (" . xL . ", " . yT . ") to (" . xR . ", " . yB . ")"

	if (xL > xR or yT > yB) {
		msgbox,,% script,% "ImageSearch failed! xL (" . xL . ") > xR (" . xR . ") or yT (" . yT  . ") > yB (" . yB . ")"
		exit
	}
	reFocus()
	ImageSearch xPos, yPos, xL, yT, xR, yB, *30 %imageFile%
	if (ErrorLevel = 2) {
		playWarningSound()
		msgbox,,% script,% "ImageSearch failed! Could not open: " . %imageFile%
		exit
	} else if (ErrorLevel = 0 and !absolute) {
		; Absolute --> Relative
		xPos -= xWinPos
		yPos -= yWinPos
	}
	return !ErrorLevel
}

; Search for a specific pixel color within the given region
locatePixel(pixelColor, xL, yT, xR, yB, byref xPos:="", byref yPos:="") {
	global

	reFocus()
	PixelSearch, xPos, yPos, xL, yT, xR, yB, %pixelColor%,, Fast RGB
	if (ErrorLevel = 0) {
		; Absolute --> Relative
		xPos -= xWinPos
		yPos -= yWinPos
	}
	return !ErrorLevel
}

matchPixelColor(color, x, y) {
	reFocus()
	PixelGetColor, pixelColor, x, y, RGB
	; msgbox % "Is " . pixelColor . " at (" . x . ", " . y . ") equal to " . color . "?"
	return color = pixelColor
}
