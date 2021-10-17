

mouseMove(dx,dy,state){
    if (!IsMouseMoveMode()) {
        return g_mouseMove.stopMove()
    }
    ;showToolTip("----" )
    MouseMove, %dx%, %dy%, 0, R
}



IsMouseMoveMode(){
    aa := CapsLockXMode == 1 && SpaceMode == 1
    ;showToolTip(aa . "----" )
    return aa
}

#if IsMouseMoveMode()



j::
{ 
    ;showToolTip("--33--")
    ;showToolTip(g_mouseMove)
    g_mouseMove.moveLeft()
    return
}
j Up::
{ 
    g_mouseMove.stopmoveLeft()
    return
}

l::
{ 
    g_mouseMove.moveRight()
    return
}
l Up::
{ 
    g_mouseMove.stopmoveRight()
    return
}

i::
{ 
    g_mouseMove.moveUp()
    return
}
i Up::
{ 
    g_mouseMove.stopmoveUp()
    return
}

k::
{ 
    g_mouseMove.moveDown()
    return
}
k Up::
{ 
    g_mouseMove.stopmoveDown()
    return
}

u::mouseClick()
o:: mouseRightClick()
u Up:: SendEvent {Blind}{LButton Up}
o Up:: SendEvent {Blind}{RButton Up}
mouseClick(){                                             
    SendEvent {Blind}{LButton Down}
    KeyWait, u, ; wait forever 防止重复触发
}
mouseRightClick(){
    SendEvent {Blind}{RButton Down}
    KeyWait, o, ; wait forever 防止重复触发
}


#if