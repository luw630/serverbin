--�������͵Ĺ���
--�����󣬴���������ɵ��¼�

function Monster_Init_1(regionGID, monsterGID, monsterId)
	
end

function Monster_End_1(regionGID, monsterGID)
end

function Monster_Update_1(regionGID, monsterGID, monsterId, existTime)

	local nCurrActionID = GetMonsterCurActionID()

	if ( nCurrActionID == 7 ) then	--����״̬��ֹ	
		--OnProcessDead()
		--����������Ӧ���������Զ������ݣ������趨�ù������ú�������Ч������
		--g_EnemyID_10[monsterGID]	= 0	
		--g_EnemyID_20[monsterGID]	= 0	 
		--g_Cruel_10[monsterGID] = false
		EventRegionFinish(1);
	end	
	
end
