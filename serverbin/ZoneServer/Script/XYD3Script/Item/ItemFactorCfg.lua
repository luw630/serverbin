-- 道具属性加成配置
--[[
		EEA_MAXHP			= 0,				// 生命上限
		EEA_MAXMP			= 1,				// 内力上限
		EEA_PHYATK			= 2,				// 外功攻击
		EEA_FPATK			= 3,				// 内功攻击
		EEA_PHYDEFENCE		= 4,				// 外功防御
		EEA_FPDEFENCE		= 5,				// 内功防御
		EEA_PHYHIT			= 6,				// 外功命中
		EEA_FPHIT			= 7,				// 内功命中
		EEA_PHYESCAPE		= 8,				// 外功躲避
		EEA_FPESCAPE		= 9,				// 内功躲避
		EEA_OUTCRIATT		= 10,				// 外功暴击
		EEA_INCRIATT		= 11,				// 内功暴击
		EEA_PHYDAMAGEFIX	= 12,				// 外功攻击修正
		EEA_FPDAMAGEFIX		= 13,				// 内功攻击修正
		EEA_PHYDEFENCEFIX	= 14,				// 外功防御修正
		EEA_FPDEFENCEFIX	= 15,				// 内功防御修正
		EEA_PHYHITFIX		= 16,				// 外功命中修正
		EEA_FPHITFIX		= 17,				// 内功命中修正
		EEA_PHYESCFIX		= 18,				// 外功躲避修正
		EEA_FPESCFIX		= 19,				// 内功躲避修正
		EEA_PHYCRIATKFIX	= 20,				// 外功暴击修正
		EEA_FPCRIATKFIX		= 21,				// 内功暴击修正
		EEA_ATK_ICE			= 22,				// 冰攻击
		EEA_ATK_FIRE		= 23,				// 火攻击
		EEA_ATK_XUAN		= 24,				// 玄攻击
		EEA_ATK_POI			= 25,				// 毒攻击
		EEA_DEFENCE_ICE		= 26,				// 冰防御
		EEA_DEFENCE_FIRE	= 27,				// 火防御
		EEA_DEFENCE_XUAN	= 28,				// 玄防御
		EEA_DEFENCE_POI		= 29,				// 毒防御
--]]

ItemFactorPointTable = {}			-- 值加成
ItemFactorPrecentTable = {}			-- 百分比加成


