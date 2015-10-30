
function OnClickTestCopyScene(npcid)
	rfalse('on click test copy scene npc['..tostring(npcid)..']')
	if npcid == 1 then 
		-- ��ʾ
		CS_OnProcListDisplay(npcid)
	elseif npcid == 2 then 
		-- ��׼�����
		ret, info = CS_OnOpenCSPanel( )
		rfalse('code: '..tostring(ret)..'   '..tostring(info))
	--[[elseif npcid == 3 then
		-- ׼��
		CS_OnProcReady()]]--
	elseif npcid == 4 then
		-- ȡ�ý���
		CS_OnProcAward()
	else
		SetMessage(80000,����NPC[npcid].talk,0,0)
	end

end

-- ֪ͨ�ͻ�����ʾ�ɽӸ��������б�
g_ListCopySceneID = {}
local function __SendListCSID( listCopySceneID )
	local sbuff = "������ȥ�ĸ����У�#"
	for k,v in pairs(listCopySceneID) do
		if v ~= nil then
			sbuff = sbuff..��������[v].��������.."#"
		else
			break
		end
	end
	sbuff = sbuff.."�ر�#"
	SetMessage( MENU.�򿪸�������, sbuff, 0, 0)

	--��Ҫ�� listCopySceneID ��ʱ����һ��,����ѡ�񸱱��Ժ���Ҹ�����ţ����һ��Ĭ���ǹرռ�
	local sid = GetPlayerData(17)
	g_ListCopySceneID[sid] = listCopySceneID
end

-- ������ʾ�ĸ���ID�б�
local function __FilterDisplay( playerLevel, listCopySceneID)
	local listID = {}	--��ʾ�ĸ������
	local i = 1
	for k,v in pairs(listCopySceneID) do
		if v ~= nil then
			if ��������[v].��ʾ�ȼ����� <= playerLevel then
				local teamInfo = GetTeamInfo()
				if teamInfo == nil or ��������[v].������� >= table.maxn(teamInfo) then
					listID[i] = v
					i = i + 1
				end
			end
		else
			break
		end
	end
	return listID
end

-- ����npcIDȡ�ö�Ӧ��NPC���������и�������ID�б�
local function __GetIDListFromNPC(npcID)
	return NPC���������б�[npcID]
end

-- �ж��Ƿ����׼����ǰ��������
local function __OnCheckReadyCondition(condition, playerSID)
	rfalse('__OnCheckReadyCondition')

	if condition == nil or playerSID == nil then
		return false, '��������'
	end
	-- �жϵȼ� 
	local level = GetPlayerData(1)
	if level < condition.�ȼ� then
		return false, '�ȼ�����'
	end
	
	-- �жϾ��帱����׼������
	local money = GetPlayerData(48)
	if money<condition.��Ǯ then
		return false,'���Ľ�Ǯ����'
	end

	local rt;
	for k,v in pairs(condition.����) do
		rt = CheckGoods(v.id,v.num,1,playerSID)
		if rt==false or rt==0 then
			return false, '����'..v.name..'����'
		end
	end

	return true
end

--��ʾ��Ա׼����Ϣ���ַ���
local function __CS_GetTeamPrepareInfo( copyScene)
	local teamPrepare = ""
	local teamInfo = GetTeamInfo()
	if teamInfo ~= nil and copyScene ~= nil then
		for i = 1, table.maxn( teamInfo), 1 do
			local name = string.format("%11s", teamInfo[i].name)
			if copyScene.PlayerSIDList[teamInfo[i].staticId] == true then
				teamPrepare = teamPrepare .. name .. "  ��׼��\n"
			else
				teamPrepare = teamPrepare .. name .. "  δ׼��\n"
			end
		end
	else
		return ""
	end
	return teamPrepare
end

