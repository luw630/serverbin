--[[
/*
玩家身上的副本数据结构说明：
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

服务器内每个副本状态数据说明:
Temp = {
	CopySceneGID,			--副本全局ID
	TaskID,					--任务ID
	DynamicSceneGIDList,	--动态地图组的GID列表
	PlayerSIDList = { },	--(PlayerSID -> true(存贮的是每个玩家是否准备)
	PlayerCount = 0,
	MonsterDeadList={},
}
*/
--]]

-- 初始化副本数据表
dbMgr.CopySceneDataPool.temp = dbMgr.CopySceneDataPool.temp or {
	CopySceneList = {},
	__IDG = 0,		--全局共享计数器,每新生成一个副本,__IDG+=1
}
dbMgr.CopySceneDataPool.data = dbMgr.CopySceneDataPool.data or {
	EnterCount={},
	ClearDate,
}

--定义副本临时数据（根据队伍ID创建）
PrepareScene = PrepareScene or { }

-- 创建一个测试NPC
--rfalse('create test copy scene npc')
RemoveObjectIndirect(1, 400001)
CreateObjectIndirect( { regionId = 73, name = '副本开启', clickScript = 30000, controlId = 400001, imageId = 15,  x = 5 , y = 201 , dir = 4 , objectType = 1 , mType = 0})
RemoveObjectIndirect(1, 400002)
CreateObjectIndirect( { regionId = 73, name = '副本入口', clickScript = 30000, controlId = 400002, imageId = 15,  x = 6 , y = 202 , dir = 5 , objectType = 1 , mType = 0})
--RemoveObjectIndirect(1, 400003)
--CreateObjectIndirect( { regionId = 1, name = '副本准备', clickScript = 30000, controlId = 400003, imageId = 15,  x = 17 , y = 42 , dir = 5 , objectType = 1 , mType = 0})
RemoveObjectIndirect(1, 400004)
CreateObjectIndirect( { regionId = 73, name = '副本奖励', clickScript = 30000, controlId = 400004, imageId = 15,  x = 8 , y = 202 , dir = 5 , objectType = 1 , mType = 0})

-- 注册计时器
local _csCurDate = os.date('*t',os.time())
local _csClearTimer = 24*60*60-1 - _csCurDate.hour*60*60-_csCurDate.min*60-_csCurDate.sec
ClrEvent(LUA_EVENT_TIMER.CopySceneClearTimer)
function OnCopySceneClearTime( )
	--重置计时器
	SetEvent(24*60*60-1, LUA_EVENT_TIMER.CopySceneClearTimer, 'OnCopySceneClearTime')
	--清空计数
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

-- 取得玩家相关副本数据(Temp)
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

-- 取得玩家相关副本数据
function CS_GetPlayerData(playerSID)
	if playerSID == nil or playerSID == 0 then
		return nil
	end

	dbMgr[playerSID].data = dbMgr[playerSID].data or { }
	dbMgr[playerSID].data.CopySceneData = dbMgr[playerSID].data.CopySceneData or { Complete=nil }

	return dbMgr[playerSID].data.CopySceneData
end

-- 删除玩家相关副本数据
function CS_RemovePlyaer(playerSID)
	rfalse('删除玩家相关副本数据')
	
	--删除临时数据
	local playerTemp = CS_GetPlayerTemp(playerSID)	
	if playerTemp~=nil then
		dbMgr[playerSID].temp.CopySceneData = nil
	end
	
	--如果任务未完成,则删除db数据.
	local playerData = CS_GetPlayerData(playerSID)
	if playerData~=nil and playerData.Complete == nil then
		dbMgr[playerSID].data.CopySceneData = nil
	end	    

	-- 队员全部退出副本,则删除副本数据		
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
			rfalse('副本场景还有'..tostring(copyScene.PlayerCount)..'人')
		end
		copyScene.PlayerSIDList[playerSID] = nil
	end   
	 
end

function CS_OnDelPrepareScene( teamID)
	PrepareScene[teamID] = nil
end

-- 通过副本GID取得副本数据
function CS_GetData(ID)
	local copySceneList = dbMgr.CopySceneDataPool.temp.CopySceneList
	return copySceneList[ID]
end

-- 获得副本列表
function CS_GetCopySceneList( )
	return dbMgr.CopySceneDataPool.temp.CopySceneList
end

-- 删除副本数据
function CS_RemoveData(GID)
	rfalse('删除副本数据'..tostring(GID))
	--删除副本场景
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
	rfalse('删除副本数据成功')
end

-- 生成一个新的副本GID
local function CreateCopyScene( taskID )
	dbMgr.CopySceneDataPool.temp.__IDG = dbMgr.CopySceneDataPool.temp.__IDG + 1
	local gid = dbMgr.CopySceneDataPool.temp.__IDG

	copySceneList = CS_GetCopySceneList()
	copySceneList[gid] = {
		CopySceneGID = gid,		--副本全局ID
		TaskID = taskID,		--任务ID
		DynamicSceneGIDList={},	--动态地图组的GID列表
		PlayerSIDList = {},		--(PlayerSID -> true（存贮的是每个玩家是否准备）)
		MonsterDeadList={},
		PlayerCount = 0,
	}

	return gid
end

-- 获取准备进入副本的数据,如果没有,则创建,否则返回现有数据
function CS_GetCopySceneInfo( taskID )
	rfalse('create copy scene : taskid=' .. tostring(taskID))
	--获得SID
	local sid = GetPlayerData(17)
	--获得临时数据
	local playerTemp = CS_GetPlayerTemp(sid)

	if playerTemp.CopySceneGID ~= nil then
		return playerTemp
	end

	--如果角色身上没有CopySceneGID,则查看队伍
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

	--标志角色还没有准备好
	copyScene = CS_GetData(csgid)
	copyScene.PlayerSIDList[sid] = false

	return playerTemp
end

--获得角色临时副本数据
function CS_GetCopyScene()
	local sid = GetPlayerData(17)
	local playerTemp = CS_GetPlayerTemp(sid)
	if playerTemp.CopySceneGID==nil then 
		return nil
	end	
	return CS_GetData(playerTemp.CopySceneGID)
end

-- 获得进入副本的次数
function CS_CheckEnterCount( taskid, playersid )
	local csConfig = 副本配置[taskid]
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
	
	return enterCount[taskid][playersid]<csConfig.每天最大次数;
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