-- AddBuff
-- param_1	 1 -- ����Լ� 2 -- ���� 3 -- ����Ŀ��
-- param_2	 buffIndex


function InAttack3(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		if LuaRandRange(1,100) > 50 then
			AddFightBuff(3, 30005)	-- ����Ŀ��
		end	
	end
end

function InAttack5(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		--AddFightBuff(3, 30000)	-- ����Ŀ��
		--rfalse("InAttack5")
	end
end

function InAttack303(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		--AddFightBuff(1, 1)	-- ����Ŀ��
	end
end

function InAttack307(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		--AddFightBuff(3, 30000)	-- ����Ŀ��
	end
end



function InAttack309(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 30000)	-- ����Ŀ��
	end
end

function InAttack2010(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 30000)	-- ����Ŀ��
	end
end

function InAttack3010(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 30000)	-- ����Ŀ��
	end
end

function InAttack5010(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 30000)	-- ����Ŀ��
	end
end

function InAttack104()
	AddFightBuff(3,30000)	-- ����Ŀ��
end

--[[function InAttack2000(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 30004)	-- ����Ŀ��
	end
end]]

--[[ ��������
function InAttack3009(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(1, 30006)	-- �����⹦����
		AddFightBuff(1, 30007)	-- �����ڹ�����
		AddFightBuff(1, 30008)	-- �����⹦����
	end
end

-- �������
function InAttack3010(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(1, 30005)	-- ����Ѫ����
	end
end

-- �޺���
function InAttack3011(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(2, 30009)	-- ���������⹦����
	end
end

-- �����
function InAttack3012(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(1, 30004)	-- 100%�����˺�
	end
end

-- ��������
function InAttack3013(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(1, 30010)	-- ����
		AddFightBuff(1, 30011)	-- ��ѣ��
	end
end--]]

--[[ ������������Buff
--������
function AttachPasstiveSkillBuff3002(SkillLevel)
	AddFightBuff(3, 30010)--����
end

--������ɽ
function AttachPasstiveSkillBuff3003(SkillLevel)
	AddFightBuff(1, 30010)--�ֿ�����
end

--�������
function AttachPasstiveSkillBuff3005(SkillLevel)
	AddFightBuff(3, 30010)--����
end

--������̨
function AttachPasstiveSkillBuff3006(SkillLevel)
	AddFightBuff(1, 30010)--�ֿ�����
end

--������˥
function AttachPasstiveSkillBuff3007(SkillLevel)
	AddFightBuff(3, 30010)--����
end

--һέ�ɽ�
function AttachPasstiveSkillBuff3008(SkillLevel)
	AddFightBuff(1, 30010)--�ֿ�����
end--]]



