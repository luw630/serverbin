TarotCardData = tostring("TarotCardInf")

--初始化玩家塔罗牌数据
function InitPlayerTarotData(TarotInf)
    if TarotInf == nil then
        local MaxTarotNum = table.getn(TarotCfg)
        TarotInf = {}
        TarotInf.TurnOnCard = {}   --翻开的塔罗牌ID，最大能翻开MaxTurnOnTarotNum个
        --for n = 1, MaxTurnOnTarotNum do
            --TarotInf.TurnOnCard[n] = {}
            --TarotInf.TurnOnCard[n][1] = 0   --表示翻开的塔罗牌ID, 为0时表示没有翻开
            --TarotInf.TurnOnCard[n][2] = 0   --表示翻开的塔罗牌位置，范围[1, MaxTarotNum]，当塔罗牌ID为0时，该参数必须为0
        --end
        TarotInf.PreResetTime = 0   --塔罗牌上次重置时间
        TarotInf.IsCanPlayTurnOffCard = 1   --判断玩家是否打开塔罗牌面板5s后播放扣牌动画，为1表示会，为0表示不会
        WeekReturnChargeData(TarotCardData, TarotInf, 0)
    end
    return TarotInf
end

--通过基本数据塔罗牌ID获得该塔罗牌在基本数据中的索引
function GetTarotCfgIndexByID(TarotID)
    for n, v in pairs(TarotCfg) do
        if v[1] == TarotID then
            return n
        end
    end
end

--获取塔罗牌在翻牌区间中的索引通过塔罗牌ID
function GetTurnOnTarotCfgIndexByID(TarotID)
    for n, v in pairs(TurnOnTarotCfg) do
        if v[1] == TarotID then
            return n
        end
    end
end

--获取塔罗牌奖励数据的索引通过塔罗牌奖励数据ID
function GetTarotAwardCfgIndexByID(TarotAwardID)
    for n, v in pairs(TarotAwardCfg) do
        if v[1] == TarotAwardID then
            return n
        end
    end
end

--登陆发送玩家塔罗牌相关数据
function SendPlayerTarotData()
    local PlayerTarotInf = LoadPlayerTable(TarotCardData, 0)
    if PlayerTarotInf == nil then
        PlayerTarotInf = InitPlayerTarotData(PlayerTarotInf)
    end

    --塔罗牌基本数据信息
    local TarotBaseData = deepcopy(TarotCfg)
    for n, v in pairs(TarotBaseData) do
        local ItemID = TarotAwardCfg[v[3]][2]
        local ItemNum = TarotAwardCfg[v[3]][3]
        v[3] = ItemID
        v[4] = ItemNum
    end
    --发送数据
    SendTarotBaseData(PlayerTarotInf.IsCanPlayTurnOffCard, TarotBaseData, PlayerTarotInf.TurnOnCard)
end

--随机抽取一张塔罗牌
function RandomGetTarotID(TarotRange)
    if TarotRange == nil then
        return
    end
    local WeightAll = 0
    --计算权重总值
    for n, v in pairs(TarotRange) do
        WeightAll = WeightAll + v[2]
    end
    local RandomValue = math.random(WeightAll)

    --判断产出的塔罗牌ID
    local EachTarotIDWeight = 0   --每张塔罗牌所占权重比
    for n, v in pairs(TarotRange) do
        --抽取到当前索引的宠物ID
        if RandomValue > EachTarotIDWeight and RandomValue <= EachTarotIDWeight + v[2] then
            return v[1]
        end
        EachTarotIDWeight = EachTarotIDWeight + v[2]
    end
end

