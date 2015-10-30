PlayerDailyData = tostring("PlayerDailyData")	--保存玩家相关的日常信息

function 
	DailyAreaManagerInit()
	if DailyAreaManager == nil then					--普通通关
		DailyAreaManager = {}
	end
end

DailyAreaManagerInit()

function DailyScMainLoop()	
	for k,v in pairs(DailyAreaManager) do
		if v.survivetime ~= nil and v.starttime ~= nil  then
			local survivetime = v.survivetime * 60		--换成秒
			if os.time() - v.starttime > survivetime and survivetime ~= 0 then
				v.survivetime = 0 	--由于改该函数一直在检测，保证只执行一次
				rfalse("v.CurDailyIndex = " .. tostring(v.CurDailyIndex))
				RequestDailyAward(v.CurDailyIndex, v.Playerlist, k)
				--OnRecvSQLeaveDailyScene(v.Playerlist)
				break
			end
		end	
		--OnCheckTimeToRefresh(v)
		if v.IsComplete ~= 1 then
			delayCall_new(k)
		end
	end

	--竞技场处理逻辑
	GymkhanaMainLoop()	
end

--保存玩家日常完成的情况
function InitPlayerDailyData(PlayerDaily, playergid)
	if PlayerDaily == nil then
		PlayerDaily = { DailyPreResetTime = 0}	--DailyPreResetTime玩家上一次时间重置;
	end	
	--下面的数据没有时间运用，主要防止WeekReturnChargeData函数不能保存空表
	for i, v in pairs(DailySceneTable) do
		PlayerDaily[i] = {}
		PlayerDaily[i].DailyID = DailySceneTable[i].DailyID	--当前日常ID
		PlayerDaily[i].FinishCount = 0 --当前日常ID玩家完成的次数
		PlayerDaily[i].FinishState	= 0 --1可以领取，0为可以进入
		PlayerDaily[i].CurDailyLevel = 1  --当前需要完成的日常活动层数
		PlayerDaily[i].SpendTimes = 0  --玩家付费进入活动的次数
		PlayerDaily[i].EndTime = 0 		--在活动副本中的时间长度
		PlayerDaily[i].KillMonsterNum = 0  	--活动副本中杀怪数量
		--如果活动为未知神殿
		--if DailySceneTable[i].DailyType == DAILY_UNKNOWNDARKHOUSE then
		PlayerDaily[i].GetAwardNum = 0  	--未知神殿当天获得的奖励数
		--end
	end
	WeekReturnChargeData(PlayerDailyData,PlayerDaily, playergid)
end

function InitDailyScene()
	if DailySceneTable ~= nil then
		for o,p in pairs(DailySceneTable) do
			if p.Monster ~= nil then
				for i, mCreate in pairs(p.Monster) do
					mCreate.x = mCreate.x * Postionamend 		--怪物出生坐标修正
					mCreate.y = mCreate.y * Postionamend
					--rfalse("Monster x = "..mCreate.x.." y = "..mCreate.y.."")
				end
			elseif p.BatchMonster ~= nil then
				for i,j in pairs(p.BatchMonster) do
					if type(j) == "table" then
						for m,n in pairs(j.monsterlist) do
							n.x = n.x * Postionamend 			--怪物出生坐标修正
							n.y = n.y * Postionamend
							--rfalse("Monster x = "..n.x.." y = "..n.y.."")
						end
					end
				end
			end
			if p.bornPostion ~= nil then
				p.bornPostion[1] = p.bornPostion[1] * Postionamend     --复活以及死亡复活坐标修正
				p.bornPostion[2] = p.bornPostion[2] * Postionamend
			end
		end
	end
end

InitDailyScene()

--随机获得怪物ID
function RandomGetMonsterID(MonsterRange)
    if MonsterRange == nil then
        return
    end
    local WeightAll = 0
    --计算权重总值
    for n, v in ipairs(MonsterRange) do
        WeightAll = WeightAll + v[2]
    end
    local RandomValue = math.random(WeightAll)

    --判断产出的怪物
    local EachMonsterIDWeight = 0   --每个怪物所占权重比
    for n, v in ipairs(MonsterRange) do
        --抽取到当前索引的宠物ID
        if RandomValue > EachMonsterIDWeight and RandomValue <= EachMonsterIDWeight + v[2] then
            return v[1]
        end
        EachMonsterIDWeight = EachMonsterIDWeight + v[2]
    end
end

--判断活动是否为未知神殿，如果是，则随机刷出一个怪物
function IsUnknownDarkHouseRefreshMonster(DailyType, DailyIndex)
	if DailyType == DAILY_UNKNOWNDARKHOUSE then
		local playerDaily = LoadPlayerTable(PlayerDailyData, playergid)		--加载日常相关数据
		if playerDaily == nil or playerDaily[DailyIndex].GetAwardNum == nil or playerDaily[DailyIndex].FinishCount == nil then
			return
		end
		if playerDaily[DailyIndex].GetAwardNum >= UDHGetItemNum then 	--不能刷出某一指定怪物
			return RandomGetMonsterID(UDHDebarCertainMonsterCfg[DailyIndex])
		elseif math.mod(playerDaily[DailyIndex].FinishCount, UDHMustEnterTimes) == 0 then	--必然刷出某一指定怪物
			return MustRefreshMonsterID[DailyIndex]
		else
			return RandomGetMonsterID(UnKnownDarkHouseMonsterCfg[DailyIndex])
		end

	end
end

