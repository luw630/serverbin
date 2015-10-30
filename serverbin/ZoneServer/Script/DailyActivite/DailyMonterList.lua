DAILY_AllMONSTERDIE = 1		--日常活动中所有怪物都死亡
DAILY_PLAYERDIE = 2	--玩家死亡，判断杀怪层数
DAILY_ALLMONSTERORPLAYERDIE = 3 --所有怪物死亡或者玩家死亡
DAILY_SPECIFYMONSTERDIE = 4  --指定ID的怪物死亡

DAILY_JINGYINGTYPE = 0   --精英关卡类型
DAILY_SANGSHITYPE = 1    --丧尸围城类型
XINYANG_FIGHTTYPE = 2 	--信仰挑战类型
DAILY_WORLDTREE = 3 	--世界之树类型
DAILY_SHILEYUAN = 4 	--失乐园类型
DAILY_UNKNOWNDARKHOUSE = 5 	--未知神殿
DAILY_SHENQUANSHAN = 6 		--神泉山
DAILY_HONORHALL = 7 		--荣誉殿堂
DAILY_FORTUNEHILL = 8 		--财富山
DAILY_ACTIVITE3 = 12 		--活动3
DAILY_ACTIVITE4 = 10 		--活动4
DAILY_ACTIVITE5 = 11 		--活动5
GYMKHANA_SENZHILEYUAN = 9   --森之乐园竞技场活动


--下面的内容为可配置的
SangShiLayerInterval = 5 	--丧尸围城的层数单元，每隔SangShiLayerInterval值算一层
DailyResetTime = 11 * 60 * 60 + 7 * 60		--日常活动重置时间0 - 24 * 60 * 60 S
DailyCount = 13 --玩家日常活动个数；配置日常活动时必须配置活动的个数，不然，信仰主神挑战也会被当做日常活动功能


DailySceneBossMonsterID = {31201,31202,31203,31204}	--活动中的BOSS怪物ID列表，如果没有就为空表

DailySceneTable = {}



--  DailySceneTable[1] = 				--精英关卡
-- {
-- 	DailyID = 1,				--所属日常ID
-- 	DailyType = DAILY_JINGYINGTYPE,
-- 	regionID = 10002,
-- 	MapID 	= 116,				--静态地图资源
-- 	Npc ={},					--NPC 列表
-- 	bornPostion = {36.97816,20.53465},		--玩家出生点
-- 	BaseSpendGlod = 10,		--基础消费金币数，付费操作时消耗的实际的金币公式为：BaseSpeedGlod + 10 * 次数

-- 	BatchMonster =  			--分批操作刷新的怪物
-- 	{
-- 		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
-- 		[1] = --1
-- 		{
-- 			monsterlist =
-- 			{
-- 				{monsterId = 30101, x = 25.01747, y = 33.61871, refreshTime = 36000000, objectType = 0},	--BOSS怪物
-- 			},
-- 			BossMonsterID = 30101,	--指定BOSS的怪物ID,Boss怪物死亡后退出场景
-- 			refreshdelaytime = 1, 			--刷新延迟 秒
-- 		},
-- 	},

-- 	LimitContorl =
-- 	{
-- 		--LimitSP = 1,			--体力限制
-- 		LimitTimes = 1,			--次数限制
-- 		OpenTime = 30,			--开启时间分钟
-- 		LimitPlayerLevel = 0,	--玩家等级限制
-- 	},
	
-- 	WinCondition = 					--胜利条件
-- 	{
-- 		winrule = DAILY_SPECIFYMONSTERDIE,		--指定ID怪物死亡
-- 		MonsterID = 30101,	--指定BOSS的怪物ID
-- 	},

-- 	FixAward = 					--通关完成以后的固定奖励, 暂时不定义，后续添加
-- 	{
-- 	},
-- }

