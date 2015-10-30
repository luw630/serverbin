--[[
file:	HeroHungingHuntingLogic.lua
author:	Jonson
update:	2015-07-06
desc:	�������佫�һ�Ѱ�����߼�
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

--��ʼ�һ�Ѱ��
function StartHunging(sid, heroID, heroNumLimit, masterLevel)
	local hungingHeroNum = _GetClassifiedHeroNum(sid, _HeroExGameplayMode.HuntingTreasure)
	--����ﵽ����Ѱ�����������Ƶ���㣬�������ѡ���µ�Ӣ�۹һ�Ѱ��
	if hungingHeroNum >= heroNumLimit then
		return 0
	end
	
	local trainingState = _GetSpecifyExBaseData(sid, heroID, _HeroExDataType.trainingState)
	local huntingState = _GetSpecifyExBaseData(sid, heroID, _HeroExDataType.hungingHuntingState)
	--���ָ����Ӣ�ۻ��ڹһ�Ѱ�����߻���ѵ��������һ�Ѱ��
	if trainingState ~= 0 or huntingState ~= 0 then
		return 0
	end
	
	--��¼��Ӣ�۹һ���״̬
	_StartToHunting(sid, heroID, masterLevel)
	--���ùһ�����ʼʱ��
	local curTime = GetServerTime()
	SetGameplayTimeParam(sid, heroID, curTime)
	--���µ�ǰ�������Ѱ����Ӣ�۵ĸ���
	_IncClassifiedHeroNum(sid, _HeroExGameplayMode.HuntingTreasure)
	return 1
end

--�������,maxRequestTimes���������������ٴεĵ���,gapTime����ÿ����ò����������һ��
function RequestSurprisePresents(sid, heroID, maxRequestTimes, gapTime)
	--��ȡ�Ѿ�����������ٴ���
	local requestedTimes = _GetSpecifyExBaseData(sid, heroID, _HeroExDataType.surprisedTimes)
	look("requestedTimes " .. requestedTimes)
	--����Ѿ�����Ĵ������������Ĵ���(���������ܳ���9)���������
	if requestedTimes >= maxRequestTimes or requestedTimes >= 9 then
		return 0
	end
	
	local huntingState = _GetSpecifyExBaseData(sid, heroID, _HeroExDataType.hungingHuntingState)
	--����佫û���ڹһ�Ѱ�����������
	if huntingState == 0 then
		look("Not Hunging")
		return 0
	end
	
	local curTime = GetServerTime()
	--��ȡ���佫��ʼ�һ���ʱ��
	local gameplayStartTime = _GetGameplayTimeParam(sid, heroID)
	gameplayStartTime = gameplayStartTime + requestedTimes * gapTime
	local elaspedTime = curTime - gameplayStartTime
	--��ε���
	local randomTimes = math.floor(elaspedTime / gapTime)
	randomTimes = math.min(maxRequestTimes, requestedTimes + randomTimes) - requestedTimes
	--���������+1
	if randomTimes > 0 then
		_SetSpecifyExBaseData(sid, heroID, _HeroExDataType.surprisedTimes, randomTimes)
	end
	look("randomTimes " .. randomTimes)
	--��C++�˽�����������Ĳ���
	return randomTimes
end

--����һ�Ѱ���Ľ���, maxHungingTime��ʾ��ܹһ��೤ʱ�䣬gapTime����ÿ�������������һ������ֵ
function RequestHungingLiquidation(sid, heroID, maxHungingTime, gapTime)
	local huntingState = _GetSpecifyExBaseData(sid, heroID, _HeroExDataType.hungingHuntingState)
	--����佫û���ڹһ�Ѱ�����������
	if huntingState == 0 then
		return 0
	end
	
	local gameplayStartTime = _GetGameplayTimeParam(sid, heroID)
	local curTime = GetServerTime()
	--��ÿ�ʼ���淨�Ѿ����˶೤ʱ��
	curTime = curTime - gameplayStartTime
	curTime = math.min(maxHungingTime, curTime)
	--������淨�ĳ���ʱ���У��ܹ������Ӷ��ٴν�Ǯ
	curTime = math.floor(curTime / gapTime)
	--���ùһ���״̬
	ResetExBaseData(sid, heroID)
	--���µ�ǰ�������Ѱ����Ӣ�۵ĸ���
	_DecClassifiedHeroNum(sid, _HeroExGameplayMode.HuntingTreasure)
	--���н�ҵĽ���
	return curTime
end

