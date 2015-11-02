--军团副本相关
FACTION_SCENE_RESETTIME = 5    --军团副本重置时间
local PlayerFactionData = nil
local PLAYERFACTIONDATANAME = tostring("FactionData")
function OnRequestTurnOnScene( sid ,btype,sceneID) --当同步申请开启副本,类型,副本ID
	
	local PlayerFactionID = GetPlayerDataSG(sid,10)
	if PlayerFactionID == 0 then 
		look(" Player No Faction")
		return
	end

	local FactionInfo = GetFactionInfoByID(PlayerFactionID)
	if FactionInfo == nil then
		look(" GetFactionInfoByID Faile")
		return
	end

	local PlayerName = GetPlayerDataSG(sid,4)

	if btype == 1 then  --新开
		if FactionSceneMap[sceneID] == nil then
			look(" GetFactionFactionSceneMap Faile")
			return
		end
		local SceneInfo = FactionSceneMap[sceneID]
		local bisactive = 1

		if FactionInfo.SceneStatus ~= nil and FactionInfo.SceneStatus[sceneID] ~= nil then
			if FactionInfo.SceneStatus[sceneID].TurnOn == 0 then   --未开启	
				if FactionInfo.ActiveValue < SceneInfo.ActiveValue then
					look(" ActiveValue Faile")
					bisactive = 0
					return
				end

				if SceneInfo.LimitContorl ~= nil and #SceneInfo.LimitContorl > 0 then
					for i,v in ipairs(SceneInfo.LimitContorl) do      --关卡前置限制
						if FactionInfo.SceneStatus[v].SceneClear == nil or FactionInfo.SceneStatus[v].SceneClear == 0 then
							look(" LimitContorl ClearStatus == 0  active faile")
							bisactive = 0
							break
						end
					end
				end

				if SceneInfo.LimitLevel ~= nil then
					if FactionInfo.FactionLevel < SceneInfo.LimitLevel then
						look(" LimitLevel active faile need "..SceneInfo.LimitLevel)
						bisactive = 0
					end
				end 

				if FactionInfo.CreatePlayerName ~= PlayerName then
					look(" You are not CreateFaction")
					bisactive = 0
				end

				

				if FactionInfo.ScOpenCountToday > FactionMapOpenCount[FactionInfo.FactionLevel] then  --军团副本开启每天最大数量
					look(" OpenCountToday MAX  "..FactionInfo.ScOpenCountToday)
					bisactive = 0
					--return
				end

				if FactionInfo.ScAllCountToday > FactionMapAllCount[FactionInfo.FactionLevel] then  --军团副本开启最大数量
					look(" OpenAllCount MAX "..FactionInfo.ScAllCountToday)
					bisactive = 0
					--return
				end

				if bisactive == 1 then
					FactionInfo.ActiveValue = FactionInfo.ActiveValue - SceneInfo.ActiveValue
					FactionInfo.SceneStatus[sceneID].TurnOn = 1
					FactionInfo.ScOpenCountToday = FactionInfo.ScOpenCountToday + 1
					FactionInfo.ScAllCountToday = FactionInfo.ScAllCountToday + 1

					if FactionInfo.HurtRank == nil then
						FactionInfo.HurtRank = {}
					end

					if FactionInfo.HurtRank[sceneID] == nil then
						FactionInfo.HurtRank[sceneID] = {}
					end

					OnAddFactionLog(PlayerFactionID,FACTIONOPERATE.SCENEOPEN,0,sceneID)

				end
			end
		end
	end

	OnUpdateSceneData(sid)
	
	local FactionScene = {}
	FactionScene.ActiveValue = FactionInfo.ActiveValue    --活跃度
	FactionScene.scenelist= {}
	
	for k,v in pairs(FactionInfo.SceneStatus) do
		local temp  = 
		{
			sceneID = k,
			stauts = CovertSceneStatus(v.TurnOn,v.ClearStatus),
			scenemapcount = v.scenemapCount
		}
		table.insert(FactionScene.scenelist,temp)
	end
	look("OnRequestTurnOnScene")
	FactionInfo.ProperyChange = 1
	--look(FactionScene.scenelist)
	SendFactionSceneList(sid,FactionScene.ActiveValue,FactionInfo.ScOpenCountToday,FactionScene.scenelist)

end

function CovertSceneStatus( TurnOn,ClearStatus) --军团副本状态
	if TurnOn == 0 and ClearStatus == 0 then
		return 0
	elseif TurnOn == 0 and ClearStatus == 1 then
		return 1
	elseif TurnOn == 1 and ClearStatus == 0 then
		return 2
	elseif TurnOn == 1 and ClearStatus == 1 then
		return 3
	end
	return nil
end

