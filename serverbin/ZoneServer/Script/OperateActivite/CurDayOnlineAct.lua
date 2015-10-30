--玩家每日在线时长相关数据信息
CurDayOnlineData = tostring("CurDayOnlineInf")

--新玩家第一次登陆初始化玩家每日在线时长相关数据
function FLInitCurDayOnlineData()
    local PlayerCurDayOnlineData = {}
    PlayerCurDayOnlineData[1] = os.time()   --保存玩家当天每次上线时间，如果玩家一直在线到第二天，则该值重置为当天的重置时间，该参数只用于每日在线时长奖励
    PlayerCurDayOnlineData[2] = 0   --保存玩家下线时，当天总的在线时间，在玩家退出时保存一次
    PlayerCurDayOnlineData[3] = {}     --保存玩家当前在线时长奖励领取状态信息
    for n, v in pairs(CurDayOnlineAwardCfg) do
        PlayerCurDayOnlineData[3][n] = 0    --领取奖励标识（0标识不能领取，1标识可以领取，2标识已经领取）
    end
    PlayerCurDayOnlineData[4] = 0   --保存玩家上一次重置时间
    WeekReturnChargeData(CurDayOnlineData, PlayerCurDayOnlineData, 0)
end

--设置玩家当天每次登陆时的时间
function SetCurDayOnlineLoginTime()
    local PlayerCurDayOnlineData = LoadPlayerTable(CurDayOnlineData, 0)
    if PlayerCurDayOnlineData == nil then
        return
    end
    PlayerCurDayOnlineData[1] = os.time()
    WeekReturnChargeData(CurDayOnlineData, PlayerCurDayOnlineData, 0)
end

--保存玩家下线时玩家当前总的在线时间
function SaveCurDayOnlineTime()
    local PlayerCurDayOnlineData = LoadPlayerTable(CurDayOnlineData, 0)
    if PlayerCurDayOnlineData == nil then
        return
    end
    local CurrentTime = os.time()
    local CurDayOnlineTime = GetCurDayAllOnlineTime(PlayerCurDayOnlineData, CurrentTime)  --当前玩家当天总的在线时间
    PlayerCurDayOnlineData[2] = CurDayOnlineTime
    WeekReturnChargeData(CurDayOnlineData, PlayerCurDayOnlineData, 0)
end

--重置每日在线时长领取奖励活动的玩家数据
function ResetCurDayOnlinePlayerData(PlayerCurDayOnlineData, CurrentTime)
    if PlayerCurDayOnlineData == nil then
        return
    end
    PlayerCurDayOnlineData[1] = CurrentTime
    PlayerCurDayOnlineData[2] = 0
    PlayerCurDayOnlineData[4] = CurrentTime
    for n, v in pairs(CurDayOnlineAwardCfg) do
        PlayerCurDayOnlineData[3][n] = 0    --领取奖励标识（0标识不能领取，1标识可以领取，2标识已经领取）
    end
    WeekReturnChargeData(CurDayOnlineData, PlayerCurDayOnlineData, 0)
end

--判断每日在线时长领取奖励活动是否重置
function JudgeCurDayOnlineIsReset()
    local PlayerCurDayOnlineData = LoadPlayerTable(CurDayOnlineData, 0)
    if PlayerCurDayOnlineData == nil then
        return
    end
    local CurrentTime = os.time()
    local CurTime = CurrentTime - CurDayOnlineResetTime    --标准化到24点重置
    local PreTime = PlayerCurDayOnlineData[4] - CurDayOnlineResetTime    --标准化到24点重置
    if PreTime < 0 then
        PreTime = 0
    end

    local DayTime = 24 * 60 * 60
    if math.floor(CurTime / DayTime) > math.floor(PreTime / DayTime) then --满足重置
        --重置每日在线时长领取奖励活动的玩家数据
        ResetCurDayOnlinePlayerData(PlayerCurDayOnlineData, CurrentTime)

        --通知玩家重置
        NotifyCurDayOnlineReset()
    end
end

--获取当前玩家当天总的在线时间
function GetCurDayAllOnlineTime(PlayerCurDayOnlineData, CurrentTime)
    if PlayerCurDayOnlineData == nil then
        return 0
    end
    return PlayerCurDayOnlineData[2] + (CurrentTime - PlayerCurDayOnlineData[1])  --当前玩家当天总的在线时间
end

--判断每日在线时长领取奖励活动中是否有新达到领取奖励状态的奖励
function JudgeCurDayOnlineIsAddAward()
    local PlayerCurDayOnlineData = LoadPlayerTable(CurDayOnlineData, 0)
    if PlayerCurDayOnlineData == nil then
        return
    end
    local CurrentTime = os.time()
    local CurDayOnlineTime = GetCurDayAllOnlineTime(PlayerCurDayOnlineData, CurrentTime)  --当前玩家当天总的在线时间
    local HaveChangedFlag = 0   --是否有达到新增一个奖励标识，为0标识没有，为1表示有
    for n, v in pairs(CurDayOnlineAwardCfg) do
        if CurDayOnlineTime >= v[2] and PlayerCurDayOnlineData[3][n] == 0 then
            PlayerCurDayOnlineData[3][n] = 1
            HaveChangedFlag = 1

            --通知玩家
            NotifyCurDayOnlineAddNewAward(v[1])
        end
    end
    if HaveChangedFlag == 1 then
        WeekReturnChargeData(CurDayOnlineData, PlayerCurDayOnlineData, 0)
    end
