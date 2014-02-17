; Caps Lock -> Ctrl
Capslock::Control

; Right Ctrl -> Caps Lock
RControl::Capslock

; 切换输入法，Left Ctrl-Space -> Ctrl-Shift-Space
LControl & Space::Send {Control down}{Shift down}{Space}{Control up}{Shift up}

#IfWinActive emacs  ; if in emacs
; 复制
LControl & c::Send {Alt down}w{Alt up}
; 粘贴
LControl & v::Send {Control down}y{Control up}
; 剪切
LControl & x::Send {Control down}w{Control up}
; 撤消
LControl & z::Send {Control down}{Shift down}-{Control up}{Shift up}
; 重做
LControl & y::Send {Alt down}{Shift down}-{Alt up}{Shift up}
#IfWinActive        ; end if in emacs