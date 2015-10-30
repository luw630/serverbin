--[[
file:	First_recharge.lua
author:	wk
update:	2015-07-09
desc:首冲
]]--
local f_recharge_conf={
	{GoodsType.hero, 101, 1 },--{类型，itemID, 数量} （如果类型不等于item，则填0）
	{GoodsType.money, 0, 188888 },
	{GoodsType.item,  20001,30 },
}

function f_recharge_award(sid)
	local state=get_Exdata(sid, 3) 
	if state==nil then return end
	if state==1 then 
		look("you have get awards")
		CI_SendFirstRechargeRes(2)--已领
		return 
	end
	local maxRecharge=CI_GetPlayerDataSG(0,7)--取历史最大充值数
	 if maxRecharge >0 then
		for k,v in pairs (f_recharge_conf) do
			CI_AddGoods_SG(v[1], v[2], v[3], GoodsWay.active)
		end
		set_Exdata(sid, 3, 1)
		CI_SendFirstRechargeRes(1)--成功
	 else
		 CI_SendFirstRechargeRes(3)--未充值
	 end
end