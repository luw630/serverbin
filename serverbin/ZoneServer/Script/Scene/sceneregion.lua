-- SceneManager = {}								--关卡场景管理
PlayerSceneData = tostring("PlayerSceneMap")  --玩家关卡，章节,评分,以及次数限制数据
PlayerSceneSDData = tostring("PlayerSceneMapSD") --玩家扫荡数据
SCENE_LIMITTIMES = 99  --关卡通关或扫荡次数限制
START_SCENEINDEX = 1 	--起始关卡

function InitScene()
	if SceneMapTable ~= nil then
		for o,p in pairs(SceneMapTable) do
			for k,v in pairs(p) do
				if v.Monster ~= nil then
					for i, mCreate in pairs(v.Monster) do
						mCreate.x = mCreate.x * Postionamend 		--怪物出生坐标修正
						mCreate.y = mCreate.y * Postionamend
						--rfalse("Monster x = "..mCreate.x.." y = "..mCreate.y.."")
					end
				elseif v.BatchMonster ~= nil then
					for i,j in pairs(v.BatchMonster) do
						if type(j) == "table" then
							for m,n in pairs(j.monsterlist) do
								n.x = n.x * Postionamend 			--怪物出生坐标修正
								n.y = n.y * Postionamend
								--rfalse("Monster x = "..n.x.." y = "..n.y.."")
							end
						end
					end
					if v.BatchMonster.bornType == REFRSHTYPE_REGIONRANDOM then  --随机刷怪
						for i,j in pairs(v.BatchMonster) do
							if type(j) == "table" then
								if  j.randradius ~= nil then
									local lenth = GetTableLenth(j.monsterlist)
									for m=1,lenth do
										local monsterlist = deepcopy(j.monsterlist[m])
										local num = j.monsternum[m]
										for n=1,num - 1 do
											local radius = LuaRandRange(1,j.randradius)
											local radian = LuaRandRange(0,2*3.14)
											monsterlist.x = j.monsterlist[1].x + radius * math.cos(radian)
											monsterlist.y = j.monsterlist[1].y + radius * math.sin(radian)
											table.insert(j.monsterlist,monsterlist)
											monsterlist = deepcopy(j.monsterlist[m])
										end
									end
								end	
							end
						end
					end
				end

				if v.RefreshMonster ~= nil then
					for i,j in pairs(v.RefreshMonster) do
						if j.refreshtype == REFRSHTYPE_REGION then
							for m,n in pairs(j.monsterlist) do
								n.x = n.x * Postionamend 			--怪物出生坐标修正
								n.y = n.y * Postionamend
							end
							if j.regionPosition ~= nil then
								local region = j.regionPosition
								-- region.upleft[1] = region.upleft[1] *Postionamend
								-- region.upleft[2] = region.upleft[2] *Postionamend
								-- region.lowleft[1] = region.lowleft[1] *Postionamend
								-- region.lowleft[2] = region.lowleft[2] *Postionamend
								-- region.upright[1] = region.upright[1] *Postionamend
								-- region.upright[2] = region.upright[2] *Postionamend
								-- region.lowright[1] = region.lowright[1] *Postionamend
								-- region.lowright[2] = region.lowright[2] *Postionamend
								region.left = region.left *Postionamend
								region.low = region.low *Postionamend
								region.right = region.right *Postionamend
								region.top = region.top *Postionamend
							end

						elseif j.refreshtype == REFRSHTYPE_REGIONRANDOM then
							if j.srcPosition ~= nil then
								j.srcPosition[1] = j.srcPosition[1] * Postionamend
								j.srcPosition[2] = j.srcPosition[2] * Postionamend
							end
						end
					end
				end

				if v.bornPostion ~= nil then
					v.bornPostion[1] = v.bornPostion[1] * Postionamend     --复活以及死亡复活坐标修正
					v.bornPostion[2] = v.bornPostion[2] * Postionamend
				end

				if v.relivePostion ~= nil then
					v.relivePostion[1] = v.relivePostion[1] * Postionamend
					v.relivePostion[2] = v.relivePostion[2] * Postionamend
				end
			end
		end

	end
end

