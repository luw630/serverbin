

function IsMemberOnline( PlayerName )
	local sid = GetPlayerSidByName(PlayerName)
	if sid ~= nil and sid > 0 then
		return true
	end
	return false
end

function OnShowFactioninfo( PlayerSid)  --��Ҳ鿴�������ھ�����Ϣ
	--look("OnShowFactioninfo")
	local PlayerFactionID = GetPlayerDataSG(PlayerSid,10)   --����ID
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
		SendFactioninfo(PlayerSid,factionInfo,factionInfo.MemberList)--�����������ھ�����Ϣ
		OnSynFaction(PlayerSid)
		OnShowFactionNotice(PlayerSid)
	end

end


function ChangePlayerFactionMoney( sid,dChangenum) --�ı������
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


function GetPlayerFactionMoney( sid ) --��ȡ������
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


function OnShowFactionList( PlayerSid,btype,sFactionName,FactionID)  --��Ҳ������о����б�  0  ȫ�����  1 ID���� 2 ���ֲ���
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
			SendFactionList(PlayerSid,FactionList)--���;����б�
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
	SendFactionList(PlayerSid,FactionList)--���;����б�
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


function PlayerAddFaction(FactionID,PlayerSid ) --���������뵽����
	local PlayerFactionID = GetPlayerDataSG(PlayerSid,10)   --����ID
	if PlayerFactionID > 0 then
		look("PlayerAddFaction Faile "..PlayerFactionID)
		SendJoinResult(PlayerSid,4)	 --����������
		return 
	end

	local factionInfo = GetFactionInfoByID(FactionID)
	if factionInfo == nil then
		look("PlayerAddFaction Faile Name Is't exist "..FactionID)
		SendJoinResult(PlayerSid,0)	 --����������
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
		SendJoinResult(PlayerSid,2)	 --����������
		return
	elseif bisadd == 2 then
		look("PlayerAddFaction AllReady")
		SendJoinResult(PlayerSid,1)	 --����������
		return
	end

	
	if #factionInfo.RequestList + 1 > QUESTLISTMAX then
		look("PlayerAddFaction RequestList Max "..#factionInfo.RequestList)
		SendJoinResult(PlayerSid,5)	 --����������
		return
	end
	
	local flevel = factionInfo.FactionLevel
	if flevel > #FACTIONMEMBERMAX then	--���ƾ��ų�Ա�������ñ��쳣
		look("Faction Member Config Cound't found Limit Number with "..tostring(flevel))
		SendJoinResult(PlayerSid,0)	 --����������
		return
	end
	
	if factionInfo.MemberNum + 1 > FACTIONMEMBERMAX[flevel] then
		look("PlayerAddFaction Member Max ")
		SendJoinResult(PlayerSid,6)	 --����������
		return
	end

	local MemberName = GetPlayerDataSG(PlayerSid,4)
	if factionInfo.KickInfo[MemberName] ~= nil then
		local kicktime = factionInfo.KickInfo[MemberName]
		if kicktime > 0 then
			local nInterval = os.difftime(os.time(),kicktime)
			if nInterval < FACTIONKICKJOINTIME then
				SendJoinResult(PlayerSid,7)	 --����������
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
			if quitinfo[3] == 1 then --����
				if quitinfo[1] == FactionID then
					if nInterval < FACTIONKICKJOINTIME then
						SendJoinResult(PlayerSid,7)	 --����������
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
					SendJoinResult(PlayerSid,8)	 --����������,ʱ��δ��
					look("Join Time Limit 1")
					return
				end 

				if quitday >= nowday then     --��ǰ�˳��ľ���
					if quittimedate.hour >= FactionSceneResetTime then
						SendJoinResult(PlayerSid,8)	 --����������,��5���Ժ��˳����ŵ�ǰ����������
						look("Join Time Limit 2  quittime "..quittimedate.hour)
						return
					end
				end
			end
		end
	end


	
	if JoinMemberInFaction(FactionID,MemberName,0) == false then
		look("JoinMemberInFaction Faile")
		SendJoinResult(PlayerSid,2)	 --����������
		return
	end

	UpdatePlayerQuestFactionID(PlayerSid,FactionID,0) --������ұ����������
	SendJoinResult(PlayerSid,1)	 --����������
	OnSynFaction(PlayerSid)
	factionInfo.ProperyChange = 1
	look("SendJoinTo Sucess "..FactionID)
end


function PlayerLeaveFaction( PlayerSid ) --����뿪����
	local PlayerFactionID = GetPlayerDataSG(PlayerSid,10)   --����ID
	if PlayerFactionID == 0 then
		look("PlayerLeaveFaction Faile "..PlayerFactionID)
		return false
	end


	local factionInfo = GetFactionInfoByID(PlayerFactionID)
	if factionInfo == nil then
		look("PlayerAddFaction Faile Name Is't exist "..PlayerFactionID)
		return false
	end

	local MemberName = GetPlayerDataSG(PlayerSid,4)  --�������
	if RemoveMemberList(PlayerFactionID,MemberName) == true then
		SetPlayerData(PlayerSid,10,0)         --���ù���ID
		UpdatePlayerQuestFactionID(PlayerSid,0,0) --��������ľ���ID0
		OnSynFaction(PlayerSid)
		return true
	end
	return false
end


function KickFromFaction(FactionID,kPlayerName ) --�߳�����
	local factionInfo = GetFactionInfoByID(FactionID)
	local kPlayerSid = GetPlayerSidByName(kPlayerName)
	if factionInfo == nil then
		look("PlayerAddFaction Faile Name Is't exist "..FactionID)
		return false
	end
	if RemoveMemberList(FactionID,kPlayerName) == true then
		if kPlayerSid ~= nil and kPlayerSid > 0 then  --������� 
			OnUpdateFactionPlayer(kPlayerName,0,0,0)
			SaveQuitFactionTime(kPlayerSid,FactionID,1)
		else
			if factionInfo.KickInfo == nil then     --��Ҳ����ߣ���¼�����ߵļ�¼
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

function GetPlayerFactionName( sid ) --��ȡ��Ҿ�������
	local PlayerFactionID = GetPlayerDataSG(PlayerSid,10)   --����ID
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

--���ų��������,������Ҳ鿴������Ϣ
-- 0  �鿴��������������б�     1   ͬ���ܾ���Ҽ���  2  ����ҳ�����  3 ��ɢ����
-- 5  �鿴�Լ�����ľ����б�       6   ȡ����������   7 �˳����ھ���   
-- 8  ��������					   9      
function PlayerManagerFaction( PlayerSid,mType,bAgree,szPlayerName ) 
	local PlayerFactionID = GetPlayerDataSG(PlayerSid,10)   --����ID
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

		if mType == 0 then  -- 0  �鿴��������������б�
			if PlayerTitle < FACTIONDUTY[1] then
				look("Title Limit On Faction "..PlayerTitle)
				return
			end
			SendManagerFaction(PlayerSid,1,mType,factionInfo.RequestList)
		elseif mType == 1 then --  ͬ���ܾ���Ҽ��룬����ǣ�浽���ܻᱻ������Ŵ���
			if PlayerTitle < FACTIONDUTY[1] then
				look("Title Limit On Faction "..PlayerTitle)
				return
			end
			if bAgree == 0 then   --�ܾ�
				local RefusePlayerSid = GetPlayerSidByName(szPlayerName)
				if RefusePlayerSid ~= nil and RefusePlayerSid > 0 then  --online
					local PlayerQFactionList = GetPlayerQuestFactionList(RefusePlayerSid)
					for i,v in ipairs(PlayerQFactionList) do
						if v[1] == PlayerFactionID  then 
						    v[2] = 2
							SendManagerFaction(PlayerSid,1,mType)
							RemoveJoinList(PlayerFactionID,szPlayerName)  --���Լ��������������
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
									RemoveJoinList(PlayerFactionID,szPlayerName)  --���Լ��������������
									OnUpdateFactionPlayer(szPlayerName,0,PlayerFactionID,2)
									return
								end
							end
						end
					end
				end
			elseif bAgree == 1 then --ͬ����Ҽ��룬����ڼ��һ����������Ϊ��ʱ��������ʱ���Ѿ��ı��
				local AddPlayerSid = GetPlayerSidByName(szPlayerName)
				local PlayerQFactionList = nil
				if AddPlayerSid ~= nil and AddPlayerSid > 0 then  --online
					PlayerQFactionList = GetPlayerQuestFactionList(AddPlayerSid)
					for i,v in ipairs(PlayerQFactionList) do
						if v[1] > 0 and v[2] == 1  then --�Ѿ����������ż���
							look("PlayerManagerFaction Faile Had In Faction")
							SendManagerFaction(PlayerSid,2,mType)
							RemoveJoinList(PlayerFactionID,szPlayerName)  --���Լ��������������
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
								if v[1] > 0 and v[2] == 1  then --�Ѿ����������ż���
									look("PlayerManagerFaction Faile Had In Faction")
									SendManagerFaction(PlayerSid,2,mType)
									RemoveJoinList(PlayerFactionID,szPlayerName)  --���Լ��������������
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

				if JoinMemberInFaction(PlayerFactionID,szPlayerName,1) == false then --���뵽����
					look("JoinMemberInFaction Faile")
					SendManagerFaction(PlayerSid,0,mType)
					return
				end

				for i,v in ipairs(PlayerQFactionList) do
					if v[1] > 0 then
						local factionInfo = GetFactionInfoByID(v[1])
						if factionInfo ~= nil then
						    if RemoveJoinList(v[1],szPlayerName) == true then   --�������б���ɾ��
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
		elseif mType == 2 then -- ����ҳ�����
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
		elseif mType == 3 then --��ɢ����
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
		if mType == 5 then --�鿴�Լ�����ľ����б�
			local PlayerQFactionList = GetPlayerQuestFactionList(PlayerSid)
			for i,v in ipairs(PlayerQFactionList) do
				if v[1] > 0 then
					local QjoinID = v[1]
					if MemberIsInFaction(QjoinID,ManagerName,0) == false then  --�����������Ҳ���
						if MemberIsInFaction(QjoinID,ManagerName,1) == false then --��ԱҲû��Ӧ�ñ��߾ܾ�
							UpdatePlayerQuestFactionID(PlayerSid,QjoinID,2)  --���¾ܾ�
						else
							UpdatePlayerQuestFactionID(PlayerSid,QjoinID,1)  --����ͬ��
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
		elseif mType == 6 then --6   ȡ������ 
			local PlayerQFactionList = GetPlayerQuestFactionList(PlayerSid)
			if bAgree == 0 then  --�������������Ϊȡ��������ŵ�����
				for i,v in ipairs(PlayerQFactionList) do
					if v[1] > 0 then
						local factionInfo = GetFactionInfoByID(v[1])
						if factionInfo ~= nil then
						    if RemoveJoinList(v[1],ManagerName) == true then   --�������б���ɾ��
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
						    if RemoveJoinList(QFactionID,ManagerName) == true then   --�������б���ɾ��
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
		elseif mType == 7 then --7 �˳����ھ���
			local PlayerFactionID = GetPlayerDataSG(PlayerSid,10)   --����ID
			local factionInfo = GetFactionInfoByID(PlayerFactionID)
			local bDisband = 0

			if factionInfo == nil then
				look("Get Faction nil")
				SendManagerFaction(PlayerSid,0,mType)
				OnSynFaction(PlayerSid)
				return
			end

			if GetFactionMasterName(PlayerFactionID) == ManagerName then --���ų�
				if factionInfo.MemberNum - 1 <= 0 then   --ֱ�ӽ�ɢ
					bDisband = 1
					if onDisbandFaction(PlayerFactionID) == true then
						SendManagerFaction(PlayerSid,1,mType)
					else
						SendManagerFaction(PlayerSid,0,mType)
					end
					return 
				else
					SetFcCreatePlayer(PlayerFactionID)   --�������ų�
				end
			end

			if PlayerLeaveFaction(PlayerSid) == true then
				SendManagerFaction(PlayerSid,1,mType)
			else
				SendManagerFaction(PlayerSid,0,mType)
			end

			if bDisband == 0 then  --�˳�����
				SaveQuitFactionTime(PlayerSid,PlayerFactionID,0)
			end
		elseif mType == 8 then --8 ��������
			--look("mType "..mType.." bAgree "..bAgree)
			local PlayerTitle = GetMemberTitle(PlayerFactionID,ManagerName)
			local memberinfo =  GetMemberInfoFromFaction(PlayerFactionID,szPlayerName,1)
			local factionInfo = GetFactionInfoByID(PlayerFactionID)
			if memberinfo ~= nil then

				if bAgree == FACTIONDUTY[4] then
					if GetFactionMasterName(PlayerFactionID) == ManagerName then --���ų�
						if ChangeFactionLeader(PlayerFactionID,szPlayerName) == true then
							SendManagerFaction(PlayerSid,1,mType)
							OnAddFactionLog(PlayerFactionID,FACTIONOPERATE.UPDATETITLE,szPlayerName,bAgree)
							return
						end
					end
				end


				if PlayerTitle <= bAgree then --�˴����������Ϊ������ְ��
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
						SendManagerFaction(PlayerSid,3,mType)       --ְλ��������
						return
					end
				else
					if Cnum >= FACTIONDUTYNUM[2] then
						look(" Title Num Limit "..Cnum)
						SendManagerFaction(PlayerSid,3,mType)    --ְλ��������
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

function GetQuitFactionInfo( PlayerSid ) --��ȡ����˳�������Ϣ
	local PlayerQFactionList = GetPlayerQuestFactionList(PlayerSid)
	if PlayerQFactionList.QuitInfo == nil then
		PlayerQFactionList.QuitInfo = {0,0,0}    --�����˳��������Ϣ��ʱ�����һ������ID ,����ID + �˳�ʱ�� + �Ƿ��������
	end
	return PlayerQFactionList.QuitInfo
end

function SaveQuitFactionTime( PlayerSid,FactionID,bIskick ) --��������ϴ��˳����ŵ�ʱ��,��չ�����б��еĵ�������������  ����ID + �˳�ʱ��
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

function OnSynFaction( PlayerSid )  --�������ͬ��������Ϣ
	local FactionInfo = {}
	local QjoinList = GetPlayerQuestFactionList(PlayerSid)[1]
	FactionInfo.FactionID = GetPlayerDataSG(PlayerSid,10)
	FactionInfo.JoinID = QjoinList[1]
	FactionInfo.JoinState = QjoinList[2]
	FactionInfo.FactionMoney = GetPlayerFactionMoney(PlayerSid)
	SendSynFaction(PlayerSid,FactionInfo)
--	look("OnSynFaction")
end

function OnSynFactionByName( szPlayerName )  --�������ͬ��������Ϣ
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

function UpdatePlayerQuestFaction( PlayerSid,qFactionList) --��������ľ���ID
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


function UpdatePlayerQuestFactionID( PlayerSid,FactionID,bAgree) --��������ľ���ID 
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
					if v[2] == 2 then     --�Ѿ����ܾ���
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

function UpdatePlayerLogOut( PlayerSid ) --����˳���Ϸ
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

function UpdatePlayerLogin(PlayerSid ) --��ҵ�½���Ÿ���
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


	local bAgree = 0 				--��״̬ ���ų�û��������

	--look("UpdatePlayerLogin "..PlayerFactionID.."    "..PlayerJoinFactionID)

	if PlayerFactionID > 0 then   --���¾��ų�Ա���ݣ���ȼ�ս����
		local FactionInfo = GetFactionInfoByID(PlayerFactionID)
		local curMeminfo = GetMemberInfoFromFaction(PlayerFactionID,sPlayerName,1) 
		if FactionInfo ~= nil then
			if curMeminfo == nil then --���ھ�����û���Լ�������ܱ�����
				look("CI_SetPlayerData FactionID curMeminfo 0")
				SetPlayerData(PlayerSid,10,0)  --���¾���ID
			else
				curMeminfo.PlayerName = sPlayerName
				curMeminfo.Title = curMeminfo.Title
				curMeminfo.PlayerLevle = GetPlayerDataSG(PlayerSid,3)  
				curMeminfo.wFightPower = GetPlayerDataSG(PlayerSid,8)	 
				curMeminfo.wHeadIcon = GetPlayerDataSG(PlayerSid,9) 
				UpdateFactionMembers(PlayerFactionID,curMeminfo,1)  --���³�Ա�б��е���Ϣ
			end
		else
			look("can't Found Faction")  
			look("CI_SetPlayerData FactionID  FactionInfo 0")
			SetPlayerData(PlayerSid,10,0)  --û���ҵ����ţ������������ݡ�Ҳ�����Ѿ�����ɢ ���¾���ID
		end
	else
		local QuestFactionList = GetPlayerQuestFactionList(PlayerSid)
		if GetTableNLenth(QuestFactionList) > 0 then
			for i,v in ipairs(QuestFactionList) do
				if v[1] > 0 then  --������������
					if GetFactionInfoByID(v[1]) ~= nil then
						local curMeminfo = GetMemberInfoFromFaction(v[1],sPlayerName,0) 
						if curMeminfo == nil then --�������б���û���ҵ�
							if GetMemberInfoFromFaction(v[1],sPlayerName,1) == nil then --�ڳ�Ա�б��в���
								 --֪ͨ�����������󱻾ܾ�
								 bAgree = 2     
							else
								--֪ͨ������������ͬ��
								 bAgree = 1  
								 SetPlayerData(PlayerSid,10,v[1])  --���¾���ID
								 UpdatePlayerQuestFactionID(PlayerSid,v[1],bAgree)
								 UpdatePlayerLogin(PlayerSid)    --���¾��ų�Ա��Ϣ
							end
						else
							--���������б���δ��������,ֻ��Ҫ������������
							curMeminfo.PlayerName = sPlayerName
							curMeminfo.Title = 0
							curMeminfo.PlayerLevle = GetPlayerDataSG(PlayerSid,3)  
							curMeminfo.wFightPower = GetPlayerDataSG(PlayerSid,8)	 
							curMeminfo.wHeadIcon = GetPlayerDataSG(PlayerSid,9) 
							UpdateFactionMembers(v[1],curMeminfo,0)   --���������б��е���Ϣ
						end
					else
						look("Join Faction Can't Found ")  --����ľ��Ų����ڣ��ָ� ��Ҳ�����Ѿ�����ɢ ���¾���ID
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
			UpdateFactionMembers(PlayerFactionID,curMeminfo,1)  --���³�Ա�б��е���Ϣ
			look("PlayerChangeNameInFaction  "..oldName.."   to  "..newName)
		end

		if m_factionManager[PlayerFactionID].CreatePlayerName == oldName then  --���ų�
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
						UpdateFactionMembers(v[1],curMeminfo,0)   --���������б��е���Ϣ
						look("PlayerChangeNameInFaction  "..oldName.."   to  "..newName)
					end
				end
			end
		end
	end
end

function OnFactionDecGoods( sid,itype,id,inum )--��ҿ�Ǯ�����ߣ�����

	local PlayerFactionID = GetPlayerDataSG(sid,10)
	if PlayerFactionID > 0 then 
		 local FactionInfo = GetFactionInfoByID(PlayerFactionID)
		 local Pname = GetPlayerDataSG(sid,4)
		 local memberinfo = GetMemberInfoFromFaction(PlayerFactionID,Pname,1)
		 if FactionInfo ~= nil  and memberinfo ~= nil then
			if itype == GoodsType.endurance then 
				if FACTIONACTIVITYVALUE ~= nil then
					local addcount = inum / FACTIONACTIVITYVALUE[1]
					ChangeFactionActive(PlayerFactionID,addcount)  --�ı��Ծ��
					memberinfo.LastActiveValue = memberinfo.LastActiveValue + addcount
					memberinfo.PlayerActiveValue = memberinfo.PlayerActiveValue + addcount
					FactionInfo.ProperyChange = 1
				end
			end	
		 end
	end
end

function OnAddFactionLog(FactionID,logType,param1,param2) --���������¼
	local FactionInfo = GetFactionInfoByID(FactionID)
	if FactionInfo ~= nil then
		local operate = {logType,param1,param2}
		if #FactionInfo.FactionLog + 1 > FACTIONOPERATENUM then
			table.remove(FactionInfo.FactionLog,1)	
		end
		table.insert(FactionInfo.FactionLog,operate)
	end
end

function OnShowFactionLog( sid ) --�鿴������־
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

function OnShowFactionNotice(sid) --�鿴���Ź���
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
			OnAddFactionLog(PlayerFactionID,FACTIONOPERATE.SENDEMAILALL,szPlayerName,0) --�ʼ�������־
			return
		end	
		SendFcEmailResult(sid,0)
		return
	end
	SendFcEmailResult(sid,255)
end

function OnSendEmail(sendname,recvname,mailtitle,mailcontent) --���ų�Ա�����ʼ�
	local MailInfo = {}    -- �ʼ���Ϣ
	local RewardList = {}  --�����б�
	MailInfo.senderName = sendname
	MailInfo.recvname = recvname
	MailInfo.title = mailtitle
	MailInfo.content = mailcontent
	MailInfo.expiretime = FACTION_MAIL_EXTIME
	SendMailToPlayer(MailInfo,RewardList)
end

function OnSendEmailWithGoods(sendname,recvname,mailtitle,mailcontent,itemid,itemnum) --���ų�Ա�����ʼ�
	local MailInfo = {}    -- �ʼ���Ϣ
	local RewardList = {}  --�����б�
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


function GetQuestEquipmentPepleNum( FactionID,equiptid) --����������ĳ��װ��������
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

