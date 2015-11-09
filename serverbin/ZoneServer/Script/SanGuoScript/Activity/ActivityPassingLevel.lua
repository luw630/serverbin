--[[
file:	ActivityPassingLevel.lua
author:	Jonson
update:	2015-11-02
desc:	�����ĸ����ؿ�ͨ�ش��������
]]--

--���渱��ͨ�ش���������������ļ�
local PassingLevelActConfig = PassingLevelActConfig
local _ActIndex = ActIndex
local _ActivityRegister = ActivityRegister
local _SendLuaMsg = SendLuaMsg
local _msgh_s2c_def = msgh_s2c_def
local _s2c_msg = s2c_msg
--�����������ͻ��˵�ͨ�ػ�������Ϣͷ
local passLevelActMsgHead = _msgh_s2c_def[_s2c_msg.act][6]
local _g_ActivifyConfig = g_ActivifyConfig

--���ɻʵ��
PassingLevelAct = Activitymodule:new()
--��ʼ���������
PassingLevelAct:Init(_ActIndex.passinglevel)
--ע��ʵ�������������
_ActivityRegister(PassingLevelAct)
--��ȡ����������
PassingActData = PassingLevelAct:LoadData()
--��ʼ�������Ϣ
local actMsg = {}

--��ȡĳһ����ҵ�ͨ�ش����������
function PassingLevelAct:getPassLevelData(sid)
	--������û�п������������������
	if not self.ActivityEnable then
		return
	end
	
	if PassingActData[sid] == nil then
		PassingActData[sid] = { count = 0}
	end
	
	return PassingActData[sid]
end

--�������Ļ�����Ϣ��ʽ
local function baseMsgPack()
	--��Ϣͷ�Ķ���
	actMsg = { ids = passLevelActMsgHead }
end

--������������ͬ����Ϣ
local function SynDataMsgPack(sid)
	--��ȡ�������
	local pdata = PassingLevelAct:getPassLevelData(sid)
	if pdata == nil then
		return
	end
	actMsg.data = pdata
end

--���������Ƿ���ȡ�ɹ�����ص���Ϣ
local function RewardsGotMsgPack(state)
	actMsg.rewardsGot = state
end

--���������ʱ��
function PassingLevelAct:OnTrigger(paramsTab)
	--��ʼ��ȡ����������ҵ�ID�����ͨ��ĳһ���ؿ�������
	local sid
	local passingCount
	for k,v in pairs(paramsTab) do
		sid = k
		passingCount = v
	end
	
	if sid == nil or passingCount == nil then
		return
	end
	
	--��¼��ҵ�ͨ�ص��ܴ���
	local pdata = self:getPassLevelData(sid)
	pdata.count = pdata.count + passingCount
	--��ʼ�ж���Щ��������ȡ�����Ѿ�������
	pdata.rewardsState = pdata.rewardsState or {}
	--��ʱ����Ҫ��PassingLevelActConfig���õĽ������������ģ�����ϵ�
	for key, value in ipairs(PassingLevelActConfig) do
		if pdata.count >= value.count and pdata.rewardsState[key] == nil then
			--true�������ȡ��false��������ȡ��nil����δ���
			pdata.rewardsState[key] = true
		end
	end
	--ͬ���������ݵ��ͻ���
	baseMsgPack()
	SynDataMsgPack(sid)
	_SendLuaMsg(sid, actMsg)
end

--�ͻ���������ȡͨ�ش��������
function GetPassingLevelActRewards(sid, rewardsIndex)
	if not PassingLevelAct.ActivityEnable then
		--������ϸ��߿ͻ��ˣ�������ȡ��������Ϣ�ͻ��������Ϣ
		--ͬ���������ݵ��ͻ���
		baseMsgPack()
		_SendLuaMsg(sid, actMsg)
		return
	end
	
	--��ȡ�������
	local pdata = PassingLevelAct:getPassLevelData(sid)
	--�ж��Ƿ������ȡ����
	if pdata == nil or pdata.rewardsState == nil or not pdata.rewardsState[rewardsIndex] then
		--������ϸ��߿ͻ��ˣ�������ȡ��������Ϣ
		--ͬ���������ݵ��ͻ���
		baseMsgPack()
		RewardsGotMsgPack(false)
		SynDataMsgPack(sid)
		_SendLuaMsg(sid, actMsg)
		return
	end
	
	--��Ϊ�Ѿ���ȡ��״̬
	pdata.rewardsState[rewardsIndex] = false
	pdata = PassingLevelAct:getPassLevelData(sid)
	--��ʼ���Ž���
	for _, value in pairs(PassingLevelActConfig[rewardsIndex].reward) do
		CI_AddGoods_SG(value[1], value[2], value[3], GoodsWay.active)
		--look("��ȡ������" ..value[1]..";" ..value[2]..";"..value[3]..";"..index)
	end 
	
	--ͬ���������ݵ��ͻ���
	baseMsgPack()
	SynDataMsgPack(sid)
	RewardsGotMsgPack(true)
	_SendLuaMsg(sid, actMsg)
end

--ͬ��ͨ�ش�������������
function SynPassingLevelActData(sid)
	--��ʼ���δ����Ϣ
	baseMsgPack()
	SynDataMsgPack(sid)
	_SendLuaMsg(sid, actMsg)
end