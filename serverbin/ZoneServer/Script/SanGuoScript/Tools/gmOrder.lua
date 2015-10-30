--[[
file:	gmOrder.lua
author:	wk
update:	2015-02-2
desc:gm命令模块
]]--



local function gmOrderList(gCMD , args)
	 if not _DEBUG then   --测试
		return
	end
	--look("")
	if gCMD == "add" then --增加玩家数据
		CI_AddGoods_SG(args[1],args[2],args[3],100)
	elseif gCMD == "dec" then 
		CI_DecGoods_SG(args[1],args[2],args[3])
	elseif gCMD == "setskill" then --设置武将技能等级;参数:武将id,技能位置(1-4),技能等级
		CI_SetPlayerDataSG(0,3,args[1],args[2],args[3])
	elseif gCMD == "addexp" then --增加武将经验(武将升级);参数2个:武将id,增加的经验值,具体经验值对应等级参照配置YingXiongDengJi.txt (需要重新登录)
		CI_SetPlayerDataSG(0,4,args[1],args[2])
	elseif gCMD == "setstar" then --设置武将星级;参数2个:武将id,武将星级
		CI_SetPlayerDataSG(0,5,args[1],args[2])
	elseif gCMD == "setrank" then --设置武将品阶;参数2个:武将id,武将品阶
		CI_SetPlayerDataSG(0,6,args[1],args[2])
	elseif gCMD == "setvip" then --设置vip等级
		gm_setvip(tonumber(args[1])	)
		--CI_UpdateVIPLevel(0, args[1])
	elseif gCMD == "wb" then --开始国战 war begin
		ClrEvent(War_Time)
		war_fight_start()
	elseif gCMD == "we" then --开始国战 war begin
		ClrEvent(War_Time)
		war_all_end()
	elseif gCMD == "wk" then --测试
		-- local data={ids={2,1},['a']='aaa',[1]=1,[2]=2,['t']={1,2,3}}
		-- local res=serialize(data)
		-- CI_SendMsg_SG(0,res)
		--db_gm_registerNum(5,1555556554)
		CI_TipMsg("111")
	elseif gCMD == "openamap" then --测试 openamap
		local psid = CI_GetPlayerDataSG(0,0)
		GM_OpenAllSceneMap(psid)
	elseif gCMD == "reload_giftkey" then --测试 重读激活码
		ReloadGiftFile()
	elseif gCMD == "armyactive" then
		local psid = CI_GetPlayerDataSG(0, 0)
		local PlayerFactionID = CI_GetPlayerDataSG(psid,10)
		ChangeFactionActive(PlayerFactionID, args[1])
	elseif gCMD == "setallskill" then
		CI_SetPlayerDataSG(0,3,args[1],1,80)
		CI_SetPlayerDataSG(0,3,args[1],2,80)
		CI_SetPlayerDataSG(0,3,args[1],3,80)
		CI_SetPlayerDataSG(0,3,args[1],4,80)	
		end
end

--解析命令和参数并执行
function AnalyzeAndExceteGMCommand(CmdString)
	if _DEBUG==nil then
		look("debug not open! func is AnalyzeAndExceteGMCommand")
		return
	end
	local detail = {}
	local func=nil
	local ParamIndex = 0
	local i = 1
	while true do
		m, n = string.find(CmdString, "%s+", i)
		if m == nil then
			Value = string.sub(CmdString, i)
		else
			Value = string.sub(CmdString, i, m - 1)
		end
		if func == nil then
			func = Value
		else
			ParamIndex = ParamIndex + 1
			detail[ParamIndex] = Value
		end
		if m == nil then
			break
		end
		i = n + 1
	end
	gmOrderList(func , detail)
end
