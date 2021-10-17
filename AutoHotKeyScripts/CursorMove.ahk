wheelMove(dx,dy,state){
    if (!IsCurseMoveMode()) {
        return g_cursorMove.stopMove()
    }
    if(dx < 0){
        wheelLeft(-dx)
    }
    if(dx > 0){
        wheelRight(dx)
    }
    if(dy < 0){
        wheelup(-dy)
    }
    if(dy > 0){
        wheelDown(dy)
    }
}
wheelLeft(n:=1){
    loop %n%{
        SendEvent {WheelLeft}
    }
}
wheelRight(n:=1){
    loop %n%{
        SendEvent {WheelRight}
    }
}
wheelup(n:=1){
    loop %n%{
        SendEvent {WheelUp}
    }
}
wheelDown(n:=1){
    loop %n%{
        SendEvent {WheelDown}
    }
}


cursorMove(dx,dy,state){
    if (!IsCurseMoveMode()) {
        return g_cursorMove.stopMove()
    }
    if(dx < 0){
        pressLeft(-dx)
    }
    if(dx > 0){
        pressRight(dx)
    }
    if(dy < 0){
        pressup(-dy)
    }
    if(dy > 0){
        pressDown(dy)
    }
}
pressLeft(n:=1){
    loop %n%{
        SendEvent {Blind}{Left}
    }
}
pressRight(n:=1){
    loop %n%{
        SendEvent {Blind}{Right}
    }
}
pressup(n:=1){
    loop %n%{
        SendEvent {Blind}{up}
    }
}
pressDown(n:=1){
    loop %n%{
        SendEvent {Blind}{Down}
    }
}


IsCurseMoveMode(){
    aa := CapsLockXMode == 1 && SpaceMode == 0
    ;showToolTip("----" . aa)
    return aa
}

#if IsCurseMoveMode()

j::
{ 
    g_cursorMove.moveLeft()
    return
}
j Up::
{ 
    g_cursorMove.stopmoveLeft()
    return
}

l::
{ 
    g_cursorMove.moveRight()
    return
}
l Up::
{ 
    g_cursorMove.stopmoveRight()
    return
}

i::
{ 
    g_cursorMove.moveUp()
    return
}
i Up::
{ 
    g_cursorMove.stopmoveUp()
    return
}

k::
{ 
    g_cursorMove.moveDown()
    return
}
k Up::
{ 
    g_cursorMove.stopmoveDown()
    return
}
t::Send {F12} 
g::Send ^{F12} 
f::Send {Backspace} 
d::Send {Delete} 
,::Send ^+{Left} 
.::Send ^+{Right} 
y::Send +{Home} 
p::Send +{End}
s::Send ^s
c::Send ^c 
x::Send ^x 
v::Send ^v 
z::Send ^z
q::send !{F4} 
w::Send ^w 
e::send {XButton1}
r::Send {XButton2} 
u:: Send {Home}
o:: Send {End}


a:: 
{
Send {Home} 
Send +{End} 
return 
}

[::
{ 
    g_wheelMove.moveUp()
    return
}
[ Up::
{ 
    g_wheelMove.stopmoveUp()
    return
}

]::
{ 
    g_wheelMove.moveDown()
    return
}
] Up::
{ 
    g_wheelMove.stopmoveDown()
    return
}

h::
{ 
    g_wheelMove.moveLeft()
    return
}
h Up::
{ 
    g_wheelMove.stopmoveLeft()
    return
}

`;::
{ 
    g_wheelMove.moveRight()
    return
}
`; Up::
{ 
    g_wheelMove.stopmoveRight()
    return
}
#if