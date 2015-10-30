 -- QUESTFACTIONMAX = 1	--最多申请军团数量
 -- QUESTLISTMAX = 20      --军团最多接受的申请数量
 
--FACTIONMEMBERMAX = 50	
FACTION_GOLD = 500   --军团元宝
FACTION_MAIL_EXTIME = 60 * 24 * 2   --2天
FACTION_ACTIVE_RESETTIME = 7    --军团活跃度累计清理时间
--m_factionManager 

function CreateFaction( strFactionName,wFactionIcon, PlayerSid )
	local serverid = GetServerID()
	local PlayerFactionID = GetPlayerDataSG(PlayerSid,10)   --军团ID
	local PlayerGold = GetPlayerDataSG(PlayerSid,2)   --Ôª±¦
	local PlayerQFactionid = GetPlayerQuestFactionID(PlayerSid)

	if PlayerFactionID > 0 then
		look("Faction is "..PlayerFactionID)
		SendCreateFactionResult(PlayerSid,6)
		return 
	end

	if PlayerGold < FACTION_GOLD then
		SendCreateFactionResult(PlayerSid,2)
		return
	end

	if string.len(strFactionName) < 3 then
		look("strFactionName to short ")
		SendCreateFactionResult(PlayerSid,4)
		return 
	end

	if GetFactionIDByName(strFactionName) > 0 then
		look("strFactionName is Exist ")
		SendCreateFactionResult(PlayerSid,3)
		return 
	end

	if IsValidName(strFactionName) == true then
		SendCreateFactionResult(PlayerSid,5)
		return
	end
	local sCreatePlayerName = GetPlayerDataSG(PlayerSid,4)
	
	local cFactionInfo = CreateFactionInfo(strFactionName,wFactionIcon,sCreatePlayerName)
	if cFactionInfo == nil then
		look("CreateFactionInfo Faile")
		SendCreateFactionResult(PlayerSid,9)
		return
	end

	ZeroPlayerQuestFaction(PlayerSid)

	-- local PlayerQFactionList = GetPlayerQuestFactionList(PlayerSid)
	-- for i,v in ipairs(PlayerQFactionList) do
	-- 	if v[1] > 0 then
	-- 		if MemberIsInFaction(v[1],sCreatePlayerName,0) == true then
	-- 			RemoveJoinList(v[1],sCreatePlayerName)
	-- 		end
	-- 	end
	-- end

	-- if PlayerQFactionid > 0 then  --已经发送过申请，取消 
	-- 	if MemberIsInFaction(PlayerQFactionid,sCreatePlayerName,0) == true then
	-- 		RemoveJoinList(PlayerQFactionid,sCreatePlayerName)
	-- 	end
	-- 	UpdatePlayerQuestFactionID(PlayerSid,0,0)
	-- end

	CI_DecGoods_SG(2,0,FACTION_GOLD,GoodsWay.fanctionWar)

	-- cFactionInfo.RequestList = cFactionInfo.MemberList   --测试table
	-- cFactionInfo.RequestList[1].PlayerLevle = 88

	m_factionManager[cFactionInfo.FactionID] = {}
	m_factionManager[cFactionInfo.FactionID] = deepcopy(cFactionInfo)

	SetPlayerData(PlayerSid,10,cFactionInfo.FactionID)
	--CI_SetPlayerDataSG(PlayerSid,7,cFactionInfo.FactionID)         --设置工会ID
	look("CreateFaction Sucess")
	--look(m_factionManager[cFactionInfo.FactionID] )
	SendCreateFactionResult(PlayerSid,1)
	--SaveAllFaction() 
	SaveFactionData()  									--创建后保存一次
end

function GetFactionNum( ) --¾üÍÅÊýÁ¿
	local num = 0
	for k,v in pairs(m_factionManager) do
		num = num + 1
	end
	return num
end

function GetMaxFactionID( ) --获取服务器中最大的ID
	local tempid = 1
	for k,v in pairs(m_factionManager) do
		if tempid < k then
			tempid = k
		end
	end
	return tempid
end

function GetFactionID( ) --获取军团ID
	if GetTableNLenth(m_factionManager) == 0 then
		local FactionID = GetServerID() * 100 + GetTableNLenth(m_factionManager) + 1
		return FactionID
	else
		return GetMaxFactionID() + 1
	end
