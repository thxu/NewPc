#If CapsLockMode
WheelDown:: func_scrollRight(15) return
WheelUp:: func_scrollLeft(15) return

;WheelDown:: func_scrollRight_2() return
;WheelUp:: func_scrollLeft_1() return
#If

;虚拟屏幕切换
+WheelDown:: func_SwitchToNextDesktop() return
+WheelUp:: func_SwitchToPrevDesktop() return

#If MouseIsTouchScreenBottom()
WheelDown:: func_SwitchToNextDesktop() return
WheelUp:: func_SwitchToPrevDesktop() return

;WheelDown:: showToolTip("WheelDown") return
;WheelUp:: showToolTip("WheelUp") return
#If


;Tab页切换
#If MouseIsTouchScreenTop()
WheelDown:: func_SwitchToNextTab() return
WheelUp:: func_SwitchToPrevTab() return
#If

;页面滚动
#If MouseIsTouchScreenLeft()
WheelDown:: func_pageDn() return
WheelUp:: func_pageUP() return
#If

#If MouseIsTouchScreenRight()
WheelDown:: func_pageDn() return
WheelUp:: func_pageUP() return
#If


;滚轮向左水平滚动
func_scrollLeft(i:=1){
    ControlGetFocus, fcontrol, A
    Loop %i%
        SendMessage, 0x114, 0, 0, %fcontrol%, A  ; 0x114 is WM_HSCROLL and the 0 after it is SB_LINELEFT.  
    return
}
;滚轮向右水平滚动
func_scrollRight(i:=1){
    ControlGetFocus, fcontrol, A
    Loop %i%
        SendMessage, 0x114, 1, 0, %fcontrol%, A  ; 0x114 is WM_HSCROLL and the 1 after it is SB_LINERIGHT. 
    return
}



;滚轮向左水平滚动
func_scrollLeft_1(){
    MouseClick,WheelLeft,,,15,100,D,R
    return
}
;滚轮向右水平滚动
func_scrollRight_2(){
    MouseClick,WheelRight,,,15,100,D,R
    return
}


func_pageDn(){
    Send {PgDn}
    return
}
func_pageUp(){
    Send {PgUP}
    return
}


func_SwitchToNextDesktop(){
    Send ^#{Right}
    return
}
func_SwitchToPrevDesktop(){
    Send ^#{Left}
    return
}

func_SwitchToNextTab(){
    Send ^{Tab}
    return
}
func_SwitchToPrevTab(){
    Send ^+{Tab}
    return
}


MouseIsTouchScreenBottom(){
    CoordMode, Mouse, Screen ;set coordinates mode to be relative to the whole screen
    MouseGetPos, mX, mY ;store the X coordinate of the mouse in mx
    SysGet, VirtualScreenHeight, 79
    ;aa:=abs(VirtualScreenHeight - mY)
    ;showToolTip(mY . "--" . aa)
    if (abs(VirtualScreenHeight - mY) <= 2 ) ;if the "absolute" difference is within 2 pixels
    {
        return true
    }
    return false
}
MouseIsTouchScreenTop(){
    CoordMode, Mouse, Screen ;set coordinates mode to be relative to the whole screen
    MouseGetPos, mX, mY ;store the X coordinate of the mouse in mx
    SysGet, VirtualScreenWidth, 78
    if (abs(mX) > 2 && abs(VirtualScreenWidth-mX) > 10 && abs(mY) <= 2 ) ;if the "absolute" difference is within 2 pixels
        return true
    return false
}
MouseIsTouchScreenRight(){
    CoordMode, Mouse, Screen ;set coordinates mode to be relative to the whole screen
    MouseGetPos, mX,mY ;store the X coordinate of the mouse in mx*
    SysGet, VirtualScreenWidth, 78
    if (abs(VirtualScreenWidth-mX) <= 10 && mY > 2) ;if the "absolute" difference is within 2 pixels
        return true
    return false
}
MouseIsTouchScreenLeft(){
    CoordMode, Mouse, Screen ; set coordinates mode to be relative to the whole screen
    MouseGetPos, mX,mY ;store the X coordinate of the mouse in mX
    if ( mX <= 2 && abs(mY) > 2) ; if the "absolute" difference is within 2 pixels
        return true
    return false
}