NpcTable[1] =
{
	NpcCreate =
	{
		objectType = 1,			-- 要创建NPC
		imageID = 10002,		-- 模型ID
		regionId = 1, 			-- 所在地图ID
		name = "无眉",			-- 名称
		title = "玄修者长老",   -- 称号
		x = 156.6, 				-- 所在坐标（格子）
		y = 325.7,
		dir = 0,			-- NPC朝向
		chose =1, 			-- NPC类型（2为任务）
		moveType = 0, 		-- 移动类型
		moveArea = 0, 		-- 移动范围
		School = 0,			-- 门派
		LiveTime = 0xffffffff	-- 生存时间
	},
}

NpcTable[2] =
{
	NpcCreate =
	{
		objectType = 1,		
		imageID = 10003,
		regionId = 1, 		
		name = "玄灵仙子", 	
		title = "试炼指引", 		
		x = 357.5, 			
		y = 307.5,
		dir = 120,			
		chose =1, 			
		moveType = 0, 		
		moveArea = 0, 		
		School = 0,			
		LiveTime = 0xffffffff	
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
		x = 524, 			-- 所在坐标（格子）
		y = 329,
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
			name 	= '九幽秘境',
			id 		= 1,
			school 	= nil,
			sex 	= nil,
			level 	= nil,
			task= {
					allNeed = {{4, TS_ACCEPTED}},
					oneNeed = nil,
				  }
		}
	},
}

NpcTable[4] =
{
	NpcCreate =
	{
		objectType = 1,		
		imageID = 10005,
		regionId = 2, 		
		name = "昊天", 	
		title = "玄使", 		
		x = 1292.1, 			
		y = 741.1,
		dir = 0,			
		chose =1, 			
		moveType = 0, 		
		moveArea = 0, 		
		School = 0,			
		LiveTime = 0xffffffff	
	},
}
NpcTable[5] =
{
	NpcCreate =
	{
		objectType = 1,		
		imageID = 10006,
		regionId = 2, 		
		name = "黛兰无雁", 	
		title = "碧落仙子", 		
		x = 1295.0, 			
		y = 1006.3,
		dir = 180,			
		chose =1, 			
		moveType = 0, 		
		moveArea = 0, 		
		School = 0,			
		LiveTime = 0xffffffff	
	},
}
NpcTable[6] =
{
	NpcCreate =
	{
		objectType = 1,		
		imageID = 10007,
		regionId = 2, 		
		name = "千星坠", 	
		title = "玄武道人", 		
		x = 1001.3, 			
		y = 1300.0,
		dir = 90,			
		chose =1, 			
		moveType = 0, 		
		moveArea = 0, 		
		School = 0,
		LiveTime = 0xffffffff	
	},
	NpcMenu =
	{
		{
			name 	= '药品商店',
			id 		= 1,
			school 	= nil,
			sex 	= nil,
			level 	= nil,
			task	= nil,
		}
	},
}

NpcTable[7] =
{
	NpcCreate =
	{
		objectType = 1,		
		imageID = 10008,
		regionId = 2, 		
		name = "离觞", 	
		title = "白虎仙子", 		
		x = 564.0, 			
		y = 1149.9,
		dir = 90,			
		chose =1, 			
		moveType = 0, 		
		moveArea = 0, 		
		School = 0,			
		LiveTime = 0xffffffff	
	},
}

NpcTable[8] =
{
	NpcCreate =
	{
		objectType = 1,		
		imageID = 10009,
		regionId = 2, 		
		name = "天机子", 	
		title = "神相", 		
		x = 445.3, 			
		y = 987.6,
		dir = 0,			
		chose =1, 			
		moveType = 0, 		
		moveArea = 0, 		
		School = 0,			
		LiveTime = 0xffffffff	
	},
}
NpcTable[9] =
{
	NpcCreate =
	{
		objectType = 1,		
		imageID = 10010,
		regionId = 2, 		
		name = "欧冶子", 	
		title = "匠神", 		
		x = 452.6, 			
		y = 698.7,
		dir = 0,			
		chose =1, 			
		moveType = 0, 		
		moveArea = 0, 		
		School = 0,			
		LiveTime = 0xffffffff	
	},
}
NpcTable[10] =
{
	NpcCreate =
	{
		objectType = 1,		
		imageID = 10011,
		regionId = 2, 		
		name = "莫不练", 	
		title = "器神", 		
		x = 452.1, 			
		y = 536.5,
		dir = 0,			
		chose =1, 			
		moveType = 0, 		
		moveArea = 0, 		
		School = 0,			
		LiveTime = 0xffffffff	
	},
}

NpcTable[11] =
{
	NpcCreate =
	{
		objectType = 1,		
		imageID = 10012,
		regionId = 2, 		
		name = "司马天真", 	
		title = "", 		
		x = 492.7, 			
		y = 394.6,
		dir = 0,			
		chose =1, 			
		moveType = 0, 		
		moveArea = 0, 		
		School = 0,			
		LiveTime = 0xffffffff	
	},
}

NpcTable[12] =
{
	NpcCreate =
	{
		objectType = 1,		
		imageID = 10013,
		regionId = 2, 		
		name = "尺勿语", 	
		title = "青龙圣者", 		
		x = 453.2, 			
		y = 304.5,
		dir = 0,			
		chose =1, 			
		moveType = 0, 		
		moveArea = 0, 		
		School = 0,			
		LiveTime = 0xffffffff	
	},
	NpcMenu =
	{
		{
			name 	= '戮人谷',
			id 		= 1,
			school 	= nil,
			sex 	= nil,
			level 	= nil,
			task= {
					allNeed = {{12, TS_COMPLETE}},
					oneNeed = {{14,TS_NOTACCEPT},{14,TS_ACCEPTED}},
				  }
		}
	},
}
NpcTable[13] =
{
	NpcCreate =
	{
		objectType = 1,		
		imageID = 10013,
		regionId = 103,
		name = "神秘使者", 	
		title = "", 		
		x = 251.1, 			
		y = 306.1,
		dir = 180,			
		chose =1, 			
		moveType = 0, 		
		moveArea = 0, 		
		School = 0,			
		LiveTime = 0xffffffff	
	},
}
NpcTable[14] =
{
	NpcCreate =
	{
		objectType = 1,		
		imageID = 10013,
		regionId = 103, 		
		name = "仇天海", 	
		title = "", 		
		x = 460.2, 			
		y = 551.5,
		dir = 120,
		chose =1, 			
		moveType = 0, 		
		moveArea = 0, 		
		School = 0,			
		LiveTime = 0xffffffff	
	},
}
NpcTable[15] =
{
	NpcCreate =
	{
		objectType = 1,		
		imageID = 10013,
		regionId = 2, 		
		name = "前线将军", 	
		title = "", 		
		x = 1295.2, 			
		y = 759.5,
		dir = 120,
		chose =1, 			
		moveType = 0, 		
		moveArea = 0, 		
		School = 0,			
		LiveTime = 0xffffffff	
	},
}