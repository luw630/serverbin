function OnArenaRun()
    for k,v in pairs(ArenaManager) do
        OnArenaPlayerAtter(v.playergid,v.monstergid)
    end
end

function OnArenaPlayerAtter(playergid,monstergid)  --玩家攻击怪物
    local pos = getmonsterdatanew(monstergid,GMon_POSTION)
    printtable(pos)
    local QuestSkill = {}
    QuestSkill.AttackerGID = playergid
    QuestSkill.DefenderGID = monstergid
    QuestSkill.DefenderWorldPosX = pos[1]
    QuestSkill.DefenderWorldPosY = pos[2]
    QuestSkill.dwSkillIndex = 0
   -- PlayerProcessQuestSkill(QuestSkill)
    --ProcessQuestSkill(playergid,monstergid,pos[1],pos[2],0)
    rfalse("player ProcessQuestSkill")
end

function LeaveArena(playergid,sid,reginid)
    if GetPlayerData(playergid,GPP_ACTION) == EA_DEAD or GetPlayerData(playergid,GPP_CURHP) == 0 then
        rfalse("LeaveArenaRelive  "..playergid.."")
        PlayerQuestRelive(0,playergid)
    end
    PutPlayerFromDynamic(1,reginid,0,0,0)                       --把玩家从场景从移动
    DestroyScene(reginid)
   if ArenaManager[sid] ~= nil then
        RemoveFromTable(ArenaManager,sid)
   end
end

function InitArenaMager()
    if ArenaManager == nil then
        ArenaManager = {}
    end
end

InitArenaMager()