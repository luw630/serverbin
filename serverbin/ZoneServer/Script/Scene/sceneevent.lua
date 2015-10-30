--SceneManager = {}								--关卡场景管理

function SceneManagerInit()
	if SceneManager == nil then					--普通通关
		SceneManager = {}
	end
	if SceneManagerSD == nil then				--扫荡
		SceneManagerSD = {}
	end
	if SceneDelayCallBack == nil then     --时间触发回调
		SceneDelayCallBack = {}
	end

end

SceneManagerInit()
function MainLoop()		--循环的脚本调用，1分钟调用1次
	--rfalse("MainLoop")
	look("MainLoop")
	for k,v in pairs(SceneManager) do
		if v.survivetime ~= nil and v.starttime ~= nil  then
			local survivetime = v.survivetime * 60		--换成秒
			if os.time() - v.starttime > survivetime then
				OnSceneComplete(v,k,v.Playerlist)
				rfalse("time to DestroyScene "..k.." \r")
				OnRecvSQSceneLeave(v.Playerlist)
				break
			end
		end	
		OnCheckTimeToRefresh(v)
		delayCall_new(k)
	end

	for k,v in pairs(SceneManagerSD) do   --扫荡
		GetSDComplete(k)
	end

	--delayCall()
	CheckRuntime()
	--OnArenaRun()
end

function OnObjectDead(objectgid,reginid,mapID,killgid,dRankIndex)
	--rfalse("objectgid = "..objectgid.." reginid = "..reginid.." mapid= "..mapID.."killgid = "..killgid)
	--printtable(objectgid)

	if GetObjectType(objectgid) == OBJECT_PLAYER then
		disposeplayerdead(objectgid,reginid,mapID)  							--处理玩家死亡
		OnMonsterKillPlayer(objectgid,reginid,mapID,killgid)
	elseif GetObjectType(objectgid) == OBJECT_MONSTER then
		if SceneManager[reginid] ~= nil then		
			if SceneManager[reginid].BatchMonster ~= nil then
				OnDieMonsterrefresh(SceneManager[reginid],GetMonsterData(2),reginid)
			end
			local scmanager = SceneManager[reginid]
			scmanager.wkillcount = scmanager.wkillcount + 1
			if scmanager.winruleconfig ~= nil then
				if scmanager.winruleconfig.winrule == SPECIFIC_MONSTERDIE then  --指定ID怪物死亡
					local diemonsterid = GetMonsterData(2) 
					if  scmanager.winruleconfig.diemonsterid == diemonsterid then
						scmanager.IsComplete = 1 									--闯关完成
						SceneManager[reginid].IsComplete = 1	
						SendSceneFinish(scmanager,reginid,killgid)					
						--OnSceneComplete(scmanager,reginid,killgid)
						return 
					end
				elseif scmanager.winruleconfig.winrule == All_MONSTERDIE then  --所有怪物死亡
					if scmanager.MonsterNum > 0 then
						scmanager.MonsterNum = scmanager.MonsterNum - 1
					end
					if scmanager.MonsterNum == 0 then
						scmanager.IsComplete = 1						--闯关完成
						SendSceneFinish(scmanager,reginid,killgid)	
						--OnSceneComplete(scmanager,reginid,killgid)
						return 
					end
					SceneManager[reginid].MonsterNum = scmanager.MonsterNum
				elseif scmanager.winruleconfig.winrule == SPECIFIC_MONSTERDIENUM then  --指定怪物数量死亡
					if scmanager.MonsterNum > 0 then
						scmanager.MonsterNum = scmanager.MonsterNum - 1
					end
					scmanager.diemonsternum = scmanager.diemonsternum + 1
					if scmanager.diemonsternum >= scmanager.winruleconfig.diemonsternum then --达到指定怪物数量
						scmanager.IsComplete = 1						--闯关完成
						SendSceneFinish(scmanager,reginid,killgid)	
						return 
					end
					SceneManager[reginid].MonsterNum = scmanager.MonsterNum
				end
			end
		end
		OnMonsterDie(objectgid)
		OnPlayerWinInArena(killgid,reginid,dRankIndex)
	else --处理宠物死亡
		OnMonsterKillPlayer(objectgid,reginid,mapID,killgid)
	end
end

function OnObjectDamage(objectgid,DamageValue,killgid)
	if GetObjectType(objectgid) == OBJECT_MONSTER and DamageValue > 0 then
		OnMonsterDamage(objectgid,DamageValue,killgid)
		local scmanager = GetPlayerSceneManager(killgid)
		if scmanager ~= nil then
			if scmanager.wmaxhit == nil then
				scmanager.wmaxhit = 0
			end
			if scmanager.wcurrenthit == nil then
				scmanager.wcurrenthit = 0
			end
			if os.time() - scmanager.dlasthittime > 3 then
				if scmanager.wmaxhit < scmanager.wcurrenthit then
					scmanager.wmaxhit = scmanager.wcurrenthit
				end
				scmanager.wcurrenthit = 0
			else
				scmanager.wcurrenthit = scmanager.wcurrenthit + 1
			end
			scmanager.dlasthittime = os.time()
		end
	else
		OnPlayerDamage(objectgid,DamageValue,killgid)
	end 
end

function GetSceneCompleteStar( scmanager )--获取场景评分
	if scmanager == nil or type(scmanager) ~= "table" then
		return nil
	end

	if scmanager.IsComplete == 0 then
		return 0							--未达到完成条件得到0星
	end

	if scmanager.starttime ~= nil and scmanager.winStar ~= nil then		--根据时间计算星,这里必定是已经通关，最少1星
		local completetime = os.time() - scmanager.starttime
		scmanager.completetime = completetime
		--rfalse("completetime = "..completetime.."")
		local i = 1
		local lenth = GetTableLenth(scmanager.winStar)
		while i <= lenth do
			if completetime <= scmanager.winStar[i]  then
				return i
			end
			i = i + 1
		end
		-- for k,v in pairs(scmanager.winStar) do
		-- 	if completetime >= v   then
		-- 		return tonumber(k)
		-- 	end
		-- end
	end
	return 3		--不在3个星时间之内，得到3星
end

function OnSceneComplete(scmanager,reginid,playergid) --当玩家闯关完成时
	if scmanager == nil or type(scmanager) ~= "table" then
		return nil
	end
	scmanager.CompleteStar = GetSceneCompleteStar(scmanager) 	--得到评分	
	--rfalse("CompleteStar = "..scmanager.CompleteStar.."")
	SendPlayerRewardMsg(scmanager)

end


