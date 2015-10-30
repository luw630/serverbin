--初始化本地时间与HTC时间的时间差
function InitTimeDiff()
    local TimeDiffrenceD = os.date("*t", 0)
    TimeDiffrence = TimeDiffrenceD.hour     --记录本地时间与HTC时间的时间差
end
InitTimeDiff()
--判断活动是否开放
function JudgeDailyIsOpen(DailyOpenTimeInf, DailyOpentimeList, DailyType)
    if type(DailyOpenTimeInf) ~= "table" then
        return
    end


    local DailyOpenTimeSysCall = nil
    if DailyType == DAILY_SHILEYUAN then
        DailyOpenTimeSysCall = ShiLeYuanOpenTimeSysCall
    elseif DailyType == DAILY_SHENQUANSHAN then
        DailyOpenTimeSysCall = SQSOpenTimeSysCall
    elseif DailyType == DAILY_FORTUNEHILL then
        DailyOpenTimeSysCall = FortuneHillOpenTimeSysCall
    elseif DailyType == GYMKHANA_SENZHILEYUAN then
        DailyOpenTimeSysCall = GymOpenTimeSysCall
    end

    local CurTime = os.time()
    local CurDayTime = math.mod(CurTime + TimeDiffrence * 60 * 60, 24 * 60 * 60)    --本地时间
    local OnceJudgeFlag = 0 
    for n, v in pairs(DailyOpentimeList) do
        if CurDayTime >= v[1] and CurDayTime <= v[2] then
            if DailyOpenTimeInf.OpenFlag == 0 then
                DailyOpenTimeInf.CurOpenTime = CurTime - CurDayTime + v[1]
                DailyOpenTimeInf.OpenFlag = 1
                --广播活动开放标志的更新
                BroadCastDailyOpenFlag(DailyOpenTimeInf.OpenFlag, DailyType)
            end
            return
        end
    end

    if OnceJudgeFlag == 0 then
        if DailyOpenTimeInf.OpenFlag == 1 or DailyOpenTimeInf.CurOpenTime == 0 then
            DailyOpenTimeInf.CurOpenTime = 1
            DailyOpenTimeInf.OpenFlag = 0
            --广播活动开放标志的更新
            BroadCastDailyOpenFlag(DailyOpenTimeInf.OpenFlag, DailyType)
        end
    end
end

--判断是否提示活动刷新倒计时系统公告
function DailyCountDownSysCall(DailyOpenTimeInf, IntervalTime, DailyType)
    local DailyOpenTimeSysCall = nil
    local FormatStr = nil
    if DailyType == DAILY_SHILEYUAN then
        FormatStr = "SHILEYUANOPENTIMETIPS"
        DailyOpenTimeSysCall = ShiLeYuanOpenTimeSysCall
    elseif DailyType == DAILY_SHENQUANSHAN then
        FormatStr = "SHENQUANSHANOPENTIMETIPS"
        DailyOpenTimeSysCall = SQSOpenTimeSysCall
    elseif DailyType == DAILY_FORTUNEHILL then
        FormatStr = "FORTUNEHILLOPENTIMETIPS"
        DailyOpenTimeSysCall = FortuneHillOpenTimeSysCall
    elseif DailyType == GYMKHANA_SENZHILEYUAN then
        FormatStr = "GYMOPENTIMETIPS"
        DailyOpenTimeSysCall = GymOpenTimeSysCall
    end

    if type(DailyOpenTimeSysCall) ~= "table" then
        return
    end

    local TempDailyOpenTimeTip = deepcopy(DailyOpenTimeSysCall)
    for n, v in pairs(TempDailyOpenTimeTip) do
        if IntervalTime <= v[1] and IntervalTime > v[1] - 3 and DailyOpenTimeInf.IsSysCallFlag == 0 then
            --发送公告
            local Msg = MystringFormat(FormatStr, v[1] / 60)
            if v[2] ~= 0 then
                rfalse(Msg)
                SendSysCall(v[2], Msg, 1)
                DailyOpenTimeInf.IsSysCallFlag = 1
                v[2] = 0
            end
            break
        elseif IntervalTime <= v[1] - 3 and IntervalTime > v[1] - 6 and DailyOpenTimeInf.IsSysCallFlag == 1 then
            DailyOpenTimeInf.IsSysCallFlag = 0
            break
        end
    end
end

--判断活动是否可以提示开放倒计时时间
function JudgeDailyCanSysCall(DailyOpenTimeInf, DailyOpentimeList, DailyType)
    if type(DailyOpenTimeInf) ~= "table" or type(DailyOpentimeList) ~= "table" then
        return
    end
    if DailyOpenTimeInf.OpenFlag == 1 then
        return
    end
    local CurTime = os.time()
    local CurDayTime = math.mod(CurTime + TimeDiffrence * 60 * 60, 24 * 60 * 60)    --本地时间
    for n, v in pairs(DailyOpentimeList) do
        if CurDayTime < v[1] then
            local IntervalTime = v[1] - CurDayTime
            --判断是否提示活动刷新倒计时系统公告
            DailyCountDownSysCall(DailyOpenTimeInf, IntervalTime, DailyType)
            break
        end
    end
end

--活动开放时间检测
function JudgeDailyIsOpenLoop()
    --判断失乐园是否开放
    JudgeDailyIsOpen(ShiLeYuOpenTimeInf, ShiLeYuanOpenTimeList, DAILY_SHILEYUAN)
    --判断失乐园是否可以提示开放倒计时时间
    JudgeDailyCanSysCall(ShiLeYuOpenTimeInf, ShiLeYuanOpenTimeList, DAILY_SHILEYUAN)


    --判断神泉山是否开放
    JudgeDailyIsOpen(SQSOpenTimeInf, SQSOpenTimeList, DAILY_SHENQUANSHAN)
    --判断神泉山是否可以提示开放倒计时时间
    JudgeDailyCanSysCall(SQSOpenTimeInf, SQSOpenTimeList, DAILY_SHENQUANSHAN)


    --判断财富山是否开放
    JudgeDailyIsOpen(FortuneHillOpenTimeInf, FortuneHillOpenTimeList, DAILY_FORTUNEHILL)
    --判断财富山是否可以提示开放倒计时时间
    JudgeDailyCanSysCall(FortuneHillOpenTimeInf, FortuneHillOpenTimeList, DAILY_FORTUNEHILL)

    --判断竞技场活动是否开放
    JudgeDailyIsOpen(GymOpenTimeInf, GymOpenTimeList, GYMKHANA_SENZHILEYUAN)
    --判断竞技场是否可以提示开放倒计时时间
    JudgeDailyCanSysCall(GymOpenTimeInf, GymOpenTimeList, GYMKHANA_SENZHILEYUAN)
end