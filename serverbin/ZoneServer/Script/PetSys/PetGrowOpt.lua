

--宠物吞噬一定数量的宠物, 最大一次只能吞并四个宠物
function PetSwallowPets(SrcPetIndex, SrcPetIndex1, SrcPetIndex2, SrcPetIndex3, SrcPetIndex4, SrcPetIndex5, ExpRateItemID)
    if SrcPetIndex == nil or SrcPetIndex >= 99 then
        local str = MystringFormat("NOT_PETINFO")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end

    local PetTransRateIndex = GetPetExpTransRateIndex(ExpRateItemID)
    --判断使用宠物经验转换比率道具时的经验转换比率值
    if PetTransRateIndex ~= nil then
        --判断道具数量是否足够
        local ItemIsEnough = CheckGoods(PetExpTransRate[PetTransRateIndex][1], PetExpTransRate[PetTransRateIndex][2], 1)
        if ItemIsEnough == false or ItemIsEnough == 0 then
            local str = MystringFormat("ITEMNOTENOUGH")
            if str ~= nil then
                TalkToPlayer(2,str)
            end
            return
        end
        DeleteItem(PetExpTransRate[PetTransRateIndex][2], PetExpTransRate[PetTransRateIndex][1])
        GrowExpSwitchScale = GrowExpSwitchScale + PetExpTransRate[PetTransRateIndex][3]
        BringExpSwitchScale = BringExpSwitchScale + PetExpTransRate[PetTransRateIndex][4]
    end
    --判断VIP等级 宠物吞噬后整体经验按VIP等级加成
    local PlayerVipLevel = GetPlayerData(0, 101)    --获取玩家VIP等级
    if PlayerVipLevel > 0 then
        AllExpAttachScale = AllExpAttachScale + VIPPetSwallowExpTranCfg[PlayerVipLevel]
    end

    local DestPetIndexList = {SrcPetIndex1, SrcPetIndex2, SrcPetIndex3, SrcPetIndex4, SrcPetIndex5}

    --执行吞噬操作, 并计算吞噬后，吞噬源宠物的经验和等级（宠物的等级不能大于该宠物星级最大等级）
    ExceSwallowPetOpt(SrcPetIndex, DestPetIndexList, GrowExpSwitchScale, BringExpSwitchScale, AllExpAttachScale)

    SendPetMergerInf(SrcPetIndex)
end

--获取宠物突破的索引通过宠物ID和宠物星级
function GetPetBreachIndexByID(PetID, PetStar)
    for n, v in pairs(PetBreachConfig) do
        if v[1] == PetID and v[2] == PetStar then
            return n
        end
    end
end

--宠物突破
function PetBreach(PetIndex)
    if PetIndex == nil or PetIndex >= 99 then
        local str = MystringFormat("NOT_PETINFO")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end

    local PetID = nil
    local PetStar = nil
    PetID, PetStar = GetPetIDAndStar(PetIndex)
    if PetID == nil  or PetStar == nil then
        local str = MystringFormat("NOT_PETINFO")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end

    local PetBreachIndex = GetPetBreachIndexByID(PetID, PetStar)
    if PetBreachIndex == nil then
        local str = MystringFormat("NOT_PETINFO")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end

    --判断道具是否足够
    local ElemNum = table.getn(PetBreachConfig[PetBreachIndex])
    for i = 3, ElemNum, 2 do
        local ItemIsEnough = CheckGoods(PetBreachConfig[PetBreachIndex][i], PetBreachConfig[PetBreachIndex][i + 1], 1)
        if ItemIsEnough == false or ItemIsEnough == 0 then
            local str = MystringFormat("ITEMNOTENOUGH")
            if str ~= nil then
                TalkToPlayer(2,str)
            end
            return
        end
    end

    --消耗道具
    for i = 3, ElemNum, 2 do
        DeleteItem(PetBreachConfig[PetBreachIndex][i], PetBreachConfig[PetBreachIndex][i + 1])
    end

    --突破操作(升星操作)
    PetBreachOpt(PetIndex, PetsStarConfig)

    --发送突破成功消息
    SendPetBreachInf(PetIndex)
end