function SendPlayerRewardMsg(scmanager)
	if scmanager == nil or type(scmanager) ~= "table" then
		return nil
	end
	if scmanager.IsComplete == 0 then
		rfalse("scmanagerComplete Faile ")
		return
	end 

	SetPlayer(scmanager.Playerlist,1,0) 			--设置脚本中调用的玩家

	local playerscene = LoadPlayerTable(PlayerSceneData,scmanager.Playerlist)		--关卡，章节,评分,以及次数限制
	if playerscene == nil then
		rfalse("SendPlayerRewardMsg:LoadPlayerTable:PlayerScene nil ")
		return
	end

	
	if playerscene.scenesdinfo.sdstate == SCENE_SD_ISSTART then
		rfalse("player is sendReward ")
		return
	end

	OnTaskCallBack(TASK_SCENE,scmanager.scenemap,scmanager.sceneindex)

	if playerscene.scenesdinfo.sdstate ~= SCENE_PB_SENDAWARD then
		rfalse("player is in sdstate = "..playerscene.scenesdinfo.sdstate)
		return
	end

	playerscene.scenesdinfo.sdstate = SCENE_SD_ISSTART
	WeekReturnChargeData(PlayerSceneData,playerscene,scmanager.Playerlist)			--保存关卡，章节,次数限制

	local sendreward = {}
	sendreward.bwintype = SCENE_COMMON - 1		--通关类型普通
	sendreward.bwinstar = scmanager.CompleteStar --评分
	sendreward.wfinishtime = scmanager.completetime --通关时间
	sendreward.wkillcount = scmanager.wkillcount    --击杀数量
	if scmanager.wmaxhit < scmanager.wcurrenthit then
		scmanager.wmaxhit = scmanager.wcurrenthit
	end
	sendreward.wmaxhit = scmanager.wmaxhit			--最大连击

	local exp = scmanager.fixationreward.exp.exp
	local money = scmanager.fixationreward.exp.money

	exp = GetVIPIncrease(0,exp) 					--VIP增加收益
	money = GetVIPIncrease(0,money) 				--VIP增加收益

	rfalse("sceneexp = "..exp.."")

	sendreward.playerexp = exp						--玩家经验奖励
	sendreward.petexp = 0							--宠物经验奖励
	sendreward.mountexp = 0							--坐骑经验奖励
	sendreward.dmoney = money 						--玩家得到的银币奖励
	sendreward.dmoneyextract_1 = silvercost[1]		--银币花费抽奖
	sendreward.dmoneyextract_2 = silvercost[2]		--银币花费抽奖
	sendreward.dmoneyextract_3 = silvercost[3]		--银币花费抽奖
	sendreward.dgoldextract_1 = godcost[1]			--金币花费抽奖
	sendreward.dgoldextract_2 = godcost[2]			--金币花费抽奖
	sendreward.dgoldextract_3 = godcost[3]			--金币花费抽奖

	AddToSceneData(scmanager.sceneindex,GetPlayerData(0,GPP_MYName),scmanager.completetime) --加入到关卡排行榜中

	local specialrate = 1
	if SceneMapTable[scmanager.scenemap][scmanager.sceneindex].specialrate ~= nil then
		specialrate = SceneMapTable[scmanager.scenemap][scmanager.sceneindex].specialrate
		local randm = LuaRandRange(1,10000)
		if randm > specialrate then
			specialrate = 2
		else
			specialrate = 1
		end
	end
	
	sendreward.bspecialscene = specialrate  		--奇遇关卡还是普通关卡

	local scenereward = scmanager.scenereward.item	--关卡奖励用于在通关之前显示在面板中

	
	local sceneindex = scmanager.sceneindex						--当前关卡索引
	local scenemap = scmanager.scenemap
	CompleteScene(scenemap,sceneindex,scmanager.CompleteStar)  --完成关卡
	OpenSceneOneByOne(scenemap,sceneindex) 						--打开下一个关卡
	--增加具体奖励
	GiveExp(exp)
	GiveMoney(2,money)
	local rewardtable = scmanager.fixationreward.item
	local rewarditem = PickItem(rewardtable)
	if rewarditem ~= nil and type(rewarditem) == "table"  then
		SendRewardMsg(sendreward,rewarditem,scmanager.Playerlist)			--发送奖励到客户端
		local itemcount = GetTableLenth(rewarditem)
		local itemindex = 1
		while itemindex < itemcount do
			GiveGoods(rewarditem[itemindex],rewarditem[itemindex+1])
			itemindex = itemindex + 2
		end
	end

	cleanplayer()
end


function onRecvGetRewardMsg(bextracttype,bextractindex) --客户端请求抽牌,抽牌类型以及索引 0游戏币1金币抽牌
	local playerscene = LoadPlayerTable(PlayerSceneData)
	if playerscene == nil then
		rfalse("playerscene nil")
		return
	end
	local PickCards = playerscene.PickCards 	--抽牌次数
	bextracttype = bextracttype + 1
	if bextracttype > 2 then
		return
	end

	if bextractindex > 3 or bextractindex < 1 then  --抽牌索引
		return
	end
	--rfalse("onRecvGetRewardMsg "..bextracttype.."  bextractindex "..bextractindex.."\r")
	local scenemapindex = playerscene.PickCardsceneMap  		 --需要获取奖励章节
	local sceneindex = playerscene.PickCardsceneindex   --需要获取奖励的关卡
	local rewardtable = {}
	if PickCards[bextracttype] > 0 then
		if bextracttype == 1 then --游戏币抽牌
			local playermoney = GetPlayerData(0,GPP_MYBINDMONEY) --玩家绑定游戏币
			local moneycost = silvercost[bextractindex]  --抽牌消耗
			if playermoney < moneycost then
				rfalse("money Not enough")
				TalkToPlayer(2,"money Not enough")
				return
			end
			ChangeMoney(2,-moneycost)						--绑定
--			rfalse("rewardtable scenemapindex = "..scenemapindex.."sceneindex = "..sceneindex.." bextractindex = "..bextractindex)
			rewardtable = SceneMapTable[scenemapindex][sceneindex].silverreward[bextractindex]  --游戏币抽牌
			
		elseif bextracttype == 2 then --金币抽取
			local playermoney = GetPlayerData(0,GPP_MYMONEY) --玩家非绑定游戏币
			local moneycost = godcost[bextractindex]  --抽牌消耗
			if playermoney < moneycost then
				rfalse("money Not enough")
				TalkToPlayer(2,"gold Not enough")
				return
			end
			ChangeMoney(1,-moneycost)					--非绑定
			rewardtable = SceneMapTable[scenemapindex][sceneindex].goldreward[bextractindex]		--金币抽牌
		end
		-- for k,v in pairs(rewardtable) do
				
		-- end
		local rewarditem = PickItem(rewardtable)
		if rewarditem ~= nil and type(rewarditem) == "table"  then
			SendWinRewardMsg(bextractindex,bextracttype-1,rewarditem)
			local itemcount = GetTableLenth(rewarditem)
			local itemindex = 1
			while itemindex < itemcount do
				GiveGoods(rewarditem[itemindex],rewarditem[itemindex+1])
				itemindex = itemindex + 2
			end
		end
		PickCards[bextracttype] = PickCards[bextracttype] - 1
		playerscene.PickCards[bextracttype] = PickCards[bextracttype]		--记录当前抽牌次数
		WeekReturnChargeData(PlayerSceneData,playerscene)						--保存关卡，章节,次数限制
	end
end

function PickItem(rewardlist)--抽牌
	--assert(type(rewardlist) == "table")
	if type(rewardlist) ~= "table" then
		rfalse("rewardlist ~= table")
		return
	end

	local rewarditem = {}								--最后抽取出来的道具
	local count = rewardlist.itemcount 					 --个数次数
	--rfalse("count ="..count)
	local randsun = 0
	for k,v in pairs(rewardlist) do
		if type(v) == "table" then
			randsun = randsun + v[3]
			-- printtable(v)
			-- for i,j in pairs(v) do
			-- 	if type(j) == "table" then
			-- 		randsun = randsun + j[3]
			-- 	end	
			-- end
		end
	end
	local randm = LuaRandRange(1,randsun)
	--rfalse("randsun = "..randsun.." randm = "..randm)
	while count > 0 do
		for k,v in pairs(rewardlist) do
			if type(v) == "table" then
				if randm <= v[3] then
					if v[1] ~= nil then
						table.insert(rewarditem,v[1])
						table.insert(rewarditem,v[2])	
						break
					end
				else
					randm = randm - v[3]
				end
			end
		end
		count = count - 1
		randm = LuaRandRange(1,randsun)
	end
	--rfalse("tablelen ="..GetTableLenth(rewarditem))
	--printtable(rewarditem)
	return rewarditem
