--[[
file:	player.lua
author:	wk
update:	2015-01-26
desc:	player data init interface
�״ε�½(��Ϸ��ֻ�����һ��,֮ǰû�л�������,�л���󲻻��) OnPlayerFristLogin �����lua���ݳ�ʼ���Լ��������ܴ���,playerDataInit֮����ܲ����������
����(���ÿ�����߶������,���޻��涼��)OnPlayerOnline ���������Ҫ���Ĵ���,����ͬ�����ݸ�ǰ̨
���� OnPlayerLogout ��lua���ݱ��洦��,�����dbMgr[sid]����,��ͨ��dbMgr[sid]==nil�ж�����ڲ�����
����Ԥ��ÿ5����ȫ�����data���ݱ���һ��;1Сʱ ����һ�����繫������

]]--

local tableName=tostring("data")

--����״ε�½�������
function OnPlayerFristLogin(sid)
	look('OnPlayerOnline��ҵ�½lua�������,sid=='..tostring(sid))
	--��ʼ�����lua����,������ڴ˺�����ͷ
	playerDataInit( sid )  
	
	if dbMgr[sid]==nil or dbMgr[sid].data==nil then 
		look("playerDataInit fail ,sid="..sid)
		return
	end
	local account=GetPlayerData(0,29)
	db_StaySetOnLogin(account) --��½ʱд�����ݿ�,������
	PlayerOnlineFriend(sid)
	--CheckAllFirends(sid)
	ActivityOnPlayerLogin(sid)  --��ҵ�½�����Ļ
	DbDataService_PlayerLogin(sid)  --������������

	--�������޸����LUA������������ʱ�ӿ�
	db_GetVIPExp(sid) --�޸�VIP����
	--db_GetRegTime(sid)
	OnChangeNameCount(sid) --�޸���������
	set_Ctime(sid) --�޸���˺Ŵ���ʱ��
	UpdatePlayerLogin(sid)
	OnUpdataPrayerPointLogin(sid)
	--look(gid)
	--look(GetPlayerData(0,GPP_MYACCOUNT))
	
end
--������ߵ������
function OnPlayerOnline(sid)
	if dbMgr[sid]==nil or dbMgr[sid].data==nil then
		look("OnPlayerOnline fail ,sid="..sid)
		return
	end
	act_login(sid)--��ҵ�¼������޸�
	SynInfoFirst(sid)-- ͬ�����һЩ�������ݸ�ǰ̨
	FillNotificationData()--ϵͳ֪ͨ������
	SynMissionDataToClient(sid)--ͬ����������ݵ��ͻ���
	SynMissionActivenessDataToClient(sid)--ͬ�������Ծ�����ݵ��ͻ���
	SynHeroExDataToClient(sid)--ͬ������佫��������ݵ��ͻ���
	SendRewardState(sid)
	SynMembershipDate(sid) --����ͬ���¿���Ա����
	--Callback_WeekReMoney(sid)--֪ͨ�ͻ�����ҵĻ�����Ϣ
	RemoneyActivity:OnTrigger(sid)
	UpdatePlayerLogin(sid)
	OnUpdataPrayerPointLogin(sid)

end

--������ߵ������
function OnPlayerLogout()
	local sid=CI_GetPlayerDataSG(0,0)
	--look('OnPlayerLogout�������lua�������,sid=='..tostring(sid))
	if dbMgr[sid]==nil then 
		look('OnPlayerLogout,no player now____sid='..tostring(sid))
		return 
	end
	FriendLogout(sid)--�˳�֪ͨ��������

	UpdatePlayerLogOut(sid)

	--����lua����,����ŵ��˺������
	SI_savePlayerData(sid,1)

	DbDataService_PlayerLogout(sid)  --������������


	--look(dbMgr)
end


