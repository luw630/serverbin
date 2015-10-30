
local function get_CreditData(sid) -- 获取玩家信誉数据
	if dbMgr[sid] == nil or dbMgr.data == nil then
		return
	end
	if dbMgr[sid].data["credit"] == nil then
		dbMgr[sid].data["credit"] = {
		[1] = 5, -- 玩家初始信誉为5
		[2] = 0, -- 玩家是否作弊过
		}
	end
	return dbMgr[sid].data["credit"]
end

function get_CreditDataValue(sid, dType) -- 获取玩家信誉数据指定值
	local creditData = get_CreditData(sid)
	if creditData == nil then
		return 0
	end
	local result = creditData[dType]
	return result
end

function set_CreditDataValue(sid, dType, value) -- 设置玩家信誉数据指定值
	local creditData = get_CreditData(sid)
	if creditData == nil or creditData[dType] == nil then
		return
	end
	creditData[dType] = value
end