end

function GetFactionIDByName( strFactionName ) --¸通过名字查找
	if m_factionManager ~= nil then
		for k,v in pairs(m_factionManager) do
			if v.FactionName == strFactionName then
				return v.FactionID
			end
		end
	end
	return 0 
end

function GetFactionInfoByID( FactionID ) --
	if m_factionManager ~= nil then
		return m_factionManager[FactionID]
	end
	return nil
end

function GetFactionInfoByPlayerSid( PlayerSid ) 
	local PlayerFactionID = GetPlayerDataSG(PlayerSid,10)
	return GetFactionInfoByID(PlayerFactionID)
end

function CreateFactionMember( memberName,playerTitle )  --
	local playersid = GetPlayerSidByName(memberName)
	if playersid == 0 or playersid == nil then
		look("CreateFactionMember Player Not Found")
		return nil
	end
	local FactionMember = {}
	FactionMember.PlayerName = memberName
	FactionMember.Title = playerTitle 			--职位
	FactionMember.ChallengeCount = FactionMemberCount  --军团成员每日挑战次数
	FactionMember.ChallengeSceneMap = {0,0}  --军团成员每日正在挑战的关卡
	FactionMember.PlayerLevle = GetPlayerDataSG(playersid,3)  
	FactionMember.wFightPower = GetPlayerDataSG(playersid,8)	 
	FactionMember.wHeadIcon = GetPlayerDataSG(playersid,9) 
	FactionMember.FactionMoney = 0     --军团中的钱，军需令
	FactionMember.JoinTime = os.time()
	FactionMember.PlayerActiveValue = 0     --玩家军团的活跃度贡献值1周贡献值
	FactionMember.LastActiveValue = 0     --玩家当天活跃度贡献值
	FactionMember.RequestEquipment = 0  	--玩家申请的副本掉落装备
	FactionMember.GotEquipmentTime = 0  	--玩家申请装备得到的时间
	return FactionMember

end

function CreateFactionMemberForTest( memberName,playerTitle )  --测试用创建成员，不用实时获取成员信息
	local FactionMember = {}
	FactionMember.PlayerName = memberName
	FactionMember.Title = playerTitle 			--职位
	FactionMember.ChallengeCount = FactionMemberCount  --军团成员每日挑战次数
	FactionMember.ChallengeSceneMap = {0,0}  --军团成员每日正在挑战的关卡
	FactionMember.PlayerLevle = 10
	FactionMember.wFightPower = 999 
	FactionMember.wHeadIcon = 108  
	FactionMember.FactionMoney = 0     --军团中的钱，军需令
	FactionMember.JoinTime = os.time()
	FactionMember.PlayerActiveValue = 0     --玩家在军团的活跃度贡献值
	FactionMember.LastActiveValue = 0     --玩家当天活跃度贡献值
	FactionMember.RequestEquipment = 0  	--玩家申请的副本掉落装备
	FactionMember.GotEquipmentTime = 0  	--玩家申请装备得到的时间
	return FactionMember

end

function CreateFactionInfoForTest( strFactionName,wFactionIcon,strCreatePlayerName ) --测试用无须验证成员信息
	local FactionInfo = {}
	FactionInfo.FactionName = strFactionName
	FactionInfo.CreatePlayerName = strCreatePlayerName
	FactionInfo.MasterSid = 99999
	FactionInfo.FactionID = GetFactionID()
	FactionInfo.FactionIcon = wFactionIcon
	FactionInfo.CreateTime = os.time()
	FactionInfo.MemberNum = 1  			--成员数量
	FactionInfo.QuestJoinNum = 0        --申请的数量
	FactionInfo.FactionLevel = 1        --等级
	FactionInfo.Title = 8  				--职位
	FactionInfo.ProperyChange = 1 		--属性改变标志
	FactionInfo.ActiveValue = 0 		--军团活跃值
	FactionInfo.Exp = 0 				--军团经验值
	FactionInfo.SceneStatus = {} 		--副本开启状态
	if FactionSceneMap ~= nil then
		for k,v in pairs(FactionSceneMap) do
			FactionInfo.SceneStatus[k] = {}
			FactionInfo.SceneStatus[k].TurnOn = 0 			--是否开启
			FactionInfo.SceneStatus[k].ClearStatus = 0      --是否已经通关
			FactionInfo.SceneStatus[k].scenemap = {}     --当前副本关卡
		end
	end
	FactionInfo.ScOpenCountToday = 0    --副本每日开启数量
	FactionInfo.ScAllCountToday = 0    --副本当前开启总数量
	FactionInfo.RequestList = {}   --申请列表
	FactionInfo.MemberList = {}   --成员列表
	FactionInfo.KickInfo = {}     --被踢的成员列表
	FactionInfo.HurtRank = {}    --军团副本伤害排名
	FactionInfo.Notice = "Notice"  			--军团公告
	FactionInfo.ModifyNTime = 0  			--军团公告修改时间
	FactionInfo.FactionLog = {} 		--军团操作日志
	FactionInfo.EquipmentDepot = {}    --军团副本掉落的仓库
	FactionInfo.QuestEquipmentList= {}  --军团申请装备的队列
	FactionInfo.EmailSendCount = 0  --军团邮件发送次数
	--当前创建军团的人员默认创建为军团长
	local FactionMember = CreateFactionMemberForTest(strCreatePlayerName,1)
	if FactionMember == nil then
		return nil
	end
	table.insert(FactionInfo.MemberList,FactionMember)
	return FactionInfo
