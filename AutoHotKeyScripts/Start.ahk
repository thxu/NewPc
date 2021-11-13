Process Priority, , High ; 脚本高优先级
#include MoveController.ahk

global g_mouseMove := new MoveController(Func("mouseMove"),130,250)
global g_cursorMove := new MoveController(Func("cursorMove"),5,30)
global g_wheelMove := new MoveController(Func("wheelMove"),3,10)

global CapsLockXMode := 0
global CapsLockX_PreKey := ""
global CapsLockPressTimestamp := 0

#If CapsLockX_Avaliable()
#If !CapsLockX_Avaliable()
#If

Hotkey, If, CapsLockX_Avaliable()
Hotkey CapsLock, CapsLockX_Dn

Hotkey, If, !CapsLockX_Avaliable()

Hotkey, If
Hotkey CapsLock Up, CapsLockX_Up

CapsLockX_Avaliable(){
    return 1
}
CapsLockX_Dn(){
    CapsLockX_PreKey := RegExReplace(A_ThisHotkey, "[\$\*\!\^\+\#\s]")
    CapsLockXMode = 1
    ; 记录 CapsLock 按住的时间
    if ( CapsLockPressTimestamp == 0){
        CapsLockPressTimestamp := A_TickCount
    }
}
CapsLockX_Up(){
    CapsLockXMode = 0
    if(A_PriorKey == CapsLockX_PreKey){
        span := A_TickCount - CapsLockPressTimestamp
        if (CapsLockX_PreKey == "CapsLock" &&  span < 500){
            if (GetKeyState("CapsLock", "T")){
                SetCapsLockState, Off
            } else {
                SetCapsLockState, On
            }
        }
    }
    CapsLockPressTimestamp := 0
}






global SpaceMode := 0
global Space_PreKey := ""

#If Space_Avaliable()
#If !Space_Avaliable()
#If

Hotkey, If, Space_Avaliable()
Hotkey Space, Space_Dn

Hotkey, If, !Space_Avaliable()

Hotkey, If
Hotkey Space Up, Space_Up

Space_Avaliable(){
    return 1
}
Space_Dn(){
    SpaceMode = 1
    if(CapsLockXMode=0){
        SendEvent, {Space}
    }
    ;showToolTip("1")
}
Space_Up(){
    SpaceMode = 0
    ;showToolTip("0")
}






#UseHook

/*
global LShift_PreKey := ""
global LShiftPressTimestamp := 0

#If LShift_Avaliable()
#If !LShift_Avaliable()
#If

Hotkey, If, LShift_Avaliable()
Hotkey LShift, LShift_Dn

Hotkey, If, !LShift_Avaliable()

Hotkey, If
Hotkey LShift Up, LShift_Up

LShift_Avaliable(){
    return 1
}
LShift_Dn(){
    LShift_PreKey := RegExReplace(A_ThisHotkey, "[\$\*\!\^\+\#\s]")
    ; 记录 CapsLock 按住的时间
    if ( LShiftPressTimestamp == 0){
        ;Send, {LShift Down}
        LShiftPressTimestamp := A_TickCount
    }
    ;showToolTip(LShiftPressTimestamp)
}
LShift_Up(){
    if(A_PriorKey == LShift_PreKey){
        span := A_TickCount - LShiftPressTimestamp
        ;showToolTip(span . "-" . LShiftPressTimestamp)
        if (LShift_PreKey == "LShift" &&  span < 500){
            switchime(0)
        }
    }
    LShiftPressTimestamp := 0
    Send, {LShift Up}
}
*/





~LShift::
    LShift_PreKey := RegExReplace(A_ThisHotkey, "[\$\*\!\^\+\#\s\~]")
    LShiftPressTimestamp := A_TickCount
    keywait, LShift

    span := A_TickCount - LShiftPressTimestamp
    ;showToolTip(span)
	if (A_PriorKey == LShift_PreKey && LShift_PreKey == "LShift" &&  span < 500){
        switchime(0)
    }
return


~RShift::
	switchime(1)
return

LShift & Space::
	switchime(1)
return

#UseHook off 

switchime(ime := "A")
{
	if (ime = 1)
    {
		DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str,"00000804", UInt, 1))
	}
    else if (ime = 0)
	{
		DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str,, UInt, 1))
	}
    else if (ime = "A")
	{
		Send, ^{Space}
	}
}
return

#n::
{
    Run notepads.exe
}


#include CursorMove.ahk
#include MouseMove.ahk
#include Quick.ahk