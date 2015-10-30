RechargeFeedBackData = tostring("RechargeFeedBackData")
--获取充值回馈奖励索引通过奖励ID
function GetRFBIndexByID(AwardID)
    for n, v in pairs(RechargeFeedBackAwardCfg) do
        if v[1] == AwardID then
            return n
        end
    end
end

--初始化充值回馈数据信息
function InitRFBData()
    local PlayerRFBInf = {}
    for n, v in pairs(RechargeFeedBackAwardCfg) do
        PlayerRFBInf[v[1]] = 0  --对应奖励状态(0表示不能领取，1表示可以领取，2表示已领取)
    end
    WeekReturnChargeData(RechargeFeedBackData, PlayerRFBInf, 0)
end

--获取玩家充值回馈详细信息
function GetPlayerRFBInf()
    local PlayerRFBInf = LoadPlayerTable(RechargeFeedBackData, 0)
    if PlayerRFBInf == nil then
        return
    end
    local TempRFBInf = deepcopy(RechargeFeedBackAwardCfg)
    for n, v in pairs(TempRFBInf) do
        v[4] = v[3]
        v[3] = PlayerRFBInf[v[1]]
    end

    SendPlayerRFBInf(table.getn(TempRFBInf), TempRFBInf)
end

--判断玩家充值回馈是否有新的奖励可以领取
function JudgeRFBIsAddNewAward(RechargeGlodNum)
    local PlayerRFBInf = LoadPlayerTable(RechargeFeedBackData, 0)
    if PlayerRFBInf == nil then
        return
    end
    for n, v in pairs(RechargeFeedBackAwardCfg) do
        if RechargeGlodNum >= v[2] and PlayerRFBInf[v[1]] == 0 then
            PlayerRFBInf[v[1]] = 1
            --通知有新的奖励可以领取
            NotifyRFBCanGetNewAward(v[1])
        end
    end
    WeekReturnChargeData(RechargeFeedBackData, PlayerRFBInf, 0)
end

--领取指定奖励ID的奖励
function GetSpecRFBAward(AwardID)
    local PlayerRFBInf = LoadPlayerTable(RechargeFeedBackData, 0)
    if PlayerRFBInf == nil then
        --发送失败消息
        SendGetRFBAwardRes(0)
        return
    end
    if PlayerRFBInf[AwardID] ~= 1 then
        --发送失败消息
        SendGetRFBAwardRes(0)
        return 
    end
    local AwardIndex = GetRFBIndexByID(AwardID)
    if RechargeFeedBackAwardCfg[AwardIndex] == nil then
        SendGetRFBAwardRes(0)
        return
    end
    --统计奖励的道具
    local AwardItem = RechargeFeedBackAwardCfg[AwardIndex][3]
    --奖励道具
    if AwardItem ~= nil and table.getn(AwardItem) ~= 0 then
        local res = AddSomeGoods(AwardItem)
        if res == 0 then
            --发送失败消息
            SendGetRFBAwardRes(0)
            return
        end
    end
    --发送失败消息
    SendGetRFBAwardRes(1)
    PlayerRFBInf[AwardID] = 2
    WeekReturnChargeData(RechargeFeedBackData, PlayerRFBInf, 0)
end