-- �����������б���ʾ
function CS_OnProcListDisplay(npcID)

	-- ȡ����ҵĸ���״̬����
	local sid = GetPlayerData(17)
	local playerData = CS_GetPlayerData(sid)

	-- �����һ�εĸ���������û��ȡ,��ô���ܽ����µĸ���
	if playerData.Complete ~= nil then
		SendTipsMsg(1,'��һ�εĸ���������δ��ȡ')
		return false, '��һ�εĸ���������δ��ȡ'
	end

	local playerTemp = CS_GetPlayerTemp(sid)
	if playerTemp.TaskID ~= nil then
		SendTipsMsg(1,'�Ѿ���ȡ��������')
		return false, '�Ѿ���ȡ��������'
	end

	local teamID = GetPlayerData(12)
	local isTeamLeader = GetPlayerData(13)
	local leader = true
	if teamID ~= 0 and isTeamLeader == 0 then
		SendTipsMsg(1,'�㲻�Ƕӳ������ܽ�������')
		return false, '�Ƕӳ����ܽ�������'
	end
	rfalse('׼����ȡ��������')

	-- ȡ����ҵ�SID
	local level = GetPlayerData( PlayerProperty.�ȼ� )

	-- ��NPC��ȡ�������ĸ�������ID�б�
	local listCopySceneID = __GetIDListFromNPC(npcID)

	-- ͨ�������������˵����ɼ��ĸ�������ID
	local listCopySceneID = __FilterDisplay( level, listCopySceneID)

	-- ֪ͨ�ͻ�����ʾ�ɽӸ��������б�
	local SendListCSID = __SendListCSID( listCopySceneID)

end

