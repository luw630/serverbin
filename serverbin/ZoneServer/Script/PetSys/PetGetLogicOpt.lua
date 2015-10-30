--品质类型
BLUEQUALITY = 1 --蓝色品质
PURPLEQUALITY = 2   --紫色品质
ORANGEQUALITY = 3   --橙色品质

--宠物抽取类型
FREEEXTRA = 1   --免费抽取方式
PAYONECEXTRA = 2 --付费抽取一次方式
PAYMANYTIMESEXTRA = 3  --付费抽取多次方式
GAMBLECARD = 4      --赌博性质的卡牌
EXTRAHIGHQUALITYPET = 5  --抽取一次高品质的宠物；主要拥有抽取多次的情况，必须至少抽取的宠物中有高品质的宠物

PetMaxNum = 99  --玩家最多可以拥有的宠物数量


--宠物基本数据最大限制信息
--参数依次为：最大战斗力、最大成长经验、最大携带经验、最大魂力、最大等级
PetsBaseLimitData = {10^9, 10^10, 10^10, 10000, 100}

--玩家宠物卡牌下次可以领取的时间
PetCardNextRefreshData = tostring("PetCardNextRefreshTime")

--返回玩家变身间隔时间
function ReturnPlayerTranLimit()
    return PlayerTranIntervalTime
end

--死亡变身的冷却时间
function ReturnPlayerDieTranLimit()
    return DieTranIntervalTime
end

--获取宠物基本属性通过宠物索引和相关字段索引
function GetPetBaseProperties(PetIndex, PetPropertyID)
    return PetsBaseDataList[PetIndex][PetPropertyID]
end

--返回宠物战斗基本属性的索引
function ReturnFightBaseIndex(PetBaseDataID)    
    local PetBaseDataIndex = nil
    for n, v in pairs(CreatePetsDataList) do
        if v[1] == PetBaseDataID then
            PetBaseDataIndex = n
        end
    end
    return PetBaseDataIndex
end

--返回宠物技能数据的索引
function ReturnPetSkillIndex(PetSkillID)    
    local PetSkillIndex = nil
    for n, v in pairs(PetsSkillList) do
        if v[1] == PetSkillID then
            PetSkillIndex = n
        end
    end
    return PetSkillIndex
end

--获取宠物战斗基本属性通过基本数据索引和相关的字段索引
function GetPetFightBaseProperties(PetBaseDataID, PetFightPropertyID)
    local PetBaseDataIndex = ReturnFightBaseIndex(PetBaseDataID)
    if PetBaseDataIndex ~= nil then
        return CreatePetsDataList[PetBaseDataIndex][PetFightPropertyID]
    end
end

--初始化宠物卡牌倒计时相关数据信息
function InitPetCardCountDown(PetCardData, GID)
    if PetCardData == nil then
        PetCardData = {}
        for n, v in pairs(CardExtracteConfig) do
            if v.ConsumeJinBi == 0 then     --免费的有刷新时间
                PetCardData[n] = 0      --当前时间如果大于下次可以抽取时间，则表示玩家可以抽取卡牌
            end
        end
        WeekReturnChargeData(PetCardNextRefreshData,PetCardData, GID)
    end
end

--获取卡牌的宠物信息
function GetCardPetInfo(CardType)
    local TempPetIDArr = {}     --保存卡牌中可以产出宠物的ID数据
    local PetIDNum = 0
    for n, v in ipairs(CardExtracteConfig[CardType]) do
        if v[1] ~= nil then
            PetIDNum = PetIDNum + 1
            TempPetIDArr[PetIDNum] = v[1]
        end
    end
    --发送卡牌中可以产出宠物的信息
    SendCardPetInf(TempPetIDArr)
end

--获取宠物的卡牌信息
function GetPetCardInfo()
    local PetCardNextRefreshTimeDt = LoadPlayerTable(PetCardNextRefreshData, 0)
    if PetCardNextRefreshTimeDt == nil then
        InitPetCardCountDown(PetCardNextRefreshTimeDt, 0)
        PetCardNextRefreshTimeDt = LoadPlayerTable(PetCardNextRefreshData, 0)
    end

    local NowTime = os.time()
    local CardCountDownTime = {}
    for n, v in pairs(PetCardNextRefreshTimeDt) do
        if PetCardNextRefreshTimeDt[n] == nil then   --付费的卡牌没有倒计时限制
            CardCountDownTime[n] = 0
        else
            CardCountDownTime[n] = PetCardNextRefreshTimeDt[n] - NowTime
            if CardCountDownTime[n] < 0 then
                CardCountDownTime[n] = 0
            end
        end
    end
    --发送宠物卡牌信息
    SendPetCardInf(CardExtracteConfig, CardCountDownTime)
