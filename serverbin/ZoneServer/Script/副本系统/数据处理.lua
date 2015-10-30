--[[
/*
������ϵĸ������ݽṹ˵����
Data = {
	Complete = {
		TaskID,
		Award = {}		--int Award[](itemIDX -> ItemCount)
	}
}

Temp = {	-- playertemp
	CopySceneGID,
	TaskID,
}

PrepareScene = {
	[TeamID]={	CopySceneGID = gid }
}

��������ÿ������״̬����˵��:
Temp = {
	CopySceneGID,			--����ȫ��ID
	TaskID,					--����ID
	DynamicSceneGIDList,	--��̬��ͼ���GID�б�
	PlayerSIDList = { },	--(PlayerSID -> true(��������ÿ������Ƿ�׼��)
	PlayerCount = 0,
	MonsterDeadList={},
}
*/
--]]

-- ��ʼ���������ݱ�
dbMgr.CopySceneDataPool.temp = dbMgr.CopySceneDataPool.temp or {
	CopySceneList = {},
	__IDG = 0,		--ȫ�ֹ��������,ÿ������һ������,__IDG+=1
}
dbMgr.CopySceneDataPool.data = dbMgr.CopySceneDataPool.data or {
	EnterCount={},
	ClearDate,
}

--���帱����ʱ���ݣ����ݶ���ID������
PrepareScene = PrepareScene or { }

-- ����һ������NPC
--rfalse('create test copy scene npc')
RemoveObjectIndirect(1, 400001)
CreateObjectIndirect( { regionId = 73, name = '��������', clickScript = 30000, controlId = 400001, imageId = 15,  x = 5 , y = 201 , dir = 4 , objectType = 1 , mType = 0})
RemoveObjectIndirect(1, 400002)
CreateObjectIndirect( { regionId = 73, name = '�������', clickScript = 30000, controlId = 400002, imageId = 15,  x = 6 , y = 202 , dir = 5 , objectType = 1 , mType = 0})
--RemoveObjectIndirect(1, 400003)
--CreateObjectIndirect( { regionId = 1, name = '����׼��', clickScript = 30000, controlId = 400003, imageId = 15,  x = 17 , y = 42 , dir = 5 , objectType = 1 , mType = 0})
RemoveObjectIndirect(1, 400004)
CreateObjectIndirect( { regionId = 73, name = '��������', clickScript = 30000, controlId = 400004, imageId = 15,  x = 8 , y = 202 , dir = 5 , objectType = 1 , mType = 0})

-- ע���ʱ��
local _csCurDate = os.date('*t',os.time())
local _csClearTimer = 24*60*60-1 - _csCurDate.hour*60*60-_csCurDate.min*60-_csCurDate.sec
ClrEvent(LUA_EVENT_TIMER.CopySceneClearTimer)
function OnCopySceneClearTime( )
	--���ü�ʱ��
	SetEvent(24*60*60-1, LUA_EVENT_TIMER.CopySceneClearTimer, 'OnCopySceneClearTime')
	--��ռ���
	--rfalse('_CopySceneClearTimer')
	dbMgr.CopySceneDataPool.data.EnterCount={}
	dbMgr.CopySceneDataPool.data.ClearDate = _csCurDate.day
end
rfalse('SetEvent OnCopySceneClearTime :'..tostring(_csClearTimer)..' Date='..tostring(_csCurDate.day))
if _csCurDate.day ~= dbMgr.CopySceneDataPool.data.ClearDate then
	rfalse('ClearDate = _csCurDate.day')
	dbMgr.CopySceneDataPool.data.EnterCount={}
	dbMgr.CopySceneDataPool.data.ClearDate = _csCurDate.day
end
SetEvent(_csClearTimer, LUA_EVENT_TIMER.CopySceneClearTimer, 'OnCopySceneClearTime')

-- ȡ�������ظ�������(Temp)
function CS_GetPlayerTemp(playerSID)
	if playerSID == nil or playerSID == 0 then
		return
	end
	dbMgr[playerSID].temp = dbMgr[playerSID].temp or {}
	dbMgr[playerSID].temp.CopySceneData = dbMgr[playerSID].temp.CopySceneData or {
		CopySceneGID,
		TaskID,
	}

	return dbMgr[playerSID].temp.CopySceneData
end

-- ȡ�������ظ�������
function CS_GetPlayerData(playerSID)
	if playerSID == nil or playerSID == 0 then
		return nil
	end

	dbMgr[playerSID].data = dbMgr[playerSID].data or { }
	dbMgr[playerSID].data.CopySceneData = dbMgr[playerSID].data.CopySceneData or { Complete=nil }

	return dbMgr[playerSID].data.CopySceneData
end

