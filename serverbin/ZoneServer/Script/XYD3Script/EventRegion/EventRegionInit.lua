-- -- 获取怪物状态枚举(GetMonsterData函数参数)
-- GMon_LEVEL			= 1		-- 怪物等级
-- GMon_ID				= 2		-- 怪物Monster模板ID
-- GMon_NAME			= 3		-- 怪物Name
-- GMon_EXP			= 4		-- 怪物经验
-- GMon_LevelType		= 5		-- 怪物类型（普通&精英&BOSS）
-- GMon_CURHP			= 6		-- 怪物当前血量
-- GMon_MaxHP			= 7		-- 怪物最大血量
-- GMon_AttType		= 8		-- 怪物攻击类型
-- GMon_LastEnemyID	= 9		-- 谁攻击了我
-- GMon_GroupID		= 10	-- 怪物的组别的ID
-- GMon_PartolRadius	= 11	-- 监控半径
-- GMon_TailLength		= 12	-- 追击半径
-- GMon_NodeCount		= 13	-- 路点总个数
-- GMon_CurNode		= 14	-- 当前路点个数
-- GMon_MoveType		= 15    -- 移动类型
-- GMon_Move2Att		= 16    -- 是否移动去攻击
-- GMon_CurrAction		= 17    -- 当前移动行为站立还是跑 还是其他
-- GMon_HPcent         = 18    -- 当前生命百分比
-- GMon_BackProtect    = 19    -- 处于返回保护
-- GMon_BornTime   	= 20    -- 出生到现在的时间
-- GMon_POSTION   		= 21    -- 坐标float XY
EventRegion = {}
EventRegionList = {}
PathList = {}

--GetAttackTargetMonster 搜索和自己不是同一个组的怪物，如果同一组不攻击

-----------------------------------------------------------------------------------------
dofile("XYD3Script\\EventRegion\\EventRegion20000.lua")
--dofile("XYD3Script\\EventRegion\\EventRegion20003.lua")
--dofile("XYD3Script\\EventRegion\\EventRegion20004.lua")
-----------------------------------------------------------------------------------------

-- 创建副本地图的函数
function LuaCreateEventRegion(regionID)--自定义函数
	local dyconf = EventRegion[regionID]
	if (nil == dyconf) then
		return
	end
	--if (dyconf.LevelLimt ~= nil) then
		--local n1 = dyconf.LevelLimt[1]
		--local n2 = dyconf.LevelLimt[2]
		--local Levl = GetPlayerData(0,GPP_LEVEL)
		--if (Levl > n1 and Levl <= n2) then
	
		--else
			--TalkToPlayer(2,"等级不合条件！等级段["..n1.." , "..n2.."]")
			--return
		--end
	--end
	local mapx = CreateRegion(regionID, dyconf.MapID, 0, 0, 0, 0)
	if (nil == mapx) then
		return
	end

	-- 创建普通怪物，如果在场景创建是没有设定普通怪，这一块没用的
	if type({}) == type (dyconf.Monster) then
		for k, mCreate in pairs(dyconf.Monster) do
			mCreate.regionId = mapx
			CreateObjectIndirect(mCreate)
		end
	end

	return mapx
end

-- 创建动态地图并且将玩家放入
function PutPlayerToEventRegion(regionID, x, y,id)--自定义函数
	if ( IsCanEnterPart(regionID) == 0 ) then
		rfalse("111")
		return
	end
	
	local dmGID = LuaCreateEventRegion(regionID)
	local n = GetPlayerTeam(1)
	if (dmGID == nil) then
		return
	end
	
	if(n == 0)then
		PutPlayerTo(0, x, y, dmGID,id)--最后2个参数
		CreatePartNpc(regionID)		  --这个回调判定在函数里面，如果没有什么也不会发生
		
	else
		local a = GetPlayerTeam(2)
		if(a == 1)then
			local PlayerGID = {}
			PlayerGID[0],PlayerGID[1],PlayerGID[2],PlayerGID[3],PlayerGID[4] = GetPlayerGIDbyTeam()
			for i=0,4 do
				if (PlayerGID[i]~=0) then
					PutPlayerTo(0, x, y, dmGID, PlayerGID[i])
					
				else
					rfalse("队伍为空: "..i)
				end
			end
			CreatePartNpc(regionID)		  --这个回调判定在函数里面，如果没有什么也不会发生
		else
			SendMsgForPlayer(0,"你不是队长不能开启副本")
		end
	end
end

-----------------------------------------------------------------------------------------

function EventRegion_Init(regionID, regionGID)
  --执行 Init_20000(regionGID) 等等
  local funcName = loadstring("Init_"..regionID.. "(" ..regionGID..","..regionID..")")
  --local funcName = loadstring("Init_" .. regionID .. "(" .. regionGID .. ")")
  funcName();

end

function EventRegion_Run(regionID, regionGID, regionExistTime)

  --执行 Run_20000(regionGID, RegionExistTime) 等等
  local funcName = loadstring("Run_" .. regionID .. "(" .. regionGID .. "," .. regionExistTime ..","..regionID.. ")")
  funcName();
  
end

function EventRegion_End(regionID, regionGID, regionExistTime, regionEndTime,EventRegionEnd)

  --执行 End_20000(regionGID, RegionExistTime) 等等
  local funcName = loadstring("End_" .. regionID .. "(" .. regionGID .. "," .. regionExistTime .."," .. regionEndTime ..","..regionID..","..EventRegionEnd..")")
  funcName();
  
end

