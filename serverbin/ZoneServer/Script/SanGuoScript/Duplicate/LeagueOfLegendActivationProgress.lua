--[[
file:	LeagueOfLegendActivationConfig.lua
author:	Jonson
update:	2015-04-14
desc:��������˵�����ļ����߼�����
]]--

local _activeDateConfig = activeDateConfig
--ȡ����˵����ģ�������������
local function LOLActivation_getdata( sid )
	if dbMgr[sid]==nil or  dbMgr[sid].data==nil then 
		return
	end
	if dbMgr[sid].data['lolactive']==nil then --��ʼ������˵�������ŵĹ�������
		dbMgr[sid].data['lolactive']={
			[1]=700001,--�����񹤹�������
			[2]=700002,--��������˫ȫ����
			[3]=700003,--�������ֲ�������
		}
	end
	return dbMgr[sid].data['lolactive']
end

--�������µĿ��Źؿ�����
local function LOLActivation(pdata)
	if pdata == nil then return end
	
	local curTime = GetServerTime()
	local dt = os.date("*t", curTime)
	
	local tempTable
	--��ʱΪ�賿5����½���˵����
	if dt.hour < 5 then
		--Ӧ��Ϊǰһ��Ŀ�������
		curTime = curTime - 86400
		dt = os.date("*t", curTime)
	end
	--��ȡ��ǰ�Ŀ��Ÿ���������
	tempTable = _activeDateConfig[dt.wday]
	--�޸���ҵ�����
	pdata[1] = tempTable[1] or 0
	pdata[2] = tempTable[2] or 0
	pdata[3] = tempTable[3] or 0
end

--��һ�ε�½��ʱ�򽲿�����Ϣ�����ͻ���
function LOLActivation_firstlogin(sid,dataTb,index)
	local pdata = LOLActivation_getdata( sid )	
	if pdata == nil then
		return
	end
	
	--�����½���Ŀ�������
	LOLActivation(pdata)
	CI_ActiveLeagueOfLegendDuplicate(pdata)
	
	for i=1,3 do
		if pdata[i] == nil then
			dataTb[index + i - 1] = 0 --�������0
		else
			dataTb[index + i - 1] = pdata[i]
		end
	end
	return index+3 --�¸�λ�ô�4��ʼ
end

--�жϽ�����Կ�����Щ�������������Ϣͬ�����ͻ���
function SI_JudgeLOLActiveState(sid)
	local pdata = LOLActivation_getdata( sid )
	if pdata == nil then
		return
	end
	
	--�����½���Ŀ�������
	LOLActivation(pdata)
	
	--������صĽ���˵����������������������Ϣ���͵��ͻ��ˣ���C++�˴��������
	CI_ActiveLeagueOfLegendDuplicate(pdata)
end