--判断活动是否为财富山，如果是，但玩家杀死一个怪物后，随机刷另一个怪物
function FortuneMonsterDieRefresh(DailyType, DailyIndex)
	if DailyType == DAILY_FORTUNEHILL then
		return RandomGetMonsterID(FortuneHillMonsterRandomCfg[DailyIndex])
	end
end

--把玩家放入日常活动场景中
function PutPlayerToDailyScene(DailyIndex)
	local scmap = DailySceneTable[DailyIndex]	--日常活动地图数据
	if scmap ~= nil then
		local dailyscenebase = {}
		dailyscenebase.Monster = {}


		local regionID = scmap.regionID
		local mapid = scmap.MapID
		local RegionGID = CreateScene(regionID, mapid, 2, 0, 0, 0)	--创建日常活动场景
		if (nil == RegionGID) then
			return
		end

		-- 创建怪物
		dailyscenebase.Monsterlist = {}
		if scmap.Monster ~= nil then
			for k, mCreate in pairs(scmap.Monster) do
				mCreate.regionId = RegionGID
				local monstergid = CreateObjectIndirect(mCreate)
				--table.insert(dailyscenebase.Monsterlist,monstergid)
			end
			dailyscenebase.Monster = scmap.Monster
			dailyscenebase.MonsterNum = GetTableLenth(scmap.Monster)
		elseif scmap.BatchMonster ~= nil then
			--dailyscenebase.BatchMonster = scmap.BatchMonster
			dailyscenebase.CurDailyIndex = DailyIndex	--当前日常索引
			dailyscenebase.BatchMonster = {}
			dailyscenebase.BatchMonsternum = {}
			dailyscenebase.BatchMonsterBossID = {}	--用于精英关卡
			dailyscenebase.BatchCurrentGroup = 1    --默认为第一波
			dailyscenebase.RefreshType = scmap.BatchMonster.refreshtype    --类型
			dailyscenebase.wKillCount = 0	--玩家杀怪数量
			dailyscenebase.WinCondition = scmap.WinCondition	--胜利条件
			dailyscenebase.wcurrenthit = 0						--当前连击数
			dailyscenebase.wmaxhit = 0							--最大连击
			dailyscenebase.dlasthittime = 0 						--上一次产生伤害的时间
			dailyscenebase.MonsterDropGlodNum = 0	--活动中怪物掉落的银币数量，最后结算
			dailyscenebase.UDHMonsterID = 0	--未知神殿随机刷出的怪物ID
			dailyscenebase.RefreshDelayTime = {} --延时
			dailyscenebase.refreshstarttime = os.time()   --进入开始时间
			dailyscenebase.survivetime = scmap.LimitContorl.OpenTime	--日常活动时间限制, 时间到后自动结束日常活动
			dailyscenebase.SpecMonsterDieTimes = 0 		--指定怪物死亡次数，用于财富山活动

			--把玩家放到目标场景
			if scmap.bornPostion ~= nil then

				local x = scmap.bornPostion[1]
				local y = scmap.bornPostion[2]
				PutPlayerTo(0, x, y, RegionGID,0)
				rfalse("PutPlayerTo x = "..x.." y = "..y.."")
				dailyscenebase.Playerlist = GetPlayerGID(0)
				dailyscenebase.starttime = os.time()


	            --进入时玩家的血量增满
				local m_PlayerMaxHp = GetPlayerData(dailyscenebase.Playerlist, 4)	--获取玩家最多血量
				SetObjectData(dailyscenebase.Playerlist, 18, m_PlayerMaxHp)	--设置玩家满血
			end

			local MonsterNum = 0
			local NpcNum = 0
			for k,v in pairs(scmap.BatchMonster) do
				if type(v) == "table" then

					if k >= dailyscenebase.BatchCurrentGroup then
						dailyscenebase.RefreshDelayTime[k] = v.refreshdelaytime
					end
					--刷新当前波怪物
					if k == dailyscenebase.BatchCurrentGroup then  --通知玩家下一波怪物是第几波怪和刷新延迟时间
					SendNextBatchMonsterInf(0, k, dailyscenebase.RefreshDelayTime[k], scmap.DailyID)
					end
					for i,j in pairs(v.monsterlist) do
						j.regionId = RegionGID
						if k == dailyscenebase.BatchCurrentGroup then  --刷新当前批怪物
							local RefreshMonster = deepcopy(j)

							--判断未知神殿处理逻辑
							local MonsterID = IsUnknownDarkHouseRefreshMonster(scmap.DailyType, DailyIndex)
							if MonsterID ~= nil then
								RefreshMonster.monsterId = MonsterID
								dailyscenebase.UDHMonsterID = MonsterID
							end

							--local monstergid = CreateObjectIndirect(j)
							local createmon = {CreateObjectIndirect,RefreshMonster}
							local delaytime = dailyscenebase.RefreshDelayTime[k]
							rfalse("RegionGID  ==   " ..  RegionGID)
							AddfunctiondelayCall(delaytime, createmon, RegionGID)
						end
						if j.objectType == 1 then
							NpcNum = NpcNum + 1
						end
					end
					if k >= dailyscenebase.BatchCurrentGroup then
						dailyscenebase.BatchMonster[k] = v.monsterlist
						MonsterNum = MonsterNum + GetTableLenth(v.monsterlist) - NpcNum         --所有怪物数量
						dailyscenebase.BatchMonsternum[k] = GetTableLenth(v.monsterlist) - NpcNum   --每一波怪物数量
						dailyscenebase.RefreshDelayTime[k] = v.refreshdelaytime
						dailyscenebase.BatchMonsterBossID[k] = v.BossMonsterID 	--每一波怪物的BOSS怪物ID
						NpcNum = 0
					end
				end
			end
			dailyscenebase.MonsterNum = MonsterNum
			if scmap.DailyType == DAILY_SHILEYUAN or scmap.DailyType == DAILY_FORTUNEHILL then 	--如果为失乐园活动，则不限制刷怪次数
				dailyscenebase.MonsterNum = 9999999
			end
		end

		if scmap.LimitContorl ~= nil then
			--dailyscenebase.LimitTimes = scmap.LimitContorl.LimitTimes   --次数限制
			dailyscenebase.OpenTime = scmap.LimitContorl.OpenTime	--开放条件
			dailyscenebase.mapx = RegionGID
			if DailyAreaManager[RegionGID] == nil then
				DailyAreaManager[RegionGID] = {}
				DailyAreaManager[RegionGID] = deepcopy(dailyscenebase)
				DailyAreaManager[RegionGID].IsComplete = 0				--日常活动场景是否结束，1表示结束，不一定日常活动完成
				DailyAreaManager[RegionGID].CompleteWhy = -1				--当IsComplete = 1时，应根据该字段判断活动是否已经完成（取值为：
																										--DAILY_AllMONSTERDIE = 0		--日常活动中所有怪物都死亡
																										--DAILY_PLAYERDIE = 1	--玩家死亡，判断杀怪层数
																										--DAILY_SPECIFYMONSTERDIE = 2  --指定ID的怪物死亡）
				DailyAreaManager[RegionGID].diemonsternum = 0          --已经死亡的怪物计数
				SendEnterSceneMsg(0)							--发送进入成功消息
			end
		end
	end
