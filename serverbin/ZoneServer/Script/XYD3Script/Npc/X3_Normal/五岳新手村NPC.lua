

NpcTable[1] =
{
	NpcCreate =
	{
		objectType = 1,		-- 要创建NPC
		imageID = 10002,
		regionId = 1, 		-- 所在地图ID
		name = "无眉", 		-- 'NAME'
		title = "玄修长老",			-- 'CHENGHAO'
		x = 519, 			-- 所在坐标（格子）
		y = 344,
		z= 601,
		dir = 58,			-- NPC朝向
		chose =1, 			-- NPC类型（2为任务）
		moveType = 0, 		-- 移动类型
		moveArea = 0, 		-- 移动范围
		School = 0,			-- 门派
		LiveTime = 0xffffffff	-- 生存时间
	},
		NpcMenu =
	{
		
		{
			name 	= '我靠，商店',
			id 		= 2,
			school 	= nil,
			sex 	= nil,
			level 	= nil,
			task 	= nil,
		},
		
	},
}


NpcTable[2] =
{
	NpcCreate =
	{
		objectType = 1,		-- 要创建NPC
		imageID = 10003,
		regionId = 1, 		-- 所在地图ID
		name = "玄灵仙子", 		-- 'NAME'
		title = "试练指引",			-- 'CHENGHAO'
		x = 606, 			-- 所在坐标（格子）
		y = 338,
		z= 586,
		dir = 121,			-- NPC朝向
		chose =1, 			-- NPC类型（2为任务）
		moveType = 0, 		-- 移动类型
		moveArea = 0, 		-- 移动范围
		School = 0,			-- 门派
		LiveTime = 0xffffffff	-- 生存时间
	},
		NpcMenu =
	{
		{
			name 	= 'CeShiNPC',
			id 		= 1,
			school 	= nil,
			sex 	= nil,
			level 	= nil,
			task 	= nil,
		},
	},
}

NpcTable[3] =
{
	NpcCreate =
	{
		objectType = 1,		-- 要创建NPC
		imageID = 10004,
		regionId = 1, 		-- 所在地图ID
		name = "历无邪", 		-- 'NAME'
		title = "试练监管",			-- 'CHENGHAO'
		x = 789, 			-- 所在坐标（格子）
		y = 366,
		z= 1018,
		dir = 265,			-- NPC朝向
		chose =1, 			-- NPC类型（2为任务）
		moveType = 0, 		-- 移动类型
		moveArea = 0, 		-- 移动范围
		School = 0,			-- 门派
		LiveTime = 0xffffffff	-- 生存时间
	},
		NpcMenu =
	{
		{
			name 	= '进入九幽秘境',
			id 		= 1,
			school 	= nil,
			sex 	= nil,
			level 	= nil,
			task 	= nil,
		}
	},
}


