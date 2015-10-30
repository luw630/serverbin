function OnMonster_Init(monsterAiID,monsterGID) ---怪物初始化状态 只执行一次
      if monsterAiID == 7 then
        AddBuff(monsterGID,5007)
	  elseif monsterAiID == 4 then
        AddBuff(monsterGID,50007)
	  elseif monsterAiID == 6 then
        AddBuff(monsterGID,30007)
      end
end

function OnMonster_End(monsterAiID,monsterGID)
end

function OnMonster_Update(monsterAiID,monsterGID,AttEnemyID)
      local retAttack = nil
    if monsterAiID == 1 then
        retAttack = OnMonster_Update_1(monsterGID,AttEnemyID)
     elseif monsterAiID == 2 then                              --被动非移动怪物
        retAttack = OnMonster_Update_2(monsterGID,AttEnemyID)
     elseif monsterAiID == 3 then                              --被动移动怪物AI
        retAttack = OnMonster_Update_3(monsterGID,AttEnemyID)
     elseif monsterAiID == 4 then                              --主动非移动怪物AI
        retAttack = OnMonster_Update_4(monsterGID,AttEnemyID)
     elseif monsterAiID == 5 then                              --主动移动怪物AI
        retAttack = OnMonster_Update_5(monsterGID,AttEnemyID)
     elseif monsterAiID == 6 then                              --BOSS怪物
        retAttack = OnMonster_Update_6(monsterGID,AttEnemyID)
     elseif monsterAiID == 7 then                              --主动移动BOSS霸体AI
        retAttack = OnMonster_Update_7(monsterGID,AttEnemyID)
     elseif monsterAiID == 8 then                              
        retAttack = OnMonster_Update_8(monsterGID,AttEnemyID)
     elseif monsterAiID == 11 then                             --主动非移动怪物AI
        retAttack = OnMonster_Update_11(monsterGID,AttEnemyID)
     elseif monsterAiID == 12 then							   --主动非移动怪物AI
        retAttack = OnMonster_Update_12(monsterGID,AttEnemyID)		
    elseif monsterAiID == 13 then                              --站着不动打不还手
        retAttack = OnMonster_Update_13(monsterGID,AttEnemyID)      
--------------------------以下为BOSS的AI----------------------
	 elseif monsterAiID == 101 then                             --石像鬼
        retAttack = OnMonster_Update_101(monsterGID,AttEnemyID)
	 elseif monsterAiID == 102 then								--国王
        retAttack = OnMonster_Update_102(monsterGID,AttEnemyID)
	 elseif monsterAiID == 103 then								--等等
        retAttack = OnMonster_Update_103(monsterGID,AttEnemyID)
	 elseif monsterAiID == 104 then
        retAttack = OnMonster_Update_104(monsterGID,AttEnemyID)
	 elseif monsterAiID == 105 then
        retAttack = OnMonster_Update_105(monsterGID,AttEnemyID)
	 elseif monsterAiID == 106 then
        retAttack = OnMonster_Update_106(monsterGID,AttEnemyID)
	 elseif monsterAiID == 107 then
        retAttack = OnMonster_Update_107(monsterGID,AttEnemyID)
---------------------------以下为信仰BOSS的AI---------------------
	 elseif monsterAiID == 110 then                            
        retAttack = OnMonster_Update_110(monsterGID,AttEnemyID)
	 elseif monsterAiID == 111 then								
        retAttack = OnMonster_Update_111(monsterGID,AttEnemyID)
	 elseif monsterAiID == 112 then								
        retAttack = OnMonster_Update_112(monsterGID,AttEnemyID)
	 elseif monsterAiID == 113 then
        retAttack = OnMonster_Update_113(monsterGID,AttEnemyID)
	 elseif monsterAiID == 114 then
        retAttack = OnMonster_Update_114(monsterGID,AttEnemyID)
	 elseif monsterAiID == 115 then
        retAttack = OnMonster_Update_115(monsterGID,AttEnemyID)
	 elseif monsterAiID == 116 then
        retAttack = OnMonster_Update_116(monsterGID,AttEnemyID)
	 elseif monsterAiID == 117 then								
        retAttack = OnMonster_Update_117(monsterGID,AttEnemyID)
	 elseif monsterAiID == 118 then
        retAttack = OnMonster_Update_118(monsterGID,AttEnemyID)
	 elseif monsterAiID == 119 then
        retAttack = OnMonster_Update_119(monsterGID,AttEnemyID)
	 elseif monsterAiID == 120 then
        retAttack = OnMonster_Update_120(monsterGID,AttEnemyID)
	 elseif monsterAiID == 121 then
        retAttack = OnMonster_Update_121(monsterGID,AttEnemyID)
    end
    return retAttack
