--[[
file:	ActivityHeroNumsInc.lua
author:	Jonson
update:	2015-11-03
desc:	������Ӣ���������ӵĻ
]]--

--����Ӣ���ռ�������������ļ�
local HeroNumsActConfig = HeroNumsActConfig
local _ActIndex = ActIndex
local _ActivityRegister = ActivityRegister
local _SendLuaMsg = SendLuaMsg
local _msgh_s2c_def = msgh_s2c_def
local _s2c_msg = s2c_msg
--�����������ͻ��˵�Ӣ���ռ��Ļ����Ϣ����Ϣͷ
local heroNumsActMsgHead = _msgh_s2c_def[_s2c_msg.act][7]
local _g_ActivifyConfig = g_ActivifyConfig

--���ɻʵ��
HeroNumsAct = Activitymodule:new()
--��ʼ���������
HeroNumsAct:Init(_ActIndex.heroNums)
--ע��ʵ�������������
_ActivityRegister(HeroNumsAct)
--��ȡ����������
HeroNumsActData = HeroNumsAct:LoadData()
--��ʼ�������Ϣ
local actMsg = {}

--��ȡĳһ����ҵ�ͨ�ش����������
function HeroNumsAct:getHeroNumData(sid)
	--������û�п������������������
	if not self.ActivityEnable then
		return
	end
	
	if HeroNumsActData[sid] == nil then
		HeroNumsActData[sid] = { count = 0 }
	end

	return HeroNumsActData[sid]
end

--�������Ļ�����Ϣ��ʽ
local function baseMsgPack()
	--��Ϣͷ�Ķ���
	actMsg = { ids = heroNumsActMsgHead }
end

--������������ͬ����Ϣ
local function SynDataMsgPack(sid)
	--��ȡ�������
	local pdata = HeroNumsAct:getHeroNumData(sid)
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
function HeroNumsAct:OnTrigger(paramsTab)
	--��ʼ��ȡ����������ҵ�ID����ҵ�ǰ���佫����
	look(paramsTab)
	local sid
	local heroNums
	for k,v in pairs(paramsTab) do
		sid = k
		heroNums = v
	end
	
	if sid == nil or heroNums == nil then
		return
	end
	
	--��¼����ռ����佫��������
	local pdata = self:getHeroNumData(sid)
	pdata.count = heroNums
	--��ʼ�ж���Щ��������ȡ�����Ѿ�������
	pdata.rewardsState = pdata.rewardsState or {}
	--��ʱ����Ҫ��HeroNumsActConfig���õĽ������������ģ�����ϵ�
	for key, value in ipairs(HeroNumsActConfig) do
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

--�ͻ���������ȡӢ���ռ������
function GetHeroNumsActRewards(sid, rewardsIndex)
	if not HeroNumsAct.ActivityEnable then
		--������ϸ��߿ͻ��ˣ�������ȡ��������Ϣ�ͻ��������Ϣ
		--ͬ���������ݵ��ͻ���
		baseMsgPack()
		_SendLuaMsg(sid, actMsg)
		return
	end
	
	--��ȡ�������
	local pdata = HeroNumsAct:getHeroNumData(sid)
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
	--��ʼ���Ž���
	for _, value in pairs(HeroNumsActConfig[rewardsIndex].reward) do
		CI_AddGoods_SG(value[1], value[2], value[3], GoodsWay.active)
		--look("��ȡ������" ..value[1]..";" ..value[2]..";"..value[3]..";"..index)
	end 
	
	--ͬ���������ݵ��ͻ���
	baseMsgPack()
	SynDataMsgPack(sid)
	RewardsGotMsgPack(true)
	_SendLuaMsg(sid, actMsg)
end

--ͬ��Ӣ���ռ�����������
function SynHeroNumsActData(sid)
	--��ʼ���δ����Ϣ
	baseMsgPack()
	SynDataMsgPack(sid)
	_SendLuaMsg(sid, actMsg)
end