LimitPlayerGMLevel = 0 		--玩家GM命令达到一定等级才能执行的操作
GM_Command_List = {
	--ExceteFunc,为该命令执行的函数；ParamLen, 为该函数中参数的数量；Type，表示是否为只有服务端才能使用该命令，为1表示该命令只能服务端才能使用
	--[[--服务端拥有下面所有GM命令，包括客户端GM命令--]]

	--[[--下面为客户端所拥有的GM命令--]]
	help = {},

	changeglorydot = {ExceteFunc = ChangeGloryDot, ParamLen = 2},	--改变玩家荣耀点

	changemoney = {ExceteFunc = ChangeMoney, ParamLen = 3}, --改变玩家的金钱(参数依次为：玩家唯一索引GID；金钱类型；改变数值)

	changeexp = {ExceteFunc = GiveExp, ParamLen = 2},	--更改玩家经验(参数依次为：玩家唯一索引GID；更改数量)

	changesp = {ExceteFunc = GiveSp, ParamLen = 2},  --更改玩家真气(参数依次为：玩家唯一索引GID；更改数量)

	addgoods = {ExceteFunc = GiveGoods, ParamLen = 3}, --增加玩家背包中的物品(参数依次为：玩家唯一索引GID；物品ID；增加数量)

	delgoods = {ExceteFunc = DeleteItem, ParamLen = 3}, --消耗指定ID道具的数量(参数依次为：玩家唯一索引GID；道具ID；消耗该道具的数量)

	activeskill = {ExceteFunc = ActiveSkill, ParamLen = 2},		--激活技能(参数依次为：玩家唯一索引GID；技能ID)

	activepackage = {ExceteFunc = ActivePackage, ParamLen = 3}, -- 激活或锁定背包格子(参数依次为：玩家唯一索引GID；改变格子状态的数量；格子状态(激活1或锁定0))

	setskilllevel = {ExceteFunc = SetSkillLevel, ParamLen = 3}, --设置当前技能ID的等级(参数依次为：玩家唯一索引GID；技能ID；技能等级)

	setindexskilllevel = {ExceteFunc = SetCurrentSkillLevel, ParamLen = 3}, --设置索引位置技能等级(参数依次为：玩家唯一索引GID；技能在技能表中的索引；该技能等级)

	setplayerviplevel = {ExceteFunc = SetPlayerVipLevel, ParamLen = 2}, --设置玩家Vip等级(参数依次为：玩家唯一索引GID；Vip等级值)

	--addmoney = {ExceteFunc = GiveMoney, ParamLen = 2},  --增加玩家金钱(参数依次为：钱类型；增加数量)

	--createcount = {ExceteFunc = GiveMount, ParamLen = 1},  --创建坐骑(参数依次为：坐骑ID)

	--createpet = {ExceteFunc = GivePet, ParamLen = 1},  --创建宠物(参数依次为：宠物ID)

	--createfightpet = {ExceteFunc = GiveFightPet, ParamLen = 1},		--创建侠客(参数依次为：侠客ID)

	--UCgetitemnum = {ExceteFunc = GetItemNum, ParamLen = 2},		--获取指定道具的数量(参数依次为：道具ID；玩家唯一索引，为0时表示当前玩家)

	UCgetplayersid = {ExceteFunc = GetPlayerSID, ParamLen = 1},	--获取玩家对服务器集群唯一静态的ID(SID)(参数依次为：玩家姓名)

	UCgetplayergid = {ExceteFunc = GetPlayerGID, ParamLen = 1}, 	--获取玩家全局唯一标示(参数依次为：玩家对服务器集群唯一静态的ID(SID)，由数据库服务器生成；)

	UCgetplayerdata = {ExceteFunc = GetPlayerData, ParamLen = 2}, --获取玩家数据(参数依次为：玩家唯一索引GID；相关数据索引)

	setplayerdata = {ExceteFunc = NewSetPlayerProperty, ParamLen = 3}, --设置玩家数据(参数依次为：玩家唯一索引GID；对应数据的索引；设置的值)

	setkillallmonster = {ExceteFunc = SetKillAllMonster, ParamLen = 2},  --关卡中玩家杀死已经刷新的所有怪物：因为怪物是分批刷出来的(参数依次为：玩家唯一索引GID；是否在关卡中使用该操作，0表示关闭启用，非0表示启用)

	sendsyscall = {ExceteFunc = SendSysCall, ParamLen = 2}, 	--GM发送系统公告消息

	--getmonsterdata = {ExceteFunc = GetMonsterData, ParamLen = 1}, --获取怪物数据(参数依次为：怪物数据索引)

	--setmonsterdata = {ExceteFunc = SetMonsterData, ParamLen = 2},  --设置怪物数据(参数依次为：怪物数据索引；对应索引的值)

	--activetelegry = {ExceteFunc = ActiveTelegry, ParamLen = 1}, --激活心法(参数依次为：心法ID)

	--getservertime = {ExceteFunc = GetServerTime, ParamLen = 0}, --获取服务器时间

	--settips = {ExceteFunc = SetTips, ParamLen = 1},  --设置系统消息(参数依次为：消息内容)

	--lockplayer = {ExceteFunc = LockPlayer, ParamLen = 2}, --锁定玩家(参数依次为：锁定时间；锁定玩家全局唯一标识)

	--unlockplayer = {ExceteFunc = UnLockPlayer, ParamLen = 1}, --解锁锁定玩家(参数依次为：锁定玩家全局唯一标识)

	--setplyaercopyscenestate = {ExceteFunc = SetPlyaerCopySceneState, ParamLen = 1}, --设置玩家副本状态(参数依次为：副本状态值)

	--playeraddbuff = {ExceteFunc = PlayerAddBuff, ParamLen = 1}, --增加玩家的BUF(参数依次为：BUFID)

	--setplayerfightpoint = {ExceteFunc = setplayerpoint, ParamLen = 2}, --设置玩家战斗点数(参数依次为：战斗点类型(攻击、防御等类型)；增加数量)

	--setplayerdegree = {ExceteFunc = SetPlayerDegree, ParamLen = 2}, --设置玩家好友度(参数依次为：目标好友名；设置好友度值)

	--clearplayerbuff = {ExceteFunc = PlayerClearBuff, ParamLen = 0}, --清除玩家身上的Buff

	--setcrilial = {ExceteFunc = SetCrilial, ParamLen = 1}, --设置玩家产生暴击的值(参数依次为：产生暴击的值)

	--delequip = {ExceteFunc = DelEquipment, ParamLen = 1}, --删除指定索引的装备(参数依次为：装备索引)

	--setisnewplayer = {ExceteFunc = SetIsNewPlayer, ParamLen = 1}, 	--设置是否为新创建玩家(参数依次为：第一次创建玩家标识数值)

	--killallmonster = {ExceteFunc = KillAllMonster, ParamLen = 2}, --杀死场景中所有的怪物(参数依次为：场景ID；玩家全局唯一标识)

	--setobjectdata = {ExceteFunc = SetObjectData, ParamLen = 3}, --设置对象相关数据(参数依次为：对象全局唯一标识；数据类型索引；设置的数据值)

	--settaskfinish = {ExceteFunc = SetTaskFinish, ParamLen = 2}, --设置任务完成(参数依次为：玩家全局唯一标识；任务ID)

	--settransformerslevel = {ExceteFunc = SetTransformersLevel, ParamLen = 2}, --设置变身等级(参数依次为：变身索引；变身等级)

	--addskillproficiency = {ExceteFunc = AddSkillProficiency, ParamLen = 2}, --增加技能熟练度(参数依次为：技能ID；熟练度值)
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
	help = "help查看所有GM相关命令：changemoney；changeexp；changesp；addgoods；delgoods；activeskill；activepackage；setskilllevel；setindexskilllevel；setplayerviplevel；UCgetplayersid；UCgetplayergid；UCgetplayerdata；setplayerdata；setmovekillmonster；sendsyscall；changeglorydot;",

	changemoney = "changemoney命令：改变玩家的金钱(参数依次为：玩家唯一索引GID；金钱类型；改变数值)",

	changeexp = "changeexp命令：更改玩家经验(参数依次为：玩家唯一索引GID；更改数量)",

	changesp = "changesp命令：更改玩家真气(参数依次为：玩家唯一索引GID；更改数量)",

	addgoods = "addgoods命令：增加玩家背包中的物品(参数依次为：玩家唯一索引GID；物品ID；增加数量)",

	delgoods = "delgoods命令：消耗指定ID道具的数量(参数依次为：玩家唯一索引GID；道具ID；消耗该道具的数量)",

	activeskill = "activeskill命令：激活技能(参数依次为：玩家唯一索引GID；技能ID)",

	activepackage = "activepackage命令：激活或锁定背包格子(参数依次为：玩家唯一索引GID；改变格子状态的数量；格子状态(激活1或锁定0))",

	setskilllevel = "setskilllevel命令：设置当前技能ID的等级(参数依次为：玩家唯一索引GID；技能ID；技能等级)",

	setindexskilllevel = "setindexskilllevel命令：设置索引位置技能等级(参数依次为：玩家唯一索引GID；技能在技能表中的索引；该技能等级)",

	setplayerviplevel = "setplayerviplevel命令：设置玩家Vip等级(参数依次为：玩家唯一索引GID；Vip等级值)",

	UCgetplayersid = "UCgetplayersid命令：获取玩家对服务器集群唯一静态的ID(SID)，如果需要玩家全局唯一索引GID，则需要先获得该值(参数依次为：玩家姓名)",

	UCgetplayergid = "UCgetplayergid命令：获取玩家全局唯一标识。如需设置或获取其他玩家的数据时，则需要先获取该值(参数依次为：玩家对服务器集群唯一静态的ID(SID)，由数据库服务器生成；)",

	UCgetplayerdata = "UCgetplayerdata命令：获取玩家数据(参数依次为：玩家唯一索引GID；相关数据索引)",

	setplayerdata = "setplayerdata命令：设置玩家数据(参数依次为：玩家唯一索引GID；对应数据的索引；设置的值)",

	setkillallmonster = "setkillallmonster命令：关卡中玩家杀死已经刷新的所有怪物：因为怪物是分批刷出来的(参数依次为：玩家唯一索引GID；是否在关卡中使用该操作，0表示关闭启用，非0表示启用)",
	sendsyscall = "sendsyscall命令：GM管理员发送系统公告消息(参数依次为：显示的次数；发送的公告信息)",
	changeglorydot = "changeglorydot命令：增加玩家荣耀点数(参数依次为：玩家唯一索引GID，改变值)",
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

		if GetCmdAndParamDetail.FuncName == "UCgetplayersid" then
			ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param1)
			if	ReturnValue == nil then
				ReturnValue = "操作失败"
			end
			SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. "；" .. GetCmdAndParamDetail.Param1 .. "玩家的SID为：" ..ReturnValue)
			return
		elseif GetCmdAndParamDetail.FuncName == "UCgetplayergid" then
			ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param1)
			SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. "；SID为" .. GetCmdAndParamDetail.Param1 .. "玩家的GID为：" .. ReturnValue)
			return
		elseif GetCmdAndParamDetail.FuncName == "UCgetplayerdata" then	--执行不修改操作

			local GetType = tonumber(GetCmdAndParamDetail.Param2)
			if GM_GetPlayerData_TypeList[GetType] == nil then	--获取类型没有
				SendGmExceResult(MsgType, MsgTalker, GetCmdAndParamDetail.FuncName .. " 没有该索引的值")
				return
			end

			ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param1, GetCmdAndParamDetail.Param2)

			--处理返回来的值
			if type(ReturnValue) == "table" then  --返回的是玩家的位置，获取位置
					ReturnValue ="XPos = " .. ReturnValue[1] .. "\tYPos = " .. ReturnValue[2]
			end
			if	ReturnValue == nil then
				ReturnValue = CmdAndParams .. "；操作失败"
			end
			SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. " " .. GM_GetPlayerData_TypeList[GetType] .. ReturnValue)
			return
		--设置操作必须玩家GM等级达到一定的级别
		elseif	GetCmdAndParamDetail.FuncName == "setplayerdata" then

			if PlayerGMLevel < LimitPlayerGMLevel then
				SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. "；玩家的GM等级不够")
				return
			end

			local SetType = tonumber(GetCmdAndParamDetail.Param2)
			if GM_SetPlayerData_TypeList[SetType] == nil then	--获取类型没有
				SendGmExceResult(MsgType, MsgTalker, GetCmdAndParamDetail.FuncName .. " 没有该索引")
				return
			end

			ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param1, GetCmdAndParamDetail.Param2, GetCmdAndParamDetail.Param3)

		elseif	GetCmdAndParamDetail.FuncName == "setkillallmonster" then
			if PlayerGMLevel < LimitPlayerGMLevel then
				SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. "；玩家的GM等级不够")
				return
			end
			ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param1, GetCmdAndParamDetail.Param2)

		elseif GetCmdAndParamDetail.FuncName == "sendsyscall" then
			if PlayerGMLevel < LimitPlayerGMLevel then
				SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. "；玩家的GM等级不够")
				return
			end
			ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param1, GetCmdAndParamDetail.Param2)

		elseif GetCmdAndParamDetail.FuncName == "changeglorydot" then
			if PlayerGMLevel < LimitPlayerGMLevel then
				SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. "；玩家的GM等级不够")
				return
			end
			ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param1, GetCmdAndParamDetail.Param2)
		else	--前面这几个操作中执行函数的参数都有玩家的GID，而这里面的命令执行函数中的参数是没有GID，所以设置一下

			if PlayerGMLevel < LimitPlayerGMLevel then
				SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. "；玩家的GM等级不够")
				return
			end


			SetPlayerObject(GetCmdAndParamDetail.Param1)  --通过GID设置执行脚本的玩家

			if GetCmdAndParamDetail.FuncName == "activepackage" then	--发送更新的格子
				ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(0, GetCmdAndParamDetail.Param2, GetCmdAndParamDetail.Param3)	--通过第一个参数和第二个参数计算更改格子状态的大小
				local ActiveCellNum = GetCmdAndParamDetail.Param2
				--成功, 第一个参数结果，第二个参数是当前激活的扩展背包总数
				SendActivePackage(0, ActiveCellNum)
			else

				--相关命令函数的参数一般不超过4个参数。如果有，则增加条件
				if ParamIndex == 1 then
					ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc()
				elseif ParamIndex == 2 then
					ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param2)
				elseif ParamIndex == 3 then
					ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param2, GetCmdAndParamDetail.Param3)
				elseif ParamIndex == 4 then
					ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param2, GetCmdAndParamDetail.Param3, GetCmdAndParamDetail.Param4)
				elseif ParamIndex == 5 then
					ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param2, GetCmdAndParamDetail.Param3, GetCmdAndParamDetail.Param4, GetCmdAndParamDetail.Param5)
				end
			end

		end

		if ReturnValue == nil or not ReturnValue then
			SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. "；操作失败")	--操作失败
			return
		else
			SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. "；操作成功")
			return
		end
	end
end
