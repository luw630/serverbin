--[[
file:	HeroTrainingLogic.lua
author:	Jonson
update:	2015-07-06
desc:	�������佫ѵ�����߼�
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

--���뿪ʼѵ��ĳһ��Ӣ��
function RequestStartTraining(sid, heroID, tType, masterLevel, heroNumLimit)
	local hungingHeroNum = _GetClassifiedHeroNum(sid, _HeroExGameplayMode.Training)
	--����ﵽ����ѵ�����������Ƶ���㣬�������ѡ���µ�Ӣ��ѵ��
	if hungingHeroNum >= heroNumLimit then
		return 0
	end
	
	local trainingState = _GetSpecifyExBaseData(sid, heroID, _HeroExDataType.trainingState)
	local huntingState = _GetSpecifyExBaseData(sid, heroID, _HeroExDataType.hungingHuntingState)
	--���ָ����Ӣ�ۻ��ڹһ�Ѱ�����߻���ѵ��������ѵ��
	if trainingState ~= 0 or huntingState ~= 0 then
		return 0
	end
	
	--��¼��Ӣ��ѵ����״̬
	_StartToTrainingHero(sid, heroID, masterLevel, tType)
	--����ѵ������ʼʱ��
	local curTime = GetServerTime()
	SetGameplayTimeParam(sid, heroID, curTime)
	--���µ�ǰ�������Ѱ����Ӣ�۵ĸ���
	_IncClassifiedHeroNum(sid, _HeroExGameplayMode.Training)
	return 1
end

--�����ĳһ��Ӣ�۵�ѵ������,diamondCosted��ʾ�Ƿ��õ�Ԫ����������ѵ����maxTrainingTime��ʾ���ѵ���೤ʱ�䣬gapTime����ÿ�������������һ������ֵ
function RequestTrainingLiquidation(sid, heroID, diamondCosted, maxTrainingTime, gapTime, costPerUnitTime)
	local trainingState = _GetSpecifyExBaseData(sid, heroID, _HeroExDataType.trainingState)
	--����佫û����ѵ�����������
	if trainingState == 0 then
		return -1
	end
	
	local gameplayStartTime = GetGameplayTimeParam(sid, heroID)
	local curTime = GetServerTime()
	--��ÿ�ʼ���淨�Ѿ����˶೤ʱ��
	--������淨�ĳ���ʱ���У��ܹ������Ӷ��ٴξ���
	if diamondCosted ~= 0 then
		local trainedFlag = get_Exdata(sid, _SG_ExDataType.TrainedFlag)
		--��һ����Ԫ���������ѵ����ҪǮ
		if trainedFlag ~= 2 then
			curTime = math.floor(maxTrainingTime / gapTime)
			set_Exdata(sid, _SG_ExDataType.TrainedFlag, 2)
		else
			curTime = math.max(0, maxTrainingTime + gameplayStartTime - curTime)
			local costDiamond = math.ceil(math.max(1, math.ceil(curTime / gapTime)) * costPerUnitTime)
			--�����Ǯ�Ļ���Ǯ���Ļ����Ƿ���ȫ��ľ���ֵ
			if CI_CheckGoods_SG(_GoodsType.diamond, 0, costDiamond) == -1 then
				return -1
			end
			--�۵���Ӧ��Ԫ������
			CI_DecGoods_SG(_GoodsType.diamond, 0, costDiamond, GoodsWay.heroTraining)
			curTime = math.floor(maxTrainingTime / gapTime)
		end
	else
		curTime = curTime - gameplayStartTime
		curTime = math.min(maxTrainingTime, curTime)
		curTime = math.floor(curTime / gapTime)
	end
	
	--���ùһ���״̬
	ResetExBaseData(sid, heroID)
	--���µ�ǰ�������ѵ����Ӣ�۵ĸ���
	_DecClassifiedHeroNum(sid, _HeroExGameplayMode.Training)
	--��C++�˽����佫����Ľ���
	return curTime
end