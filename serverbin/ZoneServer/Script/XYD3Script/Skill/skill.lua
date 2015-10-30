skillconfig = {3,4,5} --连续技能ID
skillslotconfig = {0,1,2} --玩家技能槽对应上面技能
delaytime = 3	 --延迟时间
SkillThreshold = 100  --近攻技能的误差值
SkillThresholdFast = 50  --远攻技能的误差值
function ProcessQuestSkill(AttackerGID,DefenderGID,DefenderWorldPosX,DefenderWorldPosY,dwSkillIndex ) --玩家使用技能前调用
	--rfalse("ProcessQuestSkill "..AttackerGID.."  "..DefenderGID.."  "..DefenderWorldPosY.."  "..DefenderWorldPosX.."  "..dwSkillIndex)
	--rfalse("ProcessQuestSkill ="..dwSkillIndex.."  useskill="..GetSkillIDBySkillIndex(dwSkillIndex))
	
	if SkillManager[AttackerGID] == nil then
		SkillManager[AttackerGID] = {}
		SkillManager[AttackerGID].AttackerGID = AttackerGID
		SkillManager[AttackerGID].DefenderGID = DefenderGID
		SkillManager[AttackerGID].DefenderWorldPosX = DefenderWorldPosX
		SkillManager[AttackerGID].DefenderWorldPosY = DefenderWorldPosY
		SkillManager[AttackerGID].dwSkillIndex = dwSkillIndex 								--技能槽
		SkillManager[AttackerGID].usetime = os.time()
		SkillManager[AttackerGID].dwUseSkill = GetSkillIDBySkillIndex(dwSkillIndex) 		--正在使用的技能ID
		--rfalse("123")
		return SkillManager[AttackerGID]
		--SetQusetSkillMsg(SkillManager[AttackerGID])
	else
		local index  = findskillconfig(GetSkillIDBySkillIndex(dwSkillIndex))  --查找技能
		if index == 1 then
			local nowtime = os.time()
			--rfalse("nowtime = "..nowtime.." SkillManager[AttackerGID].usetime =  "..SkillManager[AttackerGID].usetime)
				--rfalse("SetQusetSkillMsg  delaytime = "..(nowtime - SkillManager[AttackerGID].usetime))
			if nowtime - SkillManager[AttackerGID].usetime < delaytime then      --未超时
				local nextskill = findnextskill(SkillManager[AttackerGID].dwUseSkill)  --查找需要切换的技能
				if nextskill > 0 then
					SkillManager[AttackerGID].dwUseSkill = skillconfig[nextskill]  		--使用的技能
					SkillManager[AttackerGID].dwSkillIndex = skillslotconfig[nextskill] --使用的技能槽
					SkillManager[AttackerGID].DefenderGID = DefenderGID
					SkillManager[AttackerGID].DefenderWorldPosX = DefenderWorldPosX
					SkillManager[AttackerGID].DefenderWorldPosY = DefenderWorldPosY
					--SetQusetSkillMsg(SkillManager[AttackerGID])
					SkillManager[AttackerGID].usetime = os.time()
					return SkillManager[AttackerGID]
					--rfalse("SetQusetSkillMsg1useskill = "..SkillManager[AttackerGID].dwUseSkill)
					--return 1
				end
			else																--超时以后的操作
					SkillManager[AttackerGID].dwUseSkill = skillconfig[1]  		--使用的技能
					SkillManager[AttackerGID].dwSkillIndex = skillslotconfig[1] --使用的技能槽
					SkillManager[AttackerGID].DefenderGID = DefenderGID
					SkillManager[AttackerGID].DefenderWorldPosX = DefenderWorldPosX
					SkillManager[AttackerGID].DefenderWorldPosY = DefenderWorldPosY
					--SetQusetSkillMsg(SkillManager[AttackerGID])
					SkillManager[AttackerGID].usetime = os.time()
					return SkillManager[AttackerGID]
					--rfalse("SetQusetSkillMsg2useskill = "..SkillManager[AttackerGID].dwUseSkill)
					--return 1
			end
		else
					SkillManager[AttackerGID].dwUseSkill = GetSkillIDBySkillIndex(dwSkillIndex)   		--使用的技能
					SkillManager[AttackerGID].dwSkillIndex = dwSkillIndex --使用的技能槽
					SkillManager[AttackerGID].DefenderGID = DefenderGID
					SkillManager[AttackerGID].DefenderWorldPosX = DefenderWorldPosX
					SkillManager[AttackerGID].DefenderWorldPosY = DefenderWorldPosY
					--SetQusetSkillMsg(SkillManager[AttackerGID])
					return SkillManager[AttackerGID]
					--rfalse("SetQusetSkillMsg3useskill = "..SkillManager[AttackerGID].dwUseSkill)
					--return 1
		end
		--SkillManager[AttackerGID].usetime = TimeGetTime()
	end
	--rfalse("ProcessQuestSkill "..SkillManager[AttackerGID].dwSkillIndex.."  "..SkillManager[AttackerGID].dwUseSkill )
	return 0
