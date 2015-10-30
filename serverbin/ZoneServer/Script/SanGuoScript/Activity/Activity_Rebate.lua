
RebateActivity =  Activitymodule:new()
RebateActivity:Init(2)
ActivityRegister(RebateActivity)
RebateActData = RebateActivity:LoadData()	--玩家的聚宝盆数据

function RebateActivity:OnTrigger(actParam) --当触发时做的事情,根据需要传递不同的参数，活动不同可以传递不同
	if RebateActivity:GetActivityEnable() == false then
		return
	end
	--look("双倍充值活动开启,测试日志，记得删除")
	local sid
	local chargNum

	for k,v in pairs(actParam) do
		sid = k
		chargNum = v
	end
	
	if sid == nil or chargNum == nil then
		return
	end
	CI_AddGoods_SG(2,0,chargNum*2,GoodsWay.chargeRebate,sid) --返利钱
	CI_AddGoods_SG(10,0,chargNum*2,GoodsWay.chargeRebate,sid)--返利vip
end



