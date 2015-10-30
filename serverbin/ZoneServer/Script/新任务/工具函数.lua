
--------------- 任务状态相关 ---------------------------------
--得到杀怪数量
function getKillCounter(taskid, monster)
    function getCounter(taskdata, k)
        if TableHasKeys(taskdata, {"current",taskid, "kill", k }) then
            return taskdata.current[taskid].kill[k]
        end
        return 0
    end
    
    local _, _, playerid = GetObjectUniqueId()    
    local taskdata = GetDBTaskData(playerid)
    
    if nil~=taskdata then
	    local taskinfo = GetTaskConfig( taskid, taskdata)
	    
	    if nil~=taskinfo and TableHasKeys(taskinfo, {"完成条件", "kill"}) then
	        local kill = taskinfo.完成条件.kill
	        if type(kill[1])==type({}) then
                for k,v in pairs(kill) do
                    if v[1]==monster then
						local counter = getCounter(taskdata, monster)
                        return counter, counter>=v[2]
                    end
                end
            elseif nil~=kill[1] and kill[1]==monster then
				local counter = getCounter(taskdata, monster)
                return counter, counter>=kill[2]
            end      
	    end
	end
	
	return -1, false
end

--------------------------
--某玩家已完成条件但没交任务
function CouldComplete(playerid, taskid)
	local taskdata = GetDBTaskData( playerid )
	local taskinfo = GetTaskConfig(taskid, taskdata)
	if nil~=taskinfo then
		return 1==通用条件判断表.CheckConditions( taskinfo.完成条件, taskdata,taskid)
	end
	return false
end

--当前玩家已完成条件但没交任务
function CurPlayerCouldComplete( taskid)
	return CouldComplete( GetCurPlayerID(), taskid)
end

---------------------------------------
--某玩家是否已经交过任务
function IsTaskCompleted(playerid,taskid)
	local taskData = GetDBTaskData( playerid )
	return TableHasKeys(taskData, {"completed", taskid} )
end

--当前玩家是否已经交过任务
function CurPlayerCompletedTask(taskid)
	return IsTaskCompleted(GetCurPlayerID(),taskid)
end

----------------------------------------------
--某玩家是否已经接受了任务
function HasTask(playerid,taskid)
	local taskData = GetDBTaskData(playerid)
	return TableHasKeys(taskData, {"current", taskid})
end

--当前玩家是否已经接受了任务
function CurPlayerHasTask(taskid)
	return HasTask(GetCurPlayerID(),taskid)
end

--------------------------------------
--获取当前玩家sid
function GetCurPlayerID()
	local npcid, monid, playerid = GetObjectUniqueId()
	return playerid
end

--主玩家接受任务 要检查接受条件
function AcceptTask(mainid, subid)
	local taskid = mainid
	if nil~=subid then
		taskid = GetTaskId(mainid, subid)
	end

	local _, _, playerid = GetObjectUniqueId()
	rfalse("AcceptTask .. " .. tostring(playerid) )
	if nil~=playerid and playerid>0 then
		接受任务(playerid, 0, taskid)
	end
end

-------------------------------------------------
--客服端播放cg
function RunCg(cgid)
	SendLuaMsg( 0, { ids = {2,1}, cg=cgid }, 9 )
	GetCurTaskTemp().cgid = cgid
end

--给某玩家，强制添加一个任务(不检查任务条件)
--------------------------------------------------
function AddTask(playerid, taskid)
	接受任务(playerid, nil, taskid, true)
end

--给当前玩家，强制添加一个任务(不检查任务条件)
function CurrPlayerAddTask(taskid)
	return	AddTask(GetCurPlayerID(), taskid)
end

--------------------------------------------
--删除某玩家的一个任务
function DelTask(playerid, taskid)
	local taskdata = GetDBTaskData( playerid )
	if TableHasKeys(taskdata, {"current", taskid }) then
		taskdata.current[taskid] = nil
		return true
	end
	return false
end

--删除当前玩家的一个任务
function CurrPlayerDelTask(taskid)
	return	DelTask(GetCurPlayerID(), taskid)
end
