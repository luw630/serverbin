PlayerSignInData = tostring("PlayerSignInData")   --保存玩家相关的签到信息
--初始化玩家每日签到所需数据，保存玩家当前没有领取的签到奖励ID和状态
function InitEveryDaySignInData()
    --SignInAwardIndex领取奖励的索引，索引范围为1-30，大于30就从新领取；AwardState是否已经领取了该索引的签到奖励;PreResetTime记录上次签到重置时间
    local EveryDaySignData = {SignInAwardIndex = 0, AwardState = 0, PreResetTime = 0}
    WeekReturnChargeData(PlayerSignInData, EveryDaySignData, 0)
end

--更新每日签到数据
function UpdateSignInData(EveryDaySignData, signinawardindex, awardstate)     --SignInAwardIndex领取奖励的索引；AwardState是否已经领取了该索引的签到奖励
    if EveryDaySignData == nil then
        return false
    end
    EveryDaySignData.SignInAwardIndex = signinawardindex
    EveryDaySignData.AwardState = awardstate
    WeekReturnChargeData(PlayerSignInData, EveryDaySignData, 0)
    return true
end

--判断玩家是否满足重置(24点重置或)
function JudgeIsCanResetSignIn(SignInData)
    local CurrentTime = os.time()
    local CurTime = CurrentTime - gEveryDaySignInResetTime    --标准化到24点重置
    local PreTime = SignInData.PreResetTime - gEveryDaySignInResetTime    --表中化到24点重置
    if PreTime < 0 then
        PreTime = 0
    end

    local DayTime = 24 * 60 * 60
    --local nowdate = tonumber(os.date("%Y%m%d",CurTime))
    --local nowdate = tonumber(os.date("%Y%m%d",PreTime))
    --local CurTimeTable = os.date("*t", CurTime)
    --local PreTimeTable = os.date("*t", PreTime)
    if SignInData == nil then   --操作失败
        return false
    end
    if math.floor(CurTime / DayTime) > math.floor(PreTime / DayTime) then --不是当天的连续登陆
        gEveryDaySignInResetTime = gEveryDaySignInResetTime
        SignInData.PreResetTime = CurrentTime
        local SignInIndex = SignInData.SignInAwardIndex
        local SignInAwardState = SignInData.AwardState
        if SignInData.AwardState == 0 then
            SignInIndex = math.mod(SignInData.SignInAwardIndex, gEveryDaySignInAward) + 1
            SignInAwardState = 1
        end
        --更新每日签到数据
        UpdateSignInData(SignInData, SignInIndex, SignInAwardState)
        return true
    end
    return false
end

--处理玩家登陆后的每日签到操作
function OnHandleSignInOpt(IsJudgeTimeFlag)  --IsJudgeTimeFlag当玩家挂起恢复时，不执行时间判断,2表示挂起重新登陆，1表示当天重新登陆,0表示在线循环检测是否已经可以重置；
    --判断每日在线时长领取奖励活动是否重置
    -- JudgeCurDayOnlineIsReset()

    -- --判断每日在线时长领取奖励活动中是否有新达到领取奖励状态的奖励
    -- JudgeCurDayOnlineIsAddAward()

    -- --判断玩家是否有新增的累计天数奖励可以领取
    -- JudgeNewAddUpLoginAward()
    
    -- --判断玩家等级是否进入了等级竞赛名次中
    -- JudgePlayerIsInLevelRace()

    -- --判断每日充值是否重置
    -- JudgeEveryDayReset()

    -- --判断塔罗牌活动是否重置
    -- JugdeTarotIsReset()

    -- local SignInData = LoadPlayerTable(PlayerSignInData, 0) --加载签到数据
    -- if SignInData == nil then
        -- InitEveryDaySignInData()
        -- SignInData = LoadPlayerTable(PlayerSignInData, 0) --加载签到数据
    -- end
    -- local bRet = false
    -- bRet = JudgeIsCanResetSignIn(SignInData)

    -- --发送每日签到奖励数据
    -- if bRet then    --重置成功后发送消息
        -- SendSignInAwardInfo(SignInData.SignInAwardIndex, SignInData.AwardState)
    -- else
        -- --IsJudgeTimeFlag ==0时不发送失败消息
        -- if IsJudgeTimeFlag == 1 then --玩家第一次登陆后，重置失败才发生的失败消息
            -- SendSignInAwardInfo(SignInData.SignInAwardIndex, SignInData.AwardState)
        -- elseif IsJudgeTimeFlag == 2 then --玩家挂起登陆后，重置失败才发生的失败消息
            -- SendSignInAwardInfo(SignInData.SignInAwardIndex, SignInData.AwardState)
        -- end
    -- end
end

--玩家领取每日签到奖励请求
function OnHandleGetSignInAwardOpt(SignInAwardIndex)
    local SignInData = LoadPlayerTable(PlayerSignInData, 0) --加载签到数据
    if SignInData == nil then
        return
    end
    if SignInData.SignInAwardIndex ~= SignInAwardIndex then -- 领取失败
        SendGetSignInAwardResult(0)
        return
    end

    if SignInData.AwardState == 0 then
        SendGetSignInAwardResult(0)
        return
    end
    local SignInAwardInf = EveryDaySignConfig[SignInAwardIndex]
    if SignInAwardInf == nil then   --领奖失败
        SendGetSignInAwardResult(0)
        return
    end
    local PlayerVipLevel = GetPlayerData(0, 101)    --获取玩家VIP等级
    local AwardItemNum = SignInAwardInf[7]      --奖励道具的数量
    local AwardSpNum = SignInAwardInf[2]
    local AwardJinBiNum = SignInAwardInf[3]
    local AwardYinBiNum = SignInAwardInf[4]
    local AwardExpNum = SignInAwardInf[5]
    if PlayerVipLevel >= SignInAwardInf[8] then
        AwardSpNum = AwardSpNum * SignInAwardInf[9]
        AwardItemNum = AwardItemNum * SignInAwardInf[9]
        AwardJinBiNum = AwardJinBiNum * SignInAwardInf[9]
        AwardYinBiNum = AwardYinBiNum * SignInAwardInf[9]
        AwardExpNum = AwardExpNum * SignInAwardInf[9]
    end
    --奖励道具
    if AwardSpNum == 0 and AwardJinBiNum == 0 and AwardYinBiNum == 0 then
        local AwardRet = GiveGoods(SignInAwardInf[6], AwardItemNum)
        if AwardRet == nil then
            SendGetSignInAwardResult(0)
            return
        end
    end
    --奖励真气
    if AwardSpNum ~= 0 then
        GiveSp(AwardSpNum)
    end
    --奖励金币
    if AwardJinBiNum ~= 0 then
        ChangeMoney(1, AwardJinBiNum)
    end
    --奖励游戏币
    if AwardYinBiNum ~= 0 then
        ChangeMoney(2, AwardYinBiNum)
    end
    --奖励经验
    if AwardExpNum ~= 0 then
        GiveExp(AwardExpNum)
    end
    SignInData.AwardState = 0
    WeekReturnChargeData(PlayerSignInData, SignInData, 0)
    SendGetSignInAwardResult(1)     --领取成功
end