end


function OnMonster_Update_1(monsterGID,AttEnemyID)
            --怪物交叉使用1、2号技能攻击目标
    local retAttack = nil
    local randindex =  LuaRandRange(1,10000)
    if randindex > 5000 then
     retAttack = StartAttack(AttEnemyID,0)
    else
     retAttack = StartAttack(AttEnemyID,1)
    end
    return retAttack
end

function OnMonster_Update_2(monsterGID,AttEnemyID)
    local retAttack = nil
    if(g_EnemyID_1[monsterGID] == 0)then
         retAttack = StartAttack(AttEnemyID,0)
         g_EnemyID_1[monsterGID] = 1
    else
        retAttack = StartAttack(AttEnemyID,1)
         g_EnemyID_1[monsterGID] = 0
    end
    return retAttack
end

function OnMonster_Update_3(monsterGID,AttEnemyID)
    local retAttack = nil
    if(g_EnemyID_1[monsterGID] == 0)then
         retAttack = StartAttack(AttEnemyID,0)
         g_EnemyID_1[monsterGID] = 1
    else
        retAttack = StartAttack(AttEnemyID,1)
         g_EnemyID_1[monsterGID] = 0
    end
    return retAttack
end

function OnMonster_Update_4(monsterGID,AttEnemyID)
    local retAttack = nil
    if(g_EnemyID_1[monsterGID] == 0)then
         retAttack = StartAttack(AttEnemyID,0)
         g_EnemyID_1[monsterGID] = 1
    else
        retAttack = StartAttack(AttEnemyID,1)
         g_EnemyID_1[monsterGID] = 0
    end
    return retAttack
end

function OnMonster_Update_5(monsterGID,AttEnemyID)
            --怪物交叉使用1、2号技能攻击目标
    local retAttack = nil
    local randindex =  LuaRandRange(1,10000)
    if randindex > 5000 then
     retAttack = StartAttack(AttEnemyID,0)
    else
     retAttack = StartAttack(AttEnemyID,1)
    end
    return retAttack
end

function OnMonster_Update_6(monsterGID,AttEnemyID)
    local Mosterhp      = GetMonsterData(GMon_HPcent)   --怪物当前血量百分比
    local retAttack = nil
    if Mosterhp <= 50  then
        if(g_EnemyID_1[monsterGID] == 0)then
             retAttack = StartAttack(AttEnemyID,3)    ----技能索引ID
             g_EnemyID_1[monsterGID] = 1
        else
             retAttack = StartAttack(AttEnemyID,4)
             g_EnemyID_1[monsterGID] = 0
        end
    else
        local retAttack = nil
        if(g_EnemyID_1[monsterGID] == 0)then
             retAttack = StartAttack(AttEnemyID,0)
             g_EnemyID_1[monsterGID] = 1
        else
             retAttack = StartAttack(AttEnemyID,1)
             g_EnemyID_1[monsterGID] = 0
         end
    end

    return retAttack
end

function OnMonster_Update_7(monsterGID,AttEnemyID)
    local retAttack = nil
    if(g_EnemyID_1[monsterGID] == 0)then
         retAttack = StartAttack(AttEnemyID,0)
         g_EnemyID_1[monsterGID] = 1
    else
        retAttack = StartAttack(AttEnemyID,1)
         g_EnemyID_1[monsterGID] = 0
		 AddBuff(monsterGID,5007)
    end
    return retAttack
end

function OnMonster_Update_11(monsterGID,AttEnemyID)

    --怪物交叉使用1、2号技能攻击目标
    local retAttack = nil
    if(g_EnemyID_1[monsterGID] == 0)then
         retAttack = StartAttack(AttEnemyID,0)
         g_EnemyID_1[monsterGID] = 1
    else
        retAttack = StartAttack(AttEnemyID,1)
         g_EnemyID_1[monsterGID] = 0
    end
    return retAttack
end

