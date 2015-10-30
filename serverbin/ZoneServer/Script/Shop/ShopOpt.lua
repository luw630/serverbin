
--通知玩家某个商城的商品已经更新
--ShopIndex 商城索引
function NotityOneGoodsUpdated(ShopIndex, GoodsUpdateState, RefreshAllTime)
    NotityGoodsUpdated(ShopIndex, GoodsUpdateState, RefreshAllTime)
end

--计算某个商城的下一次刷新时间
function CalNextShopRefreshTime(CurDayHourTime, CurRefreshTime, ShopType)
    if ShopRefreshList[ShopType].IntervalDay == 0 then --表示每天固定时间刷新组
        local TimeGroupSize = table.getn(ShopRefreshList[ShopType])
        for i = 1, TimeGroupSize do
            if CurDayHourTime < ShopRefreshList[ShopType][1] then
                ShopRefreshInf[ShopType] = CurRefreshTime + ShopRefreshList[ShopType][1] - CurDayHourTime
            elseif  CurDayHourTime > ShopRefreshList[ShopType][TimeGroupSize] then
                ShopRefreshInf[ShopType] = CurRefreshTime + ShopRefreshList[ShopType][1] + 24 * 60 * 60 - CurDayHourTime
            elseif CurDayHourTime > ShopRefreshList[ShopType][i] then
                ShopRefreshInf[ShopType] = CurRefreshTime + ShopRefreshList[ShopType][i + 1] - CurDayHourTime
            end
        end
    else
        if CurDayHourTime > ShopRefreshList[ShopType][1] then
            ShopRefreshInf[ShopType] = ShopRefreshList[ShopType].IntervalDay * 24 * 60 * 60 + CurRefreshTime - (CurDayHourTime - ShopRefreshList[ShopType][1])
        else
            ShopRefreshInf[ShopType] = ShopRefreshList[ShopType].IntervalDay * 24 * 60 * 60 + CurRefreshTime + (ShopRefreshList[ShopType][1] - CurDayHourTime)
        end
    end
end

--计算商城刷新所需的总时间
function CalShopRefreshAllTime(CurDayHourTime, ShopType, TempShopData)--注意第三个参数传递的是引用
    if ShopRefreshList[ShopType].IntervalDay == 0 then --表示每天固定时间刷新组
        local TimeGroupSize = table.getn(ShopRefreshList[ShopType])
        for i = 1, TimeGroupSize do
            if CurDayHourTime < ShopRefreshList[ShopType][1] or CurDayHourTime > ShopRefreshList[ShopType][TimeGroupSize] then
                TempShopData[2] = ShopRefreshList[ShopType][1] + 24 * 60 * 60 - ShopRefreshList[ShopType][TimeGroupSize]
            elseif CurDayHourTime > ShopRefreshList[ShopType][i] then
                TempShopData[2] = ShopRefreshList[ShopType][i + 1] - ShopRefreshList[ShopType][i]
            end
        end
    else
        TempShopData[2] = ShopRefreshList[ShopType].IntervalDay * 24 * 60 * 60
    end
end

--商城初始化
function InitShop()
    local TimeDiffrenceD = os.date("*t", 0)
    TimeDiffrence = TimeDiffrenceD.hour     --记录本地时间与HTC时间的时间差
    local CurTime = os.time()
    local CurDayHourTime = math.mod(CurTime + TimeDiffrence * 60 * 60, 24 * 60 * 60)   --当天的小时

    TempShopCountDownSysCall = deepcopy(ShopCountDownSysCall)   --固定倒计时间到了后，发送的系统提示相关数据

    math.randomseed(CurTime)
    ShopRandValue = {}  --保存商城随机值范围

    ShopRefreshInf = {} --记录每个商城下一次刷新时间
    for n, v in pairs(ShopDataList) do
        if GoodsDataList[n] ~= nil then
            local RandRange = table.getn(GoodsDataList[n])   --获取随机值范围
            ShopRandValue[n] = math.random(RandRange)  --保存商城随机值范
        end
        if v[1] == 1 then   --需要刷新的商城
            if ShopRefreshList[n] == nil or ShopRefreshList[n].IntervalDay == nil then
                break
            end

            ShopRefreshInf[n] = {}
            --计算商城的下一次刷新时间
            CalNextShopRefreshTime(CurDayHourTime, CurTime, n)

            local TempShopData = deepcopy(ShopDataList[n])   --防止ShopDataList数据被改动
            --计算商城刷新所需的总时间
            CalShopRefreshAllTime(CurDayHourTime, n, TempShopData)--注意第三个参数传递的是引用
            --通知玩家商城已经刷新
            NotityOneGoodsUpdated(n, 1, TempShopData[2])
        else
            NotityOneGoodsUpdated(n, 1, 0)
        end
    end
