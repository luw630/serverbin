--SceneMapTable = {1,2,3,4,5}		--章节列表
SceneMapTable = {}
SceneMapTable[1] = {}	--每个章节对应关卡列表 第一章
SceneMapTable[2] = {}	--每个章节对应关卡列表 第二章
silvercost = {1000,2000,3000}   --银币花费
godcost = {100,200,300}   --银币花费
relivetime = 60 				--玩家死亡后复活时间秒
SceneIndexNum = {284,10,10,10,10} --每个章节对应的关卡数量
Postionamend = 3.125   --坐标修正
SDgodcost = 1  --单次扫荡花费金币
   
   
SceneMapTable[1][1] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 103,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {43.92,32.17},		--玩家出生点
	relivePostion = {43.92,32.17},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2
	SDCompleteTask = {4,5},		--扫荡以后直接完成的关卡

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		bornType = REFRSHTYPE_REGIONRANDOM,  --出生类型为随机和普通
		[1] = --1
		{
			monsterlist = 
			{
				{monsterId = 10021, x = 81.97648, y = 42.9591, refreshTime = 36000000, objectType = 0},
				{monsterId = 10021, x = 85.56709, y = 42.5749, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {nil,1},		--奖励道具ID，数量
		exp = expreward[1].exp,
		money = expreward[1].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = All_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 0,						--死亡怪物ID
	},

	winStar = {60,150,240},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[1],
		exp = expreward[1],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


 SceneMapTable[1][2] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 123,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {87.01867,53.43437},		--玩家出生点
	relivePostion = {87.01867,53.43437},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2
	SDCompleteTask = {4,5},		--扫荡以后直接完成的关卡

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		bornType = REFRSHTYPE_REGIONRANDOM,  --出生类型为随机和普通
		[1] = --1
		{
			monsterlist = 
			{
				{monsterId = 10021, x = 103.6115, y = 53.4692, refreshTime = 36000000, objectType = 0},
				{monsterId = 10021, x = 113.3956, y = 53.86975, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
		[2] =  --2
		{
			monsterlist = 
			{
				{monsterId = 10021, x = 125.9001, y = 51.93453, refreshTime = 36000000, objectType = 0},
				{monsterId = 10021, x = 137.7568, y = 52.1162, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190103,1,190104,1},		--奖励道具ID，数量
		exp = expreward[2].exp,
		money = expreward[2].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = All_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 0,						--死亡怪物ID
	},

	winStar = {950,955,960},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[2],
		exp = expreward[2],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


 SceneMapTable[1][3] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 123,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {139.0481,135.6774},		--玩家出生点
	relivePostion = {139.0481,135.6774},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2
	SDCompleteTask = {4,5},		--扫荡以后直接完成的关卡

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		bornType = REFRSHTYPE_REGIONRANDOM,  --出生类型为随机和普通
		[1] = --1
		{
			monsterlist = 
			{
				{monsterId = 10032, x = 111.287, y = 113.2435, refreshTime = 36000000, objectType = 0},	
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190103,1,190104,1},		--奖励道具ID，数量
		exp = expreward[3].exp,
		money = expreward[3].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10031,						--死亡怪物ID
	},

	winStar = {60,150,240},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[3],
		exp = expreward[3],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


 SceneMapTable[1][4] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 123,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},
	bornPostion = {86.27573,116.2326},		--玩家出生点
	relivePostion = {86.27573,116.2326},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2
	SDCompleteTask = {4,5},		--扫荡以后直接完成的关卡

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		bornType = REFRSHTYPE_REGIONRANDOM,  --出生类型为随机和普通
		[1] = --1
		{
			monsterlist = 
			{
				{monsterId = 10041, x = 77.54218, y = 130.0171, refreshTime = 36000000, objectType = 0},
				{monsterId = 10041, x = 75.62062, y = 124.7871, refreshTime = 36000000, objectType = 0},
				{monsterId = 10041, x = 73.03693, y = 132.2052, refreshTime = 36000000, objectType = 0},
				{monsterId = 10041, x = 69.72678, y = 124.0472, refreshTime = 36000000, objectType = 0},
				{monsterId = 10042, x = 65.38358, y = 132.5965, refreshTime = 36000000, objectType = 0},
				{monsterId = 10042, x = 64.68175, y = 120.0839, refreshTime = 36000000, objectType = 0},
				{monsterId = 10042, x = 59.69745, y = 118.7998, refreshTime = 36000000, objectType = 0},
				{monsterId = 10043, x = 59.79701, y = 132.7007, refreshTime = 36000000, objectType = 0},
				{imageID = 10007, x = 59.28457, y = 107.4401, dir = 0,clickScript = 20001,LiveTime = 36000000, objectType = 1,name = "吸血鬼女萝莉"},
				{imageID = 10008, x = 59.03128, y = 104.3095, dir = 0,clickScript = 20001,LiveTime = 36000000, objectType = 1,name = "狼人老头"},
				{imageID = 10009, x = 59.08077, y = 101.4075, dir = 0,clickScript = 20001,LiveTime = 36000000, objectType = 1,name = "指挥官哈娜"},
				{imageID = 10003, x = 58.9196, y = 99.34762, dir = 0,clickScript = 20001,LiveTime = 36000000, objectType = 1,name = "沙漠商人"},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190103,1,190104,1},		--奖励道具ID，数量
		exp = expreward[4].exp,
		money = expreward[4].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10043,						--死亡怪物ID
	},

	winStar = {60,150,240},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[4],
		exp = expreward[4],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


 SceneMapTable[1][5] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 123,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {99.41126,79.5308},		--玩家出生点
	relivePostion = {99.41126,79.5308},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2
	SDCompleteTask = {4,5},		--扫荡以后直接完成的关卡

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		bornType = REFRSHTYPE_REGIONRANDOM,  --出生类型为随机和普通
		[1] =  --1
		{
			monsterlist = 
			{
				{monsterId = 10051, x = 96.16433, y = 57.12049, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10051, x = 90.35139, y = 58.22841, refreshTime = 36000000, objectType = 0},
				{monsterId = 10051, x = 90.68875, y = 54.38464, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10051, x = 91.13158, y = 49.45491, refreshTime = 36000000, objectType = 0},
				{monsterId = 10051, x = 84.71407, y = 56.64031, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10051, x = 84.77489, y = 51.70161, refreshTime = 36000000, objectType = 0},
				{monsterId = 10053, x = 81.95225, y = 46.64512, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10053, x = 86.33607, y = 46.93468, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
		[2] =  --1
		{
			monsterlist = 
			{
				{monsterId = 10052, x = 78.31734, y = 29.18635, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10052, x = 70.44109, y = 26.75388, refreshTime = 36000000, objectType = 0},
				{monsterId = 10053, x = 64.5069, y = 17.82268, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
		[3] =  --2
		{
			monsterlist = 
			{
				{monsterId = 10051, x = 47.46403, y = 22.37688, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10051, x = 42.51604, y = 23.23724, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10052, x = 43.83917, y = 28.79734, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10053, x = 37.54342, y = 24.82876, refreshTime = 36000000, objectType = 0},
				{monsterId = 10054, x = 37.39591, y = 17.97508, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190103,1,190104,1},		--奖励道具ID，数量
		exp = expreward[5].exp,
		money = expreward[5].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10054,						--死亡怪物ID
	},

	winStar = {60,150,240},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[5],
		exp = expreward[5],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][6] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 123,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {38.41925,48.73589},		--玩家出生点
	relivePostion = {38.41925,48.73589},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		bornType = REFRSHTYPE_REGIONRANDOM,  --出生类型为随机和普通
		[1] =  --1
		{
			monsterlist = 
			{
				{monsterId = 10062, x = 38.5386, y = 60.44372, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10062, x = 42.58729, y = 61.07529, refreshTime = 36000000, objectType = 0},
				{monsterId = 10061, x = 38.82864, y = 68.00821, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10061, x = 44.56532, y = 67.85877, refreshTime = 36000000, objectType = 0},	
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10062, x = 47.64617, y = 62.89978, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10062, x = 52.12071, y = 63.55585, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10062, x = 50.79211, y = 68.00338, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10062, x = 48.22482, y = 71.82616, refreshTime = 36000000, objectType = 0},
				{monsterId = 10063, x = 53.63076, y = 71.69569, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10063, x = 55.3225, y = 66.53972, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10061, x = 31.50069, y = 78.39317, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10061, x = 35.44442, y = 82.05552, refreshTime = 36000000, objectType = 0},
				{monsterId = 10062, x = 35.45538, y = 84.77285, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10062, x = 32.04609, y = 84.67823, refreshTime = 36000000, objectType = 0},
				{monsterId = 10063, x = 28.52033, y = 86.53426, refreshTime = 36000000, objectType = 0},					
				{monsterId = 10063, x = 28.0975, y = 82.29877, refreshTime = 36000000, objectType = 0},	
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},	
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10062, x = 49.99494, y = 87.10905, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10062, x = 49.52737, y = 94.40212, refreshTime = 36000000, objectType = 0},
				{monsterId = 10062, x = 52.53206, y = 94.09865, refreshTime = 36000000, objectType = 0},
				{monsterId = 10062, x = 53.35759, y = 86.78279, refreshTime = 36000000, objectType = 0},
				{monsterId = 10062, x = 56.41282, y = 86.36091, refreshTime = 36000000, objectType = 0},
				{monsterId = 10062, x = 55.99706, y = 94.18155, refreshTime = 36000000, objectType = 0},
				{monsterId = 10063, x = 60.5684, y = 85.93704, refreshTime = 36000000, objectType = 0},
				{monsterId = 10063, x = 60.6495, y = 94.33706, refreshTime = 36000000, objectType = 0},					
				{monsterId = 10064, x = 54.38146, y = 90.70732, refreshTime = 36000000, objectType = 0},	
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},	
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190103,1,190104,1},		--奖励道具ID，数量
		exp = expreward[6].exp,
		money = expreward[6].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10064,						--死亡怪物ID
	},

	winStar = {80,170,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[6],
		exp = expreward[6],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][7] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 109,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {60.45267,25.91973},		--玩家出生点
	relivePostion = {60.45267,25.91973},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		bornType = REFRSHTYPE_REGIONRANDOM,  --出生类型为随机和普通
		[1] =  --1
		{
			monsterlist = 
			{
				{monsterId = 10071, x = 49.97138, y = 27.28843, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10071, x = 46.71812, y = 29.99935, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10071, x = 46.41975, y = 26.52561, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10071, x = 44.08429, y = 22.2791, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10072, x = 41.45268, y = 27.33116, refreshTime = 36000000, objectType = 0},	
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10071, x = 36.80903, y = 22.49797, refreshTime = 36000000, objectType = 0},
				{monsterId = 10071, x = 33.05435, y = 20.35208, refreshTime = 36000000, objectType = 0},
				{monsterId = 10071, x = 30.53385, y = 21.29007, refreshTime = 36000000, objectType = 0},
				{monsterId = 10071, x = 27.43793, y = 20.65198, refreshTime = 36000000, objectType = 0},
				{monsterId = 10072, x = 25.45274, y = 18.76385, refreshTime = 36000000, objectType = 0},
				{monsterId = 10072, x = 23.5159, y = 21.73567, refreshTime = 36000000, objectType = 0},
				{monsterId = 10072, x = 18.91192, y = 23.23901, refreshTime = 36000000, objectType = 0},
				{monsterId = 10072, x = 19.56562, y = 19.95498, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 15, 				--随机最大半径
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10073, x = 21.93331, y = 33.06587, refreshTime = 36000000, objectType = 0},
				{monsterId = 10072, x = 20.4353, y = 30.08672, refreshTime = 36000000, objectType = 0},
				{monsterId = 10072, x = 18.17234, y = 31.84139, refreshTime = 36000000, objectType = 0},
				{monsterId = 10072, x = 19.36602, y = 35.40491, refreshTime = 36000000, objectType = 0},
				{monsterId = 10071, x = 25.24074, y = 35.28839, refreshTime = 36000000, objectType = 0},
				{monsterId = 10071, x = 26.35111, y = 32.93321, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},	
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190103,1,190104,1},		--奖励道具ID，数量
		exp = expreward[7].exp,
		money = expreward[7].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10073,						--死亡怪物ID
	},

	winStar = {60,150,240},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[7],
		exp = expreward[7],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


 SceneMapTable[1][8] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 109,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {31.94204,20.84713},		--玩家出生点
	relivePostion = {31.94204,20.84713},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		bornType = REFRSHTYPE_REGIONRANDOM,  --出生类型为随机和普通
		[1] =  --1
		{
			monsterlist = 
			{
				{monsterId = 10081, x = 43.28428, y = 27.05556, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10081, x = 47.03208, y = 23.59532, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10081, x = 48.29012, y = 27.90702, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10081, x = 45.95739, y = 31.36889, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10082, x = 51.05785, y = 30.66531, refreshTime = 36000000, objectType = 0},	
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10081, x = 58.01339, y = 44.45567, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10082, x = 52.90921, y = 44.23235, refreshTime = 36000000, objectType = 0},
				{monsterId = 10082, x = 55.1471, y = 49.06413, refreshTime = 36000000, objectType = 0},
				{monsterId = 10082, x = 57.99546, y = 50.51515, refreshTime = 36000000, objectType = 0},
				{monsterId = 10081, x = 54.47236, y = 54.53718, refreshTime = 36000000, objectType = 0},
				{monsterId = 10082, x = 52.04014, y = 52.89193, refreshTime = 36000000, objectType = 0},
				{monsterId = 10082, x = 50.08386, y = 48.3211, refreshTime = 36000000, objectType = 0},
				{monsterId = 10081, x = 45.98222, y = 47.11317, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10083, x = 28.83065, y = 63.20005, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10082, x = 31.731, y = 65.43246, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10082, x = 30.53917, y = 54.76189, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10082, x = 35.26381, y = 59.82852, refreshTime = 36000000, objectType = 0},
				{monsterId = 10081, x = 26.02443, y = 67.03706, refreshTime = 36000000, objectType = 0},
				{monsterId = 10081, x = 22.26503, y = 62.12851, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10081, x = 23.88666, y = 57.34204, refreshTime = 36000000, objectType = 0},	
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},	
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190103,1,190104,1},		--奖励道具ID，数量
		exp = expreward[8].exp,
		money = expreward[8].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10083,						--死亡怪物ID
	},

	winStar = {60,150,240},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[8],
		exp = expreward[8],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


 SceneMapTable[1][9] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 109,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {82.40326,55.23898},		--玩家出生点
	relivePostion = {82.40326,55.23898},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		bornType = REFRSHTYPE_REGIONRANDOM,  --出生类型为随机和普通
		[1] =  --1
		{
			monsterlist = 
			{
				{monsterId = 10091, x = 82.05753, y = 41.01767, refreshTime = 36000000, objectType = 0},
				{monsterId = 10091, x = 82.59702, y = 38.2053, refreshTime = 36000000, objectType = 0},
				{monsterId = 10091, x = 79.45635, y = 36.76147, refreshTime = 36000000, objectType = 0},
				{monsterId = 10092, x = 78.83047, y = 33.51482, refreshTime = 36000000, objectType = 0},
				{monsterId = 10092, x = 83.84806, y = 35.13972, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10091, x = 76.90717, y = 28.31224, refreshTime = 36000000, objectType = 0},
				{monsterId = 10092, x = 80.03484, y = 26.65342, refreshTime = 36000000, objectType = 0},
				{monsterId = 10092, x = 78.11495, y = 24.42556, refreshTime = 36000000, objectType = 0},
				{monsterId = 10092, x = 81.28625, y = 22.60888, refreshTime = 36000000, objectType = 0},
				{monsterId = 10092, x = 84.09008, y = 22.56498, refreshTime = 36000000, objectType = 0},
				{monsterId = 10092, x = 80.56309, y = 19.25348, refreshTime = 36000000, objectType = 0},
				{monsterId = 10091, x = 77.225, y = 18.92957, refreshTime = 36000000, objectType = 0},
				{monsterId = 10091, x = 75.02925, y = 23.11224, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10093, x = 50.46112, y = 25.42735, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10092, x = 52.7746, y = 27.91743, refreshTime = 36000000, objectType = 0},		
				{monsterId = 10092, x = 53.64572, y = 22.87211, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10092, x = 50.48587, y = 20.29333, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10091, x = 47.75934, y = 23.30287, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10091, x = 48.01249, y = 27.76741, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10091, x = 49.5868, y = 30.92824, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},		
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190103,1,190104,1},		--奖励道具ID，数量
		exp = expreward[9].exp,
		money = expreward[9].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10093,						--死亡怪物ID
	},

	winStar = {60,150,240},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[9],
		exp = expreward[9],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


 SceneMapTable[1][10] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 109,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {22.27617,32.36597},		--玩家出生点
	relivePostion = {22.27617,32.36597},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		bornType = REFRSHTYPE_REGIONRANDOM,  --出生类型为随机和普通
		[1] =  --1
		{
			monsterlist = 
			{
				{monsterId = 10101, x = 21.64318, y = 21.20144, refreshTime = 36000000, objectType = 0},
				{monsterId = 10101, x = 25.39557, y = 19.26092, refreshTime = 36000000, objectType = 0},
				{monsterId = 10101, x = 31.50875, y = 20.34839, refreshTime = 36000000, objectType = 0},
				{monsterId = 10102, x = 35.31036, y = 19.16877, refreshTime = 36000000, objectType = 0},
				{monsterId = 10102, x = 35.40542, y = 23.10139, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10102, x = 47.64506, y = 22.20532, refreshTime = 36000000, objectType = 0},
				{monsterId = 10102, x = 46.57767, y = 31.27704, refreshTime = 36000000, objectType = 0},
				{monsterId = 10102, x = 52.12543, y = 23.80341, refreshTime = 36000000, objectType = 0},
				{monsterId = 10102, x = 50.88158, y = 30.21653, refreshTime = 36000000, objectType = 0},
				{monsterId = 10102, x = 54.68763, y = 27.15842, refreshTime = 36000000, objectType = 0},
				{monsterId = 10101, x = 57.26283, y = 25.43764, refreshTime = 36000000, objectType = 0},
				{monsterId = 10101, x = 62.19444, y = 25.21916, refreshTime = 36000000, objectType = 0},
				{monsterId = 10101, x = 61.32117, y = 29.09837, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10103, x = 80.60918, y = 24.62065, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10102, x = 76.40041, y = 21.00798, refreshTime = 36000000, objectType = 0},
				{monsterId = 10102, x = 76.22015, y = 26.96304, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10102, x = 81.87284, y = 20.60766, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10101, x = 85.33315, y = 23.41854, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10101, x = 85.37601, y = 26.31938, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10101, x = 80.72277, y = 28.64974, refreshTime = 36000000, objectType = 0},	
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190103,1,190104,1},		--奖励道具ID，数量
		exp = expreward[10].exp,
		money = expreward[10].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10103,						--死亡怪物ID
	},

	winStar = {60,150,240},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[10],
		exp = expreward[10],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


 SceneMapTable[1][11] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 114,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {52.2743,11.30401},		--玩家出生点
	relivePostion = {52.2743,11.30401},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		bornType = REFRSHTYPE_REGIONRANDOM,  --出生类型为随机和普通
		[1] =  --1
		{
			monsterlist = 
			{
				{monsterId = 10111, x = 53.9743, y = 36.30584, refreshTime = 36000000, objectType = 0},
				{monsterId = 10111, x = 47.55936, y = 37.87616, refreshTime = 36000000, objectType = 0},
				{monsterId = 10111, x = 53.52531, y = 40.95852, refreshTime = 36000000, objectType = 0},
				{monsterId = 10112, x = 50.48473, y = 43.3821, refreshTime = 36000000, objectType = 0},
				{monsterId = 10112, x = 46.82327, y = 44.50361, refreshTime = 36000000, objectType = 0},
				{monsterId = 10111, x = 55.69624, y = 46.48324, refreshTime = 36000000, objectType = 0},
				{monsterId = 10112, x = 53.05161, y = 49.9978, refreshTime = 36000000, objectType = 0},
				{monsterId = 10112, x = 48.66869, y = 51.16991, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 8, 				--随机最大半径
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10111, x = 57.35236, y = 57.25671, refreshTime = 36000000, objectType = 0},
				{monsterId = 10111, x = 58.08535, y = 60.11874, refreshTime = 36000000, objectType = 0},
				{monsterId = 10111, x = 54.47131, y = 61.28855, refreshTime = 36000000, objectType = 0},
				{monsterId = 10111, x = 53.55385, y = 58.15086, refreshTime = 36000000, objectType = 0},
				{monsterId = 10112, x = 51.03338, y = 59.76363, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 8, 				--随机最大半径
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10113, x = 52.40873, y = 90.33447, refreshTime = 36000000, objectType = 0},
				{monsterId = 10112, x = 59.75172, y = 85.95741, refreshTime = 36000000, objectType = 0},
				{monsterId = 10112, x = 53.28043, y = 81.06099, refreshTime = 36000000, objectType = 0},
				{monsterId = 10112, x = 58.19921, y = 89.0032, refreshTime = 36000000, objectType = 0},
				{monsterId = 10112, x = 51.21487, y = 83.52579, refreshTime = 36000000, objectType = 0},
				{monsterId = 10111, x = 56.43406, y = 92.96594, refreshTime = 36000000, objectType = 0},
				{monsterId = 10111, x = 48.22015, y = 87.07592, refreshTime = 36000000, objectType = 0},
				{monsterId = 10111, x = 54.73306, y = 86.67927, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 8, 				--随机最大半径
		},					
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190103,1,190104,1},		--奖励道具ID，数量
		exp = expreward[11].exp,
		money = expreward[11].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10113,						--死亡怪物ID
	},

	winStar = {60,150,240},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[11],
		exp = expreward[11],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}

 SceneMapTable[1][12] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 105,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {34.37405,20.34959},		--玩家出生点
	relivePostion = {34.37405,20.34959},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		bornType = REFRSHTYPE_REGIONRANDOM,  --出生类型为随机和普通
		[1] =  --1
		{
			monsterlist = 
			{
				{monsterId = 10121, x = 41.21712, y = 29.05955, refreshTime = 36000000, objectType = 0},
				{monsterId = 10121, x = 43.16673, y = 31.61684, refreshTime = 36000000, objectType = 0},
				{monsterId = 10121, x = 45.44984, y = 34.79826, refreshTime = 36000000, objectType = 0},
				{monsterId = 10122, x = 41.98527, y = 36.10582, refreshTime = 36000000, objectType = 0},
				{monsterId = 10122, x = 48.42226, y = 38.48707, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1}, 				--怪物数量
			randradius = 15, 				--随机最大半径
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10121, x = 57.87367, y = 37.57162, refreshTime = 36000000, objectType = 0},
				{monsterId = 10121, x = 58.03096, y = 40.97002, refreshTime = 36000000, objectType = 0},
				{monsterId = 10121, x = 60.47504, y = 33.8386, refreshTime = 36000000, objectType = 0},
				{monsterId = 10121, x = 63.47765, y = 33.94801, refreshTime = 36000000, objectType = 0},
				{monsterId = 10121, x = 65.99379, y = 35.42297, refreshTime = 36000000, objectType = 0},
				{monsterId = 10122, x = 68.18255, y = 39.45384, refreshTime = 36000000, objectType = 0},
				{monsterId = 10122, x = 65.68159, y = 42.62777, refreshTime = 36000000, objectType = 0},
				{monsterId = 10122, x = 60.97249, y = 43.54142, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 15, 				--随机最大半径
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10123, x = 62.34035, y = 14.33479, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10122, x = 59.57882, y = 17.8677, refreshTime = 36000000, objectType = 0},
				{monsterId = 10122, x = 64.03936, y = 17.82562, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10122, x = 67.28419, y = 15.02525, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10121, x = 68.20172, y = 10.01305, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10121, x = 60.50606, y = 11.22519, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10121, x = 56.38327, y = 13.06076, refreshTime = 36000000, objectType = 0},
				{monsterId = 10121, x = 56.3153, y = 15.886, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 15, 				--随机最大半径
		},			
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190103,1,190104,1},		--奖励道具ID，数量
		exp = expreward[12].exp,
		money = expreward[12].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10123,						--死亡怪物ID
	},

	winStar = {60,150,240},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[12],
		exp = expreward[12],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][13] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 105,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {13.0557,44.03249},		--玩家出生点
	relivePostion = {13.0557,44.03249},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		bornType = REFRSHTYPE_REGIONRANDOM,  --出生类型为随机和普通
		[1] =  --1
		{
			monsterlist = 
			{
				{monsterId = 10131, x = 20.56172, y = 56.1793, refreshTime = 36000000, objectType = 0},
				{monsterId = 10131, x = 17.08241, y = 59.25163, refreshTime = 36000000, objectType = 0},
				{monsterId = 10131, x = 19.77493, y = 61.27717, refreshTime = 36000000, objectType = 0},
				{monsterId = 10132, x = 11.2555, y = 71.09663, refreshTime = 36000000, objectType = 0},
				{monsterId = 10132, x = 14.04054, y = 74.89774, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1}, 				--怪物数量
			randradius = 15, 				--随机最大半径
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10132, x = 33.93447, y = 74.4615, refreshTime = 36000000, objectType = 0},
				{monsterId = 10132, x = 31.73432, y = 79.88204, refreshTime = 36000000, objectType = 0},
				{monsterId = 10132, x = 48.46692, y = 79.50791, refreshTime = 36000000, objectType = 0},
				{monsterId = 10132, x = 49.56105, y = 75.15936, refreshTime = 36000000, objectType = 0},
				{monsterId = 10132, x = 47.31333, y = 72.79275, refreshTime = 36000000, objectType = 0},
				{monsterId = 10132, x = 41.11721, y = 77.75201, refreshTime = 36000000, objectType = 0},
				{monsterId = 10131, x = 39.34109, y = 82.2122, refreshTime = 36000000, objectType = 0},
				{monsterId = 10131, x = 46.06489, y = 71.96571, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 15, 				--随机最大半径
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10133, x = 80.61262, y = 68.28182, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10132, x = 74.85944, y = 64.44384, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10132, x = 73.75669, y = 68.86064, refreshTime = 36000000, objectType = 0},
				{monsterId = 10132, x = 75.66812, y = 72.15667, refreshTime = 36000000, objectType = 0},
				{monsterId = 10131, x = 79.79401, y = 74.13519, refreshTime = 36000000, objectType = 0},
				{monsterId = 10131, x = 82.77441, y = 72.53832, refreshTime = 36000000, objectType = 0},
				{monsterId = 10131, x = 83.89028, y = 67.13609, refreshTime = 36000000, objectType = 0},
				{monsterId = 10131, x = 80.28611, y = 63.13974, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 15, 				--随机最大半径
		},
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190103,1,190104,1},		--奖励道具ID，数量
		exp = expreward[13].exp,
		money = expreward[13].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10133,						--死亡怪物ID
	},

	winStar = {60,150,240},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[13],
		exp = expreward[13],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][14] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 105,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {36.60933,47.18778},		--玩家出生点
	relivePostion = {36.60933,47.18778},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		bornType = REFRSHTYPE_REGIONRANDOM,  --出生类型为随机和普通
		[1] =  --1
		{
			monsterlist = 
			{
				{monsterId = 10141, x = 46.73205, y = 37.6718, refreshTime = 36000000, objectType = 0},
				{monsterId = 10141, x = 48.18445, y = 41.42156, refreshTime = 36000000, objectType = 0},
				{monsterId = 10141, x = 52.61963, y = 35.4872, refreshTime = 36000000, objectType = 0},
				{monsterId = 10142, x = 52.04628, y = 40.21973, refreshTime = 36000000, objectType = 0},
				{monsterId = 10142, x = 54.99051, y = 42.41343, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10141, x = 63.41088, y = 44.50267, refreshTime = 36000000, objectType = 0},
				{monsterId = 10141, x = 66.08717, y = 41.08743, refreshTime = 36000000, objectType = 0},
				{monsterId = 10141, x = 68.82886, y = 43.35305, refreshTime = 36000000, objectType = 0},
				{monsterId = 10141, x = 72.62152, y = 41.11823, refreshTime = 36000000, objectType = 0},
				{monsterId = 10141, x = 69.21098, y = 38.29233, refreshTime = 36000000, objectType = 0},
				{monsterId = 10142, x = 71.44229, y = 36.59047, refreshTime = 36000000, objectType = 0},
				{monsterId = 10142, x = 66.16351, y = 35.71102, refreshTime = 36000000, objectType = 0},
				{monsterId = 10142, x = 61.73742, y = 34.91998, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10143, x = 63.23508, y = 14.03767, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10142, x = 60.58291, y = 17.20349, refreshTime = 36000000, objectType = 0},
				{monsterId = 10142, x = 65.88412, y = 17.02737, refreshTime = 36000000, objectType = 0},
				{monsterId = 10142, x = 69.98943, y = 15.82782, refreshTime = 36000000, objectType = 0},
				{monsterId = 10141, x = 68.38747, y = 12.20223, refreshTime = 36000000, objectType = 0},
				{monsterId = 10141, x = 63.49606, y = 10.14246, refreshTime = 36000000, objectType = 0},
				{monsterId = 10141, x = 58.58022, y = 12.54947, refreshTime = 36000000, objectType = 0},
				{monsterId = 10141, x = 57.17083, y = 15.88149, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190103,1,190104,1},		--奖励道具ID，数量
		exp = expreward[14].exp,
		money = expreward[14].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10143,						--死亡怪物ID
	},

	winStar = {60,150,240},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[14],
		exp = expreward[14],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][15] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 105,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {45.79006,39.85206},		--玩家出生点
	relivePostion = {45.79006,39.85206},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		bornType = REFRSHTYPE_REGIONRANDOM,  --出生类型为随机和普通
		[1] =  --1
		{
			monsterlist = 
			{
				{monsterId = 10151, x = 63.49805, y = 42.28453, refreshTime = 36000000, objectType = 0},
				{monsterId = 10151, x = 59.13776, y = 43.73058, refreshTime = 36000000, objectType = 0},
				{monsterId = 10151, x = 60.42994, y = 46.6227, refreshTime = 36000000, objectType = 0},
				{monsterId = 10152, x = 64.85901, y = 47.4481, refreshTime = 36000000, objectType = 0},
				{monsterId = 10152, x = 69.82628, y = 43.59507, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10151, x = 78.72498, y = 64.11935, refreshTime = 36000000, objectType = 0},
				{monsterId = 10151, x = 73.29697, y = 65.45063, refreshTime = 36000000, objectType = 0},
				{monsterId = 10151, x = 69.03831, y = 67.82679, refreshTime = 36000000, objectType = 0},
				{monsterId = 10151, x = 82.8738, y = 68.37679, refreshTime = 36000000, objectType = 0},
				{monsterId = 10151, x = 78.29202, y = 69.35131, refreshTime = 36000000, objectType = 0},
				{monsterId = 10152, x = 73.75052, y = 70.72645, refreshTime = 36000000, objectType = 0},
				{monsterId = 10152, x = 79.78941, y = 73.73247, refreshTime = 36000000, objectType = 0},
				{monsterId = 10152, x = 74.95586, y = 75.31348, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10153, x = 40.22767, y = 76.14505, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10152, x = 50.18024, y = 78.40002, refreshTime = 36000000, objectType = 0},
				{monsterId = 10152, x = 45.48419, y = 74.94944, refreshTime = 36000000, objectType = 0},
				{monsterId = 10152, x = 45.26402, y = 70.61021, refreshTime = 36000000, objectType = 0},
				{monsterId = 10151, x = 38.63263, y = 70.78979, refreshTime = 36000000, objectType = 0},
				{monsterId = 10151, x = 34.40611, y = 74.22353, refreshTime = 36000000, objectType = 0},
				{monsterId = 10151, x = 37.81113, y = 79.25198, refreshTime = 36000000, objectType = 0},
				{monsterId = 10151, x = 44.79627, y = 80.61091, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190103,1,190104,1},		--奖励道具ID，数量
		exp = expreward[15].exp,
		money = expreward[15].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10153,						--死亡怪物ID
	},

	winStar = {60,150,240},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[15],
		exp = expreward[15],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][16] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 114,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {61.67733,41.75911},		--玩家出生点
	relivePostion = {61.67733,41.75911},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		bornType = REFRSHTYPE_REGIONRANDOM,  --出生类型为随机和普通
		[1] =  --1
		{
			monsterlist = 
			{
				{monsterId = 10161, x = 43.49457, y = 48.27744, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10161, x = 43.14363, y = 42.84272, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10161, x = 45.25572, y = 36.6714, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10161, x = 37.63052, y = 43.82332, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10162, x = 36.68512, y = 38.02692, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10162, x = 40.47415, y = 36.06569, refreshTime = 36000000, objectType = 0},	
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10161, x = 29.9631, y = 27.93609, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10161, x = 28.83957, y = 23.20314, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10161, x = 21.73773, y = 28.55272, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10161, x = 22.6542, y = 23.69969, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10162, x = 18.55384, y = 26.77392, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10162, x = 17.97034, y = 22.31277, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10162, x = 14.02507, y = 31.73374, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10162, x = 12.96937, y = 25.70121, refreshTime = 36000000, objectType = 0},	
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10163, x = 12.15159, y = 54.539, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10162, x = 16.05928, y = 41.9526, refreshTime = 36000000, objectType = 0},
				{monsterId = 10162, x = 10.76347, y = 41.93095, refreshTime = 36000000, objectType = 0},
				{monsterId = 10162, x = 15.16255, y = 49.45911, refreshTime = 36000000, objectType = 0},
				{monsterId = 10161, x = 9.538586, y = 49.78559, refreshTime = 36000000, objectType = 0},
				{monsterId = 10161, x = 13.66676, y = 57.84476, refreshTime = 36000000, objectType = 0},
				{monsterId = 10162, x = 7.069998, y = 56.40059, refreshTime = 36000000, objectType = 0},
				{monsterId = 10161, x = 6.868617, y = 60.47615, refreshTime = 36000000, objectType = 0},
				{monsterId = 10161, x = 10.91243, y = 65.82411, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190103,1,190104,1},		--奖励道具ID，数量
		exp = expreward[16].exp,
		money = expreward[16].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10163,						--死亡怪物ID
	},

	winStar = {60,150,240},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[16],
		exp = expreward[16],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][17] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 123,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {84.32936,53.60492},		--玩家出生点
	relivePostion = {84.32936,53.60492},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		bornType = REFRSHTYPE_REGIONRANDOM,  --出生类型为随机和普通
		[1] =  --1
		{
			monsterlist = 
			{
				{monsterId = 10171, x = 96.86917, y = 49.27789, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10171, x = 99.00054, y = 48.70393, refreshTime = 36000000, objectType = 0},
				{monsterId = 10171, x = 95.7855, y = 57.15001, refreshTime = 36000000, objectType = 0},
				{monsterId = 10171, x = 99.20335, y = 56.61967, refreshTime = 36000000, objectType = 0},
				{monsterId = 10172, x = 104.5898, y = 53.73128, refreshTime = 36000000, objectType = 0},
				{monsterId = 10172, x = 110.385, y = 53.37282, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10171, x = 124.4621, y = 46.52265, refreshTime = 36000000, objectType = 0},
				{monsterId = 10171, x = 124.2718, y = 52.52552, refreshTime = 36000000, objectType = 0},
				{monsterId = 10171, x = 126.8095, y = 56.21047, refreshTime = 36000000, objectType = 0},
				{monsterId = 10171, x = 132.1109, y = 56.60039, refreshTime = 36000000, objectType = 0},
				{monsterId = 10172, x = 136.5078, y = 54.03445, refreshTime = 36000000, objectType = 0},
				{monsterId = 10172, x = 138.6086, y = 49.01524, refreshTime = 36000000, objectType = 0},
				{monsterId = 10172, x = 136.2033, y = 44.18286, refreshTime = 36000000, objectType = 0},
				{monsterId = 10172, x = 130.4019, y = 44.33017, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10173, x = 155.3341, y = 73.67326, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10172, x = 149.7113, y = 68.90859, refreshTime = 36000000, objectType = 0},
				{monsterId = 10172, x = 148.6618, y = 73.6279, refreshTime = 36000000, objectType = 0},
				{monsterId = 10172, x = 150.4685, y = 77.62231, refreshTime = 36000000, objectType = 0},
				{monsterId = 10172, x = 155.4787, y = 80.13719, refreshTime = 36000000, objectType = 0},
				{monsterId = 10172, x = 160.2641, y = 78.33846, refreshTime = 36000000, objectType = 0},
				{monsterId = 10171, x = 163.2283, y = 72.57747, refreshTime = 36000000, objectType = 0},
				{monsterId = 10171, x = 161.1645, y = 69.6468, refreshTime = 36000000, objectType = 0},
				{monsterId = 10171, x = 156.2846, y = 68.08928, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190103,1,190104,1},		--奖励道具ID，数量
		exp = expreward[17].exp,
		money = expreward[17].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10173,						--死亡怪物ID
	},

	winStar = {60,150,240},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[17],
		exp = expreward[17],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][18] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 123,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {133.0889,130.3011},		--玩家出生点
	relivePostion = {133.0889,130.3011},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		bornType = REFRSHTYPE_REGIONRANDOM,  --出生类型为随机和普通
		[1] =  --1
		{
			monsterlist = 
			{
				{monsterId = 10181, x = 113.6729, y = 117.9704, refreshTime = 36000000, objectType = 0},
				{monsterId = 10181, x = 116.8881, y = 114.9877, refreshTime = 36000000, objectType = 0},
				{monsterId = 10181, x = 108.1488, y = 117.247, refreshTime = 36000000, objectType = 0},
				{monsterId = 10181, x = 111.9369, y = 112.1664, refreshTime = 36000000, objectType = 0},
				{monsterId = 10181, x = 106.5589, y = 111.807, refreshTime = 36000000, objectType = 0},
				{monsterId = 10182, x = 111.7072, y = 115.2165, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10181, x = 93.83945, y = 111.3445, refreshTime = 36000000, objectType = 0},
				{monsterId = 10181, x = 88.63694, y = 108.8959, refreshTime = 36000000, objectType = 0},
				{monsterId = 10181, x = 91.9596, y = 114.5303, refreshTime = 36000000, objectType = 0},
				{monsterId = 10182, x = 88.5235, y = 112.4932, refreshTime = 36000000, objectType = 0},
				{monsterId = 10182, x = 85.24107, y = 113.2148, refreshTime = 36000000, objectType = 0},
				{monsterId = 10182, x = 88.72078, y = 117.0351, refreshTime = 36000000, objectType = 0},
				{monsterId = 10182, x = 85.37875, y = 118.4476, refreshTime = 36000000, objectType = 0},
				{monsterId = 10182, x = 86.32071, y = 122.1911, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 6, 				--随机最大半径
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10183, x = 66.75768, y = 128.4731, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10182, x = 75.79821, y = 126.5271, refreshTime = 36000000, objectType = 0},
				{monsterId = 10182, x = 74.12481, y = 133.1579, refreshTime = 36000000, objectType = 0},
				{monsterId = 10182, x = 71.19707, y = 129.4102, refreshTime = 36000000, objectType = 0},
				{monsterId = 10182, x = 69.3447, y = 125.1234, refreshTime = 36000000, objectType = 0},
				{monsterId = 10182, x = 63.93466, y = 122.9239, refreshTime = 36000000, objectType = 0},
				{monsterId = 10181, x = 66.0573, y = 131.2251, refreshTime = 36000000, objectType = 0},
				{monsterId = 10181, x = 60.95926, y = 132.0852, refreshTime = 36000000, objectType = 0},
				{monsterId = 10181, x = 65.28683, y = 136.0453, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},		
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190103,1,190104,1},		--奖励道具ID，数量
		exp = expreward[18].exp,
		money = expreward[18].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10183,						--死亡怪物ID
	},

	winStar = {60,150,240},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[18],
		exp = expreward[18],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][19] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 123,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {99.22621,65.97519},		--玩家出生点
	relivePostion = {99.22621,65.97519},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		bornType = REFRSHTYPE_REGIONRANDOM,  --出生类型为随机和普通
		[1] =  --1
		{
			monsterlist = 
			{
				{monsterId = 10191, x = 92.25202, y = 57.90196, refreshTime = 36000000, objectType = 0},		
				{monsterId = 10191, x = 94.12449, y = 48.31704, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10191, x = 89.24146, y = 55.21429, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10192, x = 89.61858, y = 49.42523, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10192, x = 85.20542, y = 54.77945, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10192, x = 84.86502, y = 49.75422, refreshTime = 36000000, objectType = 0},	
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10191, x = 79.20153, y = 26.52512, refreshTime = 36000000, objectType = 0},
				{monsterId = 10191, x = 76.37263, y = 20.34319, refreshTime = 36000000, objectType = 0},
				{monsterId = 10191, x = 75.18369, y = 26.84215, refreshTime = 36000000, objectType = 0},
				{monsterId = 10191, x = 70.72906, y = 29.50655, refreshTime = 36000000, objectType = 0},
				{monsterId = 10192, x = 68.59966, y = 25.38728, refreshTime = 36000000, objectType = 0},
				{monsterId = 10192, x = 67.66848, y = 18.75594, refreshTime = 36000000, objectType = 0},
				{monsterId = 10192, x = 72.96288, y = 17.49185, refreshTime = 36000000, objectType = 0},
				{monsterId = 10192, x = 66.64382, y = 14.62108, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10193, x = 37.91114, y = 22.90317, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10192, x = 45.24159, y = 22.39431, refreshTime = 36000000, objectType = 0},
				{monsterId = 10192, x = 43.69039, y = 29.01366, refreshTime = 36000000, objectType = 0},
				{monsterId = 10192, x = 39.27609, y = 29.86166, refreshTime = 36000000, objectType = 0},
				{monsterId = 10192, x = 41.40789, y = 25.87618, refreshTime = 36000000, objectType = 0},
				{monsterId = 10192, x = 39.29525, y = 18.59809, refreshTime = 36000000, objectType = 0},
				{monsterId = 10191, x = 42.05005, y = 15.5575, refreshTime = 36000000, objectType = 0},
				{monsterId = 10191, x = 34.65592, y = 17.18188, refreshTime = 36000000, objectType = 0},
				{monsterId = 10191, x = 32.98671, y = 24.48002, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},			
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190103,1,190104,1},		--奖励道具ID，数量
		exp = expreward[19].exp,
		money = expreward[19].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10193,						--死亡怪物ID
	},

	winStar = {60,150,240},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[19],
		exp = expreward[19],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][20] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 123,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {101.6853,110.2468},		--玩家出生点
	relivePostion = {101.6853,110.2468},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		bornType = REFRSHTYPE_REGIONRANDOM,  --出生类型为随机和普通
		[1] =  --1
		{
			monsterlist = 
			{
				{monsterId = 10201, x = 115.5641, y = 111.1793, refreshTime = 36000000, objectType = 0},
				{monsterId = 10201, x = 112.0226, y = 113.7565, refreshTime = 36000000, objectType = 0},
				{monsterId = 10201, x = 110.032, y = 117.4445, refreshTime = 36000000, objectType = 0},
				{monsterId = 10202, x = 117.5033, y = 115.1448, refreshTime = 36000000, objectType = 0},
				{monsterId = 10202, x = 115.0371, y = 117.5563, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10201, x = 137.0284, y = 128.7081, refreshTime = 36000000, objectType = 0},
				{monsterId = 10201, x = 138.344, y = 136.2991, refreshTime = 36000000, objectType = 0},
				{monsterId = 10202, x = 140.6361, y = 131.4966, refreshTime = 36000000, objectType = 0},
				{monsterId = 10202, x = 144.5732, y = 130.1074, refreshTime = 36000000, objectType = 0},
				{monsterId = 10202, x = 147.6651, y = 133.7136, refreshTime = 36000000, objectType = 0},
				{monsterId = 10202, x = 143.6547, y = 137.2506, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10201, x = 168.5616, y = 115.4719, refreshTime = 36000000, objectType = 0},
				{monsterId = 10201, x = 172.7409, y = 120.1466, refreshTime = 36000000, objectType = 0},
				{monsterId = 10201, x = 172.7987, y = 115.4409, refreshTime = 36000000, objectType = 0},
				{monsterId = 10201, x = 171.2427, y = 106.8677, refreshTime = 36000000, objectType = 0},
				{monsterId = 10202, x = 173.4214, y = 111.0335, refreshTime = 36000000, objectType = 0},
				{monsterId = 10202, x = 177.6847, y = 110.0768, refreshTime = 36000000, objectType = 0},
				{monsterId = 10202, x = 177.6612, y = 115.2772, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10203, x = 155.0452, y = 73.34643, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10202, x = 157.9805, y = 78.11096, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10202, x = 151.775, y = 78.03651, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10202, x = 148.7905, y = 73.49393, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10202, x = 151.4944, y = 69.65933, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10201, x = 157.3015, y = 68.00117, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10201, x = 158.6906, y = 72.4836, refreshTime = 36000000, objectType = 0},	
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 				--随机最大半径
		},	
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190103,1,190104,1},		--奖励道具ID，数量
		exp = expreward[20].exp,
		money = expreward[20].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10203,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[20],
		exp = expreward[20],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][21] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 114,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {51.92801,42.29893},		--玩家出生点
	relivePostion = {51.92801,42.29893},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		bornType = REFRSHTYPE_REGIONRANDOM,  --出生类型为随机和普通
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10211, x = 38.63169, y = 41.25944, refreshTime = 36000000, objectType = 0},
				{monsterId = 10211, x = 40.4835, y = 38.73849, refreshTime = 36000000, objectType = 0},
				{monsterId = 10211, x = 35.58772, y = 39.77902, refreshTime = 36000000, objectType = 0},
				{monsterId = 10212, x = 35.5702, y = 36.49686, refreshTime = 36000000, objectType = 0},
				{monsterId = 10212, x = 39.66146, y = 35.28283, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10211, x = 29.8631, y = 27.62039, refreshTime = 36000000, objectType = 0},
				{monsterId = 10211, x = 26.38318, y = 23.2366, refreshTime = 36000000, objectType = 0},
				{monsterId = 10211, x = 23.18882, y = 27.64444, refreshTime = 36000000, objectType = 0},
				{monsterId = 10211, x = 18.70741, y = 23.26844, refreshTime = 36000000, objectType = 0},
				{monsterId = 10212, x = 18.30837, y = 29.52379, refreshTime = 36000000, objectType = 0},
				{monsterId = 10212, x = 14.68207, y = 27.26225, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10211, x = 11.45013, y = 42.08216, refreshTime = 36000000, objectType = 0},
				{monsterId = 10211, x = 17.22375, y = 44.99543, refreshTime = 36000000, objectType = 0},
				{monsterId = 10211, x = 10.83734, y = 48.92177, refreshTime = 36000000, objectType = 0},
				{monsterId = 10211, x = 14.83557, y = 53.01708, refreshTime = 36000000, objectType = 0},
				{monsterId = 10212, x = 7.503631, y = 57.26936, refreshTime = 36000000, objectType = 0},
				{monsterId = 10212, x = 9.578275, y = 60.85961, refreshTime = 36000000, objectType = 0},
				{monsterId = 10212, x = 14.66478, y = 60.60532, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10213, x = 7.042273, y = 98.42793, refreshTime = 36000000, objectType = 0},
				{monsterId = 10212, x = 12.89398, y = 96.67224, refreshTime = 36000000, objectType = 0},
				{monsterId = 10212, x = 8.909936, y = 94.45352, refreshTime = 36000000, objectType = 0},
				{monsterId = 10212, x = 4.203261, y = 94.42431, refreshTime = 36000000, objectType = 0},
				{monsterId = 10212, x = 4.15454, y = 98.35407, refreshTime = 36000000, objectType = 0},
				{monsterId = 10211, x = 3.681414, y = 100.9748, refreshTime = 36000000, objectType = 0},
				{monsterId = 10211, x = 10.41526, y = 101.0221, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},	
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190113,1,190114,1},		--奖励道具ID，数量
		exp = expreward[21].exp,
		money = expreward[21].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10213,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[21],
		exp = expreward[21],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][22] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 105,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {86.78847,73.90348},		--玩家出生点
	relivePostion = {86.78847,73.90348},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		bornType = REFRSHTYPE_REGIONRANDOM,  --出生类型为随机和普通
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10221, x = 71.95353, y = 68.27892, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10221, x = 70.94785, y = 67.12534, refreshTime = 36000000, objectType = 0},
				{monsterId = 10221, x = 73.35909, y = 65.9632, refreshTime = 36000000, objectType = 0},
				{monsterId = 10222, x = 75.15601, y = 65.0386, refreshTime = 36000000, objectType = 0},
				{monsterId = 10222, x = 77.35403, y = 63.1342, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10221, x = 68.11915, y = 44.67004, refreshTime = 36000000, objectType = 0},
				{monsterId = 10221, x = 68.71877, y = 39.12928, refreshTime = 36000000, objectType = 0},
				{monsterId = 10221, x = 61.25866, y = 46.67979, refreshTime = 36000000, objectType = 0},
				{monsterId = 10221, x = 62.81148, y = 41.39531, refreshTime = 36000000, objectType = 0},
				{monsterId = 10222, x = 59.72139, y = 35.39193, refreshTime = 36000000, objectType = 0},
				{monsterId = 10222, x = 55.86821, y = 40.87186, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10221, x = 48.78478, y = 35.32681, refreshTime = 36000000, objectType = 0},
				{monsterId = 10221, x = 43.00387, y = 38.81378, refreshTime = 36000000, objectType = 0},
				{monsterId = 10221, x = 45.74508, y = 35.70665, refreshTime = 36000000, objectType = 0},
				{monsterId = 10221, x = 44.06918, y = 34.6887, refreshTime = 36000000, objectType = 0},
				{monsterId = 10222, x = 43.40669, y = 29.89094, refreshTime = 36000000, objectType = 0},
				{monsterId = 10222, x = 40.35911, y = 30.25217, refreshTime = 36000000, objectType = 0},
				{monsterId = 10222, x = 40.85703, y = 26.75178, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10223, x = 29.404, y = 19.778, refreshTime = 36000000, objectType = 0},
				{monsterId = 10222, x = 34.57277, y = 17.0831, refreshTime = 36000000, objectType = 0},
				{monsterId = 10222, x = 31.98979, y = 22.1793, refreshTime = 36000000, objectType = 0},
				{monsterId = 10221, x = 29.35784, y = 15.00555, refreshTime = 36000000, objectType = 0},
				{monsterId = 10221, x = 27.55202, y = 28.15598, refreshTime = 36000000, objectType = 0},
				{monsterId = 10221, x = 26.95571, y = 25.09429, refreshTime = 36000000, objectType = 0},
				{monsterId = 10221, x = 23.03821, y = 22.56726, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},	
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190113,1,190114,1},		--奖励道具ID，数量
		exp = expreward[22].exp,
		money = expreward[22].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10223,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[22],
		exp = expreward[22],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][23] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 105,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {32.69091,81.99175},		--玩家出生点
	relivePostion = {32.69091,81.99175},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		bornType = REFRSHTYPE_REGIONRANDOM,  --出生类型为随机和普通
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10231, x = 45.31327, y = 70.35143, refreshTime = 36000000, objectType = 0},	
				{monsterId = 10231, x = 47.33559, y = 75.59926, refreshTime = 36000000, objectType = 0},
				{monsterId = 10231, x = 50.12923, y = 80.77609, refreshTime = 36000000, objectType = 0},
				{monsterId = 10232, x = 51.9128, y = 74.73547, refreshTime = 36000000, objectType = 0},
				{monsterId = 10232, x = 51.23809, y = 70.57236, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10231, x = 72.53233, y = 67.31042, refreshTime = 36000000, objectType = 0},
				{monsterId = 10231, x = 76.06149, y = 68.69059, refreshTime = 36000000, objectType = 0},
				{monsterId = 10231, x = 76.27659, y = 72.59389, refreshTime = 36000000, objectType = 0},
				{monsterId = 10231, x = 77.29724, y = 63.89027, refreshTime = 36000000, objectType = 0},
				{monsterId = 10232, x = 82.72459, y = 65.63348, refreshTime = 36000000, objectType = 0},
				{monsterId = 10232, x = 82.48409, y = 72.4851, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10231, x = 63.41373, y = 46.02699, refreshTime = 36000000, objectType = 0},
				{monsterId = 10231, x = 53.45984, y = 42.60449, refreshTime = 36000000, objectType = 0},
				{monsterId = 10231, x = 57.62339, y = 38.44818, refreshTime = 36000000, objectType = 0},
				{monsterId = 10231, x = 60.92974, y = 41.85017, refreshTime = 36000000, objectType = 0},
				{monsterId = 10232, x = 65.12933, y = 43.4095, refreshTime = 36000000, objectType = 0},
				{monsterId = 10232, x = 66.97707, y = 38.70062, refreshTime = 36000000, objectType = 0},
				{monsterId = 10232, x = 69.80374, y = 42.53099, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10233, x = 32.26649, y = 22.50868, refreshTime = 36000000, objectType = 0},
				{monsterId = 10232, x = 35.68261, y = 24.50038, refreshTime = 36000000, objectType = 0},
				{monsterId = 10232, x = 36.87476, y = 19.90079, refreshTime = 36000000, objectType = 0},
				{monsterId = 10232, x = 31.30999, y = 27.58116, refreshTime = 36000000, objectType = 0},
				{monsterId = 10232, x = 27.15396, y = 24.6601, refreshTime = 36000000, objectType = 0},
				{monsterId = 10231, x = 27.09099, y = 20.68075, refreshTime = 36000000, objectType = 0},
				{monsterId = 10231, x = 31.66534, y = 17.86257, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},	
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190113,1,190114,1},		--奖励道具ID，数量
		exp = expreward[23].exp,
		money = expreward[23].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10233,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[23],
		exp = expreward[23],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][24] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 105,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {34.13545,48.04784},		--玩家出生点
	relivePostion = {34.13545,48.04784},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		bornType = REFRSHTYPE_REGIONRANDOM,  --出生类型为随机和普通
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10241, x = 47.80603, y = 37.36593, refreshTime = 36000000, objectType = 0},
				{monsterId = 10241, x = 46.8112, y = 39.88105, refreshTime = 36000000, objectType = 0},
				{monsterId = 10241, x = 48.46341, y = 39.84459, refreshTime = 36000000, objectType = 0},
				{monsterId = 10242, x = 47.92262, y = 42.31782, refreshTime = 36000000, objectType = 0},
				{monsterId = 10242, x = 50.48858, y = 42.33931, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10241, x = 68.89311, y = 46.4539, refreshTime = 36000000, objectType = 0},
				{monsterId = 10241, x = 67.513, y = 46.49385, refreshTime = 36000000, objectType = 0},
				{monsterId = 10241, x = 65.00934, y = 47.05579, refreshTime = 36000000, objectType = 0},
				{monsterId = 10242, x = 63.8308, y = 45.90553, refreshTime = 36000000, objectType = 0},
				{monsterId = 10242, x = 60.74194, y = 46.40473, refreshTime = 36000000, objectType = 0},
				{monsterId = 10242, x = 61.68692, y = 49.16433, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10241, x = 75.49779, y = 63.72002, refreshTime = 36000000, objectType = 0},
				{monsterId = 10241, x = 72.83411, y = 69.05584, refreshTime = 36000000, objectType = 0},
				{monsterId = 10241, x = 82.01543, y = 63.1812, refreshTime = 36000000, objectType = 0},
				{monsterId = 10242, x = 84.79904, y = 66.8809, refreshTime = 36000000, objectType = 0},
				{monsterId = 10242, x = 79.79002, y = 68.63387, refreshTime = 36000000, objectType = 0},
				{monsterId = 10242, x = 78.2555, y = 73.01972, refreshTime = 36000000, objectType = 0},
				{monsterId = 10242, x = 83.89144, y = 73.57067, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10243, x = 45.91386, y = 74.77444, refreshTime = 36000000, objectType = 0},
				{monsterId = 10242, x = 47.43697, y = 70.24716, refreshTime = 36000000, objectType = 0},
				{monsterId = 10242, x = 50.54248, y = 72.37633, refreshTime = 36000000, objectType = 0},
				{monsterId = 10241, x = 48.26298, y = 75.43663, refreshTime = 36000000, objectType = 0},
				{monsterId = 10241, x = 54.28832, y = 75.4417, refreshTime = 36000000, objectType = 0},
				{monsterId = 10241, x = 50.48959, y = 78.4267, refreshTime = 36000000, objectType = 0},
				{monsterId = 10241, x = 47.21067, y = 79.24151, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},	
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190113,1,190114,1},		--奖励道具ID，数量
		exp = expreward[24].exp,
		money = expreward[24].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10243,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[24],
		exp = expreward[24],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][25] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 105,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {84.57928,71.5835},		--玩家出生点
	relivePostion = {84.57928,71.5835},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		bornType = REFRSHTYPE_REGIONRANDOM,  --出生类型为随机和普通
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10251, x = 72.70845, y = 76.34364, refreshTime = 36000000, objectType = 0},
				{monsterId = 10251, x = 70.07451, y = 73.5684, refreshTime = 36000000, objectType = 0},
				{monsterId = 10251, x = 67.5755, y = 71.53474, refreshTime = 36000000, objectType = 0},
				{monsterId = 10252, x = 71.24936, y = 70.77834, refreshTime = 36000000, objectType = 0},
				{monsterId = 10252, x = 69.26121, y = 66.80979, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10252, x = 53.91067, y = 75.95398, refreshTime = 36000000, objectType = 0},
				{monsterId = 10252, x = 55.05538, y = 72.13251, refreshTime = 36000000, objectType = 0},
				{monsterId = 10252, x = 48.70052, y = 78.09198, refreshTime = 36000000, objectType = 0},
				{monsterId = 10251, x = 51.46669, y = 73.82566, refreshTime = 36000000, objectType = 0},
				{monsterId = 10251, x = 47.22863, y = 72.13242, refreshTime = 36000000, objectType = 0},
				{monsterId = 10251, x = 51.96986, y = 69.58781, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10252, x = 37.12963, y = 79.14799, refreshTime = 36000000, objectType = 0},
				{monsterId = 10252, x = 34.5131, y = 75.23806, refreshTime = 36000000, objectType = 0},
				{monsterId = 10252, x = 33.906, y = 84.14098, refreshTime = 36000000, objectType = 0},
				{monsterId = 10252, x = 31.46679, y = 81.87421, refreshTime = 36000000, objectType = 0},
				{monsterId = 10251, x = 32.2872, y = 78.90053, refreshTime = 36000000, objectType = 0},
				{monsterId = 10251, x = 28.61143, y = 79.05043, refreshTime = 36000000, objectType = 0},
				{monsterId = 10251, x = 28.31648, y = 73.37265, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10253, x = 13.39318, y = 47.41419, refreshTime = 36000000, objectType = 0},
				{monsterId = 10252, x = 15.8488, y = 58.10666, refreshTime = 36000000, objectType = 0},
				{monsterId = 10252, x = 21.06868, y = 59.72179, refreshTime = 36000000, objectType = 0},
				{monsterId = 10252, x = 10.58738, y = 50.03613, refreshTime = 36000000, objectType = 0},
				{monsterId = 10251, x = 15.37171, y = 50.67375, refreshTime = 36000000, objectType = 0},
				{monsterId = 10251, x = 16.69778, y = 44.09785, refreshTime = 36000000, objectType = 0},
				{monsterId = 10251, x = 10.54748, y = 44.48736, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},	
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190113,1,190114,1},		--奖励道具ID，数量
		exp = expreward[25].exp,
		money = expreward[25].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10253,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[25],
		exp = expreward[25],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][26] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 105,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {35.62507,47.49693},		--玩家出生点
	relivePostion = {35.62507,47.49693},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		bornType = REFRSHTYPE_REGIONRANDOM,  --出生类型为随机和普通
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10261, x = 45.15205, y = 36.04157, refreshTime = 36000000, objectType = 0},
				{monsterId = 10261, x = 45.54246, y = 43.26018, refreshTime = 36000000, objectType = 0},
				{monsterId = 10261, x = 49.90577, y = 35.83801, refreshTime = 36000000, objectType = 0},
				{monsterId = 10261, x = 47.2729, y = 39.10847, refreshTime = 36000000, objectType = 0},
				{monsterId = 10261, x = 49.80964, y = 41.37934, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10262, x = 59.90443, y = 42.75763, refreshTime = 36000000, objectType = 0},
				{monsterId = 10261, x = 63.24738, y = 43.75668, refreshTime = 36000000, objectType = 0},
				{monsterId = 10261, x = 62.27788, y = 46.19781, refreshTime = 36000000, objectType = 0},
				{monsterId = 10261, x = 64.87873, y = 45.81301, refreshTime = 36000000, objectType = 0},
				{monsterId = 10261, x = 67.16845, y = 43.48397, refreshTime = 36000000, objectType = 0},
				{monsterId = 10261, x = 69.27977, y = 43.68759, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10261, x = 56.14508, y = 36.46297, refreshTime = 36000000, objectType = 0},
				{monsterId = 10262, x = 58.64148, y = 34.89051, refreshTime = 36000000, objectType = 0},
				{monsterId = 10261, x = 62.23266, y = 34.67006, refreshTime = 36000000, objectType = 0},
				{monsterId = 10261, x = 61.97939, y = 37.11912, refreshTime = 36000000, objectType = 0},
				{monsterId = 10261, x = 65.63525, y = 35.04926, refreshTime = 36000000, objectType = 0},
				{monsterId = 10261, x = 65.95919, y = 37.48025, refreshTime = 36000000, objectType = 0},
				{monsterId = 10261, x = 69.67954, y = 37.64124, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10263, x = 63.90809, y = 14.5472, refreshTime = 36000000, objectType = 0},
				{monsterId = 10262, x = 63.64124, y = 17.14164, refreshTime = 36000000, objectType = 0},
				{monsterId = 10261, x = 67.49224, y = 17.33613, refreshTime = 36000000, objectType = 0},
				{monsterId = 10261, x = 69.69029, y = 13.35571, refreshTime = 36000000, objectType = 0},
				{monsterId = 10261, x = 64.13136, y = 11.84069, refreshTime = 36000000, objectType = 0},
				{monsterId = 10261, x = 57.84506, y = 12.24843, refreshTime = 36000000, objectType = 0},
				{monsterId = 10261, x = 59.76643, y = 16.55137, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},		
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190113,1,190114,1},		--奖励道具ID，数量
		exp = expreward[26].exp,
		money = expreward[26].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10263,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[26],
		exp = expreward[26],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][27] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 114,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {12.11674,6.620661},		--玩家出生点
	relivePostion = {12.11674,6.620661},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10271, x = 16.41739, y = 16.10984, refreshTime = 36000000, objectType = 0},
				{monsterId = 10271, x = 13.94725, y = 18.77984, refreshTime = 36000000, objectType = 0},
				{monsterId = 10271, x = 12.44114, y = 16.62054, refreshTime = 36000000, objectType = 0},
				{monsterId = 10271, x = 9.16609, y = 16.28802, refreshTime = 36000000, objectType = 0},
				{monsterId = 10271, x = 10.595, y = 21.05741, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10272, x = 23.00216, y = 21.57364, refreshTime = 36000000, objectType = 0},
				{monsterId = 10271, x = 27.47141, y = 21.59477, refreshTime = 36000000, objectType = 0},
				{monsterId = 10271, x = 31.16765, y = 23.64576, refreshTime = 36000000, objectType = 0},
				{monsterId = 10271, x = 28.95692, y = 28.47386, refreshTime = 36000000, objectType = 0},
				{monsterId = 10271, x = 26.48483, y = 26.10652, refreshTime = 36000000, objectType = 0},
				{monsterId = 10271, x = 22.5255, y = 27.07915, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10271, x = 41.91035, y = 35.84012, refreshTime = 36000000, objectType = 0},
				{monsterId = 10271, x = 42.19477, y = 40.0841, refreshTime = 36000000, objectType = 0},
				{monsterId = 10271, x = 48.44742, y = 43.21053, refreshTime = 36000000, objectType = 0},
				{monsterId = 10271, x = 48.67295, y = 39.45404, refreshTime = 36000000, objectType = 0},
				{monsterId = 10271, x = 47.60698, y = 35.50546, refreshTime = 36000000, objectType = 0},
				{monsterId = 10271, x = 54.32327, y = 42.33217, refreshTime = 36000000, objectType = 0},
				{monsterId = 10271, x = 53.90887, y = 37.05402, refreshTime = 36000000, objectType = 0},
				{monsterId = 10271, x = 51.41557, y = 33.74556, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10273, x = 53.46264, y = 9.638388, refreshTime = 36000000, objectType = 0},
				{monsterId = 10272, x = 50.36587, y = 14.37787, refreshTime = 36000000, objectType = 0},
				{monsterId = 10271, x = 55.09184, y = 13.98396, refreshTime = 36000000, objectType = 0},
				{monsterId = 10271, x = 57.55788, y = 11.80707, refreshTime = 36000000, objectType = 0},
				{monsterId = 10271, x = 56.62925, y = 5.857141, refreshTime = 36000000, objectType = 0},
				{monsterId = 10271, x = 50.4098, y = 4.509253, refreshTime = 36000000, objectType = 0},
				{monsterId = 10271, x = 49.94775, y = 8.973268, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},		
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190113,1,190114,1},		--奖励道具ID，数量
		exp = expreward[27].exp,
		money = expreward[27].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10273,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[27],
		exp = expreward[27],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][28] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 114,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {32.81673,54.21085},		--玩家出生点
	relivePostion = {32.81673,54.21085},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10281, x = 24.21596, y = 64.21125, refreshTime = 36000000, objectType = 0},
				{monsterId = 10281, x = 28.9531, y = 70.74958, refreshTime = 36000000, objectType = 0},
				{monsterId = 10281, x = 22.88985, y = 70.04314, refreshTime = 36000000, objectType = 0},
				{monsterId = 10281, x = 23.57573, y = 74.90654, refreshTime = 36000000, objectType = 0},
				{monsterId = 10281, x = 25.1243, y = 79.64014, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10282, x = 9.813104, y = 96.50948, refreshTime = 36000000, objectType = 0},
				{monsterId = 10281, x = 8.689714, y = 102.2905, refreshTime = 36000000, objectType = 0},
				{monsterId = 10281, x = 1.802002, y = 100.6309, refreshTime = 36000000, objectType = 0},
				{monsterId = 10281, x = 4.937287, y = 97.09303, refreshTime = 36000000, objectType = 0},
				{monsterId = 10281, x = 1.25448, y = 94.26727, refreshTime = 36000000, objectType = 0},
				{monsterId = 10281, x = 2.019326, y = 90.442, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10281, x = 5.4238, y = 71.43872, refreshTime = 36000000, objectType = 0},
				{monsterId = 10282, x = 12.12576, y = 71.31458, refreshTime = 36000000, objectType = 0},
				{monsterId = 10281, x = 8.739189, y = 66.22846, refreshTime = 36000000, objectType = 0},
				{monsterId = 10281, x = 13.977, y = 66.37643, refreshTime = 36000000, objectType = 0},
				{monsterId = 10281, x = 7.611663, y = 61.67627, refreshTime = 36000000, objectType = 0},
				{monsterId = 10281, x = 12.69796, y = 61.6944, refreshTime = 36000000, objectType = 0},
				{monsterId = 10281, x = 6.702955, y = 56.86597, refreshTime = 36000000, objectType = 0},
				{monsterId = 10281, x = 13.37711, y = 57.08007, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10283, x = 10.09028, y = 37.85045, refreshTime = 36000000, objectType = 0},
				{monsterId = 10282, x = 16.12799, y = 42.50636, refreshTime = 36000000, objectType = 0},
				{monsterId = 10281, x = 12.77069, y = 40.48245, refreshTime = 36000000, objectType = 0},
				{monsterId = 10281, x = 7.836851, y = 39.36161, refreshTime = 36000000, objectType = 0},
				{monsterId = 10281, x = 5.919566, y = 36.55027, refreshTime = 36000000, objectType = 0},
				{monsterId = 10281, x = 8.701612, y = 32.86993, refreshTime = 36000000, objectType = 0},
				{monsterId = 10281, x = 13.12429, y = 35.8452, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},			
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190113,1,190114,1},		--奖励道具ID，数量
		exp = expreward[28].exp,
		money = expreward[28].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10283,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[28],
		exp = expreward[28],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][29] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 114,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {13.10312,49.12975},		--玩家出生点
	relivePostion = {13.10312,49.12975},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10291, x = 13.03156, y = 38.63963, refreshTime = 36000000, objectType = 0},
				{monsterId = 10291, x = 9.369961, y = 38.90642, refreshTime = 36000000, objectType = 0},
				{monsterId = 10291, x = 5.662021, y = 35.06595, refreshTime = 36000000, objectType = 0},
				{monsterId = 10291, x = 7.918276, y = 33.14592, refreshTime = 36000000, objectType = 0},
				{monsterId = 10291, x = 11.91726, y = 31.50423, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10292, x = 22.20378, y = 21.57545, refreshTime = 36000000, objectType = 0},
				{monsterId = 10291, x = 21.12825, y = 28.05127, refreshTime = 36000000, objectType = 0},
				{monsterId = 10291, x = 22.20378, y = 21.57545, refreshTime = 36000000, objectType = 0},
				{monsterId = 10291, x = 27.22011, y = 23.29147, refreshTime = 36000000, objectType = 0},
				{monsterId = 10291, x = 24.68564, y = 26.24382, refreshTime = 36000000, objectType = 0},
				{monsterId = 10291, x = 27.96747, y = 28.40846, refreshTime = 36000000, objectType = 0},
				{monsterId = 10291, x = 31.26659, y = 26.46186, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10291, x = 42.31917, y = 37.78973, refreshTime = 36000000, objectType = 0},
				{monsterId = 10291, x = 41.53071, y = 43.81031, refreshTime = 36000000, objectType = 0},
				{monsterId = 10291, x = 46.30982, y = 39.44369, refreshTime = 36000000, objectType = 0},
				{monsterId = 10291, x = 48.10749, y = 44.10733, refreshTime = 36000000, objectType = 0},
				{monsterId = 10291, x = 50.85513, y = 38.26772, refreshTime = 36000000, objectType = 0},
				{monsterId = 10291, x = 54.15706, y = 44.21123, refreshTime = 36000000, objectType = 0},
				{monsterId = 10291, x = 56.15932, y = 38.29544, refreshTime = 36000000, objectType = 0},
				{monsterId = 10291, x = 61.83477, y = 42.0575, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10293, x = 85.66253, y = 10.53995, refreshTime = 36000000, objectType = 0},
				{monsterId = 10292, x = 83.1377, y = 13.11726, refreshTime = 36000000, objectType = 0},
				{monsterId = 10291, x = 88.78905, y = 14.23444, refreshTime = 36000000, objectType = 0},
				{monsterId = 10291, x = 91.18124, y = 10.22659, refreshTime = 36000000, objectType = 0},
				{monsterId = 10291, x = 88.82367, y = 6.4983, refreshTime = 36000000, objectType = 0},
				{monsterId = 10291, x = 84.52352, y = 6.078186, refreshTime = 36000000, objectType = 0},
				{monsterId = 10291, x = 80.83628, y = 6.761213, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},		
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190113,1,190114,1},		--奖励道具ID，数量
		exp = expreward[29].exp,
		money = expreward[29].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10293,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[29],
		exp = expreward[29],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][30] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 114,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {43.1645,87.12109},		--玩家出生点
	relivePostion = {43.1645,87.12109},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10301, x = 55.19181, y = 86.51019, refreshTime = 36000000, objectType = 0},
				{monsterId = 10301, x = 52.58232, y = 81.17738, refreshTime = 36000000, objectType = 0},
				{monsterId = 10301, x = 58.66534, y = 82.67416, refreshTime = 36000000, objectType = 0},
				{monsterId = 10301, x = 53.13771, y = 76.48714, refreshTime = 36000000, objectType = 0},
				{monsterId = 10301, x = 59.42225, y = 76.63434, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10302, x = 55.66031, y = 61.21126, refreshTime = 36000000, objectType = 0},
				{monsterId = 10301, x = 52.58618, y = 60.16563, refreshTime = 36000000, objectType = 0},
				{monsterId = 10301, x = 58.2837, y = 58.81817, refreshTime = 36000000, objectType = 0},
				{monsterId = 10301, x = 52.56595, y = 57.06572, refreshTime = 36000000, objectType = 0},
				{monsterId = 10301, x = 55.75156, y = 56.49706, refreshTime = 36000000, objectType = 0},
				{monsterId = 10301, x = 51.65796, y = 52.25002, refreshTime = 36000000, objectType = 0},
				{monsterId = 10301, x = 55.4265, y = 51.5909, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10301, x = 47.62346, y = 43.6282, refreshTime = 36000000, objectType = 0},
				{monsterId = 10301, x = 43.97854, y = 47.41444, refreshTime = 36000000, objectType = 0},
				{monsterId = 10301, x = 45.11374, y = 41.0395, refreshTime = 36000000, objectType = 0},
				{monsterId = 10301, x = 44.44791, y = 35.88003, refreshTime = 36000000, objectType = 0},
				{monsterId = 10301, x = 40.76933, y = 39.05356, refreshTime = 36000000, objectType = 0},
				{monsterId = 10301, x = 39.93519, y = 44.02626, refreshTime = 36000000, objectType = 0},
				{monsterId = 10301, x = 37.42232, y = 46.13443, refreshTime = 36000000, objectType = 0},
				{monsterId = 10301, x = 36.29112, y = 42.95783, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10303, x = 19.37677, y = 26.20366, refreshTime = 36000000, objectType = 0},
				{monsterId = 10302, x = 26.4477, y = 26.24142, refreshTime = 36000000, objectType = 0},
				{monsterId = 10301, x = 21.42435, y = 29.10905, refreshTime = 36000000, objectType = 0},
				{monsterId = 10301, x = 23.07702, y = 24.89194, refreshTime = 36000000, objectType = 0},
				{monsterId = 10301, x = 23.52715, y = 21.64188, refreshTime = 36000000, objectType = 0},
				{monsterId = 10301, x = 18.04126, y = 22.20855, refreshTime = 36000000, objectType = 0},
				{monsterId = 10301, x = 15.45913, y = 27.47145, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},		
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190113,1,190114,1},		--奖励道具ID，数量
		exp = expreward[30].exp,
		money = expreward[30].money,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10303,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[30],
		exp = expreward[30],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][31] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 114,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {88.87335,27.0721},		--玩家出生点
	relivePostion = {88.87335,27.0721},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10311, x = 87.37914, y = 42.36925, refreshTime = 36000000, objectType = 0},
				{monsterId = 10311, x = 83.85556, y = 41.05111, refreshTime = 36000000, objectType = 0},
				{monsterId = 10311, x = 81.01735, y = 37.95748, refreshTime = 36000000, objectType = 0},
				{monsterId = 10311, x = 83.80877, y = 45.20929, refreshTime = 36000000, objectType = 0},
				{monsterId = 10311, x = 80.07755, y = 43.1534, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10312, x = 85.20884, y = 56.04264, refreshTime = 36000000, objectType = 0},
				{monsterId = 10311, x = 80.43531, y = 54.00211, refreshTime = 36000000, objectType = 0},
				{monsterId = 10311, x = 81.56388, y = 57.75055, refreshTime = 36000000, objectType = 0},
				{monsterId = 10311, x = 83.13521, y = 61.1479, refreshTime = 36000000, objectType = 0},
				{monsterId = 10311, x = 80.22697, y = 61.50633, refreshTime = 36000000, objectType = 0},
				{monsterId = 10311, x = 76.6636, y = 55.72234, refreshTime = 36000000, objectType = 0},
				{monsterId = 10311, x = 74.5317, y = 59.80232, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10311, x = 61.99059, y = 45.67871, refreshTime = 36000000, objectType = 0},
				{monsterId = 10311, x = 63.56883, y = 40.33514, refreshTime = 36000000, objectType = 0},
				{monsterId = 10311, x = 59.85136, y = 42.86594, refreshTime = 36000000, objectType = 0},
				{monsterId = 10311, x = 57.90731, y = 48.49379, refreshTime = 36000000, objectType = 0},
				{monsterId = 10311, x = 56.43409, y = 44.82215, refreshTime = 36000000, objectType = 0},
				{monsterId = 10311, x = 55.64939, y = 41.07936, refreshTime = 36000000, objectType = 0},
				{monsterId = 10311, x = 57.37675, y = 37.65092, refreshTime = 36000000, objectType = 0},
				{monsterId = 10311, x = 61.85502, y = 36.03162, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10313, x = 39.24698, y = 42.61049, refreshTime = 36000000, objectType = 0},
				{monsterId = 10312, x = 43.83002, y = 45.13659, refreshTime = 36000000, objectType = 0},
				{monsterId = 10311, x = 43.20063, y = 41.59325, refreshTime = 36000000, objectType = 0},
				{monsterId = 10311, x = 42.08621, y = 38.38134, refreshTime = 36000000, objectType = 0},
				{monsterId = 10311, x = 37.07201, y = 38.72478, refreshTime = 36000000, objectType = 0},
				{monsterId = 10311, x = 36.54724, y = 44.77206, refreshTime = 36000000, objectType = 0},
				{monsterId = 10311, x = 40.33352, y = 47.99334, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},		
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {nil,1},		--奖励道具ID，数量
		exp = 100,
		money = 100,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10313,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[31],
		exp = expreward[31],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][32] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 109,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {23.45637,33.8839},		--玩家出生点
	relivePostion = {23.45637,33.8839},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10321, x = 18.77847, y = 23.71939, refreshTime = 36000000, objectType = 0},
				{monsterId = 10321, x = 22.18481, y = 22.72137, refreshTime = 36000000, objectType = 0},
				{monsterId = 10321, x = 20.33523, y = 21.65485, refreshTime = 36000000, objectType = 0},
				{monsterId = 10321, x = 18.00318, y = 20.77474, refreshTime = 36000000, objectType = 0},
				{monsterId = 10321, x = 22.22733, y = 19.48494, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10322, x = 34.17637, y = 20.98178, refreshTime = 36000000, objectType = 0},
				{monsterId = 10321, x = 34.10236, y = 24.34708, refreshTime = 36000000, objectType = 0},
				{monsterId = 10321, x = 36.29025, y = 19.74372, refreshTime = 36000000, objectType = 0},
				{monsterId = 10321, x = 36.09402, y = 22.29695, refreshTime = 36000000, objectType = 0},
				{monsterId = 10321, x = 38.41089, y = 21.58457, refreshTime = 36000000, objectType = 0},
				{monsterId = 10321, x = 38.68144, y = 23.91112, refreshTime = 36000000, objectType = 0},
				{monsterId = 10321, x = 36.9185, y = 25.1696, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10321, x = 46.53795, y = 21.39294, refreshTime = 36000000, objectType = 0},
				{monsterId = 10321, x = 45.62496, y = 24.77638, refreshTime = 36000000, objectType = 0},
				{monsterId = 10321, x = 48.25091, y = 24.07564, refreshTime = 36000000, objectType = 0},
				{monsterId = 10321, x = 46.21679, y = 27.98092, refreshTime = 36000000, objectType = 0},
				{monsterId = 10321, x = 46.10332, y = 31.45771, refreshTime = 36000000, objectType = 0},
				{monsterId = 10321, x = 49.5336, y = 26.92212, refreshTime = 36000000, objectType = 0},
				{monsterId = 10321, x = 48.924, y = 28.82558, refreshTime = 36000000, objectType = 0},
				{monsterId = 10321, x = 50.30735, y = 29.35316, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10323, x = 60.32791, y = 26.61543, refreshTime = 36000000, objectType = 0},
				{monsterId = 10322, x = 57.23378, y = 23.88861, refreshTime = 36000000, objectType = 0},
				{monsterId = 10321, x = 56.77216, y = 27.76274, refreshTime = 36000000, objectType = 0},
				{monsterId = 10321, x = 59.6241, y = 24.18707, refreshTime = 36000000, objectType = 0},
				{monsterId = 10321, x = 62.47286, y = 24.49505, refreshTime = 36000000, objectType = 0},
				{monsterId = 10321, x = 60.28617, y = 29.31816, refreshTime = 36000000, objectType = 0},
				{monsterId = 10321, x = 63.31762, y = 29.03894, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {nil,1},		--奖励道具ID，数量
		exp = 100,
		money = 100,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10323,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[32],
		exp = expreward[32],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][33] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 109,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {81.84565,32.40579},		--玩家出生点
	relivePostion = {81.84565,32.40579},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10331, x = 79.84909, y = 22.67431, refreshTime = 36000000, objectType = 0},
				{monsterId = 10331, x = 79.66159, y = 20.00346, refreshTime = 36000000, objectType = 0},
				{monsterId = 10331, x = 77.99142, y = 22.54579, refreshTime = 36000000, objectType = 0},
				{monsterId = 10331, x = 75.01678, y = 25.2361, refreshTime = 36000000, objectType = 0},
				{monsterId = 10331, x = 74.8365, y = 21.23616, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10332, x = 63.05858, y = 28.16933, refreshTime = 36000000, objectType = 0},
				{monsterId = 10331, x = 61.22709, y = 29.05659, refreshTime = 36000000, objectType = 0},
				{monsterId = 10331, x = 61.81394, y = 24.89661, refreshTime = 36000000, objectType = 0},
				{monsterId = 10331, x = 59.9355, y = 25.98773, refreshTime = 36000000, objectType = 0},
				{monsterId = 10331, x = 56.62345, y = 29.07142, refreshTime = 36000000, objectType = 0},
				{monsterId = 10331, x = 55.43994, y = 25.7369, refreshTime = 36000000, objectType = 0},
				{monsterId = 10331, x = 57.278, y = 23.75986, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10331, x = 50.2637, y = 28.94547, refreshTime = 36000000, objectType = 0},
				{monsterId = 10331, x = 47.18538, y = 29.0195, refreshTime = 36000000, objectType = 0},
				{monsterId = 10331, x = 43.7824, y = 30.63199, refreshTime = 36000000, objectType = 0},
				{monsterId = 10331, x = 51.79811, y = 30.7834, refreshTime = 36000000, objectType = 0},
				{monsterId = 10331, x = 48.97096, y = 31.75612, refreshTime = 36000000, objectType = 0},
				{monsterId = 10331, x = 45.08164, y = 33.53521, refreshTime = 36000000, objectType = 0},
				{monsterId = 10331, x = 47.62942, y = 34.75485, refreshTime = 36000000, objectType = 0},
				{monsterId = 10331, x = 50.71114, y = 33.33166, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10333, x = 55.51801, y = 47.26644, refreshTime = 36000000, objectType = 0},
				{monsterId = 10332, x = 52.7417, y = 43.59679, refreshTime = 36000000, objectType = 0},
				{monsterId = 10331, x = 49.98846, y = 47.12726, refreshTime = 36000000, objectType = 0},
				{monsterId = 10331, x = 53.40018, y = 49.79979, refreshTime = 36000000, objectType = 0},
				{monsterId = 10331, x = 59.1291, y = 49.08017, refreshTime = 36000000, objectType = 0},
				{monsterId = 10331, x = 59.63184, y = 44.96372, refreshTime = 36000000, objectType = 0},
				{monsterId = 10331, x = 57.38722, y = 42.77325, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {nil,1},		--奖励道具ID，数量
		exp = 100,
		money = 100,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10333,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[33],
		exp = expreward[33],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][34] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 109,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {82.69886,52.96371},		--玩家出生点
	relivePostion = {82.69886,52.96371},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10341, x = 77.6726, y = 31.51602, refreshTime = 36000000, objectType = 0},
				{monsterId = 10341, x = 82.21053, y = 29.96275, refreshTime = 36000000, objectType = 0},
				{monsterId = 10341, x = 78.68791, y = 27.87644, refreshTime = 36000000, objectType = 0},
				{monsterId = 10341, x = 80.82744, y = 22.41934, refreshTime = 36000000, objectType = 0},
				{monsterId = 10341, x = 76.00536, y = 24.19637, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10342, x = 53.89941, y = 24.70162, refreshTime = 36000000, objectType = 0},
				{monsterId = 10341, x = 50.87709, y = 25.42738, refreshTime = 36000000, objectType = 0},
				{monsterId = 10341, x = 48.42723, y = 23.51261, refreshTime = 36000000, objectType = 0},
				{monsterId = 10341, x = 51.20398, y = 30.23088, refreshTime = 36000000, objectType = 0},
				{monsterId = 10341, x = 48.92953, y = 29.03237, refreshTime = 36000000, objectType = 0},
				{monsterId = 10341, x = 46.08659, y = 27.9174, refreshTime = 36000000, objectType = 0},
				{monsterId = 10341, x = 48.14427, y = 32.62351, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10341, x = 56.61346, y = 48.70325, refreshTime = 36000000, objectType = 0},
				{monsterId = 10341, x = 52.25848, y = 49.96054, refreshTime = 36000000, objectType = 0},
				{monsterId = 10341, x = 53.27415, y = 46.59727, refreshTime = 36000000, objectType = 0},
				{monsterId = 10341, x = 54.68356, y = 44.5396, refreshTime = 36000000, objectType = 0},
				{monsterId = 10341, x = 50.2542, y = 46.40582, refreshTime = 36000000, objectType = 0},
				{monsterId = 10341, x = 46.67792, y = 49.1954, refreshTime = 36000000, objectType = 0},
				{monsterId = 10341, x = 47.70446, y = 46.69388, refreshTime = 36000000, objectType = 0},
				{monsterId = 10341, x = 44.02573, y = 45.75854, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10343, x = 27.94749, y = 56.97218, refreshTime = 36000000, objectType = 0},
				{monsterId = 10342, x = 34.40017, y = 55.95432, refreshTime = 36000000, objectType = 0},
				{monsterId = 10341, x = 32.22503, y = 59.45817, refreshTime = 36000000, objectType = 0},
				{monsterId = 10341, x = 28.51045, y = 51.46804, refreshTime = 36000000, objectType = 0},
				{monsterId = 10341, x = 24.43317, y = 53.47755, refreshTime = 36000000, objectType = 0},
				{monsterId = 10341, x = 26.67492, y = 62.45137, refreshTime = 36000000, objectType = 0},
				{monsterId = 10341, x = 20.84341, y = 57.08208, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {nil,1},		--奖励道具ID，数量
		exp = 100,
		money = 100,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10343,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[34],
		exp = expreward[34],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][35] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 109,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {31.94204,20.84713},		--玩家出生点
	relivePostion = {31.94204,20.84713},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 42.19727, y = 23.18497, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 47.03208, y = 23.59532, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 43.28428, y = 27.05556, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 45.24273, y = 28.14882, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 48.29012, y = 27.90702, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 45.95739, y = 31.36889, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10352, x = 56.08464, y = 45.90388, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 52.90921, y = 44.23235, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 57.99546, y = 50.51515, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 55.1471, y = 49.06413, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 54.47236, y = 54.53718, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 52.04014, y = 52.89193, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 50.08386, y = 48.3211, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 35.68336, y = 48.57583, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.79293, y = 53.45045, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 33.62408, y = 51.78503, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 31.63762, y = 50.13917, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.26381, y = 59.82852, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 32.38816, y = 58.54339, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 32.26617, y = 54.31804, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 29.64622, y = 51.99772, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10353, x = 25.25335, y = 61.88108, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 27.72755, y = 62.99622, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 27.02809, y = 59.00799, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 23.88666, y = 57.34204, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 22.26503, y = 62.12851, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 24.18572, y = 65.6876, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 27.1965, y = 66.38168, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190311,1,190401,1,190411,1},		--奖励道具ID，数量
		exp = 100,
		money = 100,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10353,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[35],
		exp = expreward[35],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][36] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 109,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {35.21942,23.39644},		--玩家出生点
	relivePostion = {35.21942,23.39644},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10361, x = 49.74173, y = 23.0599, refreshTime = 36000000, objectType = 0},
				{monsterId = 10361, x = 49.19603, y = 29.25719, refreshTime = 36000000, objectType = 0},
				{monsterId = 10361, x = 54.6159, y = 23.92988, refreshTime = 36000000, objectType = 0},
				{monsterId = 10361, x = 56.03352, y = 29.49492, refreshTime = 36000000, objectType = 0},
				{monsterId = 10361, x = 59.87098, y = 25.34761, refreshTime = 36000000, objectType = 0},
				{monsterId = 10361, x = 62.19731, y = 28.24389, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10362, x = 77.43642, y = 20.34969, refreshTime = 36000000, objectType = 0},
				{monsterId = 10361, x = 76.13668, y = 25.23325, refreshTime = 36000000, objectType = 0},
				{monsterId = 10361, x = 82.86733, y = 20.23098, refreshTime = 36000000, objectType = 0},
				{monsterId = 10361, x = 80.8418, y = 23.07432, refreshTime = 36000000, objectType = 0},
				{monsterId = 10361, x = 83.49668, y = 25.58406, refreshTime = 36000000, objectType = 0},
				{monsterId = 10361, x = 78.86532, y = 27.10102, refreshTime = 36000000, objectType = 0},
				{monsterId = 10361, x = 80.9724, y = 29.39352, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10361, x = 85.28093, y = 43.65465, refreshTime = 36000000, objectType = 0},
				{monsterId = 10361, x = 81.73005, y = 42.81301, refreshTime = 36000000, objectType = 0},
				{monsterId = 10361, x = 84.53301, y = 48.72785, refreshTime = 36000000, objectType = 0},
				{monsterId = 10361, x = 80.9193, y = 48.58479, refreshTime = 36000000, objectType = 0},
				{monsterId = 10361, x = 84.30303, y = 52.52066, refreshTime = 36000000, objectType = 0},
				{monsterId = 10361, x = 80.6224, y = 54.54952, refreshTime = 36000000, objectType = 0},
				{monsterId = 10361, x = 77.10821, y = 54.89049, refreshTime = 36000000, objectType = 0},
				{monsterId = 10361, x = 75.44925, y = 51.56125, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10363, x = 55.94487, y = 51.0196, refreshTime = 36000000, objectType = 0},
				{monsterId = 10362, x = 60.57721, y = 52.15982, refreshTime = 36000000, objectType = 0},
				{monsterId = 10361, x = 60.51739, y = 45.16851, refreshTime = 36000000, objectType = 0},
				{monsterId = 10361, x = 56.26514, y = 45.03348, refreshTime = 36000000, objectType = 0},
				{monsterId = 10361, x = 51.67666, y = 48.97256, refreshTime = 36000000, objectType = 0},
				{monsterId = 10361, x = 51.53329, y = 54.00166, refreshTime = 36000000, objectType = 0},
				{monsterId = 10361, x = 55.57322, y = 56.2583, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190311,1,190401,1,190411,1},		--奖励道具ID，数量
		exp = 100,
		money = 100,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10363,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[36],
		exp = expreward[36],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][37] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 123,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {100.6939,53.01402},		--玩家出生点
	relivePostion = {100.6939,53.01402},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10371, x = 88.39776, y = 57.05326, refreshTime = 36000000, objectType = 0},
				{monsterId = 10371, x = 83.51572, y = 56.1546, refreshTime = 36000000, objectType = 0},
				{monsterId = 10371, x = 85.36502, y = 53.45294, refreshTime = 36000000, objectType = 0},
				{monsterId = 10371, x = 84.08974, y = 50.2523, refreshTime = 36000000, objectType = 0},
				{monsterId = 10371, x = 88.32497, y = 50.04269, refreshTime = 36000000, objectType = 0},
				{monsterId = 10371, x = 85.29939, y = 47.25344, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10372, x = 79.14083, y = 27.84985, refreshTime = 36000000, objectType = 0},
				{monsterId = 10371, x = 76.05218, y = 25.89399, refreshTime = 36000000, objectType = 0},
				{monsterId = 10371, x = 73.82935, y = 28.9829, refreshTime = 36000000, objectType = 0},
				{monsterId = 10371, x = 71.59013, y = 26.21296, refreshTime = 36000000, objectType = 0},
				{monsterId = 10371, x = 75.47955, y = 19.95208, refreshTime = 36000000, objectType = 0},
				{monsterId = 10371, x = 70.60282, y = 19.21868, refreshTime = 36000000, objectType = 0},
				{monsterId = 10371, x = 65.18112, y = 17.68162, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10371, x = 47.30155, y = 27.24999, refreshTime = 36000000, objectType = 0},
				{monsterId = 10371, x = 43.65887, y = 27.48568, refreshTime = 36000000, objectType = 0},
				{monsterId = 10371, x = 46.37978, y = 31.78624, refreshTime = 36000000, objectType = 0},
				{monsterId = 10371, x = 40.48364, y = 31.10627, refreshTime = 36000000, objectType = 0},
				{monsterId = 10371, x = 43.51576, y = 34.3106, refreshTime = 36000000, objectType = 0},
				{monsterId = 10371, x = 46.05423, y = 38.52645, refreshTime = 36000000, objectType = 0},
				{monsterId = 10371, x = 39.93427, y = 37.28601, refreshTime = 36000000, objectType = 0},
				{monsterId = 10371, x = 41.29685, y = 41.60717, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10373, x = 49.58797, y = 68.06515, refreshTime = 36000000, objectType = 0},
				{monsterId = 10372, x = 43.03925, y = 61.06804, refreshTime = 36000000, objectType = 0},
				{monsterId = 10371, x = 40.93076, y = 66.39553, refreshTime = 36000000, objectType = 0},
				{monsterId = 10371, x = 42.95413, y = 69.69229, refreshTime = 36000000, objectType = 0},
				{monsterId = 10371, x = 47.20208, y = 70.6391, refreshTime = 36000000, objectType = 0},
				{monsterId = 10371, x = 49.77483, y = 63.37484, refreshTime = 36000000, objectType = 0},
				{monsterId = 10371, x = 46.09449, y = 65.66648, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190311,1,190401,1,190411,1},		--奖励道具ID，数量
		exp = 100,
		money = 100,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10373,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[37],
		exp = expreward[37],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][38] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 123,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {99.21444,79.21157},		--玩家出生点
	relivePostion = {99.21444,79.21157},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
			[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10381, x = 96.08317, y = 57.89112, refreshTime = 36000000, objectType = 0},
				{monsterId = 10381, x = 100.1926, y = 57.78797, refreshTime = 36000000, objectType = 0},
				{monsterId = 10381, x = 96.47224, y = 53.23814, refreshTime = 36000000, objectType = 0},
				{monsterId = 10381, x = 101.5632, y = 53.60362, refreshTime = 36000000, objectType = 0},
				{monsterId = 10381, x = 107.2367, y = 51.47145, refreshTime = 36000000, objectType = 0},
				{monsterId = 10381, x = 107.2871, y = 55.59231, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10382, x = 127.9287, y = 43.59426, refreshTime = 36000000, objectType = 0},
				{monsterId = 10381, x = 126.6447, y = 48.23957, refreshTime = 36000000, objectType = 0},
				{monsterId = 10381, x = 126.2477, y = 52.38166, refreshTime = 36000000, objectType = 0},
				{monsterId = 10381, x = 127.1343, y = 56.79072, refreshTime = 36000000, objectType = 0},
				{monsterId = 10381, x = 133.9998, y = 44.19843, refreshTime = 36000000, objectType = 0},
				{monsterId = 10381, x = 139.009, y = 52.6033, refreshTime = 36000000, objectType = 0},
				{monsterId = 10381, x = 133.8058, y = 56.07779, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10381, x = 153.7445, y = 66.74954, refreshTime = 36000000, objectType = 0},
				{monsterId = 10381, x = 150.7637, y = 68.78247, refreshTime = 36000000, objectType = 0},
				{monsterId = 10381, x = 148.1254, y = 71.04922, refreshTime = 36000000, objectType = 0},
				{monsterId = 10381, x = 158.7529, y = 67.89338, refreshTime = 36000000, objectType = 0},
				{monsterId = 10381, x = 161.584, y = 71.59819, refreshTime = 36000000, objectType = 0},
				{monsterId = 10381, x = 161.8074, y = 76.04758, refreshTime = 36000000, objectType = 0},
				{monsterId = 10381, x = 157.9496, y = 80.52544, refreshTime = 36000000, objectType = 0},
				{monsterId = 10381, x = 152.0479, y = 77.68217, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10383, x = 175.8312, y = 117.8099, refreshTime = 36000000, objectType = 0},
				{monsterId = 10382, x = 175.4937, y = 109.7021, refreshTime = 36000000, objectType = 0},
				{monsterId = 10381, x = 168.877, y = 112.2124, refreshTime = 36000000, objectType = 0},
				{monsterId = 10381, x = 168.0216, y = 116.6862, refreshTime = 36000000, objectType = 0},
				{monsterId = 10381, x = 168.7085, y = 122.1849, refreshTime = 36000000, objectType = 0},
				{monsterId = 10381, x = 182.4309, y = 118.3247, refreshTime = 36000000, objectType = 0},
				{monsterId = 10381, x = 179.0545, y = 112.0652, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {nil,1},		--奖励道具ID，数量
		exp = 100,
		money = 100,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10383,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[38],
		exp = expreward[38],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][39] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 123,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {61.77021,90.46613},		--玩家出生点
	relivePostion = {61.77021,90.46613},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
			[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10391, x = 48.99741, y = 92.87294, refreshTime = 36000000, objectType = 0},
				{monsterId = 10391, x = 49.35578, y = 88.49031, refreshTime = 36000000, objectType = 0},
				{monsterId = 10391, x = 45.74992, y = 94.7898, refreshTime = 36000000, objectType = 0},
				{monsterId = 10391, x = 46.46477, y = 90.4185, refreshTime = 36000000, objectType = 0},
				{monsterId = 10391, x = 46.5269, y = 86.45752, refreshTime = 36000000, objectType = 0},
				{monsterId = 10391, x = 48.55319, y = 90.74655, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10392, x = 30.72187, y = 87.32916, refreshTime = 36000000, objectType = 0},
				{monsterId = 10391, x = 32.46074, y = 84.6872, refreshTime = 36000000, objectType = 0},
				{monsterId = 10391, x = 36.84496, y = 86.28255, refreshTime = 36000000, objectType = 0},
				{monsterId = 10391, x = 27.5645, y = 82.06509, refreshTime = 36000000, objectType = 0},
				{monsterId = 10391, x = 29.11147, y = 79.18194, refreshTime = 36000000, objectType = 0},
				{monsterId = 10391, x = 33.26229, y = 80.10442, refreshTime = 36000000, objectType = 0},
				{monsterId = 10391, x = 37.88396, y = 82.71354, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10391, x = 39.46205, y = 64.9566, refreshTime = 36000000, objectType = 0},
				{monsterId = 10391, x = 41.89142, y = 68.76314, refreshTime = 36000000, objectType = 0},
				{monsterId = 10391, x = 47.76605, y = 72.57336, refreshTime = 36000000, objectType = 0},
				{monsterId = 10391, x = 46.53498, y = 68.27154, refreshTime = 36000000, objectType = 0},
				{monsterId = 10391, x = 51.51949, y = 69.46333, refreshTime = 36000000, objectType = 0},
				{monsterId = 10391, x = 43.937, y = 63.9597, refreshTime = 36000000, objectType = 0},
				{monsterId = 10391, x = 48.43767, y = 64.79688, refreshTime = 36000000, objectType = 0},
				{monsterId = 10391, x = 53.86111, y = 66.53448, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10393, x = 36.88848, y = 40.23019, refreshTime = 36000000, objectType = 0},
				{monsterId = 10392, x = 35.08, y = 46.86572, refreshTime = 36000000, objectType = 0},
				{monsterId = 10391, x = 34.06163, y = 42.40444, refreshTime = 36000000, objectType = 0},
				{monsterId = 10391, x = 37.43732, y = 42.72559, refreshTime = 36000000, objectType = 0},
				{monsterId = 10391, x = 40.04487, y = 38.53357, refreshTime = 36000000, objectType = 0},
				{monsterId = 10391, x = 41.43864, y = 43.14894, refreshTime = 36000000, objectType = 0},
				{monsterId = 10391, x = 41.52346, y = 47.33206, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190311,1,190401,1,190411,1},		--奖励道具ID，数量
		exp = 100,
		money = 100,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10393,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[39],
		exp = expreward[39],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][40] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 123,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {99.08639,79.82887},		--玩家出生点
	relivePostion = {99.08639,79.82887},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10401, x = 94.52017, y = 57.43059, refreshTime = 36000000, objectType = 0},
				{monsterId = 10401, x = 93.1513, y = 47.79405, refreshTime = 36000000, objectType = 0},
				{monsterId = 10401, x = 90.95471, y = 52.97675, refreshTime = 36000000, objectType = 0},
				{monsterId = 10401, x = 85.42162, y = 55.37304, refreshTime = 36000000, objectType = 0},
				{monsterId = 10401, x = 82.97605, y = 50.90179, refreshTime = 36000000, objectType = 0},
				{monsterId = 10401, x = 86.17518, y = 48.65981, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10402, x = 81.01682, y = 24.4397, refreshTime = 36000000, objectType = 0},
				{monsterId = 10401, x = 78.72842, y = 28.20691, refreshTime = 36000000, objectType = 0},
				{monsterId = 10401, x = 74.32771, y = 28.56387, refreshTime = 36000000, objectType = 0},
				{monsterId = 10401, x = 73.49305, y = 24.97997, refreshTime = 36000000, objectType = 0},
				{monsterId = 10401, x = 69.59283, y = 26.15153, refreshTime = 36000000, objectType = 0},
				{monsterId = 10401, x = 74.93178, y = 19.88087, refreshTime = 36000000, objectType = 0},
				{monsterId = 10401, x = 71.51648, y = 18.88255, refreshTime = 36000000, objectType = 0},
				{monsterId = 10401, x = 67.47897, y = 19.53374, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10401, x = 47.58178, y = 25.90177, refreshTime = 36000000, objectType = 0},
				{monsterId = 10401, x = 47.30815, y = 20.93235, refreshTime = 36000000, objectType = 0},
				{monsterId = 10401, x = 47.78456, y = 16.85615, refreshTime = 36000000, objectType = 0},
				{monsterId = 10401, x = 44.50674, y = 27.26299, refreshTime = 36000000, objectType = 0},
				{monsterId = 10401, x = 44.8094, y = 23.15339, refreshTime = 36000000, objectType = 0},
				{monsterId = 10401, x = 42.06014, y = 24.823, refreshTime = 36000000, objectType = 0},
				{monsterId = 10401, x = 42.88264, y = 19.72818, refreshTime = 36000000, objectType = 0},
				{monsterId = 10401, x = 44.3338, y = 17.73939, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10403, x = 33.29573, y = 20.44008, refreshTime = 36000000, objectType = 0},
				{monsterId = 10402, x = 37.26199, y = 22.39397, refreshTime = 36000000, objectType = 0},
				{monsterId = 10401, x = 38.71817, y = 15.65448, refreshTime = 36000000, objectType = 0},
				{monsterId = 10401, x = 34.51299, y = 25.56729, refreshTime = 36000000, objectType = 0},
				{monsterId = 10401, x = 330.99589, y = 24.97347, refreshTime = 36000000, objectType = 0},
				{monsterId = 10401, x = 29.91607, y = 19.70828, refreshTime = 36000000, objectType = 0},
				{monsterId = 10401, x = 32.83599, y = 15.18097, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},	
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190311,1,190401,1,190411,1},		--奖励道具ID，数量
		exp = 100,
		money = 100,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10403,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[40],
		exp = expreward[40],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][41] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 123,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {148.7616,129.6792},		--玩家出生点
	relivePostion = {148.7616,129.6792},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10411, x = 141.2607, y = 135.2334, refreshTime = 36000000, objectType = 0},
				{monsterId = 10411, x = 137.3592, y = 132.4435, refreshTime = 36000000, objectType = 0},
				{monsterId = 10411, x = 138.3229, y = 127.8, refreshTime = 36000000, objectType = 0},
				{monsterId = 10411, x = 137.5074, y = 138.5339, refreshTime = 36000000, objectType = 0},
				{monsterId = 10411, x = 134.1882, y = 134.9074, refreshTime = 36000000, objectType = 0},
				{monsterId = 10411, x = 133.7142, y = 130.2357, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10412, x = 115.8445, y = 118.5746, refreshTime = 36000000, objectType = 0},
				{monsterId = 10411, x = 114.3775, y = 113.4096, refreshTime = 36000000, objectType = 0},
				{monsterId = 10411, x = 110.9213, y = 119.0097, refreshTime = 36000000, objectType = 0},
				{monsterId = 10411, x = 109.4828, y = 115.1764, refreshTime = 36000000, objectType = 0},
				{monsterId = 10411, x = 110.1461, y = 111.4977, refreshTime = 36000000, objectType = 0},
				{monsterId = 10411, x = 106.6829, y = 115.9671, refreshTime = 36000000, objectType = 0},
				{monsterId = 10411, x = 103.4841, y = 113.0791, refreshTime = 36000000, objectType = 0},
				{monsterId = 10411, x = 106.8018, y = 111.0633, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10411, x = 93.74752, y = 113.2876, refreshTime = 36000000, objectType = 0},
				{monsterId = 10411, x = 91.37993, y = 112.0989, refreshTime = 36000000, objectType = 0},
				{monsterId = 10411, x = 92.50932, y = 108.8982, refreshTime = 36000000, objectType = 0},
				{monsterId = 10411, x = 87.84589, y = 107.2081, refreshTime = 36000000, objectType = 0},
				{monsterId = 10411, x = 90.55437, y = 116.2564, refreshTime = 36000000, objectType = 0},
				{monsterId = 10411, x = 88.38631, y = 112.2871, refreshTime = 36000000, objectType = 0},
				{monsterId = 10411, x = 87.96788, y = 118.2762, refreshTime = 36000000, objectType = 0},
				{monsterId = 10411, x = 84.63853, y = 117.1666, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10413, x = 66.21617, y = 130.9195, refreshTime = 36000000, objectType = 0},
				{monsterId = 10412, x = 78.02312, y = 133.0474, refreshTime = 36000000, objectType = 0},
				{monsterId = 10411, x = 75.91379, y = 125.8381, refreshTime = 36000000, objectType = 0},
				{monsterId = 10411, x = 71.48392, y = 132.4119, refreshTime = 36000000, objectType = 0},
				{monsterId = 10411, x = 68.90253, y = 125.4622, refreshTime = 36000000, objectType = 0},
				{monsterId = 10411, x = 65.88491, y = 134.4874, refreshTime = 36000000, objectType = 0},
				{monsterId = 10411, x = 64.1115, y = 125.926, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},	
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190311,1,190401,1,190411,1},		--奖励道具ID，数量
		exp = 100,
		money = 100,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10413,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[41],
		exp = expreward[41],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][42] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 105,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {24.69042,14.5579},		--玩家出生点
	relivePostion = {24.69042,14.5579},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10421, x = 36.28242, y = 17.75733, refreshTime = 36000000, objectType = 0},
				{monsterId = 10421, x = 33.17037, y = 20.79428, refreshTime = 36000000, objectType = 0},
				{monsterId = 10421, x = 33.88842, y = 22.74742, refreshTime = 36000000, objectType = 0},
				{monsterId = 10421, x = 38.39743, y = 21.54362, refreshTime = 36000000, objectType = 0},
				{monsterId = 10421, x = 35.92449, y = 23.74704, refreshTime = 36000000, objectType = 0},
				{monsterId = 10421, x = 34.55413, y = 25.55204, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10422, x = 46.06295, y = 33.04417, refreshTime = 36000000, objectType = 0},
				{monsterId = 10421, x = 43.10629, y = 36.81452, refreshTime = 36000000, objectType = 0},
				{monsterId = 10421, x = 46.31813, y = 37.96187, refreshTime = 36000000, objectType = 0},
				{monsterId = 10421, x = 46.47255, y = 40.76152, refreshTime = 36000000, objectType = 0},
				{monsterId = 10421, x = 49.65107, y = 36.43568, refreshTime = 36000000, objectType = 0},
				{monsterId = 10421, x = 53.93472, y = 35.25409, refreshTime = 36000000, objectType = 0},
				{monsterId = 10421, x = 52.34652, y = 39.54883, refreshTime = 36000000, objectType = 0},
				{monsterId = 10421, x = 50.95039, y = 42.50456, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10421, x = 64.4399, y = 36.14415, refreshTime = 36000000, objectType = 0},
				{monsterId = 10421, x = 65.43333, y = 41.15841, refreshTime = 36000000, objectType = 0},
				{monsterId = 10421, x = 65.36606, y = 45.09845, refreshTime = 36000000, objectType = 0},
				{monsterId = 10421, x = 68.14851, y = 35.71557, refreshTime = 36000000, objectType = 0},
				{monsterId = 10421, x = 67.55132, y = 38.79715, refreshTime = 36000000, objectType = 0},
				{monsterId = 10421, x = 68.54163, y = 42.10769, refreshTime = 36000000, objectType = 0},
				{monsterId = 10421, x = 70.5835, y = 44.09096, refreshTime = 36000000, objectType = 0},
				{monsterId = 10421, x = 72.28489, y = 39.936, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10423, x = 62.10975, y = 14.50244, refreshTime = 36000000, objectType = 0},
				{monsterId = 10422, x = 62.52137, y = 16.93143, refreshTime = 36000000, objectType = 0},
				{monsterId = 10421, x = 66.80221, y = 16.29003, refreshTime = 36000000, objectType = 0},
				{monsterId = 10421, x = 67.77641, y = 11.57098, refreshTime = 36000000, objectType = 0},
				{monsterId = 10421, x = 63.03609, y = 11.96618, refreshTime = 36000000, objectType = 0},
				{monsterId = 10421, x = 59.06435, y = 10.5447, refreshTime = 36000000, objectType = 0},
				{monsterId = 10421, x = 58.12127, y = 15.8081, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},	
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190311,1,190401,1,190411,1},		--奖励道具ID，数量
		exp = 100,
		money = 100,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10423,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[42],
		exp = expreward[42],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][43] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 105,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {84.07484,75.37902},		--玩家出生点
	relivePostion = {84.07484,75.37902},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10431, x = 71.01437, y = 69.85186, refreshTime = 36000000, objectType = 0},
				{monsterId = 10431, x = 72.43286, y = 65.6859, refreshTime = 36000000, objectType = 0},
				{monsterId = 10431, x = 74.83897, y = 63.96081, refreshTime = 36000000, objectType = 0},
				{monsterId = 10431, x = 68.6273, y = 65.22736, refreshTime = 36000000, objectType = 0},
				{monsterId = 10431, x = 70.71964, y = 64.40239, refreshTime = 36000000, objectType = 0},
				{monsterId = 10431, x = 74.29738, y = 61.72155, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10432, x = 61.36834, y = 45.10471, refreshTime = 36000000, objectType = 0},
				{monsterId = 10431, x = 68.57688, y = 46.26605, refreshTime = 36000000, objectType = 0},
				{monsterId = 10431, x = 66.39257, y = 43.20699, refreshTime = 36000000, objectType = 0},
				{monsterId = 10431, x = 62.00016, y = 41.18732, refreshTime = 36000000, objectType = 0},
				{monsterId = 10431, x = 63.65604, y = 36.43206, refreshTime = 36000000, objectType = 0},
				{monsterId = 10431, x = 66.68774, y = 39.81617, refreshTime = 36000000, objectType = 0},
				{monsterId = 10431, x = 71.23844, y = 41.17593, refreshTime = 36000000, objectType = 0},
				{monsterId = 10431, x = 68.56082, y = 37.75597, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10431, x = 48.0497, y = 42.2674, refreshTime = 36000000, objectType = 0},
				{monsterId = 10431, x = 50.51994, y = 36.04623, refreshTime = 36000000, objectType = 0},
				{monsterId = 10431, x = 47.19919, y = 36.49868, refreshTime = 36000000, objectType = 0},
				{monsterId = 10431, x = 43.79672, y = 37.46823, refreshTime = 36000000, objectType = 0},
				{monsterId = 10431, x = 40.86155, y = 35.32056, refreshTime = 36000000, objectType = 0},
				{monsterId = 10431, x = 43.13229, y = 32.90882, refreshTime = 36000000, objectType = 0},
				{monsterId = 10431, x = 45.52971, y = 31.9866, refreshTime = 36000000, objectType = 0},
				{monsterId = 10431, x = 43.07561, y = 29.84602, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10433, x = 28.54176, y = 20.48877, refreshTime = 36000000, objectType = 0},
				{monsterId = 10432, x = 31.8591, y = 24.85611, refreshTime = 36000000, objectType = 0},
				{monsterId = 10431, x = 33.88252, y = 19.272, refreshTime = 36000000, objectType = 0},
				{monsterId = 10431, x = 25.90749, y = 26.0305, refreshTime = 36000000, objectType = 0},
				{monsterId = 10431, x = 25.7274, y = 22.49543, refreshTime = 36000000, objectType = 0},
				{monsterId = 10431, x = 25.83135, y = 17.84967, refreshTime = 36000000, objectType = 0},
				{monsterId = 10431, x = 29.39594, y = 14.18922, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},	
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190311,1,190401,1,190411,1},		--奖励道具ID，数量
		exp = 100,
		money = 100,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10433,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[43],
		exp = expreward[43],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][44] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 105,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {31.57128,20.36628},		--玩家出生点
	relivePostion = {31.57128,20.36628},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10441, x = 44.72308, y = 32.51716, refreshTime = 36000000, objectType = 0},
				{monsterId = 10441, x = 42.0344, y = 35.66688, refreshTime = 36000000, objectType = 0},
				{monsterId = 10441, x = 48.67028, y = 35.08292, refreshTime = 36000000, objectType = 0},
				{monsterId = 10441, x = 46.13266, y = 36.62017, refreshTime = 36000000, objectType = 0},
				{monsterId = 10441, x = 45.01422, y = 40.47611, refreshTime = 36000000, objectType = 0},
				{monsterId = 10441, x = 50.34761, y = 39.92954, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10442, x = 68.95251, y = 37.77237, refreshTime = 36000000, objectType = 0},
				{monsterId = 10441, x = 66.8112, y = 40.21465, refreshTime = 36000000, objectType = 0},
				{monsterId = 10441, x = 64.10591, y = 40.49337, refreshTime = 36000000, objectType = 0},
				{monsterId = 10441, x = 63.64537, y = 42.82172, refreshTime = 36000000, objectType = 0},
				{monsterId = 10441, x = 68.42191, y = 42.28255, refreshTime = 36000000, objectType = 0},
				{monsterId = 10441, x = 64.15506, y = 45.90525, refreshTime = 36000000, objectType = 0},
				{monsterId = 10441, x = 60.53894, y = 45.73657, refreshTime = 36000000, objectType = 0},
				{monsterId = 10441, x = 60.13763, y = 42.81577, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10441, x = 75.73246, y = 65.93179, refreshTime = 36000000, objectType = 0},
				{monsterId = 10441, x = 73.14919, y = 67.90905, refreshTime = 36000000, objectType = 0},
				{monsterId = 10441, x = 70.53195, y = 67.89203, refreshTime = 36000000, objectType = 0},
				{monsterId = 10441, x = 78.8651, y = 70.14008, refreshTime = 36000000, objectType = 0},
				{monsterId = 10441, x = 74.11151, y = 70.72974, refreshTime = 36000000, objectType = 0},
				{monsterId = 10441, x = 79.55361, y = 74.08087, refreshTime = 36000000, objectType = 0},
				{monsterId = 10441, x = 76.10542, y = 74.76697, refreshTime = 36000000, objectType = 0},
				{monsterId = 10441, x = 73.38187, y = 73.81024, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10443, x = 46.84863, y = 75.93208, refreshTime = 36000000, objectType = 0},
				{monsterId = 10442, x = 49.49418, y = 73.0038, refreshTime = 36000000, objectType = 0},
				{monsterId = 10441, x = 44.19062, y = 71.74249, refreshTime = 36000000, objectType = 0},
				{monsterId = 10441, x = 39.87793, y = 74.31836, refreshTime = 36000000, objectType = 0},
				{monsterId = 10441, x = 41.91114, y = 78.936, refreshTime = 36000000, objectType = 0},
				{monsterId = 10441, x = 47.88297, y = 80.57544, refreshTime = 36000000, objectType = 0},
				{monsterId = 10441, x = 51.31685, y = 79.04648, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},	
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190311,1,190401,1,190411,1},		--奖励道具ID，数量
		exp = 100,
		money = 100,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10443,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[44],
		exp = expreward[44],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][45] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 105,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {10.93998,41.35875},		--玩家出生点
	relivePostion = {10.93998,41.35875},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10451, x = 17.98077, y = 53.08575, refreshTime = 36000000, objectType = 0},
				{monsterId = 10451, x = 15.48637, y = 55.65106, refreshTime = 36000000, objectType = 0},
				{monsterId = 10451, x = 20.66811, y = 54.76222, refreshTime = 36000000, objectType = 0},
				{monsterId = 10451, x = 18.85346, y = 57.37519, refreshTime = 36000000, objectType = 0},
				{monsterId = 10451, x = 15.80732, y = 58.94375, refreshTime = 36000000, objectType = 0},
				{monsterId = 10451, x = 21.9684, y = 57.60093, refreshTime = 36000000, objectType = 0},
				{monsterId = 10451, x = 19.94392, y = 60.97052, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10452, x = 31.37759, y = 74.70718, refreshTime = 36000000, objectType = 0},
				{monsterId = 10451, x = 32.19449, y = 80.64211, refreshTime = 36000000, objectType = 0},
				{monsterId = 10451, x = 36.44262, y = 70.61764, refreshTime = 36000000, objectType = 0},
				{monsterId = 10451, x = 37.57035, y = 75.66724, refreshTime = 36000000, objectType = 0},
				{monsterId = 10451, x = 38.38055, y = 80.47119, refreshTime = 36000000, objectType = 0},
				{monsterId = 10451, x = 41.84302, y = 69.8907, refreshTime = 36000000, objectType = 0},
				{monsterId = 10451, x = 49.16172, y = 74.23391, refreshTime = 36000000, objectType = 0},
				{monsterId = 10451, x = 46.29391, y = 80.49515, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10451, x = 69.96545, y = 67.86898, refreshTime = 36000000, objectType = 0},
				{monsterId = 10451, x = 74.16654, y = 72.99574, refreshTime = 36000000, objectType = 0},
				{monsterId = 10451, x = 77.59718, y = 76.43445, refreshTime = 36000000, objectType = 0},
				{monsterId = 10451, x = 74.84803, y = 66.29321, refreshTime = 36000000, objectType = 0},
				{monsterId = 10451, x = 77.92848, y = 70.16883, refreshTime = 36000000, objectType = 0},
				{monsterId = 10451, x = 82.77013, y = 75.34982, refreshTime = 36000000, objectType = 0},
				{monsterId = 10451, x = 84.68906, y = 69.88778, refreshTime = 36000000, objectType = 0},
				{monsterId = 10451, x = 80.6384, y = 65.01408, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10453, x = 62.82692, y = 42.05733, refreshTime = 36000000, objectType = 0},
				{monsterId = 10452, x = 58.96363, y = 44.40963, refreshTime = 36000000, objectType = 0},
				{monsterId = 10451, x = 66.79374, y = 45.79596, refreshTime = 36000000, objectType = 0},
				{monsterId = 10451, x = 54.67779, y = 39.33466, refreshTime = 36000000, objectType = 0},
				{monsterId = 10451, x = 59.11451, y = 37.09842, refreshTime = 36000000, objectType = 0},
				{monsterId = 10451, x = 66.66103, y = 38.44657, refreshTime = 36000000, objectType = 0},
				{monsterId = 10451, x = 70.23319, y = 40.18336, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},	
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190311,1,190401,1,190411,1},		--奖励道具ID，数量
		exp = 100,
		money = 100,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10453,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[45],
		exp = expreward[45],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][46] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 105,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {64.2715,9.891123},		--玩家出生点
	relivePostion = {64.2715,9.891123},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10461, x = 71.83193, y = 19.93044, refreshTime = 36000000, objectType = 0},
				{monsterId = 10461, x = 68.0351, y = 21.90413, refreshTime = 36000000, objectType = 0},
				{monsterId = 10461, x = 66.93549, y = 19.07415, refreshTime = 36000000, objectType = 0},
				{monsterId = 10461, x = 63.10741, y = 20.99797, refreshTime = 36000000, objectType = 0},
				{monsterId = 10461, x = 61.52381, y = 19.00756, refreshTime = 36000000, objectType = 0},
				{monsterId = 10461, x = 57.65442, y = 18.41087, refreshTime = 36000000, objectType = 0},
				{monsterId = 10461, x = 58.04987, y = 21.58472, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10462, x = 69.21471, y = 36.70137, refreshTime = 36000000, objectType = 0},
				{monsterId = 10461, x = 69.6635, y = 40.93261, refreshTime = 36000000, objectType = 0},
				{monsterId = 10461, x = 67.37519, y = 43.59758, refreshTime = 36000000, objectType = 0},
				{monsterId = 10461, x = 63.47381, y = 43.88557, refreshTime = 36000000, objectType = 0},
				{monsterId = 10461, x = 58.92673, y = 43.88654, refreshTime = 36000000, objectType = 0},
				{monsterId = 10461, x = 56.5217, y = 42.40206, refreshTime = 36000000, objectType = 0},
				{monsterId = 10461, x = 55.22309, y = 39.71426, refreshTime = 36000000, objectType = 0},
				{monsterId = 10461, x = 54.89395, y = 37.16079, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10461, x = 46.79576, y = 38.40221, refreshTime = 36000000, objectType = 0},
				{monsterId = 10461, x = 44.31372, y = 34.87992, refreshTime = 36000000, objectType = 0},
				{monsterId = 10461, x = 45.64981, y = 43.74397, refreshTime = 36000000, objectType = 0},
				{monsterId = 10461, x = 43.81127, y = 41.08846, refreshTime = 36000000, objectType = 0},
				{monsterId = 10461, x = 40.84957, y = 39.03069, refreshTime = 36000000, objectType = 0},
				{monsterId = 10461, x = 41.50182, y = 46.66906, refreshTime = 36000000, objectType = 0},
				{monsterId = 10461, x = 38.73372, y = 45.98709, refreshTime = 36000000, objectType = 0},
				{monsterId = 10461, x = 38.32325, y = 42.53643, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10463, x = 30.00265, y = 20.74543, refreshTime = 36000000, objectType = 0},
				{monsterId = 10462, x = 26.5257, y = 26.45126, refreshTime = 36000000, objectType = 0},
				{monsterId = 10461, x = 24.77932, y = 24.14544, refreshTime = 36000000, objectType = 0},
				{monsterId = 10461, x = 23.87545, y = 19.79152, refreshTime = 36000000, objectType = 0},
				{monsterId = 10461, x = 27.66022, y = 16.76343, refreshTime = 36000000, objectType = 0},
				{monsterId = 10461, x = 33.51983, y = 16.50281, refreshTime = 36000000, objectType = 0},
				{monsterId = 10461, x = 35.25771, y = 19.34607, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},		
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190311,1,190401,1,190411,1},		--奖励道具ID，数量
		exp = 100,
		money = 100,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10463,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[46],
		exp = expreward[46],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][47] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 114,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {54.27055,94.75842},		--玩家出生点
	relivePostion = {54.27055,94.75842},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10471, x = 53.66521, y = 82.77795, refreshTime = 36000000, objectType = 0},
				{monsterId = 10471, x = 58.00977, y = 80.96169, refreshTime = 36000000, objectType = 0},
				{monsterId = 10471, x = 61.79791, y = 80.26965, refreshTime = 36000000, objectType = 0},
				{monsterId = 10471, x = 52.46177, y = 80.00569, refreshTime = 36000000, objectType = 0},
				{monsterId = 10471, x = 54.21874, y = 76.79165, refreshTime = 36000000, objectType = 0},
				{monsterId = 10471, x = 57.127, y = 74.957, refreshTime = 36000000, objectType = 0},
				{monsterId = 10471, x = 60.93715, y = 76.03775, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10472, x = 50.88662, y = 48.86724, refreshTime = 36000000, objectType = 0},
				{monsterId = 10471, x = 52.76736, y = 44.69339, refreshTime = 36000000, objectType = 0},
				{monsterId = 10471, x = 46.82728, y = 46.98738, refreshTime = 36000000, objectType = 0},
				{monsterId = 10471, x = 43.55637, y = 49.44242, refreshTime = 36000000, objectType = 0},
				{monsterId = 10471, x = 38.54898, y = 46.3572, refreshTime = 36000000, objectType = 0},
				{monsterId = 10471, x = 43.46465, y = 42.96041, refreshTime = 36000000, objectType = 0},
				{monsterId = 10471, x = 43.3625, y = 38.17526, refreshTime = 36000000, objectType = 0},
				{monsterId = 10471, x = 47.94567, y = 40.5407, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10471, x = 31.65157, y = 63.643, refreshTime = 36000000, objectType = 0},
				{monsterId = 10471, x = 24.95314, y = 64.48876, refreshTime = 36000000, objectType = 0},
				{monsterId = 10471, x = 27.50691, y = 67.35477, refreshTime = 36000000, objectType = 0},
				{monsterId = 10471, x = 28.1409, y = 70.81726, refreshTime = 36000000, objectType = 0},
				{monsterId = 10471, x = 22.99822, y = 69.96935, refreshTime = 36000000, objectType = 0},
				{monsterId = 10471, x = 25.4677, y = 75.38629, refreshTime = 36000000, objectType = 0},
				{monsterId = 10471, x = 19.59883, y = 75.93311, refreshTime = 36000000, objectType = 0},
				{monsterId = 10471, x = 23.46227, y = 79.81025, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10473, x = 5.647738, y = 97.43981, refreshTime = 36000000, objectType = 0},
				{monsterId = 10472, x = 12.66, y = 98.92436, refreshTime = 36000000, objectType = 0},
				{monsterId = 10471, x = 8.907004, y = 101.3563, refreshTime = 36000000, objectType = 0},
				{monsterId = 10471, x = 8.480429, y = 95.32383, refreshTime = 36000000, objectType = 0},
				{monsterId = 10471, x = 4.491346, y = 100.1011, refreshTime = 36000000, objectType = 0},
				{monsterId = 10471, x = -0.6602691, y = 97.27319, refreshTime = 36000000, objectType = 0},
				{monsterId = 10471, x = 2.700219, y = 93.89767, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},	
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190311,1,190401,1,190411,1},		--奖励道具ID，数量
		exp = 100,
		money = 100,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10473,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[47],
		exp = expreward[47],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][48] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 114,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {12.83019,48.83538},		--玩家出生点
	relivePostion = {12.83019,48.83538},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10481, x = 3.818421, y = 36.0171, refreshTime = 36000000, objectType = 0},
				{monsterId = 10481, x = 8.923204, y = 36.71643, refreshTime = 36000000, objectType = 0},
				{monsterId = 10481, x = 13.35923, y = 35.97926, refreshTime = 36000000, objectType = 0},
				{monsterId = 10481, x = 4.537353, y = 31.6424, refreshTime = 36000000, objectType = 0},
				{monsterId = 10481, x = 7.640657, y = 34.05667, refreshTime = 36000000, objectType = 0},
				{monsterId = 10481, x = 9.514832, y = 31.39714, refreshTime = 36000000, objectType = 0},
				{monsterId = 10481, x = 12.81597, y = 33.18614, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10482, x = 21.86091, y = 21.81167, refreshTime = 36000000, objectType = 0},
				{monsterId = 10481, x = 24.2071, y = 22.81163, refreshTime = 36000000, objectType = 0},
				{monsterId = 10481, x = 22.74743, y = 27.28045, refreshTime = 36000000, objectType = 0},
				{monsterId = 10481, x = 28.96139, y = 22.44264, refreshTime = 36000000, objectType = 0},
				{monsterId = 10481, x = 27.04733, y = 25.96381, refreshTime = 36000000, objectType = 0},
				{monsterId = 10481, x = 32.96741, y = 25.90874, refreshTime = 36000000, objectType = 0},
				{monsterId = 10481, x = 30.16993, y = 28.55959, refreshTime = 36000000, objectType = 0},
				{monsterId = 10481, x = 33.89426, y = 29.5929, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10481, x = 43.73549, y = 40.84956, refreshTime = 36000000, objectType = 0},
				{monsterId = 10481, x = 47.15112, y = 44.50748, refreshTime = 36000000, objectType = 0},
				{monsterId = 10481, x = 46.31206, y = 48.73992, refreshTime = 36000000, objectType = 0},
				{monsterId = 10481, x = 51.02635, y = 40.82093, refreshTime = 36000000, objectType = 0},
				{monsterId = 10481, x = 52.77848, y = 47.80125, refreshTime = 36000000, objectType = 0},
				{monsterId = 10481, x = 58.45463, y = 41.95625, refreshTime = 36000000, objectType = 0},
				{monsterId = 10481, x = 62.42049, y = 45.53982, refreshTime = 36000000, objectType = 0},
				{monsterId = 10481, x = 65.77444, y = 41.93793, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10483, x = 84.1944, y = 59.16277, refreshTime = 36000000, objectType = 0},
				{monsterId = 10482, x = 81.10856, y = 55.83339, refreshTime = 36000000, objectType = 0},
				{monsterId = 10481, x = 78.88451, y = 62.00491, refreshTime = 36000000, objectType = 0},
				{monsterId = 10481, x = 86.68896, y = 55.98066, refreshTime = 36000000, objectType = 0},
				{monsterId = 10481, x = 89.05104, y = 58.49474, refreshTime = 36000000, objectType = 0},
				{monsterId = 10481, x = 88.60661, y = 62.7929, refreshTime = 36000000, objectType = 0},
				{monsterId = 10481, x = 84.0528, y = 64.76049, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},	
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190311,1,190401,1,190411,1},		--奖励道具ID，数量
		exp = 100,
		money = 100,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10483,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[48],
		exp = expreward[48],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][49] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 114,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {80.04394,6.737657},		--玩家出生点
	relivePostion = {80.04394,6.737657},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10491, x = 89.60381, y = 19.67893, refreshTime = 36000000, objectType = 0},
				{monsterId = 10491, x = 91.70144, y = 24.17755, refreshTime = 36000000, objectType = 0},
				{monsterId = 10491, x = 86.35938, y = 24.10607, refreshTime = 36000000, objectType = 0},
				{monsterId = 10491, x = 88.72491, y = 26.72157, refreshTime = 36000000, objectType = 0},
				{monsterId = 10491, x = 90.25993, y = 30.94238, refreshTime = 36000000, objectType = 0},
				{monsterId = 10491, x = 86.07394, y = 33.21168, refreshTime = 36000000, objectType = 0},
				{monsterId = 10491, x = 84.30863, y = 29.87966, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10492, x = 85.05027, y = 58.68871, refreshTime = 36000000, objectType = 0},
				{monsterId = 10491, x = 87.7634, y = 62.09417, refreshTime = 36000000, objectType = 0},
				{monsterId = 10491, x = 90.88171, y = 64.10158, refreshTime = 36000000, objectType = 0},
				{monsterId = 10491, x = 89.85025, y = 69.75272, refreshTime = 36000000, objectType = 0},
				{monsterId = 10491, x = 87.08791, y = 65.84495, refreshTime = 36000000, objectType = 0},
				{monsterId = 10491, x = 83.86595, y = 1.148555, refreshTime = 36000000, objectType = 0},
				{monsterId = 10491, x = 82.8269, y = 65.98786, refreshTime = 36000000, objectType = 0},
				{monsterId = 10491, x = 84.1597, y = 68.90516, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10491, x = 70.81474, y = 54.66104, refreshTime = 36000000, objectType = 0},
				{monsterId = 10491, x = 72.56792, y = 52.59353, refreshTime = 36000000, objectType = 0},
				{monsterId = 10491, x = 62.1101, y = 45.86718, refreshTime = 36000000, objectType = 0},
				{monsterId = 10491, x = 58.69091, y = 43.65716, refreshTime = 36000000, objectType = 0},
				{monsterId = 10491, x = 62.06818, y = 42.02638, refreshTime = 36000000, objectType = 0},
				{monsterId = 10491, x = 59.1181, y = 39.9418, refreshTime = 36000000, objectType = 0},
				{monsterId = 10491, x = 56.84329, y = 37.01324, refreshTime = 36000000, objectType = 0},
				{monsterId = 10491, x = 63.06449, y = 37.42981, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10493, x = 39.72173, y = 43.45577, refreshTime = 36000000, objectType = 0},
				{monsterId = 10492, x = 44.00808, y = 47.00519, refreshTime = 36000000, objectType = 0},
				{monsterId = 10491, x = 40.41607, y = 48.39051, refreshTime = 36000000, objectType = 0},
				{monsterId = 10491, x = 36.48255, y = 45.81709, refreshTime = 36000000, objectType = 0},
				{monsterId = 10491, x = 38.42788, y = 40.22137, refreshTime = 36000000, objectType = 0},
				{monsterId = 10491, x = 38.01666, y = 36.59582, refreshTime = 36000000, objectType = 0},
				{monsterId = 10491, x = 42.37066, y = 38.1155, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},	
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190311,1,190401,1,190411,1},		--奖励道具ID，数量
		exp = 100,
		money = 100,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10493,						--死亡怪物ID
	},

	winStar = {80,180,260},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[1],
		exp = expreward[1],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][50] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 114,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {14.87741,7.857231},		--玩家出生点
	relivePostion = {14.87741,7.857231},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10501, x = 14.91795, y = 21.66008, refreshTime = 36000000, objectType = 0},
				{monsterId = 10501, x = 10.11496, y = 22.81335, refreshTime = 36000000, objectType = 0},
				{monsterId = 10501, x = 15.10669, y = 25.25257, refreshTime = 36000000, objectType = 0},
				{monsterId = 10501, x = 12.1701, y = 27.53416, refreshTime = 36000000, objectType = 0},
				{monsterId = 10501, x = 16.70531, y = 28.90451, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10502, x = 15.0695, y = 40.35162, refreshTime = 36000000, objectType = 0},
				{monsterId = 10501, x = 10.57596, y = 41.60346, refreshTime = 36000000, objectType = 0},
				{monsterId = 10501, x = 17.55567, y = 43.17683, refreshTime = 36000000, objectType = 0},
				{monsterId = 10501, x = 14.60891, y = 44.79972, refreshTime = 36000000, objectType = 0},
				{monsterId = 10501, x = 11.24091, y = 46.26559, refreshTime = 36000000, objectType = 0},
				{monsterId = 10501, x = 13.565, y = 50.70007, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10501, x = 11.86051, y = 62.68409, refreshTime = 36000000, objectType = 0},
				{monsterId = 10501, x = 8.97944, y = 62.89325, refreshTime = 36000000, objectType = 0},
				{monsterId = 10501, x = 12.72824, y = 66.36864, refreshTime = 36000000, objectType = 0},
				{monsterId = 10501, x = 8.224072, y = 68.37626, refreshTime = 36000000, objectType = 0},
				{monsterId = 10501, x = 11.35304, y = 70.36114, refreshTime = 36000000, objectType = 0},
				{monsterId = 10501, x = 10.86459, y = 74.51826, refreshTime = 36000000, objectType = 0},
				{monsterId = 10501, x = 6.268641, y = 73.49596, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10501, x = 1.735383, y = 88.57477, refreshTime = 36000000, objectType = 0},
				{monsterId = 10502, x = -2.962844, y = 91.30402, refreshTime = 36000000, objectType = 0},
				{monsterId = 10501, x = -7.660269, y = 95.83309, refreshTime = 36000000, objectType = 0},
				{monsterId = 10501, x = -3.020459, y = 96.8311, refreshTime = 36000000, objectType = 0},
				{monsterId = 10501, x = -3.655196, y = 101.1794, refreshTime = 36000000, objectType = 0},
				{monsterId = 10501, x = 0.819766, y = 94.66268, refreshTime = 36000000, objectType = 0},
				{monsterId = 10501, x = 1.531047, y = 98.7139, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
		[5] = 
		{
			monsterlist = 
			{
				{monsterId = 10503, x = 11.51768, y = 99.80809, refreshTime = 36000000, objectType = 0},
				{monsterId = 10502, x = 7.357474, y = 96.42856, refreshTime = 36000000, objectType = 0},
				{monsterId = 10501, x = 9.128701, y = 102.4946, refreshTime = 36000000, objectType = 0},
				{monsterId = 10501, x = 12.72483, y = 106.8709, refreshTime = 36000000, objectType = 0},
				{monsterId = 10501, x = 16.27957, y = 99.47329, refreshTime = 36000000, objectType = 0},
				{monsterId = 10501, x = 13.40863, y = 95.01752, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 0, 			--刷新延迟 秒
			monsternum = {1,1,1,1,1,1,1}, 				--怪物数量
			randradius = 10, 
		},
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190311,1,190401,1,190411,1},		--奖励道具ID，数量
		exp = 100,
		money = 100,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = SPECIFIC_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 10503,						--死亡怪物ID
	},

	winStar = {100,200,300},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[1],
		exp = expreward[1],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][51] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 104,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {70.68,46.63},		--玩家出生点
	relivePostion = {70.68,46.63},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--刷新延迟 秒
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[5] = 
		{
			monsterlist = 
			{
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[6] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[7] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[8] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 32.64, y = 53.51, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[9] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 32.64, y = 53.51, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
		[10] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 32.64, y = 53.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 32.64, y = 53.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10353, x = 28.85, y = 61.58, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},		
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190311,1,190401,1,190411,1},		--奖励道具ID，数量
		exp = 100,
		money = 100,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = All_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 0,						--死亡怪物ID
	},

	winStar = {60,150,240},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[1],
		exp = expreward[1],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][52] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 104,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {70.68,46.63},		--玩家出生点
	relivePostion = {70.68,46.63},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--刷新延迟 秒
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[5] = 
		{
			monsterlist = 
			{
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[6] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[7] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[8] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 32.64, y = 53.51, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[9] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 32.64, y = 53.51, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
		[10] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 32.64, y = 53.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 32.64, y = 53.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10353, x = 28.85, y = 61.58, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},		
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190311,1,190401,1,190411,1},		--奖励道具ID，数量
		exp = 100,
		money = 100,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = All_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 0,						--死亡怪物ID
	},

	winStar = {60,150,240},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[1],
		exp = expreward[1],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][53] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 104,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {70.68,46.63},		--玩家出生点
	relivePostion = {70.68,46.63},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--刷新延迟 秒
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[5] = 
		{
			monsterlist = 
			{
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[6] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[7] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[8] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 32.64, y = 53.51, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[9] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 32.64, y = 53.51, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
		[10] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 32.64, y = 53.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 32.64, y = 53.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10353, x = 28.85, y = 61.58, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},		
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190311,1,190401,1,190411,1},		--奖励道具ID，数量
		exp = 100,
		money = 100,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = All_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 0,						--死亡怪物ID
	},

	winStar = {60,150,240},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[1],
		exp = expreward[1],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][54] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 104,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {70.68,46.63},		--玩家出生点
	relivePostion = {70.68,46.63},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--刷新延迟 秒
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[5] = 
		{
			monsterlist = 
			{
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[6] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[7] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[8] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 32.64, y = 53.51, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[9] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 32.64, y = 53.51, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
		[10] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 32.64, y = 53.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 32.64, y = 53.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10353, x = 28.85, y = 61.58, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},		
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190311,1,190401,1,190411,1},		--奖励道具ID，数量
		exp = 100,
		money = 100,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = All_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 0,						--死亡怪物ID
	},

	winStar = {60,150,240},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[1],
		exp = expreward[1],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][55] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 104,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {70.68,46.63},		--玩家出生点
	relivePostion = {70.68,46.63},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--刷新延迟 秒
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[5] = 
		{
			monsterlist = 
			{
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[6] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[7] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[8] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 32.64, y = 53.51, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[9] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 32.64, y = 53.51, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
		[10] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 32.64, y = 53.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 32.64, y = 53.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10353, x = 28.85, y = 61.58, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},		
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190311,1,190401,1,190411,1},		--奖励道具ID，数量
		exp = 100,
		money = 100,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = All_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 0,						--死亡怪物ID
	},

	winStar = {60,150,240},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[1],
		exp = expreward[1],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}