function OnMonster_Update_12(monsterGID,AttEnemyID)
    --召唤
    local curHp = GetMonsterData(GMon_HPcent)--HP百分比
    if BisCallMonster[monsterGID] == nil then
        BisCallMonster[monsterGID] = 0
    end
    
    if curHp <= 0.8  then
        if BisCallMonster[monsterGID] == 0 then
            for k, mCreate in pairs(Aimonsterlist[2]) do
                    mCreate.regionId = GetDynamicRegionID(monsterGID)
                    local monstergid = CreateObjectIndirect(mCreate)
                    --table.insert(scenebase.Monsterlist,monstergid)
            end
            BisCallMonster[monsterGID] = 1
            local str = MystringFormat("MONSTER_2")
            MonsterTalk(monsterGID,str)
            rfalse("call monster")
        end
    end 

    --怪物交叉使用1、2号技能攻击目标
    local retAttack = nil
    if(g_EnemyID_1[monsterGID] == 0)then
         retAttack = StartAttack(AttEnemyID,0)
         g_EnemyID_1[monsterGID] = 1
    else
        retAttack = StartAttack(AttEnemyID,1)
         g_EnemyID_1[monsterGID] = 0
    end
    return retAttack
end

function OnMonster_Update_13(monsterGID,AttEnemyID)
    if BisCallMonster[monsterGID] == 0 then
		AddBuff(monsterGID,5007)
    end
	return nil
end

function OnAiMonster_Dead(monsterGID)   --这尼玛死濒死技能
    local monsteraiid = GetMonsterData(GMon_AIID)
    if monsteraiid == 11 then
        OnAiMonster_Dead_11(monsterGID)
    elseif monsteraiid == 12 then
        OnAiMonster_Dead_12(monsterGID)
    end
end

function OnAiMonster_Dead_11(monsterGID)
    --死亡召唤怪物
    if BisCallMonster[monsterGID] == nil then
        BisCallMonster[monsterGID] = 0
    end
    if BisCallMonster[monsterGID] == 0 then
        for k, mCreate in pairs(Aimonsterlist[1]) do
                mCreate.regionId = GetDynamicRegionID(monsterGID)
                local monstergid = CreateObjectIndirect(mCreate)
        end
        BisCallMonster[monsterGID] = 1
        AddBuff(monsterGID,5012)
        AddBuff(monsterGID,5011)
		AddBuff(monsterGID,5007)
        local str = MystringFormat("MONSTER_1")
        MonsterTalk(monsterGID,str)
        rfalse("call monster")
    end
end

function OnAiMonster_Dead_12(monsterGID)
end
------------------------------------------------------------------------------------------------------------------------------------------------
function OnMonster_Update_101(monsterGID,AttEnemyID)
	local retAttack = nil
	local MosterHpPer = GetMonsterData(GMon_HPcent) * 100

	if MosterHpPer > 80 and MosterHpPer < 90 then
		retAttack = StartAttack(AttEnemyID,3)      --技能ID要尼玛 -1  这边是从0 开始计算的 配置表上是1
	elseif MosterHpPer > 50 and MosterHpPer < 60 then
		retAttack = StartAttack(AttEnemyID,3)
	elseif MosterHpPer > 20 and MosterHpPer < 30 then
		retAttack = StartAttack(AttEnemyID,3)
	elseif MosterHpPer >= 1 and MosterHpPer < 10 then
		retAttack = StartAttack(AttEnemyID,3)
	else
        retAttack = StartAttack(AttEnemyID,0)
		AddBuff(monsterGID,5007)
    end
	return retAttack
end

function OnMonster_Update_102(monsterGID,AttEnemyID)
	local retAttack = StartAttack(AttEnemyID,0)
	local MosterHpPer = GetMonsterData(GMon_HPcent)*100
	local ftime = GetMonsterFightTime(monsterGID)
	
	if math.ceil(ftime/10) == (ftime/10) then
		retAttack = StartAttack(AttEnemyID,3)
		
	elseif MosterHpPer < 20 and MosterHpPer > 15 then
	
		--MonsterTalk(monsterGID,1021);   --下地狱吧，凡人！
		
		if BisCallMonster[monsterGID] == nil then
			BisCallMonster[monsterGID] = 0
		end
		if BisCallMonster[monsterGID] == 0 then
			for k, mCreate in pairs(Aimonsterlist[102]) do         -----里面数值改为和aimonsterlist要调用的一样
					mCreate.regionId = GetDynamicRegionID(monsterGID)
					local monstergid = CreateObjectIndirect(mCreate)
			end
			BisCallMonster[monsterGID] = 1
			local str = MystringFormat("MONSTER_102")
			MonsterTalk(monsterGID,str)
			rfalse("call monster")
		end
	else
        retAttack = StartAttack(AttEnemyID,1)
         g_EnemyID_1[monsterGID] = 0
		 AddBuff(monsterGID,5007)
	end
	return retAttack