end


function SendPlayerSDReward(playersid,playerscenesd,bisdouble)--发送扫荡奖励
	if type(playerscenesd) ~= "table" then
		return
	end

	if playerscenesd.sdstate ~= SCENE_SD_ISWAITAWARD then --等待领取奖励
		rfalse("SendPlayerSDReward :player is SD close")
		return
	end

	local sdscenemap = playerscenesd.scenemap 						--扫荡的章节
	local sdsceneindex = playerscenesd.sceneindex 					--扫荡的关卡
	local sdcount = playerscenesd.sdcount 					--扫荡次数

	local scmap = SceneMapTable[sdscenemap][sdsceneindex]	--关卡地图数据
	if scmap == nil then
		rfalse("SceneMapSD SceneMapTable nil")
		return
	end

	local sendreward = {}
	sendreward.bwintype = SCENE_SD - 1		--通关类型扫荡
	sendreward.bwinstar = 0 --评分
	sendreward.wfinishtime = 0 --通关时间
	sendreward.wkillcount = 0    --击杀数量
	sendreward.wmaxhit = 0			--最大连击

	local exp = scmap.fixationreward.exp.exp * sdcount				--扫荡所得经验
	local money = scmap.fixationreward.exp.money * sdcount			--扫荡所得钱
	sendreward.playerexp = exp						--玩家经验奖励
	sendreward.petexp = 0							--宠物经验奖励
	sendreward.mountexp = 0							--坐骑经验奖励
	sendreward.dmoney = money 						--玩家得到的银币奖励
	sendreward.dmoneyextract_1 = 0					--银币花费抽奖
	sendreward.dmoneyextract_2 = 0					--银币花费抽奖
	sendreward.dmoneyextract_3 = 0					--银币花费抽奖
	sendreward.dgoldextract_1 = 0					--金币花费抽奖
	sendreward.dgoldextract_2 = 0					--金币花费抽奖
	sendreward.dgoldextract_3 = 0					--金币花费抽奖

	sendreward.bspecialscene = 1  					--奇遇关卡还是普通关卡

	exp = GetVIPIncrease(0,exp)  					--取得VIP收益
	money = GetVIPIncrease(0,money)					--取得VIP收益


	local sditem = nil
	if SceneManagerSD[playersid] ~= nil then
		sditem = SceneManagerSD[playersid].rewarditem
		--rfalse("SceneManagerSD item")
		--printtable(sditem)
	end

	if sditem == nil then
		sditem = {}
		local  temp = 0
		while temp < sdcount do
			local sdit = PickItem(scmap.fixationreward.item) 		--扫荡所得道具
			table.insert(sditem,sdit[1])
			table.insert(sditem,sdit[2])
			temp = temp + 1
		end
	end


	local itemcount = GetTableLenth(sditem) /2
	--rfalse("itemcount = "..itemcount.."")
	if  GetBlankCell() < itemcount then
		SendSDReward(0)                                    --背包已经满了
		rfalse("player bag full")
		TalkToPlayer(2,"player bag full")
		return
	end
	itemcount = GetTableLenth(sditem)
	--local scenereward =sditem								--关卡奖励用于在通关之前显示在面板中
	SendRewardMsg(sendreward,sditem,playersid)			--发送奖励到客户端
	--增加具体奖励
	if bisdouble == 1 then
		for i=1,2 do
			GiveExp(exp)
			GiveMoney(2,money)
			if sditem ~= nil and type(sditem) == "table"  then
				local itemindex = 1
				while itemindex <itemcount do
					GiveGoods(sditem[itemindex],sditem[itemindex+1])
					itemindex = itemindex + 2
				end
			end
		end
	else
		GiveExp(exp)
		GiveMoney(2,money)
		if sditem ~= nil and type(sditem) == "table"  then
			local itemindex = 1
			while itemindex <itemcount do
				GiveGoods(sditem[itemindex],sditem[itemindex+1])
				itemindex = itemindex + 2
			end
		end
	end
	

	rfalse("player "..playersid.." sd is sendreward")
	SendSDReward(1,playersid) 												--奖励领取成功
	playerscenesd.sdstate = SCENE_SD_ISSTART  						--状态切换成可以扫荡
	--WeekReturnChargeData(PlayerSceneSDData,playerscenesd)				--保存扫荡
	
end


function RemoveFromSD(playersid) --从扫荡列表中排除
	local sidpos = 1
	local isfind = false
	for k,v in pairs(SceneManagerSD) do
		if k == playersid then
			isfind = true
			break
		end
		sidpos = sidpos + 1
	end
	if isfind == true then
		SceneManagerSD[playersid] = nil
		table.remove(SceneManagerSD,sidpos)
		rfalse("RemoveFromSD .."..playersid.."sidpos = "..sidpos)
	end
end

-- function RemoveFromTable(ptable,tablekey)
-- 	if ptable == nil or ptable == {} then
-- 		return
-- 	end
-- 	local keypos = 1
-- 	local isfind = false
-- 	for k,v in pairs(ptable) do
-- 		if k == tablekey then
-- 			isfind = true
-- 			break
-- 		end
-- 		keypos = keypos + 1
-- 	end

-- 	if isfind == true then
-- 		ptable[tablekey] = nil
-- 		table.remove(ptable,keypos)
-- 		--rfalse("RemoveFromTable tablekey = "..tablekey)
-- 	end
-- end

function AddToSDTable(playersid) --玩家上线加入到列表中计算
	if SceneManagerSD[playersid] == nil then
		SceneManagerSD[playersid] = {}
	end

	local playerscene = LoadPlayerTable(PlayerSceneData,playersid)	
	if playerscene == nil then
		rfalse("playerscene nil")
		return
	end

	if playerscene.scenesdinfo.sdstate == SCENE_SD_ISSDNOW then
		SceneManagerSD[playersid] = playerscene.scenesdinfo
	end

end


function OnRecvStopSDMsg(bStopType) --客户端请求停止扫荡  0 停止扫荡 1 金币完成扫荡
	local playerscene = LoadPlayerTable(PlayerSceneData)	
	if playerscene == nil then
		rfalse("playerscene nil")
		return
	end

	
	local scenemap = playerscene.scenesdinfo.scenemap 			--扫荡章节
	local sceneindex = playerscene.scenesdinfo.sceneindex 		--扫荡关卡
	local  count = playerscene.scenesdinfo.sdcount 				--扫荡次数

	if scenemap > 0 and sceneindex > 0 then
		local scmap = SceneMapTable[scenemap][sceneindex]	--关卡地图数据
		if scmap == nil then
			rfalse("SceneMapSD SceneMapTable nil scenemap = "..scenemap.."sceneindex = "..sceneindex)
			return
		end
  
