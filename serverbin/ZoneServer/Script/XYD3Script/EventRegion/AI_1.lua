--基础类型的怪物
--死亡后，触发副本完成的事件

function Monster_Init_1(regionGID, monsterGID, monsterId)
	
end

function Monster_End_1(regionGID, monsterGID)
end

function Monster_Update_1(regionGID, monsterGID, monsterId, existTime)

	local nCurrActionID = GetMonsterCurActionID()

	if ( nCurrActionID == 7 ) then	--死亡状态终止	
		--OnProcessDead()
		--怪物死亡后，应重置所有自定义数据，除非设定该怪物重置后保留特殊效果数据
		--g_EnemyID_10[monsterGID]	= 0	
		--g_EnemyID_20[monsterGID]	= 0	 
		--g_Cruel_10[monsterGID] = false
		EventRegionFinish(1);
	end	
	
end
