
---------------------------------------------------����ͨ��AI-------------------------------------


g_EnemyID_1 = {} -- ��������ѭ������
g_EnemyID_2 = {} -- ����Ŀ�����ȫ�ֱ���
BisCallMonster = {}  --�����ٻ�����

function StaticScene_Monster_Init(monsterAiID,monsterGID)
	g_EnemyID_1[monsterGID] = 0
	g_EnemyID_2[monsterGID] = 0
	BisCallMonster[monsterGID] = 0
	OnMonster_Init(monsterAiID,monsterGID)
end
function StaticScene_Monster_End(monsterAiID,monsterGID)
	g_EnemyID_1[monsterGID] = nil
	g_EnemyID_2[monsterGID] = nil
	BisCallMonster[monsterGID] = nil
	OnMonster_End(monsterAiID,monsterGID)
end

function StaticScene_Monster_Update(monsterAiID,monsterGID)
	local CurID 		= GetMonsterCurActionID()         --��¼�˵�ǰ�����״̬
	local AttType 		= GetMonsterData(GMon_AttType)    --��������
	local MoveType 		= GetMonsterData(GMon_MoveType)   --�ƶ�����
	local ProtectTy 	= GetMonsterData(GMon_BackProtect)--���ڷ��ر���

	--����(Sreset)�ض��ű�ʱ���ű�ֻ���Monster_Update��ʼ�ض�����ʼ�����ݣ����������Ϊnil
	if(g_EnemyID_2[monsterGID] == nil) then
		g_EnemyID_2[monsterGID]	= 0
	end
	if(g_EnemyID_1[monsterGID] == nil) then
		g_EnemyID_1[monsterGID]	= 0
	end

	--������ս����ʱ����ִ��AI
	-- if (ProtectTy == 1) then
	-- 	--������ս���Զ������ݸ����趨��Ҫ��������
	-- 	g_EnemyID_1[monsterGID]	= 0
	-- 	g_EnemyID_2[monsterGID]	= 0
	-- 	return
	-- end
	--rfalse("CurID = "..CurID.." monsterGID = "..monsterGID.."")
	--����״̬��ֹ		536871988	

	if ( CurID == 7 ) then
		OnProcessDead()
		--����������Ӧ���������Զ������ݣ������趨�ù������ú�������Ч������
		g_EnemyID_1[monsterGID]	= 0
		g_EnemyID_2[monsterGID]	= 0
	end
	--AIִ��
	--��ս��״̬������û�б���Ŀ��
	if(GetMonsterData(GMon_LastEnemyID) == 0) then

		local bCheckRun = true
		--ս�����͹����Ѱ��Χ��Ŀ��
		if(AttType == 0) then

			--local MEnemyID  = GetStaticTargetMonster() ��Ѱ�ж���Ӫ�����ͨAI��������
			local PEnemyID  = GetAttackTargetPlayer()
			
			if (PEnemyID ~= 0 and type(PEnemyID) == "number") then
				SetMonsterData(GMon_LastEnemyID,PEnemyID)
				bCheckRun = false
			end

		end

		--�ƶ��͹���--վ�����Զ�Ѱ·��
		if(MoveType == 1 and bCheckRun == true) then
			if(CurID == 0) then
				StartStaticRun()
			end
		end
	--ս��״̬������ѡ��Ŀ�귽ʽ���ϴι��������Ŀ��
	else

		if(g_EnemyID_2[monsterGID] == 0)then
			g_EnemyID_2[monsterGID] = GetMonsterData(GMon_LastEnemyID)
		end

		if g_EnemyID_2[monsterGID] > 0 then
			--local state = GetPlayerData(g_EnemyID_2[monsterGID],GPP_ACTION)  --�����Ѿ�����
			local state = GetFightObjActionID(g_EnemyID_2[monsterGID])	--�������Ķ����Ѿ�����
			if state == EA_DEAD then
				SetMonsterData(GMon_LastEnemyID,0)
				SetStopTracing()
			end
		end
	    --������·���ƶ�ʱ��ͣ�ƶ�
		if(CurID == 2) then
			if(GetMonsterData(GMon_Move2Att) == 0)then
				SetMonsterData(GMon_CurrAction,0)
			else
				local AttEnemyID = GetMonsterData(GMon_LastEnemyID)
				if(g_EnemyID_2[monsterGID] ~= AttEnemyID)then

					g_EnemyID_2[monsterGID] = AttEnemyID
					SetMonsterData(GMon_CurrAction,0)
				end
			end
		end

		if(CurID == 0 ) then
			local retAttack = nil
			local AttEnemyID = GetMonsterData(GMon_LastEnemyID)
			if AttEnemyID ~= nil and AttEnemyID > 0 then
				retAttack = OnMonster_Update(monsterAiID,monsterGID,AttEnemyID)
			end

			if (retAttack == 0 or retAttack == nil) then
				SetMonsterData(GMon_CurrAction,0)
				g_EnemyID_2[monsterGID] = 0
				g_EnemyID_1[monsterGID]	= 0
				SetMonsterData(GMon_LastEnemyID,0)
			end


		end
		if(CurID == 8 ) then
			local AttEnemyID = GetMonsterData(GMon_LastEnemyID)
			if(g_EnemyID_2[monsterGID] ~= AttEnemyID) then
				g_EnemyID_2[monsterGID] = AttEnemyID
				SetMonsterData(GMon_CurrAction,0)
			end
		end
	end
end


---------------------------------------------------BOSS AI-------------------------------------









