end

function OnMonster_Update_103(monsterGID,AttEnemyID)
	local retAttack = StartAttack(AttEnemyID,0)
	local MosterHpPer = GetMonsterData(GMon_HPcent)*100
	local ftime = GetMonsterFightTime(monsterGID)
	if math.ceil(ftime/10) == (ftime/10) then
		retAttack = StartAttack(AttEnemyID,3)
	elseif MosterHpPer < 40 and MosterHpPer > 35 then
		--MonsterTalk(monsterGID,1031)      --蚂蚁你是杀不死我的，让你甜美的血让我更加漂亮
		if BisCallMonster[monsterGID] == nil then
			BisCallMonster[monsterGID] = 0
		end
		if BisCallMonster[monsterGID] == 0 then
			for k, mCreate in pairs(Aimonsterlist[103]) do         -----里面数值改为和aimonsterlist要调用的一样
					mCreate.regionId = GetDynamicRegionID(monsterGID)
					local monstergid = CreateObjectIndirect(mCreate)
			end
			BisCallMonster[monsterGID] = 1
			local str = MystringFormat("MONSTER_103")
			MonsterTalk(monsterGID,str)
			rfalse("call monster")
		end
	else
        retAttack = StartAttack(AttEnemyID,1)
         g_EnemyID_1[monsterGID] = 0
		 AddBuff(monsterGID,5007)
	end
	return retAttack
end

function OnMonster_Update_104(monsterGID,AttEnemyID)
	local retAttack = StartAttack(AttEnemyID,0)
	local MosterHpPer = GetMonsterData(GMon_HPcent)*100
	local ftime = GetMonsterFightTime(monsterGID)
	if math.ceil(ftime/10) == (ftime/10) then
		retAttack = StartAttack(AttEnemyID,3)
	elseif MosterHpPer < 40 and MosterHpPer > 35 then
		--MonsterTalk(monsterGID,1041)     -----滚开杂碎
		if BisCallMonster[monsterGID] == nil then
			BisCallMonster[monsterGID] = 0
		end
		if BisCallMonster[monsterGID] == 0 then
			for k, mCreate in pairs(Aimonsterlist[104]) do         -----里面数值改为和aimonsterlist要调用的一样
					mCreate.regionId = GetDynamicRegionID(monsterGID)
					local monstergid = CreateObjectIndirect(mCreate)
			end
			BisCallMonster[monsterGID] = 1
			local str = MystringFormat("MONSTER_104")
			MonsterTalk(monsterGID,str)
			rfalse("call monster")
		end
	else
        retAttack = StartAttack(AttEnemyID,1)
         g_EnemyID_1[monsterGID] = 0
		 AddBuff(monsterGID,5007)
	end
	return retAttack
end

function OnMonster_Update_105(monsterGID,AttEnemyID)
	local retAttack = StartAttack(AttEnemyID,0)
	local ftime = GetMonsterFightTime(monsterGID)*100
	if math.ceil(ftime/10) == (ftime/10) then
		retAttack = StartAttack(AttEnemyID,3)
	    local randindex =  LuaRandRange(1,3)
		if randindex <= 1 and randindex >=0 then
			--MonsterTalk(monsterGID,1051)    --看我的破击
			retAttack = StartAttack(AttEnemyID,1)
		elseif randindex <= 2 and randindex >1 then
			--MonsterTalk(monsterGID,1052)	--看我的暴击
			retAttack = StartAttack(AttEnemyID,2)
		else
			--MonsterTalk(monsterGID,1053)		--看我的穿刺
			retAttack = StartAttack(AttEnemyID,3)
			AddBuff(monsterGID,5007)
		end
	end
	return retAttack
end

