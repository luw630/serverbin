FIGHTPOWERTYPE = 1
LEVELTYPE = 2
GLODTYPE = 3
AWARDPOWERTYPE = 0
AWARDLEVELTYPE = 1
AWARDGLODTYPE = 2

PlayerRandAWardData = tostring("RandAWardFlag")     --玩家领取排行奖励的标志，0表示可以领取， 1表示已经领取

--初始化缓存中的排行榜信息
function InitRankInfo()
    if RandInfo == nil then
        RandInfo = LoadTable(RankListData_Path)
    end
    if RandInfo == nil then
        RandInfo = {}
        RandInfo.NextRefreshTime = os.time() + RankRefreshIntervalTime  --记录下次刷新时间
        RandInfo.NextBackRankTime = os.time() + BackRankIntervalTime    --记录下次备份数据的时间
    end
end

--获取玩家排行数据的位置通过玩家的SID，排行榜中的这两个表数据大小相同，并且所占的索引位置也相同
function GetPlayerRandBySID(Type)
    local PlayerSID = GetPlayerData(0, 38)
    if RandInfo == nil then
        RandInfo = LoadTable(RankListData_Path)
    end
    if RandInfo == nil then
        return
    end
    local TempRankInf = deepcopy(RandInfo)
    if Type == FIGHTPOWERTYPE then
        table.sort(TempRankInf, PowerSortFunc)
    elseif Type == LEVELTYPE then
        table.sort(TempRankInf, LevelSortFunc)
    elseif Type == GLODTYPE then
        table.sort(TempRankInf, GlodSordFunc)
    end
    for n, v in pairs(TempRankInf) do
        if type(v) == "table" and v.PlayerSID == PlayerSID then
            return n
        end
    end
end

--添加新玩家到排行数据列表中
function AddNewPlayerToRandData()
    local PlayerSID = GetPlayerData(0, 38)
    local PlayerName = GetPlayerData(0, 28)
    local PlayerPower = GetPlayerData(0, 102)
    local PlayerLevel = GetPlayerData(0, 10)

    local PlayerRechargeTotal = LoadPlayerTable(PlayerRechargeGlod, 0)
    if PlayerRechargeTotal == nil then
        PlayerRechargeTotal = InitPlayerRechargeGlodData(PlayerRechargeTotal)
    end
    local PlayerTotalGlod = PlayerRechargeTotal[1]

    local PlayerSchool = GetPlayerData(0, 23)
    local NewPlayerRandData = {}
    NewPlayerRandData.PlayerSID = PlayerSID
    NewPlayerRandData.PlayerName = PlayerName
    NewPlayerRandData.PlayerPower = PlayerPower
    NewPlayerRandData.PlayerLevel = PlayerLevel
    NewPlayerRandData.PlayerGlod = PlayerTotalGlod
    NewPlayerRandData.PlayerSchool = PlayerSchool

    if RandInfo == nil then
        InitRankInfo()
    end
    local ValidRandDataSize = table.getn(RandInfo)
    local AddPos = ValidRandDataSize + 1

    RandInfo[AddPos] = NewPlayerRandData
end

--判断玩家是否加入到排行榜数据中
function JudgePlayerInRandList()
    local RandPos = GetPlayerRandBySID()
    if RandPos == nil then      --玩家还没有加入到排行数据中
        AddNewPlayerToRandData()
    end
end

--玩家下线时更新在重置时间内可变的排行榜数据，即更新NewRankListData_Path文件
function PlayerLogoutUpdateRandData()
    if RandInfo == nil then
        InitRankInfo()
    end
    local PlayerRandPos = GetPlayerRandBySID()

    if PlayerRandPos == nil then
        return
    end

    local PlayerName = GetPlayerData(0, 28)
    local PlayerPower = GetPlayerData(0, 102)
    local PlayerLevel = GetPlayerData(0, 10)

    local PlayerRechargeTotal = LoadPlayerTable(PlayerRechargeGlod, 0)
    if PlayerRechargeTotal == nil then
        PlayerRechargeTotal = InitPlayerRechargeGlodData(PlayerRechargeTotal)
    end
    local PlayerTotalGlod = PlayerRechargeTotal[1]

    RandInfo[PlayerRandPos].PlayerName = PlayerName
    RandInfo[PlayerRandPos].PlayerPower = PlayerPower
    RandInfo[PlayerRandPos].PlayerLevel = PlayerLevel
    RandInfo[PlayerRandPos].PlayerGlod = PlayerTotalGlod
end

