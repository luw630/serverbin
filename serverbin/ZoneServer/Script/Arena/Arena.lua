PlayerArenaData= tostring("PlayerArenaSaveData") --玩家竞技场数据
PlayerArenaRewardTime = 5 * 60  --秒    玩家竞技场领奖间隔时间
PlayerArenaConWinTime = 23   --    玩家竞技场连胜清零时间
PlayerArenaChallengCount = 10   --玩家挑战次数

function OnMonsterBirth(PropertyID,RankIndex)
    if ArenaConfig ~= nil then
        for i,v in ipairs(ArenaConfig) do
            if v.RankIndex == RankIndex then 
                CopyFromPlayer(v)
            end
        end
    end
end


function OnPlayerWinInArena(killgid,reginid,rankindex) --当玩家战胜对手的时候
    if rankindex == 0 then
        return
    end
    local ArenaPlayer = {}
    local temp = CopyPlayerToTable(killgid,ArenaPlayer)
   -- rfalse("OnPlayerWinInArena ")
   -- printtable(temp)

   rfalse("OnPlayerWinInArena "..rankindex.."")

    local PlayerChallengData = LoadPlayerTable(PlayerArenaData,killgid)
    if PlayerChallengData == nil then
        rfalse("Load PlayerChallengData nil")
        return
        -- PlayerChallengData = {}
        -- PlayerChallengData.dcoldtime = 0   --冷却时间
        -- PlayerChallengData.bchallengecount = 10   --挑战次数
        -- PlayerChallengData.wConWin = 0   --连胜次数
        -- PlayerChallengData.wRankPoint = 0   --  --积分
        -- PlayerChallengData.RankIndex = 2001   --  排名
        -- WeekReturnChargeData(PlayerArenaData,PlayerChallengData)
    end

    rfalse("OnPlayerWinInArena RankIndex = "..PlayerChallengData.RankIndex.." ")
   if  PlayerChallengData.RankIndex > rankindex then
        local ChallengInfo = GetChallengInfo(rankindex)
        if ChallengInfo ~= nil then
            ChallengInfo = ArenaPlayer
            ChallengInfo.RankIndex = rankindex

            SaveArenaData()
            -- PutPlayerFromDynamic(1,reginid,0,0,0)                       --把玩家从场景从移动
            -- DestroyScene(reginid)

            PlayerChallengData.RankIndex = rankindex
            WeekReturnChargeData(PlayerArenaData,PlayerChallengData,killgid)
        end
   end
   local sid = GetPlayerData(killgid,GPP_QUANJUSID)
   LeaveArena(killgid,sid,reginid)
   -- if ArenaManager[sid] ~= nil then
   --      RemoveFromTable(ArenaManager,sid)
   -- end
end


function OnPutPlayerInArena(selectindex) --移动玩家到竞技场,选择的对手索引
    local sid = GetPlayerData(0,GPP_QUANJUSID)
    local RankIndex = 0

   if selectindex < 1 or selectindex > 5 then
        rfalse("OnPutPlayerInArena selectindex Error = "..selectindex.."")
        return
    end
    
    if PlayerChallengList[sid] ~= nil then
        local ChallengList = PlayerChallengList[sid]
        if ChallengList[selectindex] ~= nil then
            rfalse("OnPutPlayerInArena:ChallengList")
            RankIndex = ChallengList[selectindex].wRank
            printtable(ChallengList[selectindex])
        end
    end

    

    if RankIndex == 0 then
        rfalse("Cannot Find ChallengList")
        return
    end

     local ChallengData = GetChallengInfo(RankIndex)
     if ChallengData == nil then
        rfalse("GetChallengInfo Faile")
        return
     end

    local PlayerChallengData = OnGetPlayerChallengData()   --竞技场数据
    if PlayerChallengData == nil then
        rfalse("OnPutPlayerInArena: PlayerChallengData nil")
        return
    end

    if PlayerChallengData.bchallengecount < 1 then
        TalkToPlayer(2,"挑战次数不足")
        rfalse("OnPutPlayerInArena challengecount notenough")
        return
    end

    local monstergid = 0

    if ArenaMap ~= nil then
        local mapx = CreateScene(ArenaMap.regionID, ArenaMap.MapID, 1, 0, 0, 0)  --创建竞技场，0创建关卡
        if (nil == mapx) then
            return
        end 
        for i,j in pairs(ArenaMap.monsterlist) do
            j.regionId = mapx
            j.monsterId =  ChallengData.MonsterId  
            j.RankIndex = RankIndex
            rfalse("Area monsterId =".. j.monsterId.." RankIndex = "..RankIndex.."")
            monstergid = CreateObjectIndirect(j)
        end
        if ArenaMap.bornPostion ~= nil then
            local x = ArenaMap.bornPostion[1] 
            local y = ArenaMap.bornPostion[2] 
            PutPlayerTo(0, x, y, mapx,0)
            rfalse("PutPlayerInArena OK")
        end
        PlayerChallengData.bchallengecount = PlayerChallengData.bchallengecount - 1
        WeekReturnChargeData(PlayerArenaData,PlayerChallengData)

        if ArenaManager[sid] == nil then
            ArenaManager[sid] = {}
        end
        if monstergid > 0 then
            local temp = {}
            temp.regionId = mapx
            temp.playergid = GetPlayerData(0,GPP_QUANJUGID)
            temp.monstergid = monstergid
            ArenaManager[sid] = deepcopy(temp)
        end
    end