function OnMonster_Update_106(monsterGID,AttEnemyID)
	local retAttack = StartAttack(AttEnemyID,0)
	local ftime = GetMonsterFightTime(monsterGID)*100
	if math.ceil(ftime/10) == (ftime/10) then
		retAttack = StartAttack(AttEnemyID,3)
	elseif MosterHpPer < 40 and MosterHpPer > 35 then
		--MonsterTalk(monsterGID,1061)		--"你敢杀死我妹妹，去死吧！"
		if BisCallMonster[monsterGID] == nil then
			BisCallMonster[monsterGID] = 0
		end
		if BisCallMonster[monsterGID] == 0 then
			for k, mCreate in pairs(Aimonsterlist[106]) do         -----里面数值改为和aimonsterlist要调用的一样
					mCreate.regionId = GetDynamicRegionID(monsterGID)
					local monstergid = CreateObjectIndirect(mCreate)
			end
			BisCallMonster[monsterGID] = 1
			local str = MystringFormat("MONSTER_106")
			MonsterTalk(monsterGID,str)
			rfalse("call monster")
		end
	else
        retAttack = StartAttack(AttEnemyID,1)
         g_EnemyID_1[monsterGID] = 0
		 AddBuff(monsterGID,5007)
	end
	return retAttack
end

function OnMonster_Update_107(monsterGID,AttEnemyID)
	local retAttack = StartAttack(AttEnemyID,0)
	local ftime = GetMonsterFightTime(monsterGID)*100
	if math.ceil(ftime/10) == (ftime/10) then
		retAttack = StartAttack(AttEnemyID,2)
	elseif MosterHpPer < 40 and MosterHpPer > 35 then
		retAttack = StartAttack(AttEnemyID,3)
	elseif MosterHpPer < 10 and MosterHpPer > 20 then
		--MonsterTalk(monsterGID,1071)		--"我死的好冤！"
		if BisCallMonster[monsterGID] == nil then
			BisCallMonster[monsterGID] = 0
		end
		if BisCallMonster[monsterGID] == 0 then
			for k, mCreate in pairs(Aimonsterlist[107]) do         -----里面数值改为和aimonsterlist要调用的一样
					mCreate.regionId = GetDynamicRegionID(monsterGID)
					local monstergid = CreateObjectIndirect(mCreate)
			end
			BisCallMonster[monsterGID] = 1
			local str = MystringFormat("MONSTER_107")
			MonsterTalk(monsterGID,str)
			rfalse("call monster")
		end
	else
        retAttack = StartAttack(AttEnemyID,1)
         g_EnemyID_1[monsterGID] = 0
		 AddBuff(monsterGID,5007)
	end
	return retAttack
end

-------------------------------------------------------------------------------------------------------------
function OnMonster_Update_110(monsterGID,AttEnemyID)    -------狄俄尼索斯
	local retAttack = StartAttack(AttEnemyID,0)
	local hp		= GetObjectData(monsterGID, OBJDATA_CURHP)   --当前血量,gid = 目标gid
	local maxhp		= GetObjectData(monsterGID, OBJDATA_MAXHP)   --当前最大血量,gid = 目标gid
	
	if BisCallMonster[monsterGID] == nil then
        BisCallMonster[monsterGID] = 0
    end
	hpm = (hp / maxhp) * 100   --取得百分比
	if hpm >= 70 and hpm <= 80  then
		retAttack = StartAttack(AttEnemyID,2)
	elseif hpm >= 30 and hpm <= 40  then
		retAttack = StartAttack(AttEnemyID,2)
	elseif hpm >= 5 and hpm <= 10  then
		retAttack = StartAttack(AttEnemyID,3)
		if BisCallMonster[monsterGID] == 0 then
			local str = MystringFormat("MONSTER_108")
			MonsterTalk(monsterGID,str)
			BisCallMonster[monsterGID] = 1
			end
	else
        retAttack = StartAttack(AttEnemyID,1)
         g_EnemyID_1[monsterGID] = 0
		 AddBuff(monsterGID,5007)
	end
	return retAttack
end

function OnMonster_Update_111(monsterGID,AttEnemyID)    -------赫淮斯托斯  
	local retAttack = StartAttack(AttEnemyID,0)
	local MosterHpPer = GetMonsterData(GMon_HPcent)*100
	
	if MosterHpPer >= 70 and MosterHpPer <= 80  then
		retAttack = StartAttack(AttEnemyID,2)
	elseif MosterHpPer >= 30 and MosterHpPer <= 40  then
		retAttack = StartAttack(AttEnemyID,2)
	elseif MosterHpPer >= 5 and MosterHpPer <= 10  then
		--MonsterTalk(monsterGID,1111)		--蝼蚁岂可和日月同辉！
	retAttack = StartAttack(AttEnemyID,3)
		if BisCallMonster[monsterGID] == 0 then
			local str = MystringFormat("MONSTER_109")
			MonsterTalk(monsterGID,str)
			BisCallMonster[monsterGID] = 1
			end
	else
        retAttack = StartAttack(AttEnemyID,1)
         g_EnemyID_1[monsterGID] = 0
		 AddBuff(monsterGID,5007)
	end
	return retAttack