--圣魔炼狱20
DailySceneTable[1] = 				--圣魔炼狱20
{
	DailyID = 1,				--所属日常
	DailyType = DAILY_JINGYINGTYPE,
	regionID = 10004,	MapID 	= 116,				--静态地图资源
	Npc ={},					--NPC 列表
	bornPostion = {36.97816,20.53465},		--玩家出生点
	BaseSpendGlod = 10,		--基础消费金币数，付费操作时消耗的实际的金币公式为：BaseSpeedGlod + 10 * 次数

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 31201, x = 26.79413, y = 19.80531, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--刷新延迟 秒
		},
		[2] =  --2
		{
			monsterlist =
			{
				{monsterId = 31202, x = 26.79413, y = 19.80531, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--刷新延迟 秒
		},
		[3] =
		{
			monsterlist =
			{
				{monsterId = 31203, x = 26.79413, y = 19.80531, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--刷新延迟 秒
		},
		[4] =
		{
			monsterlist =
			{
				{monsterId = 31204, x = 26.79413, y = 19.80531, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--刷新延迟 秒
		},

	},

	LimitContorl =
	{
		--LimitSP = 1,			--体力限制
		LimitTimes = 1,			--次数限制
		OpenTime = 20,			--开启时间分钟
		LimitPlayerLevel = 0,	--玩家等级限制
	},
	
	WinCondition = 					--胜利条件
	{
		winrule = DAILY_ALLMONSTERORPLAYERDIE,  --所有怪物死亡或者玩家死亡
	},

	FixAward = 					--通关完成以后的固定奖励, 暂时不定义，后续添加
	{
	},
}

--丧尸围城
 DailySceneTable[2] = 				--丧尸围城20
{
	DailyID = 2,				--所属日常
	DailyType = DAILY_SANGSHITYPE,
	regionID = 10004,	MapID 	= 116,				--静态地图资源
	Npc ={},					--NPC 列表
	bornPostion = {32.50846,25.05575},		--玩家出生点
	BaseSpendGlod = 10,		--基础消费金币数，付费操作时消耗的实际的金币公式为：BaseSpeedGlod + 10 * 次数

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
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
				--{imageID = 10007, x = 25.12242, y = 33.75431, dir = 0,clickScript = 20051,LiveTime = 36000000, objectType = 1,name = "吸血鬼女萝莉"},
			},
			refreshdelaytime = 8, 			--刷新延迟 秒
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
			refreshdelaytime = 8, 			--刷新延迟 秒
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
			refreshdelaytime = 8, 			--刷新延迟 秒
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
			refreshdelaytime = 8, 			--刷新延迟 秒
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
			refreshdelaytime = 8, 			--刷新延迟 秒
		},

	},

	LimitContorl =
	{
		--LimitSP = 1,			--体力限制
		LimitTimes = 1,			--次数限制
		OpenTime = 20,			--开启时间分钟
		LimitPlayerLevel = 0,	--玩家等级限制
	},
	
	WinCondition = 					--胜利条件
	{
		winrule = DAILY_ALLMONSTERORPLAYERDIE,  --所有怪物死亡或者玩家死亡
	},

	FixAward = 					--通关完成以后的固定奖励, 暂时不定义，后续添加
	{
	},
}

--世界之树
 DailySceneTable[3] = 				--世界之树20
{
	DailyID = 3,				--所属日常ID
	DailyType = DAILY_WORLDTREE,
	regionID = 10002,
	MapID 	= 116,				--静态地图资源
	Npc ={},					--NPC 列表
	bornPostion = {36.09824,23.20676},		--玩家出生点
	BaseSpendGlod = 10,		--基础消费金币数，付费操作时消耗的实际的金币公式为：BaseSpeedGlod + 10 * 次数

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 33201, x = 29.29861, y = 28.81238, refreshTime = 36000000, objectType = 0},	--BOSS怪物
			},
			BossMonsterID = 10021,	--指定BOSS的怪物ID,Boss怪物死亡后退出场景
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
	},

	LimitContorl =
	{
		--LimitSP = 1,			--体力限制
		LimitTimes = 1,			--次数限制
		OpenTime = 30,			--开启时间分钟
		LimitPlayerLevel = 0,	--玩家等级限制
	},
	
	WinCondition = 					--胜利条件
	{
		winrule = DAILY_SPECIFYMONSTERDIE,		--指定ID怪物死亡
		MonsterID = 30101,	--指定BOSS的怪物ID
	},

	FixAward = 					--通关完成以后的固定奖励, 暂时不定义，后续添加
	{
	},
}

 DailySceneTable[4] = 				--失乐园30
{
	DailyID = 4,				--所属日常ID
	DailyType = DAILY_SHILEYUAN,
	regionID = 10002,
	MapID 	= 116,				--静态地图资源
	Npc ={},					--NPC 列表
	bornPostion = {36.97816,20.53465},		--玩家出生点
	BaseSpendGlod = 10,		--基础消费金币数，付费操作时消耗的实际的金币公式为：BaseSpeedGlod + 10 * 次数

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
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
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
	},

	LimitContorl =
	{
		--LimitSP = 1,			--体力限制
		LimitTimes = 1,			--次数限制
		OpenTime = 10,			--开启时间分钟
		LimitPlayerLevel = 0,	--玩家等级限制
	},
	
	WinCondition = 					--胜利条件
	{
		winrule = DAILY_ALLMONSTERORPLAYERDIE,  --所有怪物死亡或者玩家死亡
		MonsterID = 30101,	--指定BOSS的怪物ID
	},

	FixAward = 					--通关完成以后的固定奖励, 暂时不定义，后续添加
	{
	},
}

--未知神殿
--未知神殿每个N次必然遇到的怪物
UDHMustEnterTimes = 5

--未知神殿活动的道具数量到的一定值时，必然不会遇到的怪物
UDHGetItemNum = 10

--进入未知神殿需要的道具
EnterUnknownDarkHouseNeedItem = {720203, 1}

--必然刷出的怪物ID
MustRefreshMonsterID = {[5] = 35407 }

--未知神殿随机产出的怪物配置
UnKnownDarkHouseMonsterCfg =
{
	[5] =  
	{
		--参数依次为：怪物ID，权重
		{35401, 5},
		{35402, 5},
		{35403, 5},
		{35404, 5},
		{35405, 5},
		{35406, 5},
		{35407, 5},
	},

}

--未知神殿随便不能刷出某个怪物的随机区间
UDHDebarCertainMonsterCfg =
{
	[5] = 
	{
		--参数依次为：怪物ID，权重
		{35401, 5},
		{35402, 5},
		{35403, 5},
		{35404, 5},
		{35405, 5},
		{35406, 5},
	},

}

--未知神殿场景配置
 DailySceneTable[5] = 				--未知神殿
{
	DailyID = 5,				--所属日常ID
	DailyType = DAILY_UNKNOWNDARKHOUSE,
	regionID = 10002,
	MapID 	= 116,				--静态地图资源
	Npc ={},					--NPC 列表
	bornPostion = {36.09824,23.20676},		--玩家出生点
	BaseSpendGlod = 10,		--基础消费金币数，付费操作时消耗的实际的金币公式为：BaseSpeedGlod + 10 * 次数

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 0, x = 29.29861, y = 28.81238, refreshTime = 36000000, objectType = 0},	--BOSS怪物, 如果monsterId = 0，表示未知神殿随机刷出一个怪物
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
	},

	LimitContorl =
	{
		--LimitSP = 1,			--体力限制
		LimitTimes = -1,			--次数限制，当为-1时，表示不限次数
		OpenTime = 30,			--开启时间分钟
		LimitPlayerLevel = 0,	--玩家等级限制
	},
	
	WinCondition = 					--胜利条件
	{
		winrule = DAILY_ALLMONSTERORPLAYERDIE,		--所有怪物死亡或者玩家死亡
		MonsterID = 0,	--指定BOSS的怪物ID
	},

	FixAward = 					--通关完成以后的固定奖励, 暂时不定义，后续添加
	{
	},
}

