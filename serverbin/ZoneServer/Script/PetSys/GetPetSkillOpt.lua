--获得技能碎片索引通过技能碎片ID
function GetSkillChipIndexByID(SkillClipID)
    for n, v in pairs(PetSkillBookCfg) do
        if v[1] == SkillClipID then
            return n
        end
    end
end
--使用宠物技能碎片获得宠物技能书
function UsePetSkillClipOpt(SkillClipID)
    --判断技能书碎片数量是否足够
    local SkillClipIndex = GetSkillChipIndexByID(SkillClipID)
    if SkillClipIndex == nil then
        return
    end
    --判断技能碎片是否足够
    local bRet = CheckGoods(PetSkillBookCfg[SkillClipIndex][1], PetSkillBookCfg[SkillClipIndex][2], 1)
    if bRet == false or bRet == 0 then
        local str = MystringFormat("ITEMNOTENOUGH")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end
    if GetBlankCell() < 1 then
        local str = MystringFormat("BAGISFULL")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end
    --消耗道具
    DeleteItem(PetSkillBookCfg[SkillClipIndex][1], PetSkillBookCfg[SkillClipIndex][2])

    --获取合成的技能书ID
    local GetSkillBookID = RandomGetSkillBookOpt(PetSkillBookCfg[SkillClipIndex][3])
    if GetSkillBookID ~= nil then
        GiveGoods(GetSkillBookID, 1)
        --合成成功
        local str = MystringFormat("GETPETSKILLBOOK")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
    else
        --合成失败
        local str = MystringFormat("NOTGETPETSKILLBOOK")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
    end
end

--获得随机技能书组的索引通过随机技能书组的ID
function GetSkillBookIndexByID(RandomSkillGroupRangeID)
    for n, v in pairs(RandomSkillBookRangeCfg) do
        if v[1] == RandomSkillGroupRangeID then
            return n
        end
    end
end

--获得随机合成的技能书ID
function RandomGetSkillBookOpt(RandomSkillGroupRangeID)
    local SkillBookIndex = GetSkillBookIndexByID(RandomSkillGroupRangeID)
    if SkillBookIndex == nil then
        rfalse("11111")
        return
    end
    if type(RandomSkillBookRangeCfg[SkillBookIndex][2]) ~= "table" then
        rfalse("222")
        return
    end
    local WeightAll = 0
    --计算权重总值
    for n, v in ipairs(RandomSkillBookRangeCfg[SkillBookIndex][2]) do
        WeightAll = WeightAll + v[2]
    end
    local RandomValue = math.random(WeightAll)

    --判断随机的技能书ID
    local EachSkillBookWeight = 0   --每个技能书所占权重比
    for n, v in ipairs(RandomSkillBookRangeCfg[SkillBookIndex][2]) do
        --抽取到当前索引的宠物ID
        if RandomValue > EachSkillBookWeight and RandomValue <= EachSkillBookWeight + v[2] then
            return v[1]     --随机合成的技能书
        end
        EachSkillBookWeight = EachSkillBookWeight + v[2]
    end
end

--宠物学习技能
function PetStudySkillOpt(PetIndex, PetSkillBookID)
    --核对技能书道具是否足够
    local bRet = CheckGoods(PetSkillBookID, 1, 1)
    if bRet == false or bRet == 0 then
        local str = MystringFormat("ITEMNOTENOUGH")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end

    bRet = PetStudySkillByBook(PetIndex, PetSkillBookID)
    if bRet ~= 1 then
        local str = MystringFormat("PETSTUDYSKILLFAIL")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end

    --使用技能书道具
    DeleteItem(PetSkillBookID, 1)

    local str = MystringFormat("PETSTUDYSKILLSUCCESS")
    if str ~= nil then
        TalkToPlayer(2,str)
    end
end