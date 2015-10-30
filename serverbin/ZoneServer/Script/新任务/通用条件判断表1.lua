
通用条件判断表 = {

	SchoolInfo = { "少林", "武当", "峨眉", "唐门", "魔教" },

	CheckConditions = function ( conditions, taskData, taskid, dodel )
		-- 检查条件数据是配置类表数据，还是一个条件函数
		if type( conditions ) == 'table' then 
			-- 在配置表类数据处理时，没有条件顺序（这个由luakey规则进行控制）
			-- 之所以不使用以前的二维表，就是为了保证判断逻辑的简单性！
			local ck = nil
			local info
			for k,v in pairs( conditions ) do -- 遍历所有表项处理每一个条件式！
				if type( v ) == "function" then
					ck, info = v( k, taskData, taskid, false ) -- 如果是函数，则直接执行后获取返回值
				elseif 通用条件判断表[k] ~= nil then
					ck, info = 通用条件判断表[k]( v, taskData, taskid, dodel ) -- 如果是条件式，则通过模式匹配，去执行原注册的条件判断函数
				else
					ck, info = ( tostring( k ) .. ' ' .. tostring( v ) .. ' : 无效的条件设置' )
				end
				if ck ~= true then
					return 0, info -- 如果失败，直接返回失败结果数据，不需要继续执行了！
				end
			end
			return 1
		elseif type( conditions ) == 'function' then
			return conditions( conditions,taskData, taskid, dodel ) -- 有可能整个条件就是一个条件判断函数，那就直接执行后返回！
		end
		return 0, "无效的条件表"
	end,

	CheckAndDelete = function ( conditions, taskData, taskid )
		-- 检查，并且删除那些应该被删除的道具！
		local ck, info = 通用条件判断表.CheckConditions( conditions, taskData, taskid )
		if ck ~= 0 then
			ck, info = 通用条件判断表.CheckConditions( conditions, taskData, taskid, 1 )
		end
		return ck, info
	end,
	
	--任务超时检查
	CheckTimeout = function ( taskconf, taskid, taskdata )		
		if taskconf and type(taskconf.timeout)==type({}) and TableHasKeys(taskdata,{"current",taskid, "start"}) then
			local timepass = GetServerTime() - taskdata.current[taskid].start
			
			--整个任务的超时
			if taskconf.timeout[1] and taskconf.timeout[1]<timepass then
				return false
			end
			
			for k,v in pairs(taskconf.timeout) do
				if type('')==type(k) and TableHasKeys(taskconf, "完成条件", k) then
					local timeRequestIn = taskconf.timeout[k]
					
					--time out
					if timepass>timeRequestIn and not TableHasKeys(taskdata, {"current", taskid, "to", k} ) then
						return false
					end				
				end
			end
		end
		
		return true
	end,
	
	checkTaskDelay = function( taskconf, taskid, taskdata)
		if type(taskconf.完成延时)==type(0) and TableHasKeys(taskdata,{"current", taskid, "start"}) then
			local past = GetServerTime() - taskdata.current[taskid].start
			if past>0 and past>=taskconf.完成延时 then
				return true
			end
			return false
		end	
		return true
	end,

	-- 统一说明：条件判断的返回值统一为布尔类型
	-- 判断任务步骤,默认任务步骤记录在 : taskData.step
	-- 条件配置 completed = {10001}
	completed = function ( condition, taskData, taskid )
		if table.empty(condition) then
			return true
		end
		
		if taskData == nil or taskData.completed == nil then
			return false,"没有任务完成数据"
		end
		local completed = taskData.completed
		if type( condition ) == type({}) then
			for k,v in pairs(condition) do 
				if type(0)==type(v) then
					if completed[v] == nil then
						return false, "任务"..v.."未完成！"
					end
				elseif type({})==type(v) then
					local flag = false
					local uncompletedid
					for _,tid in pairs(v) do
						if completed[tid]~=nil then
							flag = true
							uncompletedid = tid 
							break
						end
					end

					if not flag then
						return false, "任务" ..  uncompletedid ..  "未完成！"
					end
				end
			end
			return true
		end
		return false
	end,

	-- 判断等级步骤,需要通过GetPlayerData获取
	level = function ( condition )	
		local level = GetPlayerData( 1 )
		if type( condition ) == 'number' then
			return level >= condition or "等级未达到" .. condition .. "级"
		elseif type(condition ) == 'table' then
			if condition[2] == nil then
				return level >= condition[1] or "等级未达到" .. condition[1] .. "级"
			else
				return level >= condition[1] and level <= condition[2]
			end
		end
		return false
	end,

	-- 判断门派步骤,需要通过GetPlayerData获取
	school = function (condition)
		local zschool = GetPlayerData( 2 )
		if type(condition) == 'table' then
			if (#condition == 1) then
				-- 对于门派，应该只有一个子表
				for i=1, #condition[1] do
					if (condition[1][i] == zschool) then
						return true
					end
				end
				return false
			else
				return false
			end
		end
		return false
--		if type( condition ) == 'number' then
--			return zschool == condition or "您不是%4" .. tostring( 通用条件判断表.SchoolInfo[condition + 1].."的弟子%0我帮不上您" )
--		end
	end,

	-- 判断道具步骤,需要通过CheckGoods检测
	items = function ( condition, taskData, taskid, dodel )
		--dodel = 1
		local checkonly
		if dodel==1 then
			checkonly = 0
		else
			checkonly = 1		
		end
		
		if type( condition ) == 'table' then
			for k,v in ipairs( condition ) do
				if CheckGoods( v[1], v[2], checkonly ) == 0 then
					return false,"任务道具错误"
					--local tab = GetItemSetting( v[1] )
					--if dodel == 1 then
					--	return "需要".. ( tab and tab.name or "道具编号"..v[1] ) .. v[2] .. "个"
					--else
					--	return "收取".. ( tab and tab.name or "道具编号"..v[1] ) .. v[2] .. "个失败"
					--end
					
				end
			end
			return true
		elseif type( condition ) == 'function' then
			return condition( dodel )
		end
		return false,"任务道具错误"

	end,
	
	-- 杀怪处理
	kill = function ( condition, taskData, taskid )
		if taskData == nil or taskData.current == nil or 
			taskData.current[taskid] == nil or taskData.current[taskid].kill == nil then
			return "没有杀怪数据"
		end
		local kill = taskData.current[taskid].kill
		if type(condition[1])==type({}) then
			for k,v in pairs( condition ) do --{怪物名字, 数量, {region, x,y}}
				local num = kill[ v[1] ]
				
				if num == nil then
					return false, "没有".. v[1].."的数据"
				end
				
				if num < v[2] then
					return false, "还差"..( v[2]-num).."个" .. v[1]
				end
			end
		else
			local num = kill[ condition[1] ]
			
			if num == nil then
				return false, "没有".. condition[1].."的数据"
			end
			
			if num < condition[2] then
				return false, "还差"..( condition[2]-num).."个" .. condition[1]
			end
		end
		return true
	end,

	-- 检查玩家区域
	area = function( condition, taskData,taskid )
		if taskData == nil or taskData.current == nil or taskData.current[taskid]==nil then
			rfalse("没有相关任务数据")
			return false
		end

		if(taskData.current[taskid]["area"] ~= nil) then
			return true
		end

		local mainid, subid= GetSubID(taskid)
		local area = 任务表[mainid][subid].完成条件.area
		local regionid
		local x
		local y

		x,y,regionid = getplayercurpos()
		local radius = area[4]
		local distance = math.abs(area[2]-x)+math.abs(area[3]-y)

		if( distance <= radius ) then
			rfalse("enter area ok")
			taskData.current[taskid]["area"] = 1
			return true
		else
			rfalse("enter area fail")
			return false
		end
			
	end,

	op = function(condition,taskData,taskid,opkey)
		if(taskData.current == nil or taskData.current[taskid] == nil) then
			return false
		end

		local taskConf = GetTaskConfig(taskid, taskData)
		if taskConf == nil then
			return false
		end

		for k,_ in pairs(taskConf.完成条件[opkey]) do
			if not TableHasKeys( taskData,{"current",taskid,opkey, k}) then
				return false 
			end
		end
		return true
	end,

	-- 点击面板
	click = function(condition,taskData,taskid)
		return 通用条件判断表.op(condition,taskData,taskid,"click")
	end,

	-- 使用技能
	us = function(condition,taskData,taskid)
		return 通用条件判断表.op(condition,taskData,taskid,"us")
	end,

	-- 穿上某个装备
	ei = function(condition,taskData,taskid)
		return 通用条件判断表.op(condition,taskData,taskid,"ei")
	end,

	-- 使用道具
	ug = function(condition,taskData,taskid)
		return 通用条件判断表.op(condition,taskData,taskid,"ug")
	end,

	-- 组队人数
	tmc = function(condition)
		local teamCount = GetPlayerData( 35 )
		rfalse("teamCount====="..tostring(teamCount))
		if type(condition) == 'number' then
			return teamCount == condition
		end

		if type(condition) == 'table' then
			if(condition[2]) == nil then
				rfalse("conditon====="..tostring(condition[1]))
				return teamCount == condition[1]
			else
				return teamCount >= condition[1] and teamCount <= condition[2]
			end
		end

		return false
	end,

	-- 武功等级
	-- 等级的配置方式为{{武功ID，武功等级},{武功ID，武功等级},{武功ID，武功等级}...}
	sl = function(condition)
		if type(condition) == 'table' then
			rfalse("当前的武功需求有"..#condition.."个")
			for i=1, #condition do
				local skill = condition[i][1]
				local level = condition[i][2]
				rfalse("武功:"..skill.."需要等级"..level)
				
				-- 获取武功的当前值
				local curLevel = GetPlayerData(36,skill)
				if (curLevel < level) then
					return false
				end
			end
			return true
		end
		rfalse("技能配置有误...");
		return false
	end,

	-- 心法等级
	tl = function(condition)
		if type(condition) == 'table' then
			rfalse("当前的心法需求有"..#condition.."个")
			for i=1, #condition do
				local skill = condition[i][1]
				local level = condition[i][2]
				rfalse("心法:"..skill.."需要等级"..level)
				
				-- 获取武功的当前值
				local curLevel = GetPlayerData(37,skill)
				rfalse("心法:"..skill.."当前的等级为:"..curLevel)
				if (curLevel < level) then
					return false
				end
			end
			return true
		end
		rfalse("心法配置有误...");
		return false
	end,

	buff = function(condition)
		if type(condition)==type({}) then
			for _, v in pairs(condition) do	
				local hasBuff = GetPlayerData(38, v)
				if hasBuff==false then
					return false, "不具有BUFF: " ..  v
				end
			end
			
			return true
		elseif type(condition)==type('') then
			return GetPlayerData(38, condition)
		end
	end,

	refresh = function(condition,taskData,taskid)
		local refresh = condition
		if refresh == nil then
			return false
		end
		
		local everyday = refresh.everyday
		if everyday ~= nil then
			if taskData.refresh == nil then
				return true
			end
			local pre = taskData.refresh[taskid]
			if pre == nil then
				return true
			end

			rfalse("adfasfdasfdasfdasfd:w")
			local now = GetServerTime()
			for k,v in pairs(everyday) do
				local preday = (pre-(v-8)*60*60)/(24*60*60)
				local nowday = (now-(v-8)*60*60)/(24*60*60)
				rfalse("everyday="..tostring(everyday).." pre="..tostring(pre).." now="..tostring(now).." preday="..tostring(preday).." nowday="..tostring(nowday))
				
				if rint(nowday) > rint(preday) then
					return true
				end
			end
		end
	end,

	start = function(condition,taskData,taskid)
		local start = condition
		if start == nil then
			return false
		end

		local everyday = start.everyday
		if everyday ~= nil then
			local now = GetServerTime()
			local nowday  = (now-8*60*60)/(24*60*60)
			local nowhour = (now - nowday*24*60*60)/(60*60)+1

			if rint(nowhour) >= everyday[1] and rint(nowhour) <= everyday[2] then
				if taskData.refresh == nil then
					return true
				end
				local pre = taskData.refresh[taskid]
				if pre == nil then
					return true
				end
				local preday = (pre-8*60*60)/(24*60*60)
				rfalse("preday="..tostring(preday).." nowday="..tostring(nowday))
				if rint(preday) ~= rint(nowday) then
					return true
				end
			end
		end
		
		return false
	end,
	
	money = function(condition,taskData,taskid)
		local moneyHave = GetPlayerData(48)
		if condition>moneyHave then
			return false, "钞票不足: " .. condition .. "  Only:" .. moneyHave
		end
		return true
	end,
	
	npc = function( condition, taskdata, taskid)
		if not TableHasKeys( taskdata, {"current", taskid, "npc"} ) then
			return false
		end
		
		local npcs = taskdata.current[taskid].npc
		if type(condition)==type({}) then
			for _,id in pairs(condition) do
				if nil==npcs[id] then
					return false
				end
			end			
			return true
		else
			return nil~=npcs[id]
		end
	end,
	
	attr = function( condition, taskdata, taskid)
		for k,v in pairs(condition) do
			local prop = PropertyTable[k]
			if prop then
				local value = GetPlayerData(prop[1])
				if value<v then
					return false
				end
			end
		end
		
		return true
	end,

	col = function ( conditions, taskdata, taskid)
		return 通用条件判断表.op(condition,taskdata,taskid,"col")
	end,
	
	nu = function( conditions, taskdata, taskid)
		return 通用条件判断表.op(condition,taskdata,taskid,"nu")
	end,
		
	cap = function( conditions, taskdata, taskid)
		for k, v in pairs(conditions) do
			if not TableHasKeys(taskdata, {"current", taskid, "cap", k}) 
			   or taskdata.current[taskid].cap[k] < v[2] then
				return false, v[1].."不够"
			end
		end
		return true
	end,
	
	me = function ( conditions, taskdata, taskid)
		return 通用条件判断表.op(condition,taskdata,taskid,"me")
	end,
	
	copy=function( conditions, taskdata, taskid )
		rfalse('判断副本任务是否完成')
		for k,v in pairs(conditions) do
		end
	end,

	nc = function( condition,taskData,taskid )
		return 通用条件判断表.op(condition,taskData,taskid,"nc")
	end
}
