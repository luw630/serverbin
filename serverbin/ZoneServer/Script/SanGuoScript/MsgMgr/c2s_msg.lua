--[[
file:	c2s_msg.lua
author:	wk
update:	2015-03-06
desc:client to server message mgr
]]--
local jextype = jex.ttype

local _msgDispatcher = {
	[100] = {},--签到
	[101] = {},--功能描述
	[102] = {},--功能描述

}
function SI_OnLuaMessage(  playerid, msg )
	recvmsg=nil
	unserialize(msg)
	if recvmsg==nil then 
		look("recvmsg=nil ")
		return
	end
	local idx = 1
	local func = _msgDispatcher
	local msgids = recvmsg.ids	
	while jextype( func ) == 5 do
		func = func[msgids[idx]]
		idx = idx + 1
	end
	if ( jextype( func ) == 6 ) then
		func( playerid, recvmsg )
	end
end

msgDispatcher 	= _msgDispatcher