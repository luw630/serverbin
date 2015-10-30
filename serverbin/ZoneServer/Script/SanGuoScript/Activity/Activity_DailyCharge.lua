--[[
file:	Activity_DailyCharge.lua
author:	Jonson
update:	2015-07-09
desc:	三国的每日充值的活动
]]--

--生成新的活动类型的实例
DailyChargeActivity = Activitymodule:new()
--初始化活动类型
DailyChargeActivity:Init(2)
--向ActivityManager注册本活动
ActivityRegister(DailyChargeActivity)
--获取所有玩家的本活动的基本数据
DailyChargeData = DailyChargeActivity:LoadData()	--玩家的每日充值数据

function DailyChargeActivity:OnTrigger(actParam) --当触发时做的事情,根据需要传递不同的参数，活动不同可以传递不同
	look("MyActivity OnTrigger "..self.ActivityID.."   Type "..self.ActivityType.."   name "..self.ActivityName)
	self:ChargeGiveItem(100,1000)
end