end

InitShop()

function ReturnShopDecri(ShopType, Param)
    local str = ""    

    if ShopType == 1 then
        str = MystringFormat("SHOPCOUNTDOWNTIP1", Param)
    elseif ShopType == 2 then
        str = MystringFormat("SHOPCOUNTDOWNTIP2", Param)
    elseif ShopType == 3 then
        str = MystringFormat("SHOPCOUNTDOWNTIP3", Param)
    elseif ShopType == 4 then
        str = MystringFormat("SHOPCOUNTDOWNTIP4", Param)
    else
        str = MystringFormat("SHOPCOUNTDOWNTIP5", Param)
    end
    return str
end

--判断是否提示商城刷新倒计时系统公告
function JudgeShopCountDownSysCall(IntervalTime, ShopType)
    for n, v in pairs(TempShopCountDownSysCall[ShopType]) do
        if IntervalTime <= v[1] and IntervalTime > v[1] - 5 then
            --发送公告
            if v[2] ~= 0 then
                local index = math.mod(n, table.getn(TempShopCountDownSysCall[ShopType])) + 1
                TempShopCountDownSysCall[ShopType][index][2] = ShopCountDownSysCall[ShopType][index][2]
                local Msg = ReturnShopDecri(ShopType, v[1] / 60)
                rfalse(Msg)
                SendSysCall(v[2], Msg, 1)
                v[2] = 0
            end
        end
    end
end

--时时判断商城是否可以刷新
function JudgeRefreshGoodsLoop()
    local CurTime = os.time()
    local CurDayHourTime = math.mod(CurTime + TimeDiffrence * 60 * 60, 24 * 60 * 60)   --当天的小时
    for n, v in pairs(ShopRefreshInf) do
        JudgeShopCountDownSysCall(v - CurTime, n)
        if CurTime >= v then --该商城已经刷新

            --商城显示的商品列表随机值改变
            if GoodsDataList[n] ~= nil then
                local RandRange = table.getn(GoodsDataList[n])   --获取随机值范围
                ShopRandValue[n] = math.random(RandRange)  --保存商城随机值范围
            end

            local TempShopData = deepcopy(ShopDataList[n])   --防止ShopDataList数据被改动
            --计算商城的下一次刷新时间
            CalNextShopRefreshTime(CurDayHourTime, CurTime, n)
            --计算商城刷新所需的总时间
            CalShopRefreshAllTime(CurDayHourTime, n, TempShopData)--注意第三个参数传递的是引用
            --通知玩家商城已经刷新
            NotityOneGoodsUpdated(n, 1, TempShopData[2])
        end
    end
end

--请求商城信息,玩家登录时服务器主动发给玩家
function QuestShopListInfo()
    local TempShopDataList = deepcopy(ShopDataList)   --防止ShopDataList数据被改动

    local CurRefreshTime = os.time()
    local CurDayHourTime = math.mod(CurRefreshTime + TimeDiffrence * 60 * 60, 24 * 60 * 60)   --当天的小时
    for n, v in pairs(ShopDataList) do
        if v[1] == 1 then
            if ShopRefreshList[n] == nil or ShopRefreshList[n].IntervalDay == nil then
                break
            end

            CalShopRefreshAllTime(CurDayHourTime, n, TempShopDataList[n])   --注意第三个参数传递的是引用
        end
    end
    --
    SendShopListInfo(TempShopDataList)
end

