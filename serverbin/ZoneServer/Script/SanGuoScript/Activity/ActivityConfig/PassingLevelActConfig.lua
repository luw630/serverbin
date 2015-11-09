--[[
file:	PassingLevelActConfig.lua
author:	Jonson
update:	2015-11-5
desc:	三国的通关副本关卡奖励的增加的活动
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

--副本通关次数奖励活动的配置
PassingLevelActConfig = 
{
	[1] = {
			count = 20, --领取本奖励需要通关的次数
			reward = {--奖励列表
					[1]={GoodsType.diamond, 0, 2 },
					[2]={GoodsType.money, 0, 5000 },
					[3]={GoodsType.item, 20013, 5 },
					},
		  },
	[2] = {
			count = 50, --领取本奖励需要通关的次数
			reward = {--奖励列表
					[1]={GoodsType.diamond, 0, 5 },
					[2]={GoodsType.money, 0, 10000 },
					[3]={GoodsType.item, 20014, 1 },
					},
		  },
	[3] = {
			count = 100, --领取本奖励需要通关的次数
			reward = {--奖励列表
					[1]={GoodsType.diamond, 0, 10 },
					[2]={GoodsType.money, 0, 20000 },
					[3]={GoodsType.item, 20015, 1 },
					},
		  },

		  	  
}