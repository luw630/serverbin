
--发送系统公告
function sendsyscall(ShowNum, Message)
    return SendSysCall(ShowNum, Message, 0)
end

--设置玩家关卡自动杀怪
function setkillallmonster(GID, State)
    return SetKillAllMonster(GID, State)
end

--设置玩家基本数据
function setplayerdata(GID, DataIndex, Value)
    local SetType = tonumber(DataIndex)
    if GM_SetPlayerData_TypeList[SetType] == nil then   --获取类型没有
        return "没有该索引"
    else
        ReturnValue = NewSetPlayerProperty(GID, DataIndex, Value)
        return ReturnValue
    end
end

--获取玩家基本数据
function UCgetplayerdata(GID, DataIndex)
    local GetType = tonumber(DataIndex)
    if GM_GetPlayerData_TypeList[GetType] == nil then   --获取类型没有
        return "没有该索引的值"
    end
        ReturnValue = GetPlayerData(GID, DataIndex)
        --处理返回来的值
        if type(ReturnValue) == "table" then  --返回的是玩家的位置，获取位置
            ReturnValue ="XPos = " .. ReturnValue[1] .. "\tYPos = " .. ReturnValue[2]
        end
        if  ReturnValue == nil then
            ReturnValue = CmdAndParams .. "；操作失败"
        end
        return " " .. GM_GetPlayerData_TypeList[GetType] .. ReturnValue
end

--获取玩家GID
function UCgetplayergid(SID)
    local ReturnValue = GetPlayerGID(SID)
    return "；SID为" .. SID .. "玩家的GID为：" .. ReturnValue
end
--获取玩家SID
function UCgetplayersid(PalyerName)
    local ReturnValue = GetPlayerSID(PalyerName)
    if  ReturnValue == nil then
        ReturnValue = "操作失败"
    end
    return PalyerName .. "玩家的SID为：" .. ReturnValue
end

--更改玩家荣耀点
function changeglorydot(GID, Value)
    return ChangeGloryDot(GID, Value)
end

--更改玩家钱
function changemoney(GID, MoneyType, Value)
    SetPlayerObject(GID)  --通过GID设置执行脚本的玩家
    return ChangeMoney(MoneyType, Value)
end

--更改玩家经验
function changeexp(GID, Value)
    SetPlayerObject(GID)  --通过GID设置执行脚本的玩家
    return GiveExp(Value)
end

--更改玩家真气
function changesp(GID, Value)
    SetPlayerObject(GID)  --通过GID设置执行脚本的玩家
    return GiveSp(Value)
end

--添加道具
function addgoods(GID, GoodsID, AddNum)
    SetPlayerObject(GID)  --通过GID设置执行脚本的玩家
    return GiveGoods(GoodsID, AddNum)
end

--删除道具
function delgoods(GID, GoodsID, DeleteNum)
    SetPlayerObject(GID)  --通过GID设置执行脚本的玩家
    return DeleteItem(GoodsID, DeleteNUm)
end

--激活技能
function activeskill(GID, SkillID)
    SetPlayerObject(GID)  --通过GID设置执行脚本的玩家
    return ActiveSkill(SkillID)
end

--激活背包
function activepackage(GID, ActiveNum, State)
    SetPlayerObject(GID)  --通过GID设置执行脚本的玩家
    --成功, 第一个参数结果，第二个参数是当前激活的扩展背包总数
    SendActivePackage(0, ActiveNum)
    return ActivePackage(0, ActiveNum, State)
end

--设置技能等级
function setskilllevel(GID, SkillID, Level)
    SetPlayerObject(GID)  --通过GID设置执行脚本的玩家
    return SetSkillLevel(SkillID, Level)
end

--设置指定当前索引的技能的技能等级
function setindexskilllevel(GID, SkillIndex, Level)
    SetPlayerObject(GID)  --通过GID设置执行脚本的玩家
    return SetCurrentSkillLevel(SkillIndex, Level)
end

--设置玩家VIP等级
function setplayerviplevel(GID, VIPLevel)
    SetPlayerObject(GID)  --通过GID设置执行脚本的玩家
    return SetPlayerVipLevel(VIPLevel)
end

function pptm(MapID, fx, fy)
    if gmcount == nil then
        gmcount = 10000
    else
        gmcount = gmcount + 1
    end
    PutPlayerTo(MapID, fx, fy, 0, 0)
    return 1
    --local RegionGID = CreateRegion(gmcount, MapID, 0, 0, 0, 0)
    --if MapID ~= nil then
    --    return 1
    --end
end

--设置通关关卡
function settask(taskid)
    SetTaskStatus(taskid)
    return 1
end