
-- ���ݸ������ü���һ������������
function CS_LoadScene(copyScene, copySceneConfig, taskID)
	
	-- ���ض�̬��ͼ��
	local mapGroupConfig = copySceneConfig.��ͼ��
	for _, mapConfig in pairs(mapGroupConfig) do
		
		-- ���ص�ͼ
		local mapIdx = mapConfig.��ͼ���
		local dynamicMapGID = CreateRegion(mapIdx, mapConfig.�����.regionId, mapConfig.�����.x, mapConfig.�����.y, copyScene.CopySceneGID)
		copyScene.DynamicSceneGIDList[mapIdx] = dynamicMapGID
		
		-- ����NPC
		local npcListConfig = mapConfig.NPC�б�
		for _, npcConfig in pairs(npcListConfig) do
			rfalse('load npc')
			npcConfig.copySceneGID = copyScene.CopySceneGID
			npcConfig.regionId = dynamicMapGID
			CreateObjectIndirect(npcConfig)
		end
				
		--���زֿ�
		local npc=copySceneConfig.�ֿ�.NPC
		--����NPC[npc].ClickMenu = ClickMenu80001
		--npc.copySceneGID = copyScene.CopySceneGID
		--npc.regionId = dynamicMapGID;		
		--RemoveObjectIndirect( npc.regionId,npc.controlId )		--����npc
		--CreateObjectIndirect( npc )								--����npc
		
		copyScene.Storage = table.copy( copySceneConfig.�ֿ�.���� );--���Ʋֿ�����
		copyScene.MonsterDeadList = table.copy( copySceneConfig.�������.�������� );--���Ʋֿ�����
		
		-- ���ع���
		local monsterListConfig = mapConfig.�����б�
		for _, monsterConfig in pairs(monsterListConfig) do
			monsterConfig.copySceneGID = copyScene.CopySceneGID
			monsterConfig.regionId = dynamicMapGID
			CreateObjectIndirect(monsterConfig)
		end		
	end
	
	--������ת��
	for _k, mapConfig in pairs(mapGroupConfig) do
		-- ���ص�ͼ
		local mapIdx = mapConfig.��ͼ���	
		local dynamicMapGID = copyScene.DynamicSceneGIDList[mapIdx]	
		for _t, trap in pairs(mapConfig.��ת��) do			
			local targetMapGID = copyScene.DynamicSceneGIDList[trap.regionId]
			SetTrap(mapIdx,256,1,trap.regionId,trap.tox,trap.toy,dynamicMapGID,trap.sx,trap.sy,targetMapGID)
		end
	end
	return true
	
end

-- ����ҷŵ���������
-- ���ݴ�����ţ�����λ��
function CS_PutPlayerTo(copySceneConfig, playerSID, posIdx, copyScene)
	local initPos = copySceneConfig.��ʼλ���б�[posIdx]
	local mapGID = copyScene.DynamicSceneGIDList[initPos.��ͼ���]
	if mapGID == nil then
		rfalse('�޷��ҵ���Ӧ��̬����'..tostring(initPos.��ͼ���))
		return false
	end
		
	PutPlayerTo(initPos.��ͼ���, initPos.x, initPos.y, mapGID, playerSID)
	return true
end
function OnRegionChanged(playerSID)
	--����³����Ƿ��ڸ�����
	rfalse('�����³���')
	local playerTemp = CS_GetPlayerTemp(playerSID)
	if playerTemp==nil or playerTemp.CopySceneGID == nil then
		return
	end
	
	local sceneGID = GetCurCopyScenesGID(playerSID)	
	if sceneGID ~= playerTemp.CopySceneGID then 
		CS_OnCleanUp( playerSID )
	end
end

-- ��ĳһ����̬�����������Ϊ0��ʱ������Ļص�
function CS_OnCheckTerminate(GID)

	-- ��鶯̬���������Ƿ��ж�̬�����������
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
	
	-- ȫ�����ˣ���ôɾ�����еĶ�̬����
	CS_RemoveData(GID)
	
end
