-- 脚本事件接口 --

--退出队伍接口
function OnQuitTeam( )
	rfalse('--退出队伍接口')
	local sid = GetPlayerData(17)
	
	--检查角色是否在副本状态
	local playerTemp = CS_GetPlayerTemp(sid)
	if playerTemp ~= nil then
		CS_OnQuitTeam(  )
		return
	end
end