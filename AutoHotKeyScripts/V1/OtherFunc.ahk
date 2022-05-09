~LShift:: func_SwitchIme(0) return
~RShift:: func_SwitchIme(1) return
LShift & Space:: func_SwitchIme(1) return





#n::
{
    Run notepads.exe
}


;切换输入法
func_SwitchIme(ime := "A"){
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
    return
}


