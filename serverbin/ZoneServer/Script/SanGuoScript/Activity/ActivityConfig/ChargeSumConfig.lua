--[[
file:	ChargeSsumConfig.lua
author:	lpd
update:	2015-11-04
desc:累计充值活动配置
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

ChargeSumConfig =   --充值累计奖励
{
	isResetEveryDay=1, ---=1每日重置数据,=2不重置
	[1] = {
			miniCharge=6, --充值总额超条件
			reward={--奖励列表
					[1]={GoodsType.item, 20020, 5 },
					[2]={GoodsType.item, 20001, 5 },
					[3]={GoodsType.item, 20007, 5 },
					[4]={GoodsType.item, 20018, 1 },
					},
		  },
	[2] = {
			miniCharge=30, --充值总额超条件
			reward={--奖励列表
					[1]={GoodsType.item, 20020, 20 },
					[2]={GoodsType.item, 20001, 10 },
					[3]={GoodsType.item, 20007, 10 },
					[4]={GoodsType.item, 20018, 2 },
					},
		  },
	[3] = {
			miniCharge=98, --条件
			reward={--奖励列表
					[1]={GoodsType.item, 20020, 50 },
					[2]={GoodsType.item, 20001, 20 },
					[3]={GoodsType.item, 20007, 20 },
					[4]={GoodsType.item, 20018, 4 },
					},
		  },		

}