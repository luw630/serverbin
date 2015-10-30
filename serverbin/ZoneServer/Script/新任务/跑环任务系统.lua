
--环任务是否可完成
function ringCouldComplted(taskid, taskData)
	local ringid = GetRingSubID(taskid)
	if nil==taskData.ring  then
		return false
	end
		
	--检查完成条件
	local taskInfo = GetTaskConfig( taskid, taskData )
	if taskInfo then
		local ok, info = 通用条件判断表.CheckConditions( taskInfo.完成条件, taskData, taskid)
		if 1==ok then
			return true
		end
	end
	
	return false
end

--获取任务配置信息
function GetTaskConfig( taskid, taskData )
	if IsRingTask(taskid) then
		local ringid, subid = GetRingSubID(taskid)
		if 跑环任务配置表[ringid] then
			local mainid = 跑环任务配置表[ringid].主任务库
			if taskData and TableHasKeys( 跑环任务库, { mainid, subid} ) then
				local ringConf = 跑环任务库[ mainid ][ subid ]
				
				return buildRingTaskInfo( ringid, ringConf, taskData)
			end
		end		
	else
		local mainid,subid = GetSubID(taskid)
		if TableHasKeys( 任务表, { mainid, subid} ) then
			return 任务表[ mainid ][ subid]
		end
	end
end

--构建环任务信息
function buildRingTaskInfo( ringid, ringConf, taskData)
	function _buildGive(temp, goods)
		if nil==temp.完成奖励.giveGoods then
			temp.完成奖励.giveGoods = {}
		end
		if nil==temp.完成奖励.giveGoods.give then
			temp.完成奖励.giveGoods.give= {}
		end
		table.cat( temp.完成奖励.giveGoods.give, goods )
	end
	
	local taskType = ringConf[1]
	local ringTemplate = 跑环任务模版表[taskType]
	local ringTask = 跑环任务配置表[ringid]
	
	ringTemplate.接任务npcid = ringTask.接任务npcid
	ringTemplate.交任务npcid = ringTask.接任务npcid
	
	if ringTemplate and ringTask then
		--[[
		--接受条件
		ringTemplate.接受条件 = {}
		
		--level
		ringTemplate.接受条件.level=ringConf.等级范围
		
		--money
		local moenyRequest = v.需要金钱 or 0
		if type(moneyRequest)==TP_FUNC then		--money可以是函数
			moenyRequest = moenyRequest()
		end
		ringTemplate.接受条件.money=moenyRequest
		--]]		
	
		--完成条件
		if 1==taskType then
			ringTemplate.完成条件 = buildRingFindObj(ringConf)
		elseif 2==taskType then
			ringTemplate.完成条件 = buildRingFindNpc(ringConf)
		elseif 3==taskType then
			ringTemplate.完成条件 = buildRingKill(ringConf)
		elseif 4==taskType then
			ringTemplate.完成条件 = buildRingAbttribute(ringConf)
		end
		
		--完成奖励
		ringTemplate.完成奖励 = table.copy(ringTask.完成奖励) or {}
		buildRingAward(ringTemplate.完成奖励, ringConf)
		
		--额外奖励
		local startring 
		if TableHasKeys( taskData, {"ring", "sring"} ) then
			startring = taskData.ring.sring
		end
		if startring and TableHasKeys( 跑环任务配置表, {startring, "额外奖励"}) then
			local doneRingTimes = taskData.ring.count or 0
		
			local times = doneRingTimes+1
			local goods = ringTask.额外奖励[ times ]
			local finalGive = ringTask.额外奖励.final
			if times == 跑环任务配置表.最大环数 then
				_buildGive( ringTemplate, finalGive)
			elseif nil~=goods then
				_buildGive( ringTemplate, goods)
			end
		end
	end

	return ringTemplate
end

--构建奖励信息
function buildRingAward( awardRet, ringConf)
	local awardInfo = ringConf.完成奖励 
	if nil~=awardInfo then
		--奖励经验
		local gexp = awardInfo.giveExp
		if type(0)==type(money) then
			awardRet.giveExp = gexp
		elseif TP_FUNC==type(money) then
			arardRet.giveExp = gexp()
		end
		
		--奖励金钱
		
		local money = awardInfo.giveMoney
		if type(0)==type(money) then
			awardRet.giveMoney = money
		elseif TP_FUNC==type(money) then
			arardRet.giveMoney = money()
		end	
	end