end

function OnMonster_Update_112(monsterGID,AttEnemyID)    -------阿瑞斯
	local retAttack = StartAttack(AttEnemyID,0)
	local ftime = GetMonsterFightTime(monsterGID)*100
	if ftime >= 60 and ftime <= 300 then 
		if math.ceil(ftime/20) == (ftime/20) then
			retAttack = StartAttack(AttEnemyID,3)
		end
	elseif ftime >= 301 and ftime <= 480 then 
		if math.ceil(ftime/10) == (ftime/10) then
			retAttack = StartAttack(AttEnemyID,3)
		end	
	elseif ftime >= 481  then 
		if math.ceil(ftime/5) == (ftime/5) then
			retAttack = StartAttack(AttEnemyID,3)
		end
	else
        retAttack = StartAttack(AttEnemyID,1)
         g_EnemyID_1[monsterGID] = 0
		 AddBuff(monsterGID,5007)
	end
	return retAttack
end

function OnMonster_Update_113(monsterGID,AttEnemyID)    -------赫尔墨斯  
	local retAttack = StartAttack(AttEnemyID,0)
	local MosterHpPer = GetMonsterData(GMon_HPcent)*100
	local ftime = GetMonsterFightTime(monsterGID)
	
	if MosterHpPer >= 70 and MosterHpPer <= 80  then
		retAttack = StartAttack(AttEnemyID,2)
	elseif MosterHpPer >= 30 and MosterHpPer <= 40  then
		retAttack = StartAttack(AttEnemyID,3)
	end 
	if ftime >= 300  then
		--MonsterTalk(monsterGID,1131)		--"小耗子你上当了!"
	end
	if BisCallMonster[monsterGID] == 0 then
			local str = MystringFormat("MONSTER_110")
			MonsterTalk(monsterGID,str)
			BisCallMonster[monsterGID] = 1
			end
		local randindex =  LuaRandRange(1,500)
		if randindex <= 500 then
			retAttack = StartAttack(AttEnemyID,2)
	else
        retAttack = StartAttack(AttEnemyID,1)
         g_EnemyID_1[monsterGID] = 0
		 AddBuff(monsterGID,5007)
	end
	return retAttack
end

function OnMonster_Update_114(monsterGID,AttEnemyID)    -------阿芙洛狄忒  
	local retAttack = StartAttack(AttEnemyID,0)
	local level = GetObjectData(playerGID, OBJDATA_LEVEL)
	if level <= 70 then
		retAttack = StartAttack(AttEnemyID,3)
		if math.ceil(ftime/15) == (ftime/15) then
			--MonsterTalk(monsterGID,1141)		--"我的美丽是永恒的!"
			retAttack = StartAttack(AttEnemyID,2)
		end
	else
        retAttack = StartAttack(AttEnemyID,1)
         g_EnemyID_1[monsterGID] = 0
		 AddBuff(monsterGID,5007)
	end
	return retAttack
end

function OnMonster_Update_115(monsterGID,AttEnemyID)    -------阿尔忒弥斯  
	local retAttack = StartAttack(AttEnemyID,0)
	local level = GetObjectData(playerGID, OBJDATA_LEVEL)
	if level <= 75 then
		retAttack = StartAttack(AttEnemyID,3)
		if math.ceil(ftime/15) == (ftime/15) then
			retAttack = StartAttack(AttEnemyID,2)
		end
	else
        retAttack = StartAttack(AttEnemyID,1)
         g_EnemyID_1[monsterGID] = 0
		 AddBuff(monsterGID,5007)
	end
	return retAttack
end

function OnMonster_Update_116(monsterGID,AttEnemyID)    -------阿尔忒弥斯  
	local retAttack = StartAttack(AttEnemyID,0)
	local level = GetObjectData(playerGID, OBJDATA_LEVEL)
	if level <= 85 then
		retAttack = StartAttack(AttEnemyID,3)
		if math.ceil(ftime/15) == (ftime/15) then
			retAttack = StartAttack(AttEnemyID,2)
		end
	else
        retAttack = StartAttack(AttEnemyID,1)
         g_EnemyID_1[monsterGID] = 0
		 AddBuff(monsterGID,5007)
	end
	return retAttack