--[[
/*
����������׼��

����ֵ:
true: �ɹ�
false, xxx: ʧ�ܣ�xxxΪ������Ϣ
*/
--]]
function CS_OnOpenCSPanel( )

	-- ȡ����ҵĸ���״̬����
	local sid = GetPlayerData(17)
	local playerData = CS_GetPlayerData(sid)

	-- �����һ�εĸ���������û��ȡ,��ô���ܽ����µĸ���
	if playerData.Complete ~= nil then
		SendTipsMsg(1,'��һ�εĸ���������δ��ȡ')
		return false, '��һ�εĸ���������δ��ȡ'
	end

	local playerTemp = CS_GetPlayerTemp(sid)
	local teamID = GetPlayerData(12)
	local isTeamLeader = GetPlayerData(13)
	
	if playerTemp.CopySceneGID ~= nil then
		local copySceneInfo = CS_GetData(playerTemp.CopySceneGID)
		if copySceneInfo~=nil then
			return false, '�ظ���'
		else
			rfalse('������Ч��CopySceneGID,��������Ч���ݴ���')
			dbMgr[sid].temp.CopySceneData = nil
		end
	end

	-- �ж��Ƿ��Ƕӳ��������ǵ���
	local leader = true
	if teamID ~= 0 and isTeamLeader == 0 then
		leader = false
	end

	local TaskID = 0
	if teamID ~= 0 and leader == false then
		--ȡ�ӳ���������
		local teamInfo = GetTeamInfo( )
		local teamLeaderSID = teamInfo[1].staticId
		local leaderTemp = CS_GetPlayerTemp(teamLeaderSID)

		if leaderTemp.TaskID==nil then
			SendTipsMsg(1,'�ӳ�δ�Ӹ�������')
			return false, '�ӳ�δ�Ӹ�������'
		end
		TaskID = leaderTemp.TaskID
	else
		if playerTemp.TaskID==nil then
			SendTipsMsg(1,'δ�Ӹ�������')
			return false, 'δ�Ӹ�������'
		end
		TaskID = playerTemp.TaskID
	end

	local copySceneConfig = ��������[TaskID]
	if copySceneConfig == nil then
		return false, '�������ò�����'
	end

	-- ȡ����ʱ����ID
	local playerTemp = CS_GetCopySceneInfo( TaskID )
	if playerTemp == nil then    -- ��Ա������Ͷӳ��Ĳ�һ��
		return false, '��ʱ��������ʧ��'
	end
	--rfalse( 'playerTemp.CopySceneGID = ' .. tostring(playerTemp.CopySceneGID) )
	local copySceneInfo = CS_GetData(playerTemp.CopySceneGID)
	if copySceneInfo==nil then
		rfalse('������Ч��CopySceneGID,��������Ч���ݴ���')
		dbMgr[sid].temp.CopySceneData = nil
		return
	end

	if copySceneInfo.PlayerCount >= copySceneConfig.������� then
		SendTipsMsg(1,'���������������')
		return false, '���������������'
	end
	local wndCopyScene = {}

	if leader == true then
		--��ʾ��Ա׼����Ϣ���ַ���
		local teamPrepare = __CS_GetTeamPrepareInfo( copySceneInfo )

		-- ֪ͨ�ͻ�����ʾ��������
		wndCopyScene = {
			cleanup = true,
			image_1	=  '200,100,interface/CopyScene/�����װ�.spr',
			image_2	=  '209,132,interface/CopyScene/����'..tostring(TaskID)..'.spr',
			Static_6 = { pos = '423,373,', Text = copySceneConfig.����, setsize = '259,170'},
			text_7 = '696,373,'..teamPrepare..',12,124',				-- ��Ա׼���б�
			text_80 = '278,375,'..copySceneConfig.׼������.�ȼ�..'��,12,124',
			text_81 = '278,395,'
				..string.format("%02s",tostring(copySceneConfig.����ʱ��.��ʼ.hour))..':'
				..string.format("%02s", tostring(copySceneConfig.����ʱ��.��ʼ.min))..'����'
				..string.format("%02s",tostring(copySceneConfig.����ʱ��.����.hour))..':'
				..string.format("%02s",tostring(copySceneConfig.����ʱ��.����.min))..',12,124',
			text_82 = '278,415,'..copySceneConfig.�������..'��,12,124',
			text_83 = '278,435,'..copySceneConfig.׼������.��Ǯ..',12,124',
			text_84 = '278,515,'..copySceneConfig.���Ŀ��..',12,124',
			SprButton_1 = { pos = '343,564', image = 'Interface/CopyScene/���븱��.spr', action = '@rc,1' },
			SprButton_2 = { pos = '480,564', image = 'Interface/CopyScene/������ť.spr', action = '@rc,2,@E' },
			SprButton_4 = { pos = '620,564', image = 'Interface/CopyScene/ȡ��.spr', action = '@rc,4,@E' },
			SprButton_5 = { pos = '785,103', image = 'Interface/CopyScene/�ر�.spr', action = '@rc,4,@E' },
		}

		for k, v in pairs( copySceneConfig.׼������.���� ) do
			if v.id ~= nil then
				local str = "ItemHolder_9" .. tostring(k)
				local x = 218 + ( k - 1 ) * 39
				wndCopyScene[str] = {
					pos = tostring(x)..",470",					
					dragable = false,
					itemIDandNum = tostring(v.id)..","..tostring(v.num),
				}
			end
		end

	else
		local teamPrepare = __CS_GetTeamPrepareInfo( copySceneInfo)
		wndCopyScene = {
			cleanup = true,
			image_1	=  '200,100,interface/CopyScene/�����װ�.spr',
			image_2	=  '209,132,interface/CopyScene/����'..tostring(TaskID)..'.spr',
			Static_6 = { pos = '423,373,', Text = copySceneConfig.����, setsize = '259,170'},
			text_7 = '696,373,'..teamPrepare..',12,124',
			text_80 = '278,375,'..copySceneConfig.׼������.�ȼ�..'��,12,124',
			text_81 = '278,395,'
				..string.format("%02s",tostring(copySceneConfig.����ʱ��.��ʼ.hour))..':'
				..string.format("%02s", tostring(copySceneConfig.����ʱ��.��ʼ.min))..'����'
				..string.format("%02s",tostring(copySceneConfig.����ʱ��.����.hour))..':'
				..string.format("%02s",tostring(copySceneConfig.����ʱ��.����.min))..',12,124',
			text_82 = '278,415,'..copySceneConfig.�������..'��,12,124',
			text_83 = '278,435,'..copySceneConfig.׼������.��Ǯ..',12,124',
			text_84 = '278,515,'..copySceneConfig.���Ŀ��..',12,124',
			SprButton_2 = { pos = '343,564', image = 'Interface/CopyScene/������ť.spr', action = '@rc,2,@E' },
			SprButton_3 = { pos = '480,564', image = 'Interface/CopyScene/׼��.spr', action = '@rc,3' },
			SprButton_4 = { pos = '620,564', image = 'Interface/CopyScene/ȡ��.spr', action = '@rc,4,@E' },
			SprButton_5 = { pos = '785,103', image = 'Interface/CopyScene/�ر�.spr', action = '@rc,4,@E' },
		}
	end
	for k, v in pairs( copySceneConfig.׼������.���� ) do
		if v.id ~= nil then
			local str = "ItemHolder_9" .. tostring(k)
			local x = 218 + ( k - 1 ) * 39
			wndCopyScene[str] = {
				pos = tostring(x)..",470",
				dragable = false,
				itemIDandNum = tostring(v.id)..","..tostring(v.num),
			}
			end
	end

	WndCustomize( wndCopyScene, "WaitForCopySceneStart", copySceneInfo.CopySceneGID )
	
	copySceneInfo.PlayerCount = copySceneInfo.PlayerCount + 1
	
	return true,'�򿪸�������'

