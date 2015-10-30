PlayerActivenessData = tostring("PlayerActivenessInf")

--初始化活跃度相关数据
function InitPlayerActivenessInf(PlayerActivenessInf, ResetTime)
    if PlayerActivenessInf == nil then
        PlayerActivenessInf = {}
        PlayerActivenessInf.CurActivenessNum = 0    --玩家当前活跃度大小
        PlayerActivenessInf.ResetTime = ResetTime      --玩家活跃度重置时间
        local AwardNum = table.getn(ActivenessAwardCfg)
        PlayerActivenessInf.GetAwardFlag = {}
        for n = 1, AwardNum do
            PlayerActivenessInf.GetAwardFlag[n] = 0      --玩家领取奖励标识；0表示不能领取、1表示可以领取、2表示已经领取
        end
        local TaskNum = table.getn(ActivenessTaskCfg)
        for n = 1, TaskNum do
            PlayerActivenessInf[n] = 0
        end
        WeekReturnChargeData(PlayerActivenessData, PlayerActivenessInf, 0)
    end
    return PlayerActivenessInf
end

--获得相关任务的活跃度索引
function GetActivenessIndexByTaskType(ActivenessTaskType)
    for n, v in pairs(ActivenessTaskCfg) do
        if v[1] == ActivenessTaskType then
            return n
        end
    end
end

--玩家完成活跃度的相关任务，增加玩家的活跃度
function CompleteAndActiveness(ActivenessTaskType, playergid)
    if playergid == nil then
        playergid = 0
    end
    local PlayerActivenessInf = LoadPlayerTable(PlayerActivenessData, playergid)
    if PlayerActivenessInf == nil then
        PlayerActivenessInf = InitPlayerActivenessInf(PlayerActivenessInf, 0)
    end
    if PlayerActivenessInf[ActivenessTaskType] == nil then
        PlayerActivenessInf[ActivenessTaskType] = 0
    end

    local ActivenessIndex = GetActivenessIndexByTaskType(ActivenessTaskType)
    --没有该任务信息，不能增加玩家活跃度
    if ActivenessIndex == nil then
        return
    end

    --当前完成的任务获得活跃度已达到上限，不能再获得活跃度
    if PlayerActivenessInf[ActivenessTaskType] >= ActivenessTaskCfg[ActivenessIndex][2] then
        return
    end

    --增加该任务完成的次数
    PlayerActivenessInf[ActivenessTaskType] = PlayerActivenessInf[ActivenessTaskType] + 1

    --增加玩家的活跃度
    PlayerActivenessInf.CurActivenessNum = PlayerActivenessInf.CurActivenessNum + ActivenessTaskCfg[ActivenessIndex][3]

    JudgeActivenessAwardCanGet(PlayerActivenessInf.CurActivenessNum, PlayerActivenessInf.GetAwardFlag)  --lua中的表传递参数时为引用参数，在函数里面可做修改

    WeekReturnChargeData(PlayerActivenessData, PlayerActivenessInf, playergid)
end

--判断玩家活跃度奖励是否可以领取并设置为可领取状态
function JudgeActivenessAwardCanGet(CurActivenessNum, AwardFlag)
    if type(AwardFlag) ~= "table" then
        return
    end
    for n, v in pairs(ActivenessAwardCfg) do
        if CurActivenessNum >= v[1] and AwardFlag[n] == 0 then
            AwardFlag[n] = 1
        end 
    end
end

--判断玩家活跃度是否可以重置
function JudgeActivenessCanReset(PreResetTime)
    local CurrentTime = os.time()
    local CurTime = CurrentTime - ActivenessResetTime    --标准化到24点重置
    local PreTime = PreResetTime - ActivenessResetTime    --标准化到24点重置
    if PreTime < 0 then
        PreTime = 0
    end

    local DayTime = 24 * 60 * 60
    if math.floor(CurTime / DayTime) > math.floor(PreTime / DayTime) then --满足重置
        return 1
    end
    return 0
end