--请求某个商城中已经刷新的商品数据
--ShopType 商城类型
function QuestShopGoodsData(ShopType)
    --local RandRange = table.getn(GoodsDataList[ShopType])   --获取随机值范围
    --local RandValue = math.random(RandRange)
    if ShopRandValue[ShopType] == nil then
        return
    end
    local RandValue = ShopRandValue[ShopType]
    local TempGoodsDataList = deepcopy(GoodsDataList[ShopType][RandValue])   --防止GoodsDataList数据被改动
    for n, v in pairs(TempGoodsDataList) do --增加一条商品唯一索引属性
        local PropertyNum = table.getn(v)
        local CalGoodsUniqueIndex = GetGoodsIndexByTriIndex(ShopType, RandValue, n)     --获取商品唯一索引
        v[PropertyNum + 1] = CalGoodsUniqueIndex
        v[PropertyNum + 2] = ShopType    
    end
    SendShopGoodsListInfo(TempGoodsDataList)
end

--购买指定数量的商品
--BuyType 购买方式 1为金币购买 2为游戏币购买
--GoodsIndex 商品索引
--GoodsNum 购买数量
function BuyShopGoods(BuyType, GoodsIndex, GoodsNum)
    local ShopIndex, GoodsIndex1, GoodsIndex2 = GetTriIndexByGoodsIndex(GoodsIndex)
    if GoodsDataList[ShopIndex] == nil or GoodsDataList[ShopIndex][GoodsIndex1] == nil 
    or GoodsDataList[ShopIndex][GoodsIndex1][GoodsIndex2] == nil then    --购买失败
        SendBuyGoodsRes(0)
        return
    end
    local TempGoodsData = GoodsDataList[ShopIndex][GoodsIndex1][GoodsIndex2]    --获取商品数据

    local SpendAllJinBi = GoodsNum * TempGoodsData[4]   --购买所需金币数
    local SpendAllYinBi = GoodsNum * TempGoodsData[6]   --购买所需银币数
    if BuyType == 1 then    --金币购买处理
        local bMoneyEnough = CheckPlayerMoney(1, SpendAllJinBi, 1)
        if bMoneyEnough == 0 or bMoneyEnough == nil then
            SendBuyGoodsRes(0)
            return
        end
        --添加商品到背包中
        local res = GiveGoods(TempGoodsData[2], GoodsNum)
        if res == nil then
            SendBuyGoodsRes(0)
            return
        end
        ChangeMoney(1, -SpendAllJinBi)
    else    --银币购买处理
        local bMoneyEnough = CheckPlayerMoney(2, SpendAllYinBi, 1)
        if bMoneyEnough == 0 or bMoneyEnough == nil then
            SendBuyGoodsRes(0)
            return
        end
        --添加商品到背包中
        local res = GiveGoods(TempGoodsData[2], GoodsNum)
        if res == nil then
            SendBuyGoodsRes(0)
            return
        end
        ChangeMoney(2, -SpendAllYinBi)
    end
    SendBuyGoodsRes(1)  

    --活跃度计算
    CompleteAndActiveness(7)
end

--处理玩家请求商城刷新的倒计时
function HandleQuestShopCountDown(ShopType)
    local CurTime = os.time()
    local CountDown = ShopRefreshInf[ShopType] - CurTime
    SendShopCountDownRes(ShopType, CountDown)
end

--查找商品信息通过商品道具ID
function FindGoodsByItemID(ItemID, OptType, DefaultNum)
    local ShopNum = table.getn(GoodsDataList)
    local TempGoodsData = nil
    for i = 1, ShopNum do
        local RandValue = ShopRandValue[i]
        local TempGoodsDataList = deepcopy(GoodsDataList[i][RandValue])
        for n, v in pairs(TempGoodsDataList) do --增加一条商品唯一索引属性
            if v[2] == ItemID then 
                local PropertyNum = table.getn(v)
                local CalGoodsUniqueIndex = GetGoodsIndexByTriIndex(i, RandValue, n)     --获取商品唯一索引
                v[PropertyNum + 1] = CalGoodsUniqueIndex
                v[PropertyNum + 2] = i
                TempGoodsData = deepcopy(v)
                break
            end  
        end
        if TempGoodsData ~= nil then
            break
        end
    end
    if TempGoodsData == nil then
        local str = MystringFormat("SHOP_NOGOODS")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end
    SendGoodsInfo(DefaultNum, OptType, TempGoodsData)
end