end

--判断怪物是否为BOSS怪物
function JudgeMonsterIsBoss(MonsterID)
	for n, v in pairs(DailySceneBossMonsterID) do
		if v == MonsterID then
			return 1
		end
	end
end

--判断指定怪物是否为指定的一个怪物
function JudgeMonsterIsSpecMonster(MonsterID, SpecMonsterID)
	if MonsterID == SpecMonsterID then
		return true
	else
		return false
	end
end

--日常活动场景中对象死亡处理
function OnDailyObjectDead(objectgid,reginid,mapID,killgid, killedgid)	--后面两个参数依次为：主动杀的对象；被杀的对象
	if DailyAreaManager[reginid] == nil then
		--竞技场活动处理逻辑
		OnGymkhanaObjectDead(objectgid,reginid,mapID,killgid, killedgid)
		return
	end
	local DailyScManager = DailyAreaManager[reginid]
	local CurDailyIndex = DailyScManager.CurDailyIndex
	if GetObjectType(objectgid) == OBJECT_PLAYER then
		disposeplayerdead(objectgid,reginid,mapID)  							--处理玩家死亡
		OnMonsterKillPlayer(objectgid,reginid,mapID,killgid)
		DailyScManager.IsComplete = 1						--闯关完成
		DailyScManager.CompleteWhy = DAILY_PLAYERDIE	--玩家死亡日常活动结束
		DailyScManager.BatchCurrentGroup = DailyScManager.BatchCurrentGroup - 1
		if DailySceneTable[CurDailyIndex].DailyType == XINYANG_FIGHTTYPE then
			ResponseEntryDailyArea(objectgid, 7, 0)	--通知玩家挑战主神失败
		else
			RequestDailyAward(DailyScManager.CurDailyIndex, objectgid, reginid)		--结束奖励，并通知玩家
		end
	elseif GetObjectType(objectgid) == OBJECT_MONSTER then		--处理怪物死亡

		if GetObjectType(killgid) == OBJECT_PET then  --杀死怪物为侠客
			killgid = GetPetOwer(killgid)
		end
		DailyScManager.wKillCount = DailyScManager.wKillCount + 1
		if DailyScManager.WinCondition ~= nil then
			local diemonsterid = GetMonsterData(2)
			local IsBoss = JudgeMonsterIsBoss(diemonsterid)
			if DailySceneTable[CurDailyIndex].DailyType == DAILY_FORTUNEHILL then
				if JudgeMonsterIsSpecMonster(diemonsterid, FortuneHillCanGetGlodMonsterID[DailyScManager.CurDailyIndex]) == true then  --财富山，如果死的是指定的怪物
					DailyScManager.SpecMonsterDieTimes = DailyScManager.SpecMonsterDieTimes + 1
					if DailyScManager.SpecMonsterDieTimes == FortuneSpecMonsterDieTimesQuit then
						DailyScManager.IsComplete = 1						--闯关完成
						RequestDailyAward(DailyScManager.CurDailyIndex, killgid, reginid)		--结束奖励，并通知玩家
						return
					end
				end
			end
			local ProductItemID = nil
			local ProductItemNum = nil
			if IsBoss == 1 then 	--产出道具
				ProductItemID, ProductItemNum = RandGetItem(BossMonsterProductAward[DailySceneTable[CurDailyIndex].DailyID])
			else
				ProductItemID, ProductItemNum = RandGetItem(GeneralMonsterProductAward[DailySceneTable[CurDailyIndex].DailyID])
			end

    		SetPlayerObject(killgid)  --通过GID设置执行脚本的玩家
			if ProductItemID ~= nil then
				local Ret = GiveGoods(ProductItemID, ProductItemNum)
				if Ret == 1 then  	--获得了怪物掉落的道具
        		else 	--不能获得怪物掉落的数据
        		end
			end

			--if DailyScManager.WinCondition.winrule == DAILY_AllMONSTERDIE then  --所有怪物死亡
				if DailyScManager.MonsterNum > 0 then
					DailyScManager.MonsterNum = DailyScManager.MonsterNum - 1
					DailyAreaManager[reginid].MonsterNum = DailyScManager.MonsterNum
				end
				if DailyScManager.MonsterNum == 0 and DailyScManager.CompleteWhy ~= DAILY_PLAYERDIE then
					DailyScManager.IsComplete = 1						--闯关完成
					DailyScManager.CompleteWhy = DAILY_AllMONSTERDIE	--所有怪物死亡结束
					if DailySceneTable[CurDailyIndex].DailyType == XINYANG_FIGHTTYPE then --挑战信仰主神成功，激活相应的技能
						ActiveSkill(XinYangAciiveSkillList[CurDailyIndex - XingYangSceneStartIndex], killgid)
						ResponseEntryDailyArea(killgid, 6, 0)	--通知玩家挑战主神成功
					else
						RequestDailyAward(DailyScManager.CurDailyIndex, killgid, reginid)		--结束奖励，并通知玩家
					end
					return 
				end
				
			--elseif DailyScManager.WinCondition.winrule == DAILY_SPECIFYMONSTERDIE then  --指定ID怪物死亡BossMonsterID
				if DailyScManager.BatchMonsterBossID[DailyScManager.BatchCurrentGroup] ~= nil and
					DailyScManager.BatchMonsterBossID[DailyScManager.BatchCurrentGroup]== diemonsterid and DailyScManager.CompleteWhy ~= DAILY_PLAYERDIE then
					DailyScManager.IsComplete = 1
					DailyScManager.CompleteWhy = DAILY_SPECIFYMONSTERDIE	--指定ID怪物死亡结束
					if DailySceneTable[CurDailyIndex].DailyType == XINYANG_FIGHTTYPE then --挑战信仰主神成功，激活相应的技能
						ActiveSkill(XinYangAciiveSkillList[CurDailyIndex - XingYangSceneStartIndex], killgid)
						ResponseEntryDailyArea(killgid, 6, 0)	--通知玩家挑战主神成功
					else
						RequestDailyAward(DailyScManager.CurDailyIndex, killgid, reginid)		--结束奖励，并通知玩家
					end
					return 
				end
			--end
			if DailyAreaManager[reginid].BatchMonster ~= nil then
				if DailySceneTable[CurDailyIndex].DailyType == DAILY_FORTUNEHILL then 	--死一个怪物就刷新一次怪物
					local MonsterID = FortuneMonsterDieRefresh(DAILY_FORTUNEHILL, CurDailyIndex)
					local MonsterXY = GetMonsterData(23)
					if MonsterID ~= nil and type(MonsterXY) == "table" then
						local MonsterList = {
							{monsterId = MonsterID, x = MonsterXY[1], y = MonsterXY[2], refreshTime = 36000000, objectType = 0},
						}
						if DailyScManager.BatchMonster[2] ~= nil then
							DailyScManager.BatchMonster[2][1].monsterId = MonsterID
							DailyScManager.BatchMonster[2][1].x = MonsterXY[1]
							DailyScManager.BatchMonster[2][1].y = MonsterXY[2]
							local CurBatchMonster = deepcopy(DailyScManager.BatchMonster[2])
							DailyScManager.BatchCurrentGroup = DailyScManager.BatchCurrentGroup + 1
							SendBatchesMonster(DailyScManager.Playerlist, DailyScManager.BatchCurrentGroup, 1)   --发送当前怪物刷新
							local delaytime = DailyScManager.RefreshDelayTime[2]
							--通知玩家下一波怪物是第几波怪和刷新延迟时间
							SendNextBatchMonsterInf(DailyScManager.Playerlist, 2, delaytime, DailyScManager.CurDailyIndex)
							for k,v in pairs(CurBatchMonster) do
								local createmon = {CreateObjectIndirect,v}
								AddfunctiondelayCall(delaytime,createmon,DailyScManager.mapx)
							end
						end
					end
				else  	--判断当前怪物是否全部死亡，是就刷新另一批怪物
					DailyBatchRefreshMonster(DailyAreaManager[reginid],GetMonsterData(2),reginid)
				end
			end
		end
		OnMonsterDie(objectgid)
	end