--获取战斗力或者等级或者金币数的前N个玩家数据和玩家自己前面的N-1个玩家（包括玩家自己的数据。如果前面不足N - 1个玩家，有多少显示多少个玩家）
function GetRandDataBySortFunc(Type)
    local SortFunc = nil
    if Type == FIGHTPOWERTYPE then
        SortFunc = PowerSortFunc
    elseif Type == LEVELTYPE then
        SortFunc = LevelSortFunc
    elseif Type == GLODTYPE then
        SortFunc = GlodSordFunc
    else
        return
    end
    if type(SortFunc) ~= "function" then
        return
    end
    if RandInfo == nil then
        InitRankInfo()
    end

    local TempRankInf = deepcopy(RandInfo)
    table.sort(TempRankInf, SortFunc)

    --获取总的玩家数
    local TotalPlayerNum = table.getn(TempRankInf)
    local MaxTopN = 0
    if TotalPlayerNum < ShowTopN then
        MaxTopN = TotalPlayerNum
    else
        MaxTopN = ShowTopN
    end
    
    --获取排行榜最高的N个玩家数据
    local GetTopNData = {}
    for n = 1, MaxTopN do
        GetTopNData[n] = TempRankInf[n]
        GetTopNData[n].PlayerCurRank = n
    end

    --获取玩家排名位置
    local PlayerRandPos = GetPlayerRandBySID(Type)
    if PlayerRandPos == nil then
        return
    end
    local PlayerTopNStartPos = PlayerRandPos - ShowMineTopN + 1
    if PlayerTopNStartPos < 1 then
        PlayerTopNStartPos = 1
    end

    --获取玩家自己和自己前面的N-1个玩家，如果前面不足N - 1个玩家，有多少显示多少个玩家
    local GetPlayerTopNData = {}
    local PlayerTopNDataIndex = 1
    for n = PlayerTopNStartPos, PlayerRandPos do
        GetPlayerTopNData[PlayerTopNDataIndex] = TempRankInf[n]
        GetPlayerTopNData[PlayerTopNDataIndex].PlayerCurRank = n
        PlayerTopNDataIndex = PlayerTopNDataIndex + 1
    end
    return GetTopNData, GetPlayerTopNData
end

--战斗力排序方法
function PowerSortFunc(RandDataA, RandDataB)
    return RandDataA.PlayerPower > RandDataB.PlayerPower
end

--玩家等级排序函数
function LevelSortFunc(RandDataA, RandDataB)
    return RandDataA.PlayerLevel > RandDataB.PlayerLevel
end

--玩家充值金币数排序方法
function GlodSordFunc(RandDataA, RandDataB)
    return RandDataA.PlayerGlod > RandDataB.PlayerGlod
end

--获取排行数据，并按玩家战斗力排序或者玩家等级排序或者玩家充值金币数排序
function GetRandData(Type)
    local TopNData, PlayerTopNData = GetRandDataBySortFunc(Type)
    --发送数据给玩家
    SendRandListData(TopNData, PlayerTopNData, Type)
end

--退出服务器保存排行榜数据
function ExitSaveRankData()
    if RandInfo == nil then
        return
    end
    SaveTable(RankListData_Path, RandInfo)    --备份数据
end

--排行榜数据固定时间备份数据
function JudgeResetRandLoop()
    if RandInfo == nil then
        InitRankInfo()
    end
    local CurrentTime = os.time()

    if RandInfo.NextBackRankTime == nil then
        RandInfo.NextBackRankTime = CurrentTime + BackRankIntervalTime
    end
    if CurrentTime > RandInfo.NextBackRankTime then
        RandInfo.NextBackRankTime = CurrentTime + BackRankIntervalTime
        SaveTable(RankListData_Path, RandInfo)    --备份数据
    end
end

--刷新排行榜数据
function RefreshRankData()
    if RandInfo == nil then
        InitRankInfo()
    end
    local PlayerRandPos = GetPlayerRandBySID()
    if PlayerRandPos == nil then
        return
    end
    local PlayerPower = GetPlayerData(0, 102)
    local PlayerLevel = GetPlayerData(0, 10)

    local PlayerRechargeTotal = LoadPlayerTable(PlayerRechargeGlod, 0)
    if PlayerRechargeTotal == nil then
        PlayerRechargeTotal = InitPlayerRechargeGlodData(PlayerRechargeTotal)
    end

    local PlayerTotalGlod = PlayerRechargeTotal[1]
    RandInfo[PlayerRandPos].PlayerPower = PlayerPower
    RandInfo[PlayerRandPos].PlayerLevel = PlayerLevel
    RandInfo[PlayerRandPos].PlayerGlod = PlayerTotalGlod
end

