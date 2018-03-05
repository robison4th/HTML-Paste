#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#CommentFlag //  ; Change to C++ comment style.

// Ctrl+Window+H
^#h::
Clipboard:=""
send,^c
ClipWait, 1

// Replaces double spaces after periods:
Clipboard := regexreplace(Clipboard, ".  ", ". ")

// Replaces double spaces between words:
Clipboard := regexreplace(Clipboard, "  ", " ")

// Replaces fancy characters from MS Word:
Clipboard := regexreplace(Clipboard, "’", "'")
StringReplace, Clipboard,Clipboard,“,", All
StringReplace, Clipboard,Clipboard,”,", All

// Adds domain and email tags to URLs (Links open in new window):
Clipboard := regexreplace(Clipboard, "www.([a-zA-Z0-9_.]*)", "<a href='http://www.$1/' target='_blank'>www.$1</a>")
Clipboard := regexreplace(Clipboard, "([a-zA-Z0-9_.]*)@([a-zA-Z0-9_.]*)", "<a href='mailto:$1@$2'>$1@$2</a>")

// Loops through multiple new lines between paragraphs and removes excess beyond 1:
Loop
{
    StringReplace, Clipboard, Clipboard, `r`n`r`n, `r`n, UseErrorLevel
    if ErrorLevel = 0
        break
}

// When there is a period (or period and space) followed by a new line insert HTML paragraph tags:
// Known bug: The beginning of formatted paste from clipboard lacks opening <p>, but the end of the paste contains a hanging <p> at the end.
StringReplace, Clipboard, Clipboard, . `r`n, .</p>`r`n<p>, All
StringReplace, Clipboard, Clipboard, .`r`n, .</p>`r`n<p>, All
StringReplace, Clipboard, Clipboard, ."`r`n, .</p>`r`n<p>, All

return