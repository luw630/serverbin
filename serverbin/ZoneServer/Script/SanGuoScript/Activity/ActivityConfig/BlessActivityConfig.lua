--[[
file:	BlessActivity.lua
author:	lpd
update:	2015-11-03
desc:祈福活配置
]]--

--[[
------------------------------------------------------------------------
	GoodsType.money--铜钱
	GoodsType.diamond--钻石
	GoodsType.honor--荣誉
	GoodsType.exploit--军功
	GoodsType.endurance--体力
	GoodsType.item --道具或者装备
	GoodsType.hero --英雄
}
------------------------------------------------------------------------
]]--

BlessActConfig = { --祈福活动奖励配置
	[1] = { 
			blessCount = 20 , --blessCount满足祈福次数条件
			reward = {
			[1] = {GoodsType.item, 90144, 1}, 
			[2] = {GoodsType.money, 0, 20000}, },--武将奖励 GoodsType.hero； 武将ID108  ； 武将个数为1
		  },

	[2] = { 
			blessCount = 30 , --blessCount满足祈福次数条件
			reward = {
			[1] = {GoodsType.item, 90144, 2}, 
			[2] = {GoodsType.money, 0, 40000}, },--武将奖励 GoodsType.hero； 武将ID108  ； 武将个数为1
		  },

	[3] = {
			blessCount = 50 , --blessCount满足祈福次数条件
			reward = {
		    [1] = {GoodsType.item, 90144, 3}, 
			[2] = {GoodsType.money, 0, 80000}, },--武将奖励 GoodsType.hero； 武将ID108  ； 武将个数为1
		  },
}