end

--发送玩家每日在线时长奖励数据
function SendPlayerCurDayOnlineData()
    local PlayerCurDayOnlineData = LoadPlayerTable(CurDayOnlineData, 0)
    if PlayerCurDayOnlineData == nil then
        return
    end
    local TempPlayerOnlineData = {}
    local DataSize = 0
    for n, v in pairs(CurDayOnlineAwardCfg) do
        TempPlayerOnlineData[n] = {}
        TempPlayerOnlineData[n][1] = v[1]   --玩家当天在线级别ID
        TempPlayerOnlineData[n][2] = PlayerCurDayOnlineData[3][n]   --奖励状态（0标识不能领取，1标识可以领取，2标识已经领取）
        TempPlayerOnlineData[n][3] = v[2]   --需要在线时长时间
        TempPlayerOnlineData[n][4] = v[4]   --奖励的道具ID
        TempPlayerOnlineData[n][5] = v[5]   --奖励数量（为道具（除经验、真气、信仰之力、银币之外的道具）为道具的数量，否则为实际的奖励值）
        DataSize = DataSize + 1
    end

    --发送数据
    SendCurDayOnlineData(DataSize, TempPlayerOnlineData)
end

--获得玩家当天在线时长
function GetCurDayOnlineLong()
    local PlayerCurDayOnlineData = LoadPlayerTable(CurDayOnlineData, 0)
    if PlayerCurDayOnlineData == nil then
        return
    end
    local CurrentTime = os.time()
    local CurDayOnlineTime = GetCurDayAllOnlineTime(PlayerCurDayOnlineData, CurrentTime)

    --发送消息
    SendCurDayOnlineLong(CurDayOnlineTime)
end

--领取在线时长的奖励
function GetCurDayOnlineAward(CurDayOnlineLevelID)  --CurDayOnlineLevelID如果为0，表示领取所有可以领取的奖励
    local PlayerCurDayOnlineData = LoadPlayerTable(CurDayOnlineData, 0)
    if PlayerCurDayOnlineData == nil then
        return
    end
    local Ret = 0
    if CurDayOnlineLevelID ~= 0 then --领取指定级别ID的奖励
        Ret = GetCurDayOnlineSpecAward(PlayerCurDayOnlineData, CurDayOnlineLevelID)
    else --领取所有可以领取的奖励
        Ret = GetCurDayOnlineAllAward(PlayerCurDayOnlineData)
    end

    if Ret == 0 then
        SendCurDayOnlineGetAwardRes(0)
        return
    end
    WeekReturnChargeData(CurDayOnlineData, PlayerCurDayOnlineData, 0)
    SendCurDayOnlineGetAwardRes(1)
end

--领取所有可以领取的奖励
function GetCurDayOnlineAllAward(PlayerCurDayOnlineData)
    --统计奖励的道具
    local AwardItem = {}
    local ItemIndex = 1
    for n, v in pairs(PlayerCurDayOnlineData[3]) do
        if PlayerCurDayOnlineData[3][n] == 1 then
            if CurDayOnlineAwardCfg[n][3] == 1 then
                AwardItem[ItemIndex] = CurDayOnlineAwardCfg[n][4]
                AwardItem[ItemIndex + 1] = CurDayOnlineAwardCfg[n][5]
                ItemIndex = ItemIndex + 2
            end
        end
    end

    --奖励道具
    if ItemIndex ~= 1 then
        local res = AddSomeGoods(AwardItem)
        if res == 0 then
            return 0
        end
    end
    for n, v in pairs(PlayerCurDayOnlineData[3]) do
        if PlayerCurDayOnlineData[3][n] == 1 then
            PlayerCurDayOnlineData[3][n] = 2
        end
    end
    return 1
end

--领取指定级别ID的奖励
function GetCurDayOnlineSpecAward(PlayerCurDayOnlineData, CurDayOnlineLevelID)
    if PlayerCurDayOnlineData[3][CurDayOnlineLevelID] == nil or CurDayOnlineAwardCfg[CurDayOnlineLevelID] == nil then
        return 0
    end

    if PlayerCurDayOnlineData[3][CurDayOnlineLevelID] ~= 1 then
        return 0
    end
    --判断背包剩余空间是否足够
    if GetBlankCell() < 1 then
        local str = MystringFormat("BAGISFULL")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return 0
    end

    if CurDayOnlineAwardCfg[CurDayOnlineLevelID][3] == 1 then   --奖励道具
        GiveGoods(CurDayOnlineAwardCfg[CurDayOnlineLevelID][4], CurDayOnlineAwardCfg[CurDayOnlineLevelID][5])
    end
    PlayerCurDayOnlineData[3][CurDayOnlineLevelID] = 2
    return 1
end
