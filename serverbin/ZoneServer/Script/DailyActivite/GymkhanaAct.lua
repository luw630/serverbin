
function GymkhanaManagerInit()
	if GymkhanaManager == nil then					--普通通关
		GymkhanaManager = {}
	end
	CurGymkhanaInf = {}
	CurGymkhanaInf.PreGroupRegionGID = nil
	--CurGymkhanaInf[RegionGID] = {}  --当前分组的玩家数据信息
    --CurGymkhanaInf[RegionGID][1] = 0  --当前在场景中的玩家数量
    --CurGymkhanaInf[RegionGID][2] = 0  --进入场景中的玩家数量（包括已经离开的玩家数量）
end

GymkhanaManagerInit()

function GymkhanaMainLoop()	
	for k,v in pairs(GymkhanaManager) do
		if v.survivetime ~= nil and v.starttime ~= nil  then
			local survivetime = v.survivetime * 60		--换成秒
			if (os.time() - v.starttime > survivetime and survivetime ~= 0) or GymOpenTimeInf.OpenFlag == 0 then
				v.survivetime = 0 	--由于改该函数一直在检测，保证只执行一次
				rfalse("v.CurDailyIndex = " .. tostring(v.CurDailyIndex))
				RequestGymkhanaAward(v.CurDailyIndex, k, v.mapx)
				--OnRecvSQLeaveDailyScene(v.Playerlist)
				break
			end
		end	
		--OnCheckTimeToRefresh(v)
		if v.IsComplete ~= 1 then
			delayCall_new(v.mapx)
		end
	end
end

--把玩家插入到一个未到达指定数量的组中
function InsertGymkhanaPlayer(regionID, mapid)
	local PreRegionGID = CurGymkhanaInf.PreGroupRegionGID
	local RegionGID
	if PreRegionGID == nil then
		RegionGID = CreateScene(regionID, mapid, 2, 0, 0, 0)    --创建日常活动场景
		CurGymkhanaInf[RegionGID] = {}
		CurGymkhanaInf[RegionGID][1] = 1
		CurGymkhanaInf[RegionGID][2] = 1
		CurGymkhanaInf.PreGroupRegionGID = RegionGID
	else
		if CurGymkhanaInf[PreRegionGID][2] < EveryGroupNum then
			CurGymkhanaInf[PreRegionGID][1] = CurGymkhanaInf[PreRegionGID][1] + 1
			CurGymkhanaInf[PreRegionGID][2] = CurGymkhanaInf[PreRegionGID][2] + 1
		else
			RegionGID = CreateScene(regionID, mapid, 2, 0, 0, 0)    --创建日常活动场景
			CurGymkhanaInf[RegionGID] = {}
			CurGymkhanaInf[RegionGID][1] = 1
			CurGymkhanaInf[RegionGID][2] = 1
			CurGymkhanaInf.PreGroupRegionGID = RegionGID
		end
	end
	return CurGymkhanaInf.PreGroupRegionGID
end

--从一个分组中移除玩家
function RemoveGymkhanaPlayer(RegionGID)
	if CurGymkhanaInf[RegionGID] == nil then
		return
	end
	if CurGymkhanaInf[RegionGID][1] > 0 then
		CurGymkhanaInf[RegionGID][1] = CurGymkhanaInf[RegionGID][1] - 1
		if CurGymkhanaInf[RegionGID][1] == 0 then
			CurGymkhanaInf[RegionGID] = nil
			if RegionGID == CurGymkhanaInf.PreGroupRegionGID then
				CurGymkhanaInf.PreGroupRegionGID = nil
			end
		end
	end
end

--判断活动当前场景中是否为第一个玩家进入
function JudgeGymhkanaIsFirstPlayer(RegionGID)
	if CurGymkhanaInf[RegionGID] == nil then
		return false
	end
	if CurGymkhanaInf[RegionGID][2] == 1 then
		return true
	end
	return false
end

--获得当前场景中的人数
function GetCurGymhkanaPlayerNum(RegionGID)
	if CurGymkhanaInf[RegionGID] == nil then
		return 0
	end 
	return CurGymkhanaInf[RegionGID][1]
