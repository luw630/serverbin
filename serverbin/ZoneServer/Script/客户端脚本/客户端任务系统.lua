rfalse("task loading")

initToObjItems()

if ( msgDispatcher == nil ) then
	msgDispatcher = {
		[1] = {},	-- 新任务相关
		[2] = {},	-- CG相关
		[3] = {}, 	-- 副本相关
		[4] = {}, 	-- 副本相关
		[5] = {}, 	-- 杂项
		[6] = {}, 	-- 装备打造脚本相关    jym
	}
end

UnrealStory = {}

--[[
function RPC_Call(data)
	if(data == nil or type(data)~='table' or #data < 1 or type(data[1])~='string') then
		rfalse("函数调用格式错误")
		return
	end
	local msg = {}
	msg.func = data[1]
	data[1] = nil
	msg.args = data
	SendToServer(msg)
end
--]]

msgDispatcher[10] = function(playerid, msg)
	local f = msg.f
	if f then
		rfalse("On Sever RPC Call:" .. f)
		
	    local func = _G[f]
	    if nil==func then
	        return
	    end
	    
		local a = msg.arg
		if a then
			--ST(a)
			func(unpack(a))
		else
			--rfalse( "  No arg.\n")
			func()
		end
	end
end

function buildClickNpcStory( npcid, taskid )
	local taskinfo = GetTaskConfig(taskid, saveTaskData)
	_t = {
			npcimg = 任务NPC配置表[npcid].NpcCreate.npcimg,
			[1] = { info= 任务NPC配置表[npcid].NpcInfo.talk, selection ={ {"完成任务链 " .. taskinfo.任务名称,2}, {"退出",0} } },
			[2] = { npc = {npcid,taskid}, },
		}
	return _t
end

function InsertClickNpcStory( result, npcid )
	if saveTaskData.current then
		for taskid in pairs(saveTaskData.current) do
			if IsRingTask(taskid) then
				local ringid,subid = GetRingSubID(taskid)
				local mainid = 跑环任务配置表[ringid].主任务库
				if TableHasKeys(跑环任务库, {mainid, subid}, 2 ) and 2==跑环任务库[mainid][subid][1] then
					local npcfind = 跑环任务库[mainid][subid][2]
					for _,v in pairs(npcfind) do
						if not TableHasKeys(saveTaskData, {"current", taskid, "npc", npcid}) then
							if type(v)==type({}) and v[1] ==npcid then
								--{taskid, state, npcid,}
								table.push(result, {taskid, 4, v} )
							elseif type(v)==type(0) and v==npcid then
								table.push(result, {taskid, 4, v} )
							end
						end
					end
				end
			end
		end
	end
end

function 构建剧情( npcid, ringid )
	function _preHandleRingTasks(npcid, result, taskid)
        if nil==result then
            if taskid then
                return {{taskid,TASK_CANACCEPT}}
            end
            
            return
        end
		local rid
		if taskid then
			rid = GetRingSubID(taskid)
		end

        for k ,task in ipairs(result) do
            if IsRingTask( task[1] ) then
                local ringid,subid = GetRingSubID( task[1] )
				
				if rid==ringid and task[2]==TASK_COMPLETED then
					taskid	= nil 	--有完成的就不添加同类型的可接
				end

			    if subid==0 then
				    result[k] = nil
                end
				
            end
        end
        
        if taskid and ringCouldAccept( npcid, saveTaskData, 1) then
            
            table.push(result, {taskid,TASK_CANACCEPT} )
        end
        return result
    end

	local npcInfo   = 任务NPC配置表[npcid]
	local npcstate,result = GetNPCState(npcid)
	
	result = _preHandleRingTasks(npcid, result, ringid )
	InsertClickNpcStory(result, npcid)
		
	UnrealStory[npcid] = {}
	UnrealStory[npcid].npcimg = 任务NPC配置表[npcid].NpcCreate.npcimg 

	if result == nil then
		ShowStory(任务NPC配置表[npcid].NpcInfo.talk,任务NPC配置表[npcid].NpcCreate.npcimg,任务NPC配置表[npcid].NpcCreate.name,{{"退出",0}},1)
	elseif #result == 0 and saveTaskData.current~=nil then
		local isTaskNpc
		for k,v in pairs(saveTaskData.current) do
			local taskid = k
			local taskData = GetTaskConfig(taskid, saveTaskData)	

			if npcid == taskData.接任务npcid then
				local actionIndex= 通用条件判断表.CheckConditions(taskData.完成条件,saveTaskData,taskid)
				if(actionIndex ~= 1) then -- 未完成才触发剧情，已完成但未交显示npc默认对话
					SendToServer( { ids={1,1}, npcid = npcid, taskid = taskid, type = 2 } )
					isTaskNpc = 1
				end
				break
			end
		end
		if isTaskNpc==nil then -- 该npc暂未关联任务 或 任务已完成但未交
			ShowStory(任务NPC配置表[npcid].NpcInfo.talk,任务NPC配置表[npcid].NpcCreate.npcimg,任务NPC配置表[npcid].NpcCreate.name,{{"退出",0}},1)
		end
	elseif #result == 1 then
		local taskid = result[1][1]
		local taskData = GetTaskConfig(taskid, saveTaskData)	

		-- 一个关联任务时候的处理，直接触发！
		if result[1][2] == 2 then
			-- 启动接任务的剧情！
			SendToServer( { ids={1,1}, npcid = npcid, taskid = taskid, type = 1 } )
		elseif result[1][2] == 3 then
			-- 弹出交任务面板！
			ShowTask(0,taskData.任务名称,taskData.任务说明,taskid,taskData.交任务npcid,nil,GetConditionInfo(taskid,taskData),GetAwardInfo(taskData))			

		elseif result[1][2] == 1 then
			-- 启动任务未完成时的剧情！
			SendToServer( { ids={1,1}, npcid = npcid, taskid = taskid, type = 2 } )
		elseif result[1][2]==4 then
			story = buildClickNpcStory( npcid, taskid)

			isDaymanicTalk = nil
			storydata = story
			TalkDialog_Next(1)
		elseif result[1][2]==TASK_FUNCTION then
			SendToServer( { ids={1,1}, npcid = npcid,  index = result[1][1], type = 3 } )			
		end
	else
		--rfalse("result...\n")
		--ST(result)
		UnrealStep = 1
		UnrealNpcid = npcid
		local taskid
		local index = 1
		UnrealStory[npcid].info =  任务NPC配置表[npcid].NpcInfo.talk
		UnrealStory[npcid][1] = {}
		UnrealStory[npcid][1].selection = {}

		for k,v in pairs(result) do
			index = #UnrealStory[npcid][1].selection + 1
			local step = index + 1
			
			if v[2]==TASK_CURR or  v[2]==TASK_CANACCEPT  or v[2]==TASK_COMPLETED then
				local taskid =v[1] 							
				local taskConf = GetTaskConfig(taskid, saveTaskData)
				local taskname = taskConf.任务名称

				if v[2] == 3 then
					UnrealStory[npcid][1].selection[index] = {taskname.."(已完成)", step, TASK_COMPLETED, taskid}
				elseif v[2] == 2 then
					UnrealStory[npcid][1].selection[index] = {taskname.."(可接任务)", step, TASK_CANACCEPT, taskid}
				elseif v[2] == 1 then
					UnrealStory[npcid][1].selection[index] = {taskname.."(未完成)", step, TASK_CURR, taskid}				
				elseif v[2]==4 then
					UnrealStory[npcid][1].selection[index] = {"完成点击NPC操作", step, 4, taskid, v}
				end
			elseif v[2]==TASK_FUNCTION  then
				local FunItem = 任务NPC配置表[npcid]. NpcFunction[v[1]]
				UnrealStory[npcid][1].selection[index] = {FunItem[2], step, TASK_FUNCTION, npcid, v[1]}
			end
			
			--rfalse("UnrealStory npcid:  " .. npcid .. "\n")

			index = index + 1
		end
		UnrealStory[npcid][1].selection[index] = {"退出",0}
		if 任务NPC配置表[npcid].仓库 ~= nil then
			UnrealStory[npcid][1].selection[index+1] = {任务NPC配置表[npcid].仓库.info,index}
		end
		
		ShowStory(UnrealStory[npcid].info,UnrealStory[npcid].npcimg,UnrealStory[npcid].npcName,UnrealStory[npcid][1].selection, 1)
	end
end

msgDispatcher[1][1] = function ( playerid, msg )
	rfalse("客户端点击了npc...")
	UnrealStory = {}

	local npcid     = msg.npcid
	local state = GetNpcNcState( npcid, saveTaskData)
	if state==NC_STORY then
		构建剧情(npcid, msg.ringid)		
	elseif state==NC_CLICK or state==NC_COLLECT then
		SendToServer( { ids = { 1, 8 }, npcid = npcid } )
	end
end

local isDymanicTalk
storydata = {}
local stroynpcid = nil
msgDispatcher[1][2] = function ( playerid, msg )
	rfalse("收到任务剧情信息...")
	storydata = msg.data
	stroynpcid = msg.npcid

	isDaymanicTalk = msg.dyn

	TalkDialog_Next(1)
end

msgDispatcher[1][3] = function ( playerid, msg )
	rfalse("收到任务追踪消息:任务id" .. tostring(msg.taskid) )
	local taskid = msg.taskid
		
	if saveTaskData.current and saveTaskData.current[taskid] then
		if msg.op == 1 then
			saveTaskData.current[taskid].track = 1	--nil:取消跟踪 1: 跟踪任务 || true or false
		else
			saveTaskData.current[taskid].track = nil
		end
	end
end

msgDispatcher[1][4] = function ( playerid, msg)
	--[[
	function callTableFuncs( t )
	    assert( type(t)== type({}) )
	    for _,v in ipairs(t) do
		_G[v]()
	    end
	end
	--]]
	local taskid = msg.data.id
	
	--跑环任务暂不支持 客服端接受/完成事件
	if IsRingTask(taskid) then
		return
	end
	
	local mainid, subid = GetSubID(taskid)
	local task = 任务表[mainid][subid]
    if msg.data.accept then
	    rfalse("收到接任务消")
	    local events = task.客服端接受事件
	    if nil ~= events then
			callTableFuncs(events)
		    TaskAcceptNotify(taskid)
	    end
	else	
	    rfalse("收到任务完成消息")

	    local events = task.客服端完成事件
	    if nil ~= events then
			callTableFuncs(events)
	    end
	    
	    local goodid = msg.data.good
	    TaskCompletedNotify(taskid, goodid)
	end    
end

--采集完成
function submitAllFinishTask(npcid)
	for taskid,v in pairs(saveTaskData.current) do
		
	end
end

msgDispatcher[1][5] = function ( playerid, msg)
	local npcid = msg.npcid
	
	submitAllFinishTask( npcid)	
end

msgDispatcher[1][6] = function ( playerid, msg)
	local npcid = msg.npcid
	local itemid = msg.item
	
	--NPC特效
end

msgDispatcher[2][1] = function ( playerid, msg )
	 AutoRunScript(msg.cg)
end

-- 处理服务器通知客户端显示副本奖励窗口的消息
msgDispatcher[3][1] = function ( playerid, msg )
	rfalse('55555555')
	local awardInfo = msg.awardInfo
	local taskID = msg.taskID
	rfalse(taskID)
	local copySceneConfig = 副本配置[taskID]
	rfalse('ddfddfdfdfdf')
	if copySceneConfig == nil then
		ShowTask(2, '配置错误', '配置错误', nil, nil, nil, nil, GetAwardInfo(awardInfo))
	else
		ShowTask(2, copySceneConfig.副本名字, copySceneConfig.完成描述, nil, nil, nil, nil, GetAwardInfo(awardInfo),nil)
	end
end

-- 通知显示强制进入副本确认窗口
msgDispatcher[3][2] = function ( playerid, msg )
	ShowConfirmDialog(msg.Desc, msg.cbOkName, msg.PlayerSID)
end

-- 显示MessageBox
msgDispatcher[5][1] = function ( playerid, msg )
	ShowMessageBox(msg.Desc)
end

function CS_ClientConfirmForceEnter( playerSID )
	SendToServer( { ids = { 4, 2 }, ['PlayerSID'] = playerSID } )
end

function SendTaskTrack( taskid,  tracked )
	if tracked==1 then 
		SendToServer( { ids={1,5}, taskid=taskid, op=1 } )
	else
		SendToServer( { ids={1,5}, taskid=taskid, op=0 } )
	end
end

-- 显示提示信息   jym
msgDispatcher[6][1] = function ( playerid, msg )
	--rfalse("测试:"..tostring(msg.handle))
	ShowConfirmDialog(msg.Desc, msg.cbOkName, msg.type)
end


function DJ_ClientConfirmDoIt( Type )
	--rfalse("测试:"..tostring(Handle))
	SendToServer( { ids = { 11, 1 }, ['type'] = Type } )
end

-- ##############客户端逻辑部分#########################

if saveTaskData == nil then
	saveTaskData = {}
end

function SetTaskData( taskId, taskData )
	rfalse( "taskdata = " .. tostring( taskData ) )
	if ( taskData == nil ) then
		saveTaskData = { current = {}, completed = {} }
	else 
		saveTaskData = taskData.taskData
	end
	RefreshNpcState()
end

function ShowTable( tab, sop, path, seeall ) 
    if ( path == nil ) then path = "" end
    local isEmpty = true
    for k,v in pairs( tab ) do
        if ( seeall or ( k ~= "" ) ) then
            sop( path .. tostring( k ) .. " = ".. tostring( v ) )
            isEmpty = false
            if ( jex.ttype( v ) == 5 ) then
                ShowTable( v, sop, path .. "  " ) 
            end
        end
    end
    if ( isEmpty ) then
       sop( path .. jex.topointer( tab ) .. " table is empty" )
    end
end

--初始化npc可接、不可交任务表
npc2task = {}
function InitNpc2Task(npcid) 
	if( npcid < 0 or npc2task[npcid] ~= nil ) then
		return
	end

	for k1,v1 in pairs(任务表) do	
		--for k2,v2 in ipairs(v1) do
		for k2,v2 in pairs(v1) do
            if type(k2)==type(0) then		
                if( npcid == v2.接任务npcid ) then
                    local taskid = GetTaskId( k1,k2)
                    if( npc2task[npcid] == nil ) then
                        npc2task[npcid] = {}
                    end
                    local aTask = {taskid,0}
                    npc2task[npcid][#npc2task[npcid]+1] = aTask
                end

                if( npcid == v2.交任务npcid ) then
					local taskid = GetTaskId( k1,k2)
                    if( npc2task[npcid] == nil ) then
                        npc2task[npcid] = {}
                    end
                    local aTask = {taskid,1}
                    npc2task[npcid][#npc2task[npcid]+1] = aTask
                end
            end
		end
	end
	--ShowTable( npc2task, rfalse )
end

------------------------------------

function GetRingTaskState( npcid )
	local completed	= {}
	local canAccept = {}
	
	local _fastCompleted = {}	--快速判断任务是否已完成
		
	--完成任务
	if saveTaskData.current then
		for taskid,_ in pairs(saveTaskData.current) do
			if IsRingTask(taskid) and ringCouldComplted(taskid, saveTaskData) then
				local taskinfo = GetTaskConfig(taskid, saveTaskData)
				if taskinfo.交任务npcid == npcid then
					table.push( completed, taskid )
					local ringId = GetRingSubID(taskid)
					_fastCompleted[ringId] = true
				end
			end
		end
	end
	
	--可接任务
	local ok,ringId = ringCouldAccept(npcid, saveTaskData, 1)
	if ok and nil==_fastCompleted[ringId] then
		table.push( canAccept, GetRingTaskId(ringId,0) )
	end
		
	return completed, canAccept, curr
end

-------------------------

function GetNPCFunction(npcid)	
	if not TableHasKeys(任务NPC配置表, {npcid, "NpcFunction" }) then
		return {}
	end

	local result = {}
	local NPCFun = 任务NPC配置表[npcid].NpcFunction	
	for k,v in pairs(NPCFun) do
		if type(v[3]) == type({}) then
			local actionIndex = 通用条件判断表.CheckConditions(v[3],saveTaskData,0)
			if actionIndex == 1 then
					table.push(result, {k,TASK_FUNCTION})
			end
		else
				table.push(result, {k,TASK_FUNCTION})	
		end
	end
	return result
end

function GetNPCState( npcid)
	if(npc2task[npcid] == nil ) then
		InitNpc2Task(npcid)
	end
		
	local state		= 0
	local completed	= {}
	local canAccept = {}
	local current   = {}
	local result = {}
	
	local timeouts = {}
	
	if npc2task[npcid] then
        for k,v in pairs(npc2task[npcid]) do
            local taskid = v[1]
            local taskInfo = GetTaskConfig(taskid, saveTaskData)
            
            local curTask = nil
            if(saveTaskData.current ~=nil ) then
                curTask = saveTaskData.current[taskid]
            end
            
            
            --先判断是否有已完成任务
            
            if( curTask~= nil and v[2] == 1 ) then --交任务npc
                local actionIndex
                local failInfo
                actionIndex, failInfo = 通用条件判断表.CheckConditions(taskInfo.完成条件,saveTaskData,taskid)
                if(actionIndex == 1) then
					local notTimeout = 通用条件判断表.CheckTimeout(taskInfo, taskid, saveTaskData)
					local notDelay = 通用条件判断表.checkTaskDelay(taskInfo, taskid, saveTaskData)
					if notTimeout and notDelay then
						completed[#completed+1] = taskid
					else
						--table.push(timeouts, taskid )
						table.push(current, taskid)
					end
                else
                    current[#current+1] = taskid
					--[[
                    if __debug and failInfo then
                        rfalse( failInfo )
                    end
					--]]
                end
            end

            if(saveTaskData.completed == nil) then
                saveTaskData.completed = {}
            end
            
            if( curTask == nil and v[2] == 0 and saveTaskData.completed[taskid] == nil ) then -- 接任务npc
                local actionIndex
                local failInfo
                actionIndex, failInfo = 通用条件判断表.CheckConditions(taskInfo.接受条件,saveTaskData,taskid)
                if(actionIndex == 1) then
                    canAccept[#canAccept+1] = taskid
                end
            end

        end
     end
	
	--跑环任务
	local comp, acc = GetRingTaskState(npcid)
	table.cat( completed, comp)
	table.cat( canAccept, acc )
	
	local state = 0
	if(#completed > 0 )     then state = TASK_COMPLETED 
	elseif(#canAccept > 0 ) then state = TASK_CANACCEPT
	elseif(#current > 0)    then state = TASK_CURR
	end

	--return state,completed,canAccept,current

	for k,v in ipairs( completed ) do
		result[#result+1] = {v, TASK_COMPLETED}
	end
	for k,v in ipairs( canAccept ) do
		result[#result+1] = {v, TASK_CANACCEPT}
	end
	for k,v in ipairs( current ) do
		result[#result+1] = {v, TASK_CURR}
	end
	
	local r = GetNPCFunction(npcid)
	table.cat(result,r)
	--超时
	--[[
	for k,v in ipairs( timeouts ) do
		result[#result+1] = {v, TASK_TIMEOUT}
	end
	--]]

	--[[
	rfalse("---------------------- " .. npcid )
	ST(result)
	
	--]]
	return state, result
end


-- ##################################################################

-- 注意，消息处理函数的注册放在具体的功能脚本里边。。。

-- 客户端直接发送一个table过来，msg是客户端脚本系统中，直接序列化好的消息
-- 消息表中需要包含消息ID序列，用于对应消息处理脚本函数
function OnLuaMessage( playerid, msg )
	local idx = 1
	local func = msgDispatcher
	local msgids = msg.ids
	while jex.ttype( func ) == 5 do
		func = func[msgids[idx]]
		idx = idx + 1
	end
	if ( jex.ttype( func ) == 6 ) then
		func( playerid, msg )
	end
end

-- ##################################################################

UnrealStep   = 0
UnrealNpcid  = 0
UnrealIsAccept = 0

--UnrealAcceptInfo    = {}
--UnrealCompletedInfo = {}

function UnrealTalkDialog(npcid,step)
	UnrealStep  = step
	UnrealNpcid = npcid

	if(step==0) then
		TalkDialog_Cancel()
		return
	end

	local info      = UnrealStory[npcid][step].info
	local selection = UnrealStory[npcid][step].selection
	local task	    = UnrealStory[npcid][step].task

	if ( task ~= nil ) then
		TalkDialog_Cancel()
		local taskdata = 任务表[task[1]][task[2]]
		SendToServer( { ids={1,2}, npcid = UnrealNpcid, taskid = GetTaskId(task[1]+task[2]) } )
		return
	end

	if(info ~= nil) then
		ShowStory(UnrealStory[npcid][step].info,UnrealStory[npcid].npcimg,UnrealStory[npcid].npcName,selection,1)
	end

end
colours=colours or {}
color_config = { ready = colours.green, notready=colours.red}

function GetConditionInfo(taskid,taskdata, check)
	local old_color_table 
	
	--check默认为true
	if check==nil then
		check = true
	end
	
	if not check then
		old_color_table = table.copy(color_config)
		--color_config = { ready = "", notready=""}
		color_config = { ready = colours.red, notready=colours.red }
	end
	
	local condition = {[1]="目标:"}
	--///////////////////////////////
	local searchobj = {}
	--///////////////////////////////
	local i = 2
	for k,v in pairs(taskdata.完成条件) do		
		local key = tostring(k)
		local findpos
		if key == "level"  then
			local playerLevel = GetPlayerData( 1 )
			local text
			if playerLevel >= v then
				text = color_config.ready
			else
				text = color_config.noready
			end

			text = text.."等级达到"..tostring(v).."级"
				
			condition[i] = text
			i = i+1
		elseif key == "kill" then
			i, findpos = UpdateKillInfo(condition, i, taskdata,taskid, check)
			
			table.cat(searchobj, findpos)
		elseif key == "items" then
			i ,findpos = UpdateItemsInfo(condition,i,taskdata, check)
			table.cat(searchobj, findpos)
		--elseif key == "op" then
			--i = UpdateOpInfo(condition,i,taskdata,taskid)
		elseif key == "click" then
			i = UpdateClickInfo(condition,i,taskdata,taskid)
		elseif key == "us" then
			i = UpdateUSInfo(condition,i,taskdata,taskid)
		elseif key == "ei" then
			i = UpdateEIInfo(condition,i,taskdata,taskid)
		elseif key == "ug" then
			i, findpos = UpdateUGInfo(condition,i,taskdata,taskid)
			table.cat(searchobj, findpos)
 		elseif key == "area" and taskdata.完成条件.area.info ~= nil then
			local text
			if( saveTaskData.current ~= nil and saveTaskData.current[taskid]~=nil and saveTaskData.current[taskid]["area"] ~= nil ) then
				text = color_config.notready
			else
				text = color_config.ready
			end

			text = text .. taskdata.完成条件.area.info
			condition[i] = text
			i = i+1
		elseif key=="sl" then
			i = UpdateSLInfo(condition, i, taskdata, taskid)
		elseif key=="buff" then
			i = UpdateBuffInfo(condition, i, taskdata, taskid)
		elseif key=="tl" then
			i = UpdateTLInfo(condition, i, taskdata, taskid)
		elseif key=="npc" then
			i, findpos = UpdateNpcInfo(condition, i, taskdata, taskid)
			table.cat(searchobj, findpos)
		elseif key=='attr' then
			i = UpdateAttrInfo(condition, i, taskdata, taskid, check)
		elseif key=='tmc' then
			i = UpdateTMCInfo(condition, i, taskdata, taskid, check)			
		elseif key=='col' then
			i, findpos = UpdateCollectInfo(condition, i, taskdata, taskid)
			table.cat(searchobj, findpos)
		elseif key=='nu' then
			i, findpos = UpdateNUInfo(condition, i, taskdata, taskid)
			table.cat(searchobj, findpos)
		elseif key=='cap' then 
			i, findpos = UpdateCaptureMonsterInfo(condition, i, taskdata, taskid)
			table.cat(searchobj, findpos)
		elseif key=='me' then
			i, findpos = UpdateMapTriggerInfo(condition, i, taskdata, taskid)
			table.cat(searchobj, findpos)
		elseif key=='nc' then
			i, findpos = UpdateClickNPCInfo(condition, i, taskdata, taskid)
			table.cat(searchobj, findpos)
		end		
	end	
	
	if nil~=old_color_table then
		color_config = table.copy(old_color_table)
	end
	
	if condition[2] then
		--search obj = { type, id, region, x, y, name}
		return condition, searchobj
	else
		return {}
	end
end

function UpdateClickNPCInfo(condition, i, taskdata, taskid)
	local findobj = {}
	for k,npcid in pairs(taskdata.完成条件.nc) do
		local color = color_config.notready
		if TableHasKeys(saveTaskData, {"current", taskid, "nc", k}) then
			color = color_config.ready
		end
		local npc = 任务NPC配置表[ npcid ]
		local text = color .. "前往 <" .. npc.NpcCreate.name .. ">"
		table.push(findobj, {2, npcid, npc.NpcCreate.regionId, npc.NpcCreate.x, npc.NpcCreate.y, npc.NpcCreate.name} )
		condition[i] = text 
		i = i + 1
	end
	return i, findobj
end

function UpdateMapTriggerInfo(condition, i, taskdata, taskid)
	local findobj = {}
	
	for k,v in pairs(taskdata.完成条件.me) do
		local color = color_config.notready
		if TableHasKeys(saveTaskData, {"current", taskid, "me", k}) then
			color = color_config.ready
		end
		
		local regionName = tostring(v[1])
		if nil~=GetMapName then
			regionName = GetMapName(v[1])
		end

		local text = color .. "到 <" .. regionName .. "(" .. v[2] .."," .. v[3] .. ")>%0"
		condition[i] = text
		
		table.push(findobj, {2, npcid, v[1], v[2], v[3], regionName } )

		i = i+1		
	end
	
	return i, findobj
end

function UpdateNUInfo(condition, i, taskdata, taskid)
	local findobj = {}
	for k,v in pairs(taskdata.完成条件.nu) do
		local color
		if TableHasKeys(saveTaskData, {"current", taskid, "nu",k}) then
			color = color_config.ready
		else
			color = color_config.notready
		end
		
		local npcid = v[1]
		local name = "未知NPC id:" .. npcid
		if 任务NPC配置表[npcid] then
			local npcCreate = 任务NPC配置表[npcid].NpcCreate
			name = "<" ..npcCreate.name .. ">"
			table.push(findobj, {2, npcid, npcCreate.regionId, npcCreate.x, npcCreate.y, name } )
		end
		
		local goodname = GetGoodsName(v[2]) or ("物品" .. tostring(v[2]) )
		
		condition[i] = color ..  "对 " .. name .. " 使用 " .. goodname .. "%0"
		i = i + 1
	end
	
	return i, findobj
end

function UpdateCaptureMonsterInfo(condition, i, taskdata, taskid)
	local findobj = {}
	for k,v in pairs(taskdata.完成条件.cap) do
		local color = color_config.notready
		local count = 0
		if TableHasKeys(saveTaskData, {"current", taskid, "cap",k}) then
			count = saveTaskData.current[taskid].cap[k]
			if saveTaskData.current[taskid].cap[k] >= v[2] then
				color = color_config.ready
			end			
		end
		
		if count>v[2] then
			count = v[2]
		end
		
		local name = v[1]
		local pos = v[4]
		if type(pos)==type({}) then
			name = "<" .. name .. ">"
			table.push( findobj, {2, 0, pos[1], pos[2], pos[3], name } )
		end
		local goodname = GetGoodsName(v[3]) or ("物品" .. tostring(v[2]) )		
		condition[i] = colours.white .. "用 " .. goodname .. " 捕获 " .. name .. color.. " (" .. count .. "/" .. v[2] .. ")%0"
		
		i = i + 1
	end
	
	return i, findobj
end

function UpdateCollectInfo(condition, i, taskdata, taskid)
	local findobj = {}
	for k,npcid in pairs(taskdata.完成条件.col) do
		local color 
		if TableHasKeys(saveTaskData, {"current", taskid, "col",k}) then
			color = color_config.ready
		else
			color = color_config.notready
		end
		
		local name = "未知采集NPC id: " .. npcid
		if TableHasKeys(任务NPC配置表, {npcid, "NpcCreate", "name"} ) then
			local npcCreate = 任务NPC配置表[npcid].NpcCreate
			name = "<" .. npcCreate.name .. ">"
			table.push( findobj, {1, npcid, npcCreate.regionId, npcCreate.x, npcCreate.y, name })
		end
		condition[i] = color .. "进行 " .. name .. " 采集%0"
		i=i+1
	end
	return i, findobj
end

function TimeFormat(t)
	local s = t % 60
	local m = rint(t /60) % 60
	local h = rint(t/(60*60))
	return string.format("%d:%02d:%02d", h, m, s)
end

function GetCountDownInfo( taskInfo, taskid, key)
	local now = GetServerTime()
	local start
	if TableHasKeys(saveTaskData, {"current", taskid, "start"} ) then
		start = saveTaskData.current[taskid].start
		if TableHasKeys(taskInfo, "timeout", key ) then
			local lasttime = now - start
			local remain = taskInfo.timeout[key] - lasttime
			if remain< 0 then
				remain = 0
			end
			return TimeFormat(remain), remain, start
		end
	end
	return ""
end

function UpdateNpcInfo( condition, i, taskdata, taskid)
	function _checkNpcItem(npcid)
		local text = color_config.notready
		if TableHasKeys(saveTaskData, {"current", taskid, "npc", npcid} ) then
			text = color_config.ready
		end
		
		local npc = 任务NPC配置表[npcid]
		if npc then
			text = text .. "找到NPC <" .. npc.NpcCreate.name .. ">%0"
			return text, {1,npcid, npc.NpcCreate.regionId, npc.NpcCreate.x, npc.NpcCreate.y, npc.NpcCreate.name }
		end
	end
	
	local findobjs = {}
	local findNpc = taskdata.完成条件.npc
	if type({})==type(findNpc) then
		for _,v in pairs(findNpc) do
			local text, find = _checkNpcItem(v)
			if text then
				condition[i] = text
				table.push(findobjs, find)
				i = i + 1
			end
		end
	else
		local text, find = _checkNpcItem(findNpc)
		if text then
			condition[i] = text
			table.push(findobjs, find)
			i = i + 1
		end		
	end
	
	return i,findobjs
end

function UpdateTMCInfo(condition, i, taskdata, taskid, check)
	local teamCount = 0
	if check then
		 GetPlayerData( 35 )
	end
	
	local ok = 通用条件判断表.tmc(condtion)
	local text 
	if check and ok then
		text = color_config.ready
	else
		text = color_config.notready
	end
	
	local tmc = taskdata.完成条件.tmc
	
	if type({}) ==type(tmc) then
		text = text .. "组队人数( " .. teamCount .. "/  " .. tmc[1].. "-" .. tmc[2] .. ")之间%0"
	elseif type(0)==type(tmc) then
		text = text .. "组队人数 (" .. teamCount .. "/" .. tmc .. ")%0"
	end
	condition[i] = text
	
	i = i+1
	return i	
end

function UpdateAttrInfo(condition, i, taskdata, taskid, check)
	local attrs = taskdata.完成条件.attr
	for k,v in pairs(attrs) do
		local prop = PropertyTable[k]
		if prop then
			local text = color_config.notready
			if check then
				if GetPlayerData(prop[1])>=v then
					text = color_config.ready
				end
			end
			
			text = text .. prop[2] .. " " ..  v .. (prop[3] or "") .."%0"
			condition[i] = text
			i = i + 1
		end
	end
	return i
end

function UpdateTLInfo(condition, i, taskdata, taskid)
	local op = taskdata.完成条件.tl
	local opkey = "tl"

	local ret = i
	if op == nil then
		return ret
	end

	if type(op[1])==type({}) then
		for k,v in pairs(op) do
			local text		
			if TableHasKeys(saveTaskData.current, {taskid, opkey, v[1]}) then
				text = color_config.ready
			else
				text = color_config.notready
			end
			
			local name = GetTeleryName(v[1])
			if nil==name and __debug then
				name = "不存在id:" .. tostring(v[1])
			end

			text = "心法 " .. name .. " 等级到达 " .. text .. tostring(v[2]) .. "级%0"
			condition[ret] = text
			ret = ret +1
		end
	elseif type(op[1])==type(0) then
		local text		
		if TableHasKeys(saveTaskData.current, {taskid, opkey, op[1]}) then
			text = color_config.ready
		else
			text = color_config.notready
		end

		local name = GetTeleryName(op[1])
		if nil==name and __debug then
			name = "不存在id:" .. tostring(op[1])
		end
		
		text = "心法 " .. name .. " 等级到达 " .. text .. tostring(op[2]) .. "级%0"
		condition[ret] = text
		ret = ret +1
	end
	return ret
end

function UpdateSLInfo(condition,i,taskdata,taskid)
	local op = taskdata.完成条件.sl
	local opkey = "sl"

	local ret = i
	if op == nil then
		return ret
	end

	if type(op[1])==type({}) then
		for k,v in pairs(op) do
			local text
			
			if TableHasKeys(saveTaskData.current, {taskid, opkey, v[1]} ) then
				text = color_config.ready
			else
				text = color_config.notready
			end
			
			local name = GetSkillName( v[1])
			if nil==name and __debug then
				name = " 不存在ID: " .. tostring(v[1])
			end

			text =  "技能 " .. name .. " 等级到达 " .. text .. tostring(v[2]) .. "级%0"
			condition[ret] = text
			ret = ret +1
		end
	elseif type(op[1])==type(0) then
		local text			
		if TableHasKeys(saveTaskData.current, {taskid, opkey, op[1]}) then
			text = color_config.ready
		else
			text = color_config.notready
		end
		
		local name = GetSkillName( op[1])
		if nil==name and __debug then
			name = " 不存在ID: " .. tostring(op[1])
		end
		
		text =  "技能 " .. name .. " 等级到达 " .. text .. tostring(op[2]) .. "级%0"

		condition[ret] = text
		ret = ret +1		
	end
	return ret
end

function UpdateBuffInfo(condition,i,taskdata,taskid)
	local op = taskdata.完成条件.buff
	local opkey = "buff"

	local ret = i
	if op == nil then
		return ret
	end

	for k,v in pairs(op) do
		local text
		
		if TableHasKeys( saveTaskData.current , {taskid, opkey, v})  then
			text = color_config.ready
		else
			text = color_config.notready
		end

		text = text .. "需要BUFF " .. tostring(v)
		condition[ret] = text
		ret = ret +1
	end

	return ret
end

function UpdateClickInfo(condition,i,taskdata,taskid, check)
	local op = taskdata.完成条件.click
	local opkey = "click"

	local ret = i
	if op == nil then
		return ret
	end

	for k,v in pairs(op) do
		local text
		
		if TableHasKeys( saveTaskData.current , {taskid, opkey, k}) then
			text = color_config.ready
		else
			text = color_config.notready
		end
		
		if v == "pack" then
			text = text .. "打开包裹"
			condition[ret] = text
			ret = ret + 1
		elseif v == "state" then
			text = text .. "打开状态面板"
			condition[ret] = text
			ret = ret +1
		end
	end

	return ret
end

local FLY_BASE = 100000
local PROTECTED_BASE = 200000

function UpdateUSInfo(condition,i,taskdata,taskid)
	local op = taskdata.完成条件.us
	local opkey = "us"

	local ret = i
	if op == nil then
		return ret
	end

	for k,v in pairs(op) do
		local text
		if TableHasKeys( saveTaskData.current , {taskid, opkey, k}) then
			text = color_config.ready
		else
			text = color_config.notready
		end
		--[[
		if v == -1 then
			text = text .."使用轻功"
		else
		--]]
		local name
		if v<FLY_BASE then
			name = GetSkillName(v)
			text = text .. "使用技能 "
		elseif v>=FLY_BASE and v< PROTECTED_BASE then
			name = GetFlyName(v - FLY_BASE)
			text = text .. "使用轻功 "
		else
			name = GetProtectedName( v-PROTECTED_BASE)
			text = text .. "使用护体 "
		end
		
		if nil==name then
			if __debug then
				text = text .. "名不存在: ID" .. tostring(v)
			else
				text = text .. " ... "
			end
		else
			text = text .. name
		end
		--end
		condition[ret] = text
		ret = ret + 1
	end

	return ret
end

function UpdateUGInfo(condition,i,taskdata,taskid)
	local op = taskdata.完成条件.ug
	local opkey = "ug"

	local findobj = {}
	
	local ret = i
	if op == nil then
		return ret
	end

	for k,v in pairs(op) do
		local text
		if TableHasKeys( saveTaskData.current , {taskid, opkey, k}) then
			text = color_config.ready
		else
			text = color_config.notready
		end
		
		local name
		local pos 
		if type(v)==type(0) then
			name = GetGoodsName(v)
		elseif type(v)==type({}) then
			name = GetGoodsName(v[1])
			pos = "<场景" .. v[2] .. "(" .. v[3] .. "," .. v[4] .. ")> 附近" 
			table.push(findobj, {2, v[1], v[2], v[3], v[4], name })
		end
		if nil==name and __debug then
			name = " id:" .. tostring(v) .. "不存在" 
		end
		
		if pos then
			text = text .. "在 " .. pos .. " 使用物品 " .. name
		else
			text = text .. "使用物品 " .. name
		end
		
		condition[ret] = text
		ret = ret + 1
	end

	return ret, findobj
end

function UpdateEIInfo(condition,i,taskdata,taskid)
	local op = taskdata.完成条件.ei

	local ret = i
	if op == nil then
		return ret
	end

	for k,v in pairs(op) do
		local text
		if TableHasKeys( saveTaskData.current , {taskid, "ei", k}) then
			text = color_config.ready
		else
			text = color_config.notready
		end

		if type(0)==type(v) or (type(v)==type({}) and 1==#v) then
			local index = v
			if type(v)==type({}) then
				index = v[1]
			end

			local name = GetGoodsName(index)
			if nil==name and __debug then
				name = ' 装备ID:' .. index .. "不存在"
			end
			text = text .. "穿上装备" .. name
			condition[ret] = text
			ret = ret + 1
		elseif type({})==type(v) then
			text = text .. "穿上以下装备之一\n"
			for pos, eqid in pairs(v) do
				local name = GetGoodsName(eqid) or ("装备"..eqid)
				text = text .."     " ..name
				if pos~=#v then		--not last one
					text = text .. "\n"
				end
			end
			condition[ret] = text
		    ret = ret + 1
		end
	end

	return ret
end

--[[
function GetTargetPosition( t)
	assert(type(t) == type({}))

	local x, y, region = getplayercurpos()

	if type(t[1])~=type({}) then
	    if 4==#t and t[1]==region then
		return {t[2], t[3], t[4]}
	    elseif 3==#t then
		return  {t[1], t[2], t[3]}
	    else
		return
	    end
	end

	for k,v in pairs(t) do
	    if region ==v[1] then
		return {v[2], v[3], v[4]}
	    end
	end
end

--]]

function UpdateKillItem(taskdata, kill, taskid, check)
	local name = kill[1]
	local counter = kill[2]
	
	local killCount = 0
	if TableHasKeys(saveTaskData, {"current", taskid, "kill", name} ) then
		killCount  = saveTaskData.current[taskid].kill[name]
	end

	--bug
	if killCount>counter then
		killCount = counter
	end
	
	local text
	local countdowninfo = GetCountDownInfo( taskdata, taskid, "kill")
	if(killCount >= counter) then
		text = color_config.ready
		countdowninfo  = ""
	else
		text = color_config.notready
	end

	local targetpos
	if type(kill[3])==type({}) then
		targetpos = kill[3]
	end
		
	if check then	
		if nil~=targetpos then
			text = "已击败 <" .. name .. ">" .. text .. " (" ..tostring(killCount).."/"..tostring(counter)..")%0" .. countdowninfo
		else
			text = "已击败 " .. name ..  text .. " ("..tostring(killCount).."/"..tostring(counter)..")%0" .. countdowninfo
		end
	else
		text = "击败 " .. name .. colours.red .. ' (0/'.. counter .. ") %0"
	end
	
	if nil~=targetpos and check then
		return text, {2, 0, targetpos[1], targetpos[2], targetpos[3], name }
	else
		return text
	end
end

function UpdateKillInfo(condition, i, taskdata, taskid, check)	
	local kill = taskdata.完成条件.kill
	local findpos = {}
	local text
	local pos
		
	if type(kill[1])== type({}) then	
		for k2,v2 in pairs(kill) do

			text,pos = UpdateKillItem(taskdata, v2, taskid, check)
			if pos then
				table.push(findpos, pos)
			end
			
			condition[i] = text
			i = i+1

		end
	else
		text,pos = UpdateKillItem( taskdata, kill, taskid, check)
		if pos then
			table.push(findpos, pos)
		end		
		
		condition[i] = text
		i = i+1
	end

	if findpos~=nil and not table.empty(findpos) then
		return i,findpos
	end
	
	return i
end

function UpdateItemsInfo(condition,i,taskdata, check)
	local findobj= {}
	for k,v in ipairs(taskdata.完成条件.items) do
		local text
		
		local index = v[1]
		local items_name  = GetGoodsName(index)
		local items_count = GetGoodsCount(index)

		if nil==items_name then
			items_name = "Unkonw Item:" .. index
		end
		local items_total =v[2]

		if( items_count >= items_total ) then
			text = color_config.ready
		else
			text = color_config.notready
		end
		
		if items_count>items_total then
			items_count = items_total
		end

		local targetpos
		if type(v[3]) ==type({}) then
		    targetpos = v[3]
		end

		if targetpos and check then
		    items_name = "<" .. items_name .. ">"
		end
		 

		if check then
			text = tostring(items_name).. text .. " ("..tostring(items_count).."/".. tostring(items_total) .. ")%0"
		else
			text = tostring(items_name).. colours.red .. " (0/" .. tostring(items_total) .. ")%0"
		end
		if __debug and not items_name then
			text = "物品不存在ID:" .. tostring(index);
		end
		
		if(v[100] == nil ) then
			v[100] = items_count
		elseif( v[100] ~= items_count )	then
			RefreshNpcState()
			v[100] = items_count
		end

		condition[i] = text
		i = i+1

		if nil~=targetpos then
		    table.push(findobj, {3, index, targetpos[1], targetpos[2], targetpos[3], items_name} )
		end
		
	end

	return i, findobj
end

function GetAwardInfo(taskdata)
	local award = {[1] = "奖励:"}
	--i = 2
	for k,v in pairs(taskdata.完成奖励) do
		local key = tostring(k)
		
		if key=="giveGoods" and not table.empty(v) then		--构造奖励物品解析字符串
			local sGoods = ""
			--必得物品
			if ( v.give~=nil and not table.empty(v.give) ) then
				--<give>数量{},{},{},</give>
				sGoods = sGoods .. "<give>" .. tostring(#v.give)
				for kk,vv in pairs(v.give) do
					sGoods = sGoods .. "{" .. tostring(vv[1]) .. "," .. tostring(vv[2]) .. "},"
				end
				sGoods = sGoods .. "</give>"
			end
			
			--可以选物品
			if( v.options~=nil and not table.empty(v.options) ) then
				--<option>数量{},{},{},</option>
				sGoods = sGoods .. "<option>" .. tostring(#v.options)
				for kk,vv in pairs(v.options) do
					sGoods = sGoods .. "{" .. tostring(vv[1]) .. "," .. tostring(vv[2]) .. "},"
				end
				sGoods = sGoods .. "</option>"			
			end
			table.push(award, sGoods)
		elseif key == 'skill' then
			local skillText = "<skill>" .. tostring(#v)
			--<skill>id1,id2</skill>
			for _,sk in pairs(v) do
				skillText = skillText .. "{" .. sk[1] .. "," .. sk[2] .. "},"
			end
			skillText = skillText .. "</skill>"
			table.push(award, skillText)
		elseif key == "giveExp" then
			award.exp = v
		elseif key=="giveMoney" then
			award.money = v
		elseif key=="giveXYValue" then
			award.xyvalue = v
		end
	end
	
	if award[2] == nil then
		award[1] = nil
	end
	--rfalse("++++++++++++++++++++")
	--ST(award)
	return award
end

function GetUnRealStoryState( step)
	if TableHasKeys(UnrealStory, {UnrealNpcid, 1, "selection"} ) then
		local selection = UnrealStory[UnrealNpcid][1].selection
		for _, v in pairs(selection) do
			if step==v[2] then
				return v[3],v
			end
		end
	end
end

local superTaskId

function TalkDialog_Next(step)
	rfalse("step ===== "..tostring(step))
	if( UnrealStep ~= 0 ) then
			--local taskid = step
		local taskState, selection = GetUnRealStoryState(step)
		ST(selection)

		if( taskState == TASK_COMPLETED ) then -- 交任务
			local taskid = selection[4]
			local taskData = GetTaskConfig( taskid, saveTaskData )
			ShowTask(0,taskData.任务名称,taskData.任务说明,taskid,taskData.交任务npcid,nil,GetConditionInfo(taskid,taskData),GetAwardInfo(taskData))			
		elseif(taskState == TASK_CANACCEPT) then
			local taskid = selection[4]
			local taskData = GetTaskConfig( taskid, saveTaskData )
			SendToServer( { ids={1,1}, npcid = taskData.接任务npcid, taskid = taskid, type=1 } )
		elseif(taskState == TASK_CURR) then
			local taskid = selection[4]
			local taskData = GetTaskConfig( taskid, saveTaskData )
			SendToServer( { ids={1,1}, npcid = taskData.接任务npcid, taskid = taskid, type = 2 } )
		elseif( taskState==4) then
			SendToServer( {ids={2,2}, npcid=selection[4][3], taskid=selection[4][1]})
		elseif(taskState == TASK_FUNCTION) then
			rfalse("Send-------------------\n")
			SendToServer( { ids={1,1}, npcid = selection[4],  index = selection[5], type = 3 } )	
		end

		UnrealStep = 0
		TalkDialog_Cancel()
		return
	end
	
	if(step==0) then
		TalkDialog_Cancel()
		return
	end
	
	local story = storydata[step]

	local info      = story.info
	local selection = story.selection
	local task	    = story.task
	local npcclick  = story.npc

	if task ~= nil and ( task[1]>0 or (task[2]>0 and -1==task[1]) )then
		TalkDialog_Cancel()
		
		rfalse( task[1] .. "       " .. task[2] .. '\n')
		
		local taskid 
		if -1==(task[1]) then
			taskid = task[2]
		else		
		    taskid = GetTaskId(task[1],task[2]) 
		end
			
		local taskdata = GetTaskConfig(taskid, saveTaskData)
		
		rfalse ("task[1]="..tostring(task[1]).." task[2]="..tostring(task[2]))
		local condition = GetConditionInfo(taskid,taskdata, false)
		local award = GetAwardInfo(taskdata)

		local npcname = 任务NPC配置表[taskdata.交任务npcid].NpcCreate.name
		
		if task[3]==1 then
			superTaskId = taskid
		else
			superTaskId = nil		
		end
		
		if IsRingTask(taskid) then
			local dummyaward = {exp=0, money=0,xyvalue=0}
			ShowTask(1, taskdata.pre任务名称,taskdata.pre任务说明, taskid, taskdata.接任务npcid, npcname, {}, dummyaward, taskdata.nocancel)
		else
			ShowTask(1,taskdata.任务名称,taskdata.任务说明, taskid,taskdata.接任务npcid,npcname,condition,award, taskdata.nocancel)
		end
		return
	end

	local onClick = story.onClick
	if( onClick ~= nil ) then
		if isDaymanicTalk then
			SendToServer( { ids={1,9}, step = step, npcid = stroynpcid } )
		else
			SendToServer( { ids={3,1}, step = step, npcid = stroynpcid } )
		end

		TalkDialog_Cancel()
		return
	end

	local cg = story.cg
	if cg ~= nil then
		TalkDialog_Cancel()
		AutoRunScript(cg)
		if( story.selection~=nil ) then
			TalkDialog_Next(story.selection[1][2])
		end
		return
	end

	local onClientClick = story.onClientClick
	if(onClientClick~=nil) then
		rfalse("123------------------")

		_G[onClientClick]()
		
		if nil==selection then
			TalkDialog_Cancel()
			return
		end
	end
	
	if npcclick then
		SendToServer( {ids={2,2}, npcid=npcclick[1], taskid=npcclick[2]})
		TalkDialog_Cancel()
		return
	end
	
	if(info ~= nil) then
		ShowStory(info, storydata.npcimg, storydata.npcName,selection,1)
	end

end

function test()
	DrawSpr("sprshow0",20,20)
end

function TalkDialog_Cancel()
	isDaymanicTalk = nil
	stroynpcid = nil
	ShowStory()
end

function TaskDialog_Cancel()
	ShowTask()
end

function TaskDialog_Ok(taskType, taskNpcid, acceptTaskID, optionGoodId)
	if (taskType == 1) then		-- 接任务
		if superTaskId==acceptTaskID then
			SendToServer( { ids={1,2}, npcid = taskNpcid, taskid = acceptTaskID, super=1 } )
		else
			SendToServer( { ids={1,2}, npcid = taskNpcid, taskid = acceptTaskID } )	
		end
	elseif (taskType == 0) then		-- 交任务
		if type(optionGoodId)==type(0) then
			SendToServer( { ids={1,3}, npcid = taskNpcid, taskid = acceptTaskID, goodid = optionGoodId } )
		else
			SendToServer( { ids={1,3}, npcid = taskNpcid, taskid = acceptTaskID } )		
		end
	elseif (taskType == 2) then		-- 交副本任务
		SendToServer( { ids = {4, 1} } )
	end
	
	TaskDialog_Cancel()
end

function getRingInfo( taskid, widthtime )
	if IsRingTask(taskid) then
		local ringid = GetRingSubID(taskid)
		if TableHasKeys(saveTaskData, {"current", taskid}) then
			local counter = 1
            if TableHasKeys( saveTaskData, {"ring", "count"} ) then
                counter = saveTaskData.ring.count + 1
            end
			local text = "  " .. colours.green .. "第" .. tostring(counter) .. "环%0"		
			return text
		end
	end
	
	return ""
end


function MarkTaskTimeOut( taskInfo, taskid, finished)
	function _SendToMark(k)
		rfalse("MarkTaskTimeOut: " .. taskid .. "  " .. k)
		SendToServer( {ids={1,7}, taskid=taskid, key=k})
	end
	
	if taskInfo.timeout then
		for k,v in pairs(taskInfo.timeout) do
			if type(k)==type("") and 通用条件判断表[k] then
				if not TableHasKeys(saveTaskData,{"current", taskid,"to", k}) 
				  and 通用条件判断表[k]( taskInfo.完成条件[k], saveTaskData, taskid) then					
					_SendToMark(k)					
				end
			end
		end
		
		--[[
		if 1==finished and taskInfo.timeout[1] and not TableHasKeys(saveTaskData,{"current", taskid,"to", 1}) then
			_SendToMark(1)
		end
		--]]
	end
end

-- 返回任务用指引数据，目前只是临时使用，以后可能会替换为新的逻辑
local __time_timeout = GetServerTime()
g_specialTips = g_specialTips or {}

function GetTaskTips()
	local trackedTask= {}
	-- 如果在副本等特殊场景,通过配置表可以关闭任务追踪,转而显示特殊追踪信息
	local specialTips = g_specialTips or {}

	for _,v in pairs( specialTips ) do
		if type(v) == 'string' then
			table.push(trackedTask, {0,v} )
		end
	end

	--ST(specialTips)
	if #trackedTask > 0 then
		return trackedTask
	end
	
	-- 通过saveTaskData获取当前正在执行的任务，同时通过【任务表】，构建任务指引数据！
	
	--  加载本lua文件时已经保证了
	assert( saveTaskData ~= nil )
	--[[
	if saveTaskData == nil then
		return "任务数据为空"
	end
	--]]
	local checktime = false
	if GetServerTime()- __time_timeout > 1 then
		__time_timeout = GetServerTime()
		checktime = true
	end
	
	if saveTaskData.current ~= nil and not table.empty( saveTaskData.current ) then
		for taskid,v in pairs( saveTaskData.current ) do
			if v.track and v.track==1 then
				local tips = colours.white
				
				local taskInfo = GetTaskConfig(taskid, saveTaskData )

				local condition, findobjs = GetConditionInfo(taskid,taskInfo)
				local clickObjs={}
	
				local actionIndex
				local ringInfo = ""
				if IsRingTask(taskid) then		--跑环任务
					actionIndex = ringCouldComplted(taskid, saveTaskData)
					if actionIndex then
						actionIndex = 1
						ringInfo = getRingInfo(taskid, false)
					else
						ringInfo = getRingInfo(taskid, true)
					end
					
				else				
					actionIndex = 通用条件判断表.CheckConditions(taskInfo.完成条件,saveTaskData,taskid)
				end
								
				--主动放弃超时任务
				if checktime then 
					if not 通用条件判断表.CheckTimeout(taskInfo, taskid, saveTaskData)  then
						dropTask(taskid)
					else
						MarkTaskTimeOut(taskInfo, taskid, actionIndex)
					end
				end

				local timeoutTip = ""
				if nil~=taskInfo.timeout and nil~= taskInfo.timeout[1] then
					timeoutTip = GetCountDownInfo(taskInfo, taskid, 1) .. "后超时" or ""
				end
				
				if actionIndex == 1 or saveTaskData.current[taskid].state ~= nil then
					local _, delayInfo = GetTaskDelayInfo(taskInfo, taskid)
					tips = tips ..colours.green .. "- <!" .. tostring( taskInfo.任务名称 ) .. "（已完成）>%0" .. ringInfo.. "  " ..delayInfo .. " ".. timeoutTip .."\r\n"
					table.push(clickObjs, {0, taskid, 0, 0, 0, tips})
					
					local taskData = GetTaskConfig(taskid, saveTaskData)
					
					local npc = 任务NPC配置表[taskData.交任务npcid]		
					tips = tips .. colours.yellow .. "  任务回复:" .. colours.yellow .. "<".. npc.NpcCreate.name .. ">%0\r\n"
					--					   --{类型, id, region, x, y, name}
					table.push( clickObjs, {1,taskData.交任务npcid, npc.NpcCreate.regionId, npc.NpcCreate.x, npc.NpcCreate.y, npc.NpcCreate.name } )
					table.cat( clickObjs, findobjs)
				else
					tips = tips .. colours.yellow .. "- <!" .. tostring( taskInfo.任务名称 ) .. ">%0" .. ringInfo .. " ".. timeoutTip .. " \r\n"
					table.push(clickObjs, {0, taskid, 0, 0, 0, tips})
					for k2,v2 in pairs(condition) do
						if( k2 ~= 1) then
							tips = tips.. "  " .. colours.white .. "-%0 "..tostring(v2).."\r\n"
						end
					end
					table.cat( clickObjs, findobjs)
				end
				
				table.push(trackedTask, {taskid, tips, clickObjs } )	
			end
		end
	end
	
	UpdateRing()
	
	return trackedTask
end

function CheckAreaTask(regionid)
	if saveTaskData == nil or saveTaskData.current == nil then
		return 
	end

	for k,v in pairs(saveTaskData.current) do
		local taskid = k
		if saveTaskData.current[taskid] ~= nil then
			if not IsRingTask(taskid) then
				local taskinfo = GetTaskConfig(taskid, saveTaskData)
				local area = taskinfo.完成条件.area
				local npcid = taskinfo.交任务npcid
				if ( area ~= nil and regionid == area[1]  and saveTaskData.current[taskid]["area"]==nil ) then
					SendToServer( { ids={1,4}, npcid = npcid, taskid = taskid,opkey="area"} )
					RefreshOneNpcState(npcid)
				end
			end
		end
	end
end

-- NPC 查询函数
function GetNpcInfoById( id )
	return 任务NPC配置表[id].NpcCreate
end


function GetNpcInfoByName( name )
	--rfalse("Try to get NPCInfo By Name:" .. tostring(name) )
	if( type(name)~=type('')) then
		return nil
	end
	
	for k,v in pairs(任务NPC配置表) do
		if v.NpcCreate and v.NpcCreate.name and v.NpcCreate.name==name then
			return k, v.NpcCreate	--NPC ID, NPC信息表
		end
	end	
	return nil
end


-- 任务 查询函数
function GetTaskInfo(taskid)
	local taskData = GetTaskConfig(taskid, saveTaskData)
	if taskData~=nil then
		-- 任务状态  1:完成, 2:已接
		taskData.状态 = 0	
		if saveTaskData.current then
			if saveTaskData.current[taskid]~=nil then
				taskData.状态 = 2
			elseif saveTaskData.completed[taskid]~=nil then
				taskData.状态 = 1	
			end
		end
		--位置信息
		taskData.findpos = {}
		
		--任务描述信息寻路
		
		--接任务npc
		--{类型, id, region, x, y, name}
		if nil~=taskData.接任务npcid then
			local npc = 任务NPC配置表[taskData.接任务npcid]
			table.push(taskData.findpos, {1, taskData.交任务npcid, npc.NpcCreate.regionId, npc.NpcCreate.x, npc.NpcCreate.y, npc.NpcCreate.name})
		end
		
		--交任务npc
		local npc = 任务NPC配置表[taskData.交任务npcid]
		table.push(taskData.findpos, {1, taskData.交任务npcid, npc.NpcCreate.regionId, npc.NpcCreate.x, npc.NpcCreate.y, npc.NpcCreate.name})

		local _, findobjs = GetConditionInfo(taskid,taskData)
		table.cat(taskData.findpos, findobjs)
		
		return taskData
	end
	return nil
end

-- 主角当前的任务表 { {任务ID,任务状态}, {任务ID,任务状态}, ...}
function GetCurrentAcceptTask()	
	if saveTaskData==nil or saveTaskData.current==nil or table.empty(saveTaskData.current) then
		--return {{100002,2}, {100001,2} } --for test
		return {}
	end
	
	local taskIdsTable = {}
	for k,v in pairs(saveTaskData.current) do
		--完成状态	 0:未完成 1:完成
		local taskData = GetTaskConfig(k, saveTaskData)
		local actionIndex, failInfo = 通用条件判断表.CheckConditions(taskData.完成条件,saveTaskData,k)
		
		local taskstate = false
		if 1==actionIndex or v.state ~= nil then
			taskstate = true
		end
		
		--追踪状态
		local tracked = false
		if v.track and v.track==1 then
			tracked = true
		end
		
		table.push( taskIdsTable, {k, taskstate, tracked} )	--{k, 0} == {任务ID,任务完成状态,追踪状态}
	end
	return taskIdsTable
end

function IsTaskCompleted(taskid)
	if taksid and saveTaskData.completed then
		for k in pairs(saveTaskData.completed) do
			if k==taskid then
				return 1	--true
			end
		end
	end
	
	return 0	--false
end

function GetNPCAcceptTasks(npcid)
	local _,result = GetNPCState(npcid)	
	local ret = {}
	if result~=nil then
		for _,v in pairs(result) do
			if v[2]==2 then
				table.push(ret,v[1])
			end
		end
	end
		
	return ret
end

function GetTaskData(taskid)
	local taskData = GetTaskConfig(taskid, saveTaskData)
	if nil~=taskData then				
		local taskName = taskData.任务名称
		--if taskData.接受条件.level then
		--	taskName = "[" .. taskData.接受条件.level  .. "]" .. taskName
		--end
		
		local award = GetAwardInfo(taskData)
		local money = 0
		if nil~=award.money then
			money = award.money
		end
		
		local exp = 0
		if nil~=award.exp then
			exp = award.exp
		end
		
		local xyvalue = 0
		if nil~=award.money then
			xyvalue = award.xyvalue
		end
		
		return {taskName,taskData.任务说明,taskid,taskData.接任务npcid, taskData.交任务npcid, GetConditionInfo(taskid,taskData),award, exp, money, xyvalue}
	end
end

function GetKillMonsterInfo( monster)
	function GetKillCounter( taskid, monster)
	    local taskData = GetTaskConfig( taskid, saveTaskData )
	    if nil~=taskData then
            local kill = taskData.完成条件.kill 
            if type(kill[1])==type({}) then
                for _,v in pairs(kill) do
                    if v[1]==monster then
                        return v[2]
                    end
                end
            else
                if kill[1] == monster then
                    return kill[2]
                end
            end
	    end
	end

	for k,v in pairs(saveTaskData.current) do
	    if nil~=v.kill then
			for monsterName, killedCounter in pairs(v.kill) do
				if monsterName==monster then
					local counter = GetKillCounter(k, monster)
					if counter then
						if killedCounter==counter and counter == 1  then
							return "已击败 " .. monster
						elseif killedCounter==counter then
							return "已击败 " .. monster .. " " .. tostring(killedCounter) .. "/" .. tostring(counter)
						elseif killedCounter<counter then
							return "已击败 " .. monster .. " " .. tostring(killedCounter) .. "/" .. tostring(counter)	
						end
					end
					break
				end
			end
	    end
	end
end

local __time = GetServerTime()
function UpdateRing()
	if GetServerTime()-__time>3 then
		local _, need = ringRefresh(saveTaskData, 1)
		if need then
		    rfalse("NeedSend..  " .. GetServerTime() .. "   " .. __time .. "   " ..(GetServerTime()-__time) .. "\n")
		    SendToServer( { ids={2,3} } )
		end
		__time = GetServerTime()
	end
end


function GetTaskDelayInfo( taskInfo, taskid )
	if taskInfo.完成延时 and TableHasKeys(saveTaskData, {"current", taskid, "start"}) then
		local now = GetServerTime()
		local remain = taskInfo.完成延时  -( now- saveTaskData.current[taskid].start)

		if remain <0 then
			return true, ""
		else
			return false,  TimeFormat(remain).." 后可交"
		end
	end
	
	return true, ""
end

function OnCGPlayEnd( cgId )
	rfalse("CG END  " .. cgId .. " \n" )
	if TableHasKeys(CG完成配置, cgId) then
		local conf = CG完成配置[cgId]

		function _handel( c )
			if type(c)==type(0) then
				if nil==剧情表[c] then
					rfalse("CG完成剧情配置出错，不存在"..storyid .. "剧情")
				end
				
				storydata = 剧情表[storyid]
				isDaymanicTalk = nil
				TalkDialog_Next(1)
			elseif type('') == type(c) then
				SendToServer( { ids={3,2}, cgid=cgId, f=c} )
			end

		end
		
		_handel(conf[1])
		_handel(conf[2])		
	end
end


