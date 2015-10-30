--g_Monsterhate = {} --怪物仇恨计算
function OnMonsterDamage(objectgid,DamageValue,killgid)
    if g_Monsterhate[objectgid] == nil then
        g_Monsterhate[objectgid] = {}
        -- local temp = {}
        -- temp[killgid] = DamageValue
        -- table.insert( g_Monsterhate[objectgid],temp)
    else
        local isfind = 0
        local monsterhate = g_Monsterhate[objectgid]
        if monsterhate[killgid] ~= nil then
            monsterhate[killgid] = monsterhate[killgid] + DamageValue
        else
            monsterhate[killgid] = DamageValue
        end
        -- for k,v in pairs(monsterhate) do
        --     if k == killgid then
        --         v = v + DamageValue
        --         isfind = 1 
        --         break
        --     end  
        -- end
        -- if isfind == 0 then
        --     local temp = {}
        --     temp[killgid] = DamageValue
        --     table.insert( g_Monsterhate[objectgid],temp)
        -- end
    end
   -- rfalse("objectgid = "..objectgid.."")
   -- printtable(g_Monsterhate[objectgid])

    if g_MonsterFightTime[objectgid] == nil then
        g_MonsterFightTime[objectgid] = {}
        g_MonsterFightTime[objectgid].FightStartTime = os.time()    --战斗开始时间
        g_MonsterFightTime[objectgid].FightTime = os.time()         --战斗持续时间
    else
        local FightStartTime = g_MonsterFightTime[objectgid].FightStartTime
        if os.time() - FightStartTime > 5 then     --应该脱离战斗,战斗持续时间重新计算
            g_MonsterFightTime[objectgid].FightTime = os.time()
        else
            g_MonsterFightTime[objectgid].FightStartTime = os.time()   --更新战斗开始时间
        end
    end

end

function OnPlayerDamage(objectgid,DamageValue,killgid)  --目标收到伤害,怪物攻击
    if g_MonsterFightTime[killgid] == nil then
        g_MonsterFightTime[killgid] = {}
        g_MonsterFightTime[killgid].FightStartTime = os.time()    --战斗开始时间
        g_MonsterFightTime[killgid].FightTime = os.time()         --战斗持续时间
    else
        local FightStartTime = g_MonsterFightTime[killgid].FightStartTime
        if os.time() - FightStartTime > 5 then     --应该脱离战斗,战斗持续时间重新计算
            g_MonsterFightTime[killgid].FightTime = os.time()
        else
            g_MonsterFightTime[killgid].FightStartTime = os.time()   --更新战斗开始时间
        end
    end
end

function MonsterHateInit()
    if g_Monsterhate == nil then
        g_Monsterhate = {}
    end

    if g_MonsterFightTime == nil then
        g_MonsterFightTime = {}
    end
end


function CheckRuntime()
    local hatevalue = 1
    local EnemyID = 1
    local isfindPEnemyID = 0
    for k,v in pairs(g_Monsterhate) do
        if CheckObject(k) == 0 then
            RemoveFromTable(g_Monsterhate,k)
            break
        end
        if GetFightObjActionID(k) == EA_DEAD then
            RemoveFromTable(g_Monsterhate,k)
            break
        end
        for i,j in pairs(v) do
            if GetFightObjActionID(i) == EA_DEAD then
                RemoveFromTable(v,i)
            else
                if hatevalue < j then
                    hatevalue = j
                    EnemyID = i
                end
            end
             --rfalse("EnemyID = "..i.." hatevalue = "..j.."")
        end
        if EnemyID > 1 then
           -- rfalse("EnemyID = "..EnemyID.."")
            SetMonsterData(k,GMon_LastEnemyID,EnemyID)
           --rfalse("CheckRuntime SetMonsterData = "..EnemyID.."")
        end
        --
        hatevalue = 1
        EnemyID = 1
    end

    for k,v in pairs(g_MonsterFightTime) do
        if CheckObject(k) == 0 then
            RemoveFromTable(g_MonsterFightTime,k)
            break
        end
        local FightStartTime = v.FightStartTime
        if os.time() - FightStartTime > 5 then     --应该脱离战斗,战斗持续时间重新计算
            v.FightTime = os.time()
        end
    end

end

function OnMonsterDie(objectgid)
    local gidpos = 1
    local isfind = false
    for k,v in pairs(g_Monsterhate) do
       if k == objectgid then
            isfind = true
            break
       end
       gidpos = gidpos + 1
    end
    if isfind == true then
        g_Monsterhate[objectgid] = nil
        table.remove(g_Monsterhate,gidpos)
        --rfalse("OnMonsterDieremove "..objectgid.."")
    end
    if g_MonsterFightTime[objectgid] ~= nil then
        RemoveFromTable(g_MonsterFightTime,objectgid)
    end
    OnAiMonster_Dead(objectgid)
end

function OnMonsterKillPlayer(objectgid,reginid,mapID,killgid)
    if GetObjectType(objectgid) == OBJECT_PLAYER then
         if GetObjectType(killgid) == OBJECT_MONSTER then
            rfalse("MonsterKillPlayer SetStopTracing")
            SetStopTracing(killgid)
         end
    else
         if GetObjectType(killgid) == OBJECT_MONSTER then
            rfalse("SetStopTracing")
            SetStopTracing(killgid)
         end
    end
end

function GetMonsterFightTime(objectgid)  --获取战斗时间
    if g_MonsterFightTime[objectgid] ~= nil then
        local FightTime = g_MonsterFightTime[objectgid].FightTime
        return os.time() - FightTime
    end
    return 0
end


MonsterHateInit()