--[[
file:	globalType.lua
author:	wk
update:	2015-05-14
desc:全局配置相关
]]--
--游戏点数配置表
GoodsType = {
	money = 1, --铜钱
	diamond = 2,  --钻石
	item = 3, --道具
	hero = 4, --英雄
	Exp = 5,--经验
	honor = 6,--荣誉
	exploit = 7,--军功
	endurance = 8,--体力
	level = 9, --君主等级
	vipExp = 10, --vip点数
	Prestige=11,--声望，国战产出的声望
	blessPoints = 12,--祈福产出的祈福积分
	soulPoints = 13,--分解将魂产出的魂点
	token = 14, --军团产出的军令
}

--物品来源以及流向类型,日志使用,参照策划 "产出与消耗.xlsx"
GoodsWay= {

	duplicate=1,	--副本
	checkIn =2,		--签到
	exploitMall=3,		--军功商城,远征商店
	honorMall=4,		--荣誉商城,竞技场商店
	findCowry = 5,		--秘境寻宝	
	passCustoms = 6,	--过关斩将	
	heroLegend= 7,		--将神传说	
	practiceForce= 8,		--练武场	
	recharge = 9,		--充值	
	task = 10,			--任务
	achievement = 11,	--	成就	
	active = 12,			--活动	
	mainCityActive = 13,	--主城活动	
	varietyMall = 14,	--杂货铺	
	forgeMall = 15,		--铁匠铺	
	bless = 16,			--祈福
	addskill = 17,		--加技能	
	buyskill = 18,		--购买技能点数	
	luckMan = 19,		--奇缘商人	
	gemMan = 20,		--珍宝商人	
	goldenTouch= 21,	--点金手	
	bugEndurance = 22,	--购买体力	
	cdtimeEndurance = 23,	--时间回复(体力)	
	itemUse = 24,		--道具使用或出售
	LegionShop = 25,		--军团商店,用声望买
	mail=26,--邮件获取
	lvup=27,--人物升级
	fanctionWar = 28, --军团战
	giftVipexp = 29,		--赠送vip经验值	
	hungingHunting = 30, --武将挂机寻宝
	heroTraining = 31, --武将的训练
	chargeRebate = 32, --充值返利
	changename = 33, --改名
	warOfLeague = 34, --国战
	soulExchange = 35,--将魂兑换
	monthlyMembership = 36, --月卡
	StaminaGift = 37, --好友赠送体力
	exchangeACT = 38,--兑换活动

	monthlyMembership = 36, --月卡购买
}

--取玩家属性 编号
AttType={
	sid=0,
	money=1,
	diamond=2,
	lv=3,
	name=4,
	recharge=7, --充值总额
	fight=8, --战力
	iconId=9, --头像
	factionId=10,
	factionName=11,
}