end

--�������������ж�Ա��MessageBox(��Ա��û�м��븱��)
function CS_SentTeamMemberMsg( str)
	local teamInfo = GetTeamInfo()
	local sid = GetPlayerData(17)
	if teamInfo ~= nil then
		for i = 1, table.maxn( teamInfo), 1 do
			if teamInfo[i].staticId ~= sid then
				SendLuaMsg( teamInfo[i].staticId, { ids = IDS.��ʾMessageBox, Desc = str }, 10 )
			end
		end
	end
end

function WaitForCopySceneStart(GID, param1)
	if param1 == 1 then			-- ����
		CS_OnCopySceneStart()
	elseif param1 == 2 then		-- ����
    	CS_OnDropTask()
	elseif param1 == 3 then		-- ׼��
		ret, info = CS_OnProcReady()
		if ret~= ture then -- ֪ͨ״̬�ı�
			SendLuaMsg( 0, { ids = IDS.��ʾMessageBox, Desc = info }, 9 )
		end
		rfalse(tostring(ret)..'         '..tostring(info))
	elseif param1 == 4 then	-- ȡ��
		CS_OnCancelPrepare()
	end
end

function CS_OnCancelPrepare()
	local sid = GetPlayerData(17)
	local copyScene = CS_GetCopyScene()
	if copyScene == nil then
		rfalse('����δ����')
	    return
	end
	
	local taskid = copyScene.TaskID;
	CS_OnCleanUp( sid )
	local teamID = GetPlayerData(12)
	local isleader = GetPlayerData(13)
	if teamID == 0 or isleader == 1 then
		--����Ƕӳ�,�򱣴�����
		rfalse('�򱣴�����ID')
		CS_GetPlayerTemp( sid ).TaskID = taskid;
	end

	SetPlyaerCopySceneState( playerCSState.���ܸ������� )
	-- ˢ�¶��ѵ�׼���б�
	local temp = {}
	local teamPrepare = __CS_GetTeamPrepareInfo( copyScene )
	temp.text_7 = '696,373,'..teamPrepare..',12,124'
	local teamInfo = GetTeamInfo()
	if teamInfo ~= nil then
      for k,v in pairs (teamInfo) do
      	if v.staticId ~= sid then		-- ����ˢ���Լ���
      		if isleader == true	then
      			CustomWndClose( v.staticId ) --�رմ���
      		else
      			UpdateCustomWnd( v.staticId, temp)
      		end          
        end
      end
	end

end

function CS_OnDropTask()
	rfalse('������������')
	local sid = GetPlayerData(17)
	local copyScene = CS_GetCopyScene()
	if copyScene == nil then
	    return
	end

	local isleader = GetPlayerData(13)
	CustomWndClose( sid) --�رմ���

	if copyScene.PlayerSIDList[sid] == nil then
	    return
	end

	copyScene.PlayerSIDList[sid] = nil
	SetPlyaerCopySceneState( playerCSState.û�и������� )

	-- ˢ�¶��ѵ�׼���б�
	local temp = {}
	local teamPrepare = __CS_GetTeamPrepareInfo( copyScene )
	temp.text_7 = '696,373,'..teamPrepare..',12,124'
	local teamInfo = GetTeamInfo()
	if teamInfo ~= nil then
      for k,v in pairs (teamInfo) do
      	if v.staticId ~= sid then		-- ����ˢ���Լ���
      		if isleader==true	then
      			CustomWndClose( v.staticId ) --�رմ���
      		else
      			UpdateCustomWnd( v.staticId, temp)
      		end          
        end
      end
	end
	CS_RemovePlyaer( sid )
end

