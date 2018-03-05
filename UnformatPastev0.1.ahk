#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^#c::
Clipboard:=""
send,^c
ClipWait, 1
Clipboard := regexreplace(Clipboard, ".  ", ". ")
Clipboard := regexreplace(Clipboard, "  ", " ")
Clipboard := regexreplace(Clipboard, "’", "'")
StringReplace, Clipboard,Clipboard,“,", All
StringReplace, Clipboard,Clipboard,”,", All
Loop
{
    StringReplace, Clipboard, Clipboard, `r`n`r`n, `r`n, UseErrorLevel
    if ErrorLevel = 0
        break
}
StringReplace, Clipboard, Clipboard, . `r`n, .`r`n, All
return