function OnRequestSceneInfo( sid,sceneID ) --请求副本中关卡信息

	if CheckFactionSceneData(sid,sceneID) == false then
		return
	end
	OnUpdateSceneData(sid)

	local PlayerName = GetPlayerDataSG(sid,4)
	local PlayerFactionID = GetPlayerDataSG(sid,10)
	local FactionInfo = GetFactionInfoByID(PlayerFactionID)
	local memberinfo = GetMemberInfoFromFaction(PlayerFactionID,PlayerName,1)
	if memberinfo == nil then
		look(" GetMemberInfoFromFaction Faile")
		return
	end

	if FactionInfo.SceneStatus[sceneID].TurnOn == 0 then
		look(" SceneStatus[sceneID].Turnoff")
		return
	end


	local scenemaplist = {}
	local scenemap = FactionInfo.SceneStatus[sceneID].scenemap
	if GetTableNLenth(scenemap) == 0 then
		for k,v in pairs(FactionSceneMap[sceneID]) do
			if type(k) == "number" and type(v) == "table" then
				local temp = 
				{
					MonsterID =  v.BossInfo[1],   --怪物BOSSID
					scenemapindex = k, 			  --关卡索引
					stauts = 0,   				  --关卡状态
					BossAllHP = v.BossInfo[2],    --BOSS总血量
					BossHP = v.BossInfo[2], 	  --BOSS当前血量
				}
				table.insert(scenemap,temp)
			end
		end
	end
	--look("count"..memberinfo.ChallengeCount.."   sceneID "..sceneID)
	--look(scenemap)
	SendSceneInfo(sid,memberinfo.ChallengeCount,sceneID,scenemap) 

end

function CheckFactionSceneData( sid,sceneID ) --检查军团关卡以及关卡的安全性
	local PlayerFactionID = GetPlayerDataSG(sid,10)
	if PlayerFactionID == 0 then 
		look(" Player No Faction")
		return false
	end

	local FactionInfo = GetFactionInfoByID(PlayerFactionID)
	if FactionInfo == nil then
		look(" GetFactionInfoByID Faile")
		return false
	end

	if FactionInfo.SceneStatus == nil or FactionInfo.SceneStatus[sceneID] == nil  then
		look(" FactionInfoSceneStatus Faile")
		return false
	end

	if FactionSceneMap == nil or FactionSceneMap[sceneID] == nil then
		look(" FactionSceneMap nil")
		return false
	end
	return true
end

function GM_OpenAllSceneMap( sid ) --打开全部副本
	look("GM_OpenAllSceneMap  "..sid)
	local PlayerFactionID = GetPlayerDataSG(sid,10)
	if PlayerFactionID == 0 then 
		look(" Player No Faction")
		return
	end

	local FactionInfo = GetFactionInfoByID(PlayerFactionID)
	if FactionInfo == nil then
		look(" GetFactionInfoByID Faile")
		return
	end

	if FactionInfo.HurtRank == nil then
		FactionInfo.HurtRank = {}
	end


	if FactionSceneMap ~= nil then
		for k,v in pairs(FactionSceneMap) do
			FactionInfo.SceneStatus[k].TurnOn = 1
			if FactionInfo.HurtRank[k] == nil then
				FactionInfo.HurtRank[k] = {}
			end
		end
	end

	FactionInfo.ProperyChange = 1
end

function OnChallengeSceneMap(sid,sceneID, scenemapIndex) --挑战关卡，副本ID，关卡索引

	if CheckFactionSceneData(sid,sceneID) == false then
		return
	end

	local bsucess = 1
	local PlayerName = GetPlayerDataSG(sid,4)
	local PlayerFactionID = GetPlayerDataSG(sid,10)
	local PlayerLevel = GetPlayerDataSG(sid,3)
	local FactionInfo = GetFactionInfoByID(PlayerFactionID)

	if FactionInfo.SceneStatus[sceneID].TurnOn == 0 then
		look(" SceneStatus[sceneID].Turnoff")
		bsucess = 0
	end

	if FactionInfo.SceneStatus[sceneID].ClearStatus == 1 then
		look("sceneID "..sceneID.."   was ClearStatus already")
		bsucess = 0
	end

	if PlayerLevel < FactionSceneMap[sceneID].LimitPlayerLevel then
		look("PlayerLevel Limit "..FactionSceneMap[sceneID].LimitPlayerLevel)
		bsucess = 0
	end

	local scenemap =  FactionInfo.SceneStatus[sceneID].scenemap
	for k,v in pairs(scenemap) do
		if v.scenemapindex == scenemapIndex then
			if v.stauts == 1 then  							--判断是否已经通关
				bsucess = 0
			end
			break
		end
	end
	


	local memberinfo = GetMemberInfoFromFaction(PlayerFactionID,PlayerName,1)
	if memberinfo == nil then
		look(" GetMemberInfoFromFaction Faile")
		bsucess = 0
		--return
	end



	if memberinfo.ChallengeCount > FactionMemberCount then
		look(" ChallengeCount MAX")
		bsucess = 0
		--return
	end

	if bsucess > 0 then
		memberinfo.ChallengeSceneMap ={sceneID,scenemapIndex}   --记录挑战关卡和index
	end

	SendChallengeSceneMsg(sid,bsucess, FactionSceneMap[sceneID][scenemapIndex].BossInfo[1])
