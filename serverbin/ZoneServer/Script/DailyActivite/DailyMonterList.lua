DAILY_AllMONSTERDIE = 1		--�ճ�������й��ﶼ����
DAILY_PLAYERDIE = 2	--����������ж�ɱ�ֲ���
DAILY_ALLMONSTERORPLAYERDIE = 3 --���й������������������
DAILY_SPECIFYMONSTERDIE = 4  --ָ��ID�Ĺ�������

DAILY_JINGYINGTYPE = 0   --��Ӣ�ؿ�����
DAILY_SANGSHITYPE = 1    --ɥʬΧ������
XINYANG_FIGHTTYPE = 2 	--������ս����
DAILY_WORLDTREE = 3 	--����֮������
DAILY_SHILEYUAN = 4 	--ʧ��԰����
DAILY_UNKNOWNDARKHOUSE = 5 	--δ֪���
DAILY_SHENQUANSHAN = 6 		--��Ȫɽ
DAILY_HONORHALL = 7 		--��������
DAILY_FORTUNEHILL = 8 		--�Ƹ�ɽ
DAILY_ACTIVITE3 = 12 		--�3
DAILY_ACTIVITE4 = 10 		--�4
DAILY_ACTIVITE5 = 11 		--�5
GYMKHANA_SENZHILEYUAN = 9   --ɭ֮��԰�������


--���������Ϊ�����õ�
SangShiLayerInterval = 5 	--ɥʬΧ�ǵĲ�����Ԫ��ÿ��SangShiLayerIntervalֵ��һ��
DailyResetTime = 11 * 60 * 60 + 7 * 60		--�ճ������ʱ��0 - 24 * 60 * 60 S
DailyCount = 13 --����ճ�������������ճ��ʱ�������û�ĸ�������Ȼ������������սҲ�ᱻ�����ճ������


DailySceneBossMonsterID = {31201,31202,31203,31204}	--��е�BOSS����ID�б����û�о�Ϊ�ձ�

DailySceneTable = {}



--  DailySceneTable[1] = 				--��Ӣ�ؿ�
-- {
-- 	DailyID = 1,				--�����ճ�ID
-- 	DailyType = DAILY_JINGYINGTYPE,
-- 	regionID = 10002,
-- 	MapID 	= 116,				--��̬��ͼ��Դ
-- 	Npc ={},					--NPC �б�
-- 	bornPostion = {36.97816,20.53465},		--��ҳ�����
-- 	BaseSpendGlod = 10,		--�������ѽ���������Ѳ���ʱ���ĵ�ʵ�ʵĽ�ҹ�ʽΪ��BaseSpeedGlod + 10 * ����

-- 	BatchMonster =  			--��������ˢ�µĹ���
-- 	{
-- 		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
-- 		[1] = --1
-- 		{
-- 			monsterlist =
-- 			{
-- 				{monsterId = 30101, x = 25.01747, y = 33.61871, refreshTime = 36000000, objectType = 0},	--BOSS����
-- 			},
-- 			BossMonsterID = 30101,	--ָ��BOSS�Ĺ���ID,Boss�����������˳�����
-- 			refreshdelaytime = 1, 			--ˢ���ӳ� ��
-- 		},
-- 	},

-- 	LimitContorl =
-- 	{
-- 		--LimitSP = 1,			--��������
-- 		LimitTimes = 1,			--��������
-- 		OpenTime = 30,			--����ʱ�����
-- 		LimitPlayerLevel = 0,	--��ҵȼ�����
-- 	},
	
-- 	WinCondition = 					--ʤ������
-- 	{
-- 		winrule = DAILY_SPECIFYMONSTERDIE,		--ָ��ID��������
-- 		MonsterID = 30101,	--ָ��BOSS�Ĺ���ID
-- 	},

-- 	FixAward = 					--ͨ������Ժ�Ĺ̶�����, ��ʱ�����壬�������
-- 	{
-- 	},
-- }

