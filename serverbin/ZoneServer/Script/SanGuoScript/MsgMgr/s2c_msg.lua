--[[
file:	s2c_msg.lua
author:	wk
update:	2015-03-06
desc:server to client message mgr
]]--
local _CI_SendMsg_SG 	= CI_SendMsg_SG
local _tbtype=type({})
local _s2c_def = {
	[1] = {--�����ص�С����,һ��һ���ļ��㶨
		[1] 	= {1,1},--ǩ������ͬ����ǰ̨
		[2] 	= {1,2},--��������
		[3] 	= {1,3},--��������
	},
	[2] = {--��������
		[1] 	= {2,1},--��������
		[2] 	= {2,2},--��������
		[3] 	= {2,3},--��������
	},
}

local function _SendLuaMsg(sid,args)
	if args==nil or type(args.ids)~=_tbtype then return end
	local ret = _CI_SendMsg_SG( sid, serialize(args))
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