--[[
file:	MissionActivenessRewards.lua
author:	Jonson
update:	2015-06-19
desc:�ȶ�����������������ݴ洢
]]--

--ȡ����ҵ������Ծ�ȵ��������
local function _getdata( sid )
	if dbMgr[sid]==nil or  dbMgr[sid].data==nil then 
		return
	end
	if dbMgr[sid].data['mAct_data'] == nil then --��ʼ�������lua������
		dbMgr[sid].data['mAct_data'] = {}
	end
	return dbMgr[sid].data['mAct_data']
end

--��ʼ��ȡ�����Ծ�Ƚ���
function ClaimMissionActivenessRewards(sid, level)
	local pdata = _getdata(sid)
	if pdata == nil then 
		pdata = {}
	end
	
	--���ָ�����ݲ����ڣ����½�һ����Ĭ�Ͻ���û��ȡ
	if pdata[level] == nil then
		pdata[level] = false
	end
	
	--��ʼ�ж�ָ���Ľ����Ƿ���ȡ��
	if not pdata[level] then
		pdata[level] = true
		return 1
	else
		return 0
	end
end

--���������Ծ���������
function ResetMissionActiveness(sid)
	--��ʱ��������������࣬����ֱ���±�
	dbMgr[sid].data['mAct_data'] = {}
	-- if pdata == nil then 
		-- return
	-- end
	
	-- for key, v in pairs(pdata) do
		-- if type(key) == "number" and type(v) == "boolean" then
			-- pdata[key] = false
		-- end
	-- end
end

--ͬ�������Ծ�ȵ��ͻ���
function SynMissionActivenessDataToClient(sid)
	local pdata = _getdata(sid)
	if pdata == nil then 
		return
	end
	--�����ͻ��˵����ݽ���ֻ���Ѿ���ȡ�˽����Ķ�Ӧ��level�������Ծ�ȵ���level 30�Ľ����Ѿ���ȡ�ˣ����30ѹ�����
	local filterData = {}
	counter = 1
	for key, value in pairs(pdata) do
		if type(value) == "boolean" and value == true then
			filterData[counter] = key
			counter = counter + 1
		end
	end
	
	--����C++����ͬ�����ͻ���
	CI_SynMissionActivenessData(sid, counter - 1, filterData)
	filterData = nil
end