end


function CreateFactionInfo( strFactionName,wFactionIcon,strCreatePlayerName )
	local FactionInfo = {}
	FactionInfo.FactionName = strFactionName
	FactionInfo.CreatePlayerName = strCreatePlayerName
	FactionInfo.MasterSid = GetPlayerSidByName(strCreatePlayerName)
	FactionInfo.FactionID = GetFactionID()
	FactionInfo.FactionIcon = wFactionIcon
	--FactionInfo.CreateTime = os.date("*t", os.time())
	FactionInfo.CreateTime = os.time()
	FactionInfo.MemberNum = 1  			--成员数量
	FactionInfo.QuestJoinNum = 0        --申请的数量
	FactionInfo.FactionLevel = 1        --等级
	FactionInfo.Title = 8  				--职位
	FactionInfo.ProperyChange = 1 		--属性改变标志
	FactionInfo.ActiveValue = 0 		--军团活跃值
	FactionInfo.Exp = 0 				--军团经验值
	FactionInfo.SceneStatus = {} 		--副本开启状态
	if FactionSceneMap ~= nil then
		for k,v in pairs(FactionSceneMap) do
			FactionInfo.SceneStatus[k] = {}
			FactionInfo.SceneStatus[k].TurnOn = 0 			--是否开启，将在通关后固定时间重置
			FactionInfo.SceneStatus[k].ClearStatus = 0      --是否已经通关,将在通关后固定时间重置
			FactionInfo.SceneStatus[k].scenemapCount = 0    --当前副本关卡通关数量
			FactionInfo.SceneStatus[k].scenemap = {}     --当前副本关卡
		end
	end
	FactionInfo.ScOpenCountToday = 0    --副本每日开启数量
	FactionInfo.ScAllCountToday = 0    --副本当前开启总数量
	FactionInfo.RequestList = {}   --申请列表
	FactionInfo.MemberList = {}   --成员列表
	FactionInfo.KickInfo = {}     --被踢的成员列表
	FactionInfo.HurtRank = {}    --军团副本伤害排名
	FactionInfo.Notice = ""  			--军团公告
	FactionInfo.ModifyNTime = 0  			--军团公告修改时间
	FactionInfo.FactionLog = {} 		--军团操作日志
	FactionInfo.EquipmentDepot = {}    --军团副本掉落的仓库
	FactionInfo.QuestEquipmentList= {}  --军团申请装备的队列
	FactionInfo.EmailSendCount = 0  --军团邮件发送次数

	--当前创建军团的人员默认创建为军团长
	local FactionMember = CreateFactionMember(strCreatePlayerName,FACTIONDUTY[4])
	if FactionMember == nil then
		return nil
	end
	look("CreateFactionMember ")
	--look(FactionMember)
	table.insert(FactionInfo.MemberList,FactionMember)
	return FactionInfo
end

function IsValidName( strFactionName )
	return false
end


function Printfaction(  )
	look(m_factionManager)
	--look(m_factionManager[100100001][1])
	--local ilenth = GetTableNLenth(m_factionManager)
	--look(ilenth)
	-- for k,v in pairs(m_factionManager[100100001]) do
	-- 	if type(v) == "table" then
	--  		look(v)
	--  	end
	-- end
	
	