end

function OnMonster_Update_117(monsterGID,AttEnemyID)    -------哈迪斯  
	local retAttack = StartAttack(AttEnemyID,0)
	local MosterHpPer = GetMonsterData(GMon_HPcent)*100
	local ftime = GetMonsterFightTime(monsterGID)
	
	if MosterHpPer >= 70 and MosterHpPer <= 80  then
		retAttack = StartAttack(AttEnemyID,2)
	elseif MosterHpPer >= 30 and MosterHpPer <= 40  then
		retAttack = StartAttack(AttEnemyID,2)
	elseif MosterHpPer <= 20  then
		retAttack = StartAttack(AttEnemyID,3)
	else
        retAttack = StartAttack(AttEnemyID,1)
         g_EnemyID_1[monsterGID] = 0
		 AddBuff(monsterGID,5007)
	end
	return retAttack
end

function OnMonster_Update_118(monsterGID,AttEnemyID)    -------波塞冬  
	local retAttack = StartAttack(AttEnemyID,0)
	local MosterHpPer = GetMonsterData(GMon_HPcent)*100
	local ftime = GetMonsterFightTime(monsterGID)
	
	if MosterHpPer >= 70 and MosterHpPer <= 80  then
		retAttack = StartAttack(AttEnemyID,2)
	elseif MosterHpPer >= 30 and MosterHpPer <= 40  then
		retAttack = StartAttack(AttEnemyID,2)
	elseif MosterHpPer <= 20  then
		retAttack = StartAttack(AttEnemyID,3)
	else
        retAttack = StartAttack(AttEnemyID,1)
         g_EnemyID_1[monsterGID] = 0
		 AddBuff(monsterGID,5007)
	end
	return retAttack
end

function OnMonster_Update_119(monsterGID,AttEnemyID)    -------赫拉  
	local retAttack = StartAttack(AttEnemyID,0)
	local MosterHpPer = GetMonsterData(GMon_HPcent)*100
	local ftime = GetMonsterFightTime(monsterGID)
	
	if MosterHpPer >= 70 and MosterHpPer <= 80  then
		retAttack = StartAttack(AttEnemyID,2)
	elseif MosterHpPer >= 30 and MosterHpPer <= 40  then
		retAttack = StartAttack(AttEnemyID,2)
	elseif MosterHpPer <= 20  then
		retAttack = StartAttack(AttEnemyID,3)
	else
        retAttack = StartAttack(AttEnemyID,1)
         g_EnemyID_1[monsterGID] = 0
		 AddBuff(monsterGID,5007)
	end
	return retAttack
end

function OnMonster_Update_120(monsterGID,AttEnemyID)    -------宙斯  
	local retAttack = StartAttack(AttEnemyID,0)
	local MosterHpPer = GetMonsterData(GMon_HPcent)*100
	local ftime = GetMonsterFightTime(monsterGID)
	
	if MosterHpPer >= 70 and MosterHpPer <= 80  then
		retAttack = StartAttack(AttEnemyID,2)
	elseif MosterHpPer >= 30 and MosterHpPer <= 40  then
		retAttack = StartAttack(AttEnemyID,2)
	elseif MosterHpPer <= 20  then
		retAttack = StartAttack(AttEnemyID,3)
	else
        retAttack = StartAttack(AttEnemyID,1)
         g_EnemyID_1[monsterGID] = 0
		 AddBuff(monsterGID,5007)
	end
	return retAttack
end

function OnMonster_Update_121(monsterGID,AttEnemyID)    -------宙斯  
	local retAttack = StartAttack(AttEnemyID,0)
	local MosterHpPer = GetMonsterData(GMon_HPcent)*100
	local ftime = GetMonsterFightTime(monsterGID)
	
	if MosterHpPer >= 70 and MosterHpPer <= 80  then
		retAttack = StartAttack(AttEnemyID,2)
	elseif MosterHpPer >= 30 and MosterHpPer <= 40  then
		retAttack = StartAttack(AttEnemyID,2)
	elseif MosterHpPer <= 20  then
		retAttack = StartAttack(AttEnemyID,3)
	else
        retAttack = StartAttack(AttEnemyID,1)
         g_EnemyID_1[monsterGID] = 0
		 AddBuff(monsterGID,5007)
	end
	return retAttack
end

















