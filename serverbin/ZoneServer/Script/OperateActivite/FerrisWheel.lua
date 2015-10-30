--FerrisWheelData为全局数据

FerrisWheelData_Path = tostring("Script\\Global\\FerrisWheelData.ldb")      --用于保存幸运摩天轮数据。
--初始化幸运摩天轮数据
function InitFerrisWheelData()
    if FerrisWheelData == nil then
        FerrisWheelData = LoadTable(FerrisWheelData_Path)
    end
    if FerrisWheelData == nil then
        FerrisWheelData = {}
        FerrisWheelData[1] = FerrisWheelOpenTime --开放倒计时时间
        FerrisWheelData[2] = {CurRecordNum = 0;}  --玩家玩幸运摩天轮最新的玩家记录
        -- for n = 1, CurRecordNum do
        --     FerrisWheelData[2][n] = {}
        --     FerrisWheelData[2][n][1] = "PlayerName" --玩家名字
        --     FerrisWheelData[2][n][2] = 190501 --玩家获得的道具ID
        -- end
    end
end

--退出区域服时保存幸运摩天轮数据
function SaveFerrisWheelData()
    local ServerStartTime = GetStartServerTime()
    local CurrentTime = os.time()
    local CurrentReSidueTime = FerrisWheelData[1] - (CurrentTime - ServerStartTime)  --开放倒计时时间
    FerrisWheelData[1] = CurrentReSidueTime --开放倒计时时间
    SaveTable(FerrisWheelData_Path, FerrisWheelData)
end

InitFerrisWheelData()

--玩家幸运摩天轮数据
PlayerFWData = tostring("PlayerFerrisWheelData")

--初始化玩家幸运摩天轮数据
function InitPlayerFWData()
    local PlayerFWInf = {}
    PlayerFWInf[1] = 0  --幸运摩天轮使用的次数
    PlayerFWInf[2] = 0  --幸运摩天轮总的可以使用次数    
    WeekReturnChargeData(PlayerFWData, PlayerFWInf, 0)
end

--通过玩家充值金币总数，计算玩家当前总的可以使用的次数
function CalFWPlayerTatoltimes(RechargeTatolGlod)
    local TatolTimes = math.floor(RechargeTatolGlod/FerrisWheelConsumeGlodNum)
    local PlayerFWInf = LoadPlayerTable(PlayerFWData, 0)
    if PlayerFWInf == nil then
        return
    end
    PlayerFWInf[2] = TatolTimes   
    WeekReturnChargeData(PlayerFWData, PlayerFWInf, 0)
end

--随机获得一个幸运摩天轮选中的信息索引
function RandGetOneFerrisWheel(FerrisWheelRange)
    if FerrisWheelRange == nil then
        return
    end
    local WeightAll = 0
    --计算权重总值
    for n, v in ipairs(FerrisWheelRange) do
        WeightAll = WeightAll + v[4]
    end
    local RandomValue = math.random(WeightAll)

    --判断获得的幸运摩天轮数据
    local EachFerrisWheelWeight = 0   --每个条所占权重比
    for n, v in ipairs(FerrisWheelRange) do
        --抽取到当前索引的宠物ID
        if RandomValue > EachFerrisWheelWeight and RandomValue <= EachFerrisWheelWeight + v[4] then
            return n
        end
        EachFerrisWheelWeight = EachFerrisWheelWeight + v[4]
    end
end

--插入幸运摩天轮记录信息
function InsertFerrisWheelPlayerInf(FerrisWheelIndex)
    --记录玩家玩幸运摩天轮数据信息
    if FerrisWheelData[2].CurRecordNum < FerriWheelShowMaxNum then
        FerrisWheelData[2].CurRecordNum = FerrisWheelData[2].CurRecordNum + 1
    else
        for n = 1, FerrisWheelData[2].CurRecordNum - 1 do
            FerrisWheelData[2][n] = FerrisWheelData[2][n + 1]
        end
    end
    local InsertPos = FerrisWheelData[2].CurRecordNum
    local PlayerName = GetPlayerData(0, 28)
    FerrisWheelData[2][InsertPos] = {}
    FerrisWheelData[2][InsertPos][1] = PlayerName
    FerrisWheelData[2][InsertPos][2] = FerrisWheelDataCfg[FerrisWheelIndex][2]

    --广播幸运摩天轮的记录信息已经变更
    BroadCastFWUptRecordInf(FerrisWheelData[2])
end

--玩家开始玩幸运摩天轮
function PlayerPlayFerrisWheel()
    local PlayerFWInf = LoadPlayerTable(PlayerFWData, 0)
    if PlayerFWInf == nil then
        return
    end

    --次数不足
    if PlayerFWInf[2] - PlayerFWInf[1] == 0 then
        return
    end

    local FerrisWheelIndex = RandGetOneFerrisWheel(FerrisWheelDataCfg)
    --记录玩家玩幸运摩天轮数据信息
    InsertFerrisWheelPlayerInf(FerrisWheelIndex)

    --发送选中的物品序号信息
    SendFWSelectGoodsInf(FerrisWheelDataCfg[FerrisWheelIndex][1])

    PlayerFWInf[1] = PlayerFWInf[1] + 1
    WeekReturnChargeData(PlayerFWData, PlayerFWInf, 0)
end

--获取幸运摩天轮数据索引通过序号ID
function GetFerrisWheelIndexByID(SerialID)
    for n, v in pairs(FerrisWheelDataCfg) do
        return n
    end
end

--获取选中的幸运摩天轮奖励
function GetFerrisWheelAward(SerialID)
    --获取幸运摩天轮数据索引通过序号ID
    local FerrisWheelIndex = GetFerrisWheelIndexByID(SerialID)
    if FerrisWheelDataCfg[FerrisWheelIndex] == nil then
        SendFWGEtAwardRes(0)
        return
    end

    --判断背包剩余空间是否足够
    if GetBlankCell() < 1 then
        local str = MystringFormat("BAGISFULL")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end
    GiveGoods(FerrisWheelDataCfg[FerrisWheelIndex][2], FerrisWheelDataCfg[FerrisWheelIndex][3])
    SendFWGEtAwardRes(1)
end

--获取幸运摩天轮的数据信息(玩家登陆时获得的信息)
function GetFerrisWheelInf()
    --发送幸运摩天轮数据信息
    SendFWInf(FerrisWheelDataCfg, FerrisWheelData[2])
end

--获取玩家幸运摩天轮数据信息(玩家打开摩天轮面板式获得的信息)
function GetFerrisWheelCountDownInf()
    local PlayerFWInf = LoadPlayerTable(PlayerFWData, 0)
    if PlayerFWInf == nil then
        return
    end
    local ServerStartTime = GetStartServerTime()
    local CurrentTime = os.time()
    local CurrentReSidueTime = FerrisWheelData[1] - (CurrentTime - ServerStartTime)  --开放倒计时时间
    --发送玩家幸运摩天轮数据信息
    SendPlayerFWInf(PlayerFWInf[2] - PlayerFWInf[1], CurrentReSidueTime)
end