--获取玩家活跃度和相关任务完成的次数
function GetActivenessInfo()
    local PlayerActivenessInf = LoadPlayerTable(PlayerActivenessData, 0)
    --获取数据失败
    if PlayerActivenessInf == nil then
        PlayerActivenessInf = InitPlayerActivenessInf(PlayerActivenessInf, 0)
    end

    local ActivenessTaskNum = table.getn(ActivenessTaskCfg)

    --判断是否可以重置
    local ResetRes = JudgeActivenessCanReset(PlayerActivenessInf.ResetTime)
    if ResetRes == 1 then
        local ResetTime = os.time()
        --重置
        PlayerActivenessInf = InitPlayerActivenessInf(nil, ResetTime)
        --保存更新
        WeekReturnChargeData(PlayerActivenessData, PlayerActivenessInf, 0)
    end

    local ActivenessInfTable = {}
    ActivenessInfTable.CurActivenessNum = PlayerActivenessInf.CurActivenessNum

    --任务信息
    ActivenessInfTable.TaskInf = {}
    for n = 1, ActivenessTaskNum do
        if PlayerActivenessInf[n] == nil then
            ActivenessInfTable[n] = 0
        else
            ActivenessInfTable.TaskInf[n] = {}
            ActivenessInfTable.TaskInf[n].TaskCompleteTimes = PlayerActivenessInf[n]
            ActivenessInfTable.TaskInf[n].TaskTotalTimes = ActivenessTaskCfg[n][2]
            ActivenessInfTable.TaskInf[n].SingleGetActiveness = ActivenessTaskCfg[n][3]
            ActivenessInfTable.TaskInf[n].TaskIndex = n
        end
    end

    --奖励信息
    ActivenessInfTable.AwardInf = {}
    for n, v in pairs(ActivenessAwardCfg) do
        ActivenessInfTable.AwardInf[n] = {}
        ActivenessInfTable.AwardInf[n].Awardflag = PlayerActivenessInf.GetAwardFlag[n]
        ActivenessInfTable.AwardInf[n].AwardLevel = n
        ActivenessInfTable.AwardInf[n].NeedActiveness = v[1]
        ActivenessInfTable.AwardInf[n].AwardItemInf = v[2]
    end

    --发送活跃度相关消息
    SendActivenessInfo(ActivenessInfTable)
end

--领取所达到的活跃度相关奖励
function GetActivenessAward(AcitvenessLevel)
    local PlayerActivenessInf = LoadPlayerTable(PlayerActivenessData, 0)
    --获取数据失败
    if PlayerActivenessInf == nil then
        local str = MystringFormat("OPTFAIL")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end
    --判断玩家活跃度领取状态
    if PlayerActivenessInf.GetAwardFlag[AcitvenessLevel] == nil then
        local str = MystringFormat("OPTFAIL")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end

    --玩家没有达到领取奖励要求
    if PlayerActivenessInf.GetAwardFlag[AcitvenessLevel] == 0 then
        local str = MystringFormat("GETFAIL")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end

    --玩家已经领取过了
    if PlayerActivenessInf.GetAwardFlag[AcitvenessLevel] == 2 then
        local str = MystringFormat("HAVEGETED")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end


    --领取奖励
    --统计奖励的道具
    local AwardItem = {}
    local ItemIndex = 1
    for n, v in pairs(ActivenessAwardCfg[AcitvenessLevel][2]) do
        if v[1] == 0 then
            AwardItem[ItemIndex] = v[2]
            AwardItem[ItemIndex + 1] = v[3]
            ItemIndex = ItemIndex + 2
        end
    end

    --领取奖励
    --奖励道具
    if ItemIndex ~= 1 then
        local res = AddSomeGoods(AwardItem)
        if res == 0 then
            return
        end
    end
    --奖励银币，经验，真气
    for n, v in pairs(ActivenessAwardCfg[AcitvenessLevel][2]) do
        if v[1] ~= 0 then
            if v[1] == 1 then
                ChangeMoney(2, v[3])
            elseif v[1] == 2 then
                GiveExp(v[3])
            elseif v[1] == 3 then
                GiveSp(v[3])
            end
        end
    end

    PlayerActivenessInf.GetAwardFlag[AcitvenessLevel] = 2
    --保存更新
    WeekReturnChargeData(PlayerActivenessData, PlayerActivenessInf, 0)

    --发送领取成功消息
    if AcitvenessLevel == 5 then
        --广播给所有在线玩家
        local str = MystringFormat("BROADCASTACTIVEMAX", GetPlayerData(0, 28))
        if str ~= nil then
            SendMessageToAllPlayer(str)
        end
    end
    SendGetActivenessAwardRes(1)
end