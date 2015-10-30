--[[
file:	HeroExtendsData.lua
author:	Jonson
update:	2015-07-03
desc:	�������佫Ӣ�۵Ķ������ݵĹ�������˵����佫�Ƿ���ѵ�����Ƿ��ڹһ�Ѱ���ȵ�
]]--

--Ӣ����չ���淨������
HeroExGameplayMode = {
	Training = 1, --ѵ��Ӣ��
	HuntingTreasure = 2, --�һ�Ѱ��
}

--��Ҫ������ȡӢ����չ���淨�Ļ��������е�ĳһ������
HeroExDataType = {
	trainingState = 3, --ǧ��λ
	trainingType = 4,--���λ
	hungingHuntingState = 5,--ʮ���λ
	surprisedTimes = 6,--�����λ�������Ѿ���������Ĵ���
	cachedLevel = 7,--ǧ���λ�������ϴ�����ǿ�ʼ��һ�淨��ʱ���佫(���߾���)�ĵȼ�
}

-- ��¼������������������������ҵ��佫�У�����ѵ�����佫�ĸ��������ڹһ�Ѱ�����佫�����ȴ���ֻ�������ڴ��У�����д�뵽���ݿ���
local classifiedExHeroNumData = {}
local _HeroExDataType = HeroExDataType

--ȡ����ҵ�Ӣ�۵���չ���������
local function heroEx_getdata( sid )
	if dbMgr[sid]==nil or  dbMgr[sid].data==nil then 
		return
	end
	if dbMgr[sid].data['heroEx_data'] == nil then --��ʼ��lua������
		dbMgr[sid].data['heroEx_data'] = {
		}
	end
	return dbMgr[sid].data['heroEx_data']
end

--��ȡĳһ��ָ��Ӣ�۵���չ���淨��ص����ݣ���������ڸ�Ӣ�ۣ���Ĭ���½���
local function _GetHeroExData(sid, heroID)
	local pData = heroEx_getdata(sid)
	if pData == nil then 
		return
	end
	
	if pData[heroID] == nil then
		pData[heroID] = {
			[1] = heroID, --����Ӣ��ID��101����ô�����Ļ������ݾ���0000000101����λ����λ����Ӣ��ID��ǧ��λ�����Ƿ��ڽ���ѵ�������λ�������ѵ�������ͣ�ʮ���λ�����Ƿ��ڽ���Ѱ���������λ������������Ĵ�����ǧ���λ����������ʱ��ʾ��ʼ���淨ʱ�佫(�����)�ĵȼ�
			[2] = 0,--�淨�Ŀ�ʼʱ��
		}
	end
	
	return pData[heroID]
end

local function cacheClassifiedHeroNum(sid)
	local trainingHeroNum = 0
	local huntingHeroNum = 0
	local pData = heroEx_getdata(sid)
	for _, value in pairs(pData) do
		if value ~= nil and value[1] ~= nil then
			--��ȡ�佫��ѵ��״̬
			local datasit = math.pow(10, _HeroExDataType.trainingState)
			--��ý�ȡ��ĳһλ��������ݺ������
			local tempData = math.floor(value[1] / datasit)
			--�ȵ�ĳһλ�洢��Ҫ�ҵ�����
			if tempData % 10 ~= 0 then
				trainingHeroNum = trainingHeroNum + 1
			end
			
			--��ȡ�佫�Ĺһ�Ѱ��״̬
			datasit = math.pow(10, _HeroExDataType.hungingHuntingState)
			tempData = math.floor(value[1] / datasit)
			if tempData % 10 ~= 0 then
				huntingHeroNum = huntingHeroNum + 1
			end
		end
	end
	
	classifiedExHeroNumData[sid] = {
		[HeroExGameplayMode.Training] = trainingHeroNum,
		[HeroExGameplayMode.HuntingTreasure] = huntingHeroNum,
	}
end

--��ȡĳһ����ҵ������佫�����ڽ���ĳһ���佫����չ���淨������
function GetClassifiedHeroNum(sid, heroExGameplayMode)
	--�����ж����ڴ����Ƿ�����ҵĶ�Ӧ�����ݣ����û�У����½�һ��
	if classifiedExHeroNumData[sid] == nil then
		cacheClassifiedHeroNum(sid)
	end
	
	return classifiedExHeroNumData[sid][heroExGameplayMode]
