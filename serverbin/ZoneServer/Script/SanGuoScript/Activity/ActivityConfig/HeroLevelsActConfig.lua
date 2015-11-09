--[[
file:	HeroLevelsActConfig.lua
author:	Jonson
update:	2015-11-5
desc:	三国的英雄提升的活动
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

--武将的等级的奖励活动的配置
HeroLevelsActConfig = 
{
	[1] = {
			count = 15, --领取本奖励需要使某一个武将达到的等级
			reward = {--奖励列表
					[1]={GoodsType.item, 20013, 1 },
					[2]={GoodsType.item, 20001, 5 },
					},
		  },
	[2] = {
			count = 20, --领取本奖励需要使某一个武将达到的等级
			reward = {--奖励列表
					[1]={GoodsType.item, 20013, 2 },
					[2]={GoodsType.item, 20001, 10 },
					},
		  },
	[3] = {
			count = 30, --领取本奖励需要使某一个武将达到的等级
			reward = {--奖励列表
					[1]={GoodsType.item, 20013, 3 },
					[2]={GoodsType.item, 20001, 15 },
					},
		  },
}