--宠物更名
function PetRename(PetIndex, PetNewName)

    local bMoneyEnough = CheckPlayerMoney(1, RenameSpendMoney, 1)
    if bMoneyEnough == 0 or bMoneyEnough == nil  then   --核对金币是否足够
        --发送失败消息
        SendPetRenameInf(PetIndex, 0)
        return 0
    end
    PetRenameOpt(PetIndex, PetNewName)
    ChangeMoney(1, -RenameSpendMoney);
    --发送成功消息
    SendPetRenameInf(PetIndex, 1)
end

--宠物技能配置
function PetSkillCfgOpt(PetIndex, SkillIndex1, SkillIndex2, SkillIndex3, SkillIndex4)
    if PetIndex == nil or PetIndex >= 99 then
        local str = MystringFormat("NOT_PETINFO")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end
    local SkillTable = {SkillIndex1, SkillIndex2, SkillIndex3, SkillIndex4}
    --配置宠物技能
    PetSkillCfg(PetIndex, SkillTable)
end

--获取宠物吞噬转换比率索引
function GetPetExpTransRateIndex(ExpRateItemID)
    for n, v in pairs(PetExpTransRate) do
        if v[1] == ExpRateItemID then
            return n
        end
    end
end

--获取吞噬宠物可以获取的经验
function GetPetExpInf(SrcPetIndex1, SrcPetIndex2, SrcPetIndex3, SrcPetIndex4, SrcPetIndex5, ExpRateItemID)
    local DestPetIndexList = {SrcPetIndex1, SrcPetIndex2, SrcPetIndex3, SrcPetIndex4, SrcPetIndex5}

    local PetTransRateIndex = GetPetExpTransRateIndex(ExpRateItemID)
    --判断使用宠物经验转换比率道具时的经验转换比率值
    if PetTransRateIndex ~= nil then
        GrowExpSwitchScale = GrowExpSwitchScale + PetExpTransRate[PetTransRateIndex][3]
        BringExpSwitchScale = BringExpSwitchScale + PetExpTransRate[PetTransRateIndex][4]
    end
    --判断VIP等级 宠物吞噬后整体经验按VIP等级加成
    local PlayerVipLevel = GetPlayerData(0, 101)    --获取玩家VIP等级
    if PlayerVipLevel > 0 then
        AllExpAttachScale = AllExpAttachScale + VIPPetSwallowExpTranCfg[PlayerVipLevel]
    end

    --计算吞噬宠物可以获取的经验，并发送给玩家
    CalAndSendPetExp(DestPetIndexList, GrowExpSwitchScale, BringExpSwitchScale, AllExpAttachScale)
end

--获取当前VIP等级的魂力恢复间隔时间
function GetHunliResumeTime()
    local PlayerVipLevel = GetPlayerData(0, 101)    --获取玩家VIP等级
    return math.floor(ResumeHunliIntervaTime[PlayerVipLevel][1] * (100 - VIPPetDurableCfg[PlayerVipLevel]) / 100)
end

--获取当前VIP等级的魂力恢复需要的金币
function GetHunliResumeNeedGold(PetLevel)
    local PlayerVipLevel = GetPlayerData(0, 101)    --获取玩家VIP等级
    return ResumeHunliIntervaTime[PlayerVipLevel][2] * PetLevel
end

--获取恢复宠物魂力需要的金币数
function ResumePetDurableNeedGold(PetLevel)
    local NeedGold = GetHunliResumeNeedGold(PetLevel)
    SendResumeDurableNeedGold(NeedGold)
end

--花费金币恢复宠物魂力
function GoldResumePetDurable(PackagePetIndex, PetID, PetLevel)
    local Res = JudgePetDurableIsZero(PackagePetIndex)
    if Res ~= 1 then
        SendGoldResumeDurableRes(0)
        return
    end

    local NeedGold = GetHunliResumeNeedGold(PetLevel)
    local bMoneyEnough = CheckPlayerMoney(1, NeedGold, 1)
    if bMoneyEnough == 0 or bMoneyEnough == nil  then   --核对金币是否足够
        local str = MystringFormat("NOGOLD")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return 0
    end
    ChangeMoney(1, -NeedGold)

    local PetIndex = GetPetDataIndex(PetID, PetLevel)
    local PetBaseIndex = GetPetBaseProperties(PetIndex, 4)
    local NewPetDurable = GetPetFightBaseProperties(PetBaseIndex, 4)
    --更新宠物魂力
    UptPetDurable(PackagePetIndex, NewPetDurable)
    --同步宠物魂力数据给玩家
    NotifyPetDurableUpt(PackagePetIndex)
    SendGoldResumeDurableRes(1)
end