--神泉山50
 DailySceneTable[6] = 				--神泉山50
{
	DailyID = 6,				--所属日常ID
	DailyType = DAILY_SHENQUANSHAN,
	regionID = 10002,
	MapID 	= 116,				--静态地图资源
	Npc ={},					--NPC 列表
	bornPostion = {36.97816,20.53465},		--玩家出生点
	BaseSpendGlod = 10,		--基础消费金币数，付费操作时消耗的实际的金币公式为：BaseSpeedGlod + 10 * 次数

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
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
			refreshdelaytime = 1, 			--刷新延迟 秒
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
			refreshdelaytime = 1, 			--刷新延迟 秒
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
			refreshdelaytime = 1, 			--刷新延迟 秒
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
			refreshdelaytime = 1, 			--刷新延迟 秒
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
			refreshdelaytime = 1, 			--刷新延迟 秒
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
			refreshdelaytime = 1, 			--刷新延迟 秒
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
			refreshdelaytime = 1, 			--刷新延迟 秒
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
			refreshdelaytime = 1, 			--刷新延迟 秒
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
			refreshdelaytime = 1, 			--刷新延迟 秒
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
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
	},

	LimitContorl =
	{
		--LimitSP = 1,			--体力限制
		LimitTimes = 1,			--次数限制
		OpenTime = 10,			--开启时间分钟
		LimitPlayerLevel = 0,	--玩家等级限制
	},
	
	WinCondition = 					--胜利条件
	{
		winrule = DAILY_ALLMONSTERORPLAYERDIE,  --所有怪物死亡或者玩家死亡
		MonsterID = 30101,	--指定BOSS的怪物ID
	},

	FixAward = 					--通关完成以后的固定奖励, 暂时不定义，后续添加
	{
	},
}

--荣誉殿堂
--当玩家进入荣誉殿堂次数消耗完，则必要消耗道具进入，消耗道具配置
HonorHallEnterResumeItem = {720201, 1}

DailySceneTable[7] = 				--荣誉殿堂60
{
	DailyID = 7,				--所属日常
	DailyType = DAILY_HONORHALL,
	regionID = 10004,	MapID 	= 116,				--静态地图资源
	Npc ={},					--NPC 列表
	bornPostion = {36.97816,20.53465},		--玩家出生点
	BaseSpendGlod = 10,		--基础消费金币数，付费操作时消耗的实际的金币公式为：BaseSpeedGlod + 10 * 次数

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
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
			refreshdelaytime = 2, 			--刷新延迟 秒
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
			refreshdelaytime = 2, 			--刷新延迟 秒
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
			refreshdelaytime = 2, 			--刷新延迟 秒
		},

	},

	LimitContorl =
	{
		--LimitSP = 1,			--体力限制
		LimitTimes = 5,			--次数限制
		OpenTime = 20,			--开启时间分钟
		LimitPlayerLevel = 0,	--玩家等级限制
	},
	
	WinCondition = 					--胜利条件
	{
		winrule = DAILY_ALLMONSTERORPLAYERDIE,  --所有怪物死亡或者玩家死亡
	},

	FixAward = 					--通关完成以后的固定奖励, 暂时不定义，后续添加
	{
	},
}

--财富山
--财富山，指定怪物死亡次数多少时退出
FortuneSpecMonsterDieTimesQuit = 10

--财富山怪物随机表
FortuneHillMonsterRandomCfg = 
{
	[8] = 
	{
		--参数依次为：怪物ID，权重
		{41601, 5},
		{41602, 25},
	},
	
}

--财富山产出银币的怪物
FortuneHillCanGetGlodMonsterID = {[8] = 41601 }

 DailySceneTable[8] = 				--财富山60
{
	DailyID = 8,				--所属日常ID
	DailyType = DAILY_FORTUNEHILL,
	regionID = 10002,
	MapID 	= 116,				--静态地图资源
	Npc ={},					--NPC 列表
	bornPostion = {36.97816,20.53465},		--玩家出生点
	BaseSpendGlod = 10,		--基础消费金币数，付费操作时消耗的实际的金币公式为：BaseSpeedGlod + 10 * 次数

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
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
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
		[2] = --2
		{
			monsterlist =
			{
				{monsterId = 0, x = 0, y = 0, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
	},

	LimitContorl =
	{
		--LimitSP = 1,			--体力限制
		LimitTimes = 1,			--次数限制
		OpenTime = 10,			--开启时间分钟
		LimitPlayerLevel = 0,	--玩家等级限制
	},
	
	WinCondition = 					--胜利条件
	{
		winrule = DAILY_ALLMONSTERORPLAYERDIE,  --所有怪物死亡或者玩家死亡
		MonsterID = 30101,	--指定BOSS的怪物ID
	},

	FixAward = 					--通关完成以后的固定奖励, 暂时不定义，后续添加
	{
	},
}
 
--活动3
DailySceneTable[9] = 				--挑战BOSS活动3 60级
{
	DailyID = 9,				--所属日常
	DailyType = DAILY_ACTIVITE3,
	regionID = 10004,	MapID 	= 116,				--静态地图资源
	Npc ={},					--NPC 列表
	bornPostion = {36.97816,20.53465},		--玩家出生点
	BaseSpendGlod = 10,		--基础消费金币数，付费操作时消耗的实际的金币公式为：BaseSpeedGlod + 10 * 次数

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
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
			refreshdelaytime = 2, 			--刷新延迟 秒
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
			refreshdelaytime = 2, 			--刷新延迟 秒
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
			refreshdelaytime = 2, 			--刷新延迟 秒
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
			refreshdelaytime = 2, 			--刷新延迟 秒
		},

	},

	LimitContorl =
	{
		--LimitSP = 1,			--体力限制
		LimitTimes = 2,			--次数限制
		OpenTime = 20,			--开启时间分钟
		LimitPlayerLevel = 0,	--玩家等级限制
	},
	
	WinCondition = 					--胜利条件
	{
		winrule = DAILY_ALLMONSTERORPLAYERDIE,  --所有怪物死亡或者玩家死亡
	},

	FixAward = 					--通关完成以后的固定奖励, 暂时不定义，后续添加
	{
	},
}

