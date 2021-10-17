

class MoveController{
    __New(moveAction,maxSpeed,ratio){
        this.m_moveAction := moveAction
        this.m_leftDistence := 0
        this.m_rightDistence := 0
        this.m_upDistence := 0
        this.m_downDistence := 0

        this.m_moveDistence:=0

        this.m_maxSpeed := maxSpeed
        this.m_ratio := ratio
        this.m_dampingDecrement := 1

        this.m_a_horizontal := 0
        this.m_a_vertical := 0

        this.m_v_horizontal := 0
        this.m_v_vertical := 0

        this.m_distence_horizontal := 0
        this.m_distence_vertical := 0

        this.m_interval := 10
        this.m_timer := ObjBindMethod(this, "_ticker")

        this.a2 := 1
        this.a3 := 3
        this.aP := 9
    }
    _ticker(distence:=0){
        ;this._tickerLooper2(distence)
         loop, 1 {
            ; 系统默认时钟频率大概64hz，对于刷
            ; 所以这里套一层 Looper 来提高 FPS，提升操作手感
            this._tickerLooper2(distence)
            ; Sleep, 1
        }
    }
    _speedCalculate(time:=0){
        speed := time**2.25 * this.m_ratio
        maxs := this.m_maxSpeed
        
        speed := speed < -maxs ? -maxs : speed
        speed := speed > maxs ? maxs : speed

        return  speed
    }
    _tickerLooper2(distence:=0){
        distence := distence == 0 ? this._QPC():distence

        leftTime := this._dt(this.m_leftDistence, distence), rightTime := this._dt(this.m_rightDistence, distence)
        upTime := this._dt(this.m_upDistence, distence), downTime := this._dt(this.m_downDistence, distence)

        this.m_v_horizontal := - this._speedCalculate(leftTime) + this._speedCalculate(rightTime)
        this.m_v_vertical := - this._speedCalculate(upTime) + this._speedCalculate(downTime)

        ; 快速启动
        ;showToolTip(leftTime)
        if (!this.m_moveDistence) {
            this.m_moveDistence :=1
            this.m_distence_horizontal := this._sign(this.m_v_horizontal)
            this.m_distence_vertical := this._sign(this.m_v_vertical)
        }
        this.m_distence_horizontal += this.m_v_horizontal
        this.m_distence_vertical += this.m_v_vertical

        horizontalDistence := this.m_distence_horizontal | 0  ; 取整输出
        verticalDistence := this.m_distence_vertical | 0  ; 取整输出
        this.m_distence_horizontal -= horizontalDistence      ; 收回零头攒起来
        this.m_distence_vertical -= verticalDistence      ; 收回零头攒起来

        ;showToolTip(horizontalDistence)

        if (horizontalDistence || verticalDistence) {
            this.m_moveAction.Call(horizontalDistence, verticalDistence, "move")
        }
        ; 速度归 0，结束定时器
        if ( !this.m_v_horizontal && !this.m_v_vertical && !(horizontalDistence || verticalDistence)) {
            Return this.stopMove()
        }
    }
    _tickerLooper(distence:=0){
        distence := distence == 0 ? this._QPC():distence
        qpf := this._QPF()
        dt := this.m_moveDistence == 0 ? 0 : ((distence - this.m_moveDistence) / qpf)
        ;showToolTip(distence . "-" . this.m_moveDistence . "/" . qpf . "---" . dt)
        ;dt := this._dt(this.m_moveDistence, distence) 
        this.m_moveDistence := distence


        ; 计算用户操作总时间
        leftTime := this._dt(this.m_leftDistence, distence), rightTime := this._dt(this.m_rightDistence, distence)
        upTime := this._dt(this.m_upDistence, distence), downTime := this._dt(this.m_downDistence, distence)

        ; 处理移动
        this.m_a_horizontal := this._ma(- leftTime + rightTime) * 540 * 2
        this.m_a_vertical := this._ma(- upTime + downTime) * 540 * 2

        ;msg := this.m_v_horizontal . "+" . this.m_a_horizontal . "*" . dt . ";" . this.m_a_horizontal
        ;showToolTip(msg)

        this.m_v_horizontal := this._damping(this.m_v_horizontal + this.m_a_horizontal * dt, this.m_a_horizontal)
        this.m_v_vertical := this._damping(this.m_v_vertical + this.m_a_vertical * dt, this.m_a_vertical)

        
        this.m_distence_horizontal += this.m_v_horizontal * dt
        this.m_distence_vertical += this.m_v_vertical * dt


        horizontalDistence := this.m_distence_horizontal | 0  ; 取整输出
        verticalDistence := this.m_distence_vertical | 0  ; 取整输出
        this.m_distence_horizontal -= horizontalDistence      ; 收回零头攒起来
        this.m_distence_vertical -= verticalDistence      ; 收回零头攒起来


        if (horizontalDistence || verticalDistence) {
            this.m_moveAction.Call(horizontalDistence, verticalDistence, "move")
        }
        ; 速度归 0，结束定时器
        if ( !this.m_v_horizontal && !this.m_v_vertical && !(horizontalDistence || verticalDistence)) {
            Return this.stopMove()
        }
    }
    startMove(){
        this.m_moveDistence :=0
        ;this.ticker()
        timer := this.m_timer
        SetTimer % timer, % this.m_interval
    }
    stopMove(){
        this.m_moveDistence:=0
        this.m_leftDistence := 0
        this.m_rightDistence := 0
        this.m_upDistence := 0
        this.m_downDistence := 0

        this.m_v_horizontal := 0
        this.m_v_vertical := 0

        this.m_distence_horizontal := 0
        this.m_distence_vertical := 0

        timer := this.m_timer
        SetTimer % timer, Off
    }
    moveLeft(){
        ;showToolTip("--11--")
        this.m_leftDistence := this.m_leftDistence?this.m_leftDistence:this._QPC()
        this.startMove()
    }
    stopmoveLeft(){
        this.m_leftDistence:=0
    }

