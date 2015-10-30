--[[
file:	extendeddatafunc.lua
author:	lpd
update:	2015-06-19
desc:�洢����,ĳЩֻ��Ҫ�������ݵĹ��ܿ�ͳһ������洢�Խ�Լ�ռ�
]]--

SG_ExDataType = {
	BlessCount = 1, --�����Ԫ��ʮ��������
	BlessMaxCount = 2,--����ʮ����ص������佫��������
	ChargeClaimedFlag = 3,--�׳���ȡ��ʶ
	TrainedFlag = 4, --�״�ѵ���Ƿ���ɵı�ʶ
	NewbieGoldFlag = 5, --���ֱص�
	SendStaminaCount = 6, --������������
	GetStaminaCount = 7, --��ȡ��������
	ExpeditionTimes = 8,--����ն����ͨ�عؿ���
}

--��չ����
local function get_ExResult(sid) 
	if dbMgr[sid]==nil or  dbMgr[sid].data==nil then 
		return
	end
	if dbMgr[sid].data['exdata']==nil then 
		dbMgr[sid].data['exdata']={
			[1] = 1,--�����Ԫ��ʮ������������һ�λ�ȡʱֵΪ1
			[2] = 2,--����ʮ����ص������佫��������
			[3] = 0,--�׳���ȡ��ʶ,1Ϊ��ȡ��
			[4] = 0,--�Ƿ�ѵ�����ı�ʾ
			[5] = 0,--���������Ľ���Ƿ����ı�ʾ
			[6] = FriendConfig.SendStaminaChance,--������������
			[7]	= FriendConfig.ReceiveStaminaChance,--��ȡ��������
			[8] = 0,--����ն������Ĺؿ���
		}
	end
	return dbMgr[sid].data['exdata']
end

--��½ͬ������
function exdata_firstlogin(sid,dataTb,index)
	local pdata = get_ExResult(sid)
	dataTb[index] = pdata[3]
	dataTb[index + 1] = pdata[4] or 0
	dataTb[index + 2] = pdata[5] or 0
	dataTb[index + 3] = sid --��������SID��ʱ�ɴ˴�ͬ�����ͻ���
	dataTb[index + 4] = pdata[8] --����ն���Ĵ���Ĺؿ����ܴ���
	return index + 5
end

-- ��ȡ��������,��dtypeΪkey
function get_Exdata(sid, dtype) 
	local exdata = get_ExResult(sid)
	if exdata == nil then 
		return 
	end
	return exdata[dtype] or 0
end

-- ���ù�������,��dtypeΪkey
function set_Exdata(sid, dtype, value)
	local exdata = get_ExResult(sid)
	if exdata == nil or exdata[dtype] == nil then
		return
	end
	exdata[dtype] = value
	if dtype == 1 and value > 99999999 then --���ʮ�������̫���򱣳ֵ���99999999
		exdata[dtype] = 99999999
	end
	return true
end