--		rfalse("OnRecvStopSDMsg count = "..count.." sdstate = "..playerscene.scenesdinfo.sdstate)
		if playerscene.scenesdinfo.sdstate == SCENE_SD_ISSDNOW then --正在扫荡
			if bStopType == 0 then  --普通停止
				playerscene.scenesdinfo.sdstate = SCENE_SD_ISSTART      --关闭扫荡状态
				local startsdtime = playerscene.scenesdinfo.startsdtime
				local sdtime = scmap.LimitContorl.SDTime * count * 60   	--扫荡时间
				local siglesdtime = scmap.LimitContorl.SDTime * 60   --单个关卡扫荡时间
				local difftime = os.difftime(os.time(),startsdtime)    --扫荡经过时间

				sdtime = GetVIPSDDecreaseTime(0,sdtime)   --计算VIP扫荡时间
				siglesdtime = GetVIPSDDecreaseTime(0,siglesdtime)   --计算VIP当个关卡扫荡时间

				if difftime < sdtime then  								--扫荡停止时扫荡未完成
					local passcount = difftime / siglesdtime            --经过时间内通关的次数
						rfalse("OnRecvStopSDMsg ".. playerscene.scenesdinfo.sdstate)
					playerscene.scenesdinfo.sdcount  = passcount					--记录时间通关次数
					if passcount > 0 and difftime > siglesdtime then
						playerscene.scenesdinfo.sdstate = SCENE_SD_ISWAITAWARD   --等待玩家领取奖励
						SendSDMsg(scenemap,sceneindex,3) 								--发送停止,并且有奖励可以领取
						SendSDRewardListMsg(scenemap,sceneindex,passcount,GetPlayerGID(0),GetPlayerData(0,GPP_QUANJUSID)) --发送扫荡奖励列表
					else
						SendSDMsg(scenemap,sceneindex,1) 								--发送停止
					end
					--RemoveFromSD(GetPlayerGID(0))
					WeekReturnChargeData(PlayerSceneData,playerscene)
					rfalse("player sd is stop")
				end
			elseif bStopType == 1 then  --使用金币扫荡停止
				playerscene.scenesdinfo.sdstate = SCENE_SD_ISWAITAWARD      -- 设置状态为等待领取奖励
				local startsdtime = playerscene.scenesdinfo.startsdtime
				local sdtime = scmap.LimitContorl.SDTime * count * 60   	--扫荡时间
				local siglesdtime = scmap.LimitContorl.SDTime * 60   --单个关卡扫荡时间
				local difftime = os.difftime(os.time(),startsdtime)    --扫荡经过时间

				sdtime = GetVIPSDDecreaseTime(0,sdtime)   --计算VIP扫荡时间
				siglesdtime = GetVIPSDDecreaseTime(0,siglesdtime)   --计算VIP当个关卡扫荡时间

				if difftime < sdtime then  								--扫荡停止时扫荡未完成
					local passcount = difftime / siglesdtime            --经过时间内通关的次
					local sdgodcostmoney = SDgodcost * (count - passcount + 1)   --根据当前通关次数计算金钱
					local playermoney = GetPlayerData(0,GPP_MYMONEY) --玩家非绑定游戏币
					if playermoney < sdgodcostmoney then 
						rfalse("StopSDMsg money notenough")
						TalkToPlayer(2,"StopSDMsg money notenough")
						return
					end
					ChangeMoney(1,-sdgodcostmoney)	
					playerscene.scenesdinfo.sdcount  = count					--记录时间通关次数	
					SendSDMsg(scenemap,sceneindex,0) 								--发送扫荡完成 					
					--RemoveFromSD(GetPlayerGID(0))
					WeekReturnChargeData(PlayerSceneData,playerscene)
					SendSDRewardListMsg(scenemap,sceneindex,count,GetPlayerGID(0),GetPlayerData(0,GPP_QUANJUSID)) --发送扫荡奖励列表

					if scmap.BatchMonster ~= nil then  --扫荡完成任务杀怪
						local sid = GetPlayerData(0,GPP_QUANJUSID)
						for i,j in pairs(scmap.BatchMonster) do
							if type(j) == "table" then
								for m,n in pairs(j.monsterlist) do
									TaskKillMonster(sid,n.monsterId) 					
									--rfalse("Monster x = "..n.x.." y = "..n.y.."")
								end
							end
						end
					end

					rfalse("player sd is completet")
				end
			end
		end
	end
end

function OnRecvSDRewardMsg( bisdouble )--客户端请求扫荡完成以后的奖励
	local playerscene = LoadPlayerTable(PlayerSceneData)
	if playerscene == nil then
		rfalse("not find data")
		return
	end

	if playerscene.scenesdinfo.sdstate ~= SCENE_SD_ISWAITAWARD then
		rfalse("Not find reward state = "..playerscene.scenesdinfo.sdstate)
		return
	end

	local  count = playerscene.scenesdinfo.sdcount 				--扫荡次数
	local buymoney = GetSDBuyMoney(count)
	if bisdouble == 1 then
		if GetPlayerData(0,GPP_MYMONEY) < buymoney then
			rfalse("money notenough")
			return
		end
		ChangeMoney(1,-buymoney)					--非绑定
		--SendPlayerSDReward(GetPlayerData(0,GPP_QUANJUSID),playerscene.scenesdinfo,bisdouble)    --发送奖励
	end

	SendPlayerSDReward(GetPlayerData(0,GPP_QUANJUSID),playerscene.scenesdinfo,bisdouble)    --发送奖励
	WeekReturnChargeData(PlayerSceneData,playerscene)
	RemoveFromSD(GetPlayerData(0,GPP_QUANJUSID))
end


function GetSDComplete(playersid) --扫荡是否完成

	local playerscene = LoadPlayerTable(PlayerSceneData,playersid)
	if playerscene == nil or playerscene == -1  then
		--rfalse("find playerscene error")
		return
	end

	local scenemap = playerscene.scenesdinfo.scenemap 			--扫荡章节
	local sceneindex = playerscene.scenesdinfo.sceneindex 		--扫荡关卡
	local  count = playerscene.scenesdinfo.sdcount 				--扫荡次数
	local scmap = SceneMapTable[scenemap][sceneindex]	--关卡地图数据
	if scmap == nil then
		rfalse("SceneMapSD SceneMapTable nil")
		return
	end

  
	local startsdtime = playerscene.scenesdinfo.startsdtime
	local sdtime = scmap.LimitContorl.SDTime * count *60    	--扫荡时间
	local difftime = os.difftime(os.time(),startsdtime)

	local gid = GetPlayerGID(playersid)
	sdtime = GetVIPSDDecreaseTime(gid,sdtime)

	if difftime < sdtime then
		return
	end


	if playerscene.scenesdinfo.sdstate ~= SCENE_SD_ISSDNOW then --正在扫荡
		--rfalse("GetSDComplete :player is SD close")
		return
	end

	if scmap.BatchMonster ~= nil then  --扫荡完成任务杀怪
		for i,j in pairs(scmap.BatchMonster) do
			if type(j) == "table" then
				for m,n in pairs(j.monsterlist) do
					TaskKillMonster(playersid,n.monsterId) 					
					--rfalse("Monster x = "..n.x.." y = "..n.y.."")
				end
			end
		end
	end

	playerscene.scenesdinfo.sdstate = SCENE_SD_ISWAITAWARD   --设置状态为等待领取奖励
	SendSDMsg(scenemap,sceneindex,0,playersid) 								--发送扫荡完成

	WeekReturnChargeData(PlayerSceneData,playerscene,playersid)
	--RemoveFromSD(playersid)
	rfalse("player sd completet")

	SendSDRewardListMsg(scenemap,sceneindex,count,gid,playersid) --发送扫荡奖励列表

	-- if playergid > 0 then
	-- 	cleanplayer()
	-- end	
end