end

function buildRingFindObj( ringConfig )
	if ringConfig[2] then
		return {["items"]={ringConfig[2]}}
	end
end

function buildRingFindNpc( ringConfig )
	if ringConfig[2] then
		return {['npc'] = ringConfig[2]}
	end
end

function buildRingKill( ringConfig )
	if ringConfig[2] then
		return { ["kill"] = ringConfig[2]}
	end
end

function buildRingAbttribute( ringConfig)
	if ringConfig[2] then
		return { ["attr"]=ringConfig[2] }
	end
end

-- npc上是否可生成一个随机环任务
-- return: true, 环任务id, taskConfig
function ringCouldAccept( npcid, taskData, notupdate)
    if taskData==nil then
        return false
    end
	-- ring copy		
	for k,v in ipairs(跑环任务配置表) do
		if v.接任务npcid == npcid then
		    local ok, ringid, taskConfig = ringCouldAcceptRing( k, v, taskData, notupdate)
			if ok then
				return ok, ringid, taskConfig
			end
		end
	end
	
	return false
end

	--------------------
function ringCurrHasTheRing(ringid, taskData)
	if nil~=taskData.current then
		for taskid in pairs(taskData.current) do
			if type(0)==type(taskid) and IsRingTask(taskid) and ringid==GetRingSubID(taskid) then
				return true, taskid
			end
		end
	end
	return false
end

--某环是否可以接
function ringCouldAcceptRing( ringid, taskConfig, taskData, notupdate)
	taskConfig = taskConfig or 跑环任务配置表[ringid]
	if nil==taskConfig then
		return false
	end

	local ring = taskData.ring
	if nil~=notupdate or notupdate then
		taskData.ring = table.copy(taskData.ring)
	end
	
	function _restore()
		if nil~=notupdate or notupdate then
			taskData.ring = ring
		end
	end
	
	------------------	
	function _checkTimes(pos,times, ringid)
		function GetCurrTimes( name )
			if TableHasKeys( taskData, {"ring", pos,name}) then	
				return taskData.ring[pos][name]
			else
				return 0
			end
		end

		local _times = {"day"}
		for _,v in ipairs(_times) do
			if nil~=times[v] then
				if GetCurrTimes(v)>=times[v] then
					return false
				end
			end
		end
		
		return true	
	end
	
	--1. level check
	local levelRequest = taskConfig.等级范围
	local ok, info = 通用条件判断表.level( levelRequest )
	
	
	local finishcount = 0
	if TableHasKeys(taskData, {"ring", "count"} ) then
		finshicount = taskData.ring.count
	end

	if ok and finishcount<跑环任务配置表.最大环数 then
		--2. money check
		local moenyRequest = taskConfig.需要金钱 or 0
		if type(moneyRequest)==TP_FUNC then		--money可以是函数
			moenyRequest = moenyRequest()
		end				
		ok = 通用条件判断表.money( moenyRequest )
		
		if ok then
			--刷新次数
			ringRefresh( taskData )
			-- 3. 检索玩家当前有没有存在的任务链任务
			ok = ringCurrHasTheRing( ringid, taskData )
			if not ok then
				-- 4. 任务链每日可完成次数、每周总共可完成次数可以自由调控
				if (跑环任务配置表.可接次数 and _checkTimes( "acc", 跑环任务配置表.可接次数, ringid)) then					
					_restore()					
					return true, ringid, taskConfig
				end						
			end
		end
	end
	
	return false
end

-- client

--- Server
function 预处理剧情( playerid, story, taskData, npcid )
	if nil==story then
		return true
	end

	for _, v in ipairs(story) do
		if nil~=v.task and -1==v.task[1] then
			local newtaskid = ringGenerateTask(npcid, taskData)
			GetTaskTemp( playerid ).ringtaskid = newtaskid
			if newtaskid then
				v.task[2] = newtaskid
			else
			    return false
			end
		end
	end	
	return true
end

--server
--生成一个随机任务,服务器生成选择
--return: taskid
function ringGenerateTask(npcid, taskData)
	local ok, ringId, taskConf = ringCouldAccept( npcid, taskData)
	if ok then
		return ringRandomTask( ringId, taskConf, taskData)
	end	
end