end

--把玩家放入日常活动场景中
function PutPlayerToGymkhanaScene(DailyIndex)
	local scmap = DailySceneTable[DailyIndex]	--日常活动地图数据
	if scmap ~= nil then
		local gymkhanascenebase = {}
		local gymkhanaplayerbase = {}
		gymkhanaplayerbase.Monster = {}


		local regionID = scmap.regionID
		local mapid = scmap.MapID
        local RegionGID = InsertGymkhanaPlayer(regionID, mapid)
		if (nil == RegionGID) then
			return
		end

		-- 创建怪物
		gymkhanaplayerbase.Monsterlist = {}
		if scmap.Monster ~= nil then
			for k, mCreate in pairs(scmap.Monster) do
				mCreate.regionId = RegionGID
				local monstergid = CreateObjectIndirect(mCreate)
				--table.insert(gymkhanaplayerbase.Monsterlist,monstergid)
			end
			gymkhanaplayerbase.Monster = scmap.Monster
			gymkhanaplayerbase.MonsterNum = GetTableLenth(scmap.Monster)
		elseif scmap.BatchMonster ~= nil then
			gymkhanaplayerbase.CurDailyIndex = DailyIndex	--当前日常索引
			gymkhanaplayerbase.wKillCount = 0	--玩家杀怪数量
			gymkhanaplayerbase.wcurrenthit = 0						--当前连击数
			gymkhanaplayerbase.wmaxhit = 0							--最大连击
			gymkhanaplayerbase.dlasthittime = 0 						--上一次产生伤害的时间
			gymkhanaplayerbase.MonsterDropGlodNum = 0	--活动中怪物掉落的银币数量，最后结算
			gymkhanaplayerbase.UDHMonsterID = 0	--未知神殿随机刷出的怪物ID
			gymkhanaplayerbase.refreshstarttime = os.time()   --进入开始时间
			gymkhanaplayerbase.survivetime = scmap.LimitContorl.OpenTime	--日常活动时间限制, 时间到后自动结束日常活动
			gymkhanaplayerbase.SpecMonsterDieTimes = 0 		--指定怪物死亡次数，用于财富山活动

			--把玩家放到目标场景
			if scmap.bornPostion ~= nil then
				local x = scmap.bornPostion[1]
				local y = scmap.bornPostion[2]
				PutPlayerTo(0, x, y, RegionGID,0)
				rfalse("PutPlayerTo x = "..x.." y = "..y.."")
				gymkhanaplayerbase.Playerlist = GetPlayerGID(0)
				gymkhanaplayerbase.starttime = os.time()

	            --进入时玩家的血量增满
				local m_PlayerMaxHp = GetPlayerData(gymkhanaplayerbase.Playerlist, 4)	--获取玩家最多血量
				SetObjectData(gymkhanaplayerbase.Playerlist, 18, m_PlayerMaxHp)	--设置玩家满血
			end


			local IsFirstPlayer = JudgeGymhkanaIsFirstPlayer(RegionGID)
			if IsFirstPlayer then
				gymkhanascenebase.BatchMonster = {}
				gymkhanascenebase.BatchMonsternum = {}
				gymkhanascenebase.BatchMonsterBossID = {}	--用于精英关卡
				gymkhanascenebase.BatchCurrentGroup = 1    --默认为第一波
				gymkhanascenebase.RefreshType = scmap.BatchMonster.refreshtype    --类型
				gymkhanascenebase.RefreshDelayTime = {} --延时
				gymkhanascenebase.wAllKillCount = 0	--总的杀怪数量
				gymkhanascenebase.WinCondition = scmap.WinCondition	--胜利条件
				local MonsterNum = 0
				local NpcNum = 0
				for k,v in pairs(scmap.BatchMonster) do
					if type(v) == "table" then

						if k >= gymkhanascenebase.BatchCurrentGroup then
							gymkhanascenebase.RefreshDelayTime[k] = v.refreshdelaytime
						end
						--刷新当前波怪物
						if k == gymkhanascenebase.BatchCurrentGroup then  --通知玩家下一波怪物是第几波怪和刷新延迟时间
						SendNextBatchMonsterInf(0, k, gymkhanascenebase.RefreshDelayTime[k], scmap.DailyID)
						end
						for i,j in pairs(v.monsterlist) do
							j.regionId = RegionGID
							if k == gymkhanascenebase.BatchCurrentGroup then  --刷新当前批怪物
								local RefreshMonster = deepcopy(j)

								--local monstergid = CreateObjectIndirect(j)
								local createmon = {CreateObjectIndirect,RefreshMonster}
								local delaytime = gymkhanascenebase.RefreshDelayTime[k]
								AddfunctiondelayCall(delaytime, createmon, RegionGID)
							end
							if j.objectType == 1 then
								NpcNum = NpcNum + 1
							end
						end
						if k >= gymkhanascenebase.BatchCurrentGroup then
							gymkhanascenebase.BatchMonster[k] = v.monsterlist
							MonsterNum = MonsterNum + GetTableLenth(v.monsterlist) - NpcNum         --所有怪物数量
							gymkhanascenebase.BatchMonsternum[k] = GetTableLenth(v.monsterlist) - NpcNum   --每一波怪物数量
							gymkhanascenebase.RefreshDelayTime[k] = v.refreshdelaytime
							gymkhanascenebase.BatchMonsterBossID[k] = v.BossMonsterID 	--每一波怪物的BOSS怪物ID
							NpcNum = 0
						end
					end
				end
				gymkhanascenebase.MonsterNum = MonsterNum

				CurGymkhanaInf[RegionGID].RegionInf = deepcopy(gymkhanascenebase)
			end
		end

		if scmap.LimitContorl ~= nil then
			gymkhanaplayerbase.OpenTime = scmap.LimitContorl.OpenTime	--开放条件
			gymkhanaplayerbase.mapx = RegionGID
			local PlayerGID = GetPlayerData(0, 37)
			if GymkhanaManager[PlayerGID] == nil then
				GymkhanaManager[PlayerGID] = {}
				GymkhanaManager[PlayerGID] = deepcopy(gymkhanaplayerbase)
				GymkhanaManager[PlayerGID].IsComplete = 0				--日常活动场景是否结束，1表示结束，不一定日常活动完成
				GymkhanaManager[PlayerGID].CompleteWhy = -1				--当IsComplete = 1时，应根据该字段判断活动是否已经完成（取值为：
																										--DAILY_AllMONSTERDIE = 0		--日常活动中所有怪物都死亡
																										--DAILY_PLAYERDIE = 1	--玩家死亡，判断杀怪层数
																										--DAILY_SPECIFYMONSTERDIE = 2  --指定ID的怪物死亡）
				GymkhanaManager[PlayerGID].diemonsternum = 0          --已经死亡的怪物计数
				SendEnterSceneMsg(0)							--发送进入成功消息
			end
		end
	end