function SendSDRewardListMsg(scenemap,sceneindex,count,playergid,playersid)  --发送扫荡奖励列表
	local scmap = SceneMapTable[scenemap][sceneindex]	--关卡地图数据
	if scmap == nil then
		rfalse("SendSDRewardListMsg SceneMapTable nil")
		return
	end
	local exp = scmap.fixationreward.exp.exp * count				--扫荡所得经验
	local money = scmap.fixationreward.exp.money * count			--扫荡所得钱
	local wbuymoey = GetSDBuyMoney(count)

	exp = GetVIPIncrease(playergid,exp)
	money = GetVIPIncrease(playergid,money)

	local sditem = {}                  --获取扫荡奖励列表
	local  temp = 0
	while temp < count do
		local sdit = PickItem(scmap.fixationreward.item) 		--扫荡所得道具
		table.insert(sditem,sdit[1])
		table.insert(sditem,sdit[2])
		temp = temp + 1
	end
	rfalse("SendSDRewardListMsg")
	
	if SceneManagerSD[playersid] ~= nil then
		SceneManagerSD[playersid].rewarditem = sditem
		--printtable(sditem)
	end
	SendSceneSDListMsg(scenemap,sceneindex,exp,money,wbuymoey,sditem,playergid)     --发送扫荡奖励列表
end

function CheckPlayerSD( playersid) --登陆检测玩家扫荡完成情况

	local playerscene = LoadPlayerTable(PlayerSceneData,playersid)
	if playerscene == nil then
		rfalse("not find data")
		return
	elseif playerscene == -1 then
		rfalse("not find player")
		return
	end


	local scenemap = playerscene.scenesdinfo.scenemap 			--扫荡章节
	local sceneindex = playerscene.scenesdinfo.sceneindex 		--扫荡关卡
	local  count = playerscene.scenesdinfo.sdcount 				--扫荡次数

	if scenemap == 0 or sceneindex == 0 then
		--rfalse("Player notSD")
		return
	end

	local scmap = SceneMapTable[scenemap][sceneindex]	--关卡地图数据
	if scmap == nil then
		rfalse("SceneMapSD SceneMapTable nil")
		return
	end

	if playerscene.scenesdinfo.sdstate == SCENE_SD_ISWAITAWARD then
		SendSDMsg(scenemap,sceneindex,0,playersid) 
		SendSDRewardListMsg(scenemap,sceneindex,count,playergid)
		return
	end

	if playerscene.scenesdinfo.sdstate ~= SCENE_SD_ISSDNOW then --正在扫荡
		return
	end


	local startsdtime = playerscene.scenesdinfo.startsdtime
	local sdtime = scmap.LimitContorl.SDTime * count * 60   	--扫荡时间
	sdtime = GetVIPSDDecreaseTime(0,sdtime)

	local difftime = os.difftime(os.time(),startsdtime)
	if difftime < sdtime then
		local timelefe = sdtime - difftime
		onSelectSceneMap(1,sceneindex)
		SendEnterSceneMsg(1,timelefe,count * SDgodcost)		
		rfalse(" player sd is open timelefe = "..timelefe)
		AddToSDTable(playersid)
		return
	end
	GetSDComplete(playersid)
end

function GetSceneManagerIndex(scenegid )
	local index = 1
	for k,v in pairs(SceneManager) do
		if k == scenegid then
			return index
		end
		index = index + 1
	end
end

function DestroyDynamicScene(scenegid,monsterlist)
	for k,v in pairs(monsterlist) do
		OnMonsterDie(v)
		Removeobj(scenegid,v)
	end
	DestroyScene(scenegid)
	RemoveFromTable(SceneManager,scenegid)
	-- SceneManager[scenegid] = nil
	-- local index  = GetSceneManagerIndex(scenegid)
	-- if index ~= nil then
	-- 	table.remove(SceneManager,index)
	-- end
end

function GetSceneCompleteTime(scmanager) --获取当前关卡完成时间
	if scmanager ~= nil then
		if scmanager.starttime ~= nil then
			scmanager.completetime = os.time() - scmanager.starttime
		end
	end
end

function OnRecvSQSceneLeave(playergid) --客户端请求离开场景
	for k,v in pairs(SceneManager) do
		if v.Playerlist == playergid then
			--OnSceneComplete(v,k,v.Playerlist)
			LeaveScene(v,k,playergid)
			break
		end
	end
end

function LeaveScene(scmanager,reginid,playergid) 
	if GetPlayerData(playergid,GPP_ACTION) == EA_DEAD or GetPlayerData(playergid,GPP_CURHP) == 0 then
		rfalse("LeaveSceneRelive  "..playergid.."")
		PlayerQuestRelive(0,playergid)
	end
	if scmanager ~= nil then
		if scmanager.IsComplete == 0 then --未完成失败
			if scmanager.completetime == nil then
				GetSceneCompleteTime(scmanager)
			end
			SendPassFailMsg(scmanager.completetime,scmanager.wmaxhit)
			rfalse("SendPassFailMsg")
		end
	end
	PutPlayerFromDynamic(1,reginid,0,0,0)						--把玩家从场景从移动
	DestroyDynamicScene(reginid,scmanager.Monsterlist)
	RemoveFromTable(SceneDelayCallBack,reginid)
end

function OpenSceneList(taskscene)
	local playerscene = LoadPlayerTable(PlayerSceneData)		--关卡，章节,评分,以及次数限制
	if playerscene == nil then									--可能是初次游戏，没有数据
		OnInitPlayerScene(playerscene) 		
		playerscene = LoadPlayerTable(PlayerSceneData)		--关卡，章节,评分,以及次数限制		
	end
	SendSceneListMsg(playerscene.scenemap,playerscene.sceneindex,taskscene)
end

function SendSceneFinish(scmanager,reginid,playergid) --发送关卡完成的消息
	if scmanager == nil or type(scmanager) ~= "table" then
		return nil
	end
	if GetPlayerData(playergid,GPP_ACTION) == EA_DEAD then
		rfalse("PlayerQuestRelive  "..playergid)
		PlayerQuestRelive(0,playergid)
	end

	if scmanager.IsComplete == 0 then
		rfalse("scmanagerComplete Faile ")
		return
	end 

	if GetObjectType(playergid) == OBJECT_PET then  --杀死怪物为侠客
		playergid = GetPetOwer(playergid)
	end

	local playerscene = LoadPlayerTable(PlayerSceneData,playergid)		--关卡，章节,评分,以及次数限制
	if playerscene == nil then
		rfalse("SendSceneFinish:LoadPlayerTable:PlayerScene nil ")
		return
	end
	playerscene.scenesdinfo.sdstate = SCENE_PB_SENDAWARD 		--玩家通关设置状态为发送奖励状态
	WeekReturnChargeData(PlayerSceneData,playerscene,playergid)			--保存关卡，章节,次数限制
					
	KillAllMonster(reginid)				
	SendSceneFinishMsg(playergid)--发送关卡完成的消息
	--OnTaskCallBack(TASK_SCENE,1,scmanager.sceneindex)
	rfalse("SendSceneFinishMsg") 

	--活跃度计算
	CompleteAndActiveness(1, playergid)
end

function OnSceneQuestReward(playergid)  --关卡完成时请求关卡奖励
	local scmanager,reginid = GetPlayerSceneManager(playergid)
	if scmanager ~= nil then
		OnSceneComplete(scmanager,reginid,playergid)
	end
end

function GetPlayerSceneManager( playergid )--获取用户的关卡数据
	for k,v in pairs(SceneManager) do
		if v.Playerlist == playergid then
			return v,k
		end
	end	
	--add by ly 2014/4/19 用于日常活动场景中
	for k,v in pairs(DailyAreaManager) do
		if v.Playerlist == playergid then
			return v,k
		end
		
	end
	--rfalse("GetPlayerSceneManager nil")
end

