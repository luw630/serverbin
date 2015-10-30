--[[
file:	s2c_msg.lua
author:	wk
update:	2015-03-06
desc:server to client message mgr
]]--
local _CI_SendMsg_SG 	= CI_SendMsg_SG
local _tbtype=type({})
local _s2c_def = {
	[1] = {--玩家相关的小功能,一般一个文件搞定
		[1] 	= {1,1},--签到数据同步给前台
		[2] 	= {1,2},--功能描述
		[3] 	= {1,3},--功能描述
	},
	[2] = {--功能描述
		[1] 	= {2,1},--功能描述
		[2] 	= {2,2},--功能描述
		[3] 	= {2,3},--功能描述
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