end

function OnChallengeFinish( sid,HurtValue ) --关卡挑战完成，发送伤害量
	local PlayerFactionID = GetPlayerDataSG(sid,10)
	local PlayerName = GetPlayerDataSG(sid,4)
	if PlayerFactionID == 0 then 
		look(" Player No Faction")
		return false
	end

	local FactionInfo = GetFactionInfoByID(PlayerFactionID)
	if FactionInfo == nil then
		look(" GetFactionInfoByID Faile")
		return false
	end

	local sceneID = 0
	local scenemapIndex = 0

	local memberinfo = GetMemberInfoFromFaction(PlayerFactionID,PlayerName,1)
	if memberinfo == nil then
		look(" GetMemberInfoFromFaction Faile")
		return
	end

	if memberinfo.ChallengeSceneMap ~= nil then
		sceneID = memberinfo.ChallengeSceneMap[1]
		scenemapIndex =  memberinfo.ChallengeSceneMap[2]
		memberinfo.ChallengeSceneMap[1] = 0
		memberinfo.ChallengeSceneMap[2] = 0
	end

	memberinfo.ChallengeCount = memberinfo.ChallengeCount - 1
	if memberinfo.ChallengeCount < 0 then
		memberinfo.ChallengeCount = 0
	end

	
	local scenemapclear = 1
	if sceneID > 0 and scenemapIndex > 0 then
		local scenemap = FactionInfo.SceneStatus[sceneID].scenemap
		for k,v in pairs(scenemap) do
			if v.scenemapindex == scenemapIndex then
				v.BossHP = v.BossHP - HurtValue
				if v.BossHP <= 0 and v.stauts == 0 then
					v.stauts = 1 			--状态为已经通关
					v.BossHP = 0
					FactionInfo.SceneStatus[sceneID].scenemapCount = FactionInfo.SceneStatus[sceneID].scenemapCount + 1
					DropEquipment(FactionInfo,sceneID,scenemapIndex)
					break
				end
			end
		end

		--memberinfo.HurtValue[sceneID] = memberinfo.HurtValue[sceneID] + HurtValue
		OnUpdatePlayerHurt(sid,sceneID,HurtValue)

		if FactionInfo.SceneStatus[sceneID].scenemapCount == #scenemap then  --全部通关
			FactionInfo.SceneStatus[sceneID].ClearStatus = 1 
			if FactionInfo.SceneStatus[sceneID].SceneClear == nil then   --当前通关状态，上一个状态将会被重置。这个会保存
				FactionInfo.SceneStatus[sceneID].SceneClear = 1
			end
			SendFactionReward(sceneID,PlayerFactionID)   
			OnAddFactionLog(PlayerFactionID,FACTIONOPERATE.SCENEPASS,0,sceneID)
		end
		FactionInfo.ProperyChange = 1
		-- if scenemapclear == 1 then  --副本通关,发送奖励
		-- 	FactionInfo.SceneStatus[sceneID].ClearStatus = 1 
		-- 	SendFactionReward(sceneID,PlayerFactionID)          
		-- end
	end
end

function OnChangeNameInSceneHurt( sid,oldName, newName )
	local PlayerFactionID = GetPlayerDataSG(sid,10)
	local FactionInfo = GetFactionInfoByID(PlayerFactionID)
	local bupdate = 0
	if FactionInfo.HurtRank == nil then
		return
	end

	for k,v in pairs(FactionInfo.HurtRank) do
		for i,j in ipairs(v) do
			if j.MemberName == oldName then
				j.MemberName = newName
				bupdate = 1
				break
			end
		end
	end
	if bupdate == 1 then
		FactionInfo.ProperyChange = 1
	end
end

function OnUpdatePlayerHurt(sid,sceneID,HurtValue) --更新玩家伤害输出
	if CheckFactionSceneData(sid,sceneID) == false then
		return
	end

	local PlayerName = GetPlayerDataSG(sid,4)
	local PlayerFactionID = GetPlayerDataSG(sid,10)
	local FactionInfo = GetFactionInfoByID(PlayerFactionID)

	if FactionInfo.HurtRank == nil then
		FactionInfo.HurtRank = {}
	end
	if FactionInfo.HurtRank[sceneID] == nil then
		FactionInfo.HurtRank[sceneID] = {}
	end


	local bupdate = 0
	for i,v in ipairs(FactionInfo.HurtRank[sceneID]) do
		if v.MemberName == PlayerName then
			v.MemberHurt = v.MemberHurt + HurtValue
			bupdate = 1
			break
		end
	end

	local Temp = 
	{
		MemberName = PlayerName,
		MemberHurt = HurtValue,
		RewardNum = 0,
	}
	if bupdate == 0 then
		table.insert(FactionInfo.HurtRank[sceneID],Temp)
	end

	table.sort( FactionInfo.HurtRank[sceneID], function(t1,t2)return t1.MemberHurt > t2.MemberHurt end )

	for i,v in ipairs(FactionInfo.HurtRank[sceneID]) do
		if v.MemberName == PlayerName then
			v.RewardNum = GetFactionSceneRewardNum(sceneID,i)
			break
		end
	end
	FactionInfo.ProperyChange = 1