--宝石测试
--生命宝石
ItemFactorPointTable[4004001] ={[0] = 10}
ItemFactorPointTable[4004002] ={[0] = 20}
ItemFactorPointTable[4004003] ={[0] = 30}
ItemFactorPointTable[4004004] ={[0] = 40}
ItemFactorPointTable[4004005] ={[0] = 50}
ItemFactorPointTable[4004006] ={[0] = 60}
ItemFactorPointTable[4004007] ={[0] = 70}
ItemFactorPointTable[4004008] ={[0] = 80}
ItemFactorPointTable[4004009] ={[0] = 90}
ItemFactorPointTable[4004010] ={[0] = 100}
ItemFactorPointTable[4004011] ={[0] = 110}
ItemFactorPointTable[4004012] ={[0] = 120}
ItemFactorPointTable[4004013] ={[0] = 130}
ItemFactorPointTable[4004014] ={[0] = 140}
ItemFactorPointTable[4004015] ={[0] = 150}
ItemFactorPointTable[4004016] ={[0] = 160}
ItemFactorPointTable[4004017] ={[0] = 170}
ItemFactorPointTable[4004018] ={[0] = 180}
ItemFactorPointTable[4004019] ={[0] = 190}
ItemFactorPointTable[4004020] ={[0] = 200}
--内力宝石
ItemFactorPointTable[4004101] ={[0] = 10}
ItemFactorPointTable[4004102] ={[0] = 20}
ItemFactorPointTable[4004103] ={[0] = 30}
ItemFactorPointTable[4004104] ={[0] = 40}
ItemFactorPointTable[4004105] ={[0] = 50}
ItemFactorPointTable[4004106] ={[0] = 60}
ItemFactorPointTable[4004107] ={[0] = 70}
ItemFactorPointTable[4004108] ={[0] = 80}
ItemFactorPointTable[4004109] ={[0] = 90}
ItemFactorPointTable[4004110] ={[0] = 100}
ItemFactorPointTable[4004111] ={[0] = 110}
ItemFactorPointTable[4004112] ={[0] = 120}
ItemFactorPointTable[4004113] ={[0] = 130}
ItemFactorPointTable[4004114] ={[0] = 140}
ItemFactorPointTable[4004115] ={[0] = 150}
ItemFactorPointTable[4004116] ={[0] = 160}
ItemFactorPointTable[4004117] ={[0] = 170}
ItemFactorPointTable[4004118] ={[0] = 180}
ItemFactorPointTable[4004119] ={[0] = 190}
ItemFactorPointTable[4004120] ={[0] = 200}
--体力宝石
ItemFactorPointTable[4004201] ={[0] = 10}
ItemFactorPointTable[4004202] ={[0] = 20}
ItemFactorPointTable[4004203] ={[0] = 30}
ItemFactorPointTable[4004204] ={[0] = 40}
ItemFactorPointTable[4004205] ={[0] = 50}
ItemFactorPointTable[4004206] ={[0] = 60}
ItemFactorPointTable[4004207] ={[0] = 70}
ItemFactorPointTable[4004208] ={[0] = 80}
ItemFactorPointTable[4004209] ={[0] = 90}
ItemFactorPointTable[4004210] ={[0] = 100}
ItemFactorPointTable[4004211] ={[0] = 110}
ItemFactorPointTable[4004212] ={[0] = 120}
ItemFactorPointTable[4004213] ={[0] = 130}
ItemFactorPointTable[4004214] ={[0] = 140}
ItemFactorPointTable[4004215] ={[0] = 150}
ItemFactorPointTable[4004216] ={[0] = 160}
ItemFactorPointTable[4004217] ={[0] = 170}
ItemFactorPointTable[4004218] ={[0] = 180}
ItemFactorPointTable[4004219] ={[0] = 190}
ItemFactorPointTable[4004220] ={[0] = 200}
---攻击宝石
ItemFactorPointTable[4004301] ={[0] = 10}
ItemFactorPointTable[4004302] ={[0] = 20}
ItemFactorPointTable[4004303] ={[0] = 30}
ItemFactorPointTable[4004304] ={[0] = 40}
ItemFactorPointTable[4004305] ={[0] = 50}
ItemFactorPointTable[4004306] ={[0] = 60}
ItemFactorPointTable[4004307] ={[0] = 70}
ItemFactorPointTable[4004308] ={[0] = 80}
ItemFactorPointTable[4004309] ={[0] = 90}
ItemFactorPointTable[4004310] ={[0] = 100}
ItemFactorPointTable[4004311] ={[0] = 110}
ItemFactorPointTable[4004312] ={[0] = 120}
ItemFactorPointTable[4004313] ={[0] = 130}
ItemFactorPointTable[4004314] ={[0] = 140}
ItemFactorPointTable[4004315] ={[0] = 150}
ItemFactorPointTable[4004316] ={[0] = 160}
ItemFactorPointTable[4004317] ={[0] = 170}
ItemFactorPointTable[4004318] ={[0] = 180}
ItemFactorPointTable[4004319] ={[0] = 190}
ItemFactorPointTable[4004320] ={[0] = 200}
--防御宝石
ItemFactorPointTable[4004401] ={[0] = 10}
ItemFactorPointTable[4004402] ={[0] = 20}
ItemFactorPointTable[4004403] ={[0] = 30}
ItemFactorPointTable[4004404] ={[0] = 40}
ItemFactorPointTable[4004405] ={[0] = 50}
ItemFactorPointTable[4004406] ={[0] = 60}
ItemFactorPointTable[4004407] ={[0] = 70}
ItemFactorPointTable[4004408] ={[0] = 80}
ItemFactorPointTable[4004409] ={[0] = 90}
ItemFactorPointTable[4004410] ={[0] = 100}
ItemFactorPointTable[4004411] ={[0] = 110}
ItemFactorPointTable[4004412] ={[0] = 120}
ItemFactorPointTable[4004413] ={[0] = 130}
ItemFactorPointTable[4004414] ={[0] = 140}
ItemFactorPointTable[4004415] ={[0] = 150}
ItemFactorPointTable[4004416] ={[0] = 160}
ItemFactorPointTable[4004417] ={[0] = 170}
ItemFactorPointTable[4004418] ={[0] = 180}
ItemFactorPointTable[4004419] ={[0] = 190}
ItemFactorPointTable[4004420] ={[0] = 200}
--闪避宝石
ItemFactorPointTable[4004501] ={[0] = 10}
ItemFactorPointTable[4004502] ={[0] = 20}
ItemFactorPointTable[4004503] ={[0] = 30}
ItemFactorPointTable[4004504] ={[0] = 40}
ItemFactorPointTable[4004505] ={[0] = 50}
ItemFactorPointTable[4004506] ={[0] = 60}
ItemFactorPointTable[4004507] ={[0] = 70}
ItemFactorPointTable[4004508] ={[0] = 80}
ItemFactorPointTable[4004509] ={[0] = 90}
ItemFactorPointTable[4004510] ={[0] = 100}
ItemFactorPointTable[4004511] ={[0] = 110}
ItemFactorPointTable[4004512] ={[0] = 120}
ItemFactorPointTable[4004513] ={[0] = 130}
ItemFactorPointTable[4004514] ={[0] = 140}
ItemFactorPointTable[4004515] ={[0] = 150}
ItemFactorPointTable[4004516] ={[0] = 160}
ItemFactorPointTable[4004517] ={[0] = 170}
ItemFactorPointTable[4004518] ={[0] = 180}
ItemFactorPointTable[4004519] ={[0] = 190}
ItemFactorPointTable[4004520] ={[0] = 200}
--暴击闪宝石
ItemFactorPointTable[4004601] ={[0] = 10}
ItemFactorPointTable[4004602] ={[0] = 20}
ItemFactorPointTable[4004603] ={[0] = 30}
ItemFactorPointTable[4004604] ={[0] = 40}
ItemFactorPointTable[4004605] ={[0] = 50}
ItemFactorPointTable[4004606] ={[0] = 60}
ItemFactorPointTable[4004607] ={[0] = 70}
ItemFactorPointTable[4004608] ={[0] = 80}
ItemFactorPointTable[4004609] ={[0] = 90}
ItemFactorPointTable[4004610] ={[0] = 100}
ItemFactorPointTable[4004611] ={[0] = 110}
ItemFactorPointTable[4004612] ={[0] = 120}
ItemFactorPointTable[4004613] ={[0] = 130}
ItemFactorPointTable[4004614] ={[0] = 140}
ItemFactorPointTable[4004615] ={[0] = 150}
ItemFactorPointTable[4004616] ={[0] = 160}
ItemFactorPointTable[4004617] ={[0] = 170}
ItemFactorPointTable[4004618] ={[0] = 180}
ItemFactorPointTable[4004619] ={[0] = 190}
ItemFactorPointTable[4004620] ={[0] = 200}

