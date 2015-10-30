ActivityNotice = {}
ActivityNewS = {}

ActivityNotice[1] =
{
	ActivityReward = {8020001},						--活动奖励
	Activity =
	{
		ActivityName = "送财神活动",					--活动名称(10)
		Activitydescribe = "用花粉兑换银两",				--活动描述(50)
		ActivityNpcName = "小财神，中财神，大财神",						--活动NPC名称(10)
		ActivityDate = 0,			--活动日期
		ActivityType = 0,					--活动类型
		ActivityStartTime = 0,				--活动开始时间
		ActivityEntryRegin = 150,				--活动入口场景id
		ActivityEntryCoordX = 797,			--活动入口坐标
		ActivityEntryCoordY = 1024,
	}
}

ActivityNotice[2] =
{
	ActivityReward = {8024001},						--活动奖励
	Activity =
	{
		ActivityName = "君子劝酒",					--活动名称(10)
		Activitydescribe = "用酒兑换经验",				--活动描述(50)
		ActivityNpcName = "酒鬼，酒仙，酒神",						--活动NPC名称(10)
		ActivityDate = 0,			--活动日期
		ActivityType = 0,					--活动类型
		ActivityStartTime = 0,				--活动开始时间
		ActivityEntryRegin = 2,				--活动入口场景id
		ActivityEntryCoordX = 790,			--活动入口坐标
		ActivityEntryCoordY = 974,
	}
}

ActivityNotice[3] =
{
	ActivityReward = {},						--活动奖励
	Activity =
	{
		ActivityName = "福禄寿",					--活动名称(10)
		Activitydescribe = "每天进入福缘洞有几率获得极品道具",				--活动描述(50)
		ActivityNpcName = "福禄寿",						--活动NPC名称(10)
		ActivityDate = 0,			--活动日期
		ActivityType = 0,					--活动类型
		ActivityStartTime = 0,				--活动开始时间
		ActivityEntryRegin = 2,				--活动入口场景id
		ActivityEntryCoordX = 895,			--活动入口坐标
		ActivityEntryCoordY = 785,
	}
}

ActivityNotice[4] =
{
	ActivityReward = {},						--活动奖励
	Activity =
	{
		ActivityName = "益气养神",					--活动名称(10)
		Activitydescribe = "每天进入练功房杀怪获取大量经验",				--活动描述(50)
		ActivityNpcName = "酒仙",						--活动NPC名称(10)
		ActivityDate = 0,			--活动日期
		ActivityType = 0,					--活动类型
		ActivityStartTime = 0,				--活动开始时间
		ActivityEntryRegin = 2,				--活动入口场景id
		ActivityEntryCoordX = 895,			--活动入口坐标
		ActivityEntryCoordY = 785,
	}
}


ActivityNotice[5] =
{
	ActivityReward = {},						--活动奖励
	Activity =
	{
		ActivityName = "清除恶徒",					--活动名称(10)
		Activitydescribe = "每天下午8点以后到无极岛杀怪可获得双倍经验",				--活动描述(50)
		ActivityNpcName = "",						--活动NPC名称(10)
		ActivityDate = 0,			--活动日期
		ActivityType = 0,					--活动类型
		ActivityStartTime = 0,				--活动开始时间
		ActivityEntryRegin = 3,				--活动入口场景id
		ActivityEntryCoordX = 271,			--活动入口坐标
		ActivityEntryCoordY = 1400,
	}
}


ActivityNewS[1] =
{
	NewSIndex = 1,
	NewSDescribe = "新闻内容",	--新闻内容(50)
}


function LoadActivityNotice()
	for k, v in pairs(ActivityNotice) do
	--rfalse(v.ActivityName)
	setactivityNotice(v.Activity,v.ActivityReward[1],v.ActivityReward[2])
	end
end

--sreset