end

function GetPlayerArenaRank()  --获取玩家排名
    if ArenaConfig ~= nil then
        local sid = GetPlayerData(0,GPP_QUANJUSID)
        for k,v in pairs(ArenaConfig) do
            if v.PlayerSid ~= nil and v.PlayerSid == sid then
                return v
            end
        end
    end
    return nil
end

function GetTableValueIsRepeat(ctable,value)
    for i,v in ipairs(ctable) do
        if v == value then
            return true
        end
    end
    return false
end

function RandChalleng(beginRank,endRank,RankNum)
    local Challengnum = 0
    local plist = {}
    while true do

        if Challengnum >= RankNum then
            break
        end

        local xindex =  LuaRandRange(beginRank,endRank)
        if GetTableValueIsRepeat(plist,xindex) == false then
            table.insert(plist,xindex)
            Challengnum = Challengnum + 1
        end

    end
    return plist
end

function GetChallengList(RankIndex)
    local plist = {}
    if RankIndex > 1000 and RankIndex <= 2001 then
        local randbig = RankIndex - 50
        plist = RandChalleng(randbig,RankIndex-1,4)
    elseif RankIndex > 700 and RankIndex <= 1000 then
        local randbig = RankIndex - 30
        plist = RandChalleng(randbig,RankIndex-1,4)
    elseif RankIndex > 500 and RankIndex <= 700 then
        local randbig = RankIndex - 20
        plist = RandChalleng(randbig,RankIndex-1,4)
    elseif RankIndex > 400 and RankIndex <= 500 then
        local randbig = RankIndex - 10
        plist = RandChalleng(randbig,RankIndex-1,4)
    elseif RankIndex > 300 and RankIndex <= 400 then
        local randbig = RankIndex - 8
        plist = RandChalleng(randbig,RankIndex-1,4)
    else
        local challnum = 4
        if RankIndex <= 4 then
            challnum = RankIndex - 1

        end
        if challnum > 0 then

        end
        local randbig = RankIndex - 4
        plist = RandChalleng(RankIndex,randbig,4)
    end
    return plist
end


function  GetChallengInfo(RankIndex)  --获取排名RankIndex的玩家数据
    for k,v in pairs(ArenaConfig) do
        if v.RankIndex == RankIndex then
            return v
        end
    end
    return nil
end

function OnGetPlayerChallengData()  --玩家竞技场数据
    local PlayerChallengData = LoadPlayerTable(PlayerArenaData)
    if PlayerChallengData == nil then
        PlayerChallengData = {}
        PlayerChallengData.dcoldtime = 0   --冷却时间
        PlayerChallengData.bchallengecount = PlayerArenaChallengCount   --挑战次数
        PlayerChallengData.wConWin = 0   --连胜次数
        PlayerChallengData.SendConWin = 0   --是否已经领取了连胜奖励
        PlayerChallengData.wRankPoint = 0   --  --积分
        PlayerChallengData.RankIndex = 2001   --  排名
        WeekReturnChargeData(PlayerArenaData,PlayerChallengData)
    end
    return PlayerChallengData
