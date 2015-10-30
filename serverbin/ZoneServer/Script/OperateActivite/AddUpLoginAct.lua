AddUpLoginData = tostring("AddUpLoginData")  --玩家累计登陆相关数据

--获取累计登陆数据索引，通过累计登陆级别ID
function GetAddUpLoginIndexByID(LevelID)
    for n, v in pairs(AddUpLoginCfg) do
        if v[1] == LevelID then
            return n
        end
    end
end

--获取累计登陆奖励数据索引，通过累计登陆奖励ID
function GetAddUpLoginAwardIndexByID(AwardID)
    for n, v in pairs(AddUpLoginAwardCfg) do
        if v[1] == AwardID then
            return n
        end
    end
end

--初始化玩家累计登陆相关数据
function InitAddUpLoginData()
    PlayerAddUpLoginInf = {}
    for n, v in pairs(AddUpLoginCfg) do
        PlayerAddUpLoginInf[v[1]] = 0   --对应累计达到天数的奖励状态(0表示不能领取，1表示可以领取，2表示已领取)
    end
    WeekReturnChargeData(AddUpLoginData, PlayerAddUpLoginInf, 0)
end

--活动玩家累计登陆当前详细信息
function GetAddUpLoginDetailInf()
    local PlayerAddUpLoginInf = LoadPlayerTable(AddUpLoginData, 0)
    if PlayerAddUpLoginInf == nil then
        return
    end
    local TempAddUpLoginCfg = deepcopy(AddUpLoginCfg)
    for n, v in pairs(TempAddUpLoginCfg) do
        v[3] = PlayerAddUpLoginInf[v[1]]    --当前级别的领取奖励状态

        local AddUpLoginAwardIndex = GetAddUpLoginAwardIndexByID(AddUpLoginCfg[n][3])
        v[4] = AddUpLoginAwardCfg[AddUpLoginAwardIndex][2]  --当前级别可以领取的奖励信息列表
    end
    SendPlayerAddUpLoginInf(table.getn(TempAddUpLoginCfg), TempAddUpLoginCfg)
end

--获得玩家总的累计登陆时间
function GetAddupLoginTime()
    local AddupLoginTime = GetPlayerAddUpLoginTime()
    if AddupLoginTime == nil then
        AddupLoginTime = 0
    end
    
    SendPlayerAddUpLogintime(AddupLoginTime)
end

--判断玩家是否有新增的累计天数奖励可以领取
function JudgeNewAddUpLoginAward()
    local AddUpLoginTime = GetPlayerAddUpLoginTime()
    if AddUpLoginTime / SPecTime > table.getn(AddUpLoginCfg) then
        return
    end
    local PlayerAddUpLoginInf = LoadPlayerTable(AddUpLoginData, 0)
    if PlayerAddUpLoginInf == nil then
        return
    end
    local UpdateFlag = 0
    for n, v in pairs(AddUpLoginCfg) do
        local NeedDay = v[2] * SPecTime
        if AddUpLoginTime >= NeedDay and PlayerAddUpLoginInf[v[1]] == 0 then --有新增可以领取的奖励
            PlayerAddUpLoginInf[v[1]] = 1
            --发送消息
            NotifyAddUpLoginAddNewAward(v[1])
            UpdateFlag = 1
        end
    end
    if UpdateFlag == 1 then
        WeekReturnChargeData(AddUpLoginData, PlayerAddUpLoginInf, 0)
    end
end

--领取玩家指定级别的累计登陆奖励
function GetAddUpLoginAward(AddUpLoginLevelID)
    local PlayerAddUpLoginInf = LoadPlayerTable(AddUpLoginData, 0)
    if PlayerAddUpLoginInf == nil then
        return
    end

    local AddUpLoginDataIndex = GetAddUpLoginIndexByID(AddUpLoginLevelID)
    local AddUpLoginAwardIndex = GetAddUpLoginAwardIndexByID(AddUpLoginCfg[AddUpLoginDataIndex][3])

    if PlayerAddUpLoginInf[AddUpLoginLevelID] ~= 1 or AddUpLoginDataIndex == nil or AddUpLoginAwardIndex == nil then
        --发送失败消息
        SendAddUpLoginGetAwardRes(0)
        return
    end

    --统计奖励的道具
    local AwardItem = AddUpLoginAwardCfg[AddUpLoginAwardIndex][2]
    --奖励道具
    if AwardItem ~= nil and table.getn(AwardItem) ~= 0 then
        local res = AddSomeGoods(AwardItem)
        if res == 0 then
            --发送失败消息
            SendAddUpLoginGetAwardRes(0)
            return
        end
    end

    PlayerAddUpLoginInf[AddUpLoginLevelID] = 2
    WeekReturnChargeData(AddUpLoginData, PlayerAddUpLoginInf, 0)
    --发送成功消息
    SendAddUpLoginGetAwardRes(1)
end