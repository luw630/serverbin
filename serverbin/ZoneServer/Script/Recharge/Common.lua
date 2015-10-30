PlayerRechargeGlod = tostring(RechargeGlodData)     --玩家充值的金币总数

--初始化玩家充值金币总数数据
function InitPlayerRechargeGlodData()
    local TotalRechargeNum = {}    
    TotalRechargeNum[1] = 0     --充值金币总数
    WeekReturnChargeData(PlayerRechargeGlod, TotalRechargeNum, 0)
end

--玩家充值人民币
function PlayerPayGlod(PayNum)
    local PlayerRechargeTotal = LoadPlayerTable(PlayerRechargeGlod, 0)
    if PlayerRechargeTotal == nil then
        return
    end
    if PayNum == nil or PayNum <= 0 then
        local str = MystringFormat("RECHARGEFAIL")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end
    PlayerRechargeTotal[1] = PlayerRechargeTotal[1] + PayNum
    WeekReturnChargeData(PlayerRechargeGlod, PlayerRechargeTotal, 0)
    RefreshRankData() --刷新金币排行榜数据

    --同步玩家总的充值金币数量
    SynRechargeTatolGlod(PlayerRechargeTotal[1])

    --通过玩家充值金币总数，计算玩家当前总的可以使用的次数
    CalFWPlayerTatoltimes(PlayerRechargeTotal[1])

    --判断玩家充值回馈是否有新的奖励可以领取
    JudgeRFBIsAddNewAward(PlayerRechargeTotal[1])

    ChangeMoney(1, PayNum)

    --判断是否第一次充值，并更新第一次充值标志
    local FirstPayFlag = GetFirstPayFlag()
    if FirstPayFlag == 0 then
        SetFirstPayFlag(1)
    end

    --判断每日充值金额是否达到奖励要求,并设置领取状态
    JudgeEDAddNewAward(PayNum)
    
    local str = MystringFormat("RECHARGESUCCESS")
    if str ~= nil then
        TalkToPlayer(2,str)
    end
    GetEveryDayPayAwardState()
end

--登陆同步玩家充值的总的金币数量
function LoginSynRechargeTatot()
    local PlayerRechargeTotal = LoadPlayerTable(PlayerRechargeGlod, 0)
    if PlayerRechargeTotal == nil then
        return
    end
    --同步玩家总的充值金币数量
    SynRechargeTatolGlod(PlayerRechargeTotal[1])
end