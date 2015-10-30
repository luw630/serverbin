PlayerJuLongShanInf = tostring("JuLongShanInf")

--初始化玩家巨龙山信息
function InitPlayerJuLongShanInf(PlayerJuLongShanData)
    if PlayerJuLongShanData == nil then
        PlayerJuLongShanData = {}
        PlayerJuLongShanData[1] = 0     --玩家巨龙山活动上次重置时间
        PlayerJuLongShanData[2] = 0     --玩家当天使用巨龙令的次数
        PlayerJuLongShanData[3] = 0     --玩家当天探险的次数
        WeekReturnChargeData(PlayerJuLongShanInf, PlayerJuLongShanData, 0)
    end
    return PlayerJuLongShanData
end

--判断巨龙山活动是否可以重置, 如果可以就重置
function JugdeJuLongShanIsReset(PlayerJuLongShanData)
    local CurrentTime = os.time()
    local CurTime = CurrentTime - JuLongShanResetTime    --标准化到24点重置
    local PreTime = PlayerJuLongShanData[1] - JuLongShanResetTime    --标准化到24点重置
    if PreTime < 0 then
        PreTime = 0
    end

    local DayTime = 24 * 60 * 60
    if math.floor(CurTime / DayTime) > math.floor(PreTime / DayTime) then --满足重置
        PlayerJuLongShanData[1] = CurrentTime     --玩家巨龙山活动上次重置时间
        PlayerJuLongShanData[2] = 0     --玩家当天使用巨龙令的次数
        PlayerJuLongShanData[3] = 0     --玩家当天探险的次数
        WeekReturnChargeData(PlayerJuLongShanInf, PlayerJuLongShanData, 0)
    end
end

--随机获得巨龙山的一个奖励
function RandomGetJuLongShanAward(AwardRange)
    if AwardRange == nil then
        return
    end
    local WeightAll = 0
    --计算权重总值
    for n, v in ipairs(AwardRange) do
        WeightAll = WeightAll + v[3]
    end
    local RandomValue = math.random(WeightAll)

    --判断产出的材料
    local EachGoodsIDWeight = 0   --每个材料所占权重比
    for n, v in ipairs(AwardRange) do
        --抽取到当前索引的宠物ID
        if RandomValue > EachGoodsIDWeight and RandomValue <= EachGoodsIDWeight + v[3] then
            return v
        end
        EachGoodsIDWeight = EachGoodsIDWeight + v[3]
    end
end

--使用巨龙令开始探险
function JuLongShanRisk()
    local PlayerJuLongShanData = LoadPlayerTable(PlayerJuLongShanInf, 0)
    if PlayerJuLongShanData == nil then
        PlayerJuLongShanData = InitPlayerJuLongShanInf(PlayerJuLongShanData)
    end

    --判断巨龙山活动是否可以重置, 如果可以就重置
    JugdeJuLongShanIsReset(PlayerJuLongShanData)

    local PlayerJuLongShanRiskResume = GetResumeByRiskTimes(PlayerJuLongShanData[3])    --获取玩家探险消耗信息

    --判断巨龙令道具是否足够
    local ItemIsEnough = CheckGoods(PlayerJuLongShanRiskResume[1], PlayerJuLongShanRiskResume[2], 1, 0)
    if ItemIsEnough == false or ItemIsEnough == 0 then
        local str = MystringFormat("ITEMNOTENOUGH")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
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
    
    --消耗道具
    DeleteItem(PlayerJuLongShanRiskResume[1], PlayerJuLongShanRiskResume[2])
rfalse("PlayerJuLongShanData[2] = " .. tostring(PlayerJuLongShanData[2]))
    local JuLongShanRiskRange = nil
	if PlayerJuLongShanData[2] < 10 then
        JuLongShanRiskRange = JuLongShanLT10Cfg
    elseif PlayerJuLongShanData[2] == 10 then
        JuLongShanRiskRange = JuLongShanE10Cfg
	elseif PlayerJuLongShanData[2] >= 11 and PlayerJuLongShanData[2] < 15 then
		JuLongShanRiskRange = JuLongShanLT15AndGE11Cfg
    elseif PlayerJuLongShanData[2] == 15 then
        JuLongShanRiskRange = JuLongShanE15Cfg
	elseif PlayerJuLongShanData[2] >= 15 and PlayerJuLongShanData[2] < 20 then
		JuLongShanRiskRange = JuLongShanLT20AndGE16Cfg
    elseif PlayerJuLongShanData[2] == 20 then
        JuLongShanRiskRange = JuLongE20Cfg
	elseif PlayerJuLongShanData[2] > 20 then
		JuLongShanRiskRange = JuLongShanGT20Cfg
    end

    local JuLongShanRiskRes = RandomGetJuLongShanAward(JuLongShanRiskRange)

    local AwardType = JuLongShanRiskRes[1]
    local AwardItemID = JuLongShanRiskRes[4]
    local AwardGoodsNum = JuLongShanRiskRes[5]
    local PlotDialogueInf = PlotDialogueCfg[JuLongShanRiskRes[2]]

    if AwardType == 1 then
        GiveGoods(AwardItemID, AwardGoodsNum)
    elseif AwardType == 2 then
        AwardGoodsNum = JuLongShanExpCal(AwardGoodsNum)
        GiveExp(AwardGoodsNum)
    elseif AwardType == 3 then
        AwardGoodsNum = JuLongShanYinBiCal(AwardGoodsNum)
        ChangeMoney(2, AwardGoodsNum)
    elseif AwardType == 4 then
        AwardGoodsNum = JuLongShanSpCal(AwardGoodsNum)
        GiveSp(AwardGoodsNum)
    end

    --发送探险奖励信息
    SendJuLongShanAward(AwardType, AwardItemID, AwardGoodsNum, PlotDialogueInf)

    --判断是否要全服公告
    if JuLongShanRiskRes[6] == 1 then
        --广播给所有在线玩家
        local str = MystringFormat("BROADCASTACTIVEMAX", GetPlayerData(0, 28))
        if str ~= nil then
            SendMessageToAllPlayer(str)
        end
    end
	PlayerJuLongShanData[2] = PlayerJuLongShanData[2] + 1
    WeekReturnChargeData(PlayerJuLongShanInf, PlayerJuLongShanData, 0)
end

--获得探险消耗信息通过当天探险次数
function GetResumeByRiskTimes(RiskTimes)
    if UseJuLongLingCfg[RiskTimes] == nil then
        return UseJuLongLingCfg[table.getn(UseJuLongLingCfg)]
    end
    return UseJuLongLingCfg[RiskTimes]
end