--��Ҷ�ʱ����
function OnPlayerDataRefresh(sid)
	if dbMgr[sid]==nil or dbMgr[sid].data==nil then
		look("OnPlayerOnline fail ,sid="..sid)
		return
	end
	act_login(sid)--��ҵ�¼������޸�
	SynInfoFirst(sid)-- ͬ�����һЩ�������ݸ�ǰ̨
	FillNotificationData()--ϵͳ֪ͨ������
	SynMissionDataToClient(sid)--ͬ����������ݵ��ͻ���
	SynMissionActivenessDataToClient(sid)--ͬ�������Ծ�����ݵ��ͻ���
	SynHeroExDataToClient(sid)--ͬ������佫��������ݵ��ͻ���
end


--��һ��ʱ��ʼ��lua����
function playerDataInit( sid )
	if dbMgr[sid]==nil then --Ԫ�����ѳ�ʼ��Ϊ{},������,��˵��������c++��û����
		return false
	end
	if  dbMgr[sid].data==nil  then
		local Pdata = LoadPlayerTable(tableName, sid)
		if Pdata==nil then
			local pdata_temp={[1]=1} --����汾c++�����±����������ٳ�ʼ��һ��ֵ,��Ҫ�г���,�����л������Ż�
			SavePlayerTable(tableName,pdata_temp, sid)
			Pdata = LoadPlayerTable(tableName, sid)
		end
		if Pdata~=nil then --c++������ݳ�ʼ�����
			dbMgr[sid].data=Pdata
			dbMgr[sid].temp={}
		end
	end
	--look("���lua���ݳ�ʼ���ɹ�,sid="..sid)
end
--��������ʱ����,����������� ,itype=1�������߱�������,�ҽ�dbMgr[sid]���;dbMgrԪ����Ϊ��ȫ����ֱ����lua���ÿ�,0ֻ����,�����
function SI_savePlayerData(sid,itype)
	if dbMgr[sid]==nil then 
		look('savePlayerData,no player now____sid='..sid)
		return 
	end
	--����lua����
	-- look('�������lua����')
	if dbMgr[sid].data==nil then 
		look('SI_savePlayerData fail,possible erro:server down and townOn,no player now____sid='..sid)
		return
	end
	--look("SI_savePlayerData  "..sid)
	SavePlayerTable(tableName,dbMgr[sid].data, sid,itype)--c++����,20150126�����ӵ�4������
end


--��ǰ̨Ŀǰ����֧��lua,��½��ʱ��ͬ���ű���Ϣ��ǰ̨ 
--[[
	��Ҫ�������ݷ���dataTb�д���c++;index�������ɹ��ܾ���
]]
local dataTb={}
function SynInfoFirst(sid)
	local index = 1
	index = checkin_firstlogin(sid,dataTb,index)--1-4 ǩ��
	index = vip_firstlogin(sid,dataTb,index)--5-7	vip
	index = LOLActivation_firstlogin(sid, dataTb, index)--8-10 һЩ����
	index = GetCount(sid,dataTb,index)	-- 11  ��Ҹ�������
	index = act_firstLogin(sid,dataTb,index) -- 12 - 24 ��ʱ�����
	index = exdata_firstlogin(sid,dataTb,index)  --25-29 �׳����ݣ��״��佫ѵ����ѵ�������ݣ�������������Ƿ��Ѿ���������ݣ�����ڷ�������ȫ��ID�����ͻ��˴�һЩ�������ݣ�����Ҵ���Ĺ���ն���ؿ�����������
	
	--�����ռ���ɺ���c++,���������
	CI_SynPlayerDataSG(dataTb)
end

--�ж�����Ƿ�����
function IsOnline(sid)
	if dbMgr[sid]==nil then 
		return 
	end
	if  dbMgr[sid].data==nil then 
		return
	end
	return true
end

function OnPlayerDecGoods_SG( sid,itype,id,inum ) --��ҿ�Ǯ�����ߣ�����
 	if itype == GoodsType.endurance then   --�����۳�
 		OnFactionDecGoods(sid,itype,id,inum)
 	end
end