end


--日常活动场景中对象死亡处理
function OnGymkhanaObjectDead(objectgid,reginid,mapID,killgid, killedgid)	--后面两个参数依次为：主动杀的对象；被杀的对象
	local PlayerGID
    if GetObjectType(objectgid) == OBJECT_PLAYER then
        PlayerGID = objectgid
    else
        if GetObjectType(killgid) == OBJECT_PET then  --杀死怪物为侠客
            killgid = GetPetOwer(killgid)
        end
        PlayerGID = killgid
    end
    if GymkhanaManager[PlayerGID] == nil then
        return
    end
	local GymkhanaScManager = GymkhanaManager[PlayerGID]
	local CurDailyIndex = GymkhanaScManager.CurDailyIndex
	if GetObjectType(objectgid) == OBJECT_PLAYER then
		disposeplayerdead(objectgid,reginid,mapID)  							--处理玩家死亡
		OnMonsterKillPlayer(objectgid,reginid,mapID,killgid)
		GymkhanaScManager.IsComplete = 1						--闯关完成
		GymkhanaScManager.CompleteWhy = DAILY_PLAYERDIE	--玩家死亡日常活动结束
		RequestGymkhanaAward(GymkhanaScManager.CurDailyIndex, objectgid, reginid)		--结束奖励，并通知玩家
	elseif GetObjectType(objectgid) == OBJECT_MONSTER then		--处理怪物死亡
		local RegionManager = CurGymkhanaInf[reginid].RegionInf
		GymkhanaScManager.wKillCount = GymkhanaScManager.wKillCount + 1
		RegionManager.wAllKillCount = RegionManager.wAllKillCount + 1
		if RegionManager.WinCondition ~= nil then
			local diemonsterid = GetMonsterData(2)
			if RegionManager.WinCondition.winrule == DAILY_AllMONSTERDIE then  --所有怪物死亡
				if RegionManager.MonsterNum > 0 then
					RegionManager.MonsterNum = RegionManager.MonsterNum - 1
					CurGymkhanaInf[reginid].RegionInf.MonsterNum = RegionManager.MonsterNum
				end
				if RegionManager.MonsterNum == 0 then
					--所有玩家请求对应的奖励在指定场景
					AllPlayerAward(CurDailyIndex, reginid, DAILY_AllMONSTERDIE)
					return 
				end
				
			elseif RegionManager.WinCondition.winrule == DAILY_SPECIFYMONSTERDIE then  --指定ID怪物死亡BossMonsterID
				if RegionManager.WinCondition.MonsterID == diemonsterid then
					--所有玩家请求对应的奖励在指定场景
					AllPlayerAward(CurDailyIndex, reginid, DAILY_SPECIFYMONSTERDIE)
					return
				end
			end
			if RegionManager.BatchMonster ~= nil then
				--判断当前怪物是否全部死亡，是就刷新另一批怪物
				GymBatchRefreshMonster(RegionManager,GetMonsterData(2),reginid)
			end
		end
		OnMonsterDie(objectgid)
	end