--炼狱之地
DailySceneTable[10] = 				--炼狱之地 60级
{
	DailyID = 10,				--所属日常
	DailyType = DAILY_ACTIVITE4,
	regionID = 10004,	MapID 	= 116,				--静态地图资源
	Npc ={},					--NPC 列表
	bornPostion = {36.97816,20.53465},		--玩家出生点
	BaseSpendGlod = 10,		--基础消费金币数，付费操作时消耗的实际的金币公式为：BaseSpeedGlod + 10 * 次数

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
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
			refreshdelaytime = 2, 			--刷新延迟 秒
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
			refreshdelaytime = 2, 			--刷新延迟 秒
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
			refreshdelaytime = 2, 			--刷新延迟 秒
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
			refreshdelaytime = 2, 			--刷新延迟 秒
		},

	},

	LimitContorl =
	{
		--LimitSP = 1,			--体力限制
		LimitTimes = 2,			--次数限制
		OpenTime = 20,			--开启时间分钟
		LimitPlayerLevel = 0,	--玩家等级限制
	},
	
	WinCondition = 					--胜利条件
	{
		winrule = DAILY_ALLMONSTERORPLAYERDIE,  --所有怪物死亡或者玩家死亡
	},

	FixAward = 					--通关完成以后的固定奖励, 暂时不定义，后续添加
	{
	},
}