SceneMapTable[1][56] = 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 104,				--静态地图资源
	IsBossScene = false,		--是否为BOSS关卡
	Npc ={},					--NPC 列表
	bornPostion = {70.68,46.63},		--玩家出生点
	relivePostion = {70.68,46.63},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 68.98, y = 57.88, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--刷新延迟 秒
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 61.17, y = 55.72, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 58.24, y = 48.23, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
		[4] = 
		{
			monsterlist = 
			{
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 50.34, y = 46.51, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[5] = 
		{
			monsterlist = 
			{
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 41.41, y = 46.72, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[6] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 35.4, y = 42.33, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[7] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 35.55, y = 50.16, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[8] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 32.64, y = 53.51, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},	
		[9] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 32.64, y = 53.51, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
		[10] = 
		{
			monsterlist = 
			{
				{monsterId = 10351, x = 32.64, y = 53.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10351, x = 32.64, y = 53.51, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 36.04, y = 56.61, refreshTime = 36000000, objectType = 0},
				{monsterId = 10352, x = 27.26, y = 53.09, refreshTime = 36000000, objectType = 0},
				{monsterId = 10353, x = 28.85, y = 61.58, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},		
	},
	
	LimitContorl = 
	{
		LimitSP = 5,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},

	scenereward = 				--关卡奖励用于在通关之前显示在面板中
	{
		item = {190311,1,190401,1,190411,1},		--奖励道具ID，数量
		exp = 100,
		money = 100,
	},

	equiprecommend =     		--装备推荐
	{
		item = {190311,190401,190411},
	},

	winruleconfig = 					--胜利条件
	{
		winrule = All_MONSTERDIE,		--所有怪物死亡
		diemonsterid = 0,						--死亡怪物ID
	},

	winStar = {60,150,240},			--评星时间判断 秒,对应1星2星13星

	fixationreward = 					--通关完成以后的固定奖励
	{
		item = rewardlist[1],
		exp = expreward[1],
	},

	silverreward = 							--银币抽取的奖励 rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},

	goldreward = 							--金币抽取的奖励,分别对应3个等级的不同奖励rewardlist
	{
		 rewardlist[1], rewardlist[2], rewardlist[3]
	},
}