function OnInitPlayerScene(playerscene)   --首次游戏玩家关卡数据的初始化
	if playerscene == nil then
		playerscene = {}
	end
	playerscene.scenemap = 1									--当前章节1
	playerscene.sceneindex = START_SCENEINDEX									--当前关卡1
	playerscene.point = {}										--所有关卡评分数据
	playerscene.point[1] = {0}
	playerscene.point[1][START_SCENEINDEX] = 0                                --
	playerscene.limitcommon = {}								--关卡初始普通次数限制
	playerscene.limitcommon[1] = {}
	playerscene.limitcommon[1][1]  =  SCENE_LIMITTIMES
	playerscene.limitcommon[1][START_SCENEINDEX]  =  SCENE_LIMITTIMES

	playerscene.limitSD = {}									--关卡扫荡次数限制
	playerscene.limitSD[1] = {}
	playerscene.limitSD[1][1]  =  SCENE_LIMITTIMES
	playerscene.limitSD[1][START_SCENEINDEX]  =  SCENE_LIMITTIMES
	playerscene.PickCards = {3,3}   							--关卡抽牌剩余次数， 游戏币以及金币抽取次数剩余
	playerscene.PickCardsceneindex = 0 							--需要获取奖励的关卡
	playerscene.PickCardsceneMap = 0 							--需要获取奖励的章节
	playerscene.deadcount = 0 									--死亡次数
	playerscene.BadgeIndex = 1 									--当前收集的徽章索引
	-- playerscene.taskinfo = {} 									--当前相关联任务信息
	-- playerscene.taskinfo.taskid = 0								--任务相关ID
	-- playerscene.taskinfo.scenemap = 0							--任务相关章节
	-- playerscene.taskinfo.sceneindex = 0							--任务相关关卡ID
	-- playerscene.taskinfo.IsComplete = 0							--任务完成标志
	playerscene.scenesdinfo = {}
	playerscene.scenesdinfo.startsdtime = 0 					--扫荡开始时间
	playerscene.scenesdinfo.scenemap = 0 						--扫荡章节
	playerscene.scenesdinfo.sceneindex = 0   					--扫荡关卡
	playerscene.scenesdinfo.sdcount = 0							--扫荡次数
	playerscene.scenesdinfo.sdstate = SCENE_SD_ISSTART			--扫荡状态 
	WeekReturnChargeData(PlayerSceneData,playerscene)
end


function onGetSceneMsg(bSceneMapIndex) --获取场景关卡信息
	local playerscene = LoadPlayerTable(PlayerSceneData)		--关卡，章节,评分,以及次数限制
	if playerscene == nil then
		OnInitPlayerScene(playerscene)
		playerscene = LoadPlayerTable(PlayerSceneData)		--关卡，章节,评分,以及次数限制
		SendSceneMsg(playerscene.scenemap,playerscene.sceneindex,playerscene.point[1])
	else
		if bSceneMapIndex > 0 then
			if bSceneMapIndex <= playerscene.scenemap then
				if playerscene.point[bSceneMapIndex] == nil then
					rfalse("onGetSceneMsg "..bSceneMapIndex.."is nil")
					return
				end
				SendSceneMsg(playerscene.scenemap,playerscene.sceneindex,playerscene.point[bSceneMapIndex])
			end
		else 
			bSceneMapIndex = playerscene.scenemap
			if playerscene.point[bSceneMapIndex] == nil then
				rfalse("onGetSceneMsg "..bSceneMapIndex.."is nil")
				return
			end
			SendSceneMsg(playerscene.scenemap,playerscene.sceneindex,playerscene.point[bSceneMapIndex])
		end
		--printtable(playerscene.point[bSceneMapIndex])
		--CheckTaskState()
		--rfalse("SendSceneMsg = "..playerscene.scenemap.."playerscene.sceneindex =  "..playerscene.sceneindex)
	end
end


