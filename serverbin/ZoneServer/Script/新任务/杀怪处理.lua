
function OnPlayerOnline()
	function _GetFirstTask( story )
		for _,v in pairs(story) do
			if type(v)==type({}) and v.task then
				return table.copy(v.task)
			end
		end
	end

    -- Ԥ����ɱ�ּ�����
    local sid = GetPlayerData( 17 )
    local taskData = GetDBTaskData(sid)

	--��һ��������
	local school = GetPlayerData( 2 )
	local stroyid = 60000 + school
	local story = �����[stroyid]
	local firsttask
	if story then
		firsttask = _GetFirstTask(story)
	end
    if taskData~=nil and nil~=story and nil~=firsttask then
		local taskid = GetTaskId( firsttask[1], firsttask[2] )
		if not TableHasKeys(taskData, {"current",taskid } ) 
		   and not TableHasKeys(taskData, {"completed", taskid }) then
	 	    SendStoryData(stroyid)
		end
    end

    local data
	if dbMgr[sid] then
		data = dbMgr[sid].data
	end
    rfalse ( "name = " .. GetPlayerData(3) .. " sid = " .. sid )
    if ( data ~= nil and data.taskData ~= nil and data.taskData.current ~= nil ) then
        for taskid,v in pairs( data.taskData.current ) do
            if ( v.kill ~= nil ) then
                for mon_name,killed_num in pairs( v.kill ) do
                    if mon_name ~= "" then
                        MarkTaskKillMonster( taskid, mon_name, true )
						rfalse( "mark kill " .. tostring( mon_name ) .. " -> " .. taskid )
                    end
                end
            end
        end
    end

    -- ͬ���������ݵ��ͻ���
    SyncTaskData()

end

function OnPlayerLogin( gid )
	--�����Ƿ��ڸ����У����������������
	CS_OnCleanUp( GetPlayerData(17) )
end
--����ɫ����������ʱ�ص�
function OnPlayerReLogin( gid )
	local sid = GetPlayerData(17)		
	--������
	local playerTemp = CS_GetPlayerTemp(sid)	
	if playerTemp ~= nil then		
		CS_OnCleanUp()
		CS_Back( sid )
	end
end
function OnPlayerLogout()
	local sid = GetPlayerData(17)
	local playerTemp = CS_GetPlayerTemp(sid)
	if playerTemp~=nil then
		CS_OnCleanUp()
	end
end

function IncMonsterKilled( task, name )
    if task ~= nil and task.kill ~= nil and task.kill[name] ~= nil then
        task.kill[name] = task.kill[name] + 1
        rfalse( "ɱ�ּ���[" .. name .. "]" .. task.kill[name] )
    end
end

function OnTaskKillMonster( name, taskidList )
    local sid = GetPlayerData( 17 )
    local data = dbMgr[sid].data
    if ( data ~= nil and data.taskData ~= nil and data.taskData.current ~= nil ) then
        if type( taskidList ) == "number" then
            IncMonsterKilled( data.taskData.current[taskidList], name )
	    else
            for k,v in ipairs( taskidList ) do
                IncMonsterKilled( data.taskData.current[ dw2int(v)], name )
            end
        end
    end
end

-- Ϊ��ǰ���ע����Ҫɱ�Ĺֵ���Ϣ
function MarkKillInfo( taskdata, taskid )	
	local taskInfo = GetTaskConfig(taskid, taskdata)
	local curtask = taskdata.current[taskid]
	if ( taskInfo ~= nil and taskInfo ~= nil and taskInfo.������� ~= nil ) then
		local kill = taskInfo.�������.kill
		if ( kill ~= nil ) then
			curtask.kill = {}
			if type(kill[1])==type({}) then
				for k,v in ipairs( kill ) do
					curtask.kill[v[1]] = 0
					MarkTaskKillMonster( taskid, v[1], true )
					rfalse( "ע��ɱ����Ϣ:[".. v[1] .. "]" ..v[2] )
				end
			else
				curtask.kill[ kill[1] ] = 0
				MarkTaskKillMonster( taskid, kill[1], true)
				rfalse( "ע��ɱ����Ϣ:[" .. kill[1] .. "]x" ..kill[2] )			
			end
		end
	end
end