--玩家请求翻开一张卡片, 返回卡罗牌的ID
function TurnOnOneTarotCard(TurnOnCardPos)
    local PlayerTarotInf = LoadPlayerTable(TarotCardData, 0)
    if PlayerTarotInf == nil then
        PlayerTarotInf = InitPlayerTarotData(PlayerTarotInf)
    end

    local ItemIsEnough = CheckGoods(TurnOnTarotNeedItemID, 1, 1, 0)
    if ItemIsEnough == false or ItemIsEnough == 0 then
        local str = MystringFormat("ITEMNOTENOUGH")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return 0
    end
    --消耗道具
    DeleteItem(TurnOnTarotNeedItemID, 1)

    --获取当前翻开的塔罗牌数
    local CurTurnOnCardNum = table.getn(PlayerTarotInf.TurnOnCard)

    --卡牌不能再翻开
    if CurTurnOnCardNum >= MaxTurnOnTarotNum then
        return 
    end

    local TarotRange = deepcopy(TurnOnTarotCfg)

    --已经翻开的塔罗牌不在随机范围内
    for n, v in pairs(PlayerTarotInf.TurnOnCard) do
        local TurnOnTarotCfgIndex = GetTurnOnTarotCfgIndexByID(v[1])
        TarotRange[TurnOnTarotCfgIndex] = nil
    end

    --抽取塔罗牌ID
    local TurnOnTarotID = RandomGetTarotID(TarotRange)

    --增加当前翻开的塔罗牌数据
    PlayerTarotInf.TurnOnCard[CurTurnOnCardNum + 1] = {}
    PlayerTarotInf.TurnOnCard[CurTurnOnCardNum + 1][1] = TurnOnTarotID
    PlayerTarotInf.TurnOnCard[CurTurnOnCardNum + 1][2] = TurnOnCardPos
    WeekReturnChargeData(TarotCardData, PlayerTarotInf, 0)

    --发送翻开的塔罗牌数据
    SendAddTurnOnTarotData(CurTurnOnCardNum + 1, TurnOnTarotID, TurnOnCardPos)
end

--领取塔罗牌翻满指定数量后的奖励
function GetTurnOnTarotAward()
    local PlayerTarotInf = LoadPlayerTable(TarotCardData, 0)
    if PlayerTarotInf == nil then
        return
    end

    --奖励
    local AwardItem = {}
    local ItemIndex = 1
    for n, v in pairs(PlayerTarotInf.TurnOnCard) do
        local TarotBaseDataIndex = GetTarotCfgIndexByID(v[1])
        local TarotAwardDataIndex = GetTarotAwardCfgIndexByID(TarotCfg[TarotBaseDataIndex][3])
        if type(TarotAwardCfg[TarotAwardDataIndex]) == "table" then
            AwardItem[ItemIndex] = TarotAwardCfg[TarotAwardDataIndex][2]
            AwardItem[ItemIndex + 1] = TarotAwardCfg[TarotAwardDataIndex][3]
            ItemIndex = ItemIndex + 2
        end
    end
    if ItemIndex ~= 1 then
        local res = AddSomeGoods(AwardItem)
        if res == 0 then
            return
        end
    end

    --重置玩家的塔罗牌数据
    ResetPlayerTarotData(PlayerTarotInf)
    --发送领奖结果
    SendPlayerGetTarotAwardRes(1)
end

--更新玩家塔罗牌播放动画标志
function UptTarotPlayAnimateFlag()
    local PlayerTarotInf = LoadPlayerTable(TarotCardData, 0)
    if PlayerTarotInf == nil then
        return
    end
    PlayerTarotInf.IsCanPlayTurnOffCard = 0
    WeekReturnChargeData(TarotCardData, PlayerTarotInf, 0)
end

--重置玩家的塔罗牌数据
function ResetPlayerTarotData(PlayerTarotInf, CurrentTime)
    if PlayerTarotInf == nil then
        return
    end
    --重置玩家的塔罗牌数据
    PlayerTarotInf.TurnOnCard = {}
    if CurrentTime ~= nil then
        PlayerTarotInf.PreResetTime = CurrentTime     --玩家巨龙山活动上次重置时间
    end
    PlayerTarotInf.IsCanPlayTurnOffCard = 1   --判断玩家是否打开塔罗牌面板5s后播放扣牌动画，为1表示会，为0表示不会
    WeekReturnChargeData(TarotCardData, PlayerTarotInf, 0)

    --发送玩家塔罗牌数据重置
    SendResetTurnOnTarotData()
end

--判断塔罗牌活动是否可以重置, 如果可以就重置
function JugdeTarotIsReset()
    local PlayerTarotInf = LoadPlayerTable(TarotCardData, 0)
    if PlayerTarotInf == nil then
        return
    end
    local CurrentTime = os.time()
    local CurTime = CurrentTime - TarotResetTime    --标准化到24点重置
    local PreTime = PlayerTarotInf.PreResetTime - TarotResetTime    --标准化到24点重置
    if PreTime < 0 then
        PreTime = 0
    end

    local DayTime = 24 * 60 * 60
    if math.floor(CurTime / DayTime) > math.floor(PreTime / DayTime) then --满足重置
        --重置玩家的塔罗牌数据
        ResetPlayerTarotData(PlayerTarotInf, CurrentTime)
    end
end