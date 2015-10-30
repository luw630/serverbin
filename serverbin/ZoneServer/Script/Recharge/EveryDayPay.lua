EveryDayPayData = tostring("EverDayPayTable")
--每天充值

--每日充值奖励配置表
EveryDayPayAwardCfg = 
{
    --参数依次为：达到的充值金额，奖励的材料数据表(--参数依次为：奖励类型（0为道具 1为银币，2为经验，3为真气）、道具ID、奖励数量 ... )
    {100, {{1, 999888, 16983}, {1, 999888, 16983}, {1, 999888, 16983}, {0, 910011, 2}, {0, 910021, 2}, {0, 9100201, 1}}},
    {500, {{1, 999888, 23776}, {1, 999888, 23776}, {1, 999888, 23776}, {0, 910012, 2}, {0, 910022, 2}, {0, 9100201, 1}}},
    {1000, {{1, 999888, 44156}, {1, 999888, 44156}, {1, 999888, 44156}, {0, 910013, 2}, {0, 910023, 2}, {0, 9100202, 1}}},
    {5000, {{1, 999888, 84916}, {1, 999888, 84916}, {1, 999888, 84916}, {0, 910013, 5}, {0, 190700, 1}, {0, 9100202, 2}}},
}

function InitEveryDayPayData(PayDataTable, playergid)
    if PayDataTable == nil then
        --参数依次为：当前充值的金额总数、对应充值金额数据的奖励状态（该字段的每个字节对应相应数据的奖励状态，1为可以领取奖励， 0为不能领取奖励。最多只有16（10， 20， 30， 40， ...）个阶段。即：0000 0000 0000 0000 0000 0000 0000 0000，从低到高依次对应10， 20， 30, ....）、, 记录上一次充值的时间、每日充值下次充值可领取的奖励索引
        PayDataTable = {0, 0, 0, 1}
        WeekReturnChargeData(EveryDayPayData,PayDataTable, playergid)
    end
end

--领取奖励
function GetEveryDayPayAward(AwardIndex)
    if AwardIndex == nil or AwardIndex > 32 or EveryDayPayAwardCfg[AwardIndex] == nil then
        local str = MystringFormat("OPTFAIL")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end
    local PayDataTable = LoadPlayerTable(EveryDayPayData, 0)
    --设置奖励领取状态
    if PayDataTable == nil then
        InitEveryDayPayData(PayDataTable, 0)
        PayDataTable = LoadPlayerTable(EveryDayPayData, 0)
    end
    
    local State = GetEveryDayPayFlag(PayDataTable[2], AwardIndex - 1)
    if State == nil or State == 0 or State == 2 then
        local str = MystringFormat("GETFAIL")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end

    --领取奖励
    --统计奖励的道具
    local AwardItem = {}
    local ItemIndex = 1
    for n, v in pairs(EveryDayPayAwardCfg[AwardIndex][2]) do
        if v[1] == 0 then
            AwardItem[ItemIndex] = v[2]
            AwardItem[ItemIndex + 1] = v[3]
            ItemIndex = ItemIndex + 2
        end
    end

    --领取奖励
    --奖励道具
    if table.getn(AwardItem) ~= 0 then
        local res = AddSomeGoods(AwardItem)
        if res == 0 then
            local str = MystringFormat("GETFAIL")
            if str ~= nil then
                TalkToPlayer(2,str)
            end
            return
        end
    end
    --奖励银币，经验，真气
    for n, v in pairs(EveryDayPayAwardCfg[AwardIndex][2]) do
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
    local NewStateValue = SetEveryDayPayFlag(PayDataTable[2], AwardIndex - 1, State + 1)
    PayDataTable[2] = NewStateValue
    WeekReturnChargeData(EveryDayPayData,PayDataTable, 0)
    SendGetEDPAwardRes(1)
end

--判断并重置每日充值功能
function JudgeEveryDayReset()
    local PayDataTable = LoadPlayerTable(EveryDayPayData, 0)
    if PayDataTable == nil then
        return
    end
    --判断是否过了第二天
    local CurTime = os.time()
    local DayTime = 24 * 60 * 60
    if math.floor(CurTime / DayTime) > math.floor(PayDataTable[3] / DayTime) then
        PayDataTable[1] = 0
        PayDataTable[4] = 1
        PayDataTable[2] = 0
        PayDataTable[3] = CurTime
        WeekReturnChargeData(EveryDayPayData,PayDataTable, 0)
        local AwardStateTable = {}
        for n, v in pairs(EveryDayPayAwardCfg) do
            local State = GetEveryDayPayFlag(PayDataTable[2], n - 1)
            AwardStateTable[n] = State
        end
        SendEveryDayPayAwardState(AwardStateTable)
    end
end

function GetEveryDayPayAwardState(Flag)
    local AwardStateTable = {}
    local PayDataTable = LoadPlayerTable(EveryDayPayData, 0)
    --设置奖励领取状态
    if PayDataTable == nil then
        InitEveryDayPayData(PayDataTable, 0)
        PayDataTable = LoadPlayerTable(EveryDayPayData, 0)
    end
    for n, v in pairs(EveryDayPayAwardCfg) do
        local State = GetEveryDayPayFlag(PayDataTable[2], n - 1)
        AwardStateTable[n] = State
    end
    SendEveryDayPayAwardState(AwardStateTable)
end

--判断每日充值金额是否达到奖励要求,并设置领取状态
function JudgeEDAddNewAward(PayNum)
    local PayDataTable = LoadPlayerTable(EveryDayPayData, 0)
    if PayDataTable == nil then
        InitEveryDayPayData(PayDataTable, 0)
        PayDataTable = LoadPlayerTable(EveryDayPayData, 0)
    end

    --设置领取状态
    PayDataTable[1] = PayDataTable[1] + PayNum
    for Index = PayDataTable[4], table.getn(EveryDayPayAwardCfg) do
    --for n, v in pairs(EveryDayPayAwardCfg) do
        if PayDataTable[1] >= EveryDayPayAwardCfg[Index][1] then
            local NewStateValue = SetEveryDayPayFlag(PayDataTable[2], Index - 1, 1)
            PayDataTable[2] = NewStateValue
            PayDataTable[4] = PayDataTable[4] + 1
        end
    end
    WeekReturnChargeData(EveryDayPayData,PayDataTable, 0)
end