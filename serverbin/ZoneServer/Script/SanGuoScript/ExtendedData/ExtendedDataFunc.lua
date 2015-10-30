--[[
file:	extendeddatafunc.lua
author:	lpd
update:	2015-06-19
desc:存储数据,某些只需要少量数据的功能可统一放这里存储以节约空间
]]--

SG_ExDataType = {
	BlessCount = 1, --这个是元宝十连祈福次数
	BlessMaxCount = 2,--控制十连抽必得三星武将的最大次数
	ChargeClaimedFlag = 3,--首冲领取标识
	TrainedFlag = 4, --首次训练是否完成的标识
	NewbieGoldFlag = 5, --新手必掉
	SendStaminaCount = 6, --赠送体力次数
	GetStaminaCount = 7, --领取体力次数
	ExpeditionTimes = 8,--过关斩将的通关关卡数
}

--扩展数据
local function get_ExResult(sid) 
	if dbMgr[sid]==nil or  dbMgr[sid].data==nil then 
		return
	end
	if dbMgr[sid].data['exdata']==nil then 
		dbMgr[sid].data['exdata']={
			[1] = 1,--这个是元宝十连祈福次数，第一次获取时值为1
			[2] = 2,--控制十连抽必得三星武将的最大次数
			[3] = 0,--首冲领取标识,1为领取过
			[4] = 0,--是否训练过的标示
			[5] = 0,--新手引导的金币是否掉落的标示
			[6] = FriendConfig.SendStaminaChance,--赠送体力次数
			[7]	= FriendConfig.ReceiveStaminaChance,--领取体力次数
			[8] = 0,--过关斩将打过的关卡数
		}
	end
	return dbMgr[sid].data['exdata']
end

--登陆同步数据
function exdata_firstlogin(sid,dataTb,index)
	local pdata = get_ExResult(sid)
	dataTb[index] = pdata[3]
	dataTb[index + 1] = pdata[4] or 0
	dataTb[index + 2] = pdata[5] or 0
	dataTb[index + 3] = sid --服务器的SID暂时由此处同步到客户端
	dataTb[index + 4] = pdata[8] --过关斩将的打过的关卡的总次数
	return index + 5
end

-- 获取功能数据,以dtype为key
function get_Exdata(sid, dtype) 
	local exdata = get_ExResult(sid)
	if exdata == nil then 
		return 
	end
	return exdata[dtype] or 0
end

-- 设置功能数据,以dtype为key
function set_Exdata(sid, dtype, value)
	local exdata = get_ExResult(sid)
	if exdata == nil or exdata[dtype] == nil then
		return
	end
	exdata[dtype] = value
	if dtype == 1 and value > 99999999 then --如果十连抽次数太大，则保持等于99999999
		exdata[dtype] = 99999999
	end
	return true
end