function OnDieMonsterrefresh(scmanager,diemonsterid,mapx ) --怪物死亡后触发刷新
	if scmanager == nil or type(scmanager) ~= "table" then
		return 
	end
	local refreshgroups = scmanager.BatchCurrentGroup
	if scmanager.BatchMonsternum[refreshgroups] ~= nil  and scmanager.BatchMonster[refreshgroups] ~= nil then
		for k,v in pairs(scmanager.BatchMonster[refreshgroups]) do
			if v.monsterId == diemonsterid then
				scmanager.BatchMonsternum[refreshgroups] = scmanager.BatchMonsternum[refreshgroups] - 1
				break
			end
		end
	end
	
	if scmanager.BatchMonsternum[refreshgroups] == 0 then
		SendBatchesMonster(scmanager.Playerlist,refreshgroups,0)   --发送当前怪物死亡
		refreshgroups = refreshgroups + 1
		if scmanager.BatchMonster[refreshgroups] ~= nil then
			SendBatchesMonster(scmanager.Playerlist,refreshgroups,1)   --发送当前怪物刷新
			local delaytime = scmanager.refreshdelaytime[refreshgroups]
			for k,v in pairs(scmanager.BatchMonster[refreshgroups]) do
				local createmon = {CreateObjectIndirect,v}
				AddfunctiondelayCall(delaytime,createmon,scmanager.mapx)
			end
			scmanager.BatchCurrentGroup = refreshgroups
		end
	end
end

function OnRecvSendGroupMonsterDie()  --客户端通知当前分组怪物死亡
 	if GetPlayerInScene() == 1 then
 		local mapx = GetSceneRegionID()
 		local gid = GetPlayerData(0,GPP_QUANJUGID)
 		if mapx > 0 then
 			if SceneManager[mapx] ~= nil then
 				local scmanager = SceneManager[mapx]
 				local refreshgroups = SceneManager[mapx].BatchCurrentGroup
 				if SceneManager[mapx].BatchMonsternum[refreshgroups] ~= nil then
 					SceneManager[mapx].BatchMonsternum[refreshgroups] = 0
 					SendBatchesMonster(SceneManager[mapx].Playerlist,refreshgroups,0)   --发送当前怪物死亡
 				end
 				refreshgroups = refreshgroups + 1
				if refreshgroups > scmanager.BatchGroupNum then   --当前波数大于总共应该结束
					scmanager.IsComplete = 1						--闯关完成
					SendSceneFinish(scmanager,mapx,gid)
					return	
				end

				if scmanager.BatchMonster[refreshgroups] ~= nil then
					SendBatchesMonster(scmanager.Playerlist,refreshgroups,1)   --发送当前怪物刷新
					local delaytime = scmanager.refreshdelaytime[refreshgroups]
					for k,v in pairs(scmanager.BatchMonster[refreshgroups]) do
						local createmon = {CreateObjectIndirect,v}
						AddfunctiondelayCall(delaytime,createmon,scmanager.mapx)
					end
					scmanager.BatchCurrentGroup = refreshgroups
				end

 			end
 		end
 	end
end

function OnCheckTimeToRefresh(scmanager)
	if scmanager == nil or type(scmanager) ~= "table" then
		return 
	end
	if scmanager.BatchMonster == nil and scmanager.monsterlist == nil  then
		return
	end

	-- local gid = scmanager.Playerlist
	-- local pos = GetPlayerData(gid,GPP_QUANPOS)
	-- local nowpos = pos
	-- if pos ~= nil then
	-- 	nowpos[1] = math.ceil(pos[1] / 32)
	-- 	nowpos[2] = math.ceil(pos[2] / 32)
	-- 	rfalse("playerPosition = "..nowpos[1].."  "..nowpos[2].."")
	-- end

	if scmanager.monsterlist ~= nil then
		local refreshgroups = scmanager.RefreshCurrentGroup
		if scmanager.refreshtype[refreshgroups] == REFRSHTYPE_REGION  then --玩家到达指定范围内刷新
			if scmanager.RefreshGroup[refreshgroups] == 0 then
				if scmanager.regionPosition[refreshgroups] ~= nil then
					local gid = scmanager.Playerlist
					local pos = GetPlayerData(gid,GPP_QUANPOS)
					if pos ~= nil then
						--
						local left = scmanager.regionPosition[refreshgroups].left
						local low = scmanager.regionPosition[refreshgroups].low
						local right = scmanager.regionPosition[refreshgroups].right
						local top = scmanager.regionPosition[refreshgroups].top
						--rfalse("playerPosition x= "..pos[1].." left =  "..left.."right = "..right.."")
						--rfalse("playerPosition y= "..pos[2].." top =  "..top.." low = "..low.."")
						if pos[1] >= left and pos[1] <= right then
							if pos[2] >= low and pos[2] <= top then
								for k,v in pairs(scmanager.monsterlist[refreshgroups]) do
									CreateObjectIndirect(v)
								end
								scmanager.RefreshGroup[refreshgroups] = 1
								scmanager.RefreshCurrentGroup = scmanager.RefreshCurrentGroup + 1
								--rfalse("refreshmonster groups = "..refreshgroups.."")
							end
						end
						-- if scmanager.regionPosition[refreshgroups][1] == pos[1] and scmanager.regionPosition[refreshgroups][2] == pos[2] then
						-- 	for k,v in pairs(scmanager.monsterlist[refreshgroups]) do
						-- 		CreateObjectIndirect(v)
						-- 	end
						-- 	scmanager.RefreshGroup[refreshgroups] = 1
						-- 	scmanager.RefreshCurrentGroup = scmanager.RefreshCurrentGroup + 1
						-- end
					end	
				end
			end
			return
		end
	end



	
	-- if scmanager.refreshtype == REFRSHTYPE_MONSTERDIR then  --死亡刷新
	-- 	return
	-- end
	-- local refreshgroups = scmanager.BatchCurrentGroup
	-- local delaytime = scmanager.refreshdelaytime
	-- refreshgroups = refreshgroups + 1
	-- if scmanager.BatchMonster[refreshgroups] ~= nil then
	-- 	local nowtime = os.time()
	-- 	if nowtime >= scmanager.refreshstarttime + delaytime then
	-- 		for k,v in pairs(scmanager.BatchMonster[refreshgroups]) do
	-- 			local createmon = {CreateObjectIndirect,v}
	-- 			AddfunctiondelayCall(delaytime,createmon)
	-- 		end
	-- 		scmanager.BatchCurrentGroup = refreshgroups
	-- 		scmanager.refreshstarttime = nowtime
	-- 	end
	-- end


	if scmanager.winruleconfig ~= nil then
		local iswin = 1
		local gid = scmanager.Playerlist
		if scmanager.winruleconfig.winrule == SPECIFIC_ITEMNUM then  --得到指定数量道具
			if scmanager.winruleconfig.specificitem ~= nil then
				local specificitem = scmanager.winruleconfig.specificitem
				local num = GetTableLenth(specificitem)
				for i=1,num do
					if i % 2 > 0 then
						local playeritemnum = GetItemNum(gid,specificitem[i])
						rfalse("playeritemnum = "..playeritemnum.."")
						if playeritemnum < specificitem[i+1] then
							iswin = 0 
							break
						end
					end
				end
				if iswin == 1 then --胜利
					scmanager.IsComplete = 1						--闯关完成
					SendSceneFinish(scmanager,scmanager.scenemap,gid)	
				end
			end
		end
	end

end

