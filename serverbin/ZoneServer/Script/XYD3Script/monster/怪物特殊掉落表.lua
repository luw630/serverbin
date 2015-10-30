dofile("XYD3Script\\monster\\怪物掉落.lua")
-- dofile("XYD3Script\\monster\\普通物品掉落逻辑.lua")
-- dofile("XYD3Script\\monster\\1级物品.lua")
-- dofile("XYD3Script\\monster\\10级物品.lua")
-- dofile("XYD3Script\\monster\\20级物品.lua")
-- dofile("XYD3Script\\monster\\30级物品.lua")
-- dofile("XYD3Script\\monster\\40级物品.lua")
-- dofile("XYD3Script\\monster\\50级物品.lua")
-- dofile("XYD3Script\\monster\\60级物品.lua")
-- dofile("XYD3Script\\monster\\65级物品.lua")
-- dofile("XYD3Script\\monster\\70级物品.lua")
-- dofile("XYD3Script\\monster\\75级物品.lua")
-- dofile("XYD3Script\\monster\\公共物品.lua")
-- dofile("XYD3Script\\monster\\将军岭掉落配置.lua")
-- dofile("XYD3Script\\monster\\天福山掉落配置.lua")
-- dofile("XYD3Script\\monster\\黑龙滩掉落配置.lua")
-- dofile("XYD3Script\\monster\\无极岛掉落配置.lua")
-- dofile("XYD3Script\\monster\\帝龙堡掉落配置.lua")
-- dofile("XYD3Script\\monster\\泽阳镇掉落配置.lua")
-- dofile("XYD3Script\\monster\\乱葬岗掉落配置.lua")
-- dofile("XYD3Script\\monster\\霖迷林掉落配置.lua")
-- dofile("XYD3Script\\monster\\活动怪物掉落配置.lua")


--[[MonsterdropTable[1] =
{
	Item =
	{
	{2001001,1000},
	{2001002,1500},
	{2001003,2500},
	{2001004,3000},
	{2001005,2000}
	},								--道具(ID，掉落几率)
	TimeInterval = 10,				--时间间隔 现在以分钟为单位,如果设为0没有时间间隔
	MonsterID = {3,2,11,12,13},		--怪物ID
	DropValue = 5,					--当前掉落物品个数（所设定的时间段内所掉落的物品次数）
	AllDropValue = 5,				--当超过时间间隔时掉落的物品个数，如果设为0，掉落完成以后将不会再次掉落
	SingleDropValue = 1,			--每次掉落的个数,如果为0将永不掉落,不能大于掉落的总个数
	ItemDropTime = os.time(),		--开始掉落的时间，现在已服务器启动时间开始
	ItemDropDate = 0 ,		--掉落日期限制(格式限制20110823)，0则不限制日期
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