end

function OnRecvArenaInitMsg() --打开竞技场选择对手界面
    --rfalse("OnRecvArenaInitMsg")
    local PlayerArena = GetPlayerArenaRank()
    local PlayerChalleng = {}
    local PlayerChallengData = LoadPlayerTable(PlayerArenaData)
    if PlayerChallengData == nil then
        PlayerChallengData = {}
        PlayerChallengData.dcoldtime = 0   --冷却时间
        PlayerChallengData.bchallengecount = 10   --挑战次数
        PlayerChallengData.wConWin = 0   --连胜次数
        PlayerChallengData.wRankPoint = 0   --  --积分
        PlayerChallengData.RankIndex = 2001   --  排名
        WeekReturnChargeData(PlayerArenaData,PlayerChallengData)
    end

    PlayerChalleng.dcoldtime = PlayerChallengData.dcoldtime     
    PlayerChalleng.bchallengecount = PlayerChallengData.bchallengecount
    PlayerChalleng.wConWin = PlayerChallengData.wConWin    --连胜次数
    PlayerChalleng.wRankPoint = PlayerChallengData.wRankPoint    --积分
    PlayerChalleng.wRank =  PlayerChallengData.RankIndex   --排名

    local plist = GetChallengList( PlayerChalleng.wRank)
    if plist == nil then
        rfalse("GetChallengList nil")
        return
    end
    table.insert(plist,1)  --增加第一名
    --printtable(plist)
    local ChallengList = {}
    for k,v in pairs(plist) do
       -- rfalse("plist = "..v.."")
       local ChallengInfo = GetChallengInfo(v)
        if ChallengInfo ~= nil then
            local temp = {}
            temp.wRank = ChallengInfo.RankIndex --排名
            temp.wModID = ChallengInfo.ModId --模型ID
            temp.dfightpower = Getfightpower(ChallengInfo)  --战斗力
            temp.playername = ChallengInfo.MyName  --名字
            table.insert(ChallengList,temp)
            --printtable(temp)
        end
    end
    --rfalse(" print ChallengList --------------")
    -- printtable(ChallengList)
    local sid  = GetPlayerData(0,GPP_QUANJUSID)
    if PlayerChallengList[sid] == nil then
        PlayerChallengList[sid] = {}
    end
    PlayerChallengList[sid] = {}
    PlayerChallengList[sid] = ChallengList
   SendArenaInitMsg(PlayerChalleng,ChallengList)
   --printtable(PlayerChalleng)
    rfalse("OnRecvArenaInitMsg Rank = "..PlayerChalleng.wRank.."")
   --printtable(ChallengList)
  
  -- printtable(PlayerChallengList[sid][1])
     --SendArenaInitMsg(ChallengList)
 end


 function GetLevelReward(ranklevel) --得到排名阶段奖励
    if ArenaRewardConfig == nil then
        rfalse("ArenaRewardConfig nil")
        return
    end
    for k,v in pairs(ArenaRewardConfig) do
        if v.levelstage ~= nil then
            if ranklevel >= v.levelstage[1] and ranklevel <= v.levelstage[2] then
                return v
            end
        end
    end
    return nil
 end


 function OnRecvArenaRewardUIMsg() --打开竞技场奖励界面
    local sendreward = {}
    local AllArenaReward = {}
    for i=1,10 do   --取得前10奖励
        local ArenaReward = GetLevelReward(i)
        if ArenaReward == nil then
            rfalse("GetArenaReward nil")
            return
        end
        local temp = {}
        temp.rankstage = {}
        temp.arenaitem = {}
        temp.arenaitemnum = {}
        temp.rankstage.wMinRank =ArenaReward.levelstage[1]
        temp.rankstage.wMaxRank = ArenaReward.levelstage[2]
        for k,v in pairs(ArenaReward.rewardlist) do
             if k % 2 > 0 then
                table.insert(temp.arenaitem,v)
             else
                table.insert(temp.arenaitemnum,v)
             end
        end
        table.insert(AllArenaReward,temp)
    end
    local currentreward = {}
    local upstagereward = {}  --下一阶段奖励
    local PlayerChallengData = OnGetPlayerChallengData()   --竞技场数据
    if PlayerChallengData ~= nil then
        sendreward.wRankPoint = PlayerChallengData.wRankPoint  --积分
        --sendreward.wRankPoint = 12888  --积分
        sendreward.drewardcoldtime = PlayerChallengData.dcoldtime  --领取冷却时间
        if PlayerChallengData.dcoldtime > 0 then
            if PlayerChallengData.dcoldtime + PlayerArenaRewardTime <= os.time() then
                sendreward.drewardcoldtime = 0 
            else
                sendreward.drewardcoldtime = PlayerChallengData.dcoldtime + PlayerArenaRewardTime - os.time()
            end
        end

        sendreward.dConWinItem = {}   --连胜奖励
        sendreward.bConWinItemNum = {} --连胜奖励道具数量

        if ArenaConReConfig[10] ~= nil then
            for k,v in pairs(ArenaConReConfig[10]) do
                if k % 2 > 0 then
                    table.insert( sendreward.dConWinItem,v)
                else
                    table.insert(sendreward.bConWinItemNum,v)
                end
            end
        end
   
        local RankIndex = PlayerChallengData.RankIndex
        local ArenaReward = GetLevelReward(RankIndex)
        local nextrank = 0
        if ArenaReward ~= nil then
            local temp = {}
            currentreward.rankstage = {}
            currentreward.arenaitem = {}
            currentreward.arenaitemnum = {}
            currentreward.rankstage.wMinRank =ArenaReward.levelstage[1]
            currentreward.rankstage.wMaxRank = ArenaReward.levelstage[2]
            nextrank = currentreward.rankstage.wMinRank 
            for k,v in pairs(ArenaReward.rewardlist) do
                 if k % 2 > 0 then
                    table.insert(currentreward.arenaitem,v)
                 else
                    table.insert(currentreward.arenaitemnum,v)
                 end
            end
            --table.insert(currentreward,temp)

            nextrank = nextrank - 1
            if nextrank == 0 then
                rfalse("!First Rank Player")
                nextrank = 1
            end

            ArenaReward = GetLevelReward(nextrank)
            if ArenaReward ~= nil then
                upstagereward.rankstage = {}
                upstagereward.arenaitem = {}
                upstagereward.arenaitemnum = {}
                upstagereward.rankstage.wMinRank =ArenaReward.levelstage[1]
                upstagereward.rankstage.wMaxRank = ArenaReward.levelstage[2]
                 for k,v in pairs(ArenaReward.rewardlist) do
                     if k % 2 > 0 then
                        table.insert(upstagereward.arenaitem,v)
                     else
                        table.insert(upstagereward.arenaitemnum,v)
                     end
                end
                --table.insert(upstagereward,temp)
            end
        end

        sendreward.GetConWin =  0
        sendreward.GetCommonWin = 0
        GetArenaRewardInfoMsg(sendreward)
        printtable(sendreward)
        SendArenaRewardMsg(sendreward,AllArenaReward,upstagereward,currentreward)
    end
 end


