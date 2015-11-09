--[[
file:	expenseConfig.lua
author:	wk
update:	2015-11-04
desc:消费领奖活动
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

expenseActConfig = { --消费领奖活动奖励配置
	[1]={
		need=300, --需要消费金额
		gain={
		{GoodsType.item, 20014, 1 },
		{GoodsType.item, 90101, 3 },
		},	--兑换物品
	},
	[2]={
		need=500, --需要消费金额
		gain={
		{GoodsType.item, 20014, 2 },
		{GoodsType.item, 90101, 5 },
		},	--兑换物品
	},

	
}

