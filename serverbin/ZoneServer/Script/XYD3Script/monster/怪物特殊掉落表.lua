dofile("XYD3Script\\monster\\�������.lua")
-- dofile("XYD3Script\\monster\\��ͨ��Ʒ�����߼�.lua")
-- dofile("XYD3Script\\monster\\1����Ʒ.lua")
-- dofile("XYD3Script\\monster\\10����Ʒ.lua")
-- dofile("XYD3Script\\monster\\20����Ʒ.lua")
-- dofile("XYD3Script\\monster\\30����Ʒ.lua")
-- dofile("XYD3Script\\monster\\40����Ʒ.lua")
-- dofile("XYD3Script\\monster\\50����Ʒ.lua")
-- dofile("XYD3Script\\monster\\60����Ʒ.lua")
-- dofile("XYD3Script\\monster\\65����Ʒ.lua")
-- dofile("XYD3Script\\monster\\70����Ʒ.lua")
-- dofile("XYD3Script\\monster\\75����Ʒ.lua")
-- dofile("XYD3Script\\monster\\������Ʒ.lua")
-- dofile("XYD3Script\\monster\\�������������.lua")
-- dofile("XYD3Script\\monster\\�츣ɽ��������.lua")
-- dofile("XYD3Script\\monster\\����̲��������.lua")
-- dofile("XYD3Script\\monster\\�޼�����������.lua")
-- dofile("XYD3Script\\monster\\��������������.lua")
-- dofile("XYD3Script\\monster\\�������������.lua")
-- dofile("XYD3Script\\monster\\����ڵ�������.lua")
-- dofile("XYD3Script\\monster\\�����ֵ�������.lua")
-- dofile("XYD3Script\\monster\\������������.lua")


--[[MonsterdropTable[1] =
{
	Item =
	{
	{2001001,1000},
	{2001002,1500},
	{2001003,2500},
	{2001004,3000},
	{2001005,2000}
	},								--����(ID�����伸��)
	TimeInterval = 10,				--ʱ���� �����Է���Ϊ��λ,�����Ϊ0û��ʱ����
	MonsterID = {3,2,11,12,13},		--����ID
	DropValue = 5,					--��ǰ������Ʒ���������趨��ʱ��������������Ʒ������
	AllDropValue = 5,				--������ʱ����ʱ�������Ʒ�����������Ϊ0����������Ժ󽫲����ٴε���
	SingleDropValue = 1,			--ÿ�ε���ĸ���,���Ϊ0����������,���ܴ��ڵ�����ܸ���
	ItemDropTime = os.time(),		--��ʼ�����ʱ�䣬�����ѷ���������ʱ�俪ʼ
	ItemDropDate = 0 ,		--������������(��ʽ����20110823)��0����������
}--]]

MonsterdropTable[1] =
{
	Item =
	{
	{3500001,2000},
	{2003001,2000},
	{2023001,2000},
	{2043001,2000},
	{2063001,2000}
	},
	TimeInterval = 1,
	MonsterID = {51,52,53},
	DropValue = 20,
	AllDropValue = 20,
	SingleDropValue = 5,
	ItemDropTime = os.time(),
	ItemDropDate = 0 ,
}

MonsterdropTable[2] =
{
	Item =
	{
	{5000,2000},
	{5001,2000},
	{5002,2000},
	{5003,2000},
	{5004,2000}
	},
	TimeInterval = 20,
	MonsterID = {900,90,91,92,93},
	DropValue = 12,
	AllDropValue = 12,
	SingleDropValue = 1,
	ItemDropTime = os.time(),
	ItemDropDate = 0 ,
}

MonsterdropTable[3] =
{
	Item =
	{
	{190311,8000},
	},
	TimeInterval = 20,
	MonsterID = {5},
	DropValue = 12,
	AllDropValue = 12,
	SingleDropValue = 1,
	ItemDropTime = os.time(),
	ItemDropDate = 0 ,
}
--sreset







