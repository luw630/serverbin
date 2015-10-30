
---------------------------------------------------怪物通用AI-------------------------------------


g_EnemyID_1 = {} -- 攻击技能循环变量
g_EnemyID_2 = {} -- 怪物目标控制全局变量
BisCallMonster = {}  --怪物召唤怪物

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
	local CurID 		= GetMonsterCurActionID()         --记录了当前怪物的状态
	local AttType 		= GetMonsterData(GMon_AttType)    --攻击类型
	local MoveType 		= GetMonsterData(GMon_MoveType)   --移动类型
	local ProtectTy 	= GetMonsterData(GMon_BackProtect)--处于返回保护

	--命令(Sreset)重读脚本时，脚本只会从Monster_Update开始重读，初始化数据，否则参数将为nil
	if(g_EnemyID_2[monsterGID] == nil) then
		g_EnemyID_2[monsterGID]	= 0
	end
	if(g_EnemyID_1[monsterGID] == nil) then
		g_EnemyID_1[monsterGID]	= 0
	end

	--怪物脱战返回时，不执行AI
	-- if (ProtectTy == 1) then
	-- 	--怪物脱战，自定义数据根据设定需要进行重置
	-- 	g_EnemyID_1[monsterGID]	= 0
	-- 	g_EnemyID_2[monsterGID]	= 0
	-- 	return
	-- end
	--rfalse("CurID = "..CurID.." monsterGID = "..monsterGID.."")
	--死亡状态终止		536871988	

	if ( CurID == 7 ) then
		OnProcessDead()
		--怪物死亡后，应重置所有自定义数据，除非设定该怪物重置后保留特殊效果数据
		g_EnemyID_1[monsterGID]	= 0
		g_EnemyID_2[monsterGID]	= 0
	end
	--AI执行
	--非战斗状态：怪物没有被击目标
	if(GetMonsterData(GMon_LastEnemyID) == 0) then

		local bCheckRun = true
		--战斗类型怪物，搜寻范围内目标
		if(AttType == 0) then

			--local MEnemyID  = GetStaticTargetMonster() 搜寻敌对阵营怪物，普通AI不做考虑
			local PEnemyID  = GetAttackTargetPlayer()
			
			if (PEnemyID ~= 0 and type(PEnemyID) == "number") then
				SetMonsterData(GMon_LastEnemyID,PEnemyID)
				bCheckRun = false
			end

		end

		--移动型怪物--站立后自动寻路点
		if(MoveType == 1 and bCheckRun == true) then
			if(CurID == 0) then
				StartStaticRun()
			end
		end
	--战斗状态：怪物选择目标方式：上次攻击怪物的目标
	else

		if(g_EnemyID_2[monsterGID] == 0)then
			g_EnemyID_2[monsterGID] = GetMonsterData(GMon_LastEnemyID)
		end

		if g_EnemyID_2[monsterGID] > 0 then
			--local state = GetPlayerData(g_EnemyID_2[monsterGID],GPP_ACTION)  --敌人已经死亡
			local state = GetFightObjActionID(g_EnemyID_2[monsterGID])	--被攻击的对象已经死亡
			if state == EA_DEAD then
				SetMonsterData(GMon_LastEnemyID,0)
				SetStopTracing()
			end
		end
	    --怪物在路点移动时，停移动
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









































