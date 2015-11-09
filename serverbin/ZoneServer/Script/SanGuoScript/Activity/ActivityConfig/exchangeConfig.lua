--[[
file:	exchangeConfig.lua
author:	wk
update:	2015-11-04
desc:兑换活动
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



--兑换活动配置  每栏下need=需要物品,gain=兑换物品 vipTime=可兑换次数
exchangeACT_cfg={
	[1]={
		need={{GoodsType.diamond, 0, 100 }}, --需要物品
		gain={{GoodsType.item, 90106, 5 },{GoodsType.item, 20001, 2 },{GoodsType.item, 20009, 1 },},	--兑换物品
		vipTime={1,1,1,2,2,2,3,3,3,4,4,4,5,5,5},--可兑换次数,vip 0-15
	},
	[2]={
		need={{GoodsType.money, 0, 50000 }},
		gain={{GoodsType.item, 20002, 1 },{GoodsType.item, 20004, 1 },{GoodsType.item, 20007, 1 },},	
		vipTime={2,2,2,3,3,3,4,4,4,5,5,5,6,6,6},--可兑换次数,vip 0-15
	},
	[3]={
		need={{GoodsType.item, 20000, 5 }},
		gain={{GoodsType.item, 20001, 5 },{GoodsType.item, 20002, 5 },},	
		vipTime={3,3,3,4,4,4,5,5,5,6,6,6,7,7,7},--可兑换次数,vip 0-15
	},
	[4]={
		need={{GoodsType.item, 20005, 3 },{GoodsType.item, 20006, 3 },},
		gain={{GoodsType.item, 20004, 5 }},	
		vipTime={1,1,1,2,2,2,3,3,3,4,4,4,5,5,5},--可兑换次数,vip 0-15
	},
	
	
}