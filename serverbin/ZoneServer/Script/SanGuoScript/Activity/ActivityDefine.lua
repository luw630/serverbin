
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
}

--活动大类型编号
ActIndex={
	
	cdKey=7, --兑换码
	exchange=8,--兑换活动
	expense=9, --消费活动
}