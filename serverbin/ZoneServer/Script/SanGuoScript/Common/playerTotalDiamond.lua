--[[
file:	playerTotalDimaond.lua
desc:	玩家总金额
author:	lpd
update:	2015-11-07
]]--

--取得玩家的任务的相关数据
local function get_totalDiamond( sid )
	if dbMgr[sid]==nil or  dbMgr[sid].data==nil then 
		return
	end
	if dbMgr[sid].data['total_diamond'] == nil then --初始化任务的lua层数据
		dbMgr[sid].data['total_diamond'] = 
		{
			diamond = 0,
		}
	end
	return dbMgr[sid].data['total_diamond']
end

function updateTotalDiamond(sid, num) --num此次获取的元宝数额
 	--look("updateTotalDiamond "..sid.."  "..num)
 	local  curData = get_totalDiamond( sid )
 	curData.diamond = curData.diamond + num 
end

function sendTotalDiamond( sid ) --发送元宝总数
	look( "sendTotalDiamond "..sid)
	local  curData = get_totalDiamond(sid)
	if curData ~= nil then
		SendLuaMsg(sid, { ids = msgh_s2c_def[s2c_msg.player][2], diamond = curData.diamond})
	end
	
end

