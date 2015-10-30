

--------------------------------------------------活动类型,时间等配置--------------------------------------------------------------
--------------------------------------------------活动类型,时间等配置--------------------------------------------------------------
--------------------------------------------------活动类型,时间等配置--------------------------------------------------------------

--新活动相关公共配置
g_ActivifyConfig = {}

--
g_ActivifyConfig[1] = 
{
	ActivityID = 1000,
	ActivityType = ActivityType.CHARGE_TRIGGER,         --活动类型定义在ActivifyDefine
	ActivityEnable = true,								--活动动态开关,可以根据配置的时间开启或者关闭活动,也可以不配置时间
	ActivityTime = {starttime = 20150928,endtime = 20151003,}, --活动开始和结束时间
	ActivityName = "CHARGE_TRIGGER",						--聚宝盆
}


--充值返利
g_ActivifyConfig[2] = 
{
	ActivityID = 1001,
	ActivityType = ActivityType.CHARGE_TRIGGER,         --活动类型定义在ActivifyDefine
	ActivityEnable = true,								--活动动态开关,可以根据配置的时间开启或者关闭活动,也可以不配置时间
	ActivityTime = {starttime = 20150705,endtime = 20150928,}, --活动开始和结束时间
	ActivityName = "Rebate",						--充值返利
}

--基金
g_ActivifyConfig[6] = 
{
	ActivityID = 1006,

	ActivityType = ActivityType.OCEAN_TRIGGER,         --活动类型定义在ActivifyDefine

	ActivityEnable = true,								--活动动态开关,可以根据配置的时间开启或者关闭活动,也可以不配置时间
	ActivityTime = {starttime = 20150705,endtime = 20161001,}, --活动开始和结束时间
	ActivityName = "WeeksReturnMoney",						--元宝基金
}


--充值总额活动
g_ActivifyConfig[3] = 
{
	ActivityID = 1002,
	ActivityType = ActivityType.CHARGE_TRIGGER,         --活动类型定义在ActivifyDefine
	ActivityEnable = false,								--活动动态开关,可以根据配置的时间开启或者关闭活动,也可以不配置时间
	ActivityTime = {starttime = 20151012,endtime = 20151014,}, --活动开始和结束时间
	ActivityName = "CHARGE_SUM_REWARD",						--累计充值
}

--限时祈福
g_ActivifyConfig[5] = 
{
	ActivityID = 1005,
	ActivityType = ActivityType.PLAYER_TRIGGER,         --活动类型定义在ActivifyDefine
	ActivityEnable = false,								--活动动态开关,可以根据配置的时间开启或者关闭活动,也可以不配置时间
	ActivityTime = {starttime = 20150930,endtime = 20151223,}, --活动开始和结束时间
	ActivityName = "PRAYER_ACTIVITY",						--限时祈福
}

--兑换码
g_ActivifyConfig[ActIndex.cdKey] = 
{
	ActivityID = 1007,
	ActivityType = ActivityType.PLAYER_TRIGGER,         --活动类型定义在ActivifyDefine
	ActivityEnable = true,								--活动动态开关,可以根据配置的时间开启或者关闭活动,也可以不配置时间
	ActivityTime = {starttime = 20150811,endtime = 20151001,}, --活动开始和结束时间
	ActivityName = "GIFTKEY_ACTIVITY",						--兑换码
}

--兑换活动
g_ActivifyConfig[ActIndex.exchange] = 
{
	ActivityID = 1008,
	ActivityType = ActivityType.PLAYER_TRIGGER,         --活动类型定义在ActivifyDefine
	ActivityEnable = true,								--活动动态开关,可以根据配置的时间开启或者关闭活动,也可以不配置时间
	ActivityTime = {starttime = 20150811,endtime = 20151001,}, --活动开始和结束时间
	ActivityName = "exchange",						--活动名称,英文或者字母用于活动的保存名称,活动名称不能重复
}

--消费活动
g_ActivifyConfig[ActIndex.expense] = 
{
	ActivityID = 1009,
	ActivityType = ActivityType.PLAYER_TRIGGER,         --活动类型定义在ActivifyDefine
	ActivityEnable = true,								--活动动态开关,可以根据配置的时间开启或者关闭活动,也可以不配置时间
	ActivityTime = {starttime = 20150811,endtime = 20151001,}, --活动开始和结束时间
	ActivityName = "expense",						--活动名称,英文或者字母用于活动的保存名称,活动名称不能重复
}




--------------------------------------------------以下为功能配置相关--------------------------------------------------------------
--------------------------------------------------以下为功能配置相关--------------------------------------------------------------
--------------------------------------------------以下为功能配置相关--------------------------------------------------------------

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