end

--通知场景中所有玩家怪物已经死亡
function NotifyGymAllMonsterDie(regionid, refreshgroups)
	for k,v in pairs(GymkhanaManager) do
		if v.mapx == regionid then
			SendBatchesMonster(k,refreshgroups,0)   --发送当前怪物死亡
			SendBatchesMonster(k,refreshgroups,1)   --发送当前怪物刷新
		end
	end
end

--通知场景中所有玩家，下一波怪物还有多久刷新
function NotifyGymNextBatchRefresh(regionid, refreshgroups, delaytime)
	for k,v in pairs(GymkhanaManager) do
		if v.mapx == regionid then
			--通知玩家下一波怪物是第几波怪和刷新延迟时间
			SendNextBatchMonsterInf(k, refreshgroups, delaytime, 0)
		end
	end
end

CurGymBatchMonsterNum = {}
function GymBatchRefreshMonster(RegionManager,diemonsterid,mapx ) --刷新怪物
	if RegionManager == nil or type(RegionManager) ~= "table" then
		return 
	end
	local refreshgroups = RegionManager.BatchCurrentGroup
	if RegionManager.BatchMonsternum[refreshgroups] ~= nil  and RegionManager.BatchMonster[refreshgroups] ~= nil then
		if CurGymBatchMonsterNum[refreshgroups] == nil then
			CurGymBatchMonsterNum[refreshgroups] = RegionManager.BatchMonsternum[refreshgroups]
		end
		for k,v in pairs(RegionManager.BatchMonster[refreshgroups]) do
			if v.monsterId == diemonsterid then
				RegionManager.BatchMonsternum[refreshgroups] = RegionManager.BatchMonsternum[refreshgroups] - 1
				break
			end
		end
	end
	
	if RegionManager.BatchMonsternum[refreshgroups] == 0 then
		RegionManager.BatchMonsternum[refreshgroups] = CurGymBatchMonsterNum[refreshgroups]
		if RegionManager.BatchMonster[refreshgroups] ~= nil then
			--通知场景中所有玩家怪物已经死亡
			NotifyGymAllMonsterDie(mapx, refreshgroups)
			local delaytime = RegionManager.RefreshDelayTime[refreshgroups]
			--通知场景中所有玩家，下一波怪物还有多久刷新
			NotifyGymNextBatchRefresh(mapx, refreshgroups, delaytime)
			for k,v in pairs(RegionManager.BatchMonster[refreshgroups]) do
				local createmon = {CreateObjectIndirect,v}
				AddfunctiondelayCall(delaytime, createmon, mapx)
			end
			RegionManager.BatchCurrentGroup = refreshgroups
		end
	end