--ʥħ����20
DailySceneTable[1] = 				--ʥħ����20
{
	DailyID = 1,				--�����ճ�
	DailyType = DAILY_JINGYINGTYPE,
	regionID = 10004,	MapID 	= 116,				--��̬��ͼ��Դ
	Npc ={},					--NPC �б�
	bornPostion = {36.97816,20.53465},		--��ҳ�����
	BaseSpendGlod = 10,		--�������ѽ���������Ѳ���ʱ���ĵ�ʵ�ʵĽ�ҹ�ʽΪ��BaseSpeedGlod + 10 * ����

	BatchMonster =  			--��������ˢ�µĹ���
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 31201, x = 26.79413, y = 19.80531, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--ˢ���ӳ� ��
		},
		[2] =  --2
		{
			monsterlist =
			{
				{monsterId = 31202, x = 26.79413, y = 19.80531, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--ˢ���ӳ� ��
		},
		[3] =
		{
			monsterlist =
			{
				{monsterId = 31203, x = 26.79413, y = 19.80531, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--ˢ���ӳ� ��
		},
		[4] =
		{
			monsterlist =
			{
				{monsterId = 31204, x = 26.79413, y = 19.80531, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--ˢ���ӳ� ��
		},

	},

	LimitContorl =
	{
		--LimitSP = 1,			--��������
		LimitTimes = 1,			--��������
		OpenTime = 20,			--����ʱ�����
		LimitPlayerLevel = 0,	--��ҵȼ�����
	},
	
	WinCondition = 					--ʤ������
	{
		winrule = DAILY_ALLMONSTERORPLAYERDIE,  --���й������������������
	},

	FixAward = 					--ͨ������Ժ�Ĺ̶�����, ��ʱ�����壬�������
	{
	},
}

--ɥʬΧ��
 DailySceneTable[2] = 				--ɥʬΧ��20
{
	DailyID = 2,				--�����ճ�
	DailyType = DAILY_SANGSHITYPE,
	regionID = 10004,	MapID 	= 116,				--��̬��ͼ��Դ
	Npc ={},					--NPC �б�
	bornPostion = {32.50846,25.05575},		--��ҳ�����
	BaseSpendGlod = 10,		--�������ѽ���������Ѳ���ʱ���ĵ�ʵ�ʵĽ�ҹ�ʽΪ��BaseSpeedGlod + 10 * ����

	BatchMonster =  			--��������ˢ�µĹ���
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 32201, x = 36.8917, y = 23.12398, refreshTime = 36000000, objectType = 0},
				{monsterId = 32201, x = 34.22919, y = 20.37505, refreshTime = 36000000, objectType = 0},
				{monsterId = 32201, x = 30.61744, y = 19.3029, refreshTime = 36000000, objectType = 0},
				{monsterId = 32201, x = 27.86628, y = 22.19486, refreshTime = 36000000, objectType = 0},
				{monsterId = 32201, x = 27.47136, y = 26.00023, refreshTime = 36000000, objectType = 0},
				{monsterId = 32201, x = 30.76513, y = 28.81238, refreshTime = 36000000, objectType = 0},
				{monsterId = 32201, x = 35.32738, y = 28.77781, refreshTime = 36000000, objectType = 0},
				{monsterId = 32201, x = 37.5363, y = 26.06075, refreshTime = 36000000, objectType = 0},
				--{imageID = 10007, x = 25.12242, y = 33.75431, dir = 0,clickScript = 20051,LiveTime = 36000000, objectType = 1,name = "��Ѫ��Ů����"},
			},
			refreshdelaytime = 8, 			--ˢ���ӳ� ��
		},
		[2] =  --2
		{
			monsterlist =
			{
				{monsterId = 32202, x = 36.8917, y = 23.12398, refreshTime = 36000000, objectType = 0},
				{monsterId = 32202, x = 34.22919, y = 20.37505, refreshTime = 36000000, objectType = 0},
				{monsterId = 32202, x = 30.61744, y = 19.3029, refreshTime = 36000000, objectType = 0},
				{monsterId = 32202, x = 27.86628, y = 22.19486, refreshTime = 36000000, objectType = 0},
				{monsterId = 32202, x = 27.47136, y = 26.00023, refreshTime = 36000000, objectType = 0},
				{monsterId = 32202, x = 30.76513, y = 28.81238, refreshTime = 36000000, objectType = 0},
				{monsterId = 32202, x = 35.32738, y = 28.77781, refreshTime = 36000000, objectType = 0},
				{monsterId = 32202, x = 37.5363, y = 26.06075, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 8, 			--ˢ���ӳ� ��
		},
		[3] =
		{
			monsterlist =
			{
				{monsterId = 32203, x = 36.8917, y = 23.12398, refreshTime = 36000000, objectType = 0},
				{monsterId = 32203, x = 34.22919, y = 20.37505, refreshTime = 36000000, objectType = 0},
				{monsterId = 32203, x = 30.61744, y = 19.3029, refreshTime = 36000000, objectType = 0},
				{monsterId = 32203, x = 27.86628, y = 22.19486, refreshTime = 36000000, objectType = 0},
				{monsterId = 32203, x = 27.47136, y = 26.00023, refreshTime = 36000000, objectType = 0},
				{monsterId = 32203, x = 30.76513, y = 28.81238, refreshTime = 36000000, objectType = 0},
				{monsterId = 32203, x = 35.32738, y = 28.77781, refreshTime = 36000000, objectType = 0},
				{monsterId = 32203, x = 37.5363, y = 26.06075, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 8, 			--ˢ���ӳ� ��
		},
		[4] =
		{
			monsterlist =
			{
				{monsterId = 32204, x = 36.8917, y = 23.12398, refreshTime = 36000000, objectType = 0},
				{monsterId = 32204, x = 34.22919, y = 20.37505, refreshTime = 36000000, objectType = 0},
				{monsterId = 32204, x = 30.61744, y = 19.3029, refreshTime = 36000000, objectType = 0},
				{monsterId = 32204, x = 27.86628, y = 22.19486, refreshTime = 36000000, objectType = 0},
				{monsterId = 32204, x = 27.47136, y = 26.00023, refreshTime = 36000000, objectType = 0},
				{monsterId = 32204, x = 30.76513, y = 28.81238, refreshTime = 36000000, objectType = 0},
				{monsterId = 32204, x = 35.32738, y = 28.77781, refreshTime = 36000000, objectType = 0},
				{monsterId = 32204, x = 37.5363, y = 26.06075, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 8, 			--ˢ���ӳ� ��
		},
		[5] =
		{
			monsterlist =
			{
				{monsterId = 32205, x = 36.8917, y = 23.12398, refreshTime = 36000000, objectType = 0},
				{monsterId = 32205, x = 34.22919, y = 20.37505, refreshTime = 36000000, objectType = 0},
				{monsterId = 32205, x = 30.61744, y = 19.3029, refreshTime = 36000000, objectType = 0},
				{monsterId = 32205, x = 27.86628, y = 22.19486, refreshTime = 36000000, objectType = 0},
				{monsterId = 32205, x = 27.47136, y = 26.00023, refreshTime = 36000000, objectType = 0},
				{monsterId = 32205, x = 30.76513, y = 28.81238, refreshTime = 36000000, objectType = 0},
				{monsterId = 32205, x = 35.32738, y = 28.77781, refreshTime = 36000000, objectType = 0},
				{monsterId = 32205, x = 37.5363, y = 26.06075, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 8, 			--ˢ���ӳ� ��
		},

	},

	LimitContorl =
	{
		--LimitSP = 1,			--��������
		LimitTimes = 1,			--��������
		OpenTime = 20,			--����ʱ�����
		LimitPlayerLevel = 0,	--��ҵȼ�����
	},
	
	WinCondition = 					--ʤ������
	{
		winrule = DAILY_ALLMONSTERORPLAYERDIE,  --���й������������������
	},

	FixAward = 					--ͨ������Ժ�Ĺ̶�����, ��ʱ�����壬�������
	{
	},
}

--����֮��
 DailySceneTable[3] = 				--����֮��20
{
	DailyID = 3,				--�����ճ�ID
	DailyType = DAILY_WORLDTREE,
	regionID = 10002,
	MapID 	= 116,				--��̬��ͼ��Դ
	Npc ={},					--NPC �б�
	bornPostion = {36.09824,23.20676},		--��ҳ�����
	BaseSpendGlod = 10,		--�������ѽ���������Ѳ���ʱ���ĵ�ʵ�ʵĽ�ҹ�ʽΪ��BaseSpeedGlod + 10 * ����

	BatchMonster =  			--��������ˢ�µĹ���
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 33201, x = 29.29861, y = 28.81238, refreshTime = 36000000, objectType = 0},	--BOSS����
			},
			BossMonsterID = 10021,	--ָ��BOSS�Ĺ���ID,Boss�����������˳�����
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
	},

	LimitContorl =
	{
		--LimitSP = 1,			--��������
		LimitTimes = 1,			--��������
		OpenTime = 30,			--����ʱ�����
		LimitPlayerLevel = 0,	--��ҵȼ�����
	},
	
	WinCondition = 					--ʤ������
	{
		winrule = DAILY_SPECIFYMONSTERDIE,		--ָ��ID��������
		MonsterID = 30101,	--ָ��BOSS�Ĺ���ID
	},

	FixAward = 					--ͨ������Ժ�Ĺ̶�����, ��ʱ�����壬�������
	{
	},
}

 DailySceneTable[4] = 				--ʧ��԰30
{
	DailyID = 4,				--�����ճ�ID
	DailyType = DAILY_SHILEYUAN,
	regionID = 10002,
	MapID 	= 116,				--��̬��ͼ��Դ
	Npc ={},					--NPC �б�
	bornPostion = {36.97816,20.53465},		--��ҳ�����
	BaseSpendGlod = 10,		--�������ѽ���������Ѳ���ʱ���ĵ�ʵ�ʵĽ�ҹ�ʽΪ��BaseSpeedGlod + 10 * ����

	BatchMonster =  			--��������ˢ�µĹ���
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 34301, x = 36.8917, y = 23.12398, refreshTime = 36000000, objectType = 0},
				{monsterId = 34302, x = 34.22919, y = 20.37505, refreshTime = 36000000, objectType = 0},
				{monsterId = 34303, x = 30.61744, y = 19.3029, refreshTime = 36000000, objectType = 0},
				{monsterId = 34304, x = 27.86628, y = 22.19486, refreshTime = 36000000, objectType = 0},
				{monsterId = 34305, x = 27.47136, y = 26.00023, refreshTime = 36000000, objectType = 0},
				{monsterId = 34306, x = 30.76513, y = 28.81238, refreshTime = 36000000, objectType = 0},
				{monsterId = 34307, x = 35.32738, y = 28.77781, refreshTime = 36000000, objectType = 0},
				{monsterId = 34308, x = 37.5363, y = 26.06075, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
	},

	LimitContorl =
	{
		--LimitSP = 1,			--��������
		LimitTimes = 1,			--��������
		OpenTime = 10,			--����ʱ�����
		LimitPlayerLevel = 0,	--��ҵȼ�����
	},
	
	WinCondition = 					--ʤ������
	{
		winrule = DAILY_ALLMONSTERORPLAYERDIE,  --���й������������������
		MonsterID = 30101,	--ָ��BOSS�Ĺ���ID
	},

	FixAward = 					--ͨ������Ժ�Ĺ̶�����, ��ʱ�����壬�������
	{
	},
}

--δ֪���
--δ֪���ÿ��N�α�Ȼ�����Ĺ���
UDHMustEnterTimes = 5

--δ֪����ĵ�����������һ��ֵʱ����Ȼ���������Ĺ���
UDHGetItemNum = 10

--����δ֪�����Ҫ�ĵ���
EnterUnknownDarkHouseNeedItem = {720203, 1}

--��Ȼˢ���Ĺ���ID
MustRefreshMonsterID = {[5] = 35407 }

--δ֪�����������Ĺ�������
UnKnownDarkHouseMonsterCfg =
{
	[5] =  
	{
		--��������Ϊ������ID��Ȩ��
		{35401, 5},
		{35402, 5},
		{35403, 5},
		{35404, 5},
		{35405, 5},
		{35406, 5},
		{35407, 5},
	},

}

--δ֪�����㲻��ˢ��ĳ��������������
UDHDebarCertainMonsterCfg =
{
	[5] = 
	{
		--��������Ϊ������ID��Ȩ��
		{35401, 5},
		{35402, 5},
		{35403, 5},
		{35404, 5},
		{35405, 5},
		{35406, 5},
	},

}

--δ֪��������
 DailySceneTable[5] = 				--δ֪���
{
	DailyID = 5,				--�����ճ�ID
	DailyType = DAILY_UNKNOWNDARKHOUSE,
	regionID = 10002,
	MapID 	= 116,				--��̬��ͼ��Դ
	Npc ={},					--NPC �б�
	bornPostion = {36.09824,23.20676},		--��ҳ�����
	BaseSpendGlod = 10,		--�������ѽ���������Ѳ���ʱ���ĵ�ʵ�ʵĽ�ҹ�ʽΪ��BaseSpeedGlod + 10 * ����

	BatchMonster =  			--��������ˢ�µĹ���
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 0, x = 29.29861, y = 28.81238, refreshTime = 36000000, objectType = 0},	--BOSS����, ���monsterId = 0����ʾδ֪������ˢ��һ������
			},
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
	},

	LimitContorl =
	{
		--LimitSP = 1,			--��������
		LimitTimes = -1,			--�������ƣ���Ϊ-1ʱ����ʾ���޴���
		OpenTime = 30,			--����ʱ�����
		LimitPlayerLevel = 0,	--��ҵȼ�����
	},
	
	WinCondition = 					--ʤ������
	{
		winrule = DAILY_ALLMONSTERORPLAYERDIE,		--���й������������������
		MonsterID = 0,	--ָ��BOSS�Ĺ���ID
	},

	FixAward = 					--ͨ������Ժ�Ĺ̶�����, ��ʱ�����壬�������
	{
	},
}

--��Ȫɽ50
 DailySceneTable[6] = 				--��Ȫɽ50
{
	DailyID = 6,				--�����ճ�ID
	DailyType = DAILY_SHENQUANSHAN,
	regionID = 10002,
	MapID 	= 116,				--��̬��ͼ��Դ
	Npc ={},					--NPC �б�
	bornPostion = {36.97816,20.53465},		--��ҳ�����
	BaseSpendGlod = 10,		--�������ѽ���������Ѳ���ʱ���ĵ�ʵ�ʵĽ�ҹ�ʽΪ��BaseSpeedGlod + 10 * ����

	BatchMonster =  			--��������ˢ�µĹ���
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 37501, x = 30.32851, y = 30.50114, refreshTime = 36000000, objectType = 0},
				{monsterId = 37501, x = 27.26841, y = 27.79321, refreshTime = 36000000, objectType = 0},
				{monsterId = 37501, x = 32.53233, y = 28.16094, refreshTime = 36000000, objectType = 0},
				{monsterId = 37501, x = 30.7869, y = 26.29724, refreshTime = 36000000, objectType = 0},
				{monsterId = 37501, x = 28.8597, y = 24.80491, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
		[2] = --1
		{
			monsterlist =
			{
				{monsterId = 37501, x = 30.32851, y = 30.50114, refreshTime = 36000000, objectType = 0},
				{monsterId = 37501, x = 27.26841, y = 27.79321, refreshTime = 36000000, objectType = 0},
				{monsterId = 37501, x = 32.53233, y = 28.16094, refreshTime = 36000000, objectType = 0},
				{monsterId = 37502, x = 30.7869, y = 26.29724, refreshTime = 36000000, objectType = 0},
				{monsterId = 37502, x = 28.8597, y = 24.80491, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
		[3] = --1
		{
			monsterlist =
			{
				{monsterId = 37501, x = 30.32851, y = 30.50114, refreshTime = 36000000, objectType = 0},
				{monsterId = 37501, x = 27.26841, y = 27.79321, refreshTime = 36000000, objectType = 0},
				{monsterId = 37501, x = 32.53233, y = 28.16094, refreshTime = 36000000, objectType = 0},
				{monsterId = 37502, x = 30.7869, y = 26.29724, refreshTime = 36000000, objectType = 0},
				{monsterId = 37502, x = 28.8597, y = 24.80491, refreshTime = 36000000, objectType = 0},
				{monsterId = 37503, x = 26.97421, y = 25.42003, refreshTime = 36000000, objectType = 0},
				{monsterId = 37503, x = 32.226, y = 30.82233, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
		[4] = --1
		{
			monsterlist =
			{
				{monsterId = 37501, x = 27.05258, y = 22.77521, refreshTime = 36000000, objectType = 0},
				{monsterId = 37501, x = 35.10155, y = 29.73471, refreshTime = 36000000, objectType = 0},
				{monsterId = 37502, x = 30.7869, y = 26.29724, refreshTime = 36000000, objectType = 0},
				{monsterId = 37502, x = 29.29861, y = 28.81238, refreshTime = 36000000, objectType = 0},
				{monsterId = 37503, x = 26.97421, y = 25.42003, refreshTime = 36000000, objectType = 0},
				{monsterId = 37503, x = 27.26841, y = 27.79321, refreshTime = 36000000, objectType = 0},
				{monsterId = 37503, x = 32.226, y = 30.82233, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
		[5] = --1
		{
			monsterlist =
			{
				{monsterId = 37501, x = 30.32851, y = 30.50114, refreshTime = 36000000, objectType = 0},
				{monsterId = 37501, x = 27.26841, y = 27.79321, refreshTime = 36000000, objectType = 0},
				{monsterId = 37501, x = 32.53233, y = 28.16094, refreshTime = 36000000, objectType = 0},
				{monsterId = 37501, x = 30.7869, y = 26.29724, refreshTime = 36000000, objectType = 0},
				{monsterId = 37502, x = 28.8597, y = 24.80491, refreshTime = 36000000, objectType = 0},
				{monsterId = 37502, x = 27.05258, y = 22.77521, refreshTime = 36000000, objectType = 0},
				{monsterId = 37502, x = 26.97421, y = 25.42003, refreshTime = 36000000, objectType = 0},
				{monsterId = 37503, x = 32.226, y = 30.82233, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
		[6] = --1
		{
			monsterlist =
			{
				{monsterId = 37501, x = 30.32851, y = 30.50114, refreshTime = 36000000, objectType = 0},
				{monsterId = 37501, x = 27.26841, y = 27.79321, refreshTime = 36000000, objectType = 0},
				{monsterId = 37501, x = 32.53233, y = 28.16094, refreshTime = 36000000, objectType = 0},
				{monsterId = 37502, x = 30.7869, y = 26.29724, refreshTime = 36000000, objectType = 0},
				{monsterId = 37502, x = 28.8597, y = 24.80491, refreshTime = 36000000, objectType = 0},
				{monsterId = 37503, x = 27.05258, y = 22.77521, refreshTime = 36000000, objectType = 0},
				{monsterId = 37503, x = 26.97421, y = 25.42003, refreshTime = 36000000, objectType = 0},
				{monsterId = 37503, x = 32.226, y = 30.82233, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
		[7] = --1
		{
			monsterlist =
			{
				{monsterId = 37501, x = 30.32851, y = 30.50114, refreshTime = 36000000, objectType = 0},
				{monsterId = 37501, x = 27.26841, y = 27.79321, refreshTime = 36000000, objectType = 0},
				{monsterId = 37501, x = 32.53233, y = 28.16094, refreshTime = 36000000, objectType = 0},
				{monsterId = 37501, x = 30.7869, y = 26.29724, refreshTime = 36000000, objectType = 0},
				{monsterId = 37502, x = 28.8597, y = 24.80491, refreshTime = 36000000, objectType = 0},
				{monsterId = 37502, x = 27.05258, y = 22.77521, refreshTime = 36000000, objectType = 0},
				{monsterId = 37503, x = 26.97421, y = 25.42003, refreshTime = 36000000, objectType = 0},
				{monsterId = 37503, x = 32.226, y = 30.82233, refreshTime = 36000000, objectType = 0},
				{monsterId = 37503, x = 35.10155, y = 29.73471, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
		[8] = --1
		{
			monsterlist =
			{
				{monsterId = 37501, x = 30.32851, y = 30.50114, refreshTime = 36000000, objectType = 0},
				{monsterId = 37501, x = 27.26841, y = 27.79321, refreshTime = 36000000, objectType = 0},
				{monsterId = 37502, x = 32.53233, y = 28.16094, refreshTime = 36000000, objectType = 0},
				{monsterId = 37502, x = 30.7869, y = 26.29724, refreshTime = 36000000, objectType = 0},
				{monsterId = 37502, x = 28.8597, y = 24.80491, refreshTime = 36000000, objectType = 0},
				{monsterId = 37502, x = 27.05258, y = 22.77521, refreshTime = 36000000, objectType = 0},
				{monsterId = 37502, x = 26.97421, y = 25.42003, refreshTime = 36000000, objectType = 0},
				{monsterId = 37503, x = 32.226, y = 30.82233, refreshTime = 36000000, objectType = 0},
				{monsterId = 37503, x = 35.10155, y = 29.73471, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
		[9] = --1
		{
			monsterlist =
			{
				{monsterId = 37501, x = 30.32851, y = 30.50114, refreshTime = 36000000, objectType = 0},
				{monsterId = 37501, x = 27.26841, y = 27.79321, refreshTime = 36000000, objectType = 0},
				{monsterId = 37501, x = 32.53233, y = 28.16094, refreshTime = 36000000, objectType = 0},
				{monsterId = 37502, x = 30.7869, y = 26.29724, refreshTime = 36000000, objectType = 0},
				{monsterId = 37501, x = 28.8597, y = 24.80491, refreshTime = 36000000, objectType = 0},
				{monsterId = 37503, x = 27.05258, y = 22.77521, refreshTime = 36000000, objectType = 0},
				{monsterId = 37503, x = 26.97421, y = 25.42003, refreshTime = 36000000, objectType = 0},
				{monsterId = 37503, x = 32.226, y = 30.82233, refreshTime = 36000000, objectType = 0},
				{monsterId = 37502, x = 35.10155, y = 29.73471, refreshTime = 36000000, objectType = 0},
				{monsterId = 37502, x = 29.29861, y = 28.81238, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
		[10] = --1
		{
			monsterlist =
			{
				{monsterId = 37501, x = 30.32851, y = 30.50114, refreshTime = 36000000, objectType = 0},
				{monsterId = 37501, x = 27.26841, y = 27.79321, refreshTime = 36000000, objectType = 0},
				{monsterId = 37502, x = 32.53233, y = 28.16094, refreshTime = 36000000, objectType = 0},
				{monsterId = 37501, x = 30.7869, y = 26.29724, refreshTime = 36000000, objectType = 0},
				{monsterId = 37502, x = 28.8597, y = 24.80491, refreshTime = 36000000, objectType = 0},
				{monsterId = 37503, x = 27.05258, y = 22.77521, refreshTime = 36000000, objectType = 0},
				{monsterId = 37503, x = 26.97421, y = 25.42003, refreshTime = 36000000, objectType = 0},
				{monsterId = 37503, x = 32.226, y = 30.82233, refreshTime = 36000000, objectType = 0},
				{monsterId = 37502, x = 35.10155, y = 29.73471, refreshTime = 36000000, objectType = 0},
				{monsterId = 37501, x = 29.29861, y = 28.81238, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
	},

	LimitContorl =
	{
		--LimitSP = 1,			--��������
		LimitTimes = 1,			--��������
		OpenTime = 10,			--����ʱ�����
		LimitPlayerLevel = 0,	--��ҵȼ�����
	},
	
	WinCondition = 					--ʤ������
	{
		winrule = DAILY_ALLMONSTERORPLAYERDIE,  --���й������������������
		MonsterID = 30101,	--ָ��BOSS�Ĺ���ID
	},

	FixAward = 					--ͨ������Ժ�Ĺ̶�����, ��ʱ�����壬�������
	{
	},
}

--��������
--����ҽ����������ô��������꣬���Ҫ���ĵ��߽��룬���ĵ�������
HonorHallEnterResumeItem = {720201, 1}

DailySceneTable[7] = 				--��������60
{
	DailyID = 7,				--�����ճ�
	DailyType = DAILY_HONORHALL,
	regionID = 10004,	MapID 	= 116,				--��̬��ͼ��Դ
	Npc ={},					--NPC �б�
	bornPostion = {36.97816,20.53465},		--��ҳ�����
	BaseSpendGlod = 10,		--�������ѽ���������Ѳ���ʱ���ĵ�ʵ�ʵĽ�ҹ�ʽΪ��BaseSpeedGlod + 10 * ����

	BatchMonster =  			--��������ˢ�µĹ���
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 39601, x = 30.32851, y = 30.50114, refreshTime = 36000000, objectType = 0},
				{monsterId = 39601, x = 27.26841, y = 27.79321, refreshTime = 36000000, objectType = 0},
				{monsterId = 39601, x = 32.53233, y = 28.16094, refreshTime = 36000000, objectType = 0},
				{monsterId = 39601, x = 30.7869, y = 26.29724, refreshTime = 36000000, objectType = 0},
				{monsterId = 39601, x = 28.8597, y = 24.80491, refreshTime = 36000000, objectType = 0},
				{monsterId = 39601, x = 27.05258, y = 22.77521, refreshTime = 36000000, objectType = 0},
				{monsterId = 39601, x = 26.97421, y = 25.42003, refreshTime = 36000000, objectType = 0},
				{monsterId = 39601, x = 32.226, y = 30.82233, refreshTime = 36000000, objectType = 0},
				{monsterId = 39601, x = 35.10155, y = 29.73471, refreshTime = 36000000, objectType = 0},
				{monsterId = 39601, x = 29.29861, y = 28.81238, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--ˢ���ӳ� ��
		},
		[2] =  --2
		{
			monsterlist =
			{
				{monsterId = 39602, x = 30.32851, y = 30.50114, refreshTime = 36000000, objectType = 0},
				{monsterId = 39602, x = 27.26841, y = 27.79321, refreshTime = 36000000, objectType = 0},
				{monsterId = 39602, x = 32.53233, y = 28.16094, refreshTime = 36000000, objectType = 0},
				{monsterId = 39602, x = 30.7869, y = 26.29724, refreshTime = 36000000, objectType = 0},
				{monsterId = 39602, x = 28.8597, y = 24.80491, refreshTime = 36000000, objectType = 0},
				{monsterId = 39602, x = 27.05258, y = 22.77521, refreshTime = 36000000, objectType = 0},
				{monsterId = 39602, x = 26.97421, y = 25.42003, refreshTime = 36000000, objectType = 0},
				{monsterId = 39602, x = 32.226, y = 30.82233, refreshTime = 36000000, objectType = 0},
				{monsterId = 39602, x = 35.10155, y = 29.73471, refreshTime = 36000000, objectType = 0},
				{monsterId = 39602, x = 29.29861, y = 28.81238, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--ˢ���ӳ� ��
		},
		[3] =
		{
			monsterlist =
			{
				{monsterId = 39603, x = 30.32851, y = 30.50114, refreshTime = 36000000, objectType = 0},
				{monsterId = 39603, x = 27.26841, y = 27.79321, refreshTime = 36000000, objectType = 0},
				{monsterId = 39603, x = 32.53233, y = 28.16094, refreshTime = 36000000, objectType = 0},
				{monsterId = 39603, x = 30.7869, y = 26.29724, refreshTime = 36000000, objectType = 0},
				{monsterId = 39603, x = 28.8597, y = 24.80491, refreshTime = 36000000, objectType = 0},
				{monsterId = 39603, x = 27.05258, y = 22.77521, refreshTime = 36000000, objectType = 0},
				{monsterId = 39603, x = 26.97421, y = 25.42003, refreshTime = 36000000, objectType = 0},
				{monsterId = 39603, x = 32.226, y = 30.82233, refreshTime = 36000000, objectType = 0},
				{monsterId = 39603, x = 35.10155, y = 29.73471, refreshTime = 36000000, objectType = 0},
				{monsterId = 39603, x = 29.29861, y = 28.81238, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--ˢ���ӳ� ��
		},

	},

	LimitContorl =
	{
		--LimitSP = 1,			--��������
		LimitTimes = 5,			--��������
		OpenTime = 20,			--����ʱ�����
		LimitPlayerLevel = 0,	--��ҵȼ�����
	},
	
	WinCondition = 					--ʤ������
	{
		winrule = DAILY_ALLMONSTERORPLAYERDIE,  --���й������������������
	},

	FixAward = 					--ͨ������Ժ�Ĺ̶�����, ��ʱ�����壬�������
	{
	},
}

--�Ƹ�ɽ
--�Ƹ�ɽ��ָ������������������ʱ�˳�
FortuneSpecMonsterDieTimesQuit = 10

--�Ƹ�ɽ���������
FortuneHillMonsterRandomCfg = 
{
	[8] = 
	{
		--��������Ϊ������ID��Ȩ��
		{41601, 5},
		{41602, 25},
	},
	
}

--�Ƹ�ɽ�������ҵĹ���
FortuneHillCanGetGlodMonsterID = {[8] = 41601 }

 DailySceneTable[8] = 				--�Ƹ�ɽ60
{
	DailyID = 8,				--�����ճ�ID
	DailyType = DAILY_FORTUNEHILL,
	regionID = 10002,
	MapID 	= 116,				--��̬��ͼ��Դ
	Npc ={},					--NPC �б�
	bornPostion = {36.97816,20.53465},		--��ҳ�����
	BaseSpendGlod = 10,		--�������ѽ���������Ѳ���ʱ���ĵ�ʵ�ʵĽ�ҹ�ʽΪ��BaseSpeedGlod + 10 * ����

	BatchMonster =  			--��������ˢ�µĹ���
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 41602, x = 30.32851, y = 30.50114, refreshTime = 36000000, objectType = 0},
				{monsterId = 41602, x = 27.26841, y = 27.79321, refreshTime = 36000000, objectType = 0},
				{monsterId = 41602, x = 32.53233, y = 28.16094, refreshTime = 36000000, objectType = 0},
				{monsterId = 41601, x = 30.7869, y = 26.29724, refreshTime = 36000000, objectType = 0},
				{monsterId = 41602, x = 28.8597, y = 24.80491, refreshTime = 36000000, objectType = 0},
				{monsterId = 41602, x = 27.05258, y = 22.77521, refreshTime = 36000000, objectType = 0},
				{monsterId = 41602, x = 26.97421, y = 25.42003, refreshTime = 36000000, objectType = 0},
				{monsterId = 41602, x = 32.226, y = 30.82233, refreshTime = 36000000, objectType = 0},
				{monsterId = 41602, x = 35.10155, y = 29.73471, refreshTime = 36000000, objectType = 0},
				{monsterId = 41602, x = 29.29861, y = 28.81238, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
		[2] = --2
		{
			monsterlist =
			{
				{monsterId = 0, x = 0, y = 0, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
	},

	LimitContorl =
	{
		--LimitSP = 1,			--��������
		LimitTimes = 1,			--��������
		OpenTime = 10,			--����ʱ�����
		LimitPlayerLevel = 0,	--��ҵȼ�����
	},
	
	WinCondition = 					--ʤ������
	{
		winrule = DAILY_ALLMONSTERORPLAYERDIE,  --���й������������������
		MonsterID = 30101,	--ָ��BOSS�Ĺ���ID
	},

	FixAward = 					--ͨ������Ժ�Ĺ̶�����, ��ʱ�����壬�������
	{
	},
}
 
--�3
DailySceneTable[9] = 				--��սBOSS�3 60��
{
	DailyID = 9,				--�����ճ�
	DailyType = DAILY_ACTIVITE3,
	regionID = 10004,	MapID 	= 116,				--��̬��ͼ��Դ
	Npc ={},					--NPC �б�
	bornPostion = {36.97816,20.53465},		--��ҳ�����
	BaseSpendGlod = 10,		--�������ѽ���������Ѳ���ʱ���ĵ�ʵ�ʵĽ�ҹ�ʽΪ��BaseSpeedGlod + 10 * ����

	BatchMonster =  			--��������ˢ�µĹ���
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 42601, x = 30.32851, y = 30.50114, refreshTime = 36000000, objectType = 0},
				{monsterId = 42601, x = 27.26841, y = 27.79321, refreshTime = 36000000, objectType = 0},
				{monsterId = 42601, x = 32.53233, y = 28.16094, refreshTime = 36000000, objectType = 0},
				{monsterId = 42601, x = 30.7869, y = 26.29724, refreshTime = 36000000, objectType = 0},
				{monsterId = 42601, x = 28.8597, y = 24.80491, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--ˢ���ӳ� ��
		},
		[2] =  --2
		{
			monsterlist =
			{
				{monsterId = 42601, x = 30.32851, y = 30.50114, refreshTime = 36000000, objectType = 0},
				{monsterId = 42601, x = 27.26841, y = 27.79321, refreshTime = 36000000, objectType = 0},
				{monsterId = 42601, x = 32.53233, y = 28.16094, refreshTime = 36000000, objectType = 0},
				{monsterId = 42602, x = 30.7869, y = 26.29724, refreshTime = 36000000, objectType = 0},
				{monsterId = 42601, x = 28.8597, y = 24.80491, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--ˢ���ӳ� ��
		},
		[3] =
		{
			monsterlist =
			{
				{monsterId = 42601, x = 30.32851, y = 30.50114, refreshTime = 36000000, objectType = 0},
				{monsterId = 42601, x = 27.26841, y = 27.79321, refreshTime = 36000000, objectType = 0},
				{monsterId = 42602, x = 32.53233, y = 28.16094, refreshTime = 36000000, objectType = 0},
				{monsterId = 42602, x = 30.7869, y = 26.29724, refreshTime = 36000000, objectType = 0},
				{monsterId = 42602, x = 28.8597, y = 24.80491, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--ˢ���ӳ� ��
		},
		[4] =
		{
			monsterlist =
			{
				{monsterId = 42601, x = 30.32851, y = 30.50114, refreshTime = 36000000, objectType = 0},
				{monsterId = 42601, x = 27.26841, y = 27.79321, refreshTime = 36000000, objectType = 0},
				{monsterId = 42602, x = 32.53233, y = 28.16094, refreshTime = 36000000, objectType = 0},
				{monsterId = 42603, x = 30.7869, y = 26.29724, refreshTime = 36000000, objectType = 0},
				{monsterId = 42602, x = 28.8597, y = 24.80491, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--ˢ���ӳ� ��
		},

	},

	LimitContorl =
	{
		--LimitSP = 1,			--��������
		LimitTimes = 2,			--��������
		OpenTime = 20,			--����ʱ�����
		LimitPlayerLevel = 0,	--��ҵȼ�����
	},
	
	WinCondition = 					--ʤ������
	{
		winrule = DAILY_ALLMONSTERORPLAYERDIE,  --���й������������������
	},

	FixAward = 					--ͨ������Ժ�Ĺ̶�����, ��ʱ�����壬�������
	{
	},
}

--����֮��
DailySceneTable[10] = 				--����֮�� 60��
{
	DailyID = 10,				--�����ճ�
	DailyType = DAILY_ACTIVITE4,
	regionID = 10004,	MapID 	= 116,				--��̬��ͼ��Դ
	Npc ={},					--NPC �б�
	bornPostion = {36.97816,20.53465},		--��ҳ�����
	BaseSpendGlod = 10,		--�������ѽ���������Ѳ���ʱ���ĵ�ʵ�ʵĽ�ҹ�ʽΪ��BaseSpeedGlod + 10 * ����

	BatchMonster =  			--��������ˢ�µĹ���
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 43601, x = 30.32851, y = 30.50114, refreshTime = 36000000, objectType = 0},
				{monsterId = 43601, x = 27.26841, y = 27.79321, refreshTime = 36000000, objectType = 0},
				{monsterId = 43601, x = 32.53233, y = 28.16094, refreshTime = 36000000, objectType = 0},
				{monsterId = 43601, x = 30.7869, y = 26.29724, refreshTime = 36000000, objectType = 0},
				{monsterId = 43601, x = 28.8597, y = 24.80491, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--ˢ���ӳ� ��
		},
		[2] =  --2
		{
			monsterlist =
			{
				{monsterId = 43601, x = 30.32851, y = 30.50114, refreshTime = 36000000, objectType = 0},
				{monsterId = 43601, x = 27.26841, y = 27.79321, refreshTime = 36000000, objectType = 0},
				{monsterId = 43601, x = 32.53233, y = 28.16094, refreshTime = 36000000, objectType = 0},
				{monsterId = 43602, x = 30.7869, y = 26.29724, refreshTime = 36000000, objectType = 0},
				{monsterId = 43601, x = 28.8597, y = 24.80491, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--ˢ���ӳ� ��
		},
		[3] =
		{
			monsterlist =
			{
				{monsterId = 43601, x = 30.32851, y = 30.50114, refreshTime = 36000000, objectType = 0},
				{monsterId = 43601, x = 27.26841, y = 27.79321, refreshTime = 36000000, objectType = 0},
				{monsterId = 43602, x = 32.53233, y = 28.16094, refreshTime = 36000000, objectType = 0},
				{monsterId = 43602, x = 30.7869, y = 26.29724, refreshTime = 36000000, objectType = 0},
				{monsterId = 43602, x = 28.8597, y = 24.80491, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--ˢ���ӳ� ��
		},
		[4] =
		{
			monsterlist =
			{
				{monsterId = 43601, x = 30.32851, y = 30.50114, refreshTime = 36000000, objectType = 0},
				{monsterId = 43601, x = 27.26841, y = 27.79321, refreshTime = 36000000, objectType = 0},
				{monsterId = 43602, x = 32.53233, y = 28.16094, refreshTime = 36000000, objectType = 0},
				{monsterId = 43602, x = 28.8597, y = 24.80491, refreshTime = 36000000, objectType = 0},
				{monsterId = 43603, x = 30.7869, y = 26.29724, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--ˢ���ӳ� ��
		},

	},

	LimitContorl =
	{
		--LimitSP = 1,			--��������
		LimitTimes = 2,			--��������
		OpenTime = 20,			--����ʱ�����
		LimitPlayerLevel = 0,	--��ҵȼ�����
	},
	
	WinCondition = 					--ʤ������
	{
		winrule = DAILY_ALLMONSTERORPLAYERDIE,  --���й������������������
	},

	FixAward = 					--ͨ������Ժ�Ĺ̶�����, ��ʱ�����壬�������
	{
	},
}

--ͨ��֮·
DailySceneTable[11] = 				--ͨ��֮· 60��
{
	DailyID = 11,				--�����ճ�
	DailyType = DAILY_ACTIVITE5,
	regionID = 10004,	MapID 	= 116,				--��̬��ͼ��Դ
	Npc ={},					--NPC �б�
	bornPostion = {36.97816,20.53465},		--��ҳ�����
	BaseSpendGlod = 10,		--�������ѽ���������Ѳ���ʱ���ĵ�ʵ�ʵĽ�ҹ�ʽΪ��BaseSpeedGlod + 10 * ����

	BatchMonster =  			--��������ˢ�µĹ���
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 44601, x = 30.32851, y = 30.50114, refreshTime = 36000000, objectType = 0},
				{monsterId = 44601, x = 27.26841, y = 27.79321, refreshTime = 36000000, objectType = 0},
				{monsterId = 44601, x = 32.53233, y = 28.16094, refreshTime = 36000000, objectType = 0},
				{monsterId = 44601, x = 30.7869, y = 26.29724, refreshTime = 36000000, objectType = 0},
				{monsterId = 44601, x = 28.8597, y = 24.80491, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--ˢ���ӳ� ��
		},
		[2] =  --2
		{
			monsterlist =
			{
				{monsterId = 44601, x = 30.32851, y = 30.50114, refreshTime = 36000000, objectType = 0},
				{monsterId = 44601, x = 27.26841, y = 27.79321, refreshTime = 36000000, objectType = 0},
				{monsterId = 44601, x = 32.53233, y = 28.16094, refreshTime = 36000000, objectType = 0},
				{monsterId = 44602, x = 30.7869, y = 26.29724, refreshTime = 36000000, objectType = 0},
				{monsterId = 44601, x = 28.8597, y = 24.80491, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--ˢ���ӳ� ��
		},
		[3] =
		{
			monsterlist =
			{
				{monsterId = 44601, x = 30.32851, y = 30.50114, refreshTime = 36000000, objectType = 0},
				{monsterId = 44601, x = 27.26841, y = 27.79321, refreshTime = 36000000, objectType = 0},
				{monsterId = 44602, x = 32.53233, y = 28.16094, refreshTime = 36000000, objectType = 0},
				{monsterId = 44602, x = 30.7869, y = 26.29724, refreshTime = 36000000, objectType = 0},
				{monsterId = 44602, x = 28.8597, y = 24.80491, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--ˢ���ӳ� ��
		},
		[4] =
		{
			monsterlist =
			{
				{monsterId = 44601, x = 30.32851, y = 30.50114, refreshTime = 36000000, objectType = 0},
				{monsterId = 44601, x = 27.26841, y = 27.79321, refreshTime = 36000000, objectType = 0},
				{monsterId = 44602, x = 32.53233, y = 28.16094, refreshTime = 36000000, objectType = 0},
				{monsterId = 44602, x = 28.8597, y = 24.80491, refreshTime = 36000000, objectType = 0},
				{monsterId = 44603, x = 30.7869, y = 26.29724, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--ˢ���ӳ� ��
		},

	},

	LimitContorl =
	{
		--LimitSP = 1,			--��������
		LimitTimes = 2,			--��������
		OpenTime = 20,			--����ʱ�����
		LimitPlayerLevel = 0,	--��ҵȼ�����
	},
	
	WinCondition = 					--ʤ������
	{
		winrule = DAILY_ALLMONSTERORPLAYERDIE,  --���й������������������
	},

	FixAward = 					--ͨ������Ժ�Ĺ̶�����, ��ʱ�����壬�������
	{
	},
}

 DailySceneTable[12] =                --��ħ����
{
 DailyID = 12,                --�����ճ�ID
 DailyType = GYMKHANA_SENZHILEYUAN,
 regionID = 10002,
 MapID   = 116,              --��̬��ͼ��Դ
 Npc ={},                    --NPC �б�
 bornPostion = {36.97816,20.53465},      --��ҳ�����

 BatchMonster =              --��������ˢ�µĹ���
 {
		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 44701, x = 26.79413, y = 19.80531, refreshTime = 36000000, objectType = 0},
			},
 			BossMonsterID = 44701,	--ָ��BOSS�Ĺ���ID,Boss�����������˳�����
			refreshdelaytime = 2, 			--ˢ���ӳ� ��
		},
 },

 LimitContorl =
 {
     --LimitSP = 1,          --��������
     LimitTimes = 10,         --��������
     OpenTime = 60,          --����ʱ�����
     LimitPlayerLevel = 0,   --��ҵȼ�����
 },
    
 WinCondition =                  --ʤ������
 {
    winrule = DAILY_SPECIFYMONSTERDIE,      --ָ��ID��������
 	MonsterID = 44701,	--ָ��BOSS�Ĺ���ID
 },

 FixAward =                  --ͨ������Ժ�Ĺ̶�����, ��ʱ�����壬�������
 {
 	FixBaseExp = 100,  --�̶����齱��
 	TranExpWeight = 0.2, 	--����ת����
 },
}

 DailySceneTable[13] = 				--����(���Թ���)
{
	DailyID = 13,				--�����ճ�
	DailyType = DAILY_SANGSHITYPE,
	regionID = 10004,
	MapID 	= 114,				--��̬��ͼ��Դ
	Npc ={},					--NPC �б�
	bornPostion = {85.38502,63.12715},		--��ҳ�����
	BaseSpendGlod = 10,		--�������ѽ���������Ѳ���ʱ���ĵ�ʵ�ʵĽ�ҹ�ʽΪ��BaseSpeedGlod + 10 * ����

	BatchMonster =  			--��������ˢ�µĹ���
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
		[1] =
		{
			monsterlist =
			{
				{monsterId = 31013, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[2] =
		{
			monsterlist =
			{
				{monsterId = 31023, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[3] =
		{
			monsterlist =
			{
				{monsterId = 31033, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[4] =
		{
			monsterlist =
			{
				{monsterId = 31043, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[5] =
		{
			monsterlist =
			{
				{monsterId = 49005, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[6] =
		{
			monsterlist =
			{
				{monsterId = 49006, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[7] =
		{
			monsterlist =
			{
				{monsterId = 49007, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[8] =
		{
			monsterlist =
			{
				{monsterId = 49008, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[9] =
		{
			monsterlist =
			{
				{monsterId = 49009, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[10] =
		{
			monsterlist =
			{
				{monsterId = 49010, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[11] =
		{
			monsterlist =
			{
				{monsterId = 49011, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[12] =
		{
			monsterlist =
			{
				{monsterId = 49012, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[13] =
		{
			monsterlist =
			{
				{monsterId = 49013, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[14] =
		{
			monsterlist =
			{
				{monsterId = 49014, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[15] =
		{
			monsterlist =
			{
				{monsterId = 49015, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[16] =
		{
			monsterlist =
			{
				{monsterId = 49016, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[17] =
		{
			monsterlist =
			{
				{monsterId = 49017, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[18] =
		{
			monsterlist =
			{
				{monsterId = 49018, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[19] =
		{
			monsterlist =
			{
				{monsterId = 49019, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[20] =
		{
			monsterlist =
			{
				{monsterId = 49020, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[21] =
		{
			monsterlist =
			{
				{monsterId = 49021, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[22] =
		{
			monsterlist =
			{
				{monsterId = 49022, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[23] =
		{
			monsterlist =
			{
				{monsterId = 49023, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[24] =
		{
			monsterlist =
			{
				{monsterId = 49024, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[25] =
		{
			monsterlist =
			{
				{monsterId = 49025, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[26] =
		{
			monsterlist =
			{
				{monsterId = 49026, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[27] =
		{
			monsterlist =
			{
				{monsterId = 49027, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[28] =
		{
			monsterlist =
			{
				{monsterId = 49028, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[28] =
		{
			monsterlist =
			{
				{monsterId = 49029, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[29] =
		{
			monsterlist =
			{
				{monsterId = 49030, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[30] =
		{
			monsterlist =
			{
				{monsterId = 49031, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[31] =
		{
			monsterlist =
			{
				{monsterId = 49032, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[32] =
		{
			monsterlist =
			{
				{monsterId = 49032, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[33] =
		{
			monsterlist =
			{
				{monsterId = 49033, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[34] =
		{
			monsterlist =
			{
				{monsterId = 49034, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[35] =
		{
			monsterlist =
			{
				{monsterId = 49035, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[36] =
		{
			monsterlist =
			{
				{monsterId = 49036, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[37] =
		{
			monsterlist =
			{
				{monsterId = 49037, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[38] =
		{
			monsterlist =
			{
				{monsterId = 49038, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[39] =
		{
			monsterlist =
			{
				{monsterId = 49039, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[40] =
		{
			monsterlist =
			{
				{monsterId = 49040, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[41] =
		{
			monsterlist =
			{
				{monsterId = 49041, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[42] =
		{
			monsterlist =
			{
				{monsterId = 49042, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[43] =
		{
			monsterlist =
			{
				{monsterId = 49043, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[44] =
		{
			monsterlist =
			{
				{monsterId = 49044, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[45] =
		{
			monsterlist =
			{
				{monsterId = 49045, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[46] =
		{
			monsterlist =
			{
				{monsterId = 49046, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[47] =
		{
			monsterlist =
			{
				{monsterId = 49047, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[48] =
		{
			monsterlist =
			{
				{monsterId = 49048, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[49] =
		{
			monsterlist =
			{
				{monsterId = 49049, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[50] =
		{
			monsterlist =
			{
				{monsterId = 49050, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[51] =
		{
			monsterlist =
			{
				{monsterId = 49051, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[52] =
		{
			monsterlist =
			{
				{monsterId = 49052, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[53] =
		{
			monsterlist =
			{
				{monsterId = 49053, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[54] =
		{
			monsterlist =
			{
				{monsterId = 49054, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[55] =
		{
			monsterlist =
			{
				{monsterId = 49055, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[56] =
		{
			monsterlist =
			{
				{monsterId = 49056, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[57] =
		{
			monsterlist =
			{
				{monsterId = 49057, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[58] =
		{
			monsterlist =
			{
				{monsterId = 49058, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[59] =
		{
			monsterlist =
			{
				{monsterId = 49059, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[60] =
		{
			monsterlist =
			{
				{monsterId = 49060, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[61] =
		{
			monsterlist =
			{
				{monsterId = 49061, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[62] =
		{
			monsterlist =
			{
				{monsterId = 49062, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[63] =
		{
			monsterlist =
			{
				{monsterId = 49063, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[64] =
		{
			monsterlist =
			{
				{monsterId = 49064, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 33, 			--ˢ���ӳ� ��
		},
		[65] =
		{
			monsterlist =
			{
				{monsterId = 49065, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[66] =
		{
			monsterlist =
			{
				{monsterId = 49066, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[67] =
		{
			monsterlist =
			{
				{monsterId = 49067, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[68] =
		{
			monsterlist =
			{
				{monsterId = 49068, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[69] =
		{
			monsterlist =
			{
				{monsterId = 49069, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[70] =
		{
			monsterlist =
			{
				{monsterId = 49070, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[71] =
		{
			monsterlist =
			{
				{monsterId = 49071, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[72] =
		{
			monsterlist =
			{
				{monsterId = 49072, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[73] =
		{
			monsterlist =
			{
				{monsterId = 49073, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[74] =
		{
			monsterlist =
			{
				{monsterId = 49074, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[75] =
		{
			monsterlist =
			{
				{monsterId = 49075, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[76] =
		{
			monsterlist =
			{
				{monsterId = 49076, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[77] =
		{
			monsterlist =
			{
				{monsterId = 49077, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[78] =
		{
			monsterlist =
			{
				{monsterId = 49078, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[79] =
		{
			monsterlist =
			{
				{monsterId = 49079, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[80] =
		{
			monsterlist =
			{
				{monsterId = 49080, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[81] =
		{
			monsterlist =
			{
				{monsterId = 49081, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[82] =
		{
			monsterlist =
			{
				{monsterId = 49082, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[83] =
		{
			monsterlist =
			{
				{monsterId = 49083, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[84] =
		{
			monsterlist =
			{
				{monsterId = 49084, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[85] =
		{
			monsterlist =
			{
				{monsterId = 49085, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[86] =
		{
			monsterlist =
			{
				{monsterId = 49086, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[87] =
		{
			monsterlist =
			{
				{monsterId = 49087, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[88] =
		{
			monsterlist =
			{
				{monsterId = 49088, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[89] =
		{
			monsterlist =
			{
				{monsterId = 49089, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[90] =
		{
			monsterlist =
			{
				{monsterId = 49090, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[91] =
		{
			monsterlist =
			{
				{monsterId = 49091, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[92] =
		{
			monsterlist =
			{
				{monsterId = 49092, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[93] =
		{
			monsterlist =
			{
				{monsterId = 49093, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[94] =
		{
			monsterlist =
			{
				{monsterId = 49094, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[95] =
		{
			monsterlist =
			{
				{monsterId = 49095, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[96] =
		{
			monsterlist =
			{
				{monsterId = 49096, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[97] =
		{
			monsterlist =
			{
				{monsterId = 49097, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[98] =
		{
			monsterlist =
			{
				{monsterId = 49098, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[99] =
		{
			monsterlist =
			{
				{monsterId = 49099, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[100] =
		{
			monsterlist =
			{
				{monsterId = 49100, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[101] =
		{
			monsterlist =
			{
				{monsterId = 49101, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[102] =
		{
			monsterlist =
			{
				{monsterId = 49102, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[103] =
		{
			monsterlist =
			{
				{monsterId = 49103, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[104] =
		{
			monsterlist =
			{
				{monsterId = 49104, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[105] =
		{
			monsterlist =
			{
				{monsterId = 49105, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[106] =
		{
			monsterlist =
			{
				{monsterId = 49106, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[107] =
		{
			monsterlist =
			{
				{monsterId = 49107, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[108] =
		{
			monsterlist =
			{
				{monsterId = 49108, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[109] =
		{
			monsterlist =
			{
				{monsterId = 49109, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[110] =
		{
			monsterlist =
			{
				{monsterId = 49110, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[111] =
		{
			monsterlist =
			{
				{monsterId = 49111, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[112] =
		{
			monsterlist =
			{
				{monsterId = 49112, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[113] =
		{
			monsterlist =
			{
				{monsterId = 49113, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[114] =
		{
			monsterlist =
			{
				{monsterId = 49114, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[115] =
		{
			monsterlist =
			{
				{monsterId = 49115, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[116] =
		{
			monsterlist =
			{
				{monsterId = 49116, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[117] =
		{
			monsterlist =
			{
				{monsterId = 49117, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[118] =
		{
			monsterlist =
			{
				{monsterId = 49118, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[119] =
		{
			monsterlist =
			{
				{monsterId = 49119, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[120] =
		{
			monsterlist =
			{
				{monsterId = 49120, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[121] =
		{
			monsterlist =
			{
				{monsterId = 49121, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[122] =
		{
			monsterlist =
			{
				{monsterId = 49122, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[123] =
		{
			monsterlist =
			{
				{monsterId = 49123, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[124] =
		{
			monsterlist =
			{
				{monsterId = 49125, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[125] =
		{
			monsterlist =
			{
				{monsterId = 49125, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[126] =
		{
			monsterlist =
			{
				{monsterId = 49126, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[127] =
		{
			monsterlist =
			{
				{monsterId = 49127, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[128] =
		{
			monsterlist =
			{
				{monsterId = 49128, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[129] =
		{
			monsterlist =
			{
				{monsterId = 49129, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[130] =
		{
			monsterlist =
			{
				{monsterId = 49130, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[131] =
		{
			monsterlist =
			{
				{monsterId = 49131, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[132] =
		{
			monsterlist =
			{
				{monsterId = 49132, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
		[133] =
		{
			monsterlist =
			{
				{monsterId = 49133, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--ˢ���ӳ� ��
		},
	},

	LimitContorl =
	{
		--LimitSP = 1,			--��������
		LimitTimes = 1,			--��������
		OpenTime = 400,			--����ʱ�����
		LimitPlayerLevel = 0,	--��ҵȼ�����
	},
	
	WinCondition = 					--ʤ������
	{
		winrule = DAILY_ALLMONSTERORPLAYERDIE,  --���й������������������
	},

	FixAward = 					--ͨ������Ժ�Ĺ̶�����, ��ʱ�����壬�������
	{
	},
}





--�����Ϊ�����������ܣ��������ճ���У�ע�����ID�����ǰ��Ĳ�����
XingYangSceneStartIndex = 200

 DailySceneTable[201] = 				--��������1��ս
{
	DailyID = 201,				--�����ճ�ID
	DailyType = XINYANG_FIGHTTYPE,
	regionID = 11001,
	MapID 	= 114,				--��̬��ͼ��Դ
	Npc ={},					--NPC �б�
	bornPostion = {85.38502,63.12715},		--��ҳ�����
	BaseSpendGlod = 0,		--�������ѽ���������Ѳ���ʱ���ĵ�ʵ�ʵĽ�ҹ�ʽΪ��BaseSpeedGlod + 10 * ����������û�и��ѽ��빦��

	BatchMonster =  			--��������ˢ�µĹ���
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 31011, x = 78.95467, y = 45.07328, refreshTime = 36000000, objectType = 0},
				{monsterId = 31011, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
				{monsterId = 31012, x = 88.51092, y = 33.47585, refreshTime = 36000000, objectType = 0},
				{monsterId = 31012, x = 89.09805, y = 20.20004, refreshTime = 36000000, objectType = 0},
				{monsterId = 31011, x = 80.66039, y = 13.11668, refreshTime = 36000000, objectType = 0},
				{monsterId = 31012, x = 87.31839, y = 8.1731, refreshTime = 36000000, objectType = 0},
				{monsterId = 31013, x = 81.78182, y = 7.763235, refreshTime = 36000000, objectType = 0},
			},
			BossMonsterID = 31013,	--ָ��BOSS�Ĺ���ID,Boss�����������˳�����
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
	},

	LimitContorl =
	{
		LimitTimes = 1,			--��������
		OpenTime = 30,			--����ʱ�����
		LimitPlayerLevel = 0,	--��ҵȼ�����
	},
	
	WinCondition = 					--ʤ������
	{
		winrule = DAILY_SPECIFYMONSTERDIE,		--ָ��ID��������
	},

	FixAward = 					--ͨ������Ժ�Ĺ̶�����, ��ʱ�����壬�������
	{
	},
}
 DailySceneTable[202] = 				--��������2��ս
{
	DailyID = 202,				--�����ճ�ID
	DailyType = XINYANG_FIGHTTYPE,
	regionID = 11002,
	MapID 	= 114,				--��̬��ͼ��Դ
	Npc ={},					--NPC �б�
	bornPostion = {85.38502,63.12715},		--��ҳ�����
	BaseSpendGlod = 0,		--�������ѽ���������Ѳ���ʱ���ĵ�ʵ�ʵĽ�ҹ�ʽΪ��BaseSpeedGlod + 10 * ����������û�и��ѽ��빦��

	BatchMonster =  			--��������ˢ�µĹ���
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 31021, x = 78.95467, y = 45.07328, refreshTime = 36000000, objectType = 0},
				{monsterId = 31021, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
				{monsterId = 31022, x = 88.51092, y = 33.47585, refreshTime = 36000000, objectType = 0},
				{monsterId = 31022, x = 89.09805, y = 20.20004, refreshTime = 36000000, objectType = 0},
				{monsterId = 31021, x = 80.66039, y = 13.11668, refreshTime = 36000000, objectType = 0},
				{monsterId = 31022, x = 87.31839, y = 8.1731, refreshTime = 36000000, objectType = 0},
				{monsterId = 31023, x = 81.78182, y = 7.763235, refreshTime = 36000000, objectType = 0},
			},
			BossMonsterID = 31023,	--ָ��BOSS�Ĺ���ID,Boss�����������˳�����
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
	},

	LimitContorl =
	{
		LimitTimes = 1,			--��������
		OpenTime = 30,			--����ʱ�����
		LimitPlayerLevel = 0,	--��ҵȼ�����
	},
	
	WinCondition = 					--ʤ������
	{
		winrule = DAILY_SPECIFYMONSTERDIE,		--ָ��ID��������
	},

	FixAward = 					--ͨ������Ժ�Ĺ̶�����, ��ʱ�����壬�������
	{
	},
}
 DailySceneTable[203] = 				--��������3��ս
{
	DailyID = 203,				--�����ճ�ID
	DailyType = XINYANG_FIGHTTYPE,
	regionID = 11003,
	MapID 	= 114,				--��̬��ͼ��Դ
	Npc ={},					--NPC �б�
	bornPostion = {85.38502,63.12715},		--��ҳ�����
	BaseSpendGlod = 10,		--�������ѽ���������Ѳ���ʱ���ĵ�ʵ�ʵĽ�ҹ�ʽΪ��BaseSpeedGlod + 10 * ����

	BatchMonster =  			--��������ˢ�µĹ���
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 31031, x = 78.95467, y = 45.07328, refreshTime = 36000000, objectType = 0},
				{monsterId = 31031, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
				{monsterId = 31032, x = 88.51092, y = 33.47585, refreshTime = 36000000, objectType = 0},
				{monsterId = 31032, x = 89.09805, y = 20.20004, refreshTime = 36000000, objectType = 0},
				{monsterId = 31031, x = 80.66039, y = 13.11668, refreshTime = 36000000, objectType = 0},
				{monsterId = 31032, x = 87.31839, y = 8.1731, refreshTime = 36000000, objectType = 0},
				{monsterId = 31033, x = 81.78182, y = 7.763235, refreshTime = 36000000, objectType = 0},
			},
			BossMonsterID = 31033,	--ָ��BOSS�Ĺ���ID,Boss�����������˳�����
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
	},

	LimitContorl =
	{
		LimitTimes = 1,			--��������
		OpenTime = 30,			--����ʱ�����
		LimitPlayerLevel = 0,	--��ҵȼ�����
	},
	
	WinCondition = 					--ʤ������
	{
		winrule = DAILY_SPECIFYMONSTERDIE,		--ָ��ID��������
	},

	FixAward = 					--ͨ������Ժ�Ĺ̶�����, ��ʱ�����壬�������
	{
	},
}
 DailySceneTable[204] = 				--��������4��ս
{
	DailyID = 204,				--�����ճ�ID
	DailyType = XINYANG_FIGHTTYPE,
	regionID = 11004,
	MapID 	= 114,				--��̬��ͼ��Դ
	Npc ={},					--NPC �б�
	bornPostion = {85.38502,63.12715},		--��ҳ�����
	BaseSpendGlod = 0,		--�������ѽ���������Ѳ���ʱ���ĵ�ʵ�ʵĽ�ҹ�ʽΪ��BaseSpeedGlod + 10 * ����������û�и��ѽ��빦��

	BatchMonster =  			--��������ˢ�µĹ���
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 31041, x = 78.95467, y = 45.07328, refreshTime = 36000000, objectType = 0},
				{monsterId = 31041, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
				{monsterId = 31042, x = 88.51092, y = 33.47585, refreshTime = 36000000, objectType = 0},
				{monsterId = 31042, x = 89.09805, y = 20.20004, refreshTime = 36000000, objectType = 0},
				{monsterId = 31041, x = 80.66039, y = 13.11668, refreshTime = 36000000, objectType = 0},
				{monsterId = 31042, x = 87.31839, y = 8.1731, refreshTime = 36000000, objectType = 0},
				{monsterId = 31043, x = 81.78182, y = 7.763235, refreshTime = 36000000, objectType = 0},
			},
			BossMonsterID = 31043,	--ָ��BOSS�Ĺ���ID,Boss�����������˳�����
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
	},

	LimitContorl =
	{
		LimitTimes = 1,			--��������
		OpenTime = 30,			--����ʱ�����
		LimitPlayerLevel = 0,	--��ҵȼ�����
	},
	
	WinCondition = 					--ʤ������
	{
		winrule = DAILY_SPECIFYMONSTERDIE,		--ָ��ID��������
	},

	FixAward = 					--ͨ������Ժ�Ĺ̶�����, ��ʱ�����壬�������
	{
	},
}
 DailySceneTable[205] = 				--��������5��ս
{
	DailyID = 205,				--�����ճ�ID
	DailyType = XINYANG_FIGHTTYPE,
	regionID = 11005,
	MapID 	= 114,				--��̬��ͼ��Դ
	Npc ={},					--NPC �б�
	bornPostion = {85.38502,63.12715},		--��ҳ�����
	BaseSpendGlod = 0,		--�������ѽ���������Ѳ���ʱ���ĵ�ʵ�ʵĽ�ҹ�ʽΪ��BaseSpeedGlod + 10 * ����������û�и��ѽ��빦��

	BatchMonster =  			--��������ˢ�µĹ���
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 31051, x = 78.95467, y = 45.07328, refreshTime = 36000000, objectType = 0},
				{monsterId = 31051, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
				{monsterId = 31052, x = 88.51092, y = 33.47585, refreshTime = 36000000, objectType = 0},
				{monsterId = 31052, x = 89.09805, y = 20.20004, refreshTime = 36000000, objectType = 0},
				{monsterId = 31051, x = 80.66039, y = 13.11668, refreshTime = 36000000, objectType = 0},
				{monsterId = 31052, x = 87.31839, y = 8.1731, refreshTime = 36000000, objectType = 0},
				{monsterId = 31053, x = 81.78182, y = 7.763235, refreshTime = 36000000, objectType = 0},
			},
			BossMonsterID = 31053,	--ָ��BOSS�Ĺ���ID,Boss�����������˳�����
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
	},

	LimitContorl =
	{
		LimitTimes = 1,			--��������
		OpenTime = 30,			--����ʱ�����
		LimitPlayerLevel = 0,	--��ҵȼ�����
	},
	
	WinCondition = 					--ʤ������
	{
		winrule = DAILY_SPECIFYMONSTERDIE,		--ָ��ID��������
	},

	FixAward = 					--ͨ������Ժ�Ĺ̶�����, ��ʱ�����壬�������
	{
	},
}
 DailySceneTable[206] = 				--��������6��ս
{
	DailyID = 206,				--�����ճ�ID
	DailyType = XINYANG_FIGHTTYPE,
	regionID = 11006,
	MapID 	= 114,				--��̬��ͼ��Դ
	Npc ={},					--NPC �б�
	bornPostion = {85.38502,63.12715},		--��ҳ�����
	BaseSpendGlod = 0,		--�������ѽ���������Ѳ���ʱ���ĵ�ʵ�ʵĽ�ҹ�ʽΪ��BaseSpeedGlod + 10 * ����������û�и��ѽ��빦��

	BatchMonster =  			--��������ˢ�µĹ���
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 31061, x = 78.95467, y = 45.07328, refreshTime = 36000000, objectType = 0},
				{monsterId = 31061, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
				{monsterId = 31062, x = 88.51092, y = 33.47585, refreshTime = 36000000, objectType = 0},
				{monsterId = 31062, x = 89.09805, y = 20.20004, refreshTime = 36000000, objectType = 0},
				{monsterId = 31061, x = 80.66039, y = 13.11668, refreshTime = 36000000, objectType = 0},
				{monsterId = 31062, x = 87.31839, y = 8.1731, refreshTime = 36000000, objectType = 0},
				{monsterId = 31063, x = 81.78182, y = 7.763235, refreshTime = 36000000, objectType = 0},
			},
			BossMonsterID = 31063,	--ָ��BOSS�Ĺ���ID,Boss�����������˳�����
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
	},
	
	LimitContorl =
	{
		LimitTimes = 1,			--��������
		OpenTime = 30,			--����ʱ�����
		LimitPlayerLevel = 0,	--��ҵȼ�����
	},
	
	WinCondition = 					--ʤ������
	{
		winrule = DAILY_SPECIFYMONSTERDIE,		--ָ��ID��������
	},

	FixAward = 					--ͨ������Ժ�Ĺ̶�����, ��ʱ�����壬�������
	{
	},
}
 DailySceneTable[207] = 				--��������7��ս
{
	DailyID = 207,				--�����ճ�ID
	DailyType = XINYANG_FIGHTTYPE,
	regionID = 11007,
	MapID 	= 114,				--��̬��ͼ��Դ
	Npc ={},					--NPC �б�
	bornPostion = {85.38502,63.12715},		--��ҳ�����
	BaseSpendGlod = 0,		--�������ѽ���������Ѳ���ʱ���ĵ�ʵ�ʵĽ�ҹ�ʽΪ��BaseSpeedGlod + 10 * ����������û�и��ѽ��빦��

	BatchMonster =  			--��������ˢ�µĹ���
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 31071, x = 78.95467, y = 45.07328, refreshTime = 36000000, objectType = 0},
				{monsterId = 31071, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
				{monsterId = 31072, x = 88.51092, y = 33.47585, refreshTime = 36000000, objectType = 0},
				{monsterId = 31072, x = 89.09805, y = 20.20004, refreshTime = 36000000, objectType = 0},
				{monsterId = 31071, x = 80.66039, y = 13.11668, refreshTime = 36000000, objectType = 0},
				{monsterId = 31072, x = 87.31839, y = 8.1731, refreshTime = 36000000, objectType = 0},
				{monsterId = 31073, x = 81.78182, y = 7.763235, refreshTime = 36000000, objectType = 0},
			},
			BossMonsterID = 31073,	--ָ��BOSS�Ĺ���ID,Boss�����������˳�����
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
	},

	LimitContorl =
	{
		LimitTimes = 1,			--��������
		OpenTime = 30,			--����ʱ�����
		LimitPlayerLevel = 0,	--��ҵȼ�����
	},
	
	WinCondition = 					--ʤ������
	{
		winrule = DAILY_SPECIFYMONSTERDIE,		--ָ��ID��������
	},

	FixAward = 					--ͨ������Ժ�Ĺ̶�����, ��ʱ�����壬�������
	{
	},
}
 DailySceneTable[208] = 				--��������8��ս
{
	DailyID = 208,				--�����ճ�ID
	DailyType = XINYANG_FIGHTTYPE,
	regionID = 11008,
	MapID 	= 114,				--��̬��ͼ��Դ
	Npc ={},					--NPC �б�
	bornPostion = {85.38502,63.12715},		--��ҳ�����
	BaseSpendGlod = 0,		--�������ѽ���������Ѳ���ʱ���ĵ�ʵ�ʵĽ�ҹ�ʽΪ��BaseSpeedGlod + 10 * ����������û�и��ѽ��빦��

	BatchMonster =  			--��������ˢ�µĹ���
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 31081, x = 78.95467, y = 45.07328, refreshTime = 36000000, objectType = 0},
				{monsterId = 31081, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
				{monsterId = 31082, x = 88.51092, y = 33.47585, refreshTime = 36000000, objectType = 0},
				{monsterId = 31082, x = 89.09805, y = 20.20004, refreshTime = 36000000, objectType = 0},
				{monsterId = 31081, x = 80.66039, y = 13.11668, refreshTime = 36000000, objectType = 0},
				{monsterId = 31082, x = 87.31839, y = 8.1731, refreshTime = 36000000, objectType = 0},
				{monsterId = 31083, x = 81.78182, y = 7.763235, refreshTime = 36000000, objectType = 0},
			},
			BossMonsterID = 31083,	--ָ��BOSS�Ĺ���ID,Boss�����������˳�����
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
	},

	LimitContorl =
	{
		LimitTimes = 1,			--��������
		OpenTime = 30,			--����ʱ�����
		LimitPlayerLevel = 0,	--��ҵȼ�����
	},
	
	WinCondition = 					--ʤ������
	{
		winrule = DAILY_SPECIFYMONSTERDIE,		--ָ��ID��������
	},

	FixAward = 					--ͨ������Ժ�Ĺ̶�����, ��ʱ�����壬�������
	{
	},
}
 DailySceneTable[209] = 				--��������9��ս
{
	DailyID = 209,				--�����ճ�ID
	DailyType = XINYANG_FIGHTTYPE,
	regionID = 11009,
	MapID 	= 114,				--��̬��ͼ��Դ
	Npc ={},					--NPC �б�
	bornPostion = {85.38502,63.12715},		--��ҳ�����
	BaseSpendGlod = 0,		--�������ѽ���������Ѳ���ʱ���ĵ�ʵ�ʵĽ�ҹ�ʽΪ��BaseSpeedGlod + 10 * ����������û�и��ѽ��빦��

	BatchMonster =  			--��������ˢ�µĹ���
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 31091, x = 78.95467, y = 45.07328, refreshTime = 36000000, objectType = 0},
				{monsterId = 31091, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
				{monsterId = 31092, x = 88.51092, y = 33.47585, refreshTime = 36000000, objectType = 0},
				{monsterId = 31092, x = 89.09805, y = 20.20004, refreshTime = 36000000, objectType = 0},
				{monsterId = 31091, x = 80.66039, y = 13.11668, refreshTime = 36000000, objectType = 0},
				{monsterId = 31092, x = 87.31839, y = 8.1731, refreshTime = 36000000, objectType = 0},
				{monsterId = 31093, x = 81.78182, y = 7.763235, refreshTime = 36000000, objectType = 0},
			},
			BossMonsterID = 31093,	--ָ��BOSS�Ĺ���ID,Boss�����������˳�����
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
	},

	LimitContorl =
	{
		LimitTimes = 1,			--��������
		OpenTime = 30,			--����ʱ�����
		LimitPlayerLevel = 0,	--��ҵȼ�����
	},
	
	WinCondition = 					--ʤ������
	{
		winrule = DAILY_SPECIFYMONSTERDIE,		--ָ��ID��������
	},

	FixAward = 					--ͨ������Ժ�Ĺ̶�����, ��ʱ�����壬�������
	{
	},
}
 DailySceneTable[210] = 				--��������10��ս
{
	DailyID = 210,				--�����ճ�ID
	DailyType = XINYANG_FIGHTTYPE,
	regionID = 11010,
	MapID 	= 114,				--��̬��ͼ��Դ
	Npc ={},					--NPC �б�
	bornPostion = {85.38502,63.12715},		--��ҳ�����
	BaseSpendGlod = 0,		--�������ѽ���������Ѳ���ʱ���ĵ�ʵ�ʵĽ�ҹ�ʽΪ��BaseSpeedGlod + 10 * ����������û�и��ѽ��빦��

	BatchMonster =  			--��������ˢ�µĹ���
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 31101, x = 78.95467, y = 45.07328, refreshTime = 36000000, objectType = 0},
				{monsterId = 31101, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
				{monsterId = 31102, x = 88.51092, y = 33.47585, refreshTime = 36000000, objectType = 0},
				{monsterId = 31102, x = 89.09805, y = 20.20004, refreshTime = 36000000, objectType = 0},
				{monsterId = 31101, x = 80.66039, y = 13.11668, refreshTime = 36000000, objectType = 0},
				{monsterId = 31102, x = 87.31839, y = 8.1731, refreshTime = 36000000, objectType = 0},
				{monsterId = 31103, x = 81.78182, y = 7.763235, refreshTime = 36000000, objectType = 0},
			},
			BossMonsterID = 31103,	--ָ��BOSS�Ĺ���ID,Boss�����������˳�����
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
	},

	LimitContorl =
	{
		LimitTimes = 1,			--��������
		OpenTime = 30,			--����ʱ�����
		LimitPlayerLevel = 0,	--��ҵȼ�����
	},
	
	WinCondition = 					--ʤ������
	{
		winrule = DAILY_SPECIFYMONSTERDIE,		--ָ��ID��������
	},

	FixAward = 					--ͨ������Ժ�Ĺ̶�����, ��ʱ�����壬�������
	{
	},
}
 DailySceneTable[211] = 				--��������11��ս
{
	DailyID = 211,				--�����ճ�ID
	DailyType = XINYANG_FIGHTTYPE,
	regionID = 11011,
	MapID 	= 114,				--��̬��ͼ��Դ
	Npc ={},					--NPC �б�
	bornPostion = {85.38502,63.12715},		--��ҳ�����
	BaseSpendGlod = 0,		--�������ѽ���������Ѳ���ʱ���ĵ�ʵ�ʵĽ�ҹ�ʽΪ��BaseSpeedGlod + 10 * ����������û�и��ѽ��빦��

	BatchMonster =  			--��������ˢ�µĹ���
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 31111, x = 78.95467, y = 45.07328, refreshTime = 36000000, objectType = 0},
				{monsterId = 31111, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
				{monsterId = 31112, x = 88.51092, y = 33.47585, refreshTime = 36000000, objectType = 0},
				{monsterId = 31112, x = 89.09805, y = 20.20004, refreshTime = 36000000, objectType = 0},
				{monsterId = 31111, x = 80.66039, y = 13.11668, refreshTime = 36000000, objectType = 0},
				{monsterId = 31112, x = 87.31839, y = 8.1731, refreshTime = 36000000, objectType = 0},
				{monsterId = 31113, x = 81.78182, y = 7.763235, refreshTime = 36000000, objectType = 0},
			},
			BossMonsterID = 31113,	--ָ��BOSS�Ĺ���ID,Boss�����������˳�����
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
	},

	LimitContorl =
	{
		LimitTimes = 1,			--��������
		OpenTime = 30,			--����ʱ�����
		LimitPlayerLevel = 0,	--��ҵȼ�����
	},
	
	WinCondition = 					--ʤ������
	{
		winrule = DAILY_SPECIFYMONSTERDIE,		--ָ��ID��������
	},

	FixAward = 					--ͨ������Ժ�Ĺ̶�����, ��ʱ�����壬�������
	{
	},
}
 DailySceneTable[212] = 				--��������12��ս
{
	DailyID = 212,				--�����ճ�ID
	DailyType = XINYANG_FIGHTTYPE,
	regionID = 11012,
	MapID 	= 114,				--��̬��ͼ��Դ
	Npc ={},					--NPC �б�
	bornPostion = {85.38502,63.12715},		--��ҳ�����
	BaseSpendGlod = 0,		--�������ѽ���������Ѳ���ʱ���ĵ�ʵ�ʵĽ�ҹ�ʽΪ��BaseSpeedGlod + 10 * ����������û�и��ѽ��빦��

	BatchMonster =  			--��������ˢ�µĹ���
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 31121, x = 78.95467, y = 45.07328, refreshTime = 36000000, objectType = 0},
				{monsterId = 31121, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
				{monsterId = 31122, x = 88.51092, y = 33.47585, refreshTime = 36000000, objectType = 0},
				{monsterId = 31122, x = 89.09805, y = 20.20004, refreshTime = 36000000, objectType = 0},
				{monsterId = 31121, x = 80.66039, y = 13.11668, refreshTime = 36000000, objectType = 0},
				{monsterId = 31122, x = 87.31839, y = 8.1731, refreshTime = 36000000, objectType = 0},
				{monsterId = 311123, x = 81.78182, y = 7.763235, refreshTime = 36000000, objectType = 0},
			},
			BossMonsterID = 31123,	--ָ��BOSS�Ĺ���ID,Boss�����������˳�����
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
	},

	LimitContorl =
	{
		LimitTimes = 1,			--��������
		OpenTime = 30,			--����ʱ�����
		LimitPlayerLevel = 0,	--��ҵȼ�����
	},
	
	WinCondition = 					--ʤ������
	{
		winrule = DAILY_SPECIFYMONSTERDIE,		--ָ��ID��������
	},

	FixAward = 					--ͨ������Ժ�Ĺ̶�����, ��ʱ�����壬�������
	{
	},
}