end

function GetFactionHurtRank( sid,sceneID ) --获取军团伤害排名
	local PlayerFactionID = GetPlayerDataSG(sid,10)
	local PlayerName = GetPlayerDataSG(sid,4)
	if PlayerFactionID == 0 then 
		look(" Player No Faction")
		return 
	end

	local FactionInfo = GetFactionInfoByID(PlayerFactionID)
	if FactionInfo == nil then
		look(" GetFactionInfoByID Faile")
		return 
	end

	if FactionSceneMap[sceneID] == nil then   --这里判断副本是否存在
		look(" FactionSceneMap Faile")
		return 
	end

	if FactionInfo.HurtRank == nil then   --玩家打开副本时可能就会去点击一次排行榜，如果没有就创建一个
		FactionInfo.HurtRank = {}
	end

	if FactionInfo.HurtRank[sceneID] == nil then
		FactionInfo.HurtRank[sceneID] = {}
	end

	local Ranknumber,HurtValue = GetPlayerHurtRank(sceneID,PlayerFactionID,PlayerName)
	local PlayerRank = {}
	PlayerRank.Rank = Ranknumber
	PlayerRank.RewardNum = GetFactionSceneRewardNum(sceneID,Ranknumber)
	PlayerRank.NextRank = GetPlayerNextRange(sceneID,Ranknumber)
	PlayerRank.HurtValue = HurtValue

	if PlayerRank.NextRank  == nil then
		PlayerRank.NextRank = 255
	end
	--look(PlayerRank)
	SendFactionSceneRank(sid,FactionInfo.HurtRank[sceneID],PlayerRank)

end

function GetPlayerNextRange(sceneID,rank) --获取下一阶段排名相差
	local currentrange = 0
	if FactionSceneMap[sceneID] ~= nil then
		if FactionSceneMap[sceneID].itemlist ~= nil then
			local itemlist = FactionSceneMap[sceneID].itemlist
			currentrange = #itemlist + 1
			for i,v in ipairs(itemlist) do
				if rank >= v.range[1] and rank <= v.range[2] then
					currentrange = i 
					break
				end
			end

			if currentrange == 1 then --已经是第一阶段
				return 0
			else
				if currentrange > 0  and currentrange - 1 > 0 then
					if itemlist[currentrange - 1] ~= nil then
						if rank > 0 then
							return rank - itemlist[currentrange-1].range[2]
						else
							return itemlist[currentrange-1].range[2] - rank
						end
					end
				end
			end
		end
	end
	return nil
end

function GetFactionSceneRewardNum(sceneID,rank) --获取排名奖励
	if FactionSceneMap[sceneID] ~= nil then
		if FactionSceneMap[sceneID].itemlist ~= nil then
			for i,v in ipairs(FactionSceneMap[sceneID].itemlist) do
				if rank >= v.range[1] and rank <= v.range[2] then
					return v.reward[2]
				end
			end
		end
	end
	return 0
end



function GetPlayerHurtRank(sceneID,FactionID,sMemberName) --获取玩家军团伤害排名
	local FactionInfo = GetFactionInfoByID(FactionID)

	if FactionInfo == nil then
		look("GetPlayerHurtRank FactionInfo nil")
		return
	end

	if FactionInfo.HurtRank == nil or FactionInfo.HurtRank[sceneID] == nil then
		look("GetPlayerHurtRank FactionInfo.HurtRank  nil ")
		return
	end

	for i,v in ipairs(FactionInfo.HurtRank[sceneID]) do
		if v.MemberName == sMemberName then
			return i,v.MemberHurt
		end
	end

	return 0,0
end