end

CurBatchMonsterNum = {}

function DailyBatchRefreshMonster(DailyScManager,diemonsterid,mapx ) --刷新怪物
	if DailyScManager == nil or type(DailyScManager) ~= "table" then
		return 
	end
	local CurDailyIndex = DailyScManager.CurDailyIndex
	local refreshgroups = DailyScManager.BatchCurrentGroup
	if DailyScManager.BatchMonsternum[refreshgroups] ~= nil  and DailyScManager.BatchMonster[refreshgroups] ~= nil then
		if CurBatchMonsterNum[refreshgroups] == nil then
			CurBatchMonsterNum[refreshgroups] = DailyScManager.BatchMonsternum[refreshgroups]
		end
		for k,v in pairs(DailyScManager.BatchMonster[refreshgroups]) do
			if v.monsterId == diemonsterid then
				DailyScManager.BatchMonsternum[refreshgroups] = DailyScManager.BatchMonsternum[refreshgroups] - 1
				break
			end
		end
	end
	
	if DailyScManager.BatchMonsternum[refreshgroups] == 0 then
		-- --当前波怪物全部死亡，玩家的血量和蓝增满
		-- local m_PlayerMaxHp = GetPlayerData(DailyScManager.Playerlist, 4)	--获取玩家最多血量
		-- local m_PlayerMaxMp = GetPlayerData(DailyScManager.Playerlist, 16)	--获取玩家最大蓝
		-- SetObjectData(DailyScManager.Playerlist, 18, m_PlayerMaxHp)	--设置玩家血量满
		-- SetObjectData(DailyScManager.Playerlist, 19, m_PlayerMaxMp)	--设置玩家蓝满
		
		SendBatchesMonster(DailyScManager.Playerlist,refreshgroups,0)   --发送当前怪物死亡
		if DailySceneTable[CurDailyIndex].DailyType ~= DAILY_SHILEYUAN then 	--失乐园只刷新第一波的怪物
			refreshgroups = refreshgroups + 1
		else
			DailyScManager.BatchMonsternum[refreshgroups] = CurBatchMonsterNum[refreshgroups] 
		end
		if DailyScManager.BatchMonster[refreshgroups] ~= nil then
			SendBatchesMonster(DailyScManager.Playerlist,refreshgroups,1)   --发送当前怪物刷新
			local delaytime = DailyScManager.RefreshDelayTime[refreshgroups]
			--通知玩家下一波怪物是第几波怪和刷新延迟时间
			SendNextBatchMonsterInf(DailyScManager.Playerlist, refreshgroups, delaytime, DailyScManager.CurDailyIndex)
			for k,v in pairs(DailyScManager.BatchMonster[refreshgroups]) do
				local createmon = {CreateObjectIndirect,v}
				AddfunctiondelayCall(delaytime,createmon,DailyScManager.mapx)
			end
			DailyScManager.BatchCurrentGroup = refreshgroups
		end
	end
