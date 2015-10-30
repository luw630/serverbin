-- AddBuff
-- 1 -- 玩家自己 2 -- 队友 3 -- 攻击目标

--暗影步
function InAttack25(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 30003)	-- 定身目标
	end
end

--[[ 寒冰风雪
function InAttack2000(AtkTime, SkillLevel, TelegryLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 40000)
	end
end

-- 地动天惊
function InAttack2003(AtkTime, SkillLevel, TelegryLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 40001)
	end
end

-- 枯木生华
function InAttack2008(AtkTime, SkillLevel, TelegryLevel)
	if (1 == AtkTime) then
		DelFightBuffType(1, 1001)
	end
end

-- 寸心晖
function InAttack2011(AtkTime, SkillLevel, TelegryLevel)
	if (1 == AtkTime) then
		AddFightBuff(1, 40004)
		AddFightBuff(1, 40005)
	end
end

 --流星追月
function InAttack2012(AtkTime, SkillLevel, TelegryLevel)
	if (1 == AtkTime) then
		StartWineMove(2)		-- 开始瞬移
	end
end--]]

--测试
function InAttack2(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 30003)	-- 定身目标
	end
end

-- 被动技能永久Buff
--寸心晖
function AttachPasstiveSkillBuff2002(SkillLevel)
	AddFightBuff(3, 30010)--击退
end

--星辰枯
function AttachPasstiveSkillBuff2003(SkillLevel)
	AddFightBuff(1, 30010)--抵抗击退
end

--剑达意通
function AttachPasstiveSkillBuff2004(SkillLevel)
	AddFightBuff(3, 30010)--定身
end

--移阴转阳
function AttachPasstiveSkillBuff2005(SkillLevel)
	AddFightBuff(1, 30010)--抵抗定身
end

--流星追月
function AttachPasstiveSkillBuff2007(SkillLevel)
	AddFightBuff(3, 30010)--减速
end

--月海无涯
function AttachPasstiveSkillBuff3008(SkillLevel)
	AddFightBuff(1, 30010)--抵抗减速
end