--通天之路
DailySceneTable[11] = 				--通天之路 60级
{
	DailyID = 11,				--所属日常
	DailyType = DAILY_ACTIVITE5,
	regionID = 10004,	MapID 	= 116,				--静态地图资源
	Npc ={},					--NPC 列表
	bornPostion = {36.97816,20.53465},		--玩家出生点
	BaseSpendGlod = 10,		--基础消费金币数，付费操作时消耗的实际的金币公式为：BaseSpeedGlod + 10 * 次数

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
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
			refreshdelaytime = 2, 			--刷新延迟 秒
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
			refreshdelaytime = 2, 			--刷新延迟 秒
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
			refreshdelaytime = 2, 			--刷新延迟 秒
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
			refreshdelaytime = 2, 			--刷新延迟 秒
		},

	},

	LimitContorl =
	{
		--LimitSP = 1,			--体力限制
		LimitTimes = 2,			--次数限制
		OpenTime = 20,			--开启时间分钟
		LimitPlayerLevel = 0,	--玩家等级限制
	},
	
	WinCondition = 					--胜利条件
	{
		winrule = DAILY_ALLMONSTERORPLAYERDIE,  --所有怪物死亡或者玩家死亡
	},

	FixAward = 					--通关完成以后的固定奖励, 暂时不定义，后续添加
	{
	},
}

 DailySceneTable[12] =                --神魔牢笼
{
 DailyID = 12,                --所属日常ID
 DailyType = GYMKHANA_SENZHILEYUAN,
 regionID = 10002,
 MapID   = 116,              --静态地图资源
 Npc ={},                    --NPC 列表
 bornPostion = {36.97816,20.53465},      --玩家出生点

 BatchMonster =              --分批操作刷新的怪物
 {
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = --1
		{
			monsterlist =
			{
				{monsterId = 44701, x = 26.79413, y = 19.80531, refreshTime = 36000000, objectType = 0},
			},
 			BossMonsterID = 44701,	--指定BOSS的怪物ID,Boss怪物死亡后退出场景
			refreshdelaytime = 2, 			--刷新延迟 秒
		},
 },

 LimitContorl =
 {
     --LimitSP = 1,          --体力限制
     LimitTimes = 10,         --次数限制
     OpenTime = 60,          --开启时间分钟
     LimitPlayerLevel = 0,   --玩家等级限制
 },
    
 WinCondition =                  --胜利条件
 {
    winrule = DAILY_SPECIFYMONSTERDIE,      --指定ID怪物死亡
 	MonsterID = 44701,	--指定BOSS的怪物ID
 },

 FixAward =                  --通关完成以后的固定奖励, 暂时不定义，后续添加
 {
 	FixBaseExp = 100,  --固定经验奖励
 	TranExpWeight = 0.2, 	--经验转换率
 },
}

 DailySceneTable[13] = 				--测试(测试怪物)
{
	DailyID = 13,				--所属日常
	DailyType = DAILY_SANGSHITYPE,
	regionID = 10004,
	MapID 	= 114,				--静态地图资源
	Npc ={},					--NPC 列表
	bornPostion = {85.38502,63.12715},		--玩家出生点
	BaseSpendGlod = 10,		--基础消费金币数，付费操作时消耗的实际的金币公式为：BaseSpeedGlod + 10 * 次数

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] =
		{
			monsterlist =
			{
				{monsterId = 31013, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[2] =
		{
			monsterlist =
			{
				{monsterId = 31023, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[3] =
		{
			monsterlist =
			{
				{monsterId = 31033, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[4] =
		{
			monsterlist =
			{
				{monsterId = 31043, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[5] =
		{
			monsterlist =
			{
				{monsterId = 49005, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[6] =
		{
			monsterlist =
			{
				{monsterId = 49006, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[7] =
		{
			monsterlist =
			{
				{monsterId = 49007, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[8] =
		{
			monsterlist =
			{
				{monsterId = 49008, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[9] =
		{
			monsterlist =
			{
				{monsterId = 49009, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[10] =
		{
			monsterlist =
			{
				{monsterId = 49010, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[11] =
		{
			monsterlist =
			{
				{monsterId = 49011, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[12] =
		{
			monsterlist =
			{
				{monsterId = 49012, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[13] =
		{
			monsterlist =
			{
				{monsterId = 49013, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[14] =
		{
			monsterlist =
			{
				{monsterId = 49014, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[15] =
		{
			monsterlist =
			{
				{monsterId = 49015, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[16] =
		{
			monsterlist =
			{
				{monsterId = 49016, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[17] =
		{
			monsterlist =
			{
				{monsterId = 49017, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[18] =
		{
			monsterlist =
			{
				{monsterId = 49018, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[19] =
		{
			monsterlist =
			{
				{monsterId = 49019, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[20] =
		{
			monsterlist =
			{
				{monsterId = 49020, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[21] =
		{
			monsterlist =
			{
				{monsterId = 49021, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[22] =
		{
			monsterlist =
			{
				{monsterId = 49022, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[23] =
		{
			monsterlist =
			{
				{monsterId = 49023, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[24] =
		{
			monsterlist =
			{
				{monsterId = 49024, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[25] =
		{
			monsterlist =
			{
				{monsterId = 49025, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[26] =
		{
			monsterlist =
			{
				{monsterId = 49026, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[27] =
		{
			monsterlist =
			{
				{monsterId = 49027, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[28] =
		{
			monsterlist =
			{
				{monsterId = 49028, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[28] =
		{
			monsterlist =
			{
				{monsterId = 49029, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[29] =
		{
			monsterlist =
			{
				{monsterId = 49030, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[30] =
		{
			monsterlist =
			{
				{monsterId = 49031, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[31] =
		{
			monsterlist =
			{
				{monsterId = 49032, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[32] =
		{
			monsterlist =
			{
				{monsterId = 49032, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[33] =
		{
			monsterlist =
			{
				{monsterId = 49033, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[34] =
		{
			monsterlist =
			{
				{monsterId = 49034, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[35] =
		{
			monsterlist =
			{
				{monsterId = 49035, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[36] =
		{
			monsterlist =
			{
				{monsterId = 49036, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[37] =
		{
			monsterlist =
			{
				{monsterId = 49037, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[38] =
		{
			monsterlist =
			{
				{monsterId = 49038, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[39] =
		{
			monsterlist =
			{
				{monsterId = 49039, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[40] =
		{
			monsterlist =
			{
				{monsterId = 49040, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[41] =
		{
			monsterlist =
			{
				{monsterId = 49041, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[42] =
		{
			monsterlist =
			{
				{monsterId = 49042, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[43] =
		{
			monsterlist =
			{
				{monsterId = 49043, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[44] =
		{
			monsterlist =
			{
				{monsterId = 49044, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[45] =
		{
			monsterlist =
			{
				{monsterId = 49045, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[46] =
		{
			monsterlist =
			{
				{monsterId = 49046, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[47] =
		{
			monsterlist =
			{
				{monsterId = 49047, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[48] =
		{
			monsterlist =
			{
				{monsterId = 49048, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[49] =
		{
			monsterlist =
			{
				{monsterId = 49049, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[50] =
		{
			monsterlist =
			{
				{monsterId = 49050, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[51] =
		{
			monsterlist =
			{
				{monsterId = 49051, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[52] =
		{
			monsterlist =
			{
				{monsterId = 49052, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[53] =
		{
			monsterlist =
			{
				{monsterId = 49053, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[54] =
		{
			monsterlist =
			{
				{monsterId = 49054, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[55] =
		{
			monsterlist =
			{
				{monsterId = 49055, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[56] =
		{
			monsterlist =
			{
				{monsterId = 49056, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[57] =
		{
			monsterlist =
			{
				{monsterId = 49057, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[58] =
		{
			monsterlist =
			{
				{monsterId = 49058, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[59] =
		{
			monsterlist =
			{
				{monsterId = 49059, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[60] =
		{
			monsterlist =
			{
				{monsterId = 49060, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[61] =
		{
			monsterlist =
			{
				{monsterId = 49061, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[62] =
		{
			monsterlist =
			{
				{monsterId = 49062, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[63] =
		{
			monsterlist =
			{
				{monsterId = 49063, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[64] =
		{
			monsterlist =
			{
				{monsterId = 49064, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 33, 			--刷新延迟 秒
		},
		[65] =
		{
			monsterlist =
			{
				{monsterId = 49065, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[66] =
		{
			monsterlist =
			{
				{monsterId = 49066, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[67] =
		{
			monsterlist =
			{
				{monsterId = 49067, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[68] =
		{
			monsterlist =
			{
				{monsterId = 49068, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[69] =
		{
			monsterlist =
			{
				{monsterId = 49069, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[70] =
		{
			monsterlist =
			{
				{monsterId = 49070, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[71] =
		{
			monsterlist =
			{
				{monsterId = 49071, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[72] =
		{
			monsterlist =
			{
				{monsterId = 49072, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[73] =
		{
			monsterlist =
			{
				{monsterId = 49073, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[74] =
		{
			monsterlist =
			{
				{monsterId = 49074, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[75] =
		{
			monsterlist =
			{
				{monsterId = 49075, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[76] =
		{
			monsterlist =
			{
				{monsterId = 49076, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[77] =
		{
			monsterlist =
			{
				{monsterId = 49077, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[78] =
		{
			monsterlist =
			{
				{monsterId = 49078, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[79] =
		{
			monsterlist =
			{
				{monsterId = 49079, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[80] =
		{
			monsterlist =
			{
				{monsterId = 49080, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[81] =
		{
			monsterlist =
			{
				{monsterId = 49081, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[82] =
		{
			monsterlist =
			{
				{monsterId = 49082, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[83] =
		{
			monsterlist =
			{
				{monsterId = 49083, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[84] =
		{
			monsterlist =
			{
				{monsterId = 49084, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[85] =
		{
			monsterlist =
			{
				{monsterId = 49085, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[86] =
		{
			monsterlist =
			{
				{monsterId = 49086, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[87] =
		{
			monsterlist =
			{
				{monsterId = 49087, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[88] =
		{
			monsterlist =
			{
				{monsterId = 49088, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[89] =
		{
			monsterlist =
			{
				{monsterId = 49089, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[90] =
		{
			monsterlist =
			{
				{monsterId = 49090, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[91] =
		{
			monsterlist =
			{
				{monsterId = 49091, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[92] =
		{
			monsterlist =
			{
				{monsterId = 49092, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[93] =
		{
			monsterlist =
			{
				{monsterId = 49093, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[94] =
		{
			monsterlist =
			{
				{monsterId = 49094, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[95] =
		{
			monsterlist =
			{
				{monsterId = 49095, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[96] =
		{
			monsterlist =
			{
				{monsterId = 49096, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[97] =
		{
			monsterlist =
			{
				{monsterId = 49097, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[98] =
		{
			monsterlist =
			{
				{monsterId = 49098, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[99] =
		{
			monsterlist =
			{
				{monsterId = 49099, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[100] =
		{
			monsterlist =
			{
				{monsterId = 49100, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[101] =
		{
			monsterlist =
			{
				{monsterId = 49101, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[102] =
		{
			monsterlist =
			{
				{monsterId = 49102, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[103] =
		{
			monsterlist =
			{
				{monsterId = 49103, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[104] =
		{
			monsterlist =
			{
				{monsterId = 49104, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[105] =
		{
			monsterlist =
			{
				{monsterId = 49105, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[106] =
		{
			monsterlist =
			{
				{monsterId = 49106, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[107] =
		{
			monsterlist =
			{
				{monsterId = 49107, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[108] =
		{
			monsterlist =
			{
				{monsterId = 49108, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[109] =
		{
			monsterlist =
			{
				{monsterId = 49109, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[110] =
		{
			monsterlist =
			{
				{monsterId = 49110, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[111] =
		{
			monsterlist =
			{
				{monsterId = 49111, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[112] =
		{
			monsterlist =
			{
				{monsterId = 49112, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[113] =
		{
			monsterlist =
			{
				{monsterId = 49113, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[114] =
		{
			monsterlist =
			{
				{monsterId = 49114, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[115] =
		{
			monsterlist =
			{
				{monsterId = 49115, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[116] =
		{
			monsterlist =
			{
				{monsterId = 49116, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[117] =
		{
			monsterlist =
			{
				{monsterId = 49117, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[118] =
		{
			monsterlist =
			{
				{monsterId = 49118, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[119] =
		{
			monsterlist =
			{
				{monsterId = 49119, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[120] =
		{
			monsterlist =
			{
				{monsterId = 49120, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[121] =
		{
			monsterlist =
			{
				{monsterId = 49121, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[122] =
		{
			monsterlist =
			{
				{monsterId = 49122, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[123] =
		{
			monsterlist =
			{
				{monsterId = 49123, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[124] =
		{
			monsterlist =
			{
				{monsterId = 49125, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[125] =
		{
			monsterlist =
			{
				{monsterId = 49125, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[126] =
		{
			monsterlist =
			{
				{monsterId = 49126, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[127] =
		{
			monsterlist =
			{
				{monsterId = 49127, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[128] =
		{
			monsterlist =
			{
				{monsterId = 49128, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[129] =
		{
			monsterlist =
			{
				{monsterId = 49129, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[130] =
		{
			monsterlist =
			{
				{monsterId = 49130, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[131] =
		{
			monsterlist =
			{
				{monsterId = 49131, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[132] =
		{
			monsterlist =
			{
				{monsterId = 49132, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
		[133] =
		{
			monsterlist =
			{
				{monsterId = 49133, x = 84.58377, y = 45.37882, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 3, 			--刷新延迟 秒
		},
	},

	LimitContorl =
	{
		--LimitSP = 1,			--体力限制
		LimitTimes = 1,			--次数限制
		OpenTime = 400,			--开启时间分钟
		LimitPlayerLevel = 0,	--玩家等级限制
	},
	
	WinCondition = 					--胜利条件
	{
		winrule = DAILY_ALLMONSTERORPLAYERDIE,  --所有怪物死亡或者玩家死亡
	},

	FixAward = 					--通关完成以后的固定奖励, 暂时不定义，后续添加
	{
	},
}





--下面的为信仰新增功能，不用于日常活动中，注意这个ID必须和前面的不连续
XingYangSceneStartIndex = 200

 DailySceneTable[201] = 				--信仰主神1挑战
{
	DailyID = 201,				--所属日常ID
	DailyType = XINYANG_FIGHTTYPE,
	regionID = 11001,
	MapID 	= 114,				--静态地图资源
	Npc ={},					--NPC 列表
	bornPostion = {85.38502,63.12715},		--玩家出生点
	BaseSpendGlod = 0,		--基础消费金币数，付费操作时消耗的实际的金币公式为：BaseSpeedGlod + 10 * 次数，信仰没有付费进入功能

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
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
			BossMonsterID = 31013,	--指定BOSS的怪物ID,Boss怪物死亡后退出场景
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
	},

	LimitContorl =
	{
		LimitTimes = 1,			--次数限制
		OpenTime = 30,			--开启时间分钟
		LimitPlayerLevel = 0,	--玩家等级限制
	},
	
	WinCondition = 					--胜利条件
	{
		winrule = DAILY_SPECIFYMONSTERDIE,		--指定ID怪物死亡
	},

	FixAward = 					--通关完成以后的固定奖励, 暂时不定义，后续添加
	{
	},
}
 DailySceneTable[202] = 				--信仰主神2挑战
{
	DailyID = 202,				--所属日常ID
	DailyType = XINYANG_FIGHTTYPE,
	regionID = 11002,
	MapID 	= 114,				--静态地图资源
	Npc ={},					--NPC 列表
	bornPostion = {85.38502,63.12715},		--玩家出生点
	BaseSpendGlod = 0,		--基础消费金币数，付费操作时消耗的实际的金币公式为：BaseSpeedGlod + 10 * 次数，信仰没有付费进入功能

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
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
			BossMonsterID = 31023,	--指定BOSS的怪物ID,Boss怪物死亡后退出场景
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
	},

	LimitContorl =
	{
		LimitTimes = 1,			--次数限制
		OpenTime = 30,			--开启时间分钟
		LimitPlayerLevel = 0,	--玩家等级限制
	},
	
	WinCondition = 					--胜利条件
	{
		winrule = DAILY_SPECIFYMONSTERDIE,		--指定ID怪物死亡
	},

	FixAward = 					--通关完成以后的固定奖励, 暂时不定义，后续添加
	{
	},
}
 DailySceneTable[203] = 				--信仰主神3挑战
{
	DailyID = 203,				--所属日常ID
	DailyType = XINYANG_FIGHTTYPE,
	regionID = 11003,
	MapID 	= 114,				--静态地图资源
	Npc ={},					--NPC 列表
	bornPostion = {85.38502,63.12715},		--玩家出生点
	BaseSpendGlod = 10,		--基础消费金币数，付费操作时消耗的实际的金币公式为：BaseSpeedGlod + 10 * 次数

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
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
			BossMonsterID = 31033,	--指定BOSS的怪物ID,Boss怪物死亡后退出场景
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
	},

	LimitContorl =
	{
		LimitTimes = 1,			--次数限制
		OpenTime = 30,			--开启时间分钟
		LimitPlayerLevel = 0,	--玩家等级限制
	},
	
	WinCondition = 					--胜利条件
	{
		winrule = DAILY_SPECIFYMONSTERDIE,		--指定ID怪物死亡
	},

	FixAward = 					--通关完成以后的固定奖励, 暂时不定义，后续添加
	{
	},
}
 DailySceneTable[204] = 				--信仰主神4挑战
{
	DailyID = 204,				--所属日常ID
	DailyType = XINYANG_FIGHTTYPE,
	regionID = 11004,
	MapID 	= 114,				--静态地图资源
	Npc ={},					--NPC 列表
	bornPostion = {85.38502,63.12715},		--玩家出生点
	BaseSpendGlod = 0,		--基础消费金币数，付费操作时消耗的实际的金币公式为：BaseSpeedGlod + 10 * 次数，信仰没有付费进入功能

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
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
			BossMonsterID = 31043,	--指定BOSS的怪物ID,Boss怪物死亡后退出场景
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
	},

	LimitContorl =
	{
		LimitTimes = 1,			--次数限制
		OpenTime = 30,			--开启时间分钟
		LimitPlayerLevel = 0,	--玩家等级限制
	},
	
	WinCondition = 					--胜利条件
	{
		winrule = DAILY_SPECIFYMONSTERDIE,		--指定ID怪物死亡
	},

	FixAward = 					--通关完成以后的固定奖励, 暂时不定义，后续添加
	{
	},
}
 DailySceneTable[205] = 				--信仰主神5挑战
{
	DailyID = 205,				--所属日常ID
	DailyType = XINYANG_FIGHTTYPE,
	regionID = 11005,
	MapID 	= 114,				--静态地图资源
	Npc ={},					--NPC 列表
	bornPostion = {85.38502,63.12715},		--玩家出生点
	BaseSpendGlod = 0,		--基础消费金币数，付费操作时消耗的实际的金币公式为：BaseSpeedGlod + 10 * 次数，信仰没有付费进入功能

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
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
			BossMonsterID = 31053,	--指定BOSS的怪物ID,Boss怪物死亡后退出场景
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
	},

	LimitContorl =
	{
		LimitTimes = 1,			--次数限制
		OpenTime = 30,			--开启时间分钟
		LimitPlayerLevel = 0,	--玩家等级限制
	},
	
	WinCondition = 					--胜利条件
	{
		winrule = DAILY_SPECIFYMONSTERDIE,		--指定ID怪物死亡
	},

	FixAward = 					--通关完成以后的固定奖励, 暂时不定义，后续添加
	{
	},
}
 DailySceneTable[206] = 				--信仰主神6挑战
{
	DailyID = 206,				--所属日常ID
	DailyType = XINYANG_FIGHTTYPE,
	regionID = 11006,
	MapID 	= 114,				--静态地图资源
	Npc ={},					--NPC 列表
	bornPostion = {85.38502,63.12715},		--玩家出生点
	BaseSpendGlod = 0,		--基础消费金币数，付费操作时消耗的实际的金币公式为：BaseSpeedGlod + 10 * 次数，信仰没有付费进入功能

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
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
			BossMonsterID = 31063,	--指定BOSS的怪物ID,Boss怪物死亡后退出场景
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
	},
	
	LimitContorl =
	{
		LimitTimes = 1,			--次数限制
		OpenTime = 30,			--开启时间分钟
		LimitPlayerLevel = 0,	--玩家等级限制
	},
	
	WinCondition = 					--胜利条件
	{
		winrule = DAILY_SPECIFYMONSTERDIE,		--指定ID怪物死亡
	},

	FixAward = 					--通关完成以后的固定奖励, 暂时不定义，后续添加
	{
	},
}
 DailySceneTable[207] = 				--信仰主神7挑战
{
	DailyID = 207,				--所属日常ID
	DailyType = XINYANG_FIGHTTYPE,
	regionID = 11007,
	MapID 	= 114,				--静态地图资源
	Npc ={},					--NPC 列表
	bornPostion = {85.38502,63.12715},		--玩家出生点
	BaseSpendGlod = 0,		--基础消费金币数，付费操作时消耗的实际的金币公式为：BaseSpeedGlod + 10 * 次数，信仰没有付费进入功能

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
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
			BossMonsterID = 31073,	--指定BOSS的怪物ID,Boss怪物死亡后退出场景
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
	},

	LimitContorl =
	{
		LimitTimes = 1,			--次数限制
		OpenTime = 30,			--开启时间分钟
		LimitPlayerLevel = 0,	--玩家等级限制
	},
	
	WinCondition = 					--胜利条件
	{
		winrule = DAILY_SPECIFYMONSTERDIE,		--指定ID怪物死亡
	},

	FixAward = 					--通关完成以后的固定奖励, 暂时不定义，后续添加
	{
	},
}
 DailySceneTable[208] = 				--信仰主神8挑战
{
	DailyID = 208,				--所属日常ID
	DailyType = XINYANG_FIGHTTYPE,
	regionID = 11008,
	MapID 	= 114,				--静态地图资源
	Npc ={},					--NPC 列表
	bornPostion = {85.38502,63.12715},		--玩家出生点
	BaseSpendGlod = 0,		--基础消费金币数，付费操作时消耗的实际的金币公式为：BaseSpeedGlod + 10 * 次数，信仰没有付费进入功能

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
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
			BossMonsterID = 31083,	--指定BOSS的怪物ID,Boss怪物死亡后退出场景
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
	},

	LimitContorl =
	{
		LimitTimes = 1,			--次数限制
		OpenTime = 30,			--开启时间分钟
		LimitPlayerLevel = 0,	--玩家等级限制
	},
	
	WinCondition = 					--胜利条件
	{
		winrule = DAILY_SPECIFYMONSTERDIE,		--指定ID怪物死亡
	},

	FixAward = 					--通关完成以后的固定奖励, 暂时不定义，后续添加
	{
	},
}
 DailySceneTable[209] = 				--信仰主神9挑战
{
	DailyID = 209,				--所属日常ID
	DailyType = XINYANG_FIGHTTYPE,
	regionID = 11009,
	MapID 	= 114,				--静态地图资源
	Npc ={},					--NPC 列表
	bornPostion = {85.38502,63.12715},		--玩家出生点
	BaseSpendGlod = 0,		--基础消费金币数，付费操作时消耗的实际的金币公式为：BaseSpeedGlod + 10 * 次数，信仰没有付费进入功能

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
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
			BossMonsterID = 31093,	--指定BOSS的怪物ID,Boss怪物死亡后退出场景
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
	},

	LimitContorl =
	{
		LimitTimes = 1,			--次数限制
		OpenTime = 30,			--开启时间分钟
		LimitPlayerLevel = 0,	--玩家等级限制
	},
	
	WinCondition = 					--胜利条件
	{
		winrule = DAILY_SPECIFYMONSTERDIE,		--指定ID怪物死亡
	},

	FixAward = 					--通关完成以后的固定奖励, 暂时不定义，后续添加
	{
	},
}
 DailySceneTable[210] = 				--信仰主神10挑战
{
	DailyID = 210,				--所属日常ID
	DailyType = XINYANG_FIGHTTYPE,
	regionID = 11010,
	MapID 	= 114,				--静态地图资源
	Npc ={},					--NPC 列表
	bornPostion = {85.38502,63.12715},		--玩家出生点
	BaseSpendGlod = 0,		--基础消费金币数，付费操作时消耗的实际的金币公式为：BaseSpeedGlod + 10 * 次数，信仰没有付费进入功能

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
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
			BossMonsterID = 31103,	--指定BOSS的怪物ID,Boss怪物死亡后退出场景
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
	},

	LimitContorl =
	{
		LimitTimes = 1,			--次数限制
		OpenTime = 30,			--开启时间分钟
		LimitPlayerLevel = 0,	--玩家等级限制
	},
	
	WinCondition = 					--胜利条件
	{
		winrule = DAILY_SPECIFYMONSTERDIE,		--指定ID怪物死亡
	},

	FixAward = 					--通关完成以后的固定奖励, 暂时不定义，后续添加
	{
	},
}
 DailySceneTable[211] = 				--信仰主神11挑战
{
	DailyID = 211,				--所属日常ID
	DailyType = XINYANG_FIGHTTYPE,
	regionID = 11011,
	MapID 	= 114,				--静态地图资源
	Npc ={},					--NPC 列表
	bornPostion = {85.38502,63.12715},		--玩家出生点
	BaseSpendGlod = 0,		--基础消费金币数，付费操作时消耗的实际的金币公式为：BaseSpeedGlod + 10 * 次数，信仰没有付费进入功能

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
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
			BossMonsterID = 31113,	--指定BOSS的怪物ID,Boss怪物死亡后退出场景
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
	},

	LimitContorl =
	{
		LimitTimes = 1,			--次数限制
		OpenTime = 30,			--开启时间分钟
		LimitPlayerLevel = 0,	--玩家等级限制
	},
	
	WinCondition = 					--胜利条件
	{
		winrule = DAILY_SPECIFYMONSTERDIE,		--指定ID怪物死亡
	},

	FixAward = 					--通关完成以后的固定奖励, 暂时不定义，后续添加
	{
	},
}
 DailySceneTable[212] = 				--信仰主神12挑战
{
	DailyID = 212,				--所属日常ID
	DailyType = XINYANG_FIGHTTYPE,
	regionID = 11012,
	MapID 	= 114,				--静态地图资源
	Npc ={},					--NPC 列表
	bornPostion = {85.38502,63.12715},		--玩家出生点
	BaseSpendGlod = 0,		--基础消费金币数，付费操作时消耗的实际的金币公式为：BaseSpeedGlod + 10 * 次数，信仰没有付费进入功能

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
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
			BossMonsterID = 31123,	--指定BOSS的怪物ID,Boss怪物死亡后退出场景
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
	},

	LimitContorl =
	{
		LimitTimes = 1,			--次数限制
		OpenTime = 30,			--开启时间分钟
		LimitPlayerLevel = 0,	--玩家等级限制
	},
	
	WinCondition = 					--胜利条件
	{
		winrule = DAILY_SPECIFYMONSTERDIE,		--指定ID怪物死亡
	},

	FixAward = 					--通关完成以后的固定奖励, 暂时不定义，后续添加
	{
	},
}
