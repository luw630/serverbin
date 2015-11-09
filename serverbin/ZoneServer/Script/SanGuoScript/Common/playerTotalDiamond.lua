--[[
file:	playerTotalDimaond.lua
desc:	����ܽ��
author:	lpd
update:	2015-11-07
]]--

--ȡ����ҵ�������������
local function get_totalDiamond( sid )
	if dbMgr[sid]==nil or  dbMgr[sid].data==nil then 
		return
	end
	if dbMgr[sid].data['total_diamond'] == nil then --��ʼ�������lua������
		dbMgr[sid].data['total_diamond'] = 
		{
			diamond = 0,
		}
	end
	return dbMgr[sid].data['total_diamond']
end

function updateTotalDiamond(sid, num) --num�˴λ�ȡ��Ԫ������
 	--look("updateTotalDiamond "..sid.."  "..num)
 	local  curData = get_totalDiamond( sid )
 	curData.diamond = curData.diamond + num 
end

function sendTotalDiamond( sid ) --����Ԫ������
	look( "sendTotalDiamond "..sid)
	local  curData = get_totalDiamond(sid)
	if curData ~= nil then
		SendLuaMsg(sid, { ids = msgh_s2c_def[s2c_msg.player][2], diamond = curData.diamond})
	end
	
end