-- ��������ж�Ա׼���������������
function CS_OnProcReady()
	local copyScene = CS_GetCopyScene()
	if copyScene == nil then
		return false, '׼������������'
	end

	local taskID = copyScene.TaskID
	local copySceneConfig = ��������[taskID]
	if copySceneConfig == nil then
		return false, '�������ò�����'
	end
	
	-- �жϿ���ʱ��
	local curTime = os.time()	
	local curDate = os.date('*t',os.time())
	
	local dateBegin = copySceneConfig.����ʱ��.��ʼ; 
	dateBegin.year = curDate.year;
	dateBegin.month = curDate.month;
	dateBegin.day = curDate.day;
	dateBegin.isdst = curDate.isdst;
	
	local dateEnd = copySceneConfig.����ʱ��.����; 
	dateEnd.year = curDate.year;
	dateEnd.month = curDate.month;
	dateEnd.day = curDate.day;
	dateEnd.isdst = curDate.isdst;
	
	local timeBegin = os.time( dateBegin )
	local timeEnd = os.time( dateEnd )
	if curTime<timeBegin or curTime>=timeEnd then
		SendTipsMsg(1,'�����Ѿ��ر�')
		return false, '�����Ѿ��ر�'
	end
	
	-- �ж�����
	if copyScene.PlayerCount > copySceneConfig.������� then
		SendTipsMsg(1,'���������������')
		return false, '���������������'
	end	
	
	local sid = GetPlayerData(17)
	-- �����ж�
	if CS_CheckEnterCount(taskID,sid)==false then
		SendTipsMsg(1,'�����������������')
		return false, '�����������������'
	end
	
	-- �ж��Ƿ����׼��

	local rt,msg = __OnCheckReadyCondition(copySceneConfig.׼������, sid)
	if not rt then
		SendTipsMsg(1,msg)
		return false, msg
	end

	-- ����Ҽ��뵽��������б�
	copyScene.PlayerSIDList[sid] = true
	SetPlyaerCopySceneState( playerCSState.׼�����븱��)

	--��ʾ��Ա׼����Ϣ���ַ���
	local temp = {}
	local teamPrepare = __CS_GetTeamPrepareInfo( copyScene)
	temp.text_7 = '696,373,'..teamPrepare..',12,124'
	local teamInfo = GetTeamInfo()
	if teamInfo ~= nil then
      for k,v in pairs (teamInfo) do
      	UpdateCustomWnd( v.staticId, temp)
      end
	end

	return true
end

--ȡ������
function OnUnLockeOperator( sid )

	SendTipsMsg(1,'�������״̬',sid)
	local playerData = CS_GetPlayerData(sid)

	if playerData~=nil and playerData.Complete~=nil then
		--�������,�г�����
		CS_Back( sid )
	end
end

-- ��������������
function CS_OnCopySceneStart(prompt)
	rfalse('request enter copy scene')

	-- ���˻��߶ӳ�
	local IsReady,msg = CS_OnProcReady()
	if IsReady ~= true then
		return false, msg
	end

	-- ȡ�ö�Ӧ��������
	sid = GetPlayerData(17)
	local copyScene = CS_GetCopyScene()

	local copySceneGID = copyScene.CopySceneGID
	if copySceneGID == nil or copyScene == nil then
		return false, '����������'
	end
	-- ��鸱������ID
	local taskID = copyScene.TaskID
	if taskID == nil then
		return false, '��������ID������'
	end
	-- ��鸱������
	local copySceneConfig = ��������[taskID]
	if copySceneConfig == nil then
		return false, '�������ò�����'
	end

    local teamInfo = GetTeamInfo()
	if teamInfo ~= nil then
		for k, v in pairs(teamInfo) do
			if copyScene.PlayerSIDList[v.staticId] ~= true then
				SendLuaMsg( 0, { ids = {3, 2}, Desc = '���ж�Աû��׼���ã��Ƿ�����������', cbOkName = 'CS_ClientConfirmForceEnter', PlayerSID = sid }, 9 )
				return false, '�ȴ�ȷ���Ƿ�ǿ�ƽ���'
			end
		end
	end
		
	return CS_DoEnter( )

end

