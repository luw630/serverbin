
--活动触发类型
ActivityType = 
{
	LOGIN_TRIGGER = 1,		--登陆触发
	LEVEL_TRIGGER = 2,		--当玩家等级达到时
	LIMITTIME_TRIGGER = 3,	--限定时间内触发
	EVERYTIME_TRIGGER = 4,	--定时触发  --
	CHARGE_TRIGGER = 5,		--充值是触发
	PLAYER_TRIGGER = 6,		--玩家自己点击时候才触发
	OCEAN_TRIGGER = 7,		--玩家自己点击时候才触发
	PASSINGLEVEL_TRIGGER = 8, --玩家通关副本关卡的时候才触发
	HERONUM_INC_TRIGGER = 9,--英雄数量增加的时候才触发
	HEROLEVEL_INC_TRIGGER = 10,--英雄等级上升的时候才触发
}

--活动大类型编号
ActIndex={
	
	cdKey=7, --兑换码
	exchange=8,--兑换活动
	expense=9, --消费领奖活动
	expense_back=10, --消费返还活动
	bless = 11, --祈福活动
	doubleDrop = 12, --加倍掉落
	passinglevel = 13, --游戏关卡通关活动
	heroNums = 14, --英雄个数活动
	heroLevels = 15, --英雄等级活动
	FBThumbUp = 16 ,--facebook点赞
}