end

function SendDailyScFinish(DailyScManager,reginid,playergid) --日常活动结束相关处理，并通知玩家更新日常活动完成情况列表
	if DailyScManager == nil or type(DailyScManager) ~= "table" then
		return nil
	end

	local CurDailyIndex = DailyScManager.CurDailyIndex
	local playerDaily= LoadPlayerTable(PlayerDailyData,playergid)		--日常活动完成信息
	if playerDaily == nil then
		return nil
	end

--当玩家主动退出或者实际到时退出
	if DailyScManager.IsComplete == 0 then
		KillAllMonster(reginid)
		DailyScManager.BatchCurrentGroup = DailyScManager.BatchCurrentGroup - 1
	end

	local CurTime = os.time()
	playerDaily[CurDailyIndex].EndTime = CurTime - DailyScManager.refreshstarttime
	--玩家被动退出情况和主动退出情况
	if DailySceneTable[CurDailyIndex].DailyType ~= XINYANG_FIGHTTYPE then	--屏蔽掉信仰主神挑战
		playerDaily[CurDailyIndex].FinishCount = playerDaily[CurDailyIndex].FinishCount + 1	--玩家日常活动完成次数加1
		playerDaily[CurDailyIndex].FinishState = 1	--日常活动状态变为1（领取状态）
		playerDaily[CurDailyIndex].CurDailyLevel = DailyScManager.BatchCurrentGroup
	end
	WeekReturnChargeData(PlayerDailyData,playerDaily,playergid)
end

function DestroyDailyAreas(scenegid,monsterlist)
	for k,v in pairs(monsterlist) do
		Removeobj(scenegid,v)
	end
	DestroyScene(scenegid)
	RemoveFromTable(DailyAreaManager,scenegid)
end

function OnRecvSQLeaveDailyScene(playergid, IsActiveBreak) --客户端请求离开场景
	for k,v in pairs(DailyAreaManager) do
		--rfalse("v.Playerlist = " .. v.Playerlist .. "playergid = " .. playergid)
		if v.Playerlist == playergid then
			LeaveDailyScene(v,k,playergid, IsActiveBreak)
			break
		end
	end

	--竞技场处理逻辑
	OnLeaveGymkhana(playergid)
end

function LeaveDailyScene(DailyScManager,reginid,playergid, IsActiveBreak)
	 -- if DailyScManager ~= nil and IsActiveBreak == 1 then
	 -- 	SendDailyScFinish(DailyScManager,reginid,playergid)
	 -- 	RequestDailyAward(DailyScManager.CurDailyIndex)
	 -- end

	if GetPlayerData(playergid,GPP_ACTION) == EA_DEAD or GetPlayerData(playergid,GPP_CURHP) == 0 then
		local sid = GetPlayerData(playergid,GPP_QUANJUSID)
		local CurDailyIndex = DailyScManager.CurDailyIndex
		local relivetable = {}
		relivetable.regionID = reginid
		relivetable.type = 0
		relivetable.wX = DailySceneTable[CurDailyIndex].bornPostion[1]
		relivetable.wY = DailySceneTable[CurDailyIndex].bornPostion[2]
		PlayerRelive(sid,relivetable)
		KillAllMonster(reginid)
	end			
	OnBackFightPet()
	PutPlayerFromDynamic(1,reginid,0,0,0)						--把玩家从场景从移动
	DestroyDailyAreas(reginid,DailyScManager.Monsterlist)
	RemoveFromTable(SceneDelayCallBack,reginid)
end

function GetPlayerDailyManager( playergid )--获取日常活动相关数据
	for k,v in pairs(DailyAreaManager) do
		if v.Playerlist == playergid then
			return v,k
		end
	end
end

--判断日常活动是否可以重置，如果可以则重置
function JudgeDailyCanReset(playerDaily)
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

