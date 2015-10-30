--[[
file:	MissionActivenessRewards.lua
author:	Jonson
update:	2015-06-19
desc:萌斗三国的任务相关数据存储
]]--

--取得玩家的任务活跃度的相关数据
local function _getdata( sid )
	if dbMgr[sid]==nil or  dbMgr[sid].data==nil then 
		return
	end
	if dbMgr[sid].data['mAct_data'] == nil then --初始化任务的lua层数据
		dbMgr[sid].data['mAct_data'] = {}
	end
	return dbMgr[sid].data['mAct_data']
end

--开始领取任务活跃度奖励
function ClaimMissionActivenessRewards(sid, level)
	local pdata = _getdata(sid)
	if pdata == nil then 
		pdata = {}
	end
	
	--如果指定数据不存在，则新建一个，默认奖励没领取
	if pdata[level] == nil then
		pdata[level] = false
	end
	
	--开始判断指定的奖励是否领取过
	if not pdata[level] then
		pdata[level] = true
		return 1
	else
		return 0
	end
end

--重置任务活跃度相关数据
function ResetMissionActiveness(sid)
	--暂时来看数据量不算多，就先直接新表
	dbMgr[sid].data['mAct_data'] = {}
	-- if pdata == nil then 
		-- return
	-- end
	
	-- for key, v in pairs(pdata) do
		-- if type(key) == "number" and type(v) == "boolean" then
			-- pdata[key] = false
		-- end
	-- end
end

--同步任务活跃度到客户端
function SynMissionActivenessDataToClient(sid)
	local pdata = _getdata(sid)
	if pdata == nil then 
		return
	end
	--发给客户端的数据仅仅只是已经领取了奖励的对应的level。比如活跃度到达level 30的奖励已经领取了，则把30压入表中
	local filterData = {}
	counter = 1
	for key, value in pairs(pdata) do
		if type(value) == "boolean" and value == true then
			filterData[counter] = key
			counter = counter + 1
		end
	end
	
	--调用C++代码同步到客户端
	CI_SynMissionActivenessData(sid, counter - 1, filterData)
	filterData = nil
end