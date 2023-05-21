CoordMode, Mouse, Client                                ; 讓mouse參數不加入win視窗外框
; CTRL+B poe.trade 自動切換密語

; F2 丟倉 買回卷（可用shift買一組）
; Alt+r 回藏身處
; Alt+w ty to last whisper
; F10 加入 global trade 820

; Capslock 喝水(1~5)
; F3 鑑定當前滑鼠 放背包第一排第二格
; ALT+3/4 洗色
; CTRL+= 公會喊++
; Ctrl+i 按住ctrl連點
; 滑鼠鍵4＆5 重置採石場 quarry
; Scrolllock 按住連點洗滌+機會 洗尊師蟲戒
; ALT+Num* 點改造 ALT+Num+ 增副
;; CTRL+滑鼠4 CTRL+滑鼠5
; F11 洗改造增幅 CTRL+F11 關閉
; ritual ctrl+右鍵 暫緩


; $ins:: suspend

; init
char_id = thisismichey
affixWord := "paragon"
affixRecord := ""
rightBlank := false
colNum := 11
price := ""
rect := WindowGetRect("Path of Exile")

; F11::SetTimer,Event_Craft,1000	;F11 打開, 每隔N毫秒
; ^F11::SetTimer,Event_Craft,Off	;F12 關閉

; !NumpadAdd::
!WheelDown::
	clickCurrency("aug")
return

; !NumpadMult::
!WheelUp::
	clickCurrency("alt")
return