--返回日常活动详细信息
function DailyListInf(playerDaily)
end

--玩家请求日常活动列表信息
function OnInitDailyListInf(playergid)
	local playerDaily = LoadPlayerTable(PlayerDailyData, playergid)		--加载日常相关数据
	if playerDaily == nil then
		InitPlayerDailyData(playerDaily, playergid)
		playerDaily = LoadPlayerTable(PlayerDailyData, playergid)		----加载日常相关数据
		--return
	end

	JudgeDailyCanReset(playerDaily)		--判断是否满足重置时间重置日常活动已经完成的信息
	WeekReturnChargeData(PlayerDailyData,playerDaily, playergid)

	local TempDailySceneTable = {}
	local PlayerVipLevel = GetPlayerData(0, 101)	--获取玩家VIP等级
	for i = 1, DailyCount do
		TempDailySceneTable[i] = {}
		TempDailySceneTable[i].DailyID = DailySceneTable[i].DailyID
		TempDailySceneTable[i].LimitTimes = DailySceneTable[i].LimitContorl.LimitTimes 

		TempDailySceneTable[i].FinishCount = playerDaily[i].FinishCount
		TempDailySceneTable[i].FinishState = playerDaily[i].FinishState
		TempDailySceneTable[i].SpendTimes = playerDaily[i].SpendTimes
		if PlayerVipLevel > 0 then
			if DailySceneTable[i].DailyType == DAILY_SANGSHITYPE then
				TempDailySceneTable[i].LimitTimes = TempDailySceneTable[i].LimitTimes + VIPDailyRoutineCfg[PlayerVipLevel][1]
			elseif DailySceneTable[i].DailyType == DAILY_JINGYINGTYPE then
				rfalse(tostring(PlayerLevel))
				TempDailySceneTable[i].LimitTimes = TempDailySceneTable[i].LimitTimes + VIPDailyRoutineCfg[PlayerVipLevel][2]
			end
		end
	end
	-- local TempPlayerDaily = {}
	-- for i = 1, DailyCount do
	-- 	TempPlayerDaily[i] = {}
	-- 	TempPlayerDaily[i].DailyID = playerDaily[i].DailyID
	-- 	TempPlayerDaily[i].FinishCount = playerDaily[i].FinishCount
	-- 	TempPlayerDaily[i].FinishState = playerDaily[i].FinishState
	-- 	TempPlayerDaily[i].SpendTimes = playerDaily[i].SpendTimes
	-- end
	ReturnDailyListInfo(playergid, TempDailySceneTable)	--参数依次为：玩家GID，日常重置时间；已经完成的日常数据；日常列表信息
end

--通过已经完成的日常活动的ID查找对应的索引位置
function FindDailyIndexByID(DailyID)
	local DailyIndex = -1	--当前ID在完成的日常活动列表中的索引
	for n, v in pairs(DailySceneTable) do
		if type(v) == "table" then
			if v.DailyID == DailyID then
				DailyIndex = n
				break
			end
		end
	end
	return DailyIndex
end

--付费进入日常活动的结算
function SpendEntryDailyCal(DailyID)
	local playerDaily = LoadPlayerTable(PlayerDailyData, 0)		--加载日常相关数据
	if playerDaily == nil then
		return
	end

	local DailyIndex = FindDailyIndexByID(DailyID)
	--计算付费进入需要的消耗的金币数量
	local ConsumeGlod = DailySceneTable[DailyIndex].BaseSpendGlod + 10 * (playerDaily[DailyIndex].SpendTimes + 1)
	local bMoneyEnough = CheckPlayerMoney(1, ConsumeGlod, 1)
	if bMoneyEnough == 0 or bMoneyEnough == nil then	--核对金币是否足够
		ResponseEntryDailyArea(0, 3, 0)		--金币不足
		return 0
	else	--可以购买
		ChangeMoney(1, -ConsumeGlod);  --购买
		playerDaily[DailyIndex].SpendTimes = playerDaily[DailyIndex].SpendTimes + 1
	end
	WeekReturnChargeData(PlayerDailyData,playerDaily, 0)
	return 1
end

--消耗道具进入活动
function ResumeItemEnterDaily(ItemID, ItemNum)
	local ItemIsEnough = CheckGoods(ItemID, ItemNum, 1, 0)
	if ItemIsEnough == false or ItemIsEnough == 0 then
    	local str = MystringFormat("ITEMNOTENOUGH")
    	if str ~= nil then
        	TalkToPlayer(2,str)
    	end
    	return 0
	end

	--消耗道具
	DeleteItem(ItemID, ItemNum)
	return 1
end

