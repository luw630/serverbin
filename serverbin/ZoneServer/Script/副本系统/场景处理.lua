
-- 根据副本配置加载一个副本场景组
function CS_LoadScene(copyScene, copySceneConfig, taskID)
	
	-- 加载动态地图组
	local mapGroupConfig = copySceneConfig.地图组
	for _, mapConfig in pairs(mapGroupConfig) do
		
		-- 加载地图
		local mapIdx = mapConfig.地图编号
		local dynamicMapGID = CreateRegion(mapIdx, mapConfig.复活点.regionId, mapConfig.复活点.x, mapConfig.复活点.y, copyScene.CopySceneGID)
		copyScene.DynamicSceneGIDList[mapIdx] = dynamicMapGID
		
		-- 加载NPC
		local npcListConfig = mapConfig.NPC列表
		for _, npcConfig in pairs(npcListConfig) do
			rfalse('load npc')
			npcConfig.copySceneGID = copyScene.CopySceneGID
			npcConfig.regionId = dynamicMapGID
			CreateObjectIndirect(npcConfig)
		end
				
		--加载仓库
		local npc=copySceneConfig.仓库.NPC
		--副本NPC[npc].ClickMenu = ClickMenu80001
		--npc.copySceneGID = copyScene.CopySceneGID
		--npc.regionId = dynamicMapGID;		
		--RemoveObjectIndirect( npc.regionId,npc.controlId )		--创建npc
		--CreateObjectIndirect( npc )								--创建npc
		
		copyScene.Storage = table.copy( copySceneConfig.仓库.道具 );--复制仓库数据
		copyScene.MonsterDeadList = table.copy( copySceneConfig.完成条件.怪物死亡 );--复制仓库数据
		
		-- 加载怪物
		local monsterListConfig = mapConfig.怪物列表
		for _, monsterConfig in pairs(monsterListConfig) do
			monsterConfig.copySceneGID = copyScene.CopySceneGID
			monsterConfig.regionId = dynamicMapGID
			CreateObjectIndirect(monsterConfig)
		end		
	end
	
	--设置跳转点
	for _k, mapConfig in pairs(mapGroupConfig) do
		-- 加载地图
		local mapIdx = mapConfig.地图编号	
		local dynamicMapGID = copyScene.DynamicSceneGIDList[mapIdx]	
		for _t, trap in pairs(mapConfig.跳转点) do			
			local targetMapGID = copyScene.DynamicSceneGIDList[trap.regionId]
			SetTrap(mapIdx,256,1,trap.regionId,trap.tox,trap.toy,dynamicMapGID,trap.sx,trap.sy,targetMapGID)
		end
	end
	return true
	
end

-- 把玩家放到副本场景
-- 根据传入序号，决定位置
function CS_PutPlayerTo(copySceneConfig, playerSID, posIdx, copyScene)
	local initPos = copySceneConfig.初始位置列表[posIdx]
	local mapGID = copyScene.DynamicSceneGIDList[initPos.地图编号]
	if mapGID == nil then
		rfalse('无法找到对应动态场景'..tostring(initPos.地图编号))
		return false
	end
		
	PutPlayerTo(initPos.地图编号, initPos.x, initPos.y, mapGID, playerSID)
	return true
end
function OnRegionChanged(playerSID)
	--检查新场景是否还在副本中
	rfalse('进入新场景')
	local playerTemp = CS_GetPlayerTemp(playerSID)
	if playerTemp==nil or playerTemp.CopySceneGID == nil then
		return
	end
	
	local sceneGID = GetCurCopyScenesGID(playerSID)	
	if sceneGID ~= playerTemp.CopySceneGID then 
		CS_OnCleanUp( playerSID )
	end
end

-- 当某一个动态场景的玩家数为0的时候产生的回调
function CS_OnCheckTerminate(GID)

	-- 检查动态场景组中是否有动态场景还有玩家
	local copyScene = CS_GetData(GID)
	if copyScene == nil then
		return
	end

	for k, dynamicSceneGID in pairs(copyScene.DynamicSceneGIDList) do
		if k ~= '' then
			if GetDynamicScenePlayerNumber(dynamicSceneGID) ~= 0 then
				return
			end
		end
	end
	
	-- 全部空了，那么删除所有的动态场景
	CS_RemoveData(GID)
	
end
