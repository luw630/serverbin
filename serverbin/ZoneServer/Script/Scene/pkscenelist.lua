PkSceneMapTable = {}
PkSceneMapTable[1]= 				--章节ID，关卡ID
{
	SceneMapID = 1,				--所属章节ID
	MapID 	= 103,				--静态地图资源
	bornPostion = {43.92,32.17},		--玩家出生点
	relivePostion = {43.92,32.17},	--玩家复活点坐标
	relivemoney = 100, 			--玩家死亡后花费金币复活
	specialrate  = 1,			--特殊奇遇关卡几率，rand > specialrate 为类型2
	ScenePkType = 1,			--关卡PK限制 0 不能PK 1允许PK

	BatchMonster =  			--分批操作刷新的怪物
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --怪物死亡刷新
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 4, x = 43.92, y = 37.15, refreshTime = 36000000, objectType = 0},	
				{monsterId = 4, x = 43.92, y = 37.15, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--刷新延迟 秒
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 5, x = 43.92, y = 37.15, refreshTime = 36000000, objectType = 0},	
				{monsterId = 5, x = 43.92, y = 37.15, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--刷新延迟 秒
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 8, x = 43.92, y = 37.15, refreshTime = 36000000, objectType = 0},	
			},
			refreshdelaytime = 1, 			--刷新延迟 秒
		},
	},
	
	LimitContorl = 
	{
		LimitSP = 1,			--体力限制
		LimitTimes = 99,			--次数限制
		SDLimitTimes = 99,		--扫荡次数限制
		OpenTime = 15,			--开启时间分钟
		SDTime = 1,			--扫荡所需时间
		SDItem = 0,		--扫荡需求道具
		SDcoldMoney = 100,	--冷却扫荡时间所需金钱
	},
}