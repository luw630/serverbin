
function AddLuaPlayer(sid )
	if g_LuaPlayerManager[sid] == nil then
		g_LuaPlayerManager[sid] = {}
	end
	local Lplayer = LuaPlayer:new()
	Lplayer:Init(sid)
    g_LuaPlayerManager[sid] = Lplayer
end

function RemoveLuaPlayer(sid )
	if g_LuaPlayerManager[sid] ~= nil then
		g_LuaPlayerManager[sid] = {}
	end
end

function GetLuaPlayer(sid )
	return g_LuaPlayerManager[sid]
end

function InitLuaPlayerManager(  )
	if g_LuaPlayerManager == nil then
		g_LuaPlayerManager = {}
	end
end

InitLuaPlayerManager()