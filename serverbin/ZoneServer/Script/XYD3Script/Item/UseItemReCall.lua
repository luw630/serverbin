--技能书和技能对应表
ItemLearnSkill = {}
ItemLearnSkill[2000001] = 101
ItemLearnSkill[2000002] = 102
ItemLearnSkill[2000003] = 103
ItemLearnSkill[2000004] = 104
ItemLearnSkill[2000005] = 105
ItemLearnSkill[2000006] = 106
ItemLearnSkill[2000007] = 107
ItemLearnSkill[2000008] = 108
ItemLearnSkill[2000009] = 109
--心法书和心法对应表
ItemLearnTelegry = {}
ItemLearnTelegry[6100001] = 6000
--道具和Buff对应表
ItemAddbuff = {}
--加血
ItemAddbuff[3490001] = 1
ItemAddbuff[3490002] = 2
ItemAddbuff[3490003] = 3
ItemAddbuff[3490004] = 4
ItemAddbuff[3490005] = 5
--加内
ItemAddbuff[3495001] = 17
ItemAddbuff[3495002] = 18
ItemAddbuff[3495003] = 19
ItemAddbuff[3495004] = 20
ItemAddbuff[3495005] = 21
--任务道具使用映射表 
TaskItemUse = {}
--TaskItemUse[900002] = {task = 6,    region = 2,  xmin = 1150,  xmax = 1250 ,  ymin = 950, ymax = 1051}		-- 示例
--心法学习回调
function OnUseItem(ItemID)
	local gid = GetPlayerData(0,GPP_QUANJUGID)
    if ItemID == 999998 then
            ChangeMoney(2,299999)
            return 1
    elseif ItemID == 710306 then
            local gid = GetPlayerData(0,GPP_QUANJUGID)
			AddBuff(gid,30021)
			TalkToPlayer(2,"攻击增加")
            return 1
	elseif ItemID == 720205 then
            GiveSp(5000)
			--信仰神格SetObjectData(gid,OBJDATA_SP,20)
			TalkToPlayer(2,"获得信仰之力5000")
            return 1
	elseif ItemID == 720206 then
            GiveSp(1000)
			--信仰之源SetObjectData(gid,OBJDATA_SP,20)
			TalkToPlayer(2,"获得信仰之力1000")
            return 1
	elseif ItemID == 720207 then
            GiveExp(5000)
			TalkToPlayer(2,"获得经验值5000")
            return 11
	elseif ItemID == 720208 then
            GiveSp(1000)
			--元气球SetObjectData(gid,OBJDATA_SP,20)
			TalkToPlayer(2,"获得信仰之力1000")
            return 1
	elseif ItemID == 720209 then
            GiveSp(5000)
			--巨力元气SetObjectData(gid,OBJDATA_SP,20)
			TalkToPlayer(2,"获得信仰之力5000")
            return 1
	elseif ItemID == 720210 then
            GiveExp(8000)
			TalkToPlayer(2,"获得经验值8000")
            return 1
	elseif ItemID == 720211 then
            GiveExp(1000)
			TalkToPlayer(2,"获得经验值1000")
            return 11
	elseif ItemID == 720212 then
            GiveExp(5000)
			TalkToPlayer(2,"获得经验值5000")
            return 11
	elseif ItemID == 720213 then
            GiveExp(10000)
			TalkToPlayer(2,"获得经验值10000")
            return 11
	elseif ItemID == 720214 then
            GiveExp(50000)
			TalkToPlayer(2,"获得经验值50000")
            return 11
	elseif ItemID == 720215 then
            GiveExp(10000)
			TalkToPlayer(2,"获得经验值10000")
            return 11
	elseif ItemID == 720216 then
            GiveExp(20000)
			TalkToPlayer(2,"获得经验值20000")
            return 11
	elseif ItemID == 720217 then
            GiveExp(50000)
			TalkToPlayer(2,"获得经验值50000")
            return 11
	elseif ItemID == 720218 then
            GiveExp(80000)
			TalkToPlayer(2,"获得经验值80000")
            return 11
	elseif ItemID == 720241 then
            GiveExp(1000)
			TalkToPlayer(2,"获得经验值1000")
            return 11
	elseif ItemID == 720242 then
            GiveExp(5000)
			TalkToPlayer(2,"获得经验值5000")
            return 11
	elseif ItemID == 720243 then
            GiveExp(10000)
			TalkToPlayer(2,"获得经验值10000")
            return 11
	elseif ItemID == 720244 then
            GiveExp(50000)
			TalkToPlayer(2,"获得经验值50000")
            return 11
	elseif ItemID == 720271 then
            ChangeMoney(2,1000)
			TalkToPlayer(2,"获得银币1000")
            return 1
	elseif ItemID == 720272 then
            ChangeMoney(2,5000)
			TalkToPlayer(2,"获得银币5000")
            return 1
	elseif ItemID == 720273 then
            ChangeMoney(2,10000)
			TalkToPlayer(2,"获得银币10000")
            return 1
	elseif ItemID == 720274 then
            GiveExp(1000)
			TalkToPlayer(2,"获得经验值1000")
            return 11
	elseif ItemID == 720275 then
            GiveExp(5000)
			TalkToPlayer(2,"获得经验值5000")
            return 11
	elseif ItemID == 720276 then
            GiveExp(10000)
			TalkToPlayer(2,"获得经验值10000")
            return 11
	elseif ItemID == 730101 then
            ChangeMoney(2,2000)
			TalkToPlayer(2,"获得银币2000")
            return 1
	elseif ItemID == 730102 then
            GiveSp(1000)
			TalkToPlayer(2,"获得信仰之力1000")
            return 1
	elseif ItemID == 730103 then
            ChangeMoney(2,3000)
			TalkToPlayer(2,"获得银币3000")
            return 1
	elseif ItemID == 730104 then
            GiveSp(1500)
			TalkToPlayer(2,"获得信仰之力1500")
            return 1
	elseif ItemID == 730105 then
            ChangeGloryDot(0, 10000)
			TalkToPlayer(2,"获得荣耀点10000")
            return 1
	elseif ItemID == 730106 then
            ChangeMoney(2,5000)
			TalkToPlayer(2,"获得银币5000")
            return 1
	elseif ItemID == 730107 then
            GiveSp(3000)
			TalkToPlayer(2,"获得信仰之力3000")
            return 1
	elseif ItemID == 999997 then
			--SetObjectData(gid,OBJDATA_SP,1560)
            GiveSp(1560)
            return 1
	elseif ItemID == 810101 then
            ChangeMoney(2,1000)
			TalkToPlayer(2,"获得银币1000")
            return 1
	elseif ItemID == 810102 then
            ChangeMoney(2,5000)
			TalkToPlayer(2,"获得银币5000")
            return 1
	elseif ItemID == 810103 then
            ChangeMoney(2,10000)
			TalkToPlayer(2,"获得银币10000")
            return 1
	elseif ItemID == 810104 then
            ChangeMoney(2,15000)
			TalkToPlayer(2,"获得银币15000")
            return 1
	elseif ItemID == 810105 then
            ChangeMoney(2,20000)
            return 1
	elseif ItemID == 810106 then
            ChangeMoney(2,25000)
			TalkToPlayer(2,"获得银币25000")
            return 1
	elseif ItemID == 810107 then
            ChangeMoney(2,30000)
			TalkToPlayer(2,"获得银币30000")
            return 1
	elseif ItemID == 810108 then
            ChangeMoney(2,35000)
			TalkToPlayer(2,"获得银币35000")
            return 1
	elseif ItemID == 810109 then
            ChangeMoney(2,40000)
            return 1
	elseif ItemID == 810110 then
            ChangeMoney(2,45000)
			TalkToPlayer(2,"获得银币45000")
            return 1
	elseif ItemID == 810111 then
            ChangeMoney(2,50000)
			TalkToPlayer(2,"获得银币50000")
            return 1
	elseif ItemID == 810112 then
            ChangeMoney(2,55000)
			TalkToPlayer(2,"获得银币55000")
            return 1
	elseif ItemID == 810113 then
            GiveSp(5)
			--SetObjectData(gid,OBJDATA_SP,5)
			TalkToPlayer(2,"获得信仰之力5")
            return 1
	elseif ItemID == 810114 then
            GiveSp(5)
			--SetObjectData(gid,OBJDATA_SP,5)
			TalkToPlayer(2,"获得信仰之力5")
            return 1
	elseif ItemID == 810115 then
            GiveSp(5)
			--SetObjectData(gid,OBJDATA_SP,5)
			TalkToPlayer(2,"获得信仰之力5")
            return 1
	elseif ItemID == 810116 then
            GiveSp(10)
			--SetObjectData(gid,OBJDATA_SP,10)
			TalkToPlayer(2,"获得信仰之力10")
            return 1
	elseif ItemID == 810117 then
            GiveSp(10)
			--SetObjectData(gid,OBJDATA_SP,10)
			TalkToPlayer(2,"获得信仰之力10")
            return 1
	elseif ItemID == 810118 then
            GiveSp(10)
			--SetObjectData(gid,OBJDATA_SP,10)
			TalkToPlayer(2,"获得信仰之力10")
            return 1
	elseif ItemID == 810119 then
            GiveSp(10)
			--SetObjectData(gid,OBJDATA_SP,10)
			TalkToPlayer(2,"获得信仰之力10")
            return 1
	elseif ItemID == 810120 then
            GiveSp(10)
			--SetObjectData(gid,OBJDATA_SP,10)
			TalkToPlayer(2,"获得信仰之力10")
            return 1
	elseif ItemID == 810121 then
            GiveSp(20)
			--SetObjectData(gid,OBJDATA_SP,20)
			TalkToPlayer(2,"获得信仰之力20")
            return 1
	elseif ItemID == 810122 then
            GiveSp(20)
			--SetObjectData(gid,OBJDATA_SP,20)
			TalkToPlayer(2,"获得信仰之力20")
            return 1
	elseif ItemID == 810123 then
            GiveSp(20)
			--SetObjectData(gid,OBJDATA_SP,20)
			TalkToPlayer(2,"获得信仰之力20")
            return 1
	elseif ItemID == 810124 then
            GiveSp(20)
			--SetObjectData(gid,OBJDATA_SP,20)
			TalkToPlayer(2,"获得信仰之力20")
            return 1
	elseif ItemID == 810125 then
            ChangeMoney(1,5)
			TalkToPlayer(2,"获得钻石5")
            return 1
	elseif ItemID == 810126 then
            ChangeMoney(1,10)
			TalkToPlayer(2,"获得钻石10")
            return 1
	elseif ItemID == 810127 then
            ChangeMoney(1,15)
			TalkToPlayer(2,"获得钻石15")
            return 1
	elseif ItemID == 810128 then
            ChangeMoney(1,20)
			TalkToPlayer(2,"获得钻石20")
            return 1
	elseif ItemID == 810129 then
            ChangeMoney(1,25)
			TalkToPlayer(2,"获得钻石25")
            return 1
	elseif ItemID == 810130 then
            ChangeMoney(1,30)
			TalkToPlayer(2,"获得钻石30")
            return 1
	elseif ItemID == 9000001 then
            ChangeMoney(2,4718)
			TalkToPlayer(2,"新手礼包1")
            return 1
	elseif ItemID == 9000002 then
            ChangeMoney(2,9435)
			--SetObjectData(gid,OBJDATA_SP,26412)
            GiveSp(26412)
			TalkToPlayer(2,"新手礼包2")
            return 1
	elseif ItemID == 9000003 then
			ChangeMoney(2,14153)
            GiveGoods(190101 , 5)
			GiveGoods(190103 , 9)
			TalkToPlayer(2,"升级道具包")
            return 1
	elseif ItemID == 9000004 then
            ChangeMoney(2,18870)
			--SetObjectData(gid,OBJDATA_SP,52824)
            GiveSp(52824)
			GiveExp(408)			
			TalkToPlayer(2,"新手礼包4")
            return 1
	elseif ItemID == 9000005 then
            GiveGoods(190500 , 3)
			ChangeMoney(2,23588)
			TalkToPlayer(2,"奥义技能包")
            return 1
	elseif ItemID == 9000006 then
            ChangeMoney(2,28305)
			GiveExp(737)
			TalkToPlayer(2,"新手礼包5")
            return 1
	elseif ItemID == 9000007 then
            ChangeMoney(1,88)
			ChangeMoney(2,33023)
			--SetObjectData(gid,OBJDATA_SP,79236)
            GiveSp(79236)
			GiveExp(862)
			TalkToPlayer(2,"新手礼包6")
            return 1
	elseif ItemID == 9010001 then
            ChangeMoney(1,50)
			TalkToPlayer(2,"新手礼包1")
            return 1
	elseif ItemID == 9010002 then
            ChangeMoney(1,60)
			TalkToPlayer(2,"新手礼包2")
            return 1
	elseif ItemID == 9010003 then
            GiveGoods(190101 , 5)
			GiveGoods(190103 , 9)
			TalkToPlayer(2,"升级道具包")
            return 1
	elseif ItemID == 9010004 then
            ChangeMoney(1,70)
			TalkToPlayer(2,"新手礼包4")
            return 1
	elseif ItemID == 9010005 then
            GiveGoods(190500 , 3)
			TalkToPlayer(2,"奥义技能包")
            return 1
	elseif ItemID == 9010006 then
            ChangeMoney(1,80)
			TalkToPlayer(2,"新手礼包5")
            return 1					
    elseif ItemID == 9100201 then
        UsePetItemGet(213, 100)
        return 1
    elseif ItemID == 9100202 then
        UsePetItemGet(214, 100)
        return 1
	elseif ItemID == 9100203 then
        UsePetItemGet(513)
        return 1
	elseif ItemID == 9100204 then
        UsePetItemGet(514)
        return 1
	elseif ItemID == 9100205 then
        UsePetItemGet(515)
        return 1
	elseif ItemID == 9100206 then
        UsePetItemGet(517)
        return 1
	elseif ItemID == 9100207 then
        UsePetItemGet(509)
        return 1
	elseif ItemID == 9100208 then
        UsePetItemGet(510)
        return 1
	elseif ItemID == 910011 then
            GiveExp(6500)
			TalkToPlayer(2,"获得经验值6500")
            return 1
	elseif ItemID == 910012 then
            GiveExp(20600)
			TalkToPlayer(2,"获得经验值20600")
            return 1
	elseif ItemID == 910013 then
            GiveExp(65000)
			TalkToPlayer(2,"获得经验值65000")
            return 1
	elseif ItemID == 910021 then
			GiveSp(5100)
			--SetObjectData(gid,OBJDATA_SP,5)
			TalkToPlayer(2,"获得信仰之力5100")
            return 1
	elseif ItemID == 910022 then
			GiveSp(16000)
			--SetObjectData(gid,OBJDATA_SP,5)
			TalkToPlayer(2,"获得信仰之力16000")
            return 1
	elseif ItemID == 910023 then
			GiveSp(50300)
			--SetObjectData(gid,OBJDATA_SP,5)
			TalkToPlayer(2,"获得信仰之力50300")
            return 1
	elseif ItemID == 910031 then
            ChangeMoney(2,2400)
			TalkToPlayer(2,"获得银币2400")
            return 1
	elseif ItemID == 910032 then
            ChangeMoney(2,7700)
			TalkToPlayer(2,"获得银币7700")
            return 1
	elseif ItemID == 910033 then
            ChangeMoney(2,24300)
			TalkToPlayer(2,"获得银币24300")
            return 1
	elseif ItemID == 190700 then
            ChangeGloryDot(0, 1000000)
			TalkToPlayer(2,"获得荣耀点1000000")
            return 1
	elseif ItemID == 890001 then
			if type(BaoXiangRandItem[ItemID]) == "table" then
				GItemID, GItemNum = RandGetItem(BaoXiangRandItem[ItemID])
				if GItemID ~= nil then
					GiveGoods(GItemID, GItemNum)
					TalkToPlayer(2,"获得荣耀勋章一个")
				end
			end
			return 1
	elseif ItemID == 890002 then
			if type(BaoXiangRandItem[ItemID]) == "table" then
				GItemID, GItemNum = RandGetItem(BaoXiangRandItem[ItemID])
				if GItemID ~= nil then
					GiveGoods(GItemID, GItemNum)
					TalkToPlayer(2,"获得装备升阶材料一个")
				end
			end
			return 1
	
	end 
	