function OnUpdateSceneData(sid) --更新军团当前副本数据
	local PlayerName = GetPlayerDataSG(sid,4)
	local PlayerFactionID = GetPlayerDataSG(sid,10)
	if PlayerFactionID == 0 then 
		look(" Player No Faction")
		return false
	end


	local FactionInfo = GetFactionInfoByID(PlayerFactionID)
	if FactionInfo == nil then
		look(" GetFactionInfoByID Faile")
		return false
	end

	local memberinfo = GetMemberInfoFromFaction(PlayerFactionID,PlayerName,1)

	local nowtime = os.date("*t",os.time())
	local bIsreset = 0

	if FactionInfo.ResetTime == nil then --重置时间
		if nowtime.hour >= FACTION_SCENE_RESETTIME then
			bIsreset = 1
		end
	else
		local resetday = tonumber(os.date("%Y%m%d",FactionInfo.ResetTime))	
		local nowday = tonumber(os.date("%Y%m%d",os.time()))	
		local resethour = os.date("*t",FactionInfo.ResetTime).hour
		if nowday > resetday then
			bIsreset = 1
		else
			if resethour < FACTION_SCENE_RESETTIME and nowtime.hour >= FACTION_SCENE_RESETTIME  then
				bIsreset = 1
			end
		end
	end

	if bIsreset == 1 then
		FactionInfo.ScOpenCountToday = 0    --副本每日开启数量
		FactionInfo.ResetTime = os.time()
		FactionInfo.EmailSendCount = 0  --军团邮件发送次数
		FactionInfo.ProperyChange = 1
		for k,v in pairs(FactionInfo.SceneStatus) do
			if FactionInfo.SceneStatus[k].ClearStatus == 1 then --关卡处于通过状态
				FactionInfo.ScAllCountToday = FactionInfo.ScAllCountToday - 1   --副本开启的总数量
				FactionInfo.SceneStatus[k].TurnOn = 0    --关闭关卡
				FactionInfo.SceneStatus[k].ClearStatus = 0  --清除通关
				FactionInfo.SceneStatus[k].scenemapCount = 0    --当前副本关卡通关数量	
				if FactionInfo.HurtRank ~= nil then  		--清除伤害排行
					if FactionInfo.HurtRank[k] ~= nil then
						FactionInfo.HurtRank[k] = {}
					end
				end

				local scenemap = FactionInfo.SceneStatus[k].scenemap
				scenemap = {}  										--关卡数据直接清除
				for m,n in pairs(FactionSceneMap[k]) do
					if type(m) == "number" and type(n) == "table" then
						local temp = 
						{
							MonsterID =  n.BossInfo[1],   --怪物BOSSID
							scenemapindex = m, 			  --关卡索引
							stauts = 0,   				  --关卡状态
							BossAllHP = n.BossInfo[2],    --BOSS总血量
							BossHP = n.BossInfo[2], 	  --BOSS当前血量
						}
						table.insert(scenemap,temp)
					end
				end
				look("Faction  "..PlayerFactionID.." SceneMap had Reset  "..k)
				RFalse(string.format("Faction:%d had Reset",PlayerFactionID))
			end
		end
	end
	
	local bIsresetmember = 0      --重置成员数据
	if memberinfo ~= nil then
		PlayerFactionData = LoadLuaData(sid,PLAYERFACTIONDATANAME)  --俸禄领取数据初始化
		if PlayerFactionData == nil then
			look("PlayerFactionData == nil when UpdateFactionSalary")
		end
		
		--if memberinfo.ResetTime == nil then --关卡重置时间
		if PlayerFactionData.SalaryResetTime == nil then
			if nowtime.hour >= FACTION_SCENE_RESETTIME then
				bIsresetmember = 1
			end
		else
			--local resetday = tonumber(os.date("%Y%m%d",memberinfo.ResetTime))
			local resetday = tonumber(os.date("%Y%m%d", PlayerFactionData.SalaryResetTime))
			local nowday = tonumber(os.date("%Y%m%d",os.time()))	
			--local resethour = os.date("*t",memberinfo.ResetTime).hour
			local resethour = os.date("*t", PlayerFactionData.SalaryResetTime).hour
			if nowday > resetday then
				bIsresetmember = 1
			else
				if resethour < FACTION_SCENE_RESETTIME and nowtime.hour >= FACTION_SCENE_RESETTIME  then
					bIsresetmember = 1
				end
			end
		end

		if bIsresetmember == 1 then
			PlayerFactionData.IsGotSalary = 0
			PlayerFactionData.SalaryResetTime = os.time()
			SaveLuaData(sid,PLAYERFACTIONDATANAME,PlayerFactionData)

			memberinfo.LastActiveValue = 0   --清理昨天的活跃度
			memberinfo.ChallengeCount = FactionMemberCount  --军团成员每日挑战次数
			FactionInfo.ProperyChange = 1
			--memberinfo.ResetTime = os.time()
			look("Faction Member Data Reset :"..sid)
		end
	end
end




