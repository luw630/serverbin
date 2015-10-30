
-- 怪物死亡后的回调函数
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
	local 追踪信息
	if 副本完成条件判断表.CheckCompleteCondition(copyScene) == true then
		CS_Complete(copyScene)
		追踪信息 = 副本追踪.GetTips(copyScene,"%\73-副本任务完成\r\n")
	else
		追踪信息 = 副本追踪.GetTips(copyScene)
	end
	
	for sid, _ in pairs(copyScene.PlayerSIDList) do
		if sid ~= '' then
			--发送追踪信息
			SendLuaMsg( sid, { ids = IDS.副本任务追踪 , tips=追踪信息 }, 10 )
		end
	end		
end