function GetArenaRewardConWin(wConWin) --是否有连胜奖励
    for i=1,wConWin do
        if ArenaConReConfig[i] ~= nil then
            return i 
        end
    end
    return 0
end

function OnQuestArenaReward(bRewardtype) --客户端请求领取竞技场奖励
    rfalse("OnQuestArenaReward")
    local rewardInfo = {}
    rewardInfo.GetConWin =  0
    rewardInfo.GetCommonWin = 0
    GetArenaRewardInfoMsg(rewardInfo)
    if rewardInfo.GetCommonWin > 0 and bRewardtype == 1  then  --普通奖励
        local PlayerChallengData = OnGetPlayerChallengData()   --竞技场数据
        if PlayerChallengData ~= nil then
            local RankIndex = PlayerChallengData.RankIndex
            local ArenaReward = GetLevelReward(RankIndex)
            if ArenaReward ~= nil then
                local itemcell = GetTableLenth(ArenaReward.rewardlist) / 2
                if GetBlankCell() < itemcell then
                    rfalse("bagceLL notenough")
                    rewardInfo.GetCommonWin = 1      --可以领取但是未领取成功
                    --return 
                else
                    for i=1,itemcell*2 do
                        if i % 2 > 0 then
                            GiveGoods(ArenaReward.rewardlist[i],ArenaReward.rewardlist[i+1])
                        end
                    end
                    PlayerChallengData.dcoldtime = os.time()
                    rfalse("Send CommonWin")
                    rewardInfo.GetCommonWin = 2      --可以领取成功
                    WeekReturnChargeData(PlayerArenaData,PlayerChallengData)
                end
            end
        end
    end 

     if rewardInfo.GetConWin > 0 and bRewardtype == 2  then  --连胜奖励
        local wincount = GetArenaRewardConWin(PlayerChallengData.wConWin)
        if wincount > 0 then
            if ArenaConReConfig[wincount] ~= nil then
                local  ArenaCon = ArenaConReConfig[wincount]
                local itemcell = GetTableLenth(ArenaCon) / 2
                if GetBlankCell() < itemcell then
                    rfalse("bagceLL notenough")
                    rewardInfo.GetConWin = 1      --可以领取但是未领取成功 
                 else
                    for i=1,itemcell*2 do
                        if i % 2 > 0 then
                            GiveGoods(ArenaCon[i],ArenaCon[i+1])
                        end
                    end
                     PlayerChallengData.SendConWin = 1
                    PlayerChallengData.wConWin = 0
                    rfalse("Send ConWin")
                    rewardInfo.GetConWin = 2      --可以领取成功
                    WeekReturnChargeData(PlayerArenaData,PlayerChallengData)
                end
            end
        end
    end
    local PlayerChallengData = OnGetPlayerChallengData()   --竞技场数据
    rewardInfo.drewardcoldtime = PlayerChallengData.dcoldtime
    rewardInfo.wRankPoint = PlayerChallengData.wRankPoint
    if PlayerChallengData.dcoldtime > 0 then
        if PlayerChallengData.dcoldtime + PlayerArenaRewardTime > os.time() then
            rewardInfo.drewardcoldtime = PlayerChallengData.dcoldtime + PlayerArenaRewardTime - os.time()
        end
    end
    printtable(rewardInfo)
    SendArenaQuestMsg(rewardInfo)
