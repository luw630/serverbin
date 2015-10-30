-- AddBuff
-- 1 -- 玩家自己 2 -- 队友 3 -- 攻击目标

function InAttackPrepare_5008(AtkTime, SkillLevel,DefencerID,skillindex)
	--rfalse("InAttackPrepare")
	if (3 == AtkTime) then
		StartWineMove(3,SkillLevel,DefencerID,skillindex)		-- 开始冲锋
	end	-- 开始冲锋
end