end


function MemberIsExist( MemberInfo,MemberName )
	--look("MemberIsExist ")
	for k,v in pairs(MemberInfo) do
		if v.PlayerName == MemberName then
			return true,k
		end
	end
	return false
end

function MemberIsInFaction( FactionID, MemberName,membersouce) --是否有该成员,0 申请表 1 成员表
	--look("MemberIsInFaction")
	if m_factionManager[FactionID] ~= nil then
		if membersouce == 0 then
			return	MemberIsExist(m_factionManager[FactionID].RequestList,MemberName) 
		elseif membersouce == 1 then
			return	MemberIsExist(m_factionManager[FactionID].MemberList,MemberName) 
		end
	end
	return false
end

function RemoveMemberList( FactionID,MemberName ) --移除现有军团成员
	if m_factionManager[FactionID] ~= nil then
		local Isexist,mPos = MemberIsExist(m_factionManager[FactionID].MemberList,MemberName)
		if Isexist == true and mPos ~= nil  then
			table.remove(m_factionManager[FactionID].MemberList,mPos)
			m_factionManager[FactionID].MemberNum = m_factionManager[FactionID].MemberNum - 1
			m_factionManager[FactionID].ProperyChange = 1
			return true
		end
	end
	return false
end

function RemoveJoinList( FactionID,MemberName ) --移除申请列表中的成员
	if m_factionManager[FactionID] ~= nil then
		local Isexist,mPos = MemberIsExist(m_factionManager[FactionID].RequestList,MemberName)
		if Isexist == true and mPos ~= nil  then
			table.remove(m_factionManager[FactionID].RequestList,mPos)
			m_factionManager[FactionID].QuestJoinNum = m_factionManager[FactionID].QuestJoinNum - 1
			m_factionManager[FactionID].ProperyChange = 1
			return true
		end
	end
	return false
end


function GetPlayerQuestFactionList( PlayerSid ) --获取存储于玩家的申请列表
	local PlayerQFactionList = LoadLuaData(PlayerSid,"QFactionList")
	if PlayerQFactionList ~= nil and PlayerQFactionList ~= 0 then
		if PlayerQFactionList.QuitInfo == nil then
			local questinfo = {0,0}  --直接插入空数据
			for i=1,QUESTFACTIONMAX do
				table.insert(PlayerQFactionList,deepcopy(questinfo))
			end
			PlayerQFactionList.QuitInfo = {0,0,0}
		end
	end
	return PlayerQFactionList
end

function GetPlayerQuestFactionID( PlayerSid) --获取请求的军团ID ，现在第一个有效
	local PlayerQFactionList = GetPlayerQuestFactionList(PlayerSid)
	if GetTableNLenth(PlayerQFactionList) > 0 then
		for i,v in ipairs(PlayerQFactionList) do
			return v[1]
		end 
	end
	return 0
end


function GetFactionMasterName( FactionID ) --获取军团长名字
	if m_factionManager[FactionID] ~= nil then
		return m_factionManager[FactionID].CreatePlayerName
	end
	return 0
end

function SaveQuestFactionList( PlayerSid,QFactionList ) --保存玩家的申请列表
	SaveLuaData(PlayerSid,"QFactionList",QFactionList)

	-- if dbMgr[PlayerSid]==nil or  dbMgr[PlayerSid].data==nil then 
	-- 	return
	-- end
	-- if dbMgr[PlayerSid].data['QFactionList'] == nil then 
	-- 	 dbMgr[PlayerSid].data['QFactionList'] = {}
	-- end
	-- dbMgr[PlayerSid].data['QFactionList'] = QFactionList
end

function GetFactionMemberInfo(sid)
	local FactionID = GetPlayerDataSG(sid,10)
	local szPlayerName = GetPlayerDataSG(sid,4)
	return GetMemberInfoFromFaction(FactionID,szPlayerName,1)
end

