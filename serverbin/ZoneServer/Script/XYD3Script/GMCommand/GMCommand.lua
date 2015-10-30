LimitPlayerGMLevel = 0 		--玩家GM命令达到一定等级才能执行的操作
GM_Command_List = {
	--ExceteFunc,为该命令执行的函数；ParamLen, 为该函数中参数的数量；Type，表示是否为只有服务端才能使用该命令，为1表示该命令只能服务端才能使用
	--[[--服务端拥有下面所有GM命令，包括客户端GM命令--]]

	--[[--下面为客户端所拥有的GM命令--]]
	help = {},

	cgd = {ExceteFunc = changeglorydot, ParamLen = 2},	--改变玩家荣耀点

	cm = {ExceteFunc = changemoney, ParamLen = 3}, --改变玩家的金钱(参数依次为：玩家唯一索引GID；金钱类型；改变数值)

	ce = {ExceteFunc = changeexp, ParamLen = 2},	--更改玩家经验(参数依次为：玩家唯一索引GID；更改数量)

	cs = {ExceteFunc = changesp, ParamLen = 2},  --更改玩家真气(参数依次为：玩家唯一索引GID；更改数量)

	ag = {ExceteFunc = addgoods, ParamLen = 3}, --增加玩家背包中的物品(参数依次为：玩家唯一索引GID；物品ID；增加数量)

	dg = {ExceteFunc = delgoods, ParamLen = 3}, --消耗指定ID道具的数量(参数依次为：玩家唯一索引GID；道具ID；消耗该道具的数量)

	as = {ExceteFunc = activeskill, ParamLen = 2},		--激活技能(参数依次为：玩家唯一索引GID；技能ID)

	ap = {ExceteFunc = activepackage, ParamLen = 3}, -- 激活或锁定背包格子(参数依次为：玩家唯一索引GID；改变格子状态的数量；格子状态(激活1或锁定0))

	ssl = {ExceteFunc = setskilllevel, ParamLen = 3}, --设置当前技能ID的等级(参数依次为：玩家唯一索引GID；技能ID；技能等级)

	stisl = {ExceteFunc = setindexskilllevel, ParamLen = 3}, --设置索引位置技能等级(参数依次为：玩家唯一索引GID；技能在技能表中的索引；该技能等级)

	sv = {ExceteFunc = setplayerviplevel, ParamLen = 2}, --设置玩家Vip等级(参数依次为：玩家唯一索引GID；Vip等级值)

	gpsid = {ExceteFunc = UCgetplayersid, ParamLen = 1},	--获取玩家对服务器集群唯一静态的ID(SID)(参数依次为：玩家姓名)

	gpgid = {ExceteFunc = UCgetplayergid, ParamLen = 1}, 	--获取玩家全局唯一标示(参数依次为：玩家对服务器集群唯一静态的ID(SID)，由数据库服务器生成；)

	gpd = {ExceteFunc = UCgetplayerdata, ParamLen = 2}, --获取玩家数据(参数依次为：玩家唯一索引GID；相关数据索引)

	spd = {ExceteFunc = setplayerdata, ParamLen = 3}, --设置玩家数据(参数依次为：玩家唯一索引GID；对应数据的索引；设置的值)

	skam = {ExceteFunc = setkillallmonster, ParamLen = 2},  --关卡中玩家杀死已经刷新的所有怪物：因为怪物是分批刷出来的(参数依次为：玩家唯一索引GID；是否在关卡中使用该操作，0表示关闭启用，非0表示启用)

	ssc = {ExceteFunc = sendsyscall, ParamLen = 2}, 	--GM发送系统公告消息
	ptm = {ExceteFunc = pptm, ParamLen = 3}, 
	sct = {ExceteFunc = settask, ParamLen = 1}	--设置当前通关关卡

}

