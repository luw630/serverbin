--[[
file:	First_recharge.lua
author:	wk
update:	2015-07-09
desc:�׳�
]]--
local f_recharge_conf={
	{GoodsType.hero, 101, 1 },--{���ͣ�itemID, ����} ��������Ͳ�����item������0��
	{GoodsType.money, 0, 188888 },
	{GoodsType.item,  20001,30 },
}

function f_recharge_award(sid)
	local state=get_Exdata(sid, 3) 
	if state==nil then return end
	if state==1 then 
		look("you have get awards")
		CI_SendFirstRechargeRes(2)--����
		return 
	end
	local maxRecharge=CI_GetPlayerDataSG(0,7)--ȡ��ʷ����ֵ��
	 if maxRecharge >0 then
		for k,v in pairs (f_recharge_conf) do
			CI_AddGoods_SG(v[1], v[2], v[3], GoodsWay.active)
		end
		set_Exdata(sid, 3, 1)
		CI_SendFirstRechargeRes(1)--�ɹ�
	 else
		 CI_SendFirstRechargeRes(3)--δ��ֵ
	 end
end