function GetMemberInfoFromFaction( FactionID,szPlayerName,membersouce ) --获取成员信息
	--look("GetMemberInfoFromFaction")
	if m_factionManager[FactionID] ~= nil then  
		if membersouce == 0 then
			local Isexist,mPos = MemberIsExist(m_factionManager[FactionID].RequestList,szPlayerName)
			if Isexist == true and mPos ~= nil  then
				return m_factionManager[FactionID].RequestList[mPos]
			end
		elseif membersouce == 1 then
			local Isexist,mPos = MemberIsExist(m_factionManager[FactionID].MemberList,szPlayerName)
			if Isexist == true and mPos ~= nil  then
				return m_factionManager[FactionID].MemberList[mPos]
			end
		end
	end
	return nil
end



function JoinMemberInFaction( FactionID,szPlayerName,membersouce ) --加入1个玩家到军团,直接使用申请时的数据，因为玩家可能离线
	if m_factionManager[FactionID] == nil then
		look("Faction null")
		return false
	end

	if membersouce == 0 then  --到申请列表
		local QuestMember = CreateFactionMember(szPlayerName,0)
		if QuestMember == nil then
			return false
		end
		QuestMember.QuestTime = os.time()  --请求时间
		QuestMember.IsAgree = 0      --是否同意加入 0 未处理  1 同意 2 拒绝
		table.insert(m_factionManager[FactionID].RequestList,QuestMember)  --在军团中保存请求的玩家
		m_factionManager[FactionID].ProperyChange = 1
		m_factionManager[FactionID].QuestJoinNum = m_factionManager[FactionID].QuestJoinNum + 1
		return true
	elseif membersouce == 1 then --到成员列表
		local JoinMember = GetMemberInfoFromFaction(FactionID,szPlayerName,0)
		local ExistMember = GetMemberInfoFromFaction(FactionID,szPlayerName,1)
		if ExistMember ~= nil then
			look("Isexist member")
			return true
		end
		if JoinMember ~= nil then
			JoinMember.Title = FACTIONDUTY[1]  --职位
			table.insert(m_factionManager[FactionID].MemberList,JoinMember)
			m_factionManager[FactionID].MemberNum = m_factionManager[FactionID].MemberNum + 1
			m_factionManager[FactionID].ProperyChange = 1
			return true
		end
	end
	return false
end

function GetFactionTitleNum( FactionID,Title ) --军团相应职务人员个数
	local fnum = 0
	if m_factionManager[FactionID] ~= nil then
		for k,v in pairs(m_factionManager[FactionID].MemberList) do
			if v.Title == Title then
				fnum = fnum + 1
			end
		end
		return fnum
	end
	return -1
end

function GetMemberTitle( FactionID,szPlayerName ) --获取相关人员职位
	local memberinfo = GetMemberInfoFromFaction(FactionID,szPlayerName,1)
	if memberinfo ~= nil then
		return memberinfo.Title
	end
	return -1
end


function GetFactionMemberTitle( sid ) --军团成员的职级
	local PlayerFactionID = GetPlayerDataSG(sid,10)   --工会ID
	local ManagerName =  GetPlayerDataSG(sid,4)
	if PlayerFactionID == 0 then
		return -1
	end

	local factionInfo = GetFactionInfoByID(PlayerFactionID)
	if factionInfo == nil then
		look("GetFactionMemberLimit Faile Name Is't exist "..PlayerFactionID)
		return -1
	end

	local PlayerTitle = GetMemberTitle(PlayerFactionID,ManagerName)
	if PlayerTitle < 0 then
		look("Title Limit On Faction "..PlayerTitle)
		return -1
	end
	return PlayerTitle
end


function UpdateFactionMembers( FactionID,MemberInfo,membersouce ) --更新成员信息
	look("UpdateFactionMembers")
	if m_factionManager[FactionID] ~= nil then
		if membersouce == 0 then
			local Isexist,mPos = MemberIsExist(m_factionManager[FactionID].RequestList,MemberInfo.PlayerName)
			if Isexist == true and mPos ~= nil  then
				m_factionManager[FactionID].RequestList[mPos] = MemberInfo
				return true
			end
		elseif membersouce == 1 then
			local Isexist,mPos = MemberIsExist(m_factionManager[FactionID].MemberList,MemberInfo.PlayerName)
			if Isexist == true and mPos ~= nil  then
				m_factionManager[FactionID].MemberList[mPos] = MemberInfo
				return true
			end
		end
	end
	return nil
end