-- ǿ�ƽ��븱��
function CS_ForceEnter(playerSID)

	local teamInfo = GetTeamInfo()
	local copyScene = CS_GetCopyScene()
	if copyScene == nil then
		return false, '�޷��ҵ���Ӧ����'
	end

	if teamInfo == nil then
		return false, '������Ϣ����ȷ'
	end

	return CS_DoEnter( )

end

-- ֱ�ӽ��븱��
function CS_DoEnter( )
	rfalse('do enter')
	local teamID = GetPlayerData(12)
	local copyScene = CS_GetCopyScene()
	local copySceneConfig = ��������[copyScene.TaskID]

	local teamInfo = GetTeamInfo()
	if teamInfo ~= nil then
    	for k, v in pairs( teamInfo) do
	    	if copyScene.PlayerSIDList[v.staticId] ~= true then
		    	DeleteTeamMember(teamID, v.staticId)	--�����Աû��׼����,���߳�����(׼��״̬)
		    	CS_OnCleanUp( v.staticId)
	    	end
    	end
	end
	rfalse('�ٴμ���Ա��û��׼����')
	-- �ٴμ���Ա��û��׼����(׼������)
	for sid, v in pairs(copyScene.PlayerSIDList) do
		if sid ~= '' then
			if not __OnCheckReadyCondition(copySceneConfig.׼������, sid) then
				DeleteTeamMember(teamID, sid)
				CS_OnCleanUp( v.staticId)
			end
		end
	end

	-- ���ظ�������
	rfalse('���ظ�������')
	local taskID = copyScene.TaskID
	local copySceneConfig = ��������[taskID]
	local ret = CS_LoadScene(copyScene, copySceneConfig, taskID)
	if ret == nil then
		return false, '���ظ���ʧ��'
	end

	-- ��ʼɾÿ���˵Ķ���
	local condition = copySceneConfig.׼������
	local money = GetPlayerData(PlayerProperty.��Ǯ)
 
	for sid,v in pairs( copyScene.PlayerSIDList ) do
		if sid ~= '' and v == true then
            if CheckMoney(money,true,k)==false then
                return false,'��ɫ��Ǯ����'
            end

            for kItem,vItem in pairs(condition.����) do
                if CheckGoods(vItem.id,vItem.num,0,k)==0 then
                    return false, '��ɫ��'..vItem.name..'����'
                end
            end
        end
	end

	-- ...
	rfalse('���븱������')

	-- ���븱������
	local completeTime = copySceneConfig.ʱ������;
	local i = 1
	copyScene.PlayerCount = 0
	local ׷����Ϣ = ����׷��.GetTips(copyScene)
	for sid, _ in pairs(copyScene.PlayerSIDList) do
		if sid ~= '' then
		    CustomWndClose(sid)
		
			if CS_PutPlayerTo(copySceneConfig, sid, i, copyScene) ~= true then
				rfalse('Put player to copy scene failed')
			end

			-- ����
			CS_AddEnterCount(taskID,sid)
		
			local playerTemp = CS_GetPlayerTemp(sid)
			playerTemp.CopySceneGID = copyScene.CopySceneGID
			playerTemp.TaskID = copyScene.TaskID

			SetPlyaerCopySceneState( playerCSState.������, k)
			copyScene.PlayerCount = copyScene.PlayerCount+1
			
			--��������ʱ������,��ʼ��ʱ
			if completeTime~=nil then
				SendLuaMsg( sid, { ids = IDS.���������ʱ , time=completeTime*60 }, 10 )
			end
			
			--����׷����Ϣ
			SendLuaMsg( sid, { ids = IDS.��������׷�� , tips=׷����Ϣ }, 10 )
			i = i + 1
		end
	end	

	--�����ʱ����
	local teamID = GetPlayerData(12)
	PrepareScene[teamID] = nil
	
	-- ��ʼ��ʱ
	--��������ʱ������,��ʼ��ʱ
	if completeTime~=nil then
		completeTime = completeTime * 60
		copyScene.Timer = SetEvent(completeTime, nil, 'OnCopySceneOverTime', copyScene.TaskID, copyScene.CopySceneGID )
	end
	
	return true
end