--获取玩家属性时的类型ID
GM_GetPlayerData_TypeList = {}
	GM_GetPlayerData_TypeList[0] = "获得玩家当前攻击值为："
	GM_GetPlayerData_TypeList[1] = "获得玩家当前防御值为："
	GM_GetPlayerData_TypeList[2] = "获得玩家当前暴击为："
	GM_GetPlayerData_TypeList[3] = "获得玩家当前闪避值为："
	GM_GetPlayerData_TypeList[4] = "获得玩家最大生命值为："
	GM_GetPlayerData_TypeList[5] = "获得玩家帮派名字为："
	GM_GetPlayerData_TypeList[6] = "获得玩家侠义值为："
	GM_GetPlayerData_TypeList[7] = "获得玩家杀孽值为："
	GM_GetPlayerData_TypeList[8] = "获得玩家精力值为："
	GM_GetPlayerData_TypeList[9] = "获得玩家经验值为："
	GM_GetPlayerData_TypeList[10] = "获得玩家等级为："
	GM_GetPlayerData_TypeList[11] = "获得玩家当前移动速度值为："
	GM_GetPlayerData_TypeList[12] = "获得玩家当前攻击速度为："
	GM_GetPlayerData_TypeList[13] = "获得玩家当前轻功点数为："
	GM_GetPlayerData_TypeList[14] = "获得玩家当前强健点数为："
	GM_GetPlayerData_TypeList[15] = "获得玩家配偶名字为："
	GM_GetPlayerData_TypeList[16] = "获得玩家最大内力值为："
	GM_GetPlayerData_TypeList[17] = "获得玩家最大体力值为："
	GM_GetPlayerData_TypeList[18] = "获得玩家当前生命值为："
	GM_GetPlayerData_TypeList[19] = "获得玩家当前内力值为："
	GM_GetPlayerData_TypeList[20] = "获得玩家当前体力值为："
	GM_GetPlayerData_TypeList[21] = "获得玩家真气值为："
	GM_GetPlayerData_TypeList[23] = "获得玩家门派为："
	GM_GetPlayerData_TypeList[25] = "获得玩家当前防御点数为："
	GM_GetPlayerData_TypeList[26] = "获得玩家当前进攻点数为："
	GM_GetPlayerData_TypeList[27] = "获得玩家当前可用点数值为："
	GM_GetPlayerData_TypeList[28] = "获得玩家的角色名为："
	GM_GetPlayerData_TypeList[29] = "获得玩家的账号名称为："
	GM_GetPlayerData_TypeList[30] = "获得玩家当前金币为："
	GM_GetPlayerData_TypeList[31] = "获得玩家当前银币为："
	GM_GetPlayerData_TypeList[32] = "获得玩家当前元宝数量为："
	GM_GetPlayerData_TypeList[33] = "获得玩家伤害减免为："
	GM_GetPlayerData_TypeList[34] = "获得玩家绝对伤害为："
	GM_GetPlayerData_TypeList[35] = "获得玩家无视防御为："
	GM_GetPlayerData_TypeList[36] = "获得玩家麒麟臂等级为："
	GM_GetPlayerData_TypeList[37] = "获得全局编号为："
	GM_GetPlayerData_TypeList[38] = "获得sid为："
	GM_GetPlayerData_TypeList[39] = "获得XYpos为："
	GM_GetPlayerData_TypeList[40] = "获得状态动作为："
	GM_GetPlayerData_TypeList[41] = "获得float XYpos为："
	GM_GetPlayerData_TypeList[42] = "获得玩家变身状态为："
	GM_GetPlayerData_TypeList[60] = "获得生成副本GID为："
	GM_GetPlayerData_TypeList[61] = "获得此副本的RID为："
	GM_GetPlayerData_TypeList[62] = "获得此场景的ID为："
	GM_GetPlayerData_TypeList[63] = "获得此场景的GID为："
	GM_GetPlayerData_TypeList[99] = "获得祈福标识为："
	GM_GetPlayerData_TypeList[100] = "获得性别为："
	GM_GetPlayerData_TypeList[101] = "获得VIP等级为："

