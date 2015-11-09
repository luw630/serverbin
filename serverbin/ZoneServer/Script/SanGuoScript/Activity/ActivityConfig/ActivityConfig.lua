

--------------------------------------------------活动类型,时间等配置--------------------------------------------------------------
--------------------------------------------------活动类型,时间等配置--------------------------------------------------------------
--------------------------------------------------活动类型,时间等配置--------------------------------------------------------------

--注意！！！！！！！！！！！！
--策划只需要修改活动开启和结束时间
serverstart = CI_GetStartTime()
ServerTime = tonumber(os.date("%Y%m%d",serverstart))

--新活动相关公共配置
g_ActivifyConfig = {}


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
	ActivityTime = {starttime = 20150930,endtime = 20151003,}, --活动开始和结束时间
	ActivityName = "PRAYER_ACTIVITY",						--限时祈福
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




--兑换活动
g_ActivifyConfig[ActIndex.exchange] = 
{
	ActivityID = 1008,
	ActivityType = ActivityType.PLAYER_TRIGGER,         --活动类型定义在ActivifyDefine
	ActivityEnable = true,								--活动动态开关,可以根据配置的时间开启或者关闭活动,也可以不配置时间
	ActivityTime = {starttime = 20150811,endtime = 20151001,}, --活动开始和结束时间
	ActivityName = "exchange",						--活动名称,英文或者字母用于活动的保存名称,活动名称不能重复
}




--------------------------------------------------------------------------------------
--开服活动 
--活动开启时间 = 服务器配置的开服时间
--英雄达到的等级的活动

--聚宝盆
g_ActivifyConfig[1] = 
{
	ActivityID = 1000,
	ActivityType = ActivityType.CHARGE_TRIGGER,         --活动类型定义在ActivifyDefine
	ActivityEnable = true,								--活动动态开关,可以根据配置的时间开启或者关闭活动,也可以不配置时间
	ActivityTime = {starttime = ServerTime,endtime = ServerTime + 14,}, --活动开始和结束时间
	ActivityName = "CHARGE_TRIGGER",						--聚宝盆
}

--充值返利
g_ActivifyConfig[2] = 
{
	ActivityID = 1001,
	ActivityType = ActivityType.CHARGE_TRIGGER,         --活动类型定义在ActivifyDefine
	ActivityEnable = false,								--活动动态开关,可以根据配置的时间开启或者关闭活动,也可以不配置时间
	ActivityTime = {starttime = ServerTime,endtime = ServerTime + 3,}, --活动开始和结束时间
	ActivityName = "Rebate",						--充值返利
}

--兑换码
g_ActivifyConfig[ActIndex.cdKey] = 
{
	ActivityID = 1007,
	ActivityType = ActivityType.PLAYER_TRIGGER,         --活动类型定义在ActivifyDefine
	ActivityEnable = false,								--活动动态开关,可以根据配置的时间开启或者关闭活动,也可以不配置时间
	ActivityTime = {starttime = ServerTime,endtime = ServerTime + 7,}, --活动开始和结束时间
	ActivityName = "GIFTKEY_ACTIVITY",						--兑换码
}

--消费领奖活动
g_ActivifyConfig[ActIndex.expense] = 
{
	ActivityID = 1009,
	ActivityType = ActivityType.PLAYER_TRIGGER,         --活动类型定义在ActivifyDefine
	ActivityEnable = false,								--活动动态开关,可以根据配置的时间开启或者关闭活动,也可以不配置时间
	ActivityTime = {starttime = ServerTime,endtime = ServerTime + 7,}, --活动开始和结束时间
	ActivityName = "expense",						--活动名称,英文或者字母用于活动的保存名称,活动名称不能重复
}

