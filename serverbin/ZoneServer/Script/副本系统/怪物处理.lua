
-- ����������Ļص�����
function CS_OnMonsterDead(copySceneGID, deadScriptID)
	rfalse('on monster dead '..tostring(deadScriptID))
	
	local copyScene = CS_GetData(copySceneGID)
	if copyScene == nil then
		return
	end
	
	if copyScene.MonsterDeadList[deadScriptID] == nil then
		return
	end
	
	copyScene.MonsterDeadList[deadScriptID].num = copyScene.MonsterDeadList[deadScriptID].num-1
	local ׷����Ϣ
	if ������������жϱ�.CheckCompleteCondition(copyScene) == true then
		CS_Complete(copyScene)
		׷����Ϣ = ����׷��.GetTips(copyScene,"%\73-�����������\r\n")
	else
		׷����Ϣ = ����׷��.GetTips(copyScene)
	end
	
	for sid, _ in pairs(copyScene.PlayerSIDList) do
		if sid ~= '' then
			--����׷����Ϣ
			SendLuaMsg( sid, { ids = IDS.��������׷�� , tips=׷����Ϣ }, 10 )
		end
	end		
end