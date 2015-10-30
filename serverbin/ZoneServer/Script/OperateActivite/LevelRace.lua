--LevelRaceData为全局数据


LevelRaceData_Path = tostring("Script\\Global\\LevelRaceData.ldb")      --用于保存等级竞赛数据。
--初始化等级竞赛数据
function InitLevelRaceData()
    if LevelRaceData == nil then
        LevelRaceData = LoadTable(LevelRaceData_Path)
    end
    if LevelRaceData == nil then
        LevelRaceData = {}
        for n, v in pairs(LevelRaceDataCfg) do
            LevelRaceData[v[1]] = v[3]  --剩余的名额数
        end
    end
end

--退出区域服时保存等级竞赛数据
function SaveLevelRaceData()
    SaveTable(LevelRaceData_Path, LevelRaceData)
end

InitLevelRaceData()

--玩家等级竞赛数据信息
PlayerLevelRaceData = tostring("PlayerLevelRaceData")

--初始化玩家等级竞赛数据信息
function InitPlayerLevelRaceInf()
    local PlayerLevelRaceInf = {}
    for n, v in pairs(LevelRaceDataCfg) do
        PlayerLevelRaceInf[v[1]] = 0  --是否可以领取奖励状态（0为不可以领取，1为可以领取，2为已经领取）
    end
    WeekReturnChargeData(PlayerLevelRaceData, PlayerLevelRaceInf, 0)
end

--判断玩家等级是否进入了等级竞赛名次中
function JudgePlayerIsInLevelRace()
    local PlayerLevel = GetPlayerData(0, 10)
    local PlayerLevelRaceInf = LoadPlayerTable(PlayerLevelRaceData, 0)
    if PlayerLevelRaceInf == nil then
        return
    end
    local UpdateFlag = 0
    for n, v in pairs(LevelRaceDataCfg) do
        if LevelRaceData[v[1]] > 0 and PlayerLevel >= v[2] and PlayerLevelRaceInf[v[1]] == 0 then
            LevelRaceData[v[1]] = LevelRaceData[v[1]] - 1
            PlayerLevelRaceInf[v[1]] = 1

            --广播等级竞赛剩余次数
            BroadCastLRResidueTimes(v[1], LevelRaceData[v[1]])
            --通知玩家可以获得等级竞赛新的奖励
            NotifyLRCanGetNewAward(v[1])
            UpdateFlag = 1
        end
    end
    if UpdateFlag == 1 then
        WeekReturnChargeData(PlayerLevelRaceData, PlayerLevelRaceInf, 0)
    end
end

--获取玩家等级竞赛数据信息
function GetPlayerLevelRaceInf()
    local PlayerLevelRaceInf = LoadPlayerTable(PlayerLevelRaceData, 0)
    if PlayerLevelRaceInf == nil then
        return
    end
    local TempPlayerLevelRaceData = deepcopy(LevelRaceDataCfg)
    for n, v in pairs(TempPlayerLevelRaceData) do
        TempPlayerLevelRaceData[n][5] = PlayerLevelRaceInf[v[1]]   --玩家是否可以领取该限制条件的奖励
        TempPlayerLevelRaceData[n][6] = LevelRaceData[v[1]]   --该等级下剩余的玩家可以进入到该排名中的数量
    end
    --发送等级竞赛数据信息
    SendPlayerLRInf(table.getn(TempPlayerLevelRaceData), TempPlayerLevelRaceData)
end

--获取等级竞赛数据索引，通过ID
function GetLevelRaceIndexByID(DataID)
    for n, v in pairs(LevelRaceDataCfg) do
        if v[1] == DataID then
            return n
        end
    end
end

--玩家领取等级竞赛对应奖励
function PlayerGetLevelRaceAward(DataID)
    local PlayerLevelRaceInf = LoadPlayerTable(PlayerLevelRaceData, 0)
    if PlayerLevelRaceInf == nil then
        --发送失败
        SendGetLRAwardRes(0)
        return
    end

    if PlayerLevelRaceInf[DataID] ==nil or PlayerLevelRaceInf[DataID] ~= 1 then
        --发送失败
        SendGetLRAwardRes(0)
        return 
    end

    --获取等级竞赛数据索引，通过ID
    local LevelRaceIndex = GetLevelRaceIndexByID(DataID)
    --领取奖励
    --统计奖励的道具
    local AwardItem = LevelRaceDataCfg[LevelRaceIndex][4]
    --奖励道具
    if AwardItem ~= nil and table.getn(AwardItem) ~= 0 then
        local res = AddSomeGoods(AwardItem)
        if res == 0 then
            --发送失败消息
            SendGetLRAwardRes(0)
            return
        end
    end

    PlayerLevelRaceInf[DataID] = 2
    WeekReturnChargeData(PlayerLevelRaceData, PlayerLevelRaceInf, 0)
    --发送成功
    SendGetLRAwardRes(1)
end