end

--����ĳһ����ҵĲμ�ĳһ����չ���淨���佫������
function IncClassifiedHeroNum(sid, heroExGameplayMode)
	--�����ж����ڴ����Ƿ�����ҵĶ�Ӧ�����ݣ����û�У����½�һ��
	if classifiedExHeroNumData[sid] == nil then
		cacheClassifiedHeroNum(sid)
	end
	
	classifiedExHeroNumData[sid][heroExGameplayMode] = classifiedExHeroNumData[sid][heroExGameplayMode] + 1
end

--����ĳһ����ҵĲμ�ĳһ����չ���淨���佫������
function DecClassifiedHeroNum(sid, heroExGameplayMode)
	--�����ж����ڴ����Ƿ�����ҵĶ�Ӧ�����ݣ����û�У����½�һ��
	if classifiedExHeroNumData[sid] == nil then
		cacheClassifiedHeroNum(sid)
	end
	
	classifiedExHeroNumData[sid][heroExGameplayMode] = classifiedExHeroNumData[sid][heroExGameplayMode] - 1
end

--��ȡ�淨�����ݿ������洢��ʱ�������������Ǹ��佫��ʼ����ĳһ�淨�ľ���ʱ�䣩
function GetGameplayTimeParam(sid, heroID)
	local pHeroData = _GetHeroExData(sid, heroID)
	return pHeroData[2]
end

--�����淨�����ݿ������洢��ʱ�������������Ǹ��佫��ʼ����ĳһ�淨�ľ���ʱ�䣩
function SetGameplayTimeParam(sid, heroID, data)
	local pHeroData = _GetHeroExData(sid, heroID)
	pHeroData[2] = data
end

--��ȡӢ���佫����չ���淨��������е�ĳһ������
function GetSpecifyExBaseData(sid, heroID, heroExDataType)
	local pHeroData = _GetHeroExData(sid, heroID)
	--Ҫȡ�����ݵ�λ��
	local datasit = math.pow(10, heroExDataType)
	--��ý�ȡ��ĳһλ��������ݺ������
	local tempData = math.floor(pHeroData[1] / datasit)
	--����Ҫ��õ�����
	if heroExDataType == _HeroExDataType.cachedLevel then
		return tempData
	else
		return tempData % 10
	end
end

--�������ĳһ���佫��Ӧ����չ���淨��ص�����
function ResetExBaseData(sid, heroID)
	--������ҵ����ݴӱ����Ƴ�
	local pData = heroEx_getdata(sid)
	pData[heroID] = nil
end

--����Ӣ���佫����չ���淨��������е�ĳһ������
function SetSpecifyExBaseData(sid, heroID, heroExDataType, data)
	local pHeroData = _GetHeroExData(sid, heroID)
	--Ҫ���õ����ݵ�λ��
	local datasit = math.pow(10, heroExDataType)
	--���Ҫ���õ����ݵġ�ǰ��������
	local tempData1, tempData2 = math.modf(pHeroData[1] / datasit)
	pHeroData[1] = (tempData1 + data) * datasit + tempData2 * datasit
end

--��ʼѵ���佫�������ݵ����ò������Ƕ�SetSpecifyExBaseData��һ����ʽ�ļ�
function StartToTrainingHero(sid, heroID, masterLevel, trainingType)
	local pHeroData = _GetHeroExData(sid, heroID)
	pHeroData[1] = masterLevel * 10000000 + trainingType * 10000 + 1000 + heroID
end

--��ʼ��ĳһ���佫�һ�Ѱ���������ݵ����ò������Ƕ�SetSpecifyExBaseData��һ����ʽ�ļ�
function StartToHunting(sid, heroID, masterLevel)
	local pHeroData = _GetHeroExData(sid, heroID)
	pHeroData[1] = masterLevel * 10000000 + 100000 + heroID
end

--������佫����չ���淨
function SynHeroExDataToClient(sid)
	CI_SynHeroExtendsData(heroEx_getdata(sid))
end