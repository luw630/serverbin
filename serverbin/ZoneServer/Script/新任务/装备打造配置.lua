-- ��ʯ����ʾͼ�������
function JWTypeImageMap(level)
	rfalse("��ѯ��ʯ��ͼ������Ϊ:"..level)
	local TIMap = {}
	if (level >= 101 and level <= 130 ) then
		return "0023.spr"
	elseif (level >= 201 and level <= 230) then
		return "0034.spr"
	elseif (level >= 301 and level <= 330) then
		return "0035.spr"
	elseif (level >= 401 and level <= 430 ) then
		return "0036.spr"
	else
		return nil
	end
end

-- ���װ���ȼ��Ͳ���ID�Ƿ�ƥ��
-- �����߼�Ϊ��ͨ��װ���ȼ��鿴�����Ƿ�ƥ�䣬���ƥ�䣬�򷵻���Ҫ�Ĳ����������򷵻�nil
-- ���������ߵõ�װ������Ҫ�Ĳ������󣬿��Լ������Ĳ������Ƿ��㹻

-- װ��������� ע���޸ĸ����ã���һ���޸��·��Ĳ�ѯ����������
function CheckEMMatch(equipLevel, materialID)
	local EMMap = {}		-- Equipment<-->Material
	EMMap[1] = {1, 1}		-- �˴�Ϊ�˲��ԣ�ID��Ϊ1~8���Ժ��޸�Ϊ��ʯ��ID
	EMMap[2] = {2, 1}		--ÿ���׶�Ӧ�Ĳ���ID�͸�����
	EMMap[3] = {3, 1}
	EMMap[4] = {4, 1}
	EMMap[5] = {5, 1}
	EMMap[6] = {6, 1}
	EMMap[7] = {7, 1}
	EMMap[8] = {8, 1}

	-- ����Բ���ȼ�
	local matchLevel = 0
	if (equipLevel <= 20 ) then
		matchLevel = 1
	elseif (equipLevel <= 40 ) then
		matchLevel = 2
	elseif (equipLevel <= 60 ) then
		matchLevel = 3
	elseif (equipLevel <= 80 ) then
		matchLevel = 4
	elseif (equipLevel <= 100 ) then
		matchLevel = 5
	elseif (equipLevel <= 120 ) then
		matchLevel = 6
	elseif (equipLevel <= 140 ) then
		matchLevel = 7
	elseif (equipLevel <= 150 ) then
		matchLevel = 8
	else
		return nil
	end

	local baseIndex = matchLevel
	for i=baseIndex, 8 do
		if (materialID == EMMap[i][1]) then
			rfalse(equipLevel.." Matches "..EMMap[i][1].." with the amount of "..EMMap[i][2])
			return EMMap[i][2]
		end
	end
	return nil
end
-- װ���������,�÷����ṩ��ѯ
function GetEMMatchMaterials(equipLevel)
	local EMMap = {}		-- Equipment<-->Material
	EMMap[1] = {1, 1}		-- �˴�Ϊ�˲��ԣ�ID��Ϊ1~8���Ժ��޸�Ϊ��ʯ��ID
	EMMap[2] = {2, 1}
	EMMap[3] = {3, 1}
	EMMap[4] = {4, 1}
	EMMap[5] = {5, 1}
	EMMap[6] = {6, 1}
	EMMap[7] = {7, 1}
	EMMap[8] = {8, 1}

	-- ����Բ���ȼ�
	local matchLevel = 0
	if (equipLevel <= 20 ) then
		matchLevel = 1
	elseif (equipLevel <= 40 ) then
		matchLevel = 2
	elseif (equipLevel <= 60 ) then
		matchLevel = 3
	elseif (equipLevel <= 80 ) then
		matchLevel = 4
	elseif (equipLevel <= 100 ) then
		matchLevel = 5
	elseif (equipLevel <= 120 ) then
		matchLevel = 6
	elseif (equipLevel <= 140 ) then
		matchLevel = 7
	elseif (equipLevel <= 150 ) then
		matchLevel = 8
	else
		return nil
	end
	return EMMap[matchLevel][1],EMMap[matchLevel][2]
end

-- ȡ��ʯ����, JewelIDΪ��ʯ��ID
function TakeOutJMMap(JewelID)
	rfalse("��ѯȡ��ʯ���õı�ʯIDΪ:"..JewelID)
	local JMMap = {}
	JMMap[101] = {1, 2}				-- ��Ҫ�Ĳ���ID + ������
	JMMap[201] = {1, 2}
	return JMMap[101]				--���б�ʯ������101�����á�
	--	return JMMap[JewelID]
end

���װ�������ñ� = {}
���װ�������ñ� =
{   --[[
	[1] =
	{
		equipLevel = 10,            --�ȼ�����
		stuffID = 1,				--��Ҫ���ϱ��
		stuffNum = 1,				--��Ҫ���ϸ���
		needMoney = 0,				--��Ҫ��Ǯ
	},   --]]
	[2] =
	{
		equipLevel = 20,            --�ȼ�����
		stuffID = 1,				--��Ҫ���ϱ��
		stuffNum = 1,				--��Ҫ���ϸ���
		needMoney = 2,				--��Ҫ��Ǯ
	},
	[3] =
	{
		equipLevel = 40,            --�ȼ�����
		stuffID = 1,				--��Ҫ���ϱ��
		stuffNum = 2,				--��Ҫ���ϸ���
		needMoney = 0,				--��Ҫ��Ǯ
	},
	[4] =
	{
		equipLevel = 80,           --�ȼ�����
		stuffID = 1,				--��Ҫ���ϱ��
		stuffNum = 6,				--��Ҫ���ϸ���
		needMoney = 0,				--��Ҫ��Ǯ
	},
}

װ�������ñ� = {}
װ�������ñ� =
{   --[[
	[1] =
	{
		equipLevel = 10,            --�ȼ�����
		stuffID = 1,				--��Ҫ���ϱ��
		stuffNum = 1,				--��Ҫ���ϸ���
		needMoney = 0,				--��Ҫ��Ǯ
	},  --]]
	[2] =
	{
		equipLevel = 10,            --�ȼ�����
		stuffID = 1,				--��Ҫ���ϱ��
		stuffNum = 2,				--��Ҫ���ϸ���
		needMoney = 0,				--��Ҫ��Ǯ
	},
	[3] =
	{
		equipLevel = 40,            --�ȼ�����
		stuffID = 1,				--��Ҫ���ϱ��
		stuffNum = 4,				--��Ҫ���ϸ���
		needMoney = 0,				--��Ҫ��Ǯ
	},
	[4] =
	{
		equipLevel = 80,           --�ȼ�����
		stuffID = 1,				--��Ҫ���ϱ��
		stuffNum = 6,				--��Ҫ���ϸ���
		needMoney = 0,				--��Ҫ��Ǯ
	},
}

function GetIconPath(iconID)
		curLen = 0
		retStr = ""
		retStr = "000" .. iconID .. ".spr"
		if((iconID / 10) > 1) then 
			curLen = 1
			retStr = "00" .. iconID .. ".spr"
		end
		if((iconID / 100) > 1) then 
			curLen = 2
			retStr = "0" .. iconID .. ".spr"
		end
		if((iconID / 1000) > 1) then 
			curLen = 3
			retStr = "" .. iconID .. ".spr"
		end
		 
		return retStr
end