end

function SendGymkhanaFinish(GymkhanaScManager,reginid,playergid) --日常活动结束相关处理，并通知玩家更新日常活动完成情况列表
	if GymkhanaScManager == nil or type(GymkhanaScManager) ~= "table" then
		return nil
	end
	local CurDailyIndex = GymkhanaScManager.CurDailyIndex
	local playerDaily= LoadPlayerTable(PlayerDailyData,playergid)		--日常活动完成信息
	if playerDaily == nil then
		return nil
	end

--当玩家主动退出或者实际到时退出
	if GymkhanaScManager.IsComplete == 0 then
		if GetCurGymhkanaPlayerNum(reginid) == 1 then
			KillAllMonster(reginid)
		end
		-- GymkhanaScManager.BatchCurrentGroup = GymkhanaScManager.BatchCurrentGroup - 1
	end

	local CurTime = os.time()
	playerDaily[CurDailyIndex].EndTime = CurTime - GymkhanaScManager.refreshstarttime

	--玩家被动退出情况和主动退出情况
	playerDaily[CurDailyIndex].FinishCount = playerDaily[CurDailyIndex].FinishCount + 1	--玩家日常活动完成次数加1
	playerDaily[CurDailyIndex].FinishState = 1	--日常活动状态变为1（领取状态）
	-- playerDaily[CurDailyIndex].CurDailyLevel = GymkhanaScManager.BatchCurrentGroup

	WeekReturnChargeData(PlayerDailyData,playerDaily,playergid)
end

function DestroyGymkhana(playergid, reginid, monsterlist)
	for k,v in pairs(monsterlist) do
		Removeobj(reginid,v)
	end
	DestroyScene(reginid)
	RemoveFromTable(GymkhanaManager,playergid)
end

function OnLeaveGymkhana(playergid) --客户端请求离开场景
	-- for k,v in pairs(GymkhanaManager) do
	-- 	rfalse("<<<<<<< v.Playerlist = " .. v.Playerlist .. "playergid = " .. playergid)
	-- end
	for k,v in pairs(GymkhanaManager) do
		if k == playergid then
			LeaveGymkhana(v,v.mapx,playergid)
			break
		end
	end
end


function LeaveGymkhana(GymkhanaScManager,reginid,playergid)
	--GymkhanaPlayerNum = GymkhanaPlayerNum - 1
	local CurDailyIndex = GymkhanaScManager.CurDailyIndex
	if GetPlayerData(playergid,GPP_ACTION) == EA_DEAD or GetPlayerData(playergid,GPP_CURHP) == 0 then
		local sid = GetPlayerData(playergid,GPP_QUANJUSID)
		local relivetable = {}
		relivetable.regionID = reginid
		relivetable.type = 0
		relivetable.wX = DailySceneTable[CurDailyIndex].bornPostion[1]
		relivetable.wY = DailySceneTable[CurDailyIndex].bornPostion[2]
		PlayerRelive(sid,relivetable)
		if GetCurGymhkanaPlayerNum(reginid) == 1 then
			KillAllMonster(reginid)
		end
	end			
	OnBackFightPet()
	PutPlayerFromDynamic(1,reginid,0,0,0)						--把玩家从场景从移动
	--从一个分组中移除玩家
	RemoveGymkhanaPlayer(reginid)
	if GetCurGymhkanaPlayerNum(reginid) ~= 0 then
		RemoveFromTable(GymkhanaManager,playergid)
		return
	end
	DestroyGymkhana(playergid, reginid, GymkhanaScManager.Monsterlist)
	RemoveFromTable(SceneDelayCallBack,reginid)
end

