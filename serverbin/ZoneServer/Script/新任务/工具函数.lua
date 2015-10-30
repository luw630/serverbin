
--------------- ����״̬��� ---------------------------------
--�õ�ɱ������
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
	    
	    if nil~=taskinfo and TableHasKeys(taskinfo, {"�������", "kill"}) then
	        local kill = taskinfo.�������.kill
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
--ĳ��������������û������
function CouldComplete(playerid, taskid)
	local taskdata = GetDBTaskData( playerid )
	local taskinfo = GetTaskConfig(taskid, taskdata)
	if nil~=taskinfo then
		return 1==ͨ�������жϱ�.CheckConditions( taskinfo.�������, taskdata,taskid)
	end
	return false
end

--��ǰ��������������û������
function CurPlayerCouldComplete( taskid)
	return CouldComplete( GetCurPlayerID(), taskid)
end

---------------------------------------
--ĳ����Ƿ��Ѿ���������
function IsTaskCompleted(playerid,taskid)
	local taskData = GetDBTaskData( playerid )
	return TableHasKeys(taskData, {"completed", taskid} )
end

--��ǰ����Ƿ��Ѿ���������
function CurPlayerCompletedTask(taskid)
	return IsTaskCompleted(GetCurPlayerID(),taskid)
end

----------------------------------------------
--ĳ����Ƿ��Ѿ�����������
function HasTask(playerid,taskid)
	local taskData = GetDBTaskData(playerid)
	return TableHasKeys(taskData, {"current", taskid})
end

--��ǰ����Ƿ��Ѿ�����������
function CurPlayerHasTask(taskid)
	return HasTask(GetCurPlayerID(),taskid)
end

--------------------------------------
--��ȡ��ǰ���sid
function GetCurPlayerID()
	local npcid, monid, playerid = GetObjectUniqueId()
	return playerid
end

--����ҽ������� Ҫ����������
function AcceptTask(mainid, subid)
	local taskid = mainid
	if nil~=subid then
		taskid = GetTaskId(mainid, subid)
	end

	local _, _, playerid = GetObjectUniqueId()
	rfalse("AcceptTask .. " .. tostring(playerid) )
	if nil~=playerid and playerid>0 then
		��������(playerid, 0, taskid)
	end
end

-------------------------------------------------
--�ͷ��˲���cg
function RunCg(cgid)
	SendLuaMsg( 0, { ids = {2,1}, cg=cgid }, 9 )
	GetCurTaskTemp().cgid = cgid
end

--��ĳ��ң�ǿ�����һ������(�������������)
--------------------------------------------------
function AddTask(playerid, taskid)
	��������(playerid, nil, taskid, true)
end

--����ǰ��ң�ǿ�����һ������(�������������)
function CurrPlayerAddTask(taskid)
	return	AddTask(GetCurPlayerID(), taskid)
end

--------------------------------------------
--ɾ��ĳ��ҵ�һ������
function DelTask(playerid, taskid)
	local taskdata = GetDBTaskData( playerid )
	if TableHasKeys(taskdata, {"current", taskid }) then
		taskdata.current[taskid] = nil
		return true
	end
	return false
end

--ɾ����ǰ��ҵ�һ������
function CurrPlayerDelTask(taskid)
	return	DelTask(GetCurPlayerID(), taskid)
end
