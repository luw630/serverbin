--[[
file:	MonthlyMembership.lua
author:	lpd
update:	2015-08-24
desc:�¿�
]]--

local membershipTime = 30 * 24 * 60 * 60 --��Աʱ�� 30��ת��Ϊ��
local membershipFee = 250 --�¿���Ա��
local diamondGift = 250
local vipGift = 250
local function Recharge_getdata( sid )
	if dbMgr[sid]==nil or  dbMgr[sid].data==nil then 
		return
	end
	if dbMgr[sid].data['monthly'] == nil then 
		dbMgr[sid].data['monthly'] = 
		{
			[1] = 1,--��ֵ��ʶ 0 Ĭ��ֵ 1 ������ 2�����¿�
			[2] = -1,--����ʱ��
		}
	end
	return dbMgr[sid].data['monthly']
end

function BuyMonthlyMembership(sid, money)--�����¿�,�����¿�����ʱ��
	local monthlyData = Recharge_getdata(sid)
	local curMoney = money
	local curTime = GetServerTime()
	local result = false
	look("��ҹ����¿�==============")
	look(money)
	look(sid)
	look(curTime)
	--if monthlyData[1] == 2 then
	if true then
		if monthlyData[2] <= curTime then--����¿�����ʱ��С�ڵ�ǰʱ�䣬���Ϊ��ǰʱ��
			monthlyData[2] = curTime
			look(monthlyData[2])
		end
		while curMoney >= membershipFee do
			curMoney = curMoney - membershipFee
			monthlyData[2] = monthlyData[2] + membershipTime
			look("11111111111111111")
			look(monthlyData[2])
			CI_AddGoods_SG(15, 0, 1, GoodsWay.monthlyMembership, sid) --���ݿ��¼�¿�
			CI_AddGoods_SG(2, 0, diamondGift,GoodsWay.monthlyMembership, sid) --Ԫ����Ʒ
			CI_AddGoods_SG(10,0, vipGift,GoodsWay.monthlyMembership, sid) --VIP��Ʒ
			ActivityOnCharge(sid, membershipFee) --��ҳ�ֵ�ɹ����ص�,���ڳ�ֵ�¿�Ҳ�����ۼƳ�ֵ
			look(sid)
		end
		if money >= membershipFee then
			look("��������")
			SwitchMounthCardMission(sid, true, true) --����ÿ������
			SynMembershipDate(sid)
			result = true
		end
		if curMoney > 0 then
			CI_AddGoods_SG(2, 0, curMoney, GoodsWay.monthlyMembership,sid)
			OnChagreSuccess(sid, curMoney)
			look("�����¿������������ҳ�ֵ")
		end
		curTime = monthlyData[2]
	end
	SetRechargeFlag(sid, 0) --���ó�ֵ���
	monthlyData[1] = 0
	look("�����¿����==============")
	return result
end


function SetRechargeFlag(sid, flag) -- 1 ��ֵ���빺���¿����� | -1 ��ֵΪ������Ϸ������
	local monthlyData = Recharge_getdata(sid)
	monthlyData[1] = flag
	-- look("���ó�ֵ���")
	-- look(monthlyData[1])
	return monthlyData[1]
end

function GetRechargeFlag(sid) --��ȡ�����¿����
	local monthlyData = Recharge_getdata(sid)
	-- look("��ȡ��ֵ���")
	-- look(monthlyData[1])
	return monthlyData[1]
end
	
function IsMonthlyMem(sid) --�Ƿ�Ϊ�¿���Ա
	local monthlyData = Recharge_getdata(sid)
	if monthlyData[2] > GetServerTime() then 
		 return true
	end
	return false 
end

function SynMembershipDate(sid) --��¼ͬ��
	local monthlyData = Recharge_getdata(sid)
	look("ͬ���¿�ʱ��")
	look(monthlyData[2])
	if monthlyData[2] > GetServerTime() then
		CI_SynMembershipToClient(sid,monthlyData[2]) --
	end
end

function  FirstRecharge( sid, chargeNum )
	local closeFunc = true
	if closeFunc == true then
		return
	end

	CI_AddGoods_SG(2, 0, chargeNum,GoodsWay.chargeRebate, sid) --Ԫ����Ʒ
	-- body
end

-- function TestMounthCardMission()
	-- look("SwitchMounthCardMission")
	-- local sid = 1000100511  
	-- BuyMonthlyMembership(sid, 25)
	-- SynMembershipDate(sid)
-- end