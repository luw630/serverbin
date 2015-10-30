--首次充值奖励配置表
FirstPayAwardCfg = 
{
    --参数依次为：奖励类型（0为道具 1为银币，2为经验，3为真气）、道具ID、奖励数量
    {2, 999888, 1000},
    {0, 190501, 1},
    {0, 190502, 2},
    {0, 190503, 1},
    {0, 190504, 2},
    {0, 190701, 1},
    {0, 190702, 2},
}

--领取首次充值奖励
function GetFirstPayAward()
    --判断首次充值状态值
    local FirstPayFlag = GetFirstPayFlag()
    if FirstPayFlag ~= 1 then
        local str = MystringFormat("OPTFAIL")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end

    --统计奖励的道具
    local AwardItem = {}
    local ItemIndex = 1
    for n, v in pairs(FirstPayAwardCfg) do
        if v[1] == 0 then
            AwardItem[ItemIndex] = v[2]
            AwardItem[ItemIndex + 1] = v[3]
            ItemIndex = ItemIndex + 2
        end
    end

    --领取奖励
    --奖励道具
    local res = AddSomeGoods(AwardItem)
    if res == 0 then
        local str = MystringFormat("BAGISFULL")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end
    --奖励银币，经验，真气
    for n, v in pairs(FirstPayAwardCfg) do
        if v[1] ~= 0 then
            if v[1] == 1 then
                ChangeMoney(2, v[3])
            elseif v[1] == 2 then
                GiveExp(v[3])
            elseif v[1] == 3 then
                GiveSp(v[3])
            end
        end
    end
    --更新首次充值标识
    SetFirstPayFlag(2)
    local str = MystringFormat("GETSUCCESS")
    if str ~= nil then
        TalkToPlayer(2,str)
    end
end