--请求进入日常活动场景
function OnQuestInterDailyScene(DailyID, EnterType)

    --判断背包剩余空间是否足够
    if GetBlankCell() < 1 then
        local str = MystringFormat("BAGISFULL")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
        return
    end

	if EnterType == 1 then 	--付费进入
		local Res = SpendEntryDailyCal(DailyID)
		if Res == 0 then
			return 
		end
	end

	if EnterType == 2 then
		DailyID = DailyID + XingYangSceneStartIndex
	end

	--
	local DailyIndex = FindDailyIndexByID(DailyID)
	--竞技场活动处理逻辑
	if DailySceneTable[DailyIndex].DailyType == GYMKHANA_SENZHILEYUAN then 
		OnQuestEnterGymkhanaScene(DailyID)
		return
	end
	
	local playerDaily = LoadPlayerTable(PlayerDailyData, 0)		--加载日常相关数据
	if playerDaily == nil then
		return
	end

	if DailySceneTable[DailyIndex].DailyType == DAILY_UNKNOWNDARKHOUSE then  	--如果活动为未知神殿，消耗道具进入活动
		local bRet = ResumeItemEnterDaily(EnterUnknownDarkHouseNeedItem[1], EnterUnknownDarkHouseNeedItem[2])
		if bRet == 0 then
			return
		end
	end


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
	local PlayerVipLevel = GetPlayerData(0, 101)	--获取玩家VIP等级
	local HaveNum = DailySceneTable[DailyIndex].LimitContorl.LimitTimes + playerDaily[DailyIndex].SpendTimes
	if PlayerVipLevel > 0 then
		if DailySceneTable[DailyIndex].DailyType == DAILY_SANGSHITYPE then
			HaveNum = DailySceneTable[DailyIndex].LimitContorl.LimitTimes + VIPDailyRoutineCfg[PlayerVipLevel][1] + playerDaily[DailyIndex].SpendTimes
		elseif DailySceneTable[DailyIndex].DailyType == DAILY_JINGYINGTYPE then
			HaveNum = DailySceneTable[DailyIndex].LimitContorl.LimitTimes + VIPDailyRoutineCfg[PlayerVipLevel][2] + playerDaily[DailyIndex].SpendTimes
		end
	end
	if playerDaily[DailyIndex].FinishCount == HaveNum and DailySceneTable[DailyIndex].DailyType ~= DAILY_UNKNOWNDARKHOUSE then	
		if DailySceneTable[DailyIndex].DailyType == DAILY_SHILEYUAN or DailySceneTable[DailyIndex].DailyType == DAILY_SHENQUANSHAN then
			ResponseEntryDailyArea(0, 2, 0)	--进入操作失败
			return
		end

		--荣誉殿堂免费次数用完，判断是否有进入该活动的道具
		if DailySceneTable[DailyIndex].DailyType == DAILY_HONORHALL then
			local bRet = ResumeItemEnterDaily(HonorHallEnterResumeItem[1], HonorHallEnterResumeItem[2])
			if bRet == 0 then
				return
			end
			playerDaily[DailyIndex].SpendTimes = playerDaily[DailyIndex].SpendTimes + 1
		else

			--返回付费进入需要的消耗的金币数量
			local ConsumeGlod = DailySceneTable[DailyIndex].BaseSpendGlod + 10 * (playerDaily[DailyIndex].SpendTimes + 1)
			--发送需要消耗金币数量的消息
			ResponseEntryDailyArea(0, 0, ConsumeGlod)	--当天活动次数使用完。进入失败，返回下次付费进入需要的金币数
			return
		end
	end
	WeekReturnChargeData(PlayerDailyData,playerDaily, 0)
	PutPlayerToDailyScene(DailyIndex)	--进入日常活动场景
	ResponseEntryDailyArea(0, 1, 0)	--进入成功
end

--随机产出一个道具
function RandGetItem(ItemRange)
	if ItemRange == nil then
		return
	end
    local WeightAll = 0
    --计算权重总值
    for n, v in ipairs(ItemRange) do
        WeightAll = WeightAll + v[3]
    end
    local RandomValue = math.random(WeightAll)

    --判断产出的道具
    local EachItemIDWeight = 0   --每个道具所占权重比
    for n, v in ipairs(ItemRange) do
        --抽取到当前索引的宠物ID
        if RandomValue > EachItemIDWeight and RandomValue <= EachItemIDWeight + v[3] then
            return v[1], v[2]     --抽取到的道具
        end
        EachItemIDWeight = EachItemIDWeight + v[3]
    end
end