-- SceneDelayCallBack = {}
function delayCall()
	local nowtime = os.time()
	for k,v in pairs(SceneDelayCallBack) do
		for i,j in pairs(v) do
			if nowtime >= j.starttime + j.delaytime then
				local delaycallfunc = j.delaycall
				if delaycallfunc ~= nil then
					delaycallfunc[1](delaycallfunc[2],delaycallfunc[3])
					j.isrefresh = true
					RemoveFromTable(v,i)
					break
				end
			end
		end
	end

	-- for k,v in pairs(SceneDelayCallBack) do
	-- 	for i,j in pairs(v) do
	-- 		if j.isrefresh == true then
	-- 			RemoveFromTable(v,i)
	-- 		end
	-- 	end
	-- end

end

function delayCall_new(mapx)
	--rfalse("delayCall_new "..mapx.."")
	--printtable(SceneDelayCallBack)
	local nowtime = os.time()
	for k,v in pairs(SceneDelayCallBack) do
		for i,j in pairs(v) do
			if nowtime >= j.starttime + j.delaytime then
				local delaycallfunc = j.delaycall
				if delaycallfunc ~= nil and j.isrefresh == false then
					delaycallfunc[1](delaycallfunc[2],delaycallfunc[3])
					j.isrefresh = true
					--RemoveFromTable(v,i)
					--break
				end
			end
		end
	end

	for k,v in pairs(SceneDelayCallBack) do
		for i,j in pairs(v) do
			if j.isrefresh == true then
				RemoveFromTable(v,i)
				--rfalse("delaycallfunc from"..k.."")
				break
			end
		end
	end
end


function AddfunctiondelayCall(delaytime,functable,mapx) --延迟执行的函数，延迟时间
	local nowtime = os.time()
	if SceneDelayCallBack[mapx] == nil then
		SceneDelayCallBack[mapx] = {}
	end
	local funcCallBack = {}
	funcCallBack.delaytime = delaytime
	funcCallBack.starttime = nowtime
	funcCallBack.delaycall = functable
	funcCallBack.isrefresh = false      --是否刷新
	table.insert(SceneDelayCallBack[mapx],funcCallBack)
	--rfalse("AddfunctiondelayCall "..mapx.."")
	--printtable(SceneDelayCallBack[mapx])
end

function RemoveCallBack(tablekey)
	local sidpos = 1
	local isfind = false
	for k,v in pairs(SceneDelayCallBack) do
		if k == tablekey then
			isfind = true
			break
		end
		sidpos = sidpos + 1
	end
	if isfind == true then
	--rfalse("RemoveCallBack key = "..tablekey.."")
		SceneDelayCallBack[tablekey] = nil
		table.remove(SceneDelayCallBack,sidpos)
		
	end
end


function OnRecvQuestDebrisinfo() --客户端请求碎片信息
	local playerscene = LoadPlayerTable(PlayerSceneData)		--关卡，章节,评分,以及次数限制
	if playerscene == nil then
		OnInitPlayerScene(playerscene)
		playerscene = LoadPlayerTable(PlayerSceneData)		--关卡，章节,评分,以及次数限制
	end
	local BadgeIndex = playerscene.BadgeIndex
	local Debrisnum,DebrisAllnum = GetDebrisinfo(BadgeIndex,playerscene.sceneindex)
	OnCheckDebrisAward()
	if Debrisnum <= DebrisAllnum and DebrisAllnum > 0  then
		SendDebrisinfo(BadgeIndex,Debrisnum,DebrisAllnum)
--		rfalse("Debrisnum = "..Debrisnum.."DebrisAllnum = "..DebrisAllnum.."")
		return
	end
	rfalse("Debrisnum > DebrisAllnum")
end

function GetDebrisinfo(BadgeIndex,sceneindex)  --获取玩家徽章碎片信息 徽章index，关卡index
	local Debrisnum = 0   		--当前碎片数量
	local DebrisAllnum = 0  	--当前徽章所有碎片数量
	if Debriscollect ~= nil and Debriscollect[BadgeIndex] ~= nil then
		--DebrisAllnum = GetTableLenth(Debriscollect[BadgeIndex].Debris)
		for k,v in pairs(Debriscollect[BadgeIndex].Debris) do
			if sceneindex > v then
				Debrisnum = Debrisnum + 1
			end
			DebrisAllnum = DebrisAllnum + 1
		end
	end
	return Debrisnum,DebrisAllnum
end

function GetDebrisAward(BadgeIndex)  --获取徽章奖励
	if Debriscollect ~= nil and Debriscollect[BadgeIndex] ~= nil then
		return Debriscollect[BadgeIndex].DebrisAward
	end
	return nil
end

function OnRecvQuestDebrisAward() --客户端请求徽章奖励
	local playerscene = LoadPlayerTable(PlayerSceneData)		--关卡，章节,评分,以及次数限制
	if playerscene ~= nil then
		local BadgeIndex = playerscene.BadgeIndex
		local Debrisnum,DebrisAllnum = GetDebrisinfo(BadgeIndex,playerscene.sceneindex)
		if Debrisnum == DebrisAllnum and DebrisAllnum > 0  then  

			local DebrisAward = GetDebrisAward(BadgeIndex)  	 --背包格子判断
			if DebrisAward ~= nil then
				local numlen = GetTableLenth(DebrisAward)
				if  GetBlankCell() < numlen then
					rfalse("OnRecvQuestDebrisAward: PlayerBag Full")
					return
				end
			end	

			for k,v in pairs(DebrisAward) do    --增加奖励道具
				GiveGoods(v,1)
			end
			playerscene.BadgeIndex = playerscene.BadgeIndex + 1   --增加徽章收集ID
			WeekReturnChargeData(PlayerSceneData,playerscene) 	
			OnRecvQuestDebrisinfo()	
			rfalse("OnRecvQuestDebrisAward: Success")
		end
	end
end

function OnCheckDebrisAward() --检测徽章，通知客户端徽章奖励
	local playerscene = LoadPlayerTable(PlayerSceneData)		--关卡，章节,评分,以及次数限制
	if playerscene ~= nil then
		local BadgeIndex = playerscene.BadgeIndex
		local Debrisnum,DebrisAllnum = GetDebrisinfo(BadgeIndex,playerscene.sceneindex)
		if Debrisnum == DebrisAllnum and DebrisAllnum > 0  then
			SendDebrisAward()
		end
	end
end

function CompleteScene(scenemap,sceneindex,CompleteStar) --任务完成关卡
	local playerscene = LoadPlayerTable(PlayerSceneData,0)		--关卡，章节,评分,以及次数限制
	if playerscene == nil then
		--rfalse("SendPlayerRewardMsg:LoadPlayerTable:PlayerScene nil ")
		OnInitPlayerScene(playerscene)
		playerscene = LoadPlayerTable(PlayerSceneData)		--关卡，章节,评分,以及次数限制
		--return
	end

	playerscene.PickCardsceneindex = sceneindex 			--需要获取奖励的关卡
	playerscene.PickCardsceneMap = scenemap 				--需要获取奖励的章节
	playerscene.PickCards = {3,3} 							--重置当前关卡抽牌次数
	if playerscene.point[scenemap] ~= nil then 				--章节评分
		if playerscene.point[scenemap][sceneindex] == 0 then
			playerscene.point[scenemap][sceneindex] = CompleteStar
		elseif playerscene.point[scenemap][sceneindex] > CompleteStar then --更新评分数据,但是不做通关处理
			playerscene.point[scenemap][sceneindex] = CompleteStar
		end
	end
	WeekReturnChargeData(PlayerSceneData,playerscene,0)			--保存关卡，章节,次数限制

end


