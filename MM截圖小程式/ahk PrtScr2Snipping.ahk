#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
; SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
; 
; v.0.9 2018/11/07
;  - 從 windows snipping 改為 line 截圖工具
;  - Ctrl+v 會造成加註後的圖片全黑，改為 Ctrl+c
; v.0.1 2018/06/22
;  - made by csc 
;=====================================================


; 啟動程式時檢測 Win startup 中是否已有捷徑並建立；若無法建立捷徑則開啟路徑並貼上
SplitPath, A_Scriptname, , , , OutNameNoExt 
LinkFile=%A_StartupCommon%\%OutNameNoExt%.lnk 
IfNotExist, %LinkFile% 
    {
        FileCreateShortcut, %A_ScriptFullPath%, %LinkFile% 
        IfNotExist, %LinkFile% 
            IfNotExist, %A_ScriptFullPath%
            {
                Send, ^c
                run, %A_Startup%
                WinWait, Startup
                Send, ^v
            }
    }
SetWorkingDir, %A_ScriptDir%

filename := StrSplit(OutNameNoExt,A_Space)
; msgbox % filename[1]
if (filename[1] = "ctrl")
        Hotkey, ~^printscreen, MyLabel
else if (filename[1] = "alt")
    Hotkey, ~!printscreen, MyLabel
else if (filename[1] = "shift")
    Hotkey, ~+printscreen, MyLabel
else 
    Hotkey, ~printscreen, MyLabel
return


; 啟動剪貼工具，若已啟動則重新擷取
MyLabel:    
    WinGet, id, ID, ahk_exe SnippingTool.exe
    WinGet, idLine, ID, ahk_class Qt5QWindowIcon
    if (idLine != "") {
        ControlSend,,^p,ahk_class Qt5QWindowIcon
    }
    else if (id = "") {
		run SnippingTool.exe
	}
	else {
		WinActivate, ahk_exe SnippingTool.exe
		Send, ^n
	}
return

; 若有安裝mm程式，則切換視窗並貼上
~^c::   ; 用^v會產生黑畫面情況故改為^c
    if WinActive("ahk_class Qt5QWindowToolSaveBits")    ;Qt5QWindowToolTipSaveBits
    {
        ;send ^c
        ;ControlSend,,^c,ahk_class Qt5QWindowToolSaveBits
        ;msgbox, yes
        IfWinExist, ahk_exe Mattermost.exe
        {            
            WinActivate
            send ^+l
            send ^v
        }
        ;else    
            ;msgbox, mm not launching
    }
    
return