function PushPlayerTemplate(RegID)--关于玩家属性,技能收起抱抱
	if (EventRegion[RegID] == nil) then
		return
	end
	
	if (EventRegion[RegID].UsePlayerProperty == 1) then --玩家使用模板数据在这个接口使用填上数据
		OnPlayerClearBuff()
		for k,v in ipairs(EventRegion[RegID].TUPtable) do
			local Index = v[1]
			local value = v[2]
			SetPlayerData(1,Index,value)
		end
		LoadPlayerModifValue()
	end
	if (EventRegion[RegID].TemplateSkill == 1) then --玩家使用模板技能
		for k,v in pairs(EventRegion[RegID].TStable) do
			local SkillID = v[1]
			if (SkillID ~= nil) then
				local index = ActiveTempSkill(SkillID)
				if (index ~= -1) then
					v[2] = index
				end
			else
				rfalse("装技能失败!!!")
			end
		end
		SendTemplateSkill()
	end
	if (EventRegion[RegID].CallOutPet == 1) then --玩家收起侠客
		OnBackFightPet() --收起侠客
	end
	
	local value = EventRegion[RegID].BaseSore
	if (value ~= nil) then
		SetPlayerData(2,1,value)
		local str = "你获得了 "..value.." 分"
		TalkToPlayer(2,str)
	end
end

function PopPlayerTemplate(RegID)
	if (EventRegion[RegID] == nil) then
		return
	end
	if (EventRegion[RegID].UsePlayerProperty == 1) then --玩家使用模板数据在这个接口使用填上数据
		UnLoadPlayerModifValue()
	end
	if (EventRegion[RegID].TemplateSkill == 1) then --玩家使用模板技能
		CoolingTempSkill(0)				--剔除数据
	end
	if (EventRegion[RegID].CallOutPet == 1) then --玩家收起侠客
		
	end
end

function IsCanUsePet(RegID)
	if (EventRegion[RegID] == nil) then
		return 1 --可以使用侠客
	end
	if (EventRegion[RegID].CallOutPet == 1) then
		return 0 --不能使用侠客
	end
	return 1
end

function IsCanUseSkill(RegID,index)
	if (EventRegion[RegID] == nil) then
		return 1 --可以使用技能
	end
	if (EventRegion[RegID].TemplateSkill == 1) then
		for k,v in pairs(EventRegion[RegID].TStable) do
			local Index = v[2]
			if(Index == index) then
				return 1
			end
		end
		return 0
	end
	return 1	
end
function CreatePartNpc(RegID)
	if (EventRegion[RegID] == nil) then
		return
	end
	if (EventRegion[RegID].NpcTempCreate == 1)then
		for k,v in pairs(EventRegion[RegID].TNPtable) do
			rfalse("创建NPC在"..v)
			if (NpcTable[v] ~= nil) then
				NpcTable[v].NpcCreate.controlId 	= v
				NpcTable[v].NpcCreate.clickScript   = v
				CreateObjectIndirect(NpcTable[v].NpcCreate)
			else
				rfalse("找不到这个家伙")
			end
		end
	end
end

function OnTFPlayerValue(RegionID)
	if (EventRegion[RegionID] ~= nil) then
		if (EventRegion[RegionID].AddSore ~= nil) then
			SetPlayerData(2,1,value)
			local str = "你获得了 "..value.." 分"
			TalkToPlayer(2,str)
		end
	end
end

function GivePlayerLiftData(regionGID,regionID,FlagResult)
	if (EventRegion[regionID]~= nil) then
		local GExp		= EventRegion[regionID].RewardsEXP
		local GMoney	= EventRegion[regionID].RewardsMoney
		local GItem		= EventRegion[regionID].RewardsItem
		if (GExp == nil)then
			GExp = 0
		end
		if (GMoney == nil)then
			GMoney = 0
		end
		--rfalse("Gexp "..GExp)
		OnGivePlayerLiftData(regionGID,regionID,GExp,GMoney,GItem)--奖励礼物回调
	end
end
--副本踢人直接回家
function PartKickerToReturn(wEventID,id)
	PutPlayerTo(0,0,0,wEventID,id)
	--local wEventID = GetEventID()
	--if ( id ~= 0 and id ~= nil) then
		--local id = GetPlayerData(0,GPP_QUANJUGID)
	--end
end

function IsCanEnterPart(regionID) --先判断是否能技能退伍
	local dyconf = EventRegion[regionID]
	if (nil == dyconf) then
		return 0
	end
	local n = GetPlayerTeam(1)
	if(n == 0)then --可以进入是一个人 是否有组队
		if (dyconf.LevelLimt ~= nil) then
			  local n1 = dyconf.LevelLimt[1]
			  local n2 = dyconf.LevelLimt[2]
			  local Levl = GetPlayerData(0,GPP_LEVEL)
			  if (Levl >= n1 and Levl <= n2) then
				  return 1	
			  else
				  TalkToPlayer(2,"等级不合条件！等级段["..n1.." , "..n2.."]")
				  return 0
		      end
		else
			return 1
		end
	else
		local n1 = dyconf.LevelLimt[1]
		local n2 = dyconf.LevelLimt[2]
		local a = GetPlayerTeam(2) --是否是队长
		if(a == 1)then
			local PlayerLv= {}
			PlayerLv[0],PlayerLv[1],PlayerLv[2],PlayerLv[3],PlayerLv[4] = GetPlayerLevelbyTeam()
			for i=0,4 do
				if (PlayerLv[i]~=0) then
					if (PlayerLv[i] > n1 and PlayerLv[i] <= n2) then
							
					else
						TalkToPlayer(2,"队伍中有人等级不合条件！等级段["..n1.." , "..n2.."]")
						return 0
					end
				end
			end
			return 1
		else
			SendMsgForPlayer(0,"你不是队长不能开启副本")
			return 0
		end
	end
	return 0
	
end