--设置玩家属性时的类型ID
GM_SetPlayerData_TypeList = {}
	GM_SetPlayerData_TypeList[1] = nil
	GM_SetPlayerData_TypeList[2] = nil
	GM_SetPlayerData_TypeList[3] = "设置玩家当前真气"
	GM_SetPlayerData_TypeList[4] = nil
	GM_SetPlayerData_TypeList[5] = "设置玩家当前精力"
	GM_SetPlayerData_TypeList[6] = "设置玩家进攻"
	GM_SetPlayerData_TypeList[7] = "设置玩家防御"
	GM_SetPlayerData_TypeList[8] = "设置玩家轻身"
	GM_SetPlayerData_TypeList[9] = "设置玩家健身"
	GM_SetPlayerData_TypeList[10] = "设置玩家当前经验"
	GM_SetPlayerData_TypeList[11] = "设置玩家剩余点数"
	GM_SetPlayerData_TypeList[12] = "设置玩家玩家VIP等级"
	GM_SetPlayerData_TypeList[13] = "设置玩家等级"
	GM_SetPlayerData_TypeList[14] = nil
	GM_SetPlayerData_TypeList[15] = nil
	GM_SetPlayerData_TypeList[16] = "设置玩家银两"
	GM_SetPlayerData_TypeList[17] = "设置玩家银币"
	GM_SetPlayerData_TypeList[18] = "设置玩家赠宝"
	GM_SetPlayerData_TypeList[19] = "设置玩家元宝"

GM_Help_List = {		--GM命令说明
	help = "help查看所有GM相关命令：cm；ce；cs；ag；dg；as；ap；ssl；stisl；sv；gpsid；gpgid；gpd；spd；skam；ssc；cgd;",

	cm = "cm命令：改变玩家的金钱(参数依次为：玩家唯一索引GID；金钱类型；改变数值)",

	ce = "ce命令：更改玩家经验(参数依次为：玩家唯一索引GID；更改数量)",

	cs = "cs命令：更改玩家真气(参数依次为：玩家唯一索引GID；更改数量)",

	ag = "ag命令：增加玩家背包中的物品(参数依次为：玩家唯一索引GID；物品ID；增加数量)",

	dg = "dg命令：消耗指定ID道具的数量(参数依次为：玩家唯一索引GID；道具ID；消耗该道具的数量)",

	as = "as命令：激活技能(参数依次为：玩家唯一索引GID；技能ID)",

	ap = "ap命令：激活或锁定背包格子(参数依次为：玩家唯一索引GID；改变格子状态的数量；格子状态(激活1或锁定0))",

	ssl = "ssl命令：设置当前技能ID的等级(参数依次为：玩家唯一索引GID；技能ID；技能等级)",

	stisl = "stisl命令：设置索引位置技能等级(参数依次为：玩家唯一索引GID；技能在技能表中的索引；该技能等级)",

	sv = "sv命令：设置玩家Vip等级(参数依次为：玩家唯一索引GID；Vip等级值)",

	gpsid = "gpsid命令：获取玩家对服务器集群唯一静态的ID(SID)，如果需要玩家全局唯一索引GID，则需要先获得该值(参数依次为：玩家姓名)",

	gpgid = "gpgid命令：获取玩家全局唯一标识。如需设置或获取其他玩家的数据时，则需要先获取该值(参数依次为：玩家对服务器集群唯一静态的ID(SID)，由数据库服务器生成；)",

	gpd = "gpd命令：获取玩家数据(参数依次为：玩家唯一索引GID；相关数据索引)",

	spd = "spd命令：设置玩家数据(参数依次为：玩家唯一索引GID；对应数据的索引；设置的值)",

	skam = "skam命令：关卡中玩家杀死已经刷新的所有怪物：因为怪物是分批刷出来的(参数依次为：玩家唯一索引GID；是否在关卡中使用该操作，0表示关闭启用，非0表示启用)",
	ssc = "ssc命令：GM管理员发送系统公告消息(参数依次为：显示的次数；发送的公告信息)",
	cgd = "cgd命令：增加玩家荣耀点数(参数依次为：玩家唯一索引GID，改变值)",
}