    moveRight(){
        this.m_rightDistence := this.m_rightDistence?this.m_rightDistence:this._QPC()
        this.startMove()
    }
    stopmoveRight(){
        this.m_rightDistence:=0
    }

    moveUp(){
        this.m_upDistence := this.m_upDistence?this.m_upDistence:this._QPC()
        this.startMove()
    }
    stopmoveUp(){
        this.m_upDistence:=0
    }

    moveDown(){
        this.m_downDistence := this.m_downDistence?this.m_downDistence:this._QPC()
        this.startMove()
    }
    stopmoveDown(){
        this.m_downDistence:=0
    }


    _QPF()
    {
        DllCall("QueryPerformanceFrequency", "Int64*", QuadPart)
        Return QuadPart
    }
    _QPC()
    {
        DllCall("QueryPerformanceCounter", "Int64*", Counter)
        Return Counter
    }


    _dt(t, distence)
    {
        Return t ? (distence - t) / this._QPF() : 0
    }
    _ma(_dt)
    {
        a := 0
        a += this.a2 == 0 ? 0 : this.a2 * this._ma2(_dt)
        a += this.a3 == 0 ? 0 : this.a3 * this._ma3(_dt)
        a += this.aP == 0 ? 0 : this.aP * this._maPower(_dt)
        return a
    }
    _ma2(_dt)
    {
        ; x-_dt 二次曲线加速运动模型
        ; 跟现实世界的运动一个感觉，一般都加
        Return this._sign(_dt)
    }
    _ma3(_dt)
    {
        ; x-_dt 三次曲线函数运动模型
        ; 与现实世界不同，
        ; 这个模型会让人感觉鼠标比较“重”
        Return _dt
    }
    _maPower(_dt)
    {
        ; x-_dt 指数曲线运动的简化模型
        ; 这个模型可以满足精确定位需求，也不会感到鼠标“重”
        ; 但是因为跟现实世界的运动曲线不一样，凭直觉比较难判断落点，需要一定练习才能掌握。
        Return this._sign(_dt) * ( Exp(Abs(_dt)) - 1 )
    }
    _sign(x)
    {
        return x == 0 ? 0 : (x > 0 ? 1 : -1)
    }
    _damping(v, a)
    {
        ; 限制最大速度
        maxs := this.m_maxSpeed
        v := v < -maxs ? -maxs : v
        v := v > maxs ? maxs : v
        
        ; 摩擦力不阻碍用户意志，加速度存在时不使用摩擦力
        if ((a > 0 And v > 0) Or (a < 0 And v < 0)) {
            Return v
        }
        
        ; 简单粗暴倍数降速
        v *= 1 - this.m_dampingDecrement
        ; 线性降速
        v -= !this.m_dampingDecrement ? 0 : v > 1 ? 1 : (v < -1 ? -1 : 0)
        ; 零点吸附
        v:= Abs(v) < 1 ? 0 : v
        Return v
    }
}




showToolTip(tips){
    ToolTip %tips%
    SetTimer removeToolTip, 3000
}
removeToolTip(){
    ToolTip
}

