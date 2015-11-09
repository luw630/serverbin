--[[
file:	s2c_msg.lua
author:	wk
update:	2015-03-06
desc:server to client message mgr
]]--
local _encode = json.encode
local _CI_SendMsg_SG 	= CI_SendMsg_SG
local _tbtype=type({})


--lua消息功能枚举,服务端到前台
s2c_msg = 
{
	player=1,--玩家相关小功能
	act = 2,--活动相关
}

--消息编号
local _s2c_def = {

	--玩家相关的小功能,一般一个文件搞定
	[s2c_msg.player] = {
		[1] 	= {s2c_msg.player,1},--签到数据同步给前台
		[2]		= {s2c_msg.player,2},--玩家元宝总数同步前台
	},
	
	--活动相关
	[s2c_msg.act] = {
		[1] 	= {s2c_msg.act,1},--消费领奖活动数据同步
		[2] 	= {s2c_msg.act,2},--消费领奖活动操作结果
		[3] 	= {s2c_msg.act,3},--消费返还活动数据同步
		[4] 	= {s2c_msg.act,4},--祈福活动领取奖励同步
		[5]		= {s2c_msg.act,5},--全部活动的开启状态
		[6] 	= {s2c_msg.act, 6},--副本关卡通关活动数据同步
		[7] 	= {s2c_msg.act, 7},--英雄收集活动数据同步
		[8] 	= {s2c_msg.act, 8},--英雄等级提升活动数据同步
	},
}


--sid传0为当前玩家，否则传给指定sid的玩家； args 类似 { ids = {1,1} , 自定义变量}，ids的值必须从_s2c_def中获取
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