end

function SkillManagerInit()
	if SkillManager == nil then
		SkillManager = {}
	end
end

function SkillAttackEnd(AttackerGID)
	-- if SkillManager[AttackerGID] ~= nil then
	-- 	local nextskill  = findnextskill(SkillManager[AttackerGID].dwUseSkill)  --查找需要切换的技能
	-- 	if nextskill > 0 then
	-- 		SkillManager[AttackerGID].dwUseSkill = skillconfig[nextskill]  		--使用的技能
	-- 		SkillManager[AttackerGID].dwSkillIndex = skillslotconfig[nextskill] --使用的技能槽
	-- 		SkillManager[AttackerGID].usetime = TimeGetTime()
	-- 		rfalse("SkillAttackEnd"..AttackerGID..SkillManager[AttackerGID].AttackerGID)
	-- 		ProcessQuestSkill(SkillManager[AttackerGID])
	-- 	end
	-- end	
end

function findskillconfig(dwSkillIndex )
	if skillconfig ~= nil then
		for k,v in pairs(skillconfig) do
			if v == dwSkillIndex then
				return tonumber(k)
			end
		end
	end
	return 0
end

function findskillslotconfig(dwSkillIndex) --查找技能槽
	for k,v in pairs(skillslotconfig) do
		if v == dwSkillIndex then
			return tonumber(k)
		end
	end
	return 0
end

function findnextskill(dwSkillIndex )
	local index = findskillconfig(dwSkillIndex)
	local skillconfiglen = GetTableLenth(skillconfig)
	if index > 0 then
		if index + 1 > skillconfiglen then
			return 1
		else
			return index + 1
		end
	end
	return 0
end

function CacheSkillInit()
	if SkillCache == nil then
		SkillCache = {}
	end
end

function AddPlayerCacheSkill(AttackerGID,DefenderGID,DefenderWorldPosX,DefenderWorldPosY,dwSkillIndex) --把未处理的技能加入到缓存中
	if SkillCache[AttackerGID] == nil then
		 SkillCache[AttackerGID] = {}
	end
	local skillquest = {}
	skillquest.AttackerGID = AttackerGID
	skillquest.DefenderGID = DefenderGID
	skillquest.DefenderWorldPosX = DefenderWorldPosX
	skillquest.DefenderWorldPosY = DefenderWorldPosY
	skillquest.dwSkillIndex = dwSkillIndex
	table.insert(SkillCache[AttackerGID],skillquest)
	--local str = string.format("AddPlayerCacheSkill x = %f , y = %f",DefenderWorldPosX,DefenderWorldPosY)
	--rfalse(str)
	--printtable(SkillCache[AttackerGID])
end

function GetPlayerCacheSkill(AttackerGID)
	if SkillCache[AttackerGID] ~= nil then
		local cachesize = GetTableLenth(SkillCache[AttackerGID])
		--rfalse("cachesize = "..cachesize)
		if cachesize > 0 then
			local skillcache = {}
			skillcache = SkillCache[AttackerGID][1]
			table.remove(SkillCache[AttackerGID],1)
			SetCacheSkill(skillcache)
			cachesize = GetTableLenth(SkillCache[AttackerGID])
			--local str = string.format("GetPlayerCacheSkill x = %f , y = %f",skillcache.DefenderWorldPosX,skillcache.DefenderWorldPosY)
			--rfalse(str)
			return 
		end
	end
	SetCacheSkill(nil)
end

SkillManagerInit()
CacheSkillInit()

