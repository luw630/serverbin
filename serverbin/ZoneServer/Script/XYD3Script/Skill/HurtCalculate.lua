--战斗伤害计算
function ConsumeDamage(pAttaGid,pDestGid,SkillIndex) --攻击方，被攻击方，以及技能id
	--战斗公式	最终伤害=(1+(等级-对方等级)/100)*攻击^2/(攻击+对方防御）

	--命中计算	IF 8000+(命中-闪避)>9999 命中成功
	--ELSE IF rand(0-9999)>(命中-闪避) 命中成功
	--ELSE 命中失败

	--暴击计算	//暴击，穿刺，破击公式一致
	--IF (暴击-抗暴)<0 不触发暴击
	--ELSE IF rand(0-9999) < (暴击-抗暴)*0.3 暴击成功（最终伤害*2）
	--ELSE 不触发暴击


	local bIshitDest = false
	local bIshitBaoji = false		--暴击
	local bIsUnhitBaoji = false 	--抗暴

	local Atta_hit = GetObjectFightData(pAttaGid,4)  --攻击者命中
	local Dest_Shanbi = GetObjectFightData(pDestGid,5)  --被攻击者闪避

	if 8000 + (Atta_hit - Dest_Shanbi) > 9999 then
		bIshitDest = true
	else
		if LuaRandRange(0,9999) > (Atta_hit - Dest_Shanbi) then
			bIshitDest = true
		end
	end

	if bIshitDest == false then --未命中
		local SDamage = {}
		SDamage.wDamage = 0
		SDamage.wDamageExtra = 0
		SDamage.wIgnoreDefDamage = 0
		SDamage.wReboundDamage = 0
		SDamage.isCritical = 0
		SDamage.mHitState = Not_Hit
		SetObjectDamage(pAttaGid,SDamage)
		--rfalse("Not_Hit")
		return SDamage
	end
	
	if CheckFightState(pDestGid,FS_WUDI) == 1 then --是否无敌状态
		local SDamage = {}
		SDamage.wDamage = 0
		SDamage.wDamageExtra = 0
		SDamage.wIgnoreDefDamage = 0
		SDamage.wReboundDamage = 0
		SDamage.isCritical = 0
		SDamage.mHitState = Not_Hit
		SetObjectDamage(pAttaGid,SDamage)
		--rfalse("Not_Hit")
		return SDamage
	end

	--暴击类型随机 6 暴击 8 破击 10 穿刺
	local baojitype = {FIGHTOBJ_BAOJI,FIGHTOBJ_WRECK,FIGHTOBJ_PUNCTURE}
	local sendtype = {BAOJI_HIT,WRECK_HIT,PUNCTURE_HIT}
	local Randtype = (LuaRandRange(0,1000) % 3 ) + 1
	local sendbaojitype = sendtype[Randtype]
	Randtype = baojitype[Randtype]

	local DamageMultiple = 2 						--伤害倍数

	if GetObjectType(pAttaGid) == OBJECT_MONSTER then  --类型为怪物
		local monsterID = GetObjectData(pAttaGid,OBJDATA_ID)

		if monsterID > 0 then
			local DamageTable = GetSpecialDamage(monsterID)
			if DamageTable ~= nil then						--重新计算暴击类型已经伤害
				Randtype = DamageTable[1]
				DamageMultiple = DamageTable[2]

				sendbaojitype = sendtype[Randtype]
				Randtype = baojitype[Randtype]
				--rfalse("monster Damage DamageMultiple = "..DamageMultiple.."sendbaojitype = "..sendbaojitype)
			end
		end
	end
	

	local Atta_Baoji = GetObjectFightData(pAttaGid,Randtype)      --暴击值
	local Dest_UNCRIT = GetObjectFightData(pDestGid,Randtype + 1) --抗暴击

	--rfalse("Atta_Baoji = "..Atta_Baoji.."Dest_UNCRIT = "..Dest_UNCRIT)
	if Atta_Baoji - Dest_UNCRIT >= 0 then
		if LuaRandRange(0,9999) < (Atta_Baoji - Dest_UNCRIT) * 0.3 then
			bIshitBaoji = true
		else
			bIsUnhitBaoji = true
		end
	end


	--具体伤害
	local Atta_GongJ = GetObjectData(pAttaGid,0)
	local Dest_GongJ = GetObjectData(pDestGid,0)

	local Atta_Level =  GetObjectData(pAttaGid,10)
	local Dest_Level =  GetObjectData(pDestGid,10)

	local Dest_FangYu = GetObjectData(pDestGid,1)

	
	local damage = (1 + (Atta_Level - Dest_Level)/100) * Atta_GongJ *Atta_GongJ /(Atta_GongJ + Dest_FangYu) * (0.9 + 0.01 * LuaRandRange(1,20)) 

	local SDamage = {}

	if bIshitBaoji == true then
		damage = damage * DamageMultiple
		SDamage.mHitState = sendbaojitype
	elseif bIsUnhitBaoji == true then
		SDamage.mHitState = sendbaojitype + 1
	elseif bIshitBaoji == false and bIsUnhitBaoji == false then
		SDamage.mHitState = Hit
	end

	if damage < 1 then
		damage = 1
	end

	local skilllevel = 0
	if GetObjectType(pAttaGid) == OBJECT_PLAYER then  --类型为玩家
		skilllevel = GetSkillLevel(pAttaGid,SkillIndex)
	elseif GetObjectType(pAttaGid) == OBJECT_MONSTER then
		skilllevel = 1
	end

	if skilllevel ~= nil and skilllevel > 0 then
		local DamageRate = GetSkillDamageRate(SkillIndex,skilllevel)
		if DamageRate ~= nil and DamageRate > 0 then
			DamageRate = DamageRate / 100   --百分比
			damage = damage * DamageRate
		end
	end

	SDamage.wDamage = damage
	SDamage.wDamageExtra = 0
	SDamage.wIgnoreDefDamage = 0
	SDamage.wReboundDamage = 0
	SDamage.isCritical = 0
	SetObjectDamage(pAttaGid,SDamage)
	--printtable(SDamage)
	--rfalse("ConsumeDamage "..damage)
	return SDamage
end


function GetSpecialIndex(monsterID) --获取怪物特殊的伤害类型对应ID
	if monsterDamageConfig ~= nil then
		for k,v in pairs(monsterDamageConfig) do
			for i,j in pairs(v) do
				if j == monsterID then
					return k
				end
			end
		end
	end
	--rfalse("GetSpecialIndex nil")
end
function GetSpecialDamage(monsterID) --获取怪物特殊的伤害类型以及倍数  1暴击，2破击，3穿刺 返回table{伤害类型，伤害倍数}
	local SpecialIndex = GetSpecialIndex(monsterID)
	--rfalse("GetSpecialIndex = "..SpecialIndex)
	local FinalTable = {}
	if SpecialIndex ~= nil then
		if Special_Damage[SpecialIndex] ~= nil then
			local sDamage = Special_Damage[SpecialIndex]
			local allprobability = 0
			local Specialtable = {}
			local lenth = GetTableLenth(sDamage)
			for i=1,lenth do
				if i % 2 > 0 then
					local temp = {sDamage[i],sDamage[i+1]}
					table.insert(Specialtable,temp)
					allprobability = allprobability + sDamage[i] 	--所有权重
				end
			end

			local randm = LuaRandRange(1,allprobability)
			--rfalse("randm = "..randm.." allprobability = "..allprobability)
			for k,v in pairs(Specialtable) do
				if randm <= v[1] then
					FinalTable = {k,v[2]}
					return FinalTable
				else
					randm = randm - v[1]
				end
			end
		end
	end
	return nil
end