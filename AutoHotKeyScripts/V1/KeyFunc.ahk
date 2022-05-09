;按键绑定
#If CapsLockMode
;上下左右
i:: keyFunc_moveUp(1) return
k:: keyFunc_moveDown(1) return
j:: keyFunc_moveLeft(1) return
l:: keyFunc_moveRight(1) return

;上下左右(加速)
!i:: keyFunc_moveUp(3) return
!k:: keyFunc_moveDown(3) return
!j:: keyFunc_moveLeft(5) return
!l:: keyFunc_moveRight(5) return




;上下左右，选中
+i:: keyFunc_selectUp(1) return
+k:: keyFunc_selectDown(1) return
+j:: keyFunc_selectLeft(1) return
+l:: keyFunc_selectRight(1) return

;上下左右，选中(加速)
!+i:: keyFunc_selectUp(3) return
!+k:: keyFunc_selectDown(3) return
!+j:: keyFunc_selectLeft(5) return
!+l:: keyFunc_selectRight(5) return




;单词移动
n:: keyFunc_moveWordLeft(1) return
m:: keyFunc_moveWordRight(1) return
;单词移动(加速)
!n:: keyFunc_moveWordLeft(3) return
!m:: keyFunc_moveWordRight(3) return

;单词选中
,:: keyFunc_selectWordLeft(1) return
.:: keyFunc_selectWordRight(1) return
;单词选中(加速)
!,:: keyFunc_selectWordLeft(3) return
!.:: keyFunc_selectWordRight(3) return




;选中当前单词
h:: keyFunc_selectCurrentWord() return
;选中当前行
a:: keyFunc_selectCurrentLine() return




;home,end
u:: keyFunc_home() return
o:: keyFunc_end() return
!u:: keyFunc_selectHome() return
!o:: keyFunc_selectEnd() return




;删除
f:: keyFunc_backspace() return
d:: keyFunc_delete() return



;换行
Enter:: keyFunc_enterWherever() return
!Enter:: keyFunc_preEnterWherever() return
Space:: keyFunc_enter() return



;Ctrl+Z,X,C,V
z:: keyFunc_undo() return
x:: keyFunc_cut() return
c:: keyFunc_copy() return
v:: keyFunc_paste() return

;save,quit,closetab
s:: keyFunc_save() return
q:: keyFunc_quit() return
w:: keyFunc_close() return


;前进、后退
e:: keyFunc_back() return
r:: keyFunc_forward() retun 

;vs专用
t:: keyFunc_vsJumpToDefinition() retun
g:: keyFunc_vsJumpToImplementation() retun

#if


;光标上移
keyFunc_moveUp(i:=1){
    SendInput, {up %i%}
    Return
}
;光标下移
keyFunc_moveDown(i:=1){
    SendInput, {down %i%}
    Return
}
;光标左移
keyFunc_moveLeft(i:=1){
    SendInput, {left %i%}
    return
}
;光标右移
keyFunc_moveRight(i:=1){
    SendInput, {right %i%}
    Return
}


;向上选中
keyFunc_selectUp(i:=1){
    SendInput, +{Up %i%}
    return
}
;向下选中
keyFunc_selectDown(i:=1){
    SendInput, +{Down %i%}
    return
}
;向左选中
keyFunc_selectLeft(i:=1){
    SendInput, +{Left %i%}
    return
}
;向右选中
keyFunc_selectRight(i:=1){
    SendInput, +{Right %i%}
    return
}


;光标左移(以单词为单位)
keyFunc_moveWordLeft(i:=1){
    SendInput,^{Left %i%}
    Return
}
;光标右移(以单词为单位)
keyFunc_moveWordRight(i:=1){
    SendInput,^{Right %i%}
    Return
}



;向左选中(以单词为单位)
keyFunc_selectWordLeft(i:=1){
    SendInput, +^{Left %i%}
    return
}
;向右选中(以单词为单位)
keyFunc_selectWordRight(i:=1){
    SendInput, +^{Right %i%}
    return
}



;选中当前单词
keyFunc_selectCurrentWord(){
    SendInput, ^{Left}
    SendInput, +^{Right}
    return
}
;选中当前整行
keyFunc_selectCurrentLine(){
    SendInput, {Home}
    SendInput, +{End}
    return
}



;光标移动至行首
keyFunc_home(){
    SendInput,{Home}
    Return
}
;光标移动至行尾
keyFunc_end(){
    SendInput,{End}
    Return
}
;选中至行首
keyFunc_selectHome(){
    SendInput, +{Home}
    return
}
;选中至行尾
keyFunc_selectEnd(){
    SendInput, +{End}
    return
}



;向前删除
keyFunc_backspace(){
    SendInput,{backspace}
    Return
}
;向后删除
keyFunc_delete(){
    SendInput,{delete}
    Return
}
;向前删除(以单词为单位)
keyFunc_forwardDeleteWord(){
    SendInput, +^{right}
    SendInput, {delete}
    Return
}
;向后删除(以单词为单位)
keyFunc_deleteWord(){
    SendInput, +^{left}
    SendInput, {delete}
    Return
}


;插入新行
keyFunc_preEnterWherever(){
    SendInput,{Home}{Enter}{Left}
    Return
}
;插入新行
keyFunc_enterWherever(){
    SendInput,{End}{Enter}
    Return
}
;换行
keyFunc_enter(){
    SendInput, {Enter}
    Return
}


;ctrl+Z,X,C,V
keyFunc_undo(){
    SendInput, ^z
    Return
}
keyFunc_cut(){
    SendInput, ^x
    Return
}
keyFunc_paste(){
    SendInput, ^v
    Return
}
keyFunc_copy(){
    SendInput, ^c
    Return
}

;保存
keyFunc_save(){
    SendInput, ^s
    Return
}
;强制关闭程序
keyFunc_quit(){
    SendInput, !{F4}
    Return
}
;关闭当前tab
keyFunc_close(){
    SendInput, ^w
    Return
}

;后退
keyFunc_back(){
    SendInput, {XButton1}
    Return
}
;前进
keyFunc_forward(){
    SendInput, {XButton2} 
    Return
}

;跳转到函数定义
keyFunc_vsJumpToDefinition(){
    SendInput, {F12}  
    Return
}
;跳转到函数实现
keyFunc_vsJumpToImplementation(){
    SendInput, ^{F12}  
    Return
}