-- 随机生成一个具体的任务id
--return: taskid, ringid, subid
function ringRandomTask( ringId, taskConf, taskData)
	local taskLib = 跑环任务库[taskConf.主任务库]

	if taskLib then
		local randIndex
		if taskConf.任务比例 then
			local taskType = fastRandomRate(taskConf.任务比例)
			
			--一般而言这里是配置错误
			if nil==taskLib.libType[taskType] then
				return
			end
			
			local counter = #taskLib.libType[taskType]
			local idIndex = 1+rint( math.random()*counter)
			randIndex = taskLib.libType[taskType][ idIndex ]
		else
			local counter = #taskLib
			randIndex = 1+rint( math.random()*counter)
		end
		
		--在subid不连续的时候或许这里还需要特殊处理
		--还有任务类型概率问题
		
		local subid = randIndex		
		return GetRingTaskId(ringId, subid), ringId, subid
	end
end

--刷新环任务时间
--return: drops需要放弃的任务列表
DAY_SECONDS = 24*60*60
WEEK_SECONDS = 7*DAY_SECONDS
function ringRefresh(taskData, notupdate)
	function _clearRecord( key, now)
		local ring = taskData.ring

		if taskData.ring.acc then
			taskData.ring.acc[key] = nil
		end
				
		ring.rstart = nil
		ring.cstart = nil
		ring.slevel = nil
			
		ring.sring	= nil
		
		ring.count = nil
		
		if nil~=ring.id and TableHasKeys(taskData, {"current", ring.id}) then
			taskData.current[ring.id] = nil			
		end
		ring.id = nil
		
		ring.refresh[key] = now
	end
	
	---------------------------	

	function IsRefreshByDay(everyday, now)
		local last  = taskData.ring.refresh.day		

		if type(everyday) == type(0) then
			return not isPassedThisDay(everyday,0, last) and isPassedThisDay(everyday, 0, now)
		elseif type({}) == type(everyday) then
			return not isPassedThisDay(everyday[1], everyday[2], last) and isPassedThisDay(everyday[1], everyday[2], now)
		end
	end
	
	function IsRefreshByWeek( everyweek, now)
		local last  = taskData.ring.refresh.week
		if now-last> WEEK_SECONDS then
			return true
		elseif type(everyweek) == type(0) then
			if 2==#everyweek then
				if not isPassedThisWeek(everyweek[1], everyweek[2], 0, last) and
					isPassedThisWeek(everyweek[1], everyweek[2], 0, now) then
					return true
				end
			elseif 3==#everyweek then
				if not isPassedThisWeek(everyweek[1], everyweek[2], everyweek[3], last) and
					isPassedThisWeek(everyweek[1], everyweek[2], everyweek[3], now) then
					return true
				end
			end
		end
		--else
		--	taskData.ring.refresh.week = now
		--end
		return false
	end
   
	if not TableHasKeys( taskData, {"ring", "refresh"} ) then
		return false		
	end
		
	local refresh = 跑环任务配置表.刷新
	if nil==refresh then
		return false
	end
	
	local now = GetServerTime()
		
	local need = false
	if refresh.everyday and IsRefreshByDay( refresh.everyday, now ) then		
		if nil~=notupdate then
			return true, true
		else
			_clearRecord( "day" , now)		
		end
	end
	
	if refresh.everyweek and IsRefreshByWeek(refresh.everyweek, now) then
	
		if nil~=notupdate then
			return true, true
		else
			_clearRecord( "week" , now)		
		end
	end
			
	return true
end

--放弃
function ringDropTask(taskid, taskData)
	local ringid = GetRingSubID(taskid)
	if taskData then
	    local ring = taskData.ring		
	    if ring then
            ring.id = nil
	        ring.cstart = nil
			ring.rstart = nil
			ring.slevel = nil
			ring.sring = nil
			ring.count = nil
	    end
	end
end

function ringTaskClickNpc( taskid, taskData, npcid, _handler)	
	local taskInfo = GetTaskConfig(taskid, taskData)
	if taskInfo then
		if TableHasKeys(taskInfo, {"完成条件",npc}) then
			local condition = taskInfo.完成条件.npc
			if type(condition)==type({}) then
				for _, npc in pairs(condition) do
					if npc==npcid then
						_handler(taskid, taskData, npcid)
						return true
					end
				end
			else
				if npcid==condition then
					_handler(taskid, taskData, npcid)
					return true
				end
			end
		end				
	end
	return false
end