function onSelectSceneMap(scenemap,sceneindex,taskid) --玩家选择关卡
	if scenemap == 0 or sceneindex == 0 then
		rfalse("scenemap == 0 or sceneindex == 0")
		return
	end

	local playerscene = LoadPlayerTable(PlayerSceneData)		--玩家关卡，章节
	if playerscene == nil then									--与任务挂载，玩家可能会直接选择进入关卡
		OnInitPlayerScene(playerscene)
		playerscene = LoadPlayerTable(PlayerSceneData)		--关卡，章节,评分,以及次数限制
	end
	
	local block = true
	if playerscene.scenemap > scenemap then
		block = false
	elseif playerscene.scenemap == scenemap then
		if playerscene.sceneindex >= sceneindex then
			block = false
		end
	end

	if block == true then
		rfalse("quest scenemap :"..scenemap.." sceneindex :"..sceneindex.."is lock")
		return
	end

	local scmap = SceneMapTable[scenemap][sceneindex]
	if scmap ~= nil then
		local selecttable = {}
		selecttable.scenemapIndex = scenemap 					--章节ID
		selecttable.wsceneIndex = sceneindex	 				--关卡ID
		selecttable.bsdtime = playerscene.limitSD[scenemap][sceneindex] --剩余扫荡次数
		selecttable.bcommontime = playerscene.limitcommon[scenemap][sceneindex] --剩余普通闯关次数
		selecttable.bmaxsdtime = scmap.LimitContorl.SDLimitTimes --最大扫荡次数
		selecttable.bmaxcommontime = scmap.LimitContorl.LimitTimes --最大普通闯关次数
		selecttable.bsplimit = scmap.LimitContorl.LimitSP  --体力限制
		selecttable.SDTime = scmap.LimitContorl.SDTime * 60		--扫荡一次所需要时间秒
		selecttable.dexpreward = scmap.scenereward.exp 	--经验奖励
		selecttable.dmoneyreward = scmap.scenereward.money --金钱奖励

		local bestdata= GetSceneData(sceneindex)

		selecttable.bestplayer = bestdata.bestplayer   --最佳玩家
		selecttable.besttime = bestdata.besttime  --最短时间
		
		-- if taskid ~= nil then
		-- 	if taskid > 0 then    	--任务开启关卡
		-- 		playerscene.taskinfo.taskid = taskid								--任务相关ID
		-- 		playerscene.taskinfo.scenemap = scenemap							--任务相关章节
		-- 		playerscene.taskinfo.sceneindex = sceneindex						--任务相关关卡ID
		-- 		playerscene.taskinfo.IsComplete = 0									--任务相完成标志
		-- 		WeekReturnChargeData(PlayerSceneData,playerscene)
		-- 	end
		-- end	
		
		local rewarditem = scmap.scenereward.item
		local equiorecommend = scmap.equiprecommend.item 
		if rewarditem ~= nil and equiorecommend ~= nil then
			SendSelectSceneMsg(selecttable,rewarditem,equiorecommend)
		end
		
	end

end

function onRecvEnterSceneMap(scenemap,sceneindex,bentertype,count) --玩家请求进入关卡，bentertype = 0 普通进入，bentertype = 1 扫荡 ,次数onRecvEnterSceneMap(1,1,1,2)
	--rfalse("onRecvEnterSceneMap = "..sceneindex.."")
	bentertype = bentertype + 1		 							--lua 中Index从1开始
	local playerscene = LoadPlayerTable(PlayerSceneData)		--关卡，章节,评分,以及次数限制
	if playerscene == nil then
		--rfalse("onRecvEnterSceneMap:LoadPlayerTable:PlayerScene nil ")
		OnInitPlayerScene(playerscene) 		
		playerscene = LoadPlayerTable(PlayerSceneData)		--关卡，章节,评分,以及次数限制	
		--return
	end

	if GetBlankCell() < 1 then
		local str = MystringFormat("BAGISFULL")
		if str ~= nil then
			TalkToPlayer(2,str)
		end
		rfalse("bag Cell null")
		return
	end

	if GetPlayerInScene() == 1 then
		rfalse("PlayerIsInScene")
		return
	end

	local enterresult = 1
	if bentertype == 2 then 				--扫荡
		enterresult = 1
	end

	if scenemap == 0 or sceneindex == 0 then
		rfalse("EnterSceneMap scenemap = "..scenemap.." sceneindex = "..sceneindex)
		return
	end

	if playerscene.scenesdinfo.sdstate ~= SCENE_SD_ISSTART and playerscene.scenesdinfo.sdstate ~= SCENE_PB_SENDAWARD then

		rfalse("player is in SD sdstate = "..playerscene.scenesdinfo.sdstate)
		return
	end

	playerscene.deadcount = 0 									--死亡次数

	local block = true
	if playerscene.scenemap > scenemap then
		block = false
	elseif playerscene.scenemap == scenemap then
		if playerscene.sceneindex >= sceneindex then
			block = false
		end
	end

	if block == true then
		rfalse("onRecvEnterSceneMap :"..scenemap.." sceneindex :"..sceneindex.."is lock")
		return
	end

	local scmap = SceneMapTable[scenemap][sceneindex]	--关卡地图数据
	if scmap ~= nil then		
		local limittime = 0
		if bentertype == SCENE_COMMON then
			limittime = playerscene.limitcommon[scenemap][sceneindex]				--普通闯关次数限制
		elseif bentertype == SCENE_SD then
			limittime = playerscene.limitSD[scenemap][sceneindex]					--扫荡次数限制
		end
		--rfalse("onRecvEnterSceneMap bentertype = "..bentertype)
		local splimit = scmap.LimitContorl.LimitSP							--地图体力限制
		if limittime ~= nil and limittime > 0 then
			local currenttp = GetPlayerData(0,GPP_CURTP)				--取得体力扣除
			if currenttp >= splimit then					
				local gid = GetPlayerData(0,GPP_QUANJUGID)
				ChangeObjectData(gid,GPP_CURTP,-splimit) 					--扣除体力
				if bentertype == 1 then 									--普通闯关开始
					PutPlayerToSceneMap(scenemap,sceneindex)				--进入关卡地图
					limittime = limittime - 1 								--扣除进入次数
					playerscene.limitcommon[scenemap][sceneindex] = limittime
				elseif bentertype == 2 then									--扫荡通关开始
					rfalse("SceneMapSD")
					SceneMapSD(scenemap,sceneindex,count,playerscene)
				end

				WeekReturnChargeData(PlayerSceneData,playerscene)			--保存关卡，章节,次数限制
				return
			else
				enterresult = SCENE_ENTER_SP							--体力不足
				rfalse("SCENE_ENTER_SP")
				TalkToPlayer(2,"Player TP notenough")
			end
		else
			enterresult = SCENE_ENTER_TIME		--进入关卡次数不足
			rfalse("SCENE_ENTER_TIME")
		end
	end

	SendEnterSceneMsg(enterresult)       --发送进入失败的消息