function OnCopySceneOverTime( taskid, copySceneGID )
	rfalse('��������ʱ. taskid='..tostring(taskid)..',����GID='..tostring(copySceneGID))
	local csdata = CS_GetData( copySceneGID )
	if csdata==nil then
		return
	end

	--
 	for sid, v in pairs(csdata.PlayerSIDList) do
 		if sid ~= '' then
 			SendTipsMsg(1,'��������ʱ',sid)
 			CS_OnCleanUp(sid)
	 		CS_Back(sid)	
 		end
 	end	
end

-- �����ɢ
function OnReleaseTeam( teamID)
	rfalse('--�����ɢ')
	CS_OnDelPrepareScene( teamID)
end

-- �˳�����
function CS_OnQuitTeam( )
	rfalse('--�˳�����')
	local sid = GetPlayerData(17)
	
	--������
	local playerTemp = CS_GetPlayerTemp(sid)	
	if playerTemp ~= nil then
		rfalse('������ʱ����')
		ClearPlayerItem( )		--�����ҴӸ����ֿ���ȡ�õĵ���
		CustomWndClose( sid)	--�رմ���
		g_ListCopySceneID[sid] = nil
	end
end

-- �˳�����
function CS_DoExit()
	rfalse('--�˳�����')
	CS_OnCleanUp( GetPlayerData(17) )
end
-- �Ӹ�������
function CS_Back( sid )
	-- �ж��Ƿ��ڸ���״̬
	-- ֱ�ӴӸ���㷵��
	BackFromDynamicScene( sid )
end
--���� ��ǰ��� �� ��ʱ����
function CS_OnCleanUp( sid )
	rfalse('������ʱ����')
	if sid==nil then return end

	ClearPlayerItem( )		--�����ҴӸ����ֿ���ȡ�õĵ���
	CustomWndClose( sid)	--�رմ���

	g_ListCopySceneID[sid] = nil

	local playerData = CS_GetPlayerData( sid)
	--�����������û�����,������Ϊû�и���״̬
	if playerData ~= nil and playerData.Complete ~= nil then
		SetPlyaerCopySceneState( playerCSState.���ܸ�������, sid)
	else
		SetPlyaerCopySceneState( playerCSState.û�и�������, sid)
	end
	SendLuaMsg( sid, { ids = IDS.��������׷�� , tips=nil}, 10 )
	SendLuaMsg( sid, { ids = IDS.���������ʱ , time=0 }, 10 )
	CS_RemovePlyaer( sid )
end

 -- �������
 -- ������ɲ��������˳�������ͼ,��������10���ӵ�CGʱ��,���˳�
 function CS_Complete(copyScene)
 	rfalse('----��ɸ�������--------')
 
 	--ȡ����ʱ
 	if copyScene.Timer~=nil then 
 		rfalse('�����ʱ��')
 		ClrEvent(copyScene.Timer)
 	end
 	
 	local taskID = copyScene.TaskID
 	local copySceneConfig = ��������[taskID]
 	if copySceneConfig == nil then
 		rfalse('�������ò�����')
 		return
 	end
 	local member = {}
 	for sid, v in pairs(copyScene.PlayerSIDList) do
 		if sid ~= '' then 			
	 		member[sid] = GetPlayerGID( sid )
 		end
 	end
 	for sid, v in pairs(copyScene.PlayerSIDList) do
 		if sid ~= '' then
	 		local playerData = CS_GetPlayerData(sid)
	 		�������������.Award(taskID, playerData)
	 		SendTipsMsg(1,'��ɸ�������',sid)
	 		SendLuaMsg( sid, { ids = IDS.����������� , team=member }, 10 )
	 		LockPlayer( 5000,sid )			
 		end
 	end
 	
 end

-- ��齱���Ƿ��ܸ���
local function __CanGiveAward(award)
	return true
end

-- ���轱��
function __GiveAward(award)

	--������Ʒʱ���Ȱ����н�������Ʒͳ�Ƴ���
	local addGood = {}
	for itemIdx, count in pairs(award.ItemList) do
		if itemIdx ~= '' then
			addGood = { itemIdx, count }
		end
	end
	
	--���ж��Ƿ���������Щ��Ʒ
	if CheckAddGoods( addGood) == false then
		SendTipsMsg(1,'���������������������')
		return false
	end
	
	-- ����
	for itemIdx, count in pairs(award.ItemList) do
		GiveGoods(itemIdx, count)
	end
	
	-- ����
	if award.Exp ~= nil then
		PayThePlayer(1, award.Exp)
	end

	-- �ķ�������

	-- �书������
end

-- ȡ�ý���
function CS_DoAward()

	local sid = GetPlayerData(17)
	local playerData = CS_GetPlayerData(sid)
	if playerData == nil or playerData.Complete == nil then
		return
	end

	-- ��齱���Ƿ��ܸ���
	local award = playerData.Complete.Award
	if not __CanGiveAward(award) then
		return
	end

	-- ���轱��
	__GiveAward(award)

	playerData.Complete = nil
	playerData.TaskID = nil
	CS_RemovePlyaer( sid )
	SetPlyaerCopySceneState( playerCSState.û�и������� )
end

-- ����������
function CS_OnProcAward()

	local sid = GetPlayerData(17)
	local playerData = CS_GetPlayerData(sid)
	if playerData == nil or playerData.Complete == nil then
		return
	end

	local award = playerData.Complete.Award
	local goods = { give = {} }
	for itemIdx, count in pairs(award.ItemList) do
		if itemIdx ~= '' then
			table.push(goods.give, {itemIdx, count})
		end
	end

	local taskAward = {
		��ɽ��� = {
			giveExp = award.Exp,
			giveMoney = award.Money,
			giveGoods = goods,
		}
	}

	SendLuaMsg( 0, { ids = {3, 1}, taskID = playerData.Complete.TaskID, awardInfo = taskAward }, 9 )

end

--��NPC�Ի�
function ClickMenu80000(index)
	local npcid = GetObjectUniqueId()
	npcid = npcid - 400000
	if ����NPC[npcid]~=nil and ����NPC[npcid].ClickMenu~=nil then
		rfalse('��NPC�Ի� id='..tostring(npcid))
		����NPC[npcid].ClickMenu( index );
	end
end

--���ܸ�������
function ClickMenu80001(index)
	local sid = GetPlayerData(17)
	local lsID = g_ListCopySceneID[sid]
	if lsID ~= nil then
		if index <= table.maxn( lsID) then
			SendTipsMsg(1,'���ܸ�������')
			local csTemp = CS_GetPlayerTemp(sid)
			csTemp.TaskID = lsID[index]
			SetPlyaerCopySceneState( playerCSState.���ܸ�������)
		end
	end
	--ɾ����ʱ����
	g_ListCopySceneID[sid] = nil
end
--ȡ�ֿ���Ʒ
msgDispatcher[4][1000] = function ( playerid, msg )
	local sid = GetPlayerData(17)	--��ȡ��ɫid
	local csTemp = CS_GetPlayerTemp(sid)
	if ( csTemp.CopySceneGID == nill or csTemp.CopySceneGID==0 ) then return; end;

	--��ȡ��������
	local copyScene = CS_GetData(csTemp.CopySceneGID)

	--ȡ�����ֿ�
	local src = msg.src;
	local to = msg.to;
	local index_src = src.y*8+src.x+1;
	local item = copyScene.Storage[index_src];
	if ( item == nil ) then
		--��ͻ���ͬ��,֪ͨ�ͻ��˴�λ���Ѿ�û����
		SendLuaMsg( 0, { ids = {5,1}, Desc = '�����Ѿ������������ȡ��!' }, 9 )
		return;
	end
	local rt = GiveGoods(item[1],1);--AddGoods( item, to.x, to.y, 1 );
	if rt==nil or rt==0 then
		SendLuaMsg( 0, { ids = {5,1}, Desc = '�����Ѿ�����!' }, 9 )
		return;
	end

	--ɾ������
	item[2] = item[2] - 1
	if item[2]<=0 then
		copyScene.Storage[index_src] = nil
		item = nil
	end

	for k,v in pairs(copyScene.PlayerSIDList) do
		if k ~= '' and v == true then
		 SendLuaMsg( k, { ids = IDS.ɾ�������ֿ����, pos=src }, 10 )
		end
	end
end

--�����ҴӸ����ֿ��л�õ��ĵ���
function ClearPlayerItem( )

	--�����ɫ������Щ�����ڵĵ���,��ɾ��
	for k,v in pairs(�������߱�) do
		if v~=nil then
			ClearPlayerCSItem(v[1],v[2]);
		end
	end
end