end

--获取宠物的详细信息的索引
function GetPetDataIndex(PetID, PetLevel)
    local PetIndex = nil
    for n, v in pairs(PetsBaseDataList) do
        if v[1] == PetID and v[3] == PetLevel then
            PetIndex = n
            return PetIndex
        end
    end
end

--获取指定宠物ID的品质
function GetPetQuality(PetID)
    for n, v in pairs(PetsBaseDataList) do
        if v[1] == PetID and v[5] == 1 then
            return v[2]
        end
    end
end

--抽取一次产出的宠物ID
function GetPetIDByExtracteOnce(ExtracteRange)
    local WeightAll = 0
    --计算权重总值
    for n, v in ipairs(ExtracteRange) do
        WeightAll = WeightAll + v[2]
    end
    local RandomValue = math.random(WeightAll)

    --判断产出的宠物ID
    local EachPetIDWeight = 0   --每个宠物所占权重比
    for n, v in ipairs(ExtracteRange) do
        --抽取到当前索引的宠物ID
        if RandomValue > EachPetIDWeight and RandomValue <= EachPetIDWeight + v[2] then
            if v[1] == nil and v[3] ~= nil then --赌博性质的卡牌没有抽取到宠物，根据第三个参加奖励经验
                GiveExp(v[3])   --奖励经验
                local str = MystringFormat("GAME_EXTRACT_GETEXP")
                if str ~= nil then
                    TalkToPlayer(2,str)
                end
                    end
            return v[1]     --抽取到的宠物ID
        end
        EachPetIDWeight = EachPetIDWeight + v[2]
    end
end

--判断卡牌是否可以抽取，如果可以，返回true并更新卡牌下次可以领取的时间
function JuageIsCanExtractCard(ExtracteType)
    if CardExtracteConfig[ExtracteType] ~= nil then
        local NowTime = os.time()
        local PetCardNextRefreshTimeDt = LoadPlayerTable(PetCardNextRefreshData, 0)
        if PetCardNextRefreshTimeDt == nil then
            InitPetCardCountDown(PetCardNextRefreshTimeDt, 0)
            PetCardNextRefreshTimeDt = LoadPlayerTable(PetCardNextRefreshData, 0)
        end
        if PetCardNextRefreshTimeDt[ExtracteType] == nil then   --付费的卡牌没有倒计时限制
            return true
        else
            if PetCardNextRefreshTimeDt[ExtracteType] <= NowTime then   --可以抽取
                --计算下次刷新的时间点
                PetCardNextRefreshTimeDt[ExtracteType] = NowTime + ExtractIntervalTime

                WeekReturnChargeData(PetCardNextRefreshData,PetCardNextRefreshTimeDt, 0)
                --通知玩家倒计时已经刷新
                GetPetCardInfo()
                return true
            end
        end
    end
    return false
end

--按照抽取设置抽取当前抽取类型的宠物数据
function GetPetIDListByOnceMode(ExtracteMode)
    local TempPetIDTable = {}   --宠物数据
    local ExtracteGetPetNum = 0     --抽取获得的宠物数量
    local NeedHighQualityPetNum = CardExtracteConfig[ExtracteMode].NeedHighQualityNum --需要高品质宠物的数量
    for i = 1, CardExtracteConfig[ExtracteMode].ExtracteTimes do
        --判断依据抽取到的宠物中高品质的宠物是否足够，如果不够，后面几次则要到高品质宠物产出范围内抽取
        if CardExtracteConfig[ExtracteMode].ExtracteTimes - i + 1 == NeedHighQualityPetNum then
            --高品质范围内产出宠物
            TempPetIDTable[ExtracteGetPetNum + 1] = GetPetIDByExtracteOnce(ProduceHighQuality)
        else
            TempPetIDTable[ExtracteGetPetNum + 1] = GetPetIDByExtracteOnce(CardExtracteConfig[ExtracteMode])
        end

        if TempPetIDTable[ExtracteGetPetNum + 1] ~= nil then
            --判断是否为高品质宠物
            if HighQualityType == GetPetQuality(TempPetIDTable[ExtracteGetPetNum + 1]) then
                NeedHighQualityPetNum = NeedHighQualityPetNum - 1
                if NeedHighQualityPetNum < 0 then
                    NeedHighQualityPetNum = 0
                end
            end

            --统计产出宠物的个数
            ExtracteGetPetNum = ExtracteGetPetNum + 1

        end
    end
    return ExtracteGetPetNum, TempPetIDTable