function GetSkillDistance() --获取设置的技能距离
	return SkillThreshold
end



--add 2014/3/7 ly  用于技能升级消耗
function UpdateSkill(level, BaseSp, BAseMoney)
		--local sp =  BaseSp * 2.0 ^ (level - 1)
		local sp =  BaseSp * (level - 1)
		local money = BAseMoney * (level - 1)
		ConsumeTelergy(sp, money, 2)
end


--角色信仰技能1 刺杀之术
function AttachPasstiveSkillBuff20001(SkillLevel)
	local BuffID = 20000
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end

--角色信仰技能2 御体秘术
function AttachPasstiveSkillBuff20002(SkillLevel)
	local BuffID = 20100
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end

--角色信仰技能3 爆体领域
function AttachPasstiveSkillBuff20003(SkillLevel)
	local BuffID = 20200
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end

--角色信仰技能4 防爆之心
function AttachPasstiveSkillBuff20004(SkillLevel)
	local BuffID = 20300
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end

--角色信仰技能5 弱点击破
function AttachPasstiveSkillBuff20005(SkillLevel)
	local BuffID = 20400
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end

--角色信仰技能6 防破秘文
function AttachPasstiveSkillBuff20006(SkillLevel)
	local BuffID = 20500
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end

--角色信仰技能7 穿透之刺
function AttachPasstiveSkillBuff20007(SkillLevel)
	local BuffID = 20600
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end

--角色信仰技能8 风刺之盾
function AttachPasstiveSkillBuff20008(SkillLevel)
	local BuffID = 20700
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end

--角色信仰技能9 杀神领域
function AttachPasstiveSkillBuff20009(SkillLevel)
	local BuffID = 20800
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end

--角色信仰技能10 生命永恒
function AttachPasstiveSkillBuff20010(SkillLevel)
	local BuffID = 20900
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end

--角色信仰技能11 洗礼之光
function AttachPasstiveSkillBuff20011(SkillLevel)
	local BuffID = 21000
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end

--角色信仰技能12 神体
function AttachPasstiveSkillBuff20012(SkillLevel)
	local BuffID = 21100
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end

--宠物蓝色被动技能1
function AttachPasstiveSkillBuff46201(SkillLevel)
	local BuffID = 46100
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end

--宠物蓝色被动技能2
function AttachPasstiveSkillBuff46202(SkillLevel)
	local BuffID = 46200
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end

--宠物蓝色被动技能3
function AttachPasstiveSkillBuff46203(SkillLevel)
	local BuffID = 46300
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end

--宠物蓝色被动技能4
function AttachPasstiveSkillBuff46204(SkillLevel)
	local BuffID = 46400
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end

--宠物蓝色被动技能5
function AttachPasstiveSkillBuff46205(SkillLevel)
	local BuffID = 46500
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end

--宠物紫色被动技能1
function AttachPasstiveSkillBuff47201(SkillLevel)
	local BuffID = 47100
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end

--宠物紫色被动技能2
function AttachPasstiveSkillBuff47202(SkillLevel)
	local BuffID = 47200
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end

--宠物紫色被动技能3
function AttachPasstiveSkillBuff47203(SkillLevel)
	local BuffID = 47300
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end

--宠物紫色被动技能4
function AttachPasstiveSkillBuff47204(SkillLevel)
	local BuffID = 47400
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end

--宠物紫色被动技能5
function AttachPasstiveSkillBuff47205(SkillLevel)
	local BuffID = 47500
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end

--宠物橙色被动技能1
function AttachPasstiveSkillBuff48201(SkillLevel)
	local BuffID = 48100
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end

--宠物橙色被动技能2
function AttachPasstiveSkillBuff48202(SkillLevel)
	local BuffID = 48200
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end

--宠物橙色被动技能3
function AttachPasstiveSkillBuff48203(SkillLevel)
	local BuffID = 48300
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end

--宠物橙色被动技能4
function AttachPasstiveSkillBuff48204(SkillLevel)
	local BuffID = 48400
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end

--宠物橙色被动技能5
function AttachPasstiveSkillBuff48205(SkillLevel)
	local BuffID = 48500
	BuffID = BuffID + SkillLevel
	AddBuff(GetPlayerData(0, 37), BuffID)--
end