Event_Craft:
	 if WinActive("ahk_class POEWindowClass"){        
		eqBase := "Ivory Bow"
		;state = checkAffix(ClipBoard)
		; msgbox, % RegExMatch(ClipBoard,"im)`nIvory Bow")
		send, ^c
		regNeedle = im)(.*%eqBase%.*)
		RegExMatch(ClipBoard,regNeedle, name)
		affixRecord = %affixRecord%`n%name%
		
		FileAppend, `n%name%, D:\DriveC\Documents\My Games\Path of Exile\AffixLog.txt
		sleep, 100
		checkAffixResult(Clipboard, affixWord)
		regNeedle = im)`n%eqBase%
		if (RegExMatch(ClipBoard,regNeedle)>0){
			clickCurrency("aug")
		} else {
			clickCurrency("alt")
		}
		checkAffixResult(Clipboard, affixWord)
    } else {
        SetTimer,Event_Craft,Off
    }

return

clickCurrency(curr){
	rect := WindowGetRect("Path of Exile")
	if (curr="alt"){
		altX := rect.width * 100/1920
		altY := rect.height * 240/976
		MouseClick, right, %altX%, %altY%
		sleep 200
	}else if (curr="aug"){
		augX := rect.width * 210/1920
		augY := rect.height * 290/976
		MouseClick, right, %augX%, %augY%
		sleep 200
	}
	midItemX := rect.width * 300/1920
	midItemY := rect.height * 400/976
	MouseClick,left, %midItemX%,%midItemY%
	sleep, 200
	send, ^c	
	return
}

checkAffixResult(clip, affixWord){
	;msgbox, % affixWord

	if InStr( clip, affixWord){
		SoundPlay *48  ;
		msgbox, %affixWord% get.
		suspend
		pause
	}
	return
}


; 工藝台珠寶洗色
!3::
	rect := WindowGetRect("Path of Exile")

	; 洗兩洞
	2sX := rect.width * 670/1858
	2xY := rect.height * 280/999
	craft_btnX := rect.width * 670/1858
	craft_btnY := rect.height * 845/999
	click , %2sX% , %2xY%
	sleep, 100
	click , %craft_btnX% , %craft_btnY%
	sleep, 100
	; 洗三洞
	3sX := rect.width * 670/1858
	3xY := rect.height * 320/999
	click , %3sX% , %3xY%
	sleep, 100
	click , %craft_btnX% , %craft_btnY%
return
!4::	
	; 洗三洞
	3sX := rect.width * 670/1858
	3xY := rect.height * 320/999
	craft_btnX := rect.width * 670/1858
	craft_btnY := rect.height * 845/999
	click , %3sX% , %3xY%
	sleep, 100
	click , %craft_btnX% , %craft_btnY%
	sleep, 100
	; 洗四洞
	4sX := rect.width * 670/1858
	4xY := rect.height * 360/976
	click , %4sX% , %4xY%
	sleep, 100
	click , %craft_btnX% , %craft_btnY%
return

!r::
	click, right, down
	ClipBoard = /hideout
	sendinput, {enter}^v{enter}
	click, right, up
return

!e::
	click, right, down
	ClipBoard = /exit
	sendinput, {enter}^v{enter}
	click, right, up
return

!w::
	click, right, down
	ClipBoard = tyvm gl hf <3
	sendinput, ^{enter}^v{enter}
	click, right, up
return

!q::
	click, right, down
	ClipBoard = /kick %char_id%
	sendinput, {enter}^v{enter}
	sleep 100
	ClipBoard = /invite lady_abby
	sendinput, {enter}^v{enter}
	click, right, up

return

f10::
	click, right, down
	sendinput, {enter}/global 820{enter}
	sendinput, {enter}/trade 820{enter}
	click, right, up
return

; /::sendinput, {enter}/
^WheelUp::send {left}
^WheelDown::send {right}

; ^Numpad1:: sendinput ^f哈姆雷特
; ^Numpad2:: sendinput ^f特恩之盡
; ^Numpad3:: sendinput ^f普拉克斯瑪
; ^Numpad4:: sendinput ^f伊喬里斯
; ^Numpad5:: sendinput ^f新瓦斯
; ^Numpad6:: sendinput ^f格倫
; ^Numpad7:: sendinput ^f瓦爾多
; ^Numpad8:: sendinput ^f奧斯



; Scrolllock 按住連點洗滌+機會 洗尊師蟲戒
sc046::
	Click, right, 420, 460
	click, 330, 550
	Click, right, 227, 326
	click, 330, 550
return

; 重置 地圖
XButton1::
	; PostMessage, 0x0111, 65306,,, 冰刀.ahk - AutoHotkey  ; pause.
	; send ^{click, 278, 271} ;quarry
	MouseMove, 560, 440
	send ^{click}	; trail square
	sleep 1000
	click, 525, 305
	; PostMessage, 0x0111, 65306,,, 冰刀.ahk - AutoHotkey  ; psue.
return

XButton2::
	click, 485, 326
return

; 新右鍵選單
Menu, Tray, NoStandard
Loop 12
{
	Menu, colSlct, Add, %A_Index%, ColSlct%A_Index%
}

Menu, remainR, Add, Yes, remainRYes
Menu, remainR, Add, No, remainRNo

Menu, Tray, Add, Columns2Click, :colSlct
Menu, Tray, Add, BlankRightSide, :remainR
Menu, Tray, Add ; Separator

Menu, Tray, Standard
return


ColSlct:
	colNum := %A_ThisMenuItemPos%
	Menu, colSlct, ToggleCheck, %A_ThisMenuItem%
	Loop 12 {
		Menu, colSlct, uncheck, %A_Index%
	}
	Menu, colSlct, check, %A_ThisMenuItem%
return

remainRYes:
	rightBlank := true
	Menu, remainR, Check, Yes
	Menu, remainR, Uncheck, No
return
remainRNo:
	rightBlank := false
	Menu, remainR, Uncheck, Yes
	Menu, remainR, Check, No
return


; 3 喝水
CapsLock::
	; Hotkey, CapsLock, off
	sendinput 12345
	; sleep 1500
	; Hotkey, CapsLock, On
return

; 按住CTRL 連點左鍵 買回家捲 
$f2::
	send {ctrl down}
	loop{		; loop start
		if (!GetKeyState("f2","P"))	; 若送入的按鍵未被 按住則中斷迴圈  
		{
			send {ctrl up}
			break			; 中斷
		}
		click
		sleep, 150		; 等待0.5秒
	}
return

; CTRL+= 公會頻喊++
^=::
	send {enter}{^a}{&}{NumpadAdd}{NumpadAdd}{enter}
return

; ritual CTRL右鍵=暫緩物品
+RButton::
	; 先扣掉道具欄寬度再取剩下的中間
	MouseGetPos, xPos, yPos			;記憶目前滑鼠位置	
	; wisdomPosX = 2
	; wisdomPosY = 1
	rect := WindowGetRect("Path of Exile")
    ; MsgBox % rect.width "`n" rect.height
	; 用螢幕高度換算道具欄寬度
	itemW := rect.height * 443 / 720

	; btn position 646,776
	btnX := (rect.width - itemW) / 2
		; msgbox,% btnX
	btnY := rect.height * 776 / 1017
    ; beginPosY := rect.height * .569     ; 410/720
        ; 寬螢幕縮放時道具欄會維持固定比例，W 443 : H 720
        ; 故第一格位置以高度換算後再減去
        ; item width rate = (client width - left top grid X )/client height
        ; beginPosX = client width - (client height * item width rate)
    ; beginPosX := rect.width - (rect.height * 0.576)   
    ;gridW := rect.width * .0273             ; 35/1280
    ; gridH := rect.height * .0486            ; 35/720
    ; gridW := gridH    
	; wisposX := beginPosX + ((wisdomPosX-1)*gridW)
	; wisposY := beginPosY + ((wisdomPosY-1)*gridH)	
	MouseClick, left, %btnX%, %btnY%,,0
	MouseClick, left, %xPos%, %yPos%
	MouseClick, left, %btnX%, %btnY%,,0
	MouseMove, %xPos%, %yPos%,0		;滑鼠移回上一記憶位置
