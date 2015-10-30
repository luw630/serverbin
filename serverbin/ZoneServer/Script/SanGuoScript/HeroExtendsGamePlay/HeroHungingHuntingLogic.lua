--[[
file:	HeroHungingHuntingLogic.lua
author:	Jonson
update:	2015-07-06
desc:	三国的武将挂机寻宝的逻辑
]]--

local _HeroExGameplayMode = HeroExGameplayMode
local _HeroExDataType = HeroExDataType
local _StartToHunting = StartToHunting
local _GetSpecifyExBaseData = GetSpecifyExBaseData
local _GetClassifiedHeroNum = GetClassifiedHeroNum
local _IncClassifiedHeroNum = IncClassifiedHeroNum
local _DecClassifiedHeroNum = DecClassifiedHeroNum
local _SetSpecifyExBaseData = SetSpecifyExBaseData
local _GetGameplayTimeParam = GetGameplayTimeParam

--开始挂机寻宝
function StartHunging(sid, heroID, heroNumLimit, masterLevel)
	local hungingHeroNum = _GetClassifiedHeroNum(sid, _HeroExGameplayMode.HuntingTreasure)
	--如果达到了能寻宝的人数限制的最顶层，则不予继续选择新的英雄挂机寻宝
	if hungingHeroNum >= heroNumLimit then
		return 0
	end
	
	local trainingState = _GetSpecifyExBaseData(sid, heroID, _HeroExDataType.trainingState)
	local huntingState = _GetSpecifyExBaseData(sid, heroID, _HeroExDataType.hungingHuntingState)
	--如果指定的英雄还在挂机寻宝或者还在训练，则不予挂机寻宝
	if trainingState ~= 0 or huntingState ~= 0 then
		return 0
	end
	
	--记录该英雄挂机的状态
	_StartToHunting(sid, heroID, masterLevel)
	--设置挂机的起始时间
	local curTime = GetServerTime()
	SetGameplayTimeParam(sid, heroID, curTime)
	--更新当前玩家正在寻宝的英雄的个数
	_IncClassifiedHeroNum(sid, _HeroExGameplayMode.HuntingTreasure)
	return 1
end

--申请掉宝,maxRequestTimes代表最多能申请多少次的掉宝,gapTime代表每隔多久才能申请掉宝一次
function RequestSurprisePresents(sid, heroID, maxRequestTimes, gapTime)
	--获取已经申请掉宝多少次了
	local requestedTimes = _GetSpecifyExBaseData(sid, heroID, _HeroExDataType.surprisedTimes)
	look("requestedTimes " .. requestedTimes)
	--如果已经申请的次数超过了最大的次数(最大次数不能超过9)，则不予掉宝
	if requestedTimes >= maxRequestTimes or requestedTimes >= 9 then
		return 0
	end
	
	local huntingState = _GetSpecifyExBaseData(sid, heroID, _HeroExDataType.hungingHuntingState)
	--如果武将没有在挂机寻宝，则不予结算
	if huntingState == 0 then
		look("Not Hunging")
		return 0
	end
	
	local curTime = GetServerTime()
	--获取该武将开始挂机的时间
	local gameplayStartTime = _GetGameplayTimeParam(sid, heroID)
	gameplayStartTime = gameplayStartTime + requestedTimes * gapTime
	local elaspedTime = curTime - gameplayStartTime
	--多次掉宝
	local randomTimes = math.floor(elaspedTime / gapTime)
	randomTimes = math.min(maxRequestTimes, requestedTimes + randomTimes) - requestedTimes
	--申请掉宝数+1
	if randomTimes > 0 then
		_SetSpecifyExBaseData(sid, heroID, _HeroExDataType.surprisedTimes, randomTimes)
	end
	look("randomTimes " .. randomTimes)
	--在C++端进行随机掉宝的操作
	return randomTimes
end

--申请挂机寻宝的结算, maxHungingTime表示最长能挂机多长时间，gapTime代表每隔多少秒就增加一个基础值
function RequestHungingLiquidation(sid, heroID, maxHungingTime, gapTime)
	local huntingState = _GetSpecifyExBaseData(sid, heroID, _HeroExDataType.hungingHuntingState)
	--如果武将没有在挂机寻宝，则不予结算
	if huntingState == 0 then
		return 0
	end
	
	local gameplayStartTime = _GetGameplayTimeParam(sid, heroID)
	local curTime = GetServerTime()
	--获得开始该玩法已经过了多长时间
	curTime = curTime - gameplayStartTime
	curTime = math.min(maxHungingTime, curTime)
	--算出在玩法的持续时间中，总共会增加多少次金钱
	curTime = math.floor(curTime / gapTime)
	--重置挂机的状态
	ResetExBaseData(sid, heroID)
	--更新当前玩家正在寻宝的英雄的个数
	_DecClassifiedHeroNum(sid, _HeroExGameplayMode.HuntingTreasure)
	--进行金币的结算
	return curTime
end

