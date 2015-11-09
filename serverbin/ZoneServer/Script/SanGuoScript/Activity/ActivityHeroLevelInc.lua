--[[
file:	ActivityHeroLevelInc.lua
author:	Jonson
update:	2015-11-03
desc:	������Ӣ�۵ȼ������Ļ
]]--

--����Ӣ�۵ȼ�����������������ļ�
local HeroLevelsActConfig = HeroLevelsActConfig
local _ActIndex = ActIndex
local _ActivityRegister = ActivityRegister
local _SendLuaMsg = SendLuaMsg
local _msgh_s2c_def = msgh_s2c_def
local _s2c_msg = s2c_msg
--�����������ͻ��˵���Ϣͷ
local heroLevelMsgHead = _msgh_s2c_def[_s2c_msg.act][8]
local _g_ActivifyConfig = g_ActivifyConfig

--���ɻʵ��
HeroLevelAct = Activitymodule:new()
--��ʼ���������
HeroLevelAct:Init(_ActIndex.heroLevels)
--ע��ʵ�������������
_ActivityRegister(HeroLevelAct)
--��ȡ����������
HeroLevelActData = HeroLevelAct:LoadData()
--��ʼ�������Ϣ
local actMsg = {}

--��ȡĳһ����ҵ��佫�ȼ������������
function HeroLevelAct:getHeroLevelData(sid)
	--������û�п������������������
	if not self.ActivityEnable then
		return
	end
	if HeroLevelActData[sid] == nil then
		HeroLevelActData[sid] = { count = 0 }
	end

	return HeroLevelActData[sid]
end

--�������Ļ�����Ϣ��ʽ
local function baseMsgPack()
	--��Ϣͷ�Ķ���
	actMsg = { ids = heroLevelMsgHead }
end

--������������ͬ����Ϣ
local function SynDataMsgPack(sid)
	--��ȡ�������
	local pdata = HeroLevelAct:getHeroLevelData(sid)
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
function HeroLevelAct:OnTrigger(paramsTab)
	--��ʼ��ȡ����������ҵ�ID����ҵ�ǰ��ĳ��Ӣ�۵���ߵȼ�
	local sid
	local heroCurLevel
	for k,v in pairs(paramsTab) do
		sid = k
		heroCurLevel = v
	end
	
	if sid == nil or heroCurLevel == nil then
		return
	end

	--�ж��µĵȼ��Ƿ�����ߵȼ�
	local pdata = self:getHeroLevelData(sid)
	if heroCurLevel <= pdata.count then
		return
	end	
	
	--��¼��ҵ�Ӣ�۵���ߵȼ�
	pdata.count = heroCurLevel
	--��ʼ�ж���Щ��������ȡ�����Ѿ�������
	pdata.rewardsState = pdata.rewardsState or {}
	--��ʱ����Ҫ��HeroLevelActConfig���õĽ������������ģ�����ϵ�
	for key, value in ipairs(HeroLevelsActConfig) do
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

--�ͻ���������ȡ�佫�ȼ������Ļ����
function GetHeroLevelActRewards(sid, rewardsIndex)
	if not HeroNumsAct.ActivityEnable then
		--������ϸ��߿ͻ��ˣ�������ȡ��������Ϣ�ͻ��������Ϣ
		--ͬ���������ݵ��ͻ���
		baseMsgPack()
		_SendLuaMsg(sid, actMsg)
		return
	end
	
	--��ȡ�������
	local pdata = HeroLevelAct:getHeroLevelData(sid)
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
	for _, value in pairs(HeroLevelsActConfig[rewardsIndex].reward) do
		CI_AddGoods_SG(value[1], value[2], value[3], GoodsWay.active)
		--look("��ȡ������" ..value[1]..";" ..value[2]..";"..value[3]..";"..index)
	end 
	
	--ͬ���������ݵ��ͻ���
	baseMsgPack()
	SynDataMsgPack(sid)
	RewardsGotMsgPack(true)
	_SendLuaMsg(sid, actMsg)
end

--ͬ����ҵȼ������Ļ���������
function SynHeroLevelActData(sid)
	--��ʼ���δ����Ϣ
	baseMsgPack()
	SynDataMsgPack(sid)
	_SendLuaMsg(sid, actMsg)
end