--客户端输入的一般只有字符串和数字
function JuageAndReturnValue(StringValue)
	if type(StringValue) == "string" then
		return StringValue
	elseif type(StringValue) == "number" then
		NumberValue = tonumber(StringValue)
		return NumberValue
	end
	return StringValue
end

--解析命令和参数并执行
function AnalyzeAndExceteGMCommand(CmdString, GMLevel, MsgType, MsgTalker, Caller)	--Caller调用方式，1为服务端调用， 0为客户端调用
	local CmdAndParamDetail = {}
	local ParamIndex = 0
look("--------------------------")
look(CmdString)
	local i = 1
	local ParamIndex = 0
	while true do
		m, n = string.find(CmdString, "%s+", i)
		if m == nil then
			Value = string.sub(CmdString, i)
		else
			Value = string.sub(CmdString, i, m - 1)
		end

		if CmdAndParamDetail.FuncName == nil then
			CmdAndParamDetail.FuncName = Value
		else
			ParamIndex = ParamIndex + 1
			--判断参数类型
			Value = JuageAndReturnValue(Value)
			ParamName = "Param" .. ParamIndex
			CmdAndParamDetail[ParamName] = Value
		end
		if m == nil then
			break
		end
		i = n + 1
	end
look(CmdAndParamDetail)
	return ExceteGMCommand(CmdString, GMLevel, CmdAndParamDetail, ParamIndex, Caller, MsgType, MsgTalker)
end


--执行相关操作
function ExceteGMCommand(CmdAndParams,PlayerGMLevel, GetCmdAndParamDetail, paramLen, Caller, MsgType, MsgTalker)

	if type(GetCmdAndParamDetail) ~= "table" then
		return CmdAndParams .. "；执行失败"
	end
	local ParamIndex = paramLen

	if GM_Command_List[GetCmdAndParamDetail.FuncName] == nil then
		SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. "；没有" .. GetCmdAndParamDetail.FuncName .."命令！")
		return
	end

	--判断输入命令参数的个数是否相同
	if GM_Command_List[GetCmdAndParamDetail.FuncName].ParamLen ~= ParamIndex then
		if ParamIndex == 1 and GetCmdAndParamDetail.Param1 == "?" then
		else
			SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. "；" .. GetCmdAndParamDetail.FuncName .."参数不正确！")
			return
		end
	end


	local ReturnValue = nil
	if ParamIndex == 1 and GetCmdAndParamDetail.Param1 == "?" then		--查看命令说明
		SendGmExceResult(MsgType, MsgTalker, GM_Help_List[GetCmdAndParamDetail.FuncName])
		return
	else	--执行对应的命令

		--执行函数为nil时，不执行相关操作
		if	GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc == nil then
			SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. "；" .. GetCmdAndParamDetail.FuncName .. "没有做处理！")
			return
		end
	--相关命令函数的参数一般不超过4个参数。如果有，则增加条件
		if ParamIndex == 0 then
			ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc()
		elseif ParamIndex == 1 then
			ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param1)
		elseif ParamIndex == 2 then
			ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param1, GetCmdAndParamDetail.Param2)
		elseif ParamIndex == 3 then
			ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param1, GetCmdAndParamDetail.Param2, GetCmdAndParamDetail.Param3)
		elseif ParamIndex == 4 then
			ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param1, GetCmdAndParamDetail.Param2, GetCmdAndParamDetail.Param3, GetCmdAndParamDetail.Param4)
		elseif ParamIndex == 5 then
			ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param1, GetCmdAndParamDetail.Param2, GetCmdAndParamDetail.Param3, GetCmdAndParamDetail.Param4, GetCmdAndParamDetail.Param5)
		end


		if ReturnValue == nil or not ReturnValue then
			SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. "；操作失败")	--操作失败
			return
		else
			if tonumber(ReturnValue) == nil then
				SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. ReturnValue)
			end
			SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. "；操作成功")
			return
		end
	end
end