function OnGetFactionSalary(sid,btype) -- 当玩家领取
	local PlayerName = GetPlayerDataSG(sid,4)
	local PlayerFactionID = GetPlayerDataSG(sid,10)
	local PlayerGold = GetPlayerDataSG(sid,2)
	if PlayerFactionID == 0 then 
		look(" Player No Faction")
		return false
	end
	local IsGotSalary = 1
	local bResult = 0

	PlayerFactionData = LoadLuaData(sid,PLAYERFACTIONDATANAME)
	if PlayerFactionData == nil then  --这里首先会获取配置，不应该是nil
		look("PlayerFactionData == nil  ")
		return
	end
	IsGotSalary = PlayerFactionData.IsGotSalary


	-- local memberinfo = GetMemberInfoFromFaction(PlayerFactionID,PlayerName,1)
	-- if memberinfo ~= nil then
	-- 	if memberinfo.IsGotSalary == nil then   --这里首先会获取配置，不应该是nil
	-- 		look("memberinfo.IsGotSalary == nil  ")
	-- 		return
	-- 	end
	-- 	IsGotSalary = memberinfo.IsGotSalary
	-- end

	if IsGotSalary == 0 then
		if FactionSalaryConfig[btype] ~= nil then
			if PlayerGold < FactionSalaryConfig[btype].CostGold then
				bResult = 2
			end

			if bResult == 0 then
				CI_DecGoods_SG(2,0,FactionSalaryConfig[btype].CostGold)
				local itemlist = FactionSalaryConfig[btype].itemlist
				for i=1,#itemlist/3 do
					local itype = i * 3 - 2
					local id = itype + 1
					local num = id+1
					if itemlist[itype] == GoodsType.token then --军需令
						ChangePlayerFactionMoney(sid,itemlist[num])
					else
						if CI_AddGoods_SG(itemlist[itype],itemlist[id],itemlist[num],0,sid) == nil then
							look("OnGetFactionSalary AddItem Faile  "..itemlist[id].."     "..itemlist[num])
						end	
					end
				end
				 PlayerFactionData.IsGotSalary = 1
				 SaveLuaData(sid,PLAYERFACTIONDATANAME,PlayerFactionData)
				 bResult = 1
				 ChangeFactionActive(PlayerFactionID,FactionSalaryConfig[btype].ActivityValue)  --改变活跃度
				 ChangeFactionExp(PlayerFactionID,FactionSalaryConfig[btype].FactionExp) --改变军团经验
				 OnShowFactioninfo(sid)
				 OnAddFactionLog(PlayerFactionID,FACTIONOPERATE.GOTSALARY,PlayerName,btype) --俸禄领取日志
			end

		end
	else
		bResult = 3     --IsGotSalary > 0 已经领取
	end
	if bResult == 0 then
		bResult = 4
	end
	SendGetSalaryResult(sid,bResult)
	--look("SendGetSalaryResult "..bResult)
end


function OnInitFactionSalary( sid ) --获取俸禄的配置
	--look("OnInitFactionSalary")
	local PlayerName = GetPlayerDataSG(sid,4)
	local PlayerFactionID = GetPlayerDataSG(sid,10)
	if PlayerFactionID == 0 then 
		look(" Player No Faction")
		return false
	end
	local IsGotSalary = 1
	OnUpdateSceneData(sid)
	PlayerFactionData = LoadLuaData(sid,PLAYERFACTIONDATANAME)
	if PlayerFactionData == nil then
		look("PlayerFactionData == nil")
		return
	end
		
	if PlayerFactionData.IsGotSalary == nil then
		PlayerFactionData.IsGotSalary = 0
	end
	SaveLuaData(sid,PLAYERFACTIONDATANAME,PlayerFactionData)
	--look(PlayerFactionData)
	
	IsGotSalary = PlayerFactionData.IsGotSalary

	look("SendFactionSalaryData "..IsGotSalary)
	SendFactionSalaryData(sid,FactionSalaryConfig,IsGotSalary)
end

function ShowSceneEquipment( sid ) --玩家查看副本中可以掉落的准备
	local FactionInfo = GetFactionInfoByPlayerSid(sid)
	local memberinfo = GetFactionMemberInfo(sid)
	if FactionInfo == nil  or memberinfo == nil then
		look("ShowSceneEquipment Faile   FactionInfo == nil ")
		return
	end
	if Faction_QuestEquipt ~= nil then
		local sendEquiptlist = {}
		for i,v in ipairs(Faction_QuestEquipt) do
			sendEquiptlist[i] = {}
			for j,k in ipairs(v) do
				local equiptnum = GetFactionEquipmentNum(FactionInfo,k)
				table.insert(sendEquiptlist[i],k)
				table.insert(sendEquiptlist[i],equiptnum)
			end
		end
		--look(sendEquiptlist)
		SendEquiptList(sid,memberinfo.RequestEquipment,sendEquiptlist)
	end
end