end

BaoXiangRandItem = {
    [890001] = 
    {
        --材料道具ID，奖励道具的数量, 权重
        {190655, 1, 11},{190656, 1, 10},{190657, 1, 10},{190658, 1, 8},{190659, 1, 3},{190660, 1, 3},{190661, 1, 3},{190662, 1, 12},{190663, 1, 3},{190664, 1, 3},{190665, 1, 3},{190666, 1, 3},{190667, 1, 3},{190668, 1, 3},{190669, 1, 3},{190670, 1, 3},
    },
    [890002] = --
    {
        --材料道具ID，奖励道具的数量, 权重
        {190101, 1, 5},{190102, 1, 5},{190103, 1, 5},{190104, 1, 5},{190111, 1, 5},{190112, 1, 5},{190113, 1, 5},{190114, 1, 5},{190121, 1, 5},{190122, 1, 5},{190123, 1, 5},{190124, 1, 5},{190131, 1, 5},{190132, 1, 5},{190133, 1, 5},{190134, 1, 5},{190141, 1, 5},{190142, 1, 5},{190143, 1, 5},{190144, 1, 5},
    },
    [890003] = --
    {
        --材料道具ID，奖励道具的数量, 权重
        {190112, 1, 5},
        {190114, 1, 5},
    },
}
--[[function OnUseItem(ItemID)
    if ItemID == 999888 then
        if GetBlankCell() < 1 then
            TalkToPlayer(2,"需要3个背包格")
        else
            GiveGoods(190201,9)
            GiveGoods(190401,9)
            GiveGoods(190411,2)
            return 1
        end 
    elseif
		ItemID == 190702 then
        if GetBlankCell() < 3 then
            TalkToPlayer(2,"需要3个背包格")
        else
            GiveGoods(190201,9)
            GiveGoods(190401,9)
            GiveGoods(190411,2)
            return 1
        end 
    elseif ItemID == 190703 then
        if GetBlankCell() < 3 then
            TalkToPlayer(2,"需要3个背包格")
        else
            GiveGoods(190201,9)
            GiveGoods(190401,9)
            GiveGoods(190411,2)
            return 1
        end 
    elseif ItemID == 190704 then
        if GetBlankCell() < 3 then
            TalkToPlayer(2,"需要3个背包格")
        else
            GiveGoods(190201,9)
            GiveGoods(190401,9)
            GiveGoods(190411,2)
            return 1
        end 
    elseif ItemID == 190705 then
        if GetBlankCell() < 3 then
            TalkToPlayer(2,"需要3个背包格")
        else
            GiveGoods(190201,9)
            GiveGoods(190401,9)
            GiveGoods(190411,2)
            return 1
        end 
    elseif ItemID == 190706 then
        if GetBlankCell() < 3 then
            TalkToPlayer(2,"需要3个背包格")
        else
            GiveGoods(190201,9)
            GiveGoods(190401,9)
            GiveGoods(190411,2)
            return 1
        end 
    elseif ItemID == 190707 then
        if GetBlankCell() < 3 then
            TalkToPlayer(2,"需要3个背包格")
        else
            GiveGoods(190201,9)
            GiveGoods(190401,9)
            GiveGoods(190411,2)
            return 1
        end 
    elseif ItemID == 190708 then
        if GetBlankCell() < 3 then
            TalkToPlayer(2,"需要3个背包格")
        else
            GiveGoods(190201,9)
            GiveGoods(190401,9)
            GiveGoods(190411,2)
            return 1
        end 
    elseif ItemID == 190709 then
        if GetBlankCell() < 3 then
            TalkToPlayer(2,"需要3个背包格")
        else
            GiveGoods(190201,9)
            GiveGoods(190401,9)
            GiveGoods(190411,2)
            return 1
        end 
    end
    return 0
end]]

