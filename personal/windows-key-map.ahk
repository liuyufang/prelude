; Caps Lock -> Ctrl
Capslock::Control

; Right Ctrl -> Caps Lock
RControl::Capslock

; 切换输入法，Left Ctrl-Space -> Ctrl-Shift-Space
LControl & Space::Send {Control down}{Shift down}{Space}{Control up}{Shift up}

; #IfWinActive emacs  ; if in emacs
; #IfWinActive        ; end if in emacs