--关卡完成后，玩家请求奖励
function RequestDailyAward(DailyIndex, playergid, regionid)
	local DailyScManager = DailyAreaManager[regionid]
	
	--竞技场活动处理逻辑
	if DailyScManager == nil then
		RequestGymkhanaAward(DailyIndex, playergid, regionid)
		return
	end
	SendDailyScFinish(DailyScManager,regionid, playergid)

	local AwardTable = {0, 0, 0, 0, 0, 0, 0, 0}	--奖励表  1对应奖励材料道具ID，2对应奖励材料道具数量, 3对应额外奖励材料道具ID，4对应额外奖励材料道具数量,5对应奖励真气，6对应奖励经验，7对应奖励银币，8对应奖励金币）
	local playerDaily = LoadPlayerTable(PlayerDailyData, playergid)		--加载日常相关数据
	if playerDaily == nil then
		SendDailyAwardToPlayer(AwardTable, playergid)
		DailyScManager.IsComplete = 1
		return
	end

	if DailyAwardList[DailyIndex] == nil or DailySceneTable[DailyIndex] == nil then	--没有日常活动的奖励
		SendDailyAwardToPlayer(AwardTable, playergid)
		playerDaily[DailyIndex].FinishState = 0
		WeekReturnChargeData(PlayerDailyData,playerDaily, playergid)
		DailyScManager.IsComplete = 1
		return
	end

	--世界之树、荣耀殿堂玩家死亡，不给于奖励
	if (DailySceneTable[DailyIndex].DailyType == DAILY_WORLDTREE or DailySceneTable[DailyIndex].DailyType == DAILY_HONORHALL
		or DailySceneTable[DailyIndex].DailyType == DAILY_ACTIVITE5) 
		and (DailyScManager.CompleteWhy == DAILY_PLAYERDIE or DailyScManager.IsComplete == 0) then
		playerDaily[DailyIndex].FinishState = 0
		WeekReturnChargeData(PlayerDailyData,playerDaily, playergid)
		SendDailyAwardToPlayer(AwardTable, playergid)
		DailyScManager.IsComplete = 1
		return
	end
	DailyScManager.IsComplete = 1

	--获取玩家已经完成的日常活动杀怪层数
	local CompleteDailyLevel = playerDaily[DailyIndex].CurDailyLevel + 1
	if CompleteDailyLevel <= 0 then
		playerDaily[DailyIndex].FinishState = 0
		WeekReturnChargeData(PlayerDailyData,playerDaily, playergid)
		SendDailyAwardToPlayer(AwardTable, playergid)
		return
	end

	--玩家在活动中的时间，为分钟
	local InDailyTime = math.floor(playerDaily[DailyIndex].EndTime / 60)

	--获取奖励信息
	local AwardInfo = deepcopy(DailyAwardList[DailyIndex][CompleteDailyLevel])
	if DailySceneTable[DailyIndex].DailyType == DAILY_WORLDTREE then
		AwardInfo = deepcopy(DailyAwardList[DailyIndex][CompleteDailyLevel - 1])
		WorldTreeAwardMethod(AwardInfo, InDailyTime)
	end

	--失乐园活动奖励
	if DailySceneTable[DailyIndex].DailyType == DAILY_SHILEYUAN then
		rfalse("DAILY_SHILEYUAN")
		AwardInfo = deepcopy(DailyAwardList[DailyIndex][1])
		ShiLeYuanAwardMethod(AwardInfo, playerDaily[DailyIndex].EndTime)
	end

	--活动5
	if DailySceneTable[DailyIndex].DailyType == DAILY_ACTIVITE5 then
		rfalse("DAILY_ACTIVITE5")
		AwardInfo = deepcopy(DailyAwardList[DailyIndex][1])
	end

	--未知神殿活动奖励
	if DailySceneTable[DailyIndex].DailyType == DAILY_UNKNOWNDARKHOUSE then
		rfalse("----->DAILY_UNKNOWNDARKHOUSE")
		local ItemID, ItemNum = GetUDHAwardOpt(DailyIndex, DailyScManager.UDHMonsterID)
		if ItemID ~= nil then
			AwardInfo = {1, 0, 0, 0, 0, 0, 0}   --对应道具奖励
			playerDaily[DailyIndex].GetAwardNum = playerDaily[DailyIndex].GetAwardNum + ItemNum
			if playerDaily[DailyIndex].GetAwardNum > UDHGetItemNum then
				ItemNum = ItemNum - (playerDaily[DailyIndex].GetAwardNum - UDHGetItemNum)
				playerDaily[DailyIndex].GetAwardNum = UDHGetItemNum
			end
			AwardInfo[2] = ItemID
			AwardInfo[3] = ItemNum
		end
	end

	--神泉山活动奖励
	if DailySceneTable[DailyIndex].DailyType == DAILY_SHENQUANSHAN then
		rfalse("----->DAILY_SHENQUANSHAN")
		AwardInfo = deepcopy(DailyAwardList[DailyIndex][1])
		local AwardNum = GetSQSAwardNum(DailyScManager.wKillCount)
		AwardInfo[3] = AwardNum
	end

	--荣誉殿堂活动奖励
	if DailySceneTable[DailyIndex].DailyType == DAILY_HONORHALL then
		rfalse("----->DAILY_HONORHALL")
		AwardInfo = deepcopy(DailyAwardList[DailyIndex][1])
		local ItemID, ItemNum = RandGetItem(HHAwardCfg[DailyIndex])
		if ItemID == nil then  --概率性不能获得奖励
			AwardInfo = nil
		else
			AwardInfo[2] = ItemID
			AwardInfo[3] = ItemNum
		end
	end

	--财富山活动奖励
	if DailySceneTable[DailyIndex].DailyType == DAILY_FORTUNEHILL then
		local GlodNum = math.random(FortuneHillMonsterDieAwardCfg[DailyIndex][1], FortuneHillMonsterDieAwardCfg[DailyIndex][2])
		AwardInfo = deepcopy(DailyAwardList[DailyIndex][1])
		AwardInfo[6] = (GlodNum + AwardInfo[6]) * DailyScManager.SpecMonsterDieTimes
	end

	if AwardInfo == nil then
		playerDaily[DailyIndex].FinishState = 0
		WeekReturnChargeData(PlayerDailyData,playerDaily, playergid)
		SendDailyAwardToPlayer(AwardTable, playergid)
		return
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
		rfalse("playergid = " .. tostring(playergid))
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

function DailyClickNpc(NpcID)
	for n, v in pairs(NpcToGoodsTable) do
		rfalse("v[1] = " .. tostring(v[1]) .. ", NpcID = " .. tostring(NpcID))
		if v[1] == NpcID then
			FindGoodsByItemID(v[2], 1, v[3])
		end
	end
	--操作失败
end

--获取未知神殿奖励通过未知神殿活动索引和怪物ID
function GetUDHAwardOpt(UDHDailyIndex, MonsterID)
	if UDHRandomAwardCfg[UDHDailyIndex] == nil then
		return
	end
	for n, v in pairs(UDHRandomAwardCfg[UDHDailyIndex]) do
		if v[1] == MonsterID then
			return RandGetItem(v[2])
		end
	end
end

--获取神泉山活动奖励数量通过玩家杀怪次数随机掉落道具
function GetSQSAwardNum(KillMonsterNum)
	return math.random(0, KillMonsterNum)
end


