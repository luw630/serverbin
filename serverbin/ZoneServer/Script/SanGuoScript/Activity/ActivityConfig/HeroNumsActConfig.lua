--[[
file:	HeroNumsActConfig.lua
author:	Jonson
update:	2015-11-5
desc:	三国的英雄数量增加的活动
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

--武将角色数量的奖励活动的配置
HeroNumsActConfig =   
{
	[1] = {
			count = 3, --领取本奖励需要集齐的武将的数量
			reward = {--奖励列表
					[1]={GoodsType.item, 20000, 5 },
					[2]={GoodsType.diamond, 0, 5 },

					},
		  },
	[2] = {
			count = 5, --领取本奖励需要集齐的武将的数量
			reward = {--奖励列表
					[1]={GoodsType.item, 20000, 10 },
					[2]={GoodsType.diamond, 0, 10 },
					},
		  },

}