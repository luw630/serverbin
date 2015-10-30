rfalse("task loading")

initToObjItems()

if ( msgDispatcher == nil ) then
	msgDispatcher = {
		[1] = {},	-- ���������
		[2] = {},	-- CG���
		[3] = {}, 	-- �������
		[4] = {}, 	-- �������
		[5] = {}, 	-- ����
		[6] = {}, 	-- װ������ű����    jym
	}
end

UnrealStory = {}

--[[
function RPC_Call(data)
	if(data == nil or type(data)~='table' or #data < 1 or type(data[1])~='string') then
		rfalse("�������ø�ʽ����")
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
			npcimg = ����NPC���ñ�[npcid].NpcCreate.npcimg,
			[1] = { info= ����NPC���ñ�[npcid].NpcInfo.talk, selection ={ {"��������� " .. taskinfo.��������,2}, {"�˳�",0} } },
			[2] = { npc = {npcid,taskid}, },
		}
	return _t
end

function InsertClickNpcStory( result, npcid )
	if saveTaskData.current then
		for taskid in pairs(saveTaskData.current) do
			if IsRingTask(taskid) then
				local ringid,subid = GetRingSubID(taskid)
				local mainid = �ܻ��������ñ�[ringid].�������
				if TableHasKeys(�ܻ������, {mainid, subid}, 2 ) and 2==�ܻ������[mainid][subid][1] then
					local npcfind = �ܻ������[mainid][subid][2]
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

function ��������( npcid, ringid )
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
					taskid	= nil 	--����ɵľͲ����ͬ���͵Ŀɽ�
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

	local npcInfo   = ����NPC���ñ�[npcid]
	local npcstate,result = GetNPCState(npcid)
	
	result = _preHandleRingTasks(npcid, result, ringid )
	InsertClickNpcStory(result, npcid)
		
	UnrealStory[npcid] = {}
	UnrealStory[npcid].npcimg = ����NPC���ñ�[npcid].NpcCreate.npcimg 

	if result == nil then
		ShowStory(����NPC���ñ�[npcid].NpcInfo.talk,����NPC���ñ�[npcid].NpcCreate.npcimg,����NPC���ñ�[npcid].NpcCreate.name,{{"�˳�",0}},1)
	elseif #result == 0 and saveTaskData.current~=nil then
		local isTaskNpc
		for k,v in pairs(saveTaskData.current) do
			local taskid = k
			local taskData = GetTaskConfig(taskid, saveTaskData)	

			if npcid == taskData.������npcid then
				local actionIndex= ͨ�������жϱ�.CheckConditions(taskData.�������,saveTaskData,taskid)
				if(actionIndex ~= 1) then -- δ��ɲŴ������飬����ɵ�δ����ʾnpcĬ�϶Ի�
					SendToServer( { ids={1,1}, npcid = npcid, taskid = taskid, type = 2 } )
					isTaskNpc = 1
				end
				break
			end
		end
		if isTaskNpc==nil then -- ��npc��δ�������� �� ��������ɵ�δ��
			ShowStory(����NPC���ñ�[npcid].NpcInfo.talk,����NPC���ñ�[npcid].NpcCreate.npcimg,����NPC���ñ�[npcid].NpcCreate.name,{{"�˳�",0}},1)
		end
	elseif #result == 1 then
		local taskid = result[1][1]
		local taskData = GetTaskConfig(taskid, saveTaskData)	

		-- һ����������ʱ��Ĵ���ֱ�Ӵ�����
		if result[1][2] == 2 then
			-- ����������ľ��飡
			SendToServer( { ids={1,1}, npcid = npcid, taskid = taskid, type = 1 } )
		elseif result[1][2] == 3 then
			-- ������������壡
			ShowTask(0,taskData.��������,taskData.����˵��,taskid,taskData.������npcid,nil,GetConditionInfo(taskid,taskData),GetAwardInfo(taskData))			

		elseif result[1][2] == 1 then
			-- ��������δ���ʱ�ľ��飡
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
		UnrealStory[npcid].info =  ����NPC���ñ�[npcid].NpcInfo.talk
		UnrealStory[npcid][1] = {}
		UnrealStory[npcid][1].selection = {}

		for k,v in pairs(result) do
			index = #UnrealStory[npcid][1].selection + 1
			local step = index + 1
			
			if v[2]==TASK_CURR or  v[2]==TASK_CANACCEPT  or v[2]==TASK_COMPLETED then
				local taskid =v[1] 							
				local taskConf = GetTaskConfig(taskid, saveTaskData)
				local taskname = taskConf.��������

				if v[2] == 3 then
					UnrealStory[npcid][1].selection[index] = {taskname.."(�����)", step, TASK_COMPLETED, taskid}
				elseif v[2] == 2 then
					UnrealStory[npcid][1].selection[index] = {taskname.."(�ɽ�����)", step, TASK_CANACCEPT, taskid}
				elseif v[2] == 1 then
					UnrealStory[npcid][1].selection[index] = {taskname.."(δ���)", step, TASK_CURR, taskid}				
				elseif v[2]==4 then
					UnrealStory[npcid][1].selection[index] = {"��ɵ��NPC����", step, 4, taskid, v}
				end
			elseif v[2]==TASK_FUNCTION  then
				local FunItem = ����NPC���ñ�[npcid]. NpcFunction[v[1]]
				UnrealStory[npcid][1].selection[index] = {FunItem[2], step, TASK_FUNCTION, npcid, v[1]}
			end
			
			--rfalse("UnrealStory npcid:  " .. npcid .. "\n")

			index = index + 1
		end
		UnrealStory[npcid][1].selection[index] = {"�˳�",0}
		if ����NPC���ñ�[npcid].�ֿ� ~= nil then
			UnrealStory[npcid][1].selection[index+1] = {����NPC���ñ�[npcid].�ֿ�.info,index}
		end
		
		ShowStory(UnrealStory[npcid].info,UnrealStory[npcid].npcimg,UnrealStory[npcid].npcName,UnrealStory[npcid][1].selection, 1)
	end
end

msgDispatcher[1][1] = function ( playerid, msg )
	rfalse("�ͻ��˵����npc...")
	UnrealStory = {}

	local npcid     = msg.npcid
	local state = GetNpcNcState( npcid, saveTaskData)
	if state==NC_STORY then
		��������(npcid, msg.ringid)		
	elseif state==NC_CLICK or state==NC_COLLECT then
		SendToServer( { ids = { 1, 8 }, npcid = npcid } )
	end
end

local isDymanicTalk
storydata = {}
local stroynpcid = nil
msgDispatcher[1][2] = function ( playerid, msg )
	rfalse("�յ����������Ϣ...")
	storydata = msg.data
	stroynpcid = msg.npcid

	isDaymanicTalk = msg.dyn

	TalkDialog_Next(1)
end

msgDispatcher[1][3] = function ( playerid, msg )
	rfalse("�յ�����׷����Ϣ:����id" .. tostring(msg.taskid) )
	local taskid = msg.taskid
		
	if saveTaskData.current and saveTaskData.current[taskid] then
		if msg.op == 1 then
			saveTaskData.current[taskid].track = 1	--nil:ȡ������ 1: �������� || true or false
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
	
	--�ܻ������ݲ�֧�� �ͷ��˽���/����¼�
	if IsRingTask(taskid) then
		return
	end
	
	local mainid, subid = GetSubID(taskid)
	local task = �����[mainid][subid]
    if msg.data.accept then
	    rfalse("�յ���������")
	    local events = task.�ͷ��˽����¼�
	    if nil ~= events then
			callTableFuncs(events)
		    TaskAcceptNotify(taskid)
	    end
	else	
	    rfalse("�յ����������Ϣ")

	    local events = task.�ͷ�������¼�
	    if nil ~= events then
			callTableFuncs(events)
	    end
	    
	    local goodid = msg.data.good
	    TaskCompletedNotify(taskid, goodid)
	end    
end

--�ɼ����
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
	
	--NPC��Ч
end

msgDispatcher[2][1] = function ( playerid, msg )
	 AutoRunScript(msg.cg)
end

-- ���������֪ͨ�ͻ�����ʾ�����������ڵ���Ϣ
msgDispatcher[3][1] = function ( playerid, msg )
	rfalse('55555555')
	local awardInfo = msg.awardInfo
	local taskID = msg.taskID
	rfalse(taskID)
	local copySceneConfig = ��������[taskID]
	rfalse('ddfddfdfdfdf')
	if copySceneConfig == nil then
		ShowTask(2, '���ô���', '���ô���', nil, nil, nil, nil, GetAwardInfo(awardInfo))
	else
		ShowTask(2, copySceneConfig.��������, copySceneConfig.�������, nil, nil, nil, nil, GetAwardInfo(awardInfo),nil)
	end
end

-- ֪ͨ��ʾǿ�ƽ��븱��ȷ�ϴ���
msgDispatcher[3][2] = function ( playerid, msg )
	ShowConfirmDialog(msg.Desc, msg.cbOkName, msg.PlayerSID)
end

-- ��ʾMessageBox
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

-- ��ʾ��ʾ��Ϣ   jym
msgDispatcher[6][1] = function ( playerid, msg )
	--rfalse("����:"..tostring(msg.handle))
	ShowConfirmDialog(msg.Desc, msg.cbOkName, msg.type)
end


function DJ_ClientConfirmDoIt( Type )
	--rfalse("����:"..tostring(Handle))
	SendToServer( { ids = { 11, 1 }, ['type'] = Type } )
end

-- ##############�ͻ����߼�����#########################

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

--��ʼ��npc�ɽӡ����ɽ������
npc2task = {}
function InitNpc2Task(npcid) 
	if( npcid < 0 or npc2task[npcid] ~= nil ) then
		return
	end

	for k1,v1 in pairs(�����) do	
		--for k2,v2 in ipairs(v1) do
		for k2,v2 in pairs(v1) do
            if type(k2)==type(0) then		
                if( npcid == v2.������npcid ) then
                    local taskid = GetTaskId( k1,k2)
                    if( npc2task[npcid] == nil ) then
                        npc2task[npcid] = {}
                    end
                    local aTask = {taskid,0}
                    npc2task[npcid][#npc2task[npcid]+1] = aTask
                end

                if( npcid == v2.������npcid ) then
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
	
	local _fastCompleted = {}	--�����ж������Ƿ������
		
	--�������
	if saveTaskData.current then
		for taskid,_ in pairs(saveTaskData.current) do
			if IsRingTask(taskid) and ringCouldComplted(taskid, saveTaskData) then
				local taskinfo = GetTaskConfig(taskid, saveTaskData)
				if taskinfo.������npcid == npcid then
					table.push( completed, taskid )
					local ringId = GetRingSubID(taskid)
					_fastCompleted[ringId] = true
				end
			end
		end
	end
	
	--�ɽ�����
	local ok,ringId = ringCouldAccept(npcid, saveTaskData, 1)
	if ok and nil==_fastCompleted[ringId] then
		table.push( canAccept, GetRingTaskId(ringId,0) )
	end
		
	return completed, canAccept, curr
end

-------------------------

function GetNPCFunction(npcid)	
	if not TableHasKeys(����NPC���ñ�, {npcid, "NpcFunction" }) then
		return {}
	end

	local result = {}
	local NPCFun = ����NPC���ñ�[npcid].NpcFunction	
	for k,v in pairs(NPCFun) do
		if type(v[3]) == type({}) then
			local actionIndex = ͨ�������жϱ�.CheckConditions(v[3],saveTaskData,0)
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
            
            
            --���ж��Ƿ������������
            
            if( curTask~= nil and v[2] == 1 ) then --������npc
                local actionIndex
                local failInfo
                actionIndex, failInfo = ͨ�������жϱ�.CheckConditions(taskInfo.�������,saveTaskData,taskid)
                if(actionIndex == 1) then
					local notTimeout = ͨ�������жϱ�.CheckTimeout(taskInfo, taskid, saveTaskData)
					local notDelay = ͨ�������жϱ�.checkTaskDelay(taskInfo, taskid, saveTaskData)
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
            
            if( curTask == nil and v[2] == 0 and saveTaskData.completed[taskid] == nil ) then -- ������npc
                local actionIndex
                local failInfo
                actionIndex, failInfo = ͨ�������жϱ�.CheckConditions(taskInfo.��������,saveTaskData,taskid)
                if(actionIndex == 1) then
                    canAccept[#canAccept+1] = taskid
                end
            end

        end
     end
	
	--�ܻ�����
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
	--��ʱ
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

-- ע�⣬��Ϣ��������ע����ھ���Ĺ��ܽű���ߡ�����

-- �ͻ���ֱ�ӷ���һ��table������msg�ǿͻ��˽ű�ϵͳ�У�ֱ�����л��õ���Ϣ
-- ��Ϣ������Ҫ������ϢID���У����ڶ�Ӧ��Ϣ����ű�����
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
		local taskdata = �����[task[1]][task[2]]
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
	
	--checkĬ��Ϊtrue
	if check==nil then
		check = true
	end
	
	if not check then
		old_color_table = table.copy(color_config)
		--color_config = { ready = "", notready=""}
		color_config = { ready = colours.red, notready=colours.red }
	end
	
	local condition = {[1]="Ŀ��:"}
	--///////////////////////////////
	local searchobj = {}
	--///////////////////////////////
	local i = 2
	for k,v in pairs(taskdata.�������) do		
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

			text = text.."�ȼ��ﵽ"..tostring(v).."��"
				
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
 		elseif key == "area" and taskdata.�������.area.info ~= nil then
			local text
			if( saveTaskData.current ~= nil and saveTaskData.current[taskid]~=nil and saveTaskData.current[taskid]["area"] ~= nil ) then
				text = color_config.notready
			else
				text = color_config.ready
			end

			text = text .. taskdata.�������.area.info
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
	for k,npcid in pairs(taskdata.�������.nc) do
		local color = color_config.notready
		if TableHasKeys(saveTaskData, {"current", taskid, "nc", k}) then
			color = color_config.ready
		end
		local npc = ����NPC���ñ�[ npcid ]
		local text = color .. "ǰ�� <" .. npc.NpcCreate.name .. ">"
		table.push(findobj, {2, npcid, npc.NpcCreate.regionId, npc.NpcCreate.x, npc.NpcCreate.y, npc.NpcCreate.name} )
		condition[i] = text 
		i = i + 1
	end
	return i, findobj
end

function UpdateMapTriggerInfo(condition, i, taskdata, taskid)
	local findobj = {}
	
	for k,v in pairs(taskdata.�������.me) do
		local color = color_config.notready
		if TableHasKeys(saveTaskData, {"current", taskid, "me", k}) then
			color = color_config.ready
		end
		
		local regionName = tostring(v[1])
		if nil~=GetMapName then
			regionName = GetMapName(v[1])
		end

		local text = color .. "�� <" .. regionName .. "(" .. v[2] .."," .. v[3] .. ")>%0"
		condition[i] = text
		
		table.push(findobj, {2, npcid, v[1], v[2], v[3], regionName } )

		i = i+1		
	end
	
	return i, findobj
end

function UpdateNUInfo(condition, i, taskdata, taskid)
	local findobj = {}
	for k,v in pairs(taskdata.�������.nu) do
		local color
		if TableHasKeys(saveTaskData, {"current", taskid, "nu",k}) then
			color = color_config.ready
		else
			color = color_config.notready
		end
		
		local npcid = v[1]
		local name = "δ֪NPC id:" .. npcid
		if ����NPC���ñ�[npcid] then
			local npcCreate = ����NPC���ñ�[npcid].NpcCreate
			name = "<" ..npcCreate.name .. ">"
			table.push(findobj, {2, npcid, npcCreate.regionId, npcCreate.x, npcCreate.y, name } )
		end
		
		local goodname = GetGoodsName(v[2]) or ("��Ʒ" .. tostring(v[2]) )
		
		condition[i] = color ..  "�� " .. name .. " ʹ�� " .. goodname .. "%0"
		i = i + 1
	end
	
	return i, findobj
end

function UpdateCaptureMonsterInfo(condition, i, taskdata, taskid)
	local findobj = {}
	for k,v in pairs(taskdata.�������.cap) do
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
		local goodname = GetGoodsName(v[3]) or ("��Ʒ" .. tostring(v[2]) )		
		condition[i] = colours.white .. "�� " .. goodname .. " ���� " .. name .. color.. " (" .. count .. "/" .. v[2] .. ")%0"
		
		i = i + 1
	end
	
	return i, findobj
end

function UpdateCollectInfo(condition, i, taskdata, taskid)
	local findobj = {}
	for k,npcid in pairs(taskdata.�������.col) do
		local color 
		if TableHasKeys(saveTaskData, {"current", taskid, "col",k}) then
			color = color_config.ready
		else
			color = color_config.notready
		end
		
		local name = "δ֪�ɼ�NPC id: " .. npcid
		if TableHasKeys(����NPC���ñ�, {npcid, "NpcCreate", "name"} ) then
			local npcCreate = ����NPC���ñ�[npcid].NpcCreate
			name = "<" .. npcCreate.name .. ">"
			table.push( findobj, {1, npcid, npcCreate.regionId, npcCreate.x, npcCreate.y, name })
		end
		condition[i] = color .. "���� " .. name .. " �ɼ�%0"
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
		
		local npc = ����NPC���ñ�[npcid]
		if npc then
			text = text .. "�ҵ�NPC <" .. npc.NpcCreate.name .. ">%0"
			return text, {1,npcid, npc.NpcCreate.regionId, npc.NpcCreate.x, npc.NpcCreate.y, npc.NpcCreate.name }
		end
	end
	
	local findobjs = {}
	local findNpc = taskdata.�������.npc
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
	
	local ok = ͨ�������жϱ�.tmc(condtion)
	local text 
	if check and ok then
		text = color_config.ready
	else
		text = color_config.notready
	end
	
	local tmc = taskdata.�������.tmc
	
	if type({}) ==type(tmc) then
		text = text .. "�������( " .. teamCount .. "/  " .. tmc[1].. "-" .. tmc[2] .. ")֮��%0"
	elseif type(0)==type(tmc) then
		text = text .. "������� (" .. teamCount .. "/" .. tmc .. ")%0"
	end
	condition[i] = text
	
	i = i+1
	return i	
end

function UpdateAttrInfo(condition, i, taskdata, taskid, check)
	local attrs = taskdata.�������.attr
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
	local op = taskdata.�������.tl
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
				name = "������id:" .. tostring(v[1])
			end

			text = "�ķ� " .. name .. " �ȼ����� " .. text .. tostring(v[2]) .. "��%0"
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
			name = "������id:" .. tostring(op[1])
		end
		
		text = "�ķ� " .. name .. " �ȼ����� " .. text .. tostring(op[2]) .. "��%0"
		condition[ret] = text
		ret = ret +1
	end
	return ret
end

function UpdateSLInfo(condition,i,taskdata,taskid)
	local op = taskdata.�������.sl
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
				name = " ������ID: " .. tostring(v[1])
			end

			text =  "���� " .. name .. " �ȼ����� " .. text .. tostring(v[2]) .. "��%0"
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
			name = " ������ID: " .. tostring(op[1])
		end
		
		text =  "���� " .. name .. " �ȼ����� " .. text .. tostring(op[2]) .. "��%0"

		condition[ret] = text
		ret = ret +1		
	end
	return ret
end

function UpdateBuffInfo(condition,i,taskdata,taskid)
	local op = taskdata.�������.buff
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

		text = text .. "��ҪBUFF " .. tostring(v)
		condition[ret] = text
		ret = ret +1
	end

	return ret
end

function UpdateClickInfo(condition,i,taskdata,taskid, check)
	local op = taskdata.�������.click
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
			text = text .. "�򿪰���"
			condition[ret] = text
			ret = ret + 1
		elseif v == "state" then
			text = text .. "��״̬���"
			condition[ret] = text
			ret = ret +1
		end
	end

	return ret
end

local FLY_BASE = 100000
local PROTECTED_BASE = 200000

function UpdateUSInfo(condition,i,taskdata,taskid)
	local op = taskdata.�������.us
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
			text = text .."ʹ���Ṧ"
		else
		--]]
		local name
		if v<FLY_BASE then
			name = GetSkillName(v)
			text = text .. "ʹ�ü��� "
		elseif v>=FLY_BASE and v< PROTECTED_BASE then
			name = GetFlyName(v - FLY_BASE)
			text = text .. "ʹ���Ṧ "
		else
			name = GetProtectedName( v-PROTECTED_BASE)
			text = text .. "ʹ�û��� "
		end
		
		if nil==name then
			if __debug then
				text = text .. "��������: ID" .. tostring(v)
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
	local op = taskdata.�������.ug
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
			pos = "<����" .. v[2] .. "(" .. v[3] .. "," .. v[4] .. ")> ����" 
			table.push(findobj, {2, v[1], v[2], v[3], v[4], name })
		end
		if nil==name and __debug then
			name = " id:" .. tostring(v) .. "������" 
		end
		
		if pos then
			text = text .. "�� " .. pos .. " ʹ����Ʒ " .. name
		else
			text = text .. "ʹ����Ʒ " .. name
		end
		
		condition[ret] = text
		ret = ret + 1
	end

	return ret, findobj
end

function UpdateEIInfo(condition,i,taskdata,taskid)
	local op = taskdata.�������.ei

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
				name = ' װ��ID:' .. index .. "������"
			end
			text = text .. "����װ��" .. name
			condition[ret] = text
			ret = ret + 1
		elseif type({})==type(v) then
			text = text .. "��������װ��֮һ\n"
			for pos, eqid in pairs(v) do
				local name = GetGoodsName(eqid) or ("װ��"..eqid)
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
			text = "�ѻ��� <" .. name .. ">" .. text .. " (" ..tostring(killCount).."/"..tostring(counter)..")%0" .. countdowninfo
		else
			text = "�ѻ��� " .. name ..  text .. " ("..tostring(killCount).."/"..tostring(counter)..")%0" .. countdowninfo
		end
	else
		text = "���� " .. name .. colours.red .. ' (0/'.. counter .. ") %0"
	end
	
	if nil~=targetpos and check then
		return text, {2, 0, targetpos[1], targetpos[2], targetpos[3], name }
	else
		return text
	end
end

function UpdateKillInfo(condition, i, taskdata, taskid, check)	
	local kill = taskdata.�������.kill
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
	for k,v in ipairs(taskdata.�������.items) do
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
			text = "��Ʒ������ID:" .. tostring(index);
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
	local award = {[1] = "����:"}
	--i = 2
	for k,v in pairs(taskdata.��ɽ���) do
		local key = tostring(k)
		
		if key=="giveGoods" and not table.empty(v) then		--���콱����Ʒ�����ַ���
			local sGoods = ""
			--�ص���Ʒ
			if ( v.give~=nil and not table.empty(v.give) ) then
				--<give>����{},{},{},</give>
				sGoods = sGoods .. "<give>" .. tostring(#v.give)
				for kk,vv in pairs(v.give) do
					sGoods = sGoods .. "{" .. tostring(vv[1]) .. "," .. tostring(vv[2]) .. "},"
				end
				sGoods = sGoods .. "</give>"
			end
			
			--����ѡ��Ʒ
			if( v.options~=nil and not table.empty(v.options) ) then
				--<option>����{},{},{},</option>
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

		if( taskState == TASK_COMPLETED ) then -- ������
			local taskid = selection[4]
			local taskData = GetTaskConfig( taskid, saveTaskData )
			ShowTask(0,taskData.��������,taskData.����˵��,taskid,taskData.������npcid,nil,GetConditionInfo(taskid,taskData),GetAwardInfo(taskData))			
		elseif(taskState == TASK_CANACCEPT) then
			local taskid = selection[4]
			local taskData = GetTaskConfig( taskid, saveTaskData )
			SendToServer( { ids={1,1}, npcid = taskData.������npcid, taskid = taskid, type=1 } )
		elseif(taskState == TASK_CURR) then
			local taskid = selection[4]
			local taskData = GetTaskConfig( taskid, saveTaskData )
			SendToServer( { ids={1,1}, npcid = taskData.������npcid, taskid = taskid, type = 2 } )
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

		local npcname = ����NPC���ñ�[taskdata.������npcid].NpcCreate.name
		
		if task[3]==1 then
			superTaskId = taskid
		else
			superTaskId = nil		
		end
		
		if IsRingTask(taskid) then
			local dummyaward = {exp=0, money=0,xyvalue=0}
			ShowTask(1, taskdata.pre��������,taskdata.pre����˵��, taskid, taskdata.������npcid, npcname, {}, dummyaward, taskdata.nocancel)
		else
			ShowTask(1,taskdata.��������,taskdata.����˵��, taskid,taskdata.������npcid,npcname,condition,award, taskdata.nocancel)
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
	if (taskType == 1) then		-- ������
		if superTaskId==acceptTaskID then
			SendToServer( { ids={1,2}, npcid = taskNpcid, taskid = acceptTaskID, super=1 } )
		else
			SendToServer( { ids={1,2}, npcid = taskNpcid, taskid = acceptTaskID } )	
		end
	elseif (taskType == 0) then		-- ������
		if type(optionGoodId)==type(0) then
			SendToServer( { ids={1,3}, npcid = taskNpcid, taskid = acceptTaskID, goodid = optionGoodId } )
		else
			SendToServer( { ids={1,3}, npcid = taskNpcid, taskid = acceptTaskID } )		
		end
	elseif (taskType == 2) then		-- ����������
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
			local text = "  " .. colours.green .. "��" .. tostring(counter) .. "��%0"		
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
			if type(k)==type("") and ͨ�������жϱ�[k] then
				if not TableHasKeys(saveTaskData,{"current", taskid,"to", k}) 
				  and ͨ�������жϱ�[k]( taskInfo.�������[k], saveTaskData, taskid) then					
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

-- ����������ָ�����ݣ�Ŀǰֻ����ʱʹ�ã��Ժ���ܻ��滻Ϊ�µ��߼�
local __time_timeout = GetServerTime()
g_specialTips = g_specialTips or {}

function GetTaskTips()
	local trackedTask= {}
	-- ����ڸ��������ⳡ��,ͨ�����ñ���Թر�����׷��,ת����ʾ����׷����Ϣ
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
	
	-- ͨ��saveTaskData��ȡ��ǰ����ִ�е�����ͬʱͨ�������������������ָ�����ݣ�
	
	--  ���ر�lua�ļ�ʱ�Ѿ���֤��
	assert( saveTaskData ~= nil )
	--[[
	if saveTaskData == nil then
		return "��������Ϊ��"
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
				if IsRingTask(taskid) then		--�ܻ�����
					actionIndex = ringCouldComplted(taskid, saveTaskData)
					if actionIndex then
						actionIndex = 1
						ringInfo = getRingInfo(taskid, false)
					else
						ringInfo = getRingInfo(taskid, true)
					end
					
				else				
					actionIndex = ͨ�������жϱ�.CheckConditions(taskInfo.�������,saveTaskData,taskid)
				end
								
				--����������ʱ����
				if checktime then 
					if not ͨ�������жϱ�.CheckTimeout(taskInfo, taskid, saveTaskData)  then
						dropTask(taskid)
					else
						MarkTaskTimeOut(taskInfo, taskid, actionIndex)
					end
				end

				local timeoutTip = ""
				if nil~=taskInfo.timeout and nil~= taskInfo.timeout[1] then
					timeoutTip = GetCountDownInfo(taskInfo, taskid, 1) .. "��ʱ" or ""
				end
				
				if actionIndex == 1 or saveTaskData.current[taskid].state ~= nil then
					local _, delayInfo = GetTaskDelayInfo(taskInfo, taskid)
					tips = tips ..colours.green .. "- <!" .. tostring( taskInfo.�������� ) .. "������ɣ�>%0" .. ringInfo.. "  " ..delayInfo .. " ".. timeoutTip .."\r\n"
					table.push(clickObjs, {0, taskid, 0, 0, 0, tips})
					
					local taskData = GetTaskConfig(taskid, saveTaskData)
					
					local npc = ����NPC���ñ�[taskData.������npcid]		
					tips = tips .. colours.yellow .. "  ����ظ�:" .. colours.yellow .. "<".. npc.NpcCreate.name .. ">%0\r\n"
					--					   --{����, id, region, x, y, name}
					table.push( clickObjs, {1,taskData.������npcid, npc.NpcCreate.regionId, npc.NpcCreate.x, npc.NpcCreate.y, npc.NpcCreate.name } )
					table.cat( clickObjs, findobjs)
				else
					tips = tips .. colours.yellow .. "- <!" .. tostring( taskInfo.�������� ) .. ">%0" .. ringInfo .. " ".. timeoutTip .. " \r\n"
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
				local area = taskinfo.�������.area
				local npcid = taskinfo.������npcid
				if ( area ~= nil and regionid == area[1]  and saveTaskData.current[taskid]["area"]==nil ) then
					SendToServer( { ids={1,4}, npcid = npcid, taskid = taskid,opkey="area"} )
					RefreshOneNpcState(npcid)
				end
			end
		end
	end
end

-- NPC ��ѯ����
function GetNpcInfoById( id )
	return ����NPC���ñ�[id].NpcCreate
end


function GetNpcInfoByName( name )
	--rfalse("Try to get NPCInfo By Name:" .. tostring(name) )
	if( type(name)~=type('')) then
		return nil
	end
	
	for k,v in pairs(����NPC���ñ�) do
		if v.NpcCreate and v.NpcCreate.name and v.NpcCreate.name==name then
			return k, v.NpcCreate	--NPC ID, NPC��Ϣ��
		end
	end	
	return nil
end


-- ���� ��ѯ����
function GetTaskInfo(taskid)
	local taskData = GetTaskConfig(taskid, saveTaskData)
	if taskData~=nil then
		-- ����״̬  1:���, 2:�ѽ�
		taskData.״̬ = 0	
		if saveTaskData.current then
			if saveTaskData.current[taskid]~=nil then
				taskData.״̬ = 2
			elseif saveTaskData.completed[taskid]~=nil then
				taskData.״̬ = 1	
			end
		end
		--λ����Ϣ
		taskData.findpos = {}
		
		--����������ϢѰ·
		
		--������npc
		--{����, id, region, x, y, name}
		if nil~=taskData.������npcid then
			local npc = ����NPC���ñ�[taskData.������npcid]
			table.push(taskData.findpos, {1, taskData.������npcid, npc.NpcCreate.regionId, npc.NpcCreate.x, npc.NpcCreate.y, npc.NpcCreate.name})
		end
		
		--������npc
		local npc = ����NPC���ñ�[taskData.������npcid]
		table.push(taskData.findpos, {1, taskData.������npcid, npc.NpcCreate.regionId, npc.NpcCreate.x, npc.NpcCreate.y, npc.NpcCreate.name})

		local _, findobjs = GetConditionInfo(taskid,taskData)
		table.cat(taskData.findpos, findobjs)
		
		return taskData
	end
	return nil
end

-- ���ǵ�ǰ������� { {����ID,����״̬}, {����ID,����״̬}, ...}
function GetCurrentAcceptTask()	
	if saveTaskData==nil or saveTaskData.current==nil or table.empty(saveTaskData.current) then
		--return {{100002,2}, {100001,2} } --for test
		return {}
	end
	
	local taskIdsTable = {}
	for k,v in pairs(saveTaskData.current) do
		--���״̬	 0:δ��� 1:���
		local taskData = GetTaskConfig(k, saveTaskData)
		local actionIndex, failInfo = ͨ�������жϱ�.CheckConditions(taskData.�������,saveTaskData,k)
		
		local taskstate = false
		if 1==actionIndex or v.state ~= nil then
			taskstate = true
		end
		
		--׷��״̬
		local tracked = false
		if v.track and v.track==1 then
			tracked = true
		end
		
		table.push( taskIdsTable, {k, taskstate, tracked} )	--{k, 0} == {����ID,�������״̬,׷��״̬}
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
		local taskName = taskData.��������
		--if taskData.��������.level then
		--	taskName = "[" .. taskData.��������.level  .. "]" .. taskName
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
		
		return {taskName,taskData.����˵��,taskid,taskData.������npcid, taskData.������npcid, GetConditionInfo(taskid,taskData),award, exp, money, xyvalue}
	end
end

function GetKillMonsterInfo( monster)
	function GetKillCounter( taskid, monster)
	    local taskData = GetTaskConfig( taskid, saveTaskData )
	    if nil~=taskData then
            local kill = taskData.�������.kill 
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
							return "�ѻ��� " .. monster
						elseif killedCounter==counter then
							return "�ѻ��� " .. monster .. " " .. tostring(killedCounter) .. "/" .. tostring(counter)
						elseif killedCounter<counter then
							return "�ѻ��� " .. monster .. " " .. tostring(killedCounter) .. "/" .. tostring(counter)	
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
	if taskInfo.�����ʱ and TableHasKeys(saveTaskData, {"current", taskid, "start"}) then
		local now = GetServerTime()
		local remain = taskInfo.�����ʱ  -( now- saveTaskData.current[taskid].start)

		if remain <0 then
			return true, ""
		else
			return false,  TimeFormat(remain).." ��ɽ�"
		end
	end
	
	return true, ""
end

function OnCGPlayEnd( cgId )
	rfalse("CG END  " .. cgId .. " \n" )
	if TableHasKeys(CG�������, cgId) then
		local conf = CG�������[cgId]

		function _handel( c )
			if type(c)==type(0) then
				if nil==�����[c] then
					rfalse("CG��ɾ������ó���������"..storyid .. "����")
				end
				
				storydata = �����[storyid]
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


