#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
; SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
; 2018/06/22
; made by csc v. 0.1
;
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
	if (id = "") {
		run SnippingTool.exe
	}
	else {
		WinActivate, ahk_exe SnippingTool.exe
		Send, ^n
	}
return

; 若有安裝mm程式，則切換視窗並貼上
~$^v::
    if WinActive("ahk_exe SnippingTool.exe")
    {
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
