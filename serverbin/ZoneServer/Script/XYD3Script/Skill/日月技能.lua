-- AddBuff
-- 1 -- ����Լ� 2 -- ���� 3 -- ����Ŀ��

function InAttackPrepare_5008(AtkTime, SkillLevel,DefencerID,skillindex)
	--rfalse("InAttackPrepare")
	if (3 == AtkTime) then
		StartWineMove(3,SkillLevel,DefencerID,skillindex)		-- ��ʼ���
	end	-- ��ʼ���
end

