--初始化本地时间与HTC时间的时间差
function InitTimeDiff()
    local TimeDiffrenceD = os.date("*t", 0)
    TimeDiffrence = TimeDiffrenceD.hour     --记录本地时间与HTC时间的时间差
end
InitTimeDiff()
--判断失乐园是否开放
function JudgeShiLeYuanIsOpen()
    if ShiLeYuOpenTimeInf.OpenFlag == 1 then
        return
    end
    local CurTime = os.time()
    local CurDayTime = math.mod(CurTime + TimeDiffrence * 60 * 60, 24 * 60 * 60)    --本地时间
    for n, v in pairs(ShiLeYuanOpenTimeList) do
        if CurDayTime >= v[1] and CurDayTime <= v[2] then
            if ShiLeYuOpenTimeInf.OpenFlag == 0 then
                ShiLeYuOpenTimeInf.CurOpenTime = CurTime - CurDayTime + v[1]
                ShiLeYuOpenTimeInf.OpenFlag = 1
                --广播失乐园开放标志的更新
                BroadCastShiLeYuanOpenFlag(ShiLeYuOpenTimeInf.OpenFlag)
            end
        else
            if ShiLeYuOpenTimeInf.OpenFlag == 1 then
                ShiLeYuOpenTimeInf.CurOpenTime = 0
                ShiLeYuOpenTimeInf.OpenFlag = 0
                --广播失乐园开放标志的更新
                BroadCastShiLeYuanOpenFlag(ShiLeYuOpenTimeInf.OpenFlag)
            end
        end
    end
end

--判断是否提示失乐园刷新倒计时系统公告
function ShiLeYuanCountDownSysCall(IntervalTime)

    local TempShiLeYuanOpenTimeTip = deepcopy(ShiLeYuanOpenTimeSysCall)
    for n, v in pairs(TempShiLeYuanOpenTimeTip) do
        if IntervalTime <= v[1] and IntervalTime > v[1] - 5 then
            --发送公告
            if v[2] ~= 0 then
                local Msg = MystringFormat("SHILEYUANOPENTIMETIPS", v[1] / 60)
                rfalse(Msg)
                SendSysCall(v[2], Msg, 0)
                v[2] = 0
            end
        end
    end
end

--判断失乐园是否可以提示开放倒计时时间
function JudgeShiLeYuanCanSysCall()
    if ShiLeYuOpenTimeInf.OpenFlag == 1 then
        return
    end
    local CurTime = os.time()
    local CurDayTime = math.mod(CurTime + TimeDiffrence * 60 * 60, 24 * 60 * 60)    --本地时间
    for n, v in pairs(ShiLeYuanOpenTimeList) do
        if CurDayTime < v[1] then
            local IntervalTime = v[1] - CurDayTime
            --判断是否提示失乐园刷新倒计时系统公告
            ShiLeYuanCountDownSysCall(IntervalTime)
            break
        end
    end
end

--失乐园开放时间检测
function JudgeShiLeYuanIsOpenLoop()
    --判断失乐园是否开放
    JudgeShiLeYuanIsOpen()
    --判断失乐园是否可以提示开放倒计时时间
    JudgeShiLeYuanCanSysCall()
end