--判断日常活动是否可以重置，如果可以则重置
function JudgeGymkhanaCanReset(playerDaily)
	if playerDaily == nil then
		return
	end
    local CurrentTime = os.time()
    local CurTime = CurrentTime - DailyResetTime    --标准化到24点重置
    local PreTime = playerDaily.DailyPreResetTime - DailyResetTime    --标准化到24点重置
    if PreTime < 0 then
        PreTime = 0
    end

    local DayTime = 24 * 60 * 60
    if math.floor(CurTime / DayTime) > math.floor(PreTime / DayTime) then --满足重置
        for n, v in pairs(playerDaily) do
        	if type(v) == "table" then
				playerDaily[n].FinishCount = 0 --当前日常ID玩家完成的次数
				playerDaily[n].FinishState	= 0 --1可以领取，0为可以进入
				playerDaily[n].SpendTimes = 0  --玩家付费进入活动的次数
				playerDaily[n].GetAwardNum = 0  	--未知神殿当天获得的奖励数
        	end
        end
        playerDaily.DailyPreResetTime = CurrentTime
    end
end

--请求进入日常活动场景
function OnQuestEnterGymkhanaScene(DailyID)
	local playerDaily = LoadPlayerTable(PlayerDailyData, 0)		--加载日常相关数据
	if playerDaily == nil then
		return
	end
	--
	local DailyIndex = FindDailyIndexByID(DailyID)
	if playerDaily[DailyIndex] == nil then
		return
	end

	local PlayerLevel = GetPlayerData(0, 10)	--获取玩家等级
	if PlayerLevel < DailySceneTable[DailyIndex].LimitContorl.LimitPlayerLevel then		--玩家等级不够
		ResponseEntryDailyArea(0, 5, 0)		--进入操作失败
		return
	end

	if playerDaily[DailyIndex].FinishState == 1 then	--不能执行进入
		ResponseEntryDailyArea(0, 2, 0)	--进入操作失败
		return
	end
	if playerDaily[DailyIndex] == nil then	--当前日常列表中没有该日常活动的ID
		ResponseEntryDailyArea(0, 2, 0)		--进入操作失败
		return
	end

	--当天该日常活动的次数已经使用完
	local HaveNum = DailySceneTable[DailyIndex].LimitContorl.LimitTimes + playerDaily[DailyIndex].SpendTimes
	if playerDaily[DailyIndex].FinishCount == HaveNum then	
		ResponseEntryDailyArea(0, 2, 0)	--进入操作失败
		return
	end
	WeekReturnChargeData(PlayerDailyData,playerDaily, 0)
	PutPlayerToGymkhanaScene(DailyIndex)	--进入日常活动场景
	ResponseEntryDailyArea(0, 1, 0)	--进入成功
end

--所有玩家请求对应的奖励在指定场景
function AllPlayerAward(DailyIndex, regionid, GymType)
	for k,v in pairs(GymkhanaManager) do
		if v.mapx == regionid then
			v.IsComplete = 1						--闯关完成
			v.CompleteWhy = GymType	--
			RequestGymkhanaAward(DailyIndex, k, regionid)
		end
	end
end