end

--玩家抽取宠物操作
function ExtractPet(ExtracteMode)
    --math.randomseed(os.time())
    local TempPetIDTable = nil  --宠物数据
    local ExtracteGetPetNum = nil     --抽取获得的宠物数量
    if CardExtracteConfig[ExtracteMode] == nil then
        return
    end

    local CanExtractFlag = JuageIsCanExtractCard(ExtracteMode)
    if CanExtractFlag == false then
        local str = MystringFormat("PET_EXTRACT_TIMELIMIT")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end


    if ExtracteMode == FREEEXTRA then   --免费
    else    --付费
        --判断付费抽取时，玩家金币是否足够
        local bMoneyEnough = CheckPlayerMoney(1, CardExtracteConfig[ExtracteMode].ConsumeJinBi, 1)
        if bMoneyEnough == 0 or bMoneyEnough == nil then
            local str = MystringFormat("NOGOLD")
            if str ~= nil then
                TalkToPlayer(2,str)
            end
            return
        end
        ChangeMoney(1, -CardExtracteConfig[ExtracteMode].ConsumeJinBi)
    end
    ExtracteGetPetNum, TempPetIDTable = GetPetIDListByOnceMode(ExtracteMode)
    --创建宠物，并同步给该玩家
    if ExtracteGetPetNum == 0 and ExtracteMode ~= GAMBLECARD then
        local str = MystringFormat("NOT_EXTRACT_PET")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end

    --判断玩家拥有的宠物是否达到上限；达到上限时抽取失败
    local CurPetNum = GetPlayerPetNum()
    if CurPetNum == nil or PetMaxNum - CurPetNum < ExtracteGetPetNum then
        local str = MystringFormat("PET_NUMFULL")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end
    

    for n, v in pairs(TempPetIDTable) do
        local PetIndex = GetPetDataIndex(v, 1)
        if PetIndex == nil then     --说明产出的宠物ID中，在宠物数据中没有找到
            ExtracteGetPetNum = ExtracteGetPetNum - 1
        else
            --参数依次为：宠物基本数据、宠物战斗数据、宠物技能组、宠物星级、宠物对应星级下的最大等级、创建宠物类型（1为抽取创建、2为合成创建、3为使用道具创建）

            local PetBaseDataIndex = ReturnFightBaseIndex(PetsBaseDataList[PetIndex][4])
            local PetSkillIndex = ReturnPetSkillIndex(PetsBaseDataList[PetIndex][5])
            if PetBaseDataIndex ~= nil and PetSkillIndex ~= nil then
                AddNewPet(PetsBaseDataList[PetIndex], CreatePetsDataList[PetBaseDataIndex], PetsSkillList[PetSkillIndex], 1, PetsStarConfig[1], 1)
            end
        end
    end
end

--玩家碎片合成宠物操作
function ClipComposePet(NeedComPosePetID)
    local PetIndex = GetPetDataIndex(NeedComPosePetID, 1)
    if PetIndex == nil then
        local str = MystringFormat("NOT_PETINFO")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end
    for n, v in pairs(ChipComposeConfig) do
        if v[1] == NeedComPosePetID then

            --判断碎片道具是否足够
            for i = 2 , table.getn(v), 2 do
                --获取当前背包中碎片的数量
                local ItemNum = GetItemNum(v[i])
                --碎片不足
                if ItemNum < v[i + 1] then
                    --提示玩家碎片不足
                    local str = MystringFormat("CHIPENOUGH")
                    if str ~= nil then
                        TalkToPlayer(2,str)
                    end
                    return
                end
            end

            --核对碎片道具
            for i = 2 , table.getn(v), 2 do
                --核对道具数量并删除该数量的道具, 第三个参数为0时表示要删除道具
                local bRet = CheckGoods(v[i], v[i + 1], 1, 0)
                if bRet == 0 then
                    local str = MystringFormat("ITEMNOTENOUGH")
                    if str ~= nil then
                        TalkToPlayer(2,str)
                    end
                    return
                end
            end

            --判断玩家拥有的宠物是否达到上限；达到上限时抽取失败
            local CurPetNum = GetPlayerPetNum()
            if CurPetNum == nil or PetMaxNum - CurPetNum < 1 then
                local str = MystringFormat("PET_NUMFULL")
                if str ~= nil then
                    TalkToPlayer(2,str)
                end
                return
            end
            --创建宠物，并同步给该玩家
            --参数依次为：宠物基本数据、宠物战斗数据、宠物技能组、宠物星级、宠物对应星级下的最大等级、创建宠物类型（1为抽取创建、2为合成创建、3为使用道具创建）
            
            local PetBaseDataIndex = ReturnFightBaseIndex(PetsBaseDataList[PetIndex][4])
            local PetSkillIndex = ReturnPetSkillIndex(PetsBaseDataList[PetIndex][5])
            if PetBaseDataIndex ~= nil and PetSkillIndex ~= nil then
                for i = 2 , table.getn(v), 2 do
                    --核对道具数量并删除该数量的道具, 第三个参数为0时表示要删除道具
                    DeleteItem(v[i], v[i + 1])
                end
                AddNewPet(PetsBaseDataList[PetIndex], CreatePetsDataList[PetBaseDataIndex], PetsSkillList[PetSkillIndex], 1, PetsStarConfig[1], 2)
            end

        end
    end