--消费返还活动
g_ActivifyConfig[ActIndex.expense_back] = 
{
	ActivityID = 1010,
	ActivityType = ActivityType.PLAYER_TRIGGER,         --活动类型定义在ActivifyDefine
	ActivityEnable = false,								--活动动态开关,可以根据配置的时间开启或者关闭活动,也可以不配置时间
	ActivityTime = {starttime = ServerTime,endtime = ServerTime + 7,}, --活动开始和结束时间
	ActivityName = "expense_back",						--活动名称,英文或者字母用于活动的保存名称,活动名称不能重复
}

--祈福次数活动
g_ActivifyConfig[ActIndex.bless] = 
{
	ActivityID = 1011,
	ActivityType = ActivityType.PLAYER_TRIGGER,         --活动类型定义在ActivifyDefine
	ActivityEnable = false,								--活动动态开关,可以根据配置的时间开启或者关闭活动,也可以不配置时间
	ActivityTime = {starttime = ServerTime,endtime = ServerTime + 7,}, --活动开始和结束时间
	ActivityName = "bless",						--活动名称,英文或者字母用于活动的保存名称,活动名称不能重复
}

--精英副本掉落双倍
g_ActivifyConfig[ActIndex.doubleDrop] = 
{
	ActivityID = 1012,
	ActivityType = ActivityType.PLAYER_TRIGGER,         --活动类型定义在ActivifyDefine
	ActivityEnable = false,								--活动动态开关,可以根据配置的时间开启或者关闭活动,也可以不配置时间
	ActivityTime = {starttime = ServerTime,endtime = ServerTime + 7,}, --活动开始和结束时间
	ActivityName = "doubleDrop",						--活动名称,英文或者字母用于活动的保存名称,活动名称不能重复
}

--副本挑战次数
g_ActivifyConfig[ActIndex.passinglevel] = 
{
	ActivityID = 1013,
	ActivityType = ActivityType.PASSINGLEVEL_TRIGGER,         --活动类型定义在ActivifyDefine
	ActivityEnable = false,								--活动动态开关,可以根据配置的时间开启或者关闭活动,也可以不配置时间
	ActivityTime = {starttime = ServerTime,endtime = ServerTime + 7,}, --活动开始和结束时间
	ActivityName = "passinglevel",						--活动名称,英文或者字母用于活动的保存名称,活动名称不能重复
}

--收集的英雄个数活动
g_ActivifyConfig[ActIndex.heroNums] = 
{
	ActivityID = 1014,
	ActivityType = ActivityType.HERONUM_INC_TRIGGER,         --活动类型定义在ActivifyDefine
	ActivityEnable = false,								--活动动态开关,可以根据配置的时间开启或者关闭活动,也可以不配置时间
	ActivityTime = {starttime = ServerTime,endtime = ServerTime + 7,}, --活动开始和结束时间
	ActivityName = "heroNums",						--活动名称,英文或者字母用于活动的保存名称,活动名称不能重复
}


--英雄等级
g_ActivifyConfig[ActIndex.heroLevels] = 
{
	ActivityID = 1015,
	ActivityType = ActivityType.HEROLEVEL_INC_TRIGGER,         --活动类型定义在ActivifyDefine
	ActivityEnable = true,								--活动动态开关,可以根据配置的时间开启或者关闭活动,也可以不配置时间
	ActivityTime = {starttime = ServerTime,endtime = ServerTime + 7,}, --活动开始和结束时间
	ActivityName = "heroLevels",						--活动名称,英文或者字母用于活动的保存名称,活动名称不能重复
}

--FackBook点赞
g_ActivifyConfig[ActIndex.FBThumbUp] = 
{
	ActivityID = 1016,
	ActivityType = ActivityType.PLAYER_TRIGGER,         --活动类型定义在ActivifyDefine
	ActivityEnable = true,								--活动动态开关,可以根据配置的时间开启或者关闭活动,也可以不配置时间
	ActivityTime = {starttime = ServerTime,endtime = ServerTime + 7,}, --活动开始和结束时间
	ActivityName = "FBThumbUp",						--FackBook点赞
}







