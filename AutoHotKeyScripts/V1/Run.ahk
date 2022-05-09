SetStoreCapslockMode, Off
#MaxHotkeysPerInterval 500

global CapsLock2, CapsLockMode

CapsLock::
{
    CapsLock2:=CapsLockMode:=1
    SetTimer, setCapsLock2, -300 ; 300ms 犹豫操作时间
    KeyWait, CapsLock
    CapsLockMode:="" ;Capslock最优先置空，来关闭 Capslock+ 功能的触发
    if (CapsLock2 && A_PriorKey == "CapsLock")
    {
        SetCapsLockState, % GetKeyState("CapsLock","T") ? "Off" : "On"
    }
    CapsLock2:=""
    return
}
setCapsLock2:
{
    CapsLock2:=""
    return
}




showToolTip(tips){
    ToolTip %tips%
    SetTimer removeToolTip, 3000
}
removeToolTip(){
    ToolTip
}



#include KeyFunc.ahk
#include MediaFunc.ahk
#include OtherFunc.ahk
#include WheelFunc.ahk