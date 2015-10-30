--[[
file:	MissionData.lua
author:	Jonson
update:	2015-06-19
desc:�ȶ�����������������ݴ洢
]]--

local MissionType = {
	MonthCard = 0,	--�¿�����
	Sweep = 1,		--ɨ��������
	Lunch = 2,		--�������
	Dinner = 3,		--�������
	Supper = 4,		--ҹ������
	Duplicate = 5,	--��������
	EliteDuplicate = 6,--��Ӣ���¸�������
	TreasureHunting = 7,--�ؾ�Ѱ����������
	LeagueOfLegends = 8,--����˵��������
	Arena = 9,		--���䳡��������
	SkillUpgrade = 10,		--������������
	Forging = 11,	--��������
	Blessing = 12,	--������
	Expedition = 13,	--����ն����������
}

--�������ݵĲ��컯��ȡ������ѡ��
local MissionDataType = {
	completedTiems = 1, --��ȡ������ָ���������ɴ���
	visible = 2,--��ȡ������ָ������Ŀɼ���״��
	accomplished = 3,--��ȡ������ָ����������״��
}

--ȡ����ҵ�������������
local function Mission_getdata( sid )
	if dbMgr[sid]==nil or  dbMgr[sid].data==nil then 
		return
	end
	if dbMgr[sid].data['mission_data'] == nil then --��ʼ�������lua������
		--����λ��ʮ��λ��ʾ�������ɴ������ٷ�λ��ʾ�����Ƿ�ɼ���ǧ��λ��ʾ�����Ƿ��Ѿ���ɣ����λ��������Ϊ�����ID
		dbMgr[sid].data['mission_data'] = {}
		dbMgr[sid].data['mission_data'][50] = 500100
		dbMgr[sid].data['mission_data'][51] = 510100
		dbMgr[sid].data['mission_data'][52] = 520100
		dbMgr[sid].data['mission_data'][53] = 530100
		dbMgr[sid].data['mission_data'][54] = 540100
		dbMgr[sid].data['mission_data'][55] = 550100
		dbMgr[sid].data['mission_data'][56] = 560100
		dbMgr[sid].data['mission_data'][57] = 570100
		dbMgr[sid].data['mission_data'][58] = 580100
		dbMgr[sid].data['mission_data'][59] = 590100
		dbMgr[sid].data['mission_data'][60] = 600100
		dbMgr[sid].data['mission_data'][61] = 610100
		dbMgr[sid].data['mission_data'][62] = 620100
		dbMgr[sid].data['mission_data'][63] = 630100
		dbMgr[sid].data['mission_data'][64] = 640000--��ʱ�رո�����
	end
	return dbMgr[sid].data['mission_data']
end

--�ı�ָ��������������е�ĳһ��ֵ
local function SetSpecificMissionData(datas, missionID, missionDataType, data)
	--Ҫ���õ����ݵ�λ��
	if missionDataType == MissionDataType.completedTiems then
		--��Ϊ�������ɴ���ռλΪ����λ��ʮ��λ�����ڴ��ر���
		local tempData1, tempData2 = math.modf(datas[missionID] / 100)
		datas[missionID] = tempData1 * 100 + data
	else
		local datasit = math.pow(10, missionDataType)
		local tempData1, tempData2 = math.modf(datas[missionID] / datasit)
		tempData1 = math.floor(tempData1 / 10) * 10
		datas[missionID] = (tempData1 + data) * datasit + tempData2 * datasit
	end
end

--�����Ƿ��ǿɲ�����
local function MissionOperable(sid, missionDatas, missionID)
	--�жϸ������Ƿ�ɼ�
	local datasit = math.pow(10, MissionDataType.visible)--Ҫȡ�����ݵ�λ��
	--��ý�ȡ��ĳһλ��������ݺ������
	local tempData = math.floor(missionDatas / datasit)
	tempData = tempData % 10
	if tempData == 0 then
		return false
	end
	
	--�жϸ������Ƿ��Ѿ����
	datasit = math.pow(10, MissionDataType.accomplished)
	tempData = math.floor(missionDatas / datasit)
	tempData = tempData % 10
	if tempData ~= 0 then
		return false
	end
	
	--��������¿���Ա���򷵻�false
	if missionID == 50 and not IsMonthlyMem(sid) then
		return false
	end
	
	return true
end

--missionDataType��ʾ��ȡ�����ȫ�����������
function GetMissionData(sid, missionID, missionDataType)
	local pdata = Mission_getdata(sid)
	if pdata == nil then 
		return 
	end
	
	--��ȡָ������������
	local missionDatas = pdata[missionID]
	if (missionDatas == nil) then
		return
	end

	--Ҫȡ�����ݵ�λ��
	local datasit = math.pow(10, missionDataType)
	--��ý�ȡ��ĳһλ��������ݺ������
	local tempData = math.floor(missionDatas / datasit)
	--����Ҫ��õ�����
	return tempData % 10
end