end

--使用道具获得宠物
function UsePetItemGet(PetID, PetLevel)
    if PetLevel == nil then
        PetLevel = 1
    end
    local PetIndex = GetPetDataIndex(PetID, PetLevel)
    if PetIndex == nil then
        local str = MystringFormat("NOT_PETINFO")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end
    --判断玩家拥有的宠物是否达到上限；达到上限时抽取失败
    local CurPetNum = GetPlayerPetNum()
    if CurPetNum == nil or PetMaxNum - CurPetNum < 1 then
        local str = MystringFormat("PET_NUMFULL")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end
     --创建宠物，并同步给该玩家
    --参数依次为：宠物基本数据、宠物战斗数据、宠物技能组、宠物星级、宠物对应星级下的最大等级、创建宠物类型（1为抽取创建、2为合成创建、3为使用道具创建）
    
    local PetBaseDataIndex = ReturnFightBaseIndex(PetsBaseDataList[PetIndex][4])
    local PetSkillIndex = ReturnPetSkillIndex(PetsBaseDataList[PetIndex][5])
    if PetBaseDataIndex ~= nil and PetSkillIndex ~= nil then
        local PetMaxLevel = PetsStarConfig[1]
        for n, v in pairs(PetsStarConfig) do
            if PetLevel <= v then
                PetMaxLevel = v
                break
            end
        end
        AddNewPet(PetsBaseDataList[PetIndex], CreatePetsDataList[PetBaseDataIndex], PetsSkillList[PetSkillIndex], 1, PetMaxLevel, 3, PetLevel)
    end
end

----直接购买宠物
function DircetBuyPet(PetID)
    local PetIndex = GetPetDataIndex(PetID, 1)
    if PetIndex == nil then
        local str = MystringFormat("NOT_PETINFO")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end
    --判断玩家金币是否足够
    local PricePetIndex = nil
    for n, v in pairs(DirectBuyPetCfg) do
        if v[1] == PetID then
            PricePetIndex = n
            local bMoneyEnough = CheckPlayerMoney(1, v[2], 1)
            if bMoneyEnough == 0 or bMoneyEnough == nil then
                local str = MystringFormat("NOGOLD")
                if str ~= nil then
                    TalkToPlayer(2,str)
                end
                return
            end
            ChangeMoney(1, -v[2])
        end
    end
    if PricePetIndex == nil then
        local str = MystringFormat("PET_NOTCANSALE")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end

    --判断玩家拥有的宠物是否达到上限；达到上限时抽取失败
    local CurPetNum = GetPlayerPetNum()
    if CurPetNum == nil or PetMaxNum - CurPetNum < 1 then
        local str = MystringFormat("PET_NUMFULL")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end
     --创建宠物，并同步给该玩家
    --参数依次为：宠物基本数据、宠物战斗数据、宠物技能组、宠物星级、宠物对应星级下的最大等级、创建宠物类型（1为抽取创建、2为合成创建、3为使用道具创建、4为金币直接购买）
    
    local PetBaseDataIndex = ReturnFightBaseIndex(PetsBaseDataList[PetIndex][4])
    local PetSkillIndex = ReturnPetSkillIndex(PetsBaseDataList[PetIndex][5])
    if PetBaseDataIndex ~= nil and PetSkillIndex ~= nil then
        AddNewPet(PetsBaseDataList[PetIndex], CreatePetsDataList[PetBaseDataIndex], PetsSkillList[PetSkillIndex], 1, PetsStarConfig[1], 4)
    end
end