return


; F3 辨識物品
f3 up::
	MouseGetPos, xPos, yPos			;記憶目前滑鼠位置	
	wisdomPosX = 12
	wisdomPosY = 1
	 rect := WindowGetRect("Path of Exile")
    ;MsgBox % rect.width "`n" rect.height
    beginPosY := rect.height * .569     ; 410/720
        ; 寬螢幕縮放時道具欄會維持固定比例，W 443 : H 720
        ; 故第一格位置以高度換算後再減去
        ; item width rate = (client width - left top grid X )/client height
        ; beginPosX = client width - (client height * item width rate)
    beginPosX := rect.width - (rect.height * 0.576)   
    ;gridW := rect.width * .0273             ; 35/1280
    gridH := rect.height * .0486            ; 35/720
    gridW := gridH    
	wisposX := beginPosX + ((wisdomPosX-1)*gridW)
	wisposY := beginPosY + ((wisdomPosY-1)*gridH)
	click, right, %wisposX%, %wisposY%
	click, %xPos%, %yPos%		;滑鼠移回上一記憶位置
return

!f3::
	MouseGetPos, xPos, yPos			;記憶目前滑鼠位置	
	rect := WindowGetRect("Path of Exile")
	sleep 100
	click 
	sleep 150
	click, 900, 500
	sleep 150
	MouseMove, %xPos%, %yPos%,0
return

!z up::
	MouseGetPos, xPos, yPos			;記憶目前滑鼠位置	
	rect := WindowGetRect("Path of Exile")
	w := rect.width/2
	h := rect.height/2	
	; msgbox, %w% %h%
	click, down
	sleep 30
	mouseclick,left, %w%, %h%,,2		;點擊
	; MouseMove , %w%, %h%,2		;滑鼠移回上一記憶位置
	; sleep 30

	click
		; sleep 150

	MouseMove %xPos%, %yPos%,0		;滑鼠移回上一記憶位置
return

/*

!F2::
F2::
	; init
	rightBlank := false
	;Menu, remainR, check, No
	colNum := 10
	;Menu, colSlct, check, 11
	
    numCol := colNum       ; 由左至右點擊行數(共12行)
    ; rightBlank := false     ; 是否將右側設為保留不點擊區域
    rect := WindowGetRect("Path of Exile")
    ;MsgBox % rect.width "`n" rect.height
    beginPosY := rect.height * .569     ; 410/720
        ; 寬螢幕縮放時道具欄會維持固定比例，W 443 : H 720
        ; 故第一格位置以高度換算後再減去
        ; item width rate = (client width - left top grid X )/client height
        ; beginPosX = client width - (client height * item width rate)
    beginPosX := rect.width - (rect.height * 0.576)   
    ;gridW := rect.width * .0273             ; 35/1280
    gridH := rect.height * .0486            ; 35/720
    gridW := gridH    
    
    Loop %numCol% {
        if (rightBlank) ; 若右側要保留區域不點，直接從最左側開始
            posX := beginPosX + ((A_Index - 1) * gridW)            
        else                ; 若左側要留區域不點，扣除保留行數
            posX := beginPosX + (((12-numCol) + A_Index - 1) * gridW)
            
         Loop 5 {
            If GetKeyState("F3", "P") 
                return  
            posY := beginPosY + ((A_Index-1)  * gridH)
            Send ^{Click, %posX%, %posY%}  ; 
        }
    }
return
*/

; 抓視窗尺寸(不含win邊框)
WindowGetRect(windowTitle*) {
    if hwnd := WinExist(windowTitle*) {
        VarSetCapacity(rect, 16, 0)
        DllCall("GetClientRect", "Ptr", hwnd, "Ptr", &rect)
        return {width: NumGet(rect, 8, "Int"), height: NumGet(rect, 12, "Int")}
    }
}

; 
