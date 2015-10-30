-- AddBuff
-- 1 -- 玩家自己 2 -- 队友 3 -- 攻击目标

function InAttackPrepare_1008(AtkTime, SkillLevel,DefencerID,skillindex)
	--rfalse("InAttackPrepare")
	--if (3 == AtkTime) then
		StartWineMove(4,SkillLevel,DefencerID,skillindex)		-- 开始冲锋
	--end	-- 开始冲锋
end

-- 被动技能永久Buff
--寸心晖
--function AttachPasstiveSkillBuff1002(SkillLevel)
	--AddFightBuff(3, 30010)--击退
--end

--星辰枯
--function AttachPasstiveSkillBuff1003(SkillLevel)
	--AddFightBuff(1, 30010)--抵抗击退
--end

--剑达意通
--function AttachPasstiveSkillBuff1004(SkillLevel)
	--AddFightBuff(3, 30010)--定身
--end

--移阴转阳
--function AttachPasstiveSkillBuff1005(SkillLevel)
	--AddFightBuff(1, 30010)--抵抗定身
--end

--流星追月
--function AttachPasstiveSkillBuff1007(SkillLevel)
	--AddFightBuff(3, 30010)--减速
--end

--月海无涯
--function AttachPasstiveSkillBuff1008(SkillLevel)
	--AddFightBuff(1, 30010)--抵抗减速
--end