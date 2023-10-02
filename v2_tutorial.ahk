; MsgBox "Hello, world!"

; ^1::WinMaximize "A"

; Run "wordpad"

; Run "wordpad.exe `"C:\Program Files\AutoHotkey\license.txt`""
; Run 'wordpad.exe "C:\Program Files\AutoHotkey\license.txt"'

; Run A_ComSpec

; Run 'notepad.exe "' A_MyDocuments '\AutoHotkey.ahk"'

; Run Format('notepad.exe "{1}\AutoHotkey.ahk"', A_MyDocuments)

; Run "cmd", "C:\"

; Run "notepad",,, &pid
; WinWaitActive "ahk_pid " pid
; SendText "Hello, world!"

; Run 'edit ' A_ScriptFullPath

; Run '*Compile-Gui ' A_ScriptFullPath

; Run "cmd /k set pro"

; How to write Hotkey.

; #n::Run "notepad"

; #n::
; {
;     if WinExist("ahk_class Notepad")
;         WinActivate
;     else
;         Run "notepad"
; }
; #はWindows ボタン、Ctrlの^、Altの!、Shiftの+ 替えて組み合わせる
