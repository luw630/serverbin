--[[
file:	s2c_msg.lua
author:	wk
update:	2015-03-06
desc:server to client message mgr
]]--
local _encode = json.encode
local _CI_SendMsg_SG 	= CI_SendMsg_SG
local _tbtype=type({})


--lua��Ϣ����ö��,����˵�ǰ̨
s2c_msg = 
{
	player=1,--������С����
	act = 2,--����
}

--��Ϣ���
local _s2c_def = {

	--�����ص�С����,һ��һ���ļ��㶨
	[s2c_msg.player] = {
		[1] 	= {s2c_msg.player,1},--ǩ������ͬ����ǰ̨
		[2]		= {s2c_msg.player,2},--���Ԫ������ͬ��ǰ̨
	},
	
	--����
	[s2c_msg.act] = {
		[1] 	= {s2c_msg.act,1},--�����콱�����ͬ��
		[2] 	= {s2c_msg.act,2},--�����콱��������
		[3] 	= {s2c_msg.act,3},--���ѷ��������ͬ��
		[4] 	= {s2c_msg.act,4},--�����ȡ����ͬ��
		[5]		= {s2c_msg.act,5},--ȫ����Ŀ���״̬
		[6] 	= {s2c_msg.act, 6},--�����ؿ�ͨ�ػ����ͬ��
		[7] 	= {s2c_msg.act, 7},--Ӣ���ռ������ͬ��
		[8] 	= {s2c_msg.act, 8},--Ӣ�۵ȼ����������ͬ��
	},
}


--sid��0Ϊ��ǰ��ң����򴫸�ָ��sid����ң� args ���� { ids = {1,1} , �Զ������}��ids��ֵ�����_s2c_def�л�ȡ
local function _SendLuaMsg(sid,args) 
	if args==nil or type(args.ids)~=_tbtype then return end
	local ret = _CI_SendMsg_SG( sid, _encode(args))
	if ret == nil or ret <= 0 then
		if _DEBUG then
			 local msg = 'SendLuaMsg erro:{'..tostring(args.ids[1])..','..tostring(args.ids[2])..'} ,ret = '..tostring(ret)
			 Log("SendLuaMsg.txt",msg)
			 Log("SendLuaMsg.txt",debug.traceback())
		end
	else
		if _DEBUG and ret >= 1000 then
			local msg = 'msg:{'..tostring(args.ids[1])..','..tostring(args.ids[2])..'},Len='..tostring(ret)
			Log("SendLuaMsg.txt",msg)
		end
	end	
	return ret
end

--------------------------------------------------------------------------
-- interface:
SendLuaMsg 		= _SendLuaMsg
msgh_s2c_def	= _s2c_def