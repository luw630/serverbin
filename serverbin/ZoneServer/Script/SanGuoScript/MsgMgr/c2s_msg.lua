--[[
file:	c2s_msg.lua
author:	wk
update:	2015-03-06
desc:client to server message mgr
]]--
local jextype = jex.ttype
local _decode = json.decode
local _tostring=tostring

--lua��Ϣ����ö��,ǰ̨�������
c2s_msg = 
{
	player=101,--������С����
	act = 102,--����
}

local _msgDispatcher = 
{
	[c2s_msg.player] = {},--������С����
	[c2s_msg.act] = {},--����
}

function SI_OnLuaMessage( playerid, msg )
	local recvmsg=_decode(msg)
	if recvmsg==nil then 
		look("recvmsg=nil ")
		return
	end
	local idx = 1
	local func = _msgDispatcher
	local msgids = recvmsg.ids	
	while jextype( func ) == 5 do
		func = func[msgids[_tostring(idx)]]
		idx = idx + 1
	end
	if ( jextype( func ) == 6 ) then
		func( playerid, recvmsg )
	end
end

msgDispatcher 	= _msgDispatcher