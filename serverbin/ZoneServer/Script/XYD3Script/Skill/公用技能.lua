-- AddBuff
-- 1 -- ����Լ� 2 -- ���� 3 -- ����Ŀ��

--��ľ����
function InAttack3001(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 60000)--��Ѫ
	end
end

--��ת����
function InAttack3001(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 60001)--����
	end
end

--��������
function InAttack3001(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 60002)--����
	end
end

--�̺�����
function InAttack3001(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 60003)--����
	end
end

--����Ѳ�
function InAttack3001(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 60004)--����
	end
end

--������
function InAttack12004(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 1001)--����
	end
end


--add 2014/3/7 ly  ���ڼ�����������
function UpdateSkill(level, BaseSp, BAseMoney)
		--local sp =  BaseSp * 2.0 ^ (level - 1)
		local sp =  BaseSp * (level - 1)
		local money = BAseMoney * (level - 1)
		ConsumeTelergy(sp, money, 2)
end


--������������
--[[
	1  ������
	2  Զ�̼���
	3  ��Χ����
	4  ������������
	5  �����ֿ�����
	6  ��������
	7   (û��)��漼�ܣ���Ҫ��֤·��
	8  ���⼼��(��ʱû���� 2011.08.26 by dj)

	ConsumeTelergy(SP, money, 1) ����˵��

	��һ�����������ĵ�����
	�ڶ��������� ���ĵĽ�Ǯ
	������������ ��ʾ���µ����ͣ�1 ��ʾ�ķ���2 ��ʾ����
--]]

function UpdateSkill1(level)
		local sp = 128 * 1.045 ^ (level - 1)
		local money = 100 * level
		ConsumeTelergy(sp, money, 2)
end

function UpdateSkill2(level)
		local sp = 120 * 1.045 ^ (level - 1)
		local money = 100 * level
		ConsumeTelergy(sp, money, 2)
end

function UpdateSkill3(level)
		local sp = 112 * 1.045 ^ (level - 1)
		local money = 100 * level
		ConsumeTelergy(sp, money, 2)
end

function UpdateSkill4(level)
		local sp = 102 * 1.045 ^ (level - 1)
		local money = 90 * level
		ConsumeTelergy(sp, money, 2)
end

function UpdateSkill5(level)
		local sp = 124 * 1.045 ^ (level - 1)
		local money = 95 * level
		ConsumeTelergy(sp, money, 2)
end

function UpdateSkill6(level)
		local sp = 107 * 1.045 ^ (level - 1)
		local money = 85 * level
		ConsumeTelergy(sp, money, 2)
end

function UpdateSkill8(level)
		local sp = 124 * 1.045 ^ (level - 1)
		local money = 110 * level
		ConsumeTelergy(sp, money, 2)
end