function GetSDBuyMoney(count) --获取扫荡购买金币数量
	return 1* count
end

function ServerCompleteScene(scenemap,sceneindex) --直接完成当前关卡
	local playerscene = LoadPlayerTable(PlayerSceneData,0)		--关卡，章节,评分,以及次数限制
	if playerscene == nil then
		OnInitPlayerScene(playerscene)
		playerscene = LoadPlayerTable(PlayerSceneData)		--关卡，章节,评分,以及次数限制
	end

	playerscene.PickCardsceneindex = sceneindex 			--需要获取奖励的关卡
	playerscene.PickCardsceneMap = scenemap 				--需要获取奖励的章节
	playerscene.PickCards = {3,3} 							--重置当前关卡抽牌次数
	if playerscene.point[scenemap] ~= nil then 				--章节评分

		if playerscene.point[scenemap][sceneindex] == nil or playerscene.point[scenemap][sceneindex] == 0 then			--新通关关卡
	
			if sceneindex >= SceneIndexNum[scenemap] then 															--当前章节关卡结束
				if SceneIndexNum[scenemap + 1] ~= nil then 	
					if scenemap + 1 > playerscene.scenemap then 									--章节检测
						playerscene.scenemap = 	scenemap + 1													--取得下一章节
						playerscene.sceneindex = 1   													--可以进入下一章节
						playerscene.point[scenemap + 1] = {0}														--下一关卡得分
						playerscene.limitSD[scenemap + 1] = {SCENE_LIMITTIMES} 											--下一关卡剩余扫荡次数
						playerscene.limitcommon[scenemap + 1] = {SCENE_LIMITTIMES}									--下一关卡剩余普通闯关次数
						rfalse("enter next scenemap = "..scenemap + 1)
					end
				else
					rfalse("next scenemap nil")
					return
				end
			else
				if sceneindex > playerscene.sceneindex then
					for i=playerscene.sceneindex+1,sceneindex do
						playerscene.sceneindex = i    													--可以进入下一关卡
						playerscene.point[scenemap][i] = 0 														--下一关卡得分
						playerscene.limitSD[scenemap][i] = SCENE_LIMITTIMES 										--下一关卡剩余扫荡次数
						playerscene.limitcommon[scenemap][i] = SCENE_LIMITTIMES 									--下一关卡剩余普通闯关次数
						rfalse("OpenSceneIndex "..i.."")
					end
				-- elseif sceneindex == playerscene.sceneindex then
				-- 	playerscene.sceneindex = playerscene.sceneindex + 1   													--可以进入下一关卡
				-- 	playerscene.point[scenemap][sceneindex + 1] = 0 														--下一关卡得分
				-- 	playerscene.limitSD[scenemap][sceneindex + 1] = SCENE_LIMITTIMES 										--下一关卡剩余扫荡次数
				-- 	playerscene.limitcommon[scenemap][sceneindex + 1] = SCENE_LIMITTIMES 									--下一关卡剩余普通闯关次数
				-- 	rfalse("OpenSceneIndex "..sceneindex.."")
				end
			end
		end
	end
	WeekReturnChargeData(PlayerSceneData,playerscene,0)			--保存关卡，章节,次数限制
end


function GetTaskNextSceneIndex(taskID) --获取任务相关联的下一个需要开启的关卡
	local playerscene = LoadPlayerTable(PlayerSceneData,0)		--关卡，章节,评分,以及次数限制
	if playerscene == nil then
		OnInitPlayerScene(playerscene)
		playerscene = LoadPlayerTable(PlayerSceneData)		--关卡，章节,评分,以及次数限制
	end

	-- local currentsceneindex = playerscene.sceneindex
	 rfalse("Open Task Scene TaskID  = "..taskID.."")
	if TaskTable[taskID].taskscene ~= nil then
		for k,v in pairs(TaskTable[taskID].taskscene) do
			ServerCompleteScene(playerscene.scenemap,v)
		end
	end
	return nil
end

function  CheckIsOpenScene(sceneindex) --检测是否打开下一个关卡
	for k,v in pairs(TaskTable) do
		local status = GetTaskStatus(k)
		if status == TS_ACCEPTED then
			if TaskTable[k].taskscene ~= nil then
				local lenth = GetTableLenth(TaskTable[k].taskscene)
				local tasksceneindex = TaskTable[k].taskscene[lenth]
				if tasksceneindex > sceneindex then
					return true
				end
			end
		end
	end
	return false
end

function OpenSceneOneByOne(scenemap,sceneindex)   --打开下一个关卡
	local playerscene = LoadPlayerTable(PlayerSceneData,0)		--关卡，章节,评分,以及次数限制
	if playerscene == nil then
		OnInitPlayerScene(playerscene)
		playerscene = LoadPlayerTable(PlayerSceneData)		--关卡，章节,评分,以及次数限制
	end

	if playerscene.point[scenemap] ~= nil then 				--章节评分
		if sceneindex == playerscene.sceneindex then
			if sceneindex + 1 > SceneIndexNum[scenemap] then 															--当前章节关卡结束
				if SceneIndexNum[scenemap + 1] ~= nil then 	
					if scenemap + 1 > playerscene.scenemap then 									--章节检测
						playerscene.scenemap = 	scenemap + 1													--取得下一章节
						playerscene.sceneindex = 1   													--可以进入下一章节
						playerscene.point[scenemap + 1] = {0}														--下一关卡得分
						playerscene.limitSD[scenemap + 1] = {SCENE_LIMITTIMES} 											--下一关卡剩余扫荡次数
						playerscene.limitcommon[scenemap + 1] = {SCENE_LIMITTIMES}									--下一关卡剩余普通闯关次数
						rfalse("enter next scenemap = "..scenemap + 1)
					end
				else
					rfalse("next scenemap nil")
					return
				end
			else
				playerscene.sceneindex = playerscene.sceneindex + 1   													--可以进入下一关卡
				playerscene.point[scenemap][sceneindex + 1] = 0 														--下一关卡得分
				playerscene.limitSD[scenemap][sceneindex + 1] = SCENE_LIMITTIMES 										--下一关卡剩余扫荡次数
				playerscene.limitcommon[scenemap][sceneindex + 1] = SCENE_LIMITTIMES 									--下一关卡剩余普通闯关次数
				rfalse("OpenSceneOneByOne Index = "..(sceneindex + 1).."")
			end								
		end
	end
	WeekReturnChargeData(PlayerSceneData,playerscene,0)			--保存关卡，章节,次数限制
end


function GetVIPSDDecreaseTime(playergid,Playersdtime)  --返回VIP扫荡时间
	local viplevel = GetPlayerData(playergid,GPP_VIPLEVEL)
	if viplevel ~= nil then
		viplevel = viplevel + 1
		if viplevel > 0 then
			if VIPSCENESD ~= nil then
				if VIPSCENESD[viplevel] ~= nil then
					local vipsdtime = Playersdtime * VIPSCENESD[viplevel]
					Playersdtime = Playersdtime - vipsdtime 
				end
			end
		end
	end
	return Playersdtime
end

function GetVIPIncrease(playergid,IncreaseValue)
	local viplevel = GetPlayerData(playergid,GPP_VIPLEVEL)
	if viplevel ~= nil then
		viplevel  = viplevel + 1
		if viplevel > 0 then
			if VIPSCENEREWAED ~= nil and VIPSCENEREWAED[viplevel] ~= nil then
				IncreaseValue = IncreaseValue + IncreaseValue * VIPSCENEREWAED[viplevel]
			end
		end
	end
	return IncreaseValue
end