--missionDataType��ʾ��ȡ�����ĳһ���������ݣ�����ָ�������ĳһ�������
function SetMissionData(sid, missionID, missionDataType, data)
	local pdata = Mission_getdata(sid)
	if pdata == nil then 
		return 
	end
	
	--��ȡָ������������
	if (pdata[missionID] == nil) then
		return
	end
	
	SetSpecificMissionData(pdata, missionID, missionDataType, data)
end

--���ε�ĳһ������
function ShieldingMission(sid, missionID)
	local pdata = Mission_getdata(sid)
	if pdata == nil then 
		return 
	end
	
	--��ȡָ������������
	if (pdata[missionID] == nil) then
		return
	end
	
	--ֱ���������ε�������ʾ��û��ɣ�û����ɴ���
	pdata[missionID] = missionID * 10000
end

--�����¿���ص����������¿��������IDΪ50��
function SwitchMounthCardMission(sid, accessible, sendMsg)
	local pdata = Mission_getdata(sid)
	if pdata == nil then 
		return 
	end
	
	--��ȡָ������������
	if (pdata[50] == nil) then
		return
	end
	
	if accessible then
		--�ж������Ƿ��Ѿ���ɣ�����˵Ļ���ֱ���˳�����Ȼ�ᡰ���á�
		local tempData = pdata[50] % 10000
		if tempData >= 1000 then
			return
		end
		--��101��ָ����ɼ���������ɴ���Ϊ1
		pdata[50] = 50 * 10000 + 101
		if sendMsg then
			CI_UpdateMissionState(sid, 50, true, 1)
		end
	else
		--ֱ���������ε�������ʾ��û��ɣ�û����ɴ���
		pdata[50] = 50 * 10000
		if sendMsg then
			CI_UpdateMissionState(sid, 50, false, 0)
		end
	end
end

--�����������ɴ���
function SetMissionCompletedTimes(sid, missionID, times, maxAccomplishedTimes)
	local pdata = Mission_getdata(sid)
	if pdata == nil then 
		return 0
	end
	
	local missionDatas = pdata[missionID]
	if (missionDatas == nil) then
		return 0
	end

	--�ж������Ƿ���Բ���
	if MissionOperable(sid, missionDatas) == false then
		return 0
	end
	
	--���ж���ɴ����Ƿ��Ѿ�����
	local tempData = missionDatas % 100
	if tempData >= maxAccomplishedTimes then
		return 0
	end

	times = math.min(times + tempData, maxAccomplishedTimes)
	SetSpecificMissionData(pdata, missionID, MissionDataType.completedTiems, times)
	return times
end

--���ĳһ������
function SetMissionAccompulished(sid, missionID, times)
	local pdata = Mission_getdata(sid)
	if pdata == nil then 
		return 0
	end
	
	local missionDatas = pdata[missionID]
	if (missionDatas == nil) then
		return 0
	end
	
	--�ж������Ƿ���Բ���
	if MissionOperable(sid, missionDatas, missionID) == false then
		return 0
	end
	
	--�ж���ɴ����Ƿ��Ѿ�����
	local tempData = missionDatas % 100
	if tempData < times then
		return 0
	end
	
	--����ĳһ�������Ѿ����
	SetSpecificMissionData(pdata, missionID, MissionDataType.accomplished, 1)
	return 1
end

--�ر����е������������
function CloseTimeEnduranceMission(sid)
	local pdata = Mission_getdata(sid)
	if pdata == nil then 
		return 
	end
	
	--��ʼ�������е�����������񣬽��䡰�رյ���
	for i = 52, 54 do
		if pdata[i] ~= nil then
			SetSpecificMissionData(pdata, i, MissionDataType.visible, 0)
		end
	end
end

--������������
function ResetMission(sid)
	local pdata = Mission_getdata(sid)
	if pdata == nil then 
		return 
	end
	
	pdata[50] = 500100
	pdata[51] = 510100
	pdata[52] = 520100
	pdata[53] = 530100
	pdata[54] = 540100
	pdata[55] = 550100
	pdata[56] = 560100
	pdata[57] = 570100
	pdata[58] = 580100
	pdata[59] = 590100
	pdata[60] = 600100
	pdata[61] = 610100
	pdata[62] = 620100
	pdata[63] = 630100
	pdata[64] = 640000--��ʱ�رո�����
	
	--�ж��Ƿ����¿��û������¿��û��ͼ����Ӧ���¿�����
	if not IsMonthlyMem(sid) then
		SwitchMounthCardMission(sid,false)
	else
		SwitchMounthCardMission(sid,true)
	end
end

--����ҵ���������ͬ�����ͻ���
function SynMissionDataToClient(sid)
	--�ж��Ƿ����¿��û������¿��û��ͼ����Ӧ���¿�����
	if not IsMonthlyMem(sid) then
		SwitchMounthCardMission(sid,false)
	else
		SwitchMounthCardMission(sid,true)
	end
	
	CI_SynMissionData(Mission_getdata(sid))
end