--关卡完成后，玩家请求奖励
function RequestGymkhanaAward(DailyIndex, playergid, regionid)
	local PlayerLevel = GetPlayerData(playergid, 10)	--获取玩家等级
	local GymkhanaScManager = GymkhanaManager[playergid]
	SendGymkhanaFinish(GymkhanaScManager,regionid, playergid)
	local AwardTable = {0, 0, 0, 0, 0, 0, 0, 0}	--奖励表  1对应奖励材料道具ID，2对应奖励材料道具数量, 3对应额外奖励材料道具ID，4对应额外奖励材料道具数量,5对应奖励真气，6对应奖励经验，7对应奖励银币，8对应奖励金币）
	local playerDaily = LoadPlayerTable(PlayerDailyData, playergid)		--加载日常相关数据
	if playerDaily == nil then
		SendDailyAwardToPlayer(AwardTable, playergid)
		return
	end

	if DailyAwardList[DailyIndex] == nil or DailySceneTable[DailyIndex] == nil then	--没有日常活动的奖励
		SendDailyAwardToPlayer(AwardTable, playergid)
		playerDaily[DailyIndex].FinishState = 0
		WeekReturnChargeData(PlayerDailyData,playerDaily, playergid)
		return
	end

	--获取奖励信息
	local AwardInfo = deepcopy(DailyAwardList[DailyIndex][1])

	if AwardInfo == nil then
		playerDaily[DailyIndex].FinishState = 0
		WeekReturnChargeData(PlayerDailyData,playerDaily, playergid)
		SendDailyAwardToPlayer(AwardTable, playergid)
		return
	end

	if DailySceneTable[DailyIndex].DailyType == GYMKHANA_SENZHILEYUAN then
	--玩家在活动中的时间，为分钟
		local InDailyTime
		local BossMonsterAward = DailySceneTable[DailyIndex].FixAward
		if GymkhanaScManager.CompleteWhy == DAILY_SPECIFYMONSTERDIE then
			InDailyTime = 60
			AwardInfo[5] = AwardInfo[5] * InDailyTime * PlayerLevel
			AwardInfo[5] = AwardInfo[5] + AwardInfo[5] * BossMonsterAward.TranExpWeight + BossMonsterAward.FixBaseExp
		else
			InDailyTime = math.floor(playerDaily[DailyIndex].EndTime / 60)
			AwardInfo[5] = AwardInfo[5] * InDailyTime * PlayerLevel + BossMonsterAward.FixBaseExp
		end
	end

	local AwardType = AwardInfo[1]
	local AwardNum = 0 		--奖励的数量
	local AwardItemID = 0 	--如果奖励道具时，该值才有用
	if AwardType >= 1 and AwardType <= 5 then
		SetPlayerObject(playergid)  --通过GID设置执行脚本的玩家
		if AwardType == 1 then	--奖励材料
			AwardNum = AwardInfo[3]
			AwardItemID = AwardInfo[2]
		    --奖励
			GiveGoods(AwardItemID, AwardNum)
			AwardTable[1] = AwardItemID
			AwardTable[2] = AwardNum
		elseif AwardType == 2 then	--奖励真气
			AwardNum = AwardInfo[4]
		    --奖励
			GiveSp(AwardNum)
			AwardTable[5] = AwardNum
	  	elseif AwardType == 3 then	--奖励经验
			AwardNum = AwardInfo[5] + LevelExp
		    --奖励
		 	GiveExp(AwardNum)
			AwardTable[6] = AwardNum
	 	elseif AwardType == 4 then	--奖励银币
			AwardNum = AwardInfo[6]
		    --奖励
			ChangeMoney(2, AwardNum)
			AwardTable[7] = AwardNum
		elseif AwardType == 5 then	--奖励金币
			AwardNum = AwardInfo[7]
		    --奖励
			ChangeMoney(1, AwardNum)
			AwardTable[8] = AwardNum
		end
	elseif AwardType == 6 then 	--不区分奖励类型
		SetPlayerObject(playergid)  --通过GID设置执行脚本的玩家
		if AwardInfo[3] ~= 0 then	--奖励道具
			GiveGoods(AwardInfo[2], AwardInfo[3])
			AwardTable[1] = AwardInfo[2]
			AwardTable[2] = AwardInfo[3]
		end
		if AwardInfo[4] ~= 0 then	--奖励真气
			GiveSp(AwardInfo[4])
			AwardTable[5] = AwardInfo[4]
		end
		if AwardInfo[5] ~= 0 then	--奖励经验
			GiveExp(AwardInfo[5])
			AwardTable[6] = AwardInfo[5]
		end
		if AwardInfo[6] ~= 0 then	--奖励银币
			ChangeMoney(2, AwardInfo[6])
			AwardTable[7] = AwardInfo[6]
		end
		if AwardInfo[7] ~= 0 then	--奖励金币
			ChangeMoney(1, AwardInfo[7])
			AwardTable[8] = AwardInfo[7]
		end
	end

	playerDaily[DailyIndex].FinishState = 0
	WeekReturnChargeData(PlayerDailyData,playerDaily, playergid)

	--发送成功消息
	SendDailyAwardToPlayer(AwardTable, playergid)
	
	--活跃度计算
	CompleteAndActiveness(2, playergid)
end