--[[function OnUseItem6000002(ItemID)
	if (nil == ItemLearnTelegry[ItemID]) then
		return 0
	end

	local result = ActiveTelegry(ItemLearnTelegry[ItemID])
	return result
end
GetBlankCell()
function OnUseItem2110001(ItemID)	 --体质增长
  return GrowTiZhi(ItemID)
end
function OnUseItem2120001(ItemID)	--体质突破
  -- for i=1,23 do
  -- 	CanAddItems(1, 3530000+i,1)
  -- 	local xcan = CanAddItems(2, 1, 1)
  -- 	if xcan == 1 then
  -- 		GiveGoods(3530000+i,1)
  -- 	end
  -- end	
  -- GiveGoods(3490001,1)
  -- GiveGoods(3490002,1)
  -- GiveGoods(3490003,1)
  -- GiveGoods(3490004,1)
  -- GiveGoods(3490005,1)
  -- GiveGoods(3495001,1)
  -- GiveGoods(3495002,1)
  -- GiveGoods(3495003,1)
  -- GiveGoods(3495004,1)
  -- GiveGoods(3495005,1)
  return UpgradeTiZhi(ItemID)
end
--加坐骑
function OnUseItem5000001(ItemID)--1
	local result = GiveMount(1)
	if (nil == result or 0 == result) then
		return 0
	else
		return 1
	end
end
--技能学习回调
function OnUseItem6000001(ItemID)
	rfalse("开始使用技能书"..ItemID)
	if (nil == ItemLearnSkill[ItemID]) then
		return 0
	end
	local result = ActiveSkill(ItemLearnSkill[ItemID])
	rfalse("使用技能书成功"..ItemID)
	return result
end
--药品Buff
function OnUseItem7000001(ItemID)
	rfalse(ItemID)
	if (nil == ItemAddbuff[ItemID]) then
		return 0
	end
	PlayerAddBuff(ItemAddbuff[ItemID])
	return 1
end
--固定地点使用任务道具
function OnUseItem2530010(ItemID)
	if (nil == TaskItemUse[ItemID]) then
		return 0
	end

	local a = GetTaskStatus(TaskItemUse[ItemID].task)
	if a == 2 then
		local RegionID, X, Y = GetPlayerMapInfo()
		if (RegionID == TaskItemUse[ItemID].region and X >= TaskItemUse[ItemID].xmin and X <=TaskItemUse[ItemID].xmax and Y >= TaskItemUse[ItemID].ymin and Y<=TaskItemUse[ItemID].ymax) then
			if( ItemID == 900002 ) then
				GiveGoods(900003, 1)
			end
			return 1
		else
			TalkToPlayer(2, Prompt[9])
			return 0
		end
	end

	return 0
end
function OnUseItem99999(ItemID) --万测试道具
	GivePet(1)
	GiveExp(900000000)
	GiveGoods(2000001,1)
	PutPlayerTo(2,1100,990,0,0)
	PutPlayerToEventRegion(20003,146,200)
	PutPlayerToEventRegion(20004,234,285)	 
	GiveGoods(6020008,1)
	RegionID, X, Y = GetPlayerMapInfo()
	rfalse("RegionID="..RegionID.."	"..X.."	"..Y)
	DynamicCreateNpc(50201,RegionID,X,Y,100)
	local mCreateBoss = EventRegionList[20004].AIMonsterList[1]
	mCreateBoss.RegionGID = 1610623986
	CreateAIMonster(mCreateBoss,PathList[20004].AIPath_1)
end]]