--判断排行榜奖励是否已经刷新
function JudgeRankAwardIsReset(PreResetTime)    
    local CurrentTime = os.time()

    -- --判断玩家数据释放已经刷新
    -- if RandInfo.NextRefreshTime == nil then
    --     RandInfo.NextRefreshTime = CurrentTime + RankRefreshIntervalTime
    -- end

    -- if CurrentTime > RandInfo.NextRefreshTime then --满足重置
    --     RandInfo.NextRefreshTime = CurrentTime + RankRefreshIntervalTime
    --     local PlayerRandPos = GetPlayerRandBySID()

    --     if PlayerRandPos == nil then
    --         return
    --     end
    --     local PlayerPower = GetPlayerData(0, 102)
    --     local PlayerLevel = GetPlayerData(0, 10)
    --     local PlayerGlod = GetPlayerData(0, 30)
    --     RandInfo[PlayerRandPos].PlayerPower = PlayerPower
    --     RandInfo[PlayerRandPos].PlayerLevel = PlayerLevel
    --     RandInfo[PlayerRandPos].PlayerGlod = PlayerGlod
    -- end

    local CurTime = CurrentTime - RankResetTime    --标准化到24点重置
    local PreTime = PreResetTime - RankResetTime    --标准化到24点重置
    if PreTime < 0 then
        PreTime = 0
    end

    local DayTime = 24 * 60 * 60
    if math.floor(CurTime / DayTime) > math.floor(PreTime / DayTime) then --满足重置
        return 1
    end
    return 0
end

--获取玩家战斗力、等级、金币排行奖励领奖状态
function GetRankAwardFlag()
    local RankAwardInf = LoadPlayerTable(PlayerRandAWardData, 0)
    local IsCanReset = 0
    if RankAwardInf ~= nil then
        IsCanReset = JudgeRankAwardIsReset(RankAwardInf.PreResetTime) 
    end
    if RankAwardInf == nil or IsCanReset == 1 then
        RankAwardInf = {}
        RankAwardInf[1] = PowerAwardMaxNum     --战斗力领奖状态
        RankAwardInf[2] = LevelAwardMaxNum     --等级领奖状态
        RankAwardInf[3] = GlodAwardMaxNum     --金币领奖状态
        RankAwardInf.PreResetTime = os.time();
        WeekReturnChargeData(PlayerRandAWardData, RankAwardInf, 0)
    end
    --发送排行榜标识信息
    SendRandAwardFlag(RankAwardInf)
end

--查询奖励数据通过玩家排名和领取奖励类型
function FindAwardData(PlayerRank, Type)
    if PlayerRank > TopNAward then
        PlayerRank = 0      --领取默认奖励
    end
    for n, v in pairs(RandAwardCfg) do
   -- rfalse("v[1] = " .. tostring(v[1]) .. "   v[2] = " .. tostring(v[2]) .. "   PlayerRank = " .. tostring(PlayerRank) .. "   Type = " .. tostring(Type))
        if v[1] == PlayerRank and v[2] == Type then
            return n
        end
    end
end

--获取奖励范围索引
function GetAwardRangeIndex(RanKRangeID)
    for n, v in pairs(RankAwardRange) do
        if v[1] == RanKRangeID then
            return n
        end
    end
end

--领取排行对应的奖励
function GetRankAwardOpt(Type)
    local PlayerRankPos = GetPlayerRandBySID(Type)
    if PlayerRankPos == nil then
        return
    end
    local RankAwardInf = LoadPlayerTable(PlayerRandAWardData, 0)
    if RankAwardInf == nil then
        SendGetRandAwardRes(0)
        return
    end
    if RankAwardInf[Type] == nil then
        SendGetRandAwardRes(0)
        return
    end
    --领取奖励
    local AwardIndex = FindAwardData(RankAwardInf[Type], Type)
    if AwardIndex == nil then
        SendGetRandAwardRes(0)
        return
    end

    local RankRangeIndex = GetAwardRangeIndex(RankAwardInf[Type])
    if RankRangeIndex == nil then
        return
    end
    --
    if RandAwardCfg[RankRangeIndex] == nil then
        return
    end

    if RankAwardRange[RankRangeIndex][3] - PlayerRankPos < 0 then     --玩家排名下降，不能领取奖励
        SendGetRandAwardRes(0)
        return
    end

    local res = AddSomeGoods(RandAwardCfg[AwardIndex][3])
    if res == 0 then
        SendGetRandAwardRes(0)
        return
    end

    RankAwardInf[Type] = RankAwardInf[Type] - 1

    WeekReturnChargeData(PlayerRandAWardData, RankAwardInf, 0)
    --发送操作结果
    SendGetRandAwardRes(1)
end