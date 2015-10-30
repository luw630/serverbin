--[[
file:	HeroTrainingLogic.lua
author:	Jonson
update:	2015-07-06
desc:	三国的武将训练的逻辑
]]--

local _HeroExGameplayMode = HeroExGameplayMode
local _HeroExDataType = HeroExDataType
local _GoodsType = GoodsType
local _GetClassifiedHeroNum = GetClassifiedHeroNum
local _IncClassifiedHeroNum = IncClassifiedHeroNum
local _DecClassifiedHeroNum = DecClassifiedHeroNum
local _GetSpecifyExBaseData = GetSpecifyExBaseData
local _SetSpecifyExBaseData = SetSpecifyExBaseData
local _StartToTrainingHero = StartToTrainingHero
local _SG_ExDataType = SG_ExDataType

--申请开始训练某一个英雄
function RequestStartTraining(sid, heroID, tType, masterLevel, heroNumLimit)
	local hungingHeroNum = _GetClassifiedHeroNum(sid, _HeroExGameplayMode.Training)
	--如果达到了能训练的人数限制的最顶层，则不予继续选择新的英雄训练
	if hungingHeroNum >= heroNumLimit then
		return 0
	end
	
	local trainingState = _GetSpecifyExBaseData(sid, heroID, _HeroExDataType.trainingState)
	local huntingState = _GetSpecifyExBaseData(sid, heroID, _HeroExDataType.hungingHuntingState)
	--如果指定的英雄还在挂机寻宝或者还在训练，则不予训练
	if trainingState ~= 0 or huntingState ~= 0 then
		return 0
	end
	
	--记录该英雄训练的状态
	_StartToTrainingHero(sid, heroID, masterLevel, tType)
	--设置训练的起始时间
	local curTime = GetServerTime()
	SetGameplayTimeParam(sid, heroID, curTime)
	--更新当前玩家正在寻宝的英雄的个数
	_IncClassifiedHeroNum(sid, _HeroExGameplayMode.Training)
	return 1
end

--申请对某一个英雄的训练结算,diamondCosted表示是否用的元宝来结束的训练，maxTrainingTime表示最长能训练多长时间，gapTime代表每隔多少秒就增加一个基础值
function RequestTrainingLiquidation(sid, heroID, diamondCosted, maxTrainingTime, gapTime, costPerUnitTime)
	local trainingState = _GetSpecifyExBaseData(sid, heroID, _HeroExDataType.trainingState)
	--如果武将没有在训练，则不予结算
	if trainingState == 0 then
		return -1
	end
	
	local gameplayStartTime = GetGameplayTimeParam(sid, heroID)
	local curTime = GetServerTime()
	--获得开始该玩法已经过了多长时间
	--算出在玩法的持续时间中，总共会增加多少次经验
	if diamondCosted ~= 0 then
		local trainedFlag = get_Exdata(sid, _SG_ExDataType.TrainedFlag)
		--第一次用元宝立即完成训练不要钱
		if trainedFlag ~= 2 then
			curTime = math.floor(maxTrainingTime / gapTime)
			set_Exdata(sid, _SG_ExDataType.TrainedFlag, 2)
		else
			curTime = math.max(0, maxTrainingTime + gameplayStartTime - curTime)
			local costDiamond = math.ceil(math.max(1, math.ceil(curTime / gapTime)) * costPerUnitTime)
			--如果用钱的话，钱够的话就是发放全额的经验值
			if CI_CheckGoods_SG(_GoodsType.diamond, 0, costDiamond) == -1 then
				return -1
			end
			--扣掉对应的元宝消耗
			CI_DecGoods_SG(_GoodsType.diamond, 0, costDiamond, GoodsWay.heroTraining)
			curTime = math.floor(maxTrainingTime / gapTime)
		end
	else
		curTime = curTime - gameplayStartTime
		curTime = math.min(maxTrainingTime, curTime)
		curTime = math.floor(curTime / gapTime)
	end
	
	--重置挂机的状态
	ResetExBaseData(sid, heroID)
	--更新当前玩家正在训练的英雄的个数
	_DecClassifiedHeroNum(sid, _HeroExGameplayMode.Training)
	--在C++端进行武将经验的结算
	return curTime
end