-- ɾ�������ظ�������
function CS_RemovePlyaer(playerSID)
	rfalse('ɾ�������ظ�������')
	
	--ɾ����ʱ����
	local playerTemp = CS_GetPlayerTemp(playerSID)	
	if playerTemp~=nil then
		dbMgr[playerSID].temp.CopySceneData = nil
	end
	
	--�������δ���,��ɾ��db����.
	local playerData = CS_GetPlayerData(playerSID)
	if playerData~=nil and playerData.Complete == nil then
		dbMgr[playerSID].data.CopySceneData = nil
	end	    

	-- ��Աȫ���˳�����,��ɾ����������		
	local copyScene = CS_GetData( playerTemp.CopySceneGID )
	if copyScene ~= nil then
		if copyScene.PlayerCount <= 1 then
			local teamID = GetPlayerData(12)
			if teamID~=nil then
				PrepareScene[teamID] = nil
			end
			CS_RemoveData( playerTemp.CopySceneGID )
		else
			copyScene.PlayerCount = copyScene.PlayerCount-1
			rfalse('������������'..tostring(copyScene.PlayerCount)..'��')
		end
		copyScene.PlayerSIDList[playerSID] = nil
	end   
	 
end

function CS_OnDelPrepareScene( teamID)
	PrepareScene[teamID] = nil
end

-- ͨ������GIDȡ�ø�������
function CS_GetData(ID)
	local copySceneList = dbMgr.CopySceneDataPool.temp.CopySceneList
	return copySceneList[ID]
end

-- ��ø����б�
function CS_GetCopySceneList( )
	return dbMgr.CopySceneDataPool.temp.CopySceneList
end

-- ɾ����������
function CS_RemoveData(GID)
	rfalse('ɾ����������'..tostring(GID))
	--ɾ����������
	copyScene = dbMgr.CopySceneDataPool.temp.CopySceneList[GID]
	if copyScene==nil then
		return
	end
	
	for mapid, dynamicSceneGID in pairs(copyScene.DynamicSceneGIDList) do
		if mapid ~= '' then
			DestroyDynamicScene(dynamicSceneGID)
		end
	end
	
	dbMgr.CopySceneDataPool.temp.CopySceneList[GID] = nil
	rfalse('ɾ���������ݳɹ�')
end

-- ����һ���µĸ���GID
local function CreateCopyScene( taskID )
	dbMgr.CopySceneDataPool.temp.__IDG = dbMgr.CopySceneDataPool.temp.__IDG + 1
	local gid = dbMgr.CopySceneDataPool.temp.__IDG

	copySceneList = CS_GetCopySceneList()
	copySceneList[gid] = {
		CopySceneGID = gid,		--����ȫ��ID
		TaskID = taskID,		--����ID
		DynamicSceneGIDList={},	--��̬��ͼ���GID�б�
		PlayerSIDList = {},		--(PlayerSID -> true����������ÿ������Ƿ�׼����)
		MonsterDeadList={},
		PlayerCount = 0,
	}

	return gid
end

-- ��ȡ׼�����븱��������,���û��,�򴴽�,���򷵻���������
function CS_GetCopySceneInfo( taskID )
	rfalse('create copy scene : taskid=' .. tostring(taskID))
	--���SID
	local sid = GetPlayerData(17)
	--�����ʱ����
	local playerTemp = CS_GetPlayerTemp(sid)

	if playerTemp.CopySceneGID ~= nil then
		return playerTemp
	end

	--�����ɫ����û��CopySceneGID,��鿴����
	local teamID = GetPlayerData(12)
	local csgid=nil
	if teamID ~= 0 then
		if PrepareScene[teamID]==nil then
			PrepareScene[teamID] = {}
			PrepareScene[teamID].CopySceneGID = CreateCopyScene( taskID )
		end
		csgid = PrepareScene[teamID].CopySceneGID
	else
		csgid = CreateCopyScene( taskID )
	end

	playerTemp.CopySceneGID = csgid
	playerTemp.TaskID = taskID

	--��־��ɫ��û��׼����
	copyScene = CS_GetData(csgid)
	copyScene.PlayerSIDList[sid] = false

	return playerTemp
end

--��ý�ɫ��ʱ��������
function CS_GetCopyScene()
	local sid = GetPlayerData(17)
	local playerTemp = CS_GetPlayerTemp(sid)
	if playerTemp.CopySceneGID==nil then 
		return nil
	end	
	return CS_GetData(playerTemp.CopySceneGID)
end

-- ��ý��븱���Ĵ���
function CS_CheckEnterCount( taskid, playersid )
	local csConfig = ��������[taskid]
	if csConfig==nil then return false end
	
	local enterCount = dbMgr.CopySceneDataPool.data.EnterCount
	if enterCount[taskid]==nil then 
		enterCount[taskid] = {}
	end
	rfalse(tostring(playersid))
	rfalse(taskid)
	if enterCount[taskid][playersid]==nil then
		enterCount[taskid][playersid]=0
	end
	
	return enterCount[taskid][playersid]<csConfig.ÿ��������;
end
function CS_AddEnterCount( taskid, playersid )
	local enterCount = dbMgr.CopySceneDataPool.data.EnterCount
	if enterCount[taskid]==nil then 
		enterCount[taskid] = {}
	end
	if enterCount[taskid][playersid]==nil then
		enterCount[taskid][playersid]=0
	end
	enterCount[taskid][playersid] = enterCount[taskid][playersid]+1;
end