function LoadFactionData(FactionData)
	if FactionData ~= nil then
		local FactionID = FactionData.FactionID
		--look(" LoadFactionData "..FactionID)
		if m_factionManager ~= nil then
			m_factionManager[FactionID] = {}
			m_factionManager[FactionID] = FactionData[1]
		end
	end
	--look("LoadFactionData "..GetTableNLenth(m_factionManager))
end

function GetFactionManager( )
	if m_factionManager ~= nil then
		return m_factionManager
	end
	return nil
end


function onDisbandFaction( FactionID ) --解散军团
	if m_factionManager[FactionID] ~= nil then
		for i,v in ipairs(m_factionManager[FactionID].MemberList) do  --清空成员表
			local szPlayerName = v.PlayerName
			local sid = GetPlayerSidByName(szPlayerName)
			if sid ~= nil and sid > 0 then  --玩家在线 
				look("onDisbandFaction "..FactionID)
				OnUpdateFactionPlayer(szPlayerName,0,0,0)	--军团ID 清 0    
			end
			m_factionManager[FactionID].MemberNum = m_factionManager[FactionID].MemberNum -1 
		end

		for i,v in ipairs(m_factionManager[FactionID].RequestList) do  --清空成员表
			local szPlayerName = v.PlayerName
			local sid = GetPlayerSidByName(szPlayerName)
			if sid ~= nil and sid > 0 then  --玩家在线 
				UpdatePlayerQuestFactionID(sid,0,0)			--军团申请ID 清 0   
				OnSynFaction(sid)
			end
			m_factionManager[FactionID].QuestJoinNum = m_factionManager[FactionID].QuestJoinNum - 1
		end

		assert(m_factionManager[FactionID].MemberNum == 0,"onDisbandFaction MemberNum ~= 0")
		assert(m_factionManager[FactionID].QuestJoinNum == 0,"onDisbandFaction QuestJoinNum ~= 0")	

		local serverid = GetServerID()
		SDeleteFaction(GetServerID(),FactionID)

		RemoveFromTable(m_factionManager,FactionID)

		return true
	end
	return false
end

function ChangeFactionLeader( FactionID,NewLeaderName )
	if m_factionManager[FactionID] ~= nil then
		local memberinfo =  GetMemberInfoFromFaction(FactionID,NewLeaderName,1)
		local oldmemberinfo =  GetMemberInfoFromFaction(FactionID,m_factionManager[FactionID].CreatePlayerName,1)
		if memberinfo ~= nil and oldmemberinfo ~= nil then
			memberinfo.Title = FACTIONDUTY[4]
			oldmemberinfo.Title = FACTIONDUTY[1]
			m_factionManager[FactionID].CreatePlayerName = NewLeaderName
			m_factionManager[FactionID].ProperyChange = 1
			return true
		end
	end
	return false
end

function SetFcCreatePlayer( FactionID ) --军团长传位置,查找战斗力最高的,至少2个人，需要排除以前的军团长
	local  nsplayername = ""
	local CreatePlayerName = ""
	if m_factionManager[FactionID] ~= nil then
		CreatePlayerName = m_factionManager[FactionID].CreatePlayerName
		if m_factionManager[FactionID].MemberNum > 2 then
			local wFightPower = 1
			for k,v in pairs(m_factionManager[FactionID].MemberList) do
				if v.wFightPower > wFightPower and v.PlayerName ~= CreatePlayerName then
					wFightPower = v.wFightPower 
					nsplayername = v.PlayerName
				end
			end
			m_factionManager[FactionID].CreatePlayerName = nsplayername
			return true
		end
   
	end
	return false
end

function TestSaveMember(  )	
	local testcount = 100
	local testnum = 1
	for k,v in pairs(m_factionManager) do
		local  cFactionInfo= GetFactionInfoByID(k)
		local namecount = cFactionInfo.MemberNum 
		if cFactionInfo ~= nil then
			local factionname = "testmember_"
			local i = cFactionInfo.MemberNum
			for i=1,testcount do
				local strname =  factionname..namecount
				local memberuinfo = CreateFactionMemberForTest(strname,0)
				if memberuinfo ~= nil then
					table.insert(cFactionInfo.MemberList,memberuinfo)
					cFactionInfo.MemberNum = cFactionInfo.MemberNum + 1
				end
				namecount = namecount + 1
			end		
			cFactionInfo.ProperyChange = 1
			look(cFactionInfo.MemberNum)
		end	
		testnum = testnum - 1
		if testnum <= 0 then
			break
		end	
	end
	SaveFactionData()