end


function SceneMapSD(scenemap,sceneindex,sdcount,playerscene) --扫荡 --关卡地图数据 ,扫荡次数,玩家数据


	local scmap = SceneMapTable[scenemap][sceneindex]	--关卡地图数据
	if scmap == nil then
		rfalse("SceneMapSD SceneMapTable nil")
		return
	end

	

	--local playerscene = LoadPlayerTable(PlayerSceneData)		--关卡，章节,评分,以及次数限制 读取玩家数据
	if playerscene == nil then
		rfalse("playerscene nil")
		return
	-- else
	-- 	rfalse("Quest SceneMapSD")
	-- 	return
	end



	if playerscene.point[scenemap][sceneindex] == nil or playerscene.point[scenemap][sceneindex] == 0 then		--读取评分数据
		rfalse("no pass")
		return
	end

	local sdlimitSD = playerscene.limitSD[scenemap][sceneindex]
	if sdlimitSD < sdcount then
		rfalse("SDCOUNT_ENTER_TIME")   --扫荡次数不足
		TalkToPlayer(2,"sdcount notenough")
		SendEnterSceneMsg(SCENE_ENTER_TIME) 
		return
	end

	playerscene.limitSD[scenemap][sceneindex] = playerscene.limitSD[scenemap][sceneindex] - sdcount

	local exp = scmap.fixationreward.exp.exp * sdcount				--扫荡所得经验
	local money = scmap.fixationreward.exp.money * sdcount			--扫荡所得钱

	
	local pygid = GetPlayerData(0,GPP_QUANJUSID)
	--local pysid = GetPlayerData(0,GPP_QUANJUSID)
	if SceneManagerSD[pygid] == nil then
		SceneManagerSD[pygid] = {}
	end

	playerscene.scenesdinfo.startsdtime = os.time()	 						--扫荡开始时间
	playerscene.scenesdinfo.scenemap = scenemap 									--扫荡章节
	playerscene.scenesdinfo.sceneindex = sceneindex   								--扫荡关卡
	playerscene.scenesdinfo.sdcount = sdcount									--扫荡次数
	playerscene.scenesdinfo.sdstate = SCENE_SD_ISSDNOW						--扫荡状态 


	SceneManagerSD[pygid].startsdtime = os.time()							--扫荡开始时间
	SceneManagerSD[pygid].sdtime = scmap.LimitContorl.SDTime * sdcount    	--扫荡时间
	SceneManagerSD[pygid].scenemap = scenemap 								--扫荡章节
	SceneManagerSD[pygid].sceneindex = sceneindex   						--扫荡关卡
	SceneManagerSD[pygid].sdcount = sdcount									--扫荡次数
	SceneManagerSD[pygid].sdstate = SCENE_SD_ISSDNOW						--扫荡状态 


	local sdtime = SceneManagerSD[pygid].sdtime * 60
	sdtime = GetVIPSDDecreaseTime(0,sdtime)

	SendEnterSceneMsg(1,sdtime,SDgodcost * sdcount)				         							--发送扫荡开始以及时间	
	rfalse("start SceneMapSD .."..scenemap.."   "..sceneindex)
