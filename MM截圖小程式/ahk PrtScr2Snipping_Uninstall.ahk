#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
; SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

FileName := "ahk PrtScr2Snipping"
LinkFile=%A_StartupCommon%\%FileName%.lnk 
if FileExist(LinkFile)
    FileDelete, %LinkFile%
SetWorkingDir, %A_ScriptDir%