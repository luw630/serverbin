-- AddBuff
-- 1 -- ����Լ� 2 -- ���� 3 -- ����Ŀ��

--��Ӱ��
function InAttack25(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 30003)	-- ����Ŀ��
	end
end

--[[ ������ѩ
function InAttack2000(AtkTime, SkillLevel, TelegryLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 40000)
	end
end

-- �ض��쾪
function InAttack2003(AtkTime, SkillLevel, TelegryLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 40001)
	end
end

-- ��ľ����
function InAttack2008(AtkTime, SkillLevel, TelegryLevel)
	if (1 == AtkTime) then
		DelFightBuffType(1, 1001)
	end
end

-- ������
function InAttack2011(AtkTime, SkillLevel, TelegryLevel)
	if (1 == AtkTime) then
		AddFightBuff(1, 40004)
		AddFightBuff(1, 40005)
	end
end

 --����׷��
function InAttack2012(AtkTime, SkillLevel, TelegryLevel)
	if (1 == AtkTime) then
		StartWineMove(2)		-- ��ʼ˲��
	end
end--]]

--����
function InAttack2(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 30003)	-- ����Ŀ��
	end
end

-- ������������Buff
--������
function AttachPasstiveSkillBuff2002(SkillLevel)
	AddFightBuff(3, 30010)--����
end

--�ǳ���
function AttachPasstiveSkillBuff2003(SkillLevel)
	AddFightBuff(1, 30010)--�ֿ�����
end

--������ͨ
function AttachPasstiveSkillBuff2004(SkillLevel)
	AddFightBuff(3, 30010)--����
end

--����ת��
function AttachPasstiveSkillBuff2005(SkillLevel)
	AddFightBuff(1, 30010)--�ֿ�����
end

--����׷��
function AttachPasstiveSkillBuff2007(SkillLevel)
	AddFightBuff(3, 30010)--����
end

--�º�����
function AttachPasstiveSkillBuff3008(SkillLevel)
	AddFightBuff(1, 30010)--�ֿ�����
end