end


function PutPlayerToSceneMap(scenemap,sceneindex)		
	local scmap = SceneMapTable[scenemap][sceneindex]	--关卡地图数据
	if scmap ~= nil then	
		local scenebase = {}
		scenebase.Monster = {}

		--必要的数据判断
		if scmap.winruleconfig == nil then
			rfalse("notfind winruleconfig")
			return
		end

		--当胜利条件为指定怪物死亡作为副本结束条件时，这里判断有没有这个怪物，否则玩家进去可能不会完成
		-- local findspecificid = 0
		-- if scmap.winruleconfig.winrule == SPECIFIC_MONSTERDIE then
		-- 	if scmap.Monster ~= nil then
		-- 		for k,v in pairs(scmap.Monster) do
		-- 			if scmap.winruleconfig.diemonsterid == v.monsterId then		
		-- 				findspecificid = 1
		-- 				break
		-- 			end
		-- 		end
		-- 	end
		-- else
		-- 	findspecificid = 1
		-- end

		-- if findspecificid == 0 then
		-- 	rfalse("notfind specific monster")
		-- 	return
		-- end


		local regionID = scenemap * 10000 + sceneindex
		local mapid = scmap.MapID
		local scenepktye = 0
		if scmap.ScenePkType ~= nil then
			scenepktye = scmap.ScenePkType
		end
		local mapx = CreateScene(regionID, mapid, 0, scenepktye, 0, 0)
		if (nil == mapx) then
			return
		end	

		-- 创建怪物
		scenebase.Monsterlist = {}
		if scmap.Monster ~= nil then
			for k, mCreate in pairs(scmap.Monster) do
				mCreate.regionId = mapx
				local monstergid = CreateObjectIndirect(mCreate)
				--table.insert(scenebase.Monsterlist,monstergid)
			end
			scenebase.Monster = scmap.Monster
			scenebase.MonsterNum = GetTableLenth(scmap.Monster)
		elseif scmap.BatchMonster ~= nil then
			--scenebase.BatchMonster = scmap.BatchMonster
			scenebase.BatchMonster = {}
			scenebase.BatchMonsternum = {}
			scenebase.BatchCurrentGroup = 1    --当前第一波
			scenebase.BatchGroupNum = 0   --总共几波怪物
			scenebase.refreshtype = scmap.BatchMonster.refreshtype    --类型
			scenebase.refreshdelaytime = {} --延时
			--scenebase.refreshdelaytime = scmap.BatchMonster.refreshdelaytime    
			scenebase.refreshstarttime = os.time()   --进入开始时间
			local MonsterNum = 0
			local NpcNum = 0
			for k,v in pairs(scmap.BatchMonster) do
				if type(v) == "table" then
					for i,j in pairs(v.monsterlist) do
						j.regionId = mapx
						if k == 1 then  --只刷新第一组
							local monstergid = CreateObjectIndirect(j)
							--table.insert(scenebase.Monsterlist,monstergid)
						end
						if j.objectType == 1 then
							NpcNum = NpcNum + 1
						end
					end
					scenebase.BatchMonster[k] = v.monsterlist
					MonsterNum = MonsterNum + GetTableLenth(v.monsterlist) - NpcNum         --所有怪物数量
					scenebase.BatchMonsternum[k] = GetTableLenth(v.monsterlist) - NpcNum  --每一波怪物数量 
					scenebase.refreshdelaytime[k] = v.refreshdelaytime
					scenebase.BatchGroupNum = scenebase.BatchGroupNum + 1      --计算总共波数
					NpcNum = 0
				end
			end
			scenebase.MonsterNum = MonsterNum
		end
		if  scmap.RefreshMonster ~= nil then 
			scenebase.RefreshCurrentGroup = 1    --当前第一组
			scenebase.RefreshGroup = {} 		--是否已经刷新分组
			scenebase.monsterlist = {} 			--1--分组内的怪物
			scenebase.regionPosition = {} 		--1--分组内的区域刷怪点
			--scenebase.refreshtype = REFRSHTYPE_REGION			--分组刷怪类型
			scenebase.refreshtype = {}
			local MonsterNum = 0
			for k,v in pairs(scmap.RefreshMonster) do
				if v.refreshtype == REFRSHTYPE_REGION then
					for i,j in pairs(v.monsterlist) do
						j.regionId = mapx
					end
					MonsterNum = MonsterNum + GetTableLenth(v.monsterlist)
				elseif v.refreshtype == REFRSHTYPE_REGIONRANDOM then
					if v.srcPosition ~= nil then
						local tangent  = math.atan2(v.srcPosition[2],v.srcPosition[1]) * LuaRandRange(1,v.radius)
						-- local monsterpos = {}
						-- monsterpos.x = v.srcPosition[1] * tangent
						-- monsterpos.y = v.srcPosition[2] * tangent
						v.monsterlist = {}
						for i,j in pairs(v.monster) do
							for i=1,j.num do
								j.regionId = mapx
								j.x = v.srcPosition[1] * tangent + v.srcPosition[1]
								j.y = v.srcPosition[2] * tangent + v.srcPosition[2]
								tangent  = math.atan2(v.srcPosition[2],v.srcPosition[1]) * LuaRandRange(1,v.radius)
								table.insert(v.monsterlist,j)
							end
						end
					end
				end
				scenebase.monsterlist[k] = v.monsterlist
				scenebase.regionPosition[k] = v.regionPosition 
				scenebase.RefreshGroup[k] = 0
				scenebase.refreshtype[k] = v.refreshtype
				scenebase.MonsterNum = MonsterNum
				--printtable(v.monsterlist)
			end
		end
		--把玩家放到目标场景
		if scmap.bornPostion ~= nil then

			local x = scmap.bornPostion[1] 
			local y = scmap.bornPostion[2] 
			PutPlayerTo(0, x, y, mapx,0)
			rfalse("PutPlayerTo x = "..x.." y = "..y.."")
			scenebase.Playerlist = GetPlayerGID(0)
			scenebase.starttime = os.time()
		end

		if scmap.LimitContorl ~= nil then
			scenebase.survivetime = scmap.LimitContorl.OpenTime   --存在时间
			scenebase.winruleconfig = scmap.winruleconfig	--胜利条件
			scenebase.mapx = mapx
			scenebase.winStar = scmap.winStar				--评星时间判断
			scenebase.CompleteStar = 0						--星级0
			scenebase.wkillcount = 0						--击杀数量
			scenebase.wcurrenthit = 0						--当前连击数
			scenebase.wmaxhit = 0							--最大连击
			scenebase.dlasthittime = 0 						--上一次产生伤害的时间
			scenebase.scenereward = scmap.scenereward       --关卡奖励用于在通关之前显示在面板中
			scenebase.fixationreward = scmap.fixationreward	--通关完成以后的固定奖励
			scenebase.silverreward = scmap.silverreward		--银币抽取的奖励
			scenebase.goldreward = scmap.goldreward			--金币抽取的奖励,分别对应3个等级的不同奖励
			scenebase.sceneindex = sceneindex				--记录章节关卡index	
			scenebase.scenemap = scenemap 					--记录章节index
			scenebase.scenetype = SCENE_COMMON 				--通关类型普通

			if SceneManager[mapx] == nil then
				SceneManager[mapx] = {}
				--SceneManager[mapx] = scenebase
				SceneManager[mapx] = deepcopy(scenebase)
				SceneManager[mapx].IsComplete = 0				--是否闯关完成
				SceneManager[mapx].diemonsternum = 0          --已经死亡的怪物计数
				SendEnterSceneMsg(0)							--发送进入成功消息
				
				local max =  GetPlayerData(GetPlayerGID(0),GPP_MAXHP)
				ChangeObjectData(GetPlayerGID(0),GPP_CURHP,max)
				rfalse("PutPlayerToSceneMap "..mapx.."  ok")
				--printtable(SceneManager[mapx].Monsterlist)
				return 1
			else  
				rfalse("SceneManager"..mapx.."is exist")
				return 0
			end
		end
	end
	rfalse("PutPlayerToSceneMap Faile")
end

function RefreshReginMonster(playergid)  --区域刷怪

end

-- function deepcopy(orig)
--     local orig_type = type(orig)
--     local copy
--     if orig_type == 'table' then
--         copy = {}
--         for orig_key, orig_value in next, orig, nil do
--             copy[deepcopy(orig_key)] = deepcopy(orig_value)
--         end
--         setmetatable(copy, deepcopy(getmetatable(orig)))
--     else -- number, string, boolean, etc
--         copy = orig
--     end
--     return copy
-- end

InitScene()