function RequestSceneEquipment(sid,elevle,EIndex) --玩家申请副本掉落的装备
	--look("RequestSceneEquipment")
	local FactionInfo = GetFactionInfoByPlayerSid(sid)
	local memberinfo = GetFactionMemberInfo(sid)
	local FactionID = GetPlayerDataSG(sid,10)
	local RequestStatus = 1
	local PlayerName = GetPlayerDataSG(sid,4)
	
	if elevle > #Faction_QuestEquipt or EIndex > #Faction_QuestEquipt[elevle] then
		look("RequestEquipment Faile   elevle:"..elevle.."   EIndex: "..EIndex)
		RequestStatus = 2
		SendRqEquiptResult(sid,2)
		return 2
	end

	local RequestEquipment =  Faction_QuestEquipt[elevle][EIndex]
	local questEquipmentnum = GetQuestEquipmentPepleNum(FactionID,RequestEquipment)
	look("RequestSceneEquipment  num "..questEquipmentnum.."   FactionInfo "..FactionInfo.FactionID)
	if questEquipmentnum < 0 then
		SendRqEquiptResult(sid,4)
		look("SendRqEquiptResult 4")
		return 4
	elseif questEquipmentnum >= FACTIONMAXQUESTNUM then
		SendRqEquiptResult(sid,3)
		look("SendRqEquiptResult 5")
		return 3
	end

	if  memberinfo ~= nil then
		if memberinfo.GotEquipmentTime > 0 then
			local difftime = os.difftime(os.time(),memberinfo.GotEquipmentTime)
			if difftime >= FACTIONEQUIPMENTCD then --超出冷却时间
				memberinfo.GotEquipmentTime = 0
				FactionInfo.ProperyChange = 1
			else
				look("can't GotEquipment In this Time")
				SendRqEquiptResult(sid,5)
				return 5
			end
		end

		if memberinfo.RequestEquipment > 0 then
			look("You had QuestEquipment allready "..memberinfo.RequestEquipment)
			SendRqEquiptResult(sid,6)
			return 6
		end

		memberinfo.RequestEquipment = RequestEquipment
		AddRequestEquipment(FactionID,sid,RequestEquipment)
		OnGotEquipment(FactionInfo,PlayerName,RequestEquipment)
		FactionInfo.ProperyChange = 1
		SendRqEquiptResult(sid,1)
		look("Player RequestEquipment "..RequestEquipment.."  sucessed ")
	end

end


function OnGotEquipment( FactionInfo,PlayerName,EquipmentIndex)
	if FactionInfo == nil then
		look("OnGotEquipment FactionInfo == nil ")
		return
	end
	local memberinfo = GetMemberInfoFromFaction(FactionInfo.FactionID,PlayerName,1)
	if FactionInfo.EquipmentDepot ~= nil then
		if FactionInfo.EquipmentDepot[EquipmentIndex] ~= nil then
			if FactionInfo.EquipmentDepot[EquipmentIndex] > 0 then
				if GetRequestPlayerRank(FactionInfo,PlayerName,EquipmentIndex) == 1 then --第一个申请
					if  memberinfo ~= nil then
						memberinfo.GotEquipmentTime = os.time()
						memberinfo.RequestEquipment = 0
						RemoveRequestEquipment(FactionInfo,EquipmentIndex,1)
						FactionInfo.EquipmentDepot[EquipmentIndex] = FactionInfo.EquipmentDepot[EquipmentIndex] - 1
						FactionInfo.ProperyChange = 1
						OnSendEmailWithGoods(MystringFormat("MAIL_FACTIONEQUIPT_SENDER"),PlayerName,MystringFormat("MAIL_FACTIONEQUIPT_TITLE"),
						MystringFormat("MAIL_FACTIONEQUIPT_CONTENT"),EquipmentIndex,1)
						OnAddFactionLog(FactionInfo.FactionID,FACTIONOPERATE.GOTEQUIPMENT,PlayerName,EquipmentIndex) --俸禄领取日志
						look("Player Got QuestEquipment "..EquipmentIndex)
					end
				end
			end
		end

	end
end

function GetFactionEquipmentNum( FactionInfo,EquipmentIndex ) --获取仓库中的装备数量
	if FactionInfo == nil then
		look("GetFactionEquipmentNum FactionInfo == nil ")
		return
	end
	if FactionInfo.EquipmentDepot ~= nil then
		if FactionInfo.EquipmentDepot[EquipmentIndex] == nil then
			FactionInfo.EquipmentDepot[EquipmentIndex] = 0
		end
		return FactionInfo.EquipmentDepot[EquipmentIndex]
	end
	return 0
end

function AddEquipToFaction( FactionInfo,EquipmentIndex,num )
	if FactionInfo ~= nil and FactionInfo.EquipmentDepot ~= nil then
		if GetFactionEquipmentNum(FactionInfo,EquipmentIndex) + num <= FACTIONEQUIPMAX then
			FactionInfo.EquipmentDepot[EquipmentIndex] = FactionInfo.EquipmentDepot[EquipmentIndex] + num
		else
			look("EquipmentDepot Full")
		end
	end
end

function DropEquipment( FactionInfo,sceneID, scenemapIndex) --BOSS死亡掉落装备
	look("DropEquipment "..sceneID.."  Index "..scenemapIndex)
	if FactionInfo ~= nil then
		if FactionSceneMap[sceneID] ~= nil and FactionSceneMap[sceneID][scenemapIndex] ~= nil then
			local scenemap = FactionSceneMap[sceneID][scenemapIndex]
			if scenemap.Equipment ~= nil  and scenemap.Random ~= nil then
				local randomcount = LuaRandRange(1,100)    --随机
				local Randommap = {}
				for i,v in ipairs(scenemap.Random) do
					if i > 1 then
						Randommap[i] = Randommap[i-1] + v
					else
						Randommap[i] = v
					end

					if randomcount <= Randommap[i] then
						randomcount = i
						break
					end
				end
				assert(randomcount <= #scenemap.Random,"DropEquipment randomcount ERROR")
				local  equipnum = #scenemap.Equipment
				for i=1,randomcount do
					local randomindex = LuaRandRange(1,equipnum) 
					AddEquipToFaction(FactionInfo,scenemap.Equipment[randomindex],1)
				end

				if FactionInfo.QuestEquipmentList ~= nil then
					for k,v in pairs(FactionInfo.QuestEquipmentList) do
						if GetFactionEquipmentNum(FactionInfo,k) > 0 then
							for i,j in ipairs(v) do
								OnGotEquipment(FactionInfo,j,k)
							end
						end
					end
				end

			end
		end
	end
end

function function_name( ... )
	-- body
end

function ShowRequestRank( sid,bCanceled ) --查看当前申请的队列名次
	local PlayerName = GetPlayerDataSG(sid,4)
	local FactionID = GetPlayerDataSG(sid,10)
	local FactionInfo = GetFactionInfoByPlayerSid(sid)
	local memberinfo = GetFactionMemberInfo(sid)
	local SRequestRank = {}
	if FactionInfo ~= nil and memberinfo ~= nil then
		local EquipmentIndex = memberinfo.RequestEquipment
		local PlayerRank = GetRequestPlayerRank(FactionInfo,PlayerName,EquipmentIndex)	
		if EquipmentIndex > 0 and PlayerRank > 0 then
			if bCanceled == 0 then  --查看队列
				local equiptnum = GetFactionEquipmentNum(FactionInfo,EquipmentIndex)
				if FactionInfo.QuestEquipmentList[EquipmentIndex] ~= nil then
					for i,v in ipairs(FactionInfo.QuestEquipmentList[EquipmentIndex]) do
						memberinfo = GetMemberInfoFromFaction(FactionID,v,1)
						if memberinfo ~= nil then
							PlayerRank = i
							local wHeadIcon = memberinfo.wHeadIcon
							local PlayerLevle = memberinfo.PlayerLevle
							local temp = {PlayerRank,wHeadIcon,PlayerLevle,v}
							table.insert(SRequestRank,temp)
						end
					end
					SendRequestStatus(sid,equiptnum,SRequestRank)
					--look("ShowRequestRank ")
					--look(SRequestRank)
				end
			end
			--look("111")
		end

	
		--RemoveFromTable()
	end
end

function PlayerCanceledQuest( sid ) --玩家取消申请
	local PlayerName = GetPlayerDataSG(sid,4)
	local FactionID = GetPlayerDataSG(sid,10)
	local FactionInfo = GetFactionInfoByPlayerSid(sid)
	local memberinfo = GetFactionMemberInfo(sid)
	if FactionInfo ~= nil and memberinfo ~= nil then
		local EquipmentIndex = memberinfo.RequestEquipment
		local PlayerRank = GetRequestPlayerRank(FactionInfo,PlayerName,EquipmentIndex)	
		if EquipmentIndex > 0 and PlayerRank > 0 then
			memberinfo.GotEquipmentTime = 0
			memberinfo.RequestEquipment = 0
			RemoveRequestEquipment(FactionInfo,EquipmentIndex,PlayerRank)
			FactionInfo.ProperyChange = 1
			SendCanceledResult(sid,1)
			look("Player Canceled RequestEquipment "..EquipmentIndex)
			return
		end
		SendCanceledResult(sid,2)
		look("Player Canceled Request:Can't found  RequestEquipment or Rank "..EquipmentIndex)
		return
	end
	SendCanceledResult(sid,3)
	look("Player Canceled Request Faile:FactionInfo ERROR ")
	return

end

local FuestEquipt = FACTIONEXPUPDATE
function testRemove()
	local random = FactionSceneMap[920000][1].Random
	local Randommap = {}
	local randomcount = LuaRandRange(1,100)    --随机
	for i,v in ipairs(random) do
		if i > 1 then
			Randommap[i] = Randommap[i-1] + v
		else
			Randommap[i] = v
		end

		if randomcount <= Randommap[i] then
			look("randomcount "..randomcount.."  found index "..i)
			randomcount = i
			break
		end

	end
	for i,v in ipairs(Randommap) do
		look(v)
	end
	
	-- for i,v in ipairs(FuestEquipt) do
	-- 	look(i.."   =   "..v)
	-- end
	-- table.remove(FuestEquipt,5)
	-- look(FuestEquipt)
end