end

 function GetArenaRewardInfoMsg(sendreward) --客户端请求竞技场是否有奖励可以领取
    local PlayerChallengData = OnGetPlayerChallengData()   --竞技场数据
    if PlayerChallengData ~= nil then
        if PlayerChallengData.dcoldtime == 0 then
            sendreward.GetCommonWin = 1                   
        else
            if PlayerChallengData.dcoldtime + PlayerArenaRewardTime <= os.time() then
                sendreward.GetCommonWin = 1   
                PlayerChallengData.dcoldtime = 0
                WeekReturnChargeData(PlayerArenaData,PlayerChallengData)
            end
        end

        if PlayerChallengData.SendConWin == 0 then
            if PlayerChallengData.wConWin > 0 then
                if GetArenaRewardConWin(PlayerChallengData.wConWin) > 0 then  --有连胜奖励
                    sendreward.GetConWin = 1             --连胜奖励
                end
            end
        end
        --SendArenaRewardInfoMsg()
    end
 end


 -- function Getfightpower(objtable) --战斗力
 --    return  objtable.MaxHp*1 + objtable.GongJi*6 + objtable.FangYu*3 + objtable.Hit*2 + objtable.ShanBi*2 + objtable.BaoJi*8.22 + objtable.Uncrit*8.22 + objtable.Wreck*8.22 + objtable.Unwreck*8.22 + objtable.Puncture*8.22 + objtable.Unpuncture*8.22
 -- end

function  AreaChallengInit()
    if PlayerChallengList == nil then
        PlayerChallengList = {}
    end
end

AreaChallengInit()


