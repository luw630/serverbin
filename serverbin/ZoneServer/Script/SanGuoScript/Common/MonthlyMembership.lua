--[[
file:	MonthlyMembership.lua
author:	lpd
update:	2015-08-24
desc:月卡
]]--

local membershipTime = 30 * 24 * 60 * 60 --会员时间 30天转化为秒
local membershipFee = 250 --月卡会员费
local diamondGift = 250
local vipGift = 250
local function Recharge_getdata( sid )
	if dbMgr[sid]==nil or  dbMgr[sid].data==nil then 
		return
	end
	if dbMgr[sid].data['monthly'] == nil then 
		dbMgr[sid].data['monthly'] = 
		{
			[1] = 1,--充值标识 0 默认值 1 购买金币 2购买月卡
			[2] = -1,--到期时间
		}
	end
	return dbMgr[sid].data['monthly']
end

function BuyMonthlyMembership(sid, money)--购买月卡,返回月卡到期时间
	local monthlyData = Recharge_getdata(sid)
	local curMoney = money
	local curTime = GetServerTime()
	local result = false
	look("玩家购买月卡==============")
	look(money)
	look(sid)
	look(curTime)
	--if monthlyData[1] == 2 then
	if true then
		if monthlyData[2] <= curTime then--如果月卡到期时间小于当前时间，则改为当前时间
			monthlyData[2] = curTime
			look(monthlyData[2])
		end
		while curMoney >= membershipFee do
			curMoney = curMoney - membershipFee
			monthlyData[2] = monthlyData[2] + membershipTime
			look("11111111111111111")
			look(monthlyData[2])
			CI_AddGoods_SG(15, 0, 1, GoodsWay.monthlyMembership, sid) --数据库记录月卡
			CI_AddGoods_SG(2, 0, diamondGift,GoodsWay.monthlyMembership, sid) --元宝赠品
			CI_AddGoods_SG(10,0, vipGift,GoodsWay.monthlyMembership, sid) --VIP赠品
			ActivityOnCharge(sid, membershipFee) --玩家充值成功后活动回调,现在充值月卡也算作累计充值
			look(sid)
		end
		if money >= membershipFee then
			look("开启任务")
			SwitchMounthCardMission(sid, true, true) --开启每日任务
			SynMembershipDate(sid)
			result = true
		end
		if curMoney > 0 then
			CI_AddGoods_SG(2, 0, curMoney, GoodsWay.monthlyMembership,sid)
			OnChagreSuccess(sid, curMoney)
			look("购买月卡多出余额，当做玩家充值")
		end
		curTime = monthlyData[2]
	end
	SetRechargeFlag(sid, 0) --重置充值标记
	monthlyData[1] = 0
	look("购买月卡完毕==============")
	return result
end


function SetRechargeFlag(sid, flag) -- 1 充值进入购买月卡流程 | -1 充值为购买游戏币流程
	local monthlyData = Recharge_getdata(sid)
	monthlyData[1] = flag
	-- look("设置充值标记")
	-- look(monthlyData[1])
	return monthlyData[1]
end

function GetRechargeFlag(sid) --获取购买月卡标记
	local monthlyData = Recharge_getdata(sid)
	-- look("获取充值标记")
	-- look(monthlyData[1])
	return monthlyData[1]
end
	
function IsMonthlyMem(sid) --是否为月卡会员
	local monthlyData = Recharge_getdata(sid)
	if monthlyData[2] > GetServerTime() then 
		 return true
	end
	return false 
end

function SynMembershipDate(sid) --登录同步
	local monthlyData = Recharge_getdata(sid)
	look("同步月卡时间")
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

	CI_AddGoods_SG(2, 0, chargeNum,GoodsWay.chargeRebate, sid) --元宝赠品
	-- body
end

-- function TestMounthCardMission()
	-- look("SwitchMounthCardMission")
	-- local sid = 1000100511  
	-- BuyMonthlyMembership(sid, 25)
	-- SynMembershipDate(sid)
-- end