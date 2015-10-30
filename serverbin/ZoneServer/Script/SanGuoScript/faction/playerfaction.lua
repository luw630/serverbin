

function IsMemberOnline( PlayerName )
	local sid = GetPlayerSidByName(PlayerName)
	if sid ~= nil and sid > 0 then
		return true
	end
	return false
end

function OnShowFactioninfo( PlayerSid)  --玩家查看自身所在军团信息
	--look("OnShowFactioninfo")
	local PlayerFactionID = GetPlayerDataSG(PlayerSid,10)   --工会ID
	if PlayerFactionID == 0 then
		look("Faction is nil")
		return 
	end

	local  factionInfo = GetFactionInfoByID(PlayerFactionID)
	if factionInfo ~= nil then
		assert(#factionInfo.MemberList > 0)
		for i,v in ipairs(factionInfo.MemberList) do
			if IsMemberOnline(v.PlayerName) == true then
				v.isonline = 1
			else
				v.isonline = 0
			end
		end
		--look("OnShowFactioninfo \n")	
		SendFactioninfo(PlayerSid,factionInfo,factionInfo.MemberList)--发送自身所在军团信息
		OnSynFaction(PlayerSid)
		OnShowFactionNotice(PlayerSid)
	end

end


function ChangePlayerFactionMoney( sid,dChangenum) --改变军需令
	local PlayerFactionID = GetPlayerDataSG(sid,10)   --
	if PlayerFactionID == 0 then
		look("Faction is nil")
		return false
	end
	local MemberName = GetPlayerDataSG(sid,4)
	local memberinfo = GetMemberInfoFromFaction(PlayerFactionID,MemberName,1)
	if memberinfo ~= nil then
		memberinfo.FactionMoney = memberinfo.FactionMoney + dChangenum
		if memberinfo.FactionMoney < 0 then
			memberinfo.FactionMoney = 0
		end
		return true
	end
	return false
end


function GetPlayerFactionMoney( sid ) --获取军需令
	local PlayerFactionID = GetPlayerDataSG(sid,10)   --
	if PlayerFactionID == 0 then
		--look("Faction is nil")
		return 0
	end
	local MemberName = GetPlayerDataSG(sid,4)
	local memberinfo = GetMemberInfoFromFaction(PlayerFactionID,MemberName,1)
	if memberinfo ~= nil then
		return memberinfo.FactionMoney
	end
	return -1
end


function OnShowFactionList( PlayerSid,btype,sFactionName,FactionID)  --玩家查找所有军团列表  0  全部类别  1 ID查找 2 名字查找
	--look("OnShowFactionList")
	local fManager = nil
	local FactionList = {}
	if btype == 0 then
		fManager = GetFactionManager()
		if fManager ~= nil then
			for k,v in pairs(fManager) do
				local FactionInfo = {}
				FactionInfo.FactionName = v.FactionName
				FactionInfo.CreatePlayerName = v.CreatePlayerName
				FactionInfo.FactionLevel = v.FactionLevel
				FactionInfo.MemberNum = v.MemberNum
				FactionInfo.FactionID = v.FactionID
				FactionInfo.FactionIcon = v.FactionIcon
				table.insert(FactionList,FactionInfo)
				--look("OnShowFactionList "..v.MemberNum)
			end
			look("SendFactionList")
			SendFactionList(PlayerSid,FactionList)--发送军团列表
			return
		end
	elseif btype == 1 then
		fManager = GetFactionInfoByID(FactionID)
	elseif btype == 2 then
		local fid = GetFactionIDByName(sFactionName)
		if fid > 0 then
			fManager = GetFactionInfoByID(fid)
		end
	end
	if fManager ~= nil then
		local FactionInfo = {}
		FactionInfo.FactionName = fManager.FactionName
		FactionInfo.CreatePlayerName = fManager.CreatePlayerName
		FactionInfo.FactionLevel = fManager.FactionLevel
		FactionInfo.MemberNum = fManager.MemberNum
		FactionInfo.FactionID = fManager.FactionID
		FactionInfo.FactionIcon = fManager.FactionIcon
		table.insert(FactionList,FactionInfo)
	end
	SendFactionList(PlayerSid,FactionList)--发送军团列表
end

function GetTableNLenth( tab )
	local num = 0
	if type(tab) == "table" then
		for k,v in pairs(tab) do
			num = num + 1
		end
	end
	return num
end


function PlayerAddFaction(FactionID,PlayerSid ) --玩家请求加入到军团
	local PlayerFactionID = GetPlayerDataSG(PlayerSid,10)   --工会ID
	if PlayerFactionID > 0 then
		look("PlayerAddFaction Faile "..PlayerFactionID)
		SendJoinResult(PlayerSid,4)	 --发送请求结果
		return 
	end

	local factionInfo = GetFactionInfoByID(FactionID)
	if factionInfo == nil then
		look("PlayerAddFaction Faile Name Is't exist "..FactionID)
		SendJoinResult(PlayerSid,0)	 --发送请求结果
		return 
	end

	local questcount = 0  
	local bisadd = 0
	local PlayerQFactionList = GetPlayerQuestFactionList(PlayerSid)
	for i,v in ipairs(PlayerQFactionList) do
		if v[1] > 0  and v[1] == FactionID then
			bisadd = 2
			break
		elseif v[1] == 0 then
			bisadd = 1
			break
		else
			if v[2] == 2 then
				bisadd = 1
				break
			end
		end

	end

	if bisadd == 0 then
		look("PlayerAddFaction Quest Max ")
		SendJoinResult(PlayerSid,2)	 --发送请求结果
		return
	elseif bisadd == 2 then
		look("PlayerAddFaction AllReady")
		SendJoinResult(PlayerSid,1)	 --发送请求结果
		return
	end

	
	if #factionInfo.RequestList + 1 > QUESTLISTMAX then
		look("PlayerAddFaction RequestList Max "..#factionInfo.RequestList)
		SendJoinResult(PlayerSid,5)	 --发送请求结果
		return
	end
	
	local flevel = factionInfo.FactionLevel
	if flevel > #FACTIONMEMBERMAX then	--限制军团成员数量配置表异常
		look("Faction Member Config Cound't found Limit Number with "..tostring(flevel))
		SendJoinResult(PlayerSid,0)	 --发送请求结果
		return
	end
	
	if factionInfo.MemberNum + 1 > FACTIONMEMBERMAX[flevel] then
		look("PlayerAddFaction Member Max ")
		SendJoinResult(PlayerSid,6)	 --发送请求结果
		return
	end

	local MemberName = GetPlayerDataSG(PlayerSid,4)
	if factionInfo.KickInfo[MemberName] ~= nil then
		local kicktime = factionInfo.KickInfo[MemberName]
		if kicktime > 0 then
			local nInterval = os.difftime(os.time(),kicktime)
			if nInterval < FACTIONKICKJOINTIME then
				SendJoinResult(PlayerSid,7)	 --发送请求结果
				look("Kick Time Limit  1")
				return
			end
		end
	end

	local quitinfo = GetQuitFactionInfo(PlayerSid)
	if quitinfo ~= nil then
		if quitinfo[1] > 0 then
			local quittime = quitinfo[2]
			local nInterval = os.difftime(os.time(),quittime)
			if quitinfo[3] == 1 then --被踢
				if quitinfo[1] == FactionID then
					if nInterval < FACTIONKICKJOINTIME then
						SendJoinResult(PlayerSid,7)	 --发送请求结果
						look("Kick Time Limit 2   nInterval "..nInterval/60/60)
						return
					end	
				end
			else
				local quitday = tonumber(os.date("%Y%m%d",quittime))
				local nowday = tonumber(os.date("%Y%m%d",os.time()))

				local quittimedate = os.date("*t",quittime)
				local nowtimedate = os.date("*t",os.time())

				if nowtimedate.hour < FactionSceneResetTime then
					SendJoinResult(PlayerSid,8)	 --发送请求结果,时间未到
					look("Join Time Limit 1")
					return
				end 

				if quitday >= nowday then     --当前退出的军团
					if quittimedate.hour >= FactionSceneResetTime then
						SendJoinResult(PlayerSid,8)	 --发送请求结果,在5点以后退出军团当前不能再申请
						look("Join Time Limit 2  quittime "..quittimedate.hour)
						return
					end
				end
			end
		end
	end


	
	if JoinMemberInFaction(FactionID,MemberName,0) == false then
		look("JoinMemberInFaction Faile")
		SendJoinResult(PlayerSid,2)	 --发送请求结果
		return
	end

	UpdatePlayerQuestFactionID(PlayerSid,FactionID,0) --更新玩家保存加入请求
	SendJoinResult(PlayerSid,1)	 --发送请求结果
	OnSynFaction(PlayerSid)
	factionInfo.ProperyChange = 1
	look("SendJoinTo Sucess "..FactionID)
end


function PlayerLeaveFaction( PlayerSid ) --玩家离开军团
	local PlayerFactionID = GetPlayerDataSG(PlayerSid,10)   --工会ID
	if PlayerFactionID == 0 then
		look("PlayerLeaveFaction Faile "..PlayerFactionID)
		return false
	end


	local factionInfo = GetFactionInfoByID(PlayerFactionID)
	if factionInfo == nil then
		look("PlayerAddFaction Faile Name Is't exist "..PlayerFactionID)
		return false
	end

	local MemberName = GetPlayerDataSG(PlayerSid,4)  --玩家名字
	if RemoveMemberList(PlayerFactionID,MemberName) == true then
		SetPlayerData(PlayerSid,10,0)         --设置工会ID
		UpdatePlayerQuestFactionID(PlayerSid,0,0) --更新申请的军团ID0
		OnSynFaction(PlayerSid)
		return true
	end
	return false
end


function KickFromFaction(FactionID,kPlayerName ) --踢出军团
	local factionInfo = GetFactionInfoByID(FactionID)
	local kPlayerSid = GetPlayerSidByName(kPlayerName)
	if factionInfo == nil then
		look("PlayerAddFaction Faile Name Is't exist "..FactionID)
		return false
	end
	if RemoveMemberList(FactionID,kPlayerName) == true then
		if kPlayerSid ~= nil and kPlayerSid > 0 then  --玩家在线 
			OnUpdateFactionPlayer(kPlayerName,0,0,0)
			SaveQuitFactionTime(kPlayerSid,FactionID,1)
		else
			if factionInfo.KickInfo == nil then     --玩家不在线，记录他被踢的记录
				factionInfo.KickInfo = {}
			end
			factionInfo.KickInfo[kPlayerName] = os.time() 
		end
 		return true
	end
	return false
end

function ClearKickInfo( FactionID )
	local factionInfo = GetFactionInfoByID(FactionID)
	if factionInfo == nil then
		look("ClearKickInfo Faile Name Is't exist "..FactionID)
		return false
	end
	local ntime = os.time()
	if factionInfo.KickInfo ~= nil then
		for k,v in pairs(factionInfo.KickInfo) do
			local difftime = os.difftime(ntime,v)
			if difftime >= FACTIONKICKJOINTIME then
				v = 0
			end
		end
	end
end

function GetPlayerFactionName( sid ) --获取玩家军团名字
	local PlayerFactionID = GetPlayerDataSG(PlayerSid,10)   --工会ID
	if PlayerFactionID == 0 then
--		look("PlayerManagerFaction Faile "..PlayerFactionID)
		return ""
	end

	local factionInfo = GetFactionInfoByID(PlayerFactionID)
	if factionInfo == nil then
		look("PlayerManagerFaction Faile Name Is't exist "..PlayerFactionID)
		return ""
	end

	return factionInfo.FactionName
end

--军团长管理军团,或者玩家查看申请信息
-- 0  查看申请加入军团玩家列表     1   同意或拒绝玩家加入  2  踢玩家出军团  3 解散军团
-- 5  查看自己申请的军团列表       6   取消加入申请   7 退出所在军团   
-- 8  军团任命					   9      
function PlayerManagerFaction( PlayerSid,mType,bAgree,szPlayerName ) 
	local PlayerFactionID = GetPlayerDataSG(PlayerSid,10)   --工会ID
	local ManagerName =  GetPlayerDataSG(PlayerSid,4)

	if mType < 5 then
		if PlayerFactionID == 0 then
			look("PlayerManagerFaction Faile "..PlayerFactionID)
			return 
		end

		local factionInfo = GetFactionInfoByID(PlayerFactionID)
		if factionInfo == nil then
			look("PlayerManagerFaction Faile Name Is't exist "..PlayerFactionID)
			return 
		end

		local PlayerTitle = GetMemberTitle(PlayerFactionID,ManagerName)
		if PlayerTitle < 0 then
			look("Title Limit On Faction "..PlayerTitle)
			return
		end

		if mType == 0 then  -- 0  查看申请加入军团玩家列表
			if PlayerTitle < FACTIONDUTY[1] then
				look("Title Limit On Faction "..PlayerTitle)
				return
			end
			SendManagerFaction(PlayerSid,1,mType,factionInfo.RequestList)
		elseif mType == 1 then --  同意或拒绝玩家加入，这里牵涉到可能会被多个军团处理
			if PlayerTitle < FACTIONDUTY[1] then
				look("Title Limit On Faction "..PlayerTitle)
				return
			end
			if bAgree == 0 then   --拒绝
				local RefusePlayerSid = GetPlayerSidByName(szPlayerName)
				if RefusePlayerSid ~= nil and RefusePlayerSid > 0 then  --online
					local PlayerQFactionList = GetPlayerQuestFactionList(RefusePlayerSid)
					for i,v in ipairs(PlayerQFactionList) do
						if v[1] == PlayerFactionID  then 
						    v[2] = 2
							SendManagerFaction(PlayerSid,1,mType)
							RemoveJoinList(PlayerFactionID,szPlayerName)  --从自己军团申请中清除
							factionInfo.ProperyChange = 1
							OnUpdateFactionPlayer(szPlayerName,0,PlayerFactionID,2)
							return
						end
					end
				else
					local offineplayer = GetoffinePlayerByname(szPlayerName)
					if offineplayer ~= nil then
						look("offineplayer GetData")
						local PlayerQFactionList = offineplayer:GetData()
						if PlayerQFactionList ~= nil then
							for i,v in ipairs(PlayerQFactionList) do
								if v[1] == PlayerFactionID  then --
									look("PlayerManagerFaction Faile Had In Faction")
									v[2] = 2
									SendManagerFaction(PlayerSid,1,mType)
									RemoveJoinList(PlayerFactionID,szPlayerName)  --从自己军团申请中清除
									OnUpdateFactionPlayer(szPlayerName,0,PlayerFactionID,2)
									return
								end
							end
						end
					end
				end
			elseif bAgree == 1 then --同意玩家加入，最后在检查一下数量，因为这时距离申请时候已经改变过
				local AddPlayerSid = GetPlayerSidByName(szPlayerName)
				local PlayerQFactionList = nil
				if AddPlayerSid ~= nil and AddPlayerSid > 0 then  --online
					PlayerQFactionList = GetPlayerQuestFactionList(AddPlayerSid)
					for i,v in ipairs(PlayerQFactionList) do
						if v[1] > 0 and v[2] == 1  then --已经被其他军团加入
							look("PlayerManagerFaction Faile Had In Faction")
							SendManagerFaction(PlayerSid,2,mType)
							RemoveJoinList(PlayerFactionID,szPlayerName)  --从自己军团申请中清除
							return
						end
					end
				else
					local offineplayer = GetoffinePlayerByname(szPlayerName)
					if offineplayer ~= nil then
						look("offineplayer GetData")
						PlayerQFactionList = offineplayer:GetData()
						if PlayerQFactionList ~= nil then
							for i,v in ipairs(PlayerQFactionList) do
								if v[1] > 0 and v[2] == 1  then --已经被其他军团加入
									look("PlayerManagerFaction Faile Had In Faction")
									SendManagerFaction(PlayerSid,2,mType)
									RemoveJoinList(PlayerFactionID,szPlayerName)  --从自己军团申请中清除
									return
								end
							end
						end
					end
				end

				local flevle = factionInfo.FactionLevel
				if factionInfo.MemberNum + 1 > FACTIONMEMBERMAX[flevle] then
					look("PlayerManagerFaction Faile FACTIONMEMBERMAX")
					SendManagerFaction(PlayerSid,0,mType)
					return
				end

				if JoinMemberInFaction(PlayerFactionID,szPlayerName,1) == false then --加入到军团
					look("JoinMemberInFaction Faile")
					SendManagerFaction(PlayerSid,0,mType)
					return
				end

				for i,v in ipairs(PlayerQFactionList) do
					if v[1] > 0 then
						local factionInfo = GetFactionInfoByID(v[1])
						if factionInfo ~= nil then
						    if RemoveJoinList(v[1],szPlayerName) == true then   --从申请列表中删除
							 	factionInfo.ProperyChange = 1
							end
						end
					end
				end
				SendManagerFaction(PlayerSid,1,mType)
				OnAddFactionLog(PlayerFactionID,FACTIONOPERATE.ADDMEMBER,szPlayerName,0)
	
				OnUpdateFactionPlayer(szPlayerName,PlayerFactionID,PlayerFactionID,1)
				ClearKickInfo(PlayerFactionID)
			end
		elseif mType == 2 then -- 踢玩家出军团
			if ManagerName == szPlayerName then
				look("You Can't Kick By Self")
				SendManagerFaction(PlayerSid,0,mType)
				return 
			end
			if PlayerTitle < FACTIONDUTY[3] then
				look("PlayerTitle Limit "..PlayerTitle)
				SendManagerFaction(PlayerSid,0,mType)
				return 
			end
			if KickFromFaction(PlayerFactionID,szPlayerName) == true then
				SendManagerFaction(PlayerSid,1,mType)
				OnAddFactionLog(PlayerFactionID,FACTIONOPERATE.KICKMEMBER,szPlayerName,0)

			else
				SendManagerFaction(PlayerSid,0,mType)
			end
		elseif mType == 3 then --解散军团
			if PlayerTitle < FACTIONDUTY[4] then
				look("PlayerTitle Limit "..PlayerTitle)
				SendManagerFaction(PlayerSid,0,mType)
				return 
			end
			if onDisbandFaction(PlayerFactionID) == true then
				SendManagerFaction(PlayerSid,1,mType)
			else
				SendManagerFaction(PlayerSid,0,mType)
			end
			

			look("onDisbandFaction")
			--OnSynFaction(PlayerSid)
		end
	else
		if mType == 5 then --查看自己申请的军团列表
			local PlayerQFactionList = GetPlayerQuestFactionList(PlayerSid)
			for i,v in ipairs(PlayerQFactionList) do
				if v[1] > 0 then
					local QjoinID = v[1]
					if MemberIsInFaction(QjoinID,ManagerName,0) == false then  --军团申请中找不到
						if MemberIsInFaction(QjoinID,ManagerName,1) == false then --成员也没有应该被踢拒绝
							UpdatePlayerQuestFactionID(PlayerSid,QjoinID,2)  --更新拒绝
						else
							UpdatePlayerQuestFactionID(PlayerSid,QjoinID,1)  --更新同意
							SetPlayerData(PlayerSid,10,QjoinID)
						end
					end
				end
			end
			local sendquest = {}
			for i,v in ipairs(PlayerQFactionList) do
				sendquest[i] = v
			end
			--look(sendquest)
			SendManagerFaction(PlayerSid,1,mType,sendquest)
			OnSynFaction(PlayerSid)
			--printtable(PlayerQFactionList)
			--look(PlayerQFactionList)
		elseif mType == 6 then --6   取消加入 
			local PlayerQFactionList = GetPlayerQuestFactionList(PlayerSid)
			if bAgree == 0 then  --这里这个参数作为取消加入军团的索引
				for i,v in ipairs(PlayerQFactionList) do
					if v[1] > 0 then
						local factionInfo = GetFactionInfoByID(v[1])
						if factionInfo ~= nil then
						    if RemoveJoinList(v[1],ManagerName) == true then   --从申请列表中删除
						    	SetPlayerQuestFactionID(PlayerSid,i,0,0)
							 	factionInfo.ProperyChange = 1
							end
						end
					end
				end
				look(" RemoveJoinList ")
				SendManagerFaction(PlayerSid,1,mType)
				OnSynFaction(PlayerSid)
				return
			else
				if bAgree <= #PlayerQFactionList then
					local QFactionID = PlayerQFactionList[bAgree][1]
					if QFactionID > 0 then
						local factionInfo = GetFactionInfoByID(QFactionID)
						if factionInfo ~= nil then
						    if RemoveJoinList(QFactionID,ManagerName) == true then   --从申请列表中删除
						    	SetPlayerQuestFactionID(PlayerSid,bAgree,0,0)
							 	factionInfo.ProperyChange = 1
							end
						end
					end
					SendManagerFaction(PlayerSid,1,mType)
					OnSynFaction(PlayerSid)
					return
				end
			end
			look(" RemoveJoinList Faile")
			SendManagerFaction(PlayerSid,0,mType)
			OnSynFaction(PlayerSid)
		elseif mType == 7 then --7 退出所在军团
			local PlayerFactionID = GetPlayerDataSG(PlayerSid,10)   --工会ID
			local factionInfo = GetFactionInfoByID(PlayerFactionID)
			local bDisband = 0

			if factionInfo == nil then
				look("Get Faction nil")
				SendManagerFaction(PlayerSid,0,mType)
				OnSynFaction(PlayerSid)
				return
			end

			if GetFactionMasterName(PlayerFactionID) == ManagerName then --军团长
				if factionInfo.MemberNum - 1 <= 0 then   --直接解散
					bDisband = 1
					if onDisbandFaction(PlayerFactionID) == true then
						SendManagerFaction(PlayerSid,1,mType)
					else
						SendManagerFaction(PlayerSid,0,mType)
					end
					return 
				else
					SetFcCreatePlayer(PlayerFactionID)   --更换军团长
				end
			end

			if PlayerLeaveFaction(PlayerSid) == true then
				SendManagerFaction(PlayerSid,1,mType)
			else
				SendManagerFaction(PlayerSid,0,mType)
			end

			if bDisband == 0 then  --退出军团
				SaveQuitFactionTime(PlayerSid,PlayerFactionID,0)
			end
		elseif mType == 8 then --8 军团任命
			--look("mType "..mType.." bAgree "..bAgree)
			local PlayerTitle = GetMemberTitle(PlayerFactionID,ManagerName)
			local memberinfo =  GetMemberInfoFromFaction(PlayerFactionID,szPlayerName,1)
			local factionInfo = GetFactionInfoByID(PlayerFactionID)
			if memberinfo ~= nil then

				if bAgree == FACTIONDUTY[4] then
					if GetFactionMasterName(PlayerFactionID) == ManagerName then --军团长
						if ChangeFactionLeader(PlayerFactionID,szPlayerName) == true then
							SendManagerFaction(PlayerSid,1,mType)
							OnAddFactionLog(PlayerFactionID,FACTIONOPERATE.UPDATETITLE,szPlayerName,bAgree)
							return
						end
					end
				end


				if PlayerTitle <= bAgree then --此处这个参数作为任命的职务
					look(" PlayerTitle Limit "..PlayerTitle)
					SendManagerFaction(PlayerSid,0,mType)
					return
				end

				if PlayerTitle < memberinfo.Title then
					look(" Can't operate PlayerTitle "..PlayerTitle.."  < memberTitle "..memberinfo.Title)
					SendManagerFaction(PlayerSid,0,mType)
					return
				end

				local Cnum = GetFactionTitleNum(PlayerFactionID,bAgree)
				if bAgree == 2 then  
					if Cnum >= FACTIONDUTYNUM[1] then
						look(" Title Num Limit "..Cnum)
						SendManagerFaction(PlayerSid,3,mType)       --职位人数已满
						return
					end
				else
					if Cnum >= FACTIONDUTYNUM[2] then
						look(" Title Num Limit "..Cnum)
						SendManagerFaction(PlayerSid,3,mType)    --职位人数已满
						return
					end
				end	

				memberinfo.Title = bAgree
				factionInfo.ProperyChange = 1
				SendManagerFaction(PlayerSid,1,mType)

				OnAddFactionLog(PlayerFactionID,FACTIONOPERATE.UPDATETITLE,szPlayerName,bAgree)

				return
			end
		end
	end
end

function GetQuitFactionInfo( PlayerSid ) --获取玩家退出军团信息
	local PlayerQFactionList = GetPlayerQuestFactionList(PlayerSid)
	if PlayerQFactionList.QuitInfo == nil then
		PlayerQFactionList.QuitInfo = {0,0,0}    --军团退出保存的信息，时间和上一个军团ID ,军团ID + 退出时间 + 是否提出军团
	end
	return PlayerQFactionList.QuitInfo
end

function SaveQuitFactionTime( PlayerSid,FactionID,bIskick ) --保存玩家上次退出军团的时间,扩展申请列表中的第三个参数保存  军团ID + 退出时间
	local PlayerQFactionList = GetPlayerQuestFactionList(PlayerSid)
	if PlayerQFactionList.QuitInfo == nil then
		PlayerQFactionList.QuitInfo = {0,0,0}
	end
	PlayerQFactionList.QuitInfo[1] = FactionID
	PlayerQFactionList.QuitInfo[2] = os.time()
	PlayerQFactionList.QuitInfo[3] = bIskick
	look("Player Quit Faction ")
	SaveQuestFactionList(PlayerSid,PlayerQFactionList)
end

function OnSynFaction( PlayerSid )  --玩家请求同步军团信息
	local FactionInfo = {}
	local QjoinList = GetPlayerQuestFactionList(PlayerSid)[1]
	FactionInfo.FactionID = GetPlayerDataSG(PlayerSid,10)
	FactionInfo.JoinID = QjoinList[1]
	FactionInfo.JoinState = QjoinList[2]
	FactionInfo.FactionMoney = GetPlayerFactionMoney(PlayerSid)
	SendSynFaction(PlayerSid,FactionInfo)
--	look("OnSynFaction")
end

function OnSynFactionByName( szPlayerName )  --玩家请求同步军团信息
	local sid = GetPlayerSidByName(szPlayerName)
	if sid ~= nil and sid > 0 then
		OnSynFaction(sid)
	end
end

function OnUpdateFactionPlayer( szPlayerName,FactionID,JoinID,bAgree )
	--look("OnUpdateFactionPlayer "..szPlayerName.."   FactionID  "..FactionID)
	local sid = GetPlayerSidByName(szPlayerName)
	if sid ~= nil and sid > 0 then
		SetPlayerData(sid,10,FactionID)
		UpdatePlayerQuestFactionID(sid,JoinID,bAgree)
		OnSynFaction(sid)
	else
		local offineplayer = GetoffinePlayerByname(szPlayerName)
		if offineplayer ~= nil then
			offineplayer:UpdataFactionQuset(FactionID,JoinID,bAgree)
			look("UpdateOffinePlayer "..offineplayer.sid)
		end
	end
end

function UpdatePlayerQuestFaction( PlayerSid,qFactionList) --更新请求的军团ID
	SaveQuestFactionList(PlayerSid,qFactionList)
end

function ZeroPlayerQuestFaction( PlayerSid )
	local PlayerQFactionList = GetPlayerQuestFactionList(PlayerSid)
	if GetTableNLenth(PlayerQFactionList) > 0 then
		for i,v in ipairs(PlayerQFactionList) do
			v[1] = 0
			v[2] = 0
		end
	end
	SaveQuestFactionList(PlayerSid,PlayerQFactionList)
end

function SetPlayerQuestFactionID(  PlayerSid,ipos,FactionID,bAgree )
	local PlayerQFactionList = GetPlayerQuestFactionList(PlayerSid)
	if PlayerQFactionList ~=nil and GetTableNLenth(PlayerQFactionList) > 0 then
		if PlayerQFactionList[ipos] ~= nil then
			PlayerQFactionList[ipos][1] = FactionID
			PlayerQFactionList[ipos][2] = bAgree
			SaveQuestFactionList(PlayerSid,PlayerQFactionList)
			return 1
		end
	end
	return 0
end


function UpdatePlayerQuestFactionID( PlayerSid,FactionID,bAgree) --更新请求的军团ID 
	local bupdata = 0
	local PlayerQFactionList = GetPlayerQuestFactionList(PlayerSid)
	if GetTableNLenth(PlayerQFactionList) > 0 then
		for i,v in ipairs(PlayerQFactionList) do
			if v[1] == FactionID then
				v[2] = bAgree
				bupdata = 1
				break
			end
		end

		if bupdata == 0 then
			for i,v in ipairs(PlayerQFactionList) do
				if v[1] == 0 then
					v[1] = FactionID
					v[2] = bAgree
					break
				else
					if v[2] == 2 then     --已经被拒绝的
						v[1] = FactionID
						v[2] = bAgree
						break
					end
				end
			end
		end
	else
		local Quest = {}
		Quest[1] = FactionID
		Quest[2] = bAgree
		table.insert(PlayerQFactionList,Quest)
		look("UpdatePlayerQuestFactionID   NEW insert")		
	end
	SaveQuestFactionList(PlayerSid,PlayerQFactionList)
end

function SetPlayerData(PlayerSid ,DataType,DataValue)
	-- local LuaPlayer = GetLuaPlayer(PlayerSid)
	-- if LuaPlayer ~= nil then
	-- 	LuaPlayer[DataType] = DataValue
	-- end
	-- look("SetPlayerData "..DataType.."      "..LuaPlayer[DataType])
	CI_SetPlayerDataSG(PlayerSid,DataType,DataValue)
end


function GetPlayerDataSG( PlayerSid,DataType )
	-- local LuaPlayer = GetLuaPlayer(PlayerSid)
	-- if LuaPlayer ~= nil then
	-- 	if LuaPlayer[DataType] == nil then
	-- 		LuaPlayer[DataType] = CI_GetPlayerDataSG(PlayerSid,DataType)
	-- 	end
	-- 	look("GetPlayerDataSG "..DataType.."     "..LuaPlayer[DataType])
	-- 	return LuaPlayer[DataType]
	-- end
	-- look("Can't Find LuaPlayer ")
	return CI_GetPlayerDataSG(PlayerSid,DataType)
end

function UpdatePlayerLogOut( PlayerSid ) --玩家退出游戏
	local PlayerFactionID = GetPlayerDataSG(PlayerSid,10)
	local QuestFactionList = GetPlayerQuestFactionList(PlayerSid)

	if PlayerFactionID > 0 or GetTableNLenth(QuestFactionList) > 0 then
		mOffinePlayer = OffinePlayer:new()
		mOffinePlayer:Init(PlayerSid,'QFactionList')
		AddoffinePlayer(mOffinePlayer)
		mOffinePlayer:GetData()
	end

	RemoveLuaPlayer(PlayerSid)

end

function UpdatePlayerLogin(PlayerSid ) --玩家登陆军团更新
	AddLuaPlayer(PlayerSid)
	local PlayerFactionID = GetPlayerDataSG(PlayerSid,10)
	local sPlayerName = GetPlayerDataSG(PlayerSid,4)



	local mOffinePlayer = GetoffinePlayerBysid(PlayerSid)
	if mOffinePlayer ~= nil then
		local QuestFactionData = mOffinePlayer:GetData()
		if QuestFactionData ~= nil then
			SaveQuestFactionList(PlayerSid,QuestFactionData)
			OnoffinePlayerOnline(PlayerSid)
		end
	end


	local bAgree = 0 				--无状态 军团长没有做操作

	--look("UpdatePlayerLogin "..PlayerFactionID.."    "..PlayerJoinFactionID)

	if PlayerFactionID > 0 then   --更新军团成员数据，如等级战斗力
		local FactionInfo = GetFactionInfoByID(PlayerFactionID)
		local curMeminfo = GetMemberInfoFromFaction(PlayerFactionID,sPlayerName,1) 
		if FactionInfo ~= nil then
			if curMeminfo == nil then --所在军团中没有自己，则可能被踢了
				look("CI_SetPlayerData FactionID curMeminfo 0")
				SetPlayerData(PlayerSid,10,0)  --更新军团ID
			else
				curMeminfo.PlayerName = sPlayerName
				curMeminfo.Title = curMeminfo.Title
				curMeminfo.PlayerLevle = GetPlayerDataSG(PlayerSid,3)  
				curMeminfo.wFightPower = GetPlayerDataSG(PlayerSid,8)	 
				curMeminfo.wHeadIcon = GetPlayerDataSG(PlayerSid,9) 
				UpdateFactionMembers(PlayerFactionID,curMeminfo,1)  --更新成员列表中的信息
			end
		else
			look("can't Found Faction")  
			look("CI_SetPlayerData FactionID  FactionInfo 0")
			SetPlayerData(PlayerSid,10,0)  --没有找到军团，可能是老数据。也可能已经被解散 更新军团ID
		end
	else
		local QuestFactionList = GetPlayerQuestFactionList(PlayerSid)
		if GetTableNLenth(QuestFactionList) > 0 then
			for i,v in ipairs(QuestFactionList) do
				if v[1] > 0 then  --玩家申请过军团
					if GetFactionInfoByID(v[1]) ~= nil then
						local curMeminfo = GetMemberInfoFromFaction(v[1],sPlayerName,0) 
						if curMeminfo == nil then --在申请列表中没有找到
							if GetMemberInfoFromFaction(v[1],sPlayerName,1) == nil then --在成员列表中查找
								 --通知玩家申请的请求被拒绝
								 bAgree = 2     
							else
								--通知玩家申请的请求同意
								 bAgree = 1  
								 SetPlayerData(PlayerSid,10,v[1])  --更新军团ID
								 UpdatePlayerQuestFactionID(PlayerSid,v[1],bAgree)
								 UpdatePlayerLogin(PlayerSid)    --更新军团成员信息
							end
						else
							--还在申请列表中未做过操作,只需要更新最新属性
							curMeminfo.PlayerName = sPlayerName
							curMeminfo.Title = 0
							curMeminfo.PlayerLevle = GetPlayerDataSG(PlayerSid,3)  
							curMeminfo.wFightPower = GetPlayerDataSG(PlayerSid,8)	 
							curMeminfo.wHeadIcon = GetPlayerDataSG(PlayerSid,9) 
							UpdateFactionMembers(v[1],curMeminfo,0)   --更新申请列表中的信息
						end
					else
						look("Join Faction Can't Found ")  --申请的军团不存在，恢复 。也可能已经被解散 更新军团ID
						v[1] = 0
						bAgree = 0
					end
					UpdatePlayerQuestFactionID(PlayerSid,v[1],bAgree)
				end
			end
		end

	end

end

function PlayerChangeNameInFaction( sid,oldName, newName )
	--look("PlayerChangeNameInFaction  "..sid)
	local PlayerFactionID = GetPlayerDataSG(sid,10)

	if PlayerFactionID > 0 then   
		local FactionInfo = GetFactionInfoByID(PlayerFactionID)
		local curMeminfo = GetMemberInfoFromFaction(PlayerFactionID,oldName,1) 
		if curMeminfo ~= nil then
			curMeminfo.PlayerName = newName
			UpdateFactionMembers(PlayerFactionID,curMeminfo,1)  --更新成员列表中的信息
			look("PlayerChangeNameInFaction  "..oldName.."   to  "..newName)
		end

		if m_factionManager[PlayerFactionID].CreatePlayerName == oldName then  --军团长
			m_factionManager[PlayerFactionID].CreatePlayerName = newName
		end

		OnChangeNameInSceneHurt(sid,oldName, newName)
	else
		local QuestFactionList = GetPlayerQuestFactionList(sid)
		for i,v in ipairs(QuestFactionList) do
			if v[1] > 0 then
				if GetFactionInfoByID(v[1]) ~= nil then
					local curMeminfo = GetMemberInfoFromFaction(v[1],oldName,0) 
					if curMeminfo ~= nil then
						curMeminfo.PlayerName = newName
						UpdateFactionMembers(v[1],curMeminfo,0)   --更新申请列表中的信息
						look("PlayerChangeNameInFaction  "..oldName.."   to  "..newName)
					end
				end
			end
		end
	end
end

function OnFactionDecGoods( sid,itype,id,inum )--玩家扣钱，道具，体力

	local PlayerFactionID = GetPlayerDataSG(sid,10)
	if PlayerFactionID > 0 then 
		 local FactionInfo = GetFactionInfoByID(PlayerFactionID)
		 local Pname = GetPlayerDataSG(sid,4)
		 local memberinfo = GetMemberInfoFromFaction(PlayerFactionID,Pname,1)
		 if FactionInfo ~= nil  and memberinfo ~= nil then
			if itype == GoodsType.endurance then 
				if FACTIONACTIVITYVALUE ~= nil then
					local addcount = inum / FACTIONACTIVITYVALUE[1]
					ChangeFactionActive(PlayerFactionID,addcount)  --改变活跃度
					memberinfo.LastActiveValue = memberinfo.LastActiveValue + addcount
					memberinfo.PlayerActiveValue = memberinfo.PlayerActiveValue + addcount
					FactionInfo.ProperyChange = 1
				end
			end	
		 end
	end
end

function OnAddFactionLog(FactionID,logType,param1,param2) --加入操作记录
	local FactionInfo = GetFactionInfoByID(FactionID)
	if FactionInfo ~= nil then
		local operate = {logType,param1,param2}
		if #FactionInfo.FactionLog + 1 > FACTIONOPERATENUM then
			table.remove(FactionInfo.FactionLog,1)	
		end
		table.insert(FactionInfo.FactionLog,operate)
	end
end

function OnShowFactionLog( sid ) --查看军团日志
	if sid ~= nil and sid > 0 then
		local PlayerFactionID = GetPlayerDataSG(sid,10)
		local FactionInfo = GetFactionInfoByID(PlayerFactionID)
		if FactionInfo ~= nil then
			SendFactionLog(sid,FactionInfo.FactionLog)
		end
	end
end


function OnModifyNotice(sid,szNotice )
	if sid ~= nil and sid > 0 then
		local PlayerFactionID = GetPlayerDataSG(sid,10)
		local szPlayerName = GetPlayerDataSG(sid,4)
		local FactionInfo = GetFactionInfoByID(PlayerFactionID)
		if FactionInfo ~= nil then
			local PlayerTitle = GetMemberTitle(PlayerFactionID,szPlayerName)
			if PlayerTitle < FACTIONDUTY[1] then
				look("Title Limit On Faction "..PlayerTitle)
				return
			end
			FactionInfo.Notice = szNotice
			FactionInfo.ModifyNTime = os.time()
			FactionInfo.ProperyChange = 1
			OnAddFactionLog(PlayerFactionID,FACTIONOPERATE.NOTICECHANGE,szPlayerName,0)
			SendModifyNoticeResult(sid,1)
			return
		end
	end
	SendModifyNoticeResult(sid,0)
end

function OnShowFactionNotice(sid) --查看军团公告
	local LuaPlayer = GetLuaPlayer(sid)
	local PlayerFactionID = GetPlayerDataSG(sid,10)
	local bsend = 0
	if PlayerFactionID > 0 then 
		 local FactionInfo = GetFactionInfoByID(PlayerFactionID)
		 if FactionInfo ~= nil then
			if LuaPlayer ~= nil then
				if LuaPlayer.ShowTime == nil then
					LuaPlayer.ShowTime = FactionInfo.ModifyNTime
					bsend = 1
				else
					if LuaPlayer.ShowTime < FactionInfo.ModifyNTime then
						LuaPlayer.ShowTime = FactionInfo.ModifyNTime
						bsend = 1
					end
				end
			end
			if bsend == 1 then
				SendFactionNotice(sid,FactionInfo.Notice)
			end
		 end
	end
end

function OnSendToAllFMemberEmail( sid,mailtitle,mailcontent )
	--look("OnSendToAllFMemberEmail "..sid)
	OnUpdateSceneData(sid)
	local PlayerTitle = GetFactionMemberTitle(sid)
	if PlayerTitle > FACTIONDUTY[2] then
		local PlayerFactionID = GetPlayerDataSG(sid,10)
		local szPlayerName = GetPlayerDataSG(sid,4)
		local FactionInfo = GetFactionInfoByID(PlayerFactionID)
		if FactionInfo ~= nil and FactionInfo.EmailSendCount < FACTIONEMAILSENDMAN then
			for k,v in pairs(FactionInfo.MemberList) do
				OnSendEmail(szPlayerName,v.PlayerName,mailtitle,mailcontent)
			end
			SendFcEmailResult(sid,FACTIONEMAILSENDMAN - FactionInfo.EmailSendCount )
			FactionInfo.EmailSendCount = FactionInfo.EmailSendCount + 1
			FactionInfo.ProperyChange = 1
			OnAddFactionLog(PlayerFactionID,FACTIONOPERATE.SENDEMAILALL,szPlayerName,0) --邮件发送日志
			return
		end	
		SendFcEmailResult(sid,0)
		return
	end
	SendFcEmailResult(sid,255)
end

function OnSendEmail(sendname,recvname,mailtitle,mailcontent) --军团成员发送邮件
	local MailInfo = {}    -- 邮件信息
	local RewardList = {}  --道具列表
	MailInfo.senderName = sendname
	MailInfo.recvname = recvname
	MailInfo.title = mailtitle
	MailInfo.content = mailcontent
	MailInfo.expiretime = FACTION_MAIL_EXTIME
	SendMailToPlayer(MailInfo,RewardList)
end

function OnSendEmailWithGoods(sendname,recvname,mailtitle,mailcontent,itemid,itemnum) --军团成员发送邮件
	local MailInfo = {}    -- 邮件信息
	local RewardList = {}  --道具列表
	RewardList[1] = {}
	RewardList[1].itype = GoodsType.item
	RewardList[1].itemid = itemid
	RewardList[1].num = itemnum

	MailInfo.senderName = sendname
	MailInfo.recvname = recvname
	MailInfo.title = mailtitle
	MailInfo.content = mailcontent
	MailInfo.expiretime = FACTION_MAIL_EXTIME
	SendMailToPlayer(MailInfo,RewardList,2)
end


function GetQuestEquipmentPepleNum( FactionID,equiptid) --军团申请中某件装备的人数
	local FactionInfo = GetFactionInfoByID(FactionID)
	if FactionInfo ~= nil then
		if FactionInfo.QuestEquipmentList ~= nil then
			if FactionInfo.QuestEquipmentList[equiptid] ~= nil then
				return #FactionInfo.QuestEquipmentList[equiptid]
			end
			return 0
		end
	end	
	return -1
end

function AddRequestEquipment(FactionID,sid,equiptid)
	local PlayerName = GetPlayerDataSG(sid,4)
	local FactionInfo = GetFactionInfoByID(FactionID)
	if FactionInfo ~= nil then
		if FactionInfo.QuestEquipmentList ~= nil then
			if FactionInfo.QuestEquipmentList[equiptid] == nil then
				FactionInfo.QuestEquipmentList[equiptid] = {}
			end
			table.insert(FactionInfo.QuestEquipmentList[equiptid],PlayerName)
		end
	end
end

function RemoveRequestEquipment( FactionInfo,equiptid,PlayerRank )
	if FactionInfo ~= nil then
		if FactionInfo.QuestEquipmentList[equiptid] ~= nil then
			FactionInfo.QuestEquipmentList[equiptid][PlayerRank] = nil
			table.remove(FactionInfo.QuestEquipmentList[equiptid],PlayerRank)
		end
	end
end

function GetRequestPlayerRank(FactionInfo,PlayerName,equiptid )
	if FactionInfo ~= nil and equiptid > 0 then
		if FactionInfo.QuestEquipmentList ~= nil then
			if FactionInfo.QuestEquipmentList[equiptid] ~= nil then
				for i,v in ipairs(FactionInfo.QuestEquipmentList[equiptid]) do
					if v == PlayerName then
						return i
					end
				end
			end
		end
	end
	return 0
end



function ffff(  )
	local senddata = {}
	for i=1,2 do
		local index = 0
		local sendcount = 45
		for k,v in pairs(m_factionManager) do
			table.insert(senddata,v)
			index = index + 1
			--look(v.FactionID)
			if index >= sendcount then
				break
			end
		end
	end


	SendScriptData(senddata)
end

function OnGetScriptData( param )
	look("OnGetScriptData ")
	--look(param)
	local count = 0
	for k,v in pairs(param) do
		for i,j in pairs(v) do
			look(j.FactionID)
			count = count + 1
		end
	end
	look("OnGetScriptData "..count)
end