end

function TestSave( )
	
	local testcount = 1
	local lentn = GetTableNLenth(m_factionManager)
	if lentn < testcount then
		for i=1,testcount do
	
			local cFactionInfo = CreateFactionInfoForTest("MyFaction",101,"Hello Word")
			if cFactionInfo == nil then
				look("CreateFactionInfoForTest Faile")
				return
			end
			m_factionManager[cFactionInfo.FactionID] = {}
			m_factionManager[cFactionInfo.FactionID] = deepcopy(cFactionInfo)
			--look("CreateFactionInfoForTest Sucess "..cFactionInfo.FactionID)
		end
	end
	--look(m_factionManager)
	look("TestSave "..GetTableNLenth(m_factionManager))	
	SaveFactionData()
end

function showfaction(  )
	for k,v in pairs(m_factionManager) do
		look(v.Notice)
		look(v.MemberNum)
	end
end


function TestDel(  )
	look(GetTableNLenth(m_factionManager))
	for k,v in pairs(m_factionManager) do
		SDeleteFaction(GetServerID(),k)
	end
	m_factionManager = nil
	m_factionManager = {}
end

-- local MAXSENDNUM = 10
-- function SaveAllFaction( )
-- 	local sAllFaction = {}
-- 	if m_factionManager ~= nil then
-- 		for k,v in pairs(m_factionManager) do       --在保存后设置属性标志位0
-- 			if v.ProperyChange == 1 then
-- 				local stemp =
-- 				{
-- 					v,
-- 					v.MemberList,
-- 					v.RequestList,
-- 				}
-- 				table.insert(sAllFaction,stemp)
-- 				v.ProperyChange = 0
-- 			end
-- 		end
-- 		if #sAllFaction > 0 then
-- 			SaveAllFactioninfo(sAllFaction)
-- 			look("SaveFaction  "..#sAllFaction)
-- 		end
-- 	end
-- end

function SaveFactionData( )
	local sAllFaction = {}
	if m_factionManager ~= nil then
		for k,v in pairs(m_factionManager) do       --在保存后设置属性标志位0
			if v.ProperyChange == 1 then
				local stemp =
				{
					{FactionName = v.FactionName,FactionID = v.FactionID},
					v,
				}
				table.insert(sAllFaction,stemp)
				v.ProperyChange = 0
			end
		end
		if #sAllFaction > 0 then
			SaveAllFactionData(sAllFaction)
			look("SaveFaction  "..#sAllFaction)
		end
	end
end

function onDeleteFactionRecall( sDeleteResult )
	look("onDeleteFactionRecall "..sDeleteResult.bresult)
	-- look(sDeleteResult)
	-- if sDeleteResult.bresult == 1 then
	-- 	local fid = sDeleteResult.dFactionID
	-- 	if m_factionManager[fid] ~= nil then

	-- 	end
	-- end
end

function ChangeFactionActive( FactionID,ActiveValue ) --改变军团活跃度
	local FactionInfo = GetFactionInfoByID(FactionID)
	if FactionInfo ~= nil then
		FactionInfo.ActiveValue = FactionInfo.ActiveValue + ActiveValue
		if FactionInfo.ActiveValue < 0 then
			FactionInfo.ActiveValue = 0
		end
		return true
	end

	return false
end

function ChangeFactionExp( FactionID,ExpValue ) --改变军团经验
	local FactionInfo = GetFactionInfoByID(FactionID)
	if FactionInfo ~= nil then
		--FactionInfo.Exp = FactionInfo.Exp + ExpValue
		local destExp = FactionInfo.Exp + ExpValue
		look("destExp "..tostring(destExp))
		local levelrange = 1
		if FACTIONEXPUPDATE ~= nil then
			for i,v in ipairs(FACTIONEXPUPDATE) do
				--if FactionInfo.Exp < v then
				if destExp < v then
					break
				else
					if i < #FACTIONEXPUPDATE then
						--if  FactionInfo.Exp >= FACTIONEXPUPDATE[i] then
						if i >= FactionInfo.FactionLevel and destExp >= FACTIONEXPUPDATE[i] then
							destExp = destExp - FACTIONEXPUPDATE[i]
							levelrange = i + 1
						end
					else
						destExp = 0
						levelrange = i + 1
						break
					end
				end
			end

			FactionInfo.Exp = destExp
			if levelrange > 1 then    --本身是1级就不用改变
				if FactionInfo.FactionLevel < levelrange then
					FactionInfo.FactionLevel = levelrange
					look("Faction Was Updatelevel")
					return true
				end
			end
		end
		return true
	end
	return false
end





function SendFactionReward( sceneID,FactionID ) --发送军团奖励
	if FactionSceneMap[sceneID] == nil then
		look("SendFactionReward FactionSceneMap nil")
		return
	end
	local itemlist = FactionSceneMap[sceneID].itemlist
	
	local MailInfo = {}    -- 邮件信息
	local RewardList = {}  --道具列表
	local temp = {}
	temp.itype = GoodsType.token
	

	MailInfo.senderName = MystringFormat("MAIL_SENDER")
	MailInfo.title = MystringFormat("MAIL_FACTION_TITLE")
	MailInfo.content = MystringFormat("MAIL_FACTION_CONTENT")
	MailInfo.expiretime = FACTION_MAIL_EXTIME
	if m_factionManager[FactionID] ~= nil then

		for k,v in pairs(m_factionManager[FactionID].MemberList) do
			MailInfo.recvname = v.PlayerName

			local PlayerRank = GetPlayerHurtRank(sceneID,FactionID,v.PlayerName)
			for i,v in ipairs(itemlist) do
				if PlayerRank >= v.range[1] and PlayerRank <= v.range[2] then
					temp.itemid = v.reward[1]
					temp.num =  v.reward[2]
					RewardList[1] = temp
					SendMailToPlayer(MailInfo,RewardList,2)
					break
				end
			end
		end
	end
end

function ClearupQuestList( ) --清理所有申请列表
	for k,v in pairs(m_factionManager) do
		v.RequestList = {}
		v.QuestJoinNum = 0
	end
end

function CleanActiveValue(  ) --清理累计的7天活跃度，仅保留当天
	local nowday =  tonumber(os.date("%Y%m%d",os.time()))
	local Startday = tonumber(os.date("%Y%m%d",g_ServerStartTime))
	if 	(nowday - Startday) > 0 and (nowday - Startday) % FACTION_ACTIVE_RESETTIME == 0 then
		local nowtime = tonumber(os.date("*t",os.time()))   --这里1小时更新一次，所以判断一下时间只清除1次
		if nowtime.hour == 0 then
			for k,v in pairs(m_factionManager) do
				for i,j in pairs(v.MemberList) do
					j.PlayerActiveValue = j.LastActiveValue
				end
			end	
		end 
	end
end

function FactionInit( )
	if m_factionManager == nil then
		m_factionManager = {}
	end

	if g_ServerStartTime == nil then
		g_ServerStartTime = os.time()
	end

	UpdateFaction()
end



function UpdateFaction() --军团更新数据，兼容已上线的老军团新增现有功能
	for i,j in pairs(m_factionManager) do
		if j.Notice == nil then  --新增加的数据开始变量
			j.Notice = ""  			--军团公告
			j.ModifyNTime = 0  			--军团公告修改时间
			j.FactionLog = {} 		--军团操作日志
			j.EquipmentDepot = {}    --军团副本掉落的仓库
			j.QuestEquipmentList= {}  --军团申请装备的队列
			j.EmailSendCount = 0  --军团邮件发送次数
			j.ProperyChange = 1

			for k,v in pairs(j.MemberList) do
				if v.PlayerActiveValue == nil then  --新增加的成员数据开始变量
					v.PlayerActiveValue = 0     --玩家军团的活跃度贡献值1周贡献值
					v.LastActiveValue = 0     --玩家当天活跃度贡献值
					v.RequestEquipment = 0  	--玩家申请的副本掉落装备
					v.GotEquipmentTime = 0  	--玩家申请装备得到的时间
				end
			end
			look(" UpdateFaction Data "..i)
		end

		if j.EmailSendCount == nil then  --军团邮件发送次数
			j.EmailSendCount = 0  --军团邮件发送次数
			j.ProperyChange = 1
			look(" UpdateFaction Data "..i)
		end
	end
end


function ftest(  )
	local ft = GetFactionNum()
	look(ft)

end


FactionInit()