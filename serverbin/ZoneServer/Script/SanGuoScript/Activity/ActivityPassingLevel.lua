--[[
file:	ActivityPassingLevel.lua
author:	Jonson
update:	2015-11-02
desc:	三国的副本关卡通关次数奖励活动
]]--

--缓存副本通关次数活动奖励的配置文件
local PassingLevelActConfig = PassingLevelActConfig
local _ActIndex = ActIndex
local _ActivityRegister = ActivityRegister
local _SendLuaMsg = SendLuaMsg
local _msgh_s2c_def = msgh_s2c_def
local _s2c_msg = s2c_msg
--服务器发给客户端的通关活动的相关消息头
local passLevelActMsgHead = _msgh_s2c_def[_s2c_msg.act][6]
local _g_ActivifyConfig = g_ActivifyConfig

--生成活动实例
PassingLevelAct = Activitymodule:new()
--初始化活动的数据
PassingLevelAct:Init(_ActIndex.passinglevel)
--注册活动实例到活动管理器中
_ActivityRegister(PassingLevelAct)
--获取活动的相关数据
PassingActData = PassingLevelAct:LoadData()
--初始化活动的消息
local actMsg = {}

--获取某一个玩家的通关次数活动的数据
function PassingLevelAct:getPassLevelData(sid)
	--如果活动还没有开启，则不生成玩家数据
	if not self.ActivityEnable then
		return
	end
	
	if PassingActData[sid] == nil then
		PassingActData[sid] = { count = 0}
	end
	
	return PassingActData[sid]
end

--打包本活动的基础消息格式
local function baseMsgPack()
	--消息头的定义
	actMsg = { ids = passLevelActMsgHead }
end

--打包本活动的数据同步消息
local function SynDataMsgPack(sid)
	--获取玩家数据
	local pdata = PassingLevelAct:getPassLevelData(sid)
	if pdata == nil then
		return
	end
	actMsg.data = pdata
end

--打包活动奖励是否领取成功的相关的消息
local function RewardsGotMsgPack(state)
	actMsg.rewardsGot = state
end

--当活动触发的时候
function PassingLevelAct:OnTrigger(paramsTab)
	--开始获取传过来的玩家的ID和玩家通过某一个关卡的数量
	local sid
	local passingCount
	for k,v in pairs(paramsTab) do
		sid = k
		passingCount = v
	end
	
	if sid == nil or passingCount == nil then
		return
	end
	
	--记录玩家的通关的总次数
	local pdata = self:getPassLevelData(sid)
	pdata.count = pdata.count + passingCount
	--开始判断哪些奖励的领取条件已经满足了
	pdata.rewardsState = pdata.rewardsState or {}
	--此时必须要求PassingLevelActConfig配置的奖励需是连续的，不间断的
	for key, value in ipairs(PassingLevelActConfig) do
		if pdata.count >= value.count and pdata.rewardsState[key] == nil then
			--true代表可领取，false代表已领取，nil代表未达成
			pdata.rewardsState[key] = true
		end
	end
	--同步活动相关数据到客户端
	baseMsgPack()
	SynDataMsgPack(sid)
	_SendLuaMsg(sid, actMsg)
end

--客户端申请领取通关次数活动奖励
function GetPassingLevelActRewards(sid, rewardsIndex)
	if not PassingLevelAct.ActivityEnable then
		--还需加上告诉客户端，不予领取奖励的消息和活动结束的消息
		--同步活动相关数据到客户端
		baseMsgPack()
		_SendLuaMsg(sid, actMsg)
		return
	end
	
	--获取玩家数据
	local pdata = PassingLevelAct:getPassLevelData(sid)
	--判断是否可以领取奖励
	if pdata == nil or pdata.rewardsState == nil or not pdata.rewardsState[rewardsIndex] then
		--还需加上告诉客户端，不予领取奖励的消息
		--同步活动相关数据到客户端
		baseMsgPack()
		RewardsGotMsgPack(false)
		SynDataMsgPack(sid)
		_SendLuaMsg(sid, actMsg)
		return
	end
	
	--置为已经领取的状态
	pdata.rewardsState[rewardsIndex] = false
	pdata = PassingLevelAct:getPassLevelData(sid)
	--开始发放奖励
	for _, value in pairs(PassingLevelActConfig[rewardsIndex].reward) do
		CI_AddGoods_SG(value[1], value[2], value[3], GoodsWay.active)
		--look("领取奖励了" ..value[1]..";" ..value[2]..";"..value[3]..";"..index)
	end 
	
	--同步活动相关数据到客户端
	baseMsgPack()
	SynDataMsgPack(sid)
	RewardsGotMsgPack(true)
	_SendLuaMsg(sid, actMsg)
end

--同步通关次数活动的相关数据
function SynPassingLevelActData(sid)
	--开始依次打包消息
	baseMsgPack()
	SynDataMsgPack(sid)
	_SendLuaMsg(sid, actMsg)
end