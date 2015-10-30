
function click(uiname)
	for taskid in pairs(saveTaskData.current) do
		if not IsRingTask(taskid) then
			local taskinfo = GetTaskConfig(taskid, saveTaskData)
			if TableHasKeys(taskinfo, {"�������", "click"}) then
				local k = itemExist(taskinfo.�������.click,uiname)
				if 0~=k and not TableHasKeys( saveTaskData, {"current", taskid, "click", k} ) then 
					rfalse("���Ͳ�����Ϣ��������")
					SendToServer( { ids={2,1}, taskid = taskid, opkey = "click" ,opvalue=k } )
				end
			end
		end
	end
end

function useskill(skillid)
	rfalse("useskill"..skillid)
	
	if nil==saveTaskData.current then
		return
	end
	
	for taskid in pairs(saveTaskData.current) do
		if not IsRingTask(taskid) then
			local taskinfo = GetTaskConfig(taskid, saveTaskData)

			local op = taskinfo.�������--.op
			if( op == nil or op.us == nil) then
				return
			end
			
			local flag = 0;
			
			for i=1, #op.us do
				for k,v in pairs(op.us[i]) do
					if v==skillid then
						if saveTaskData.current[taskid].us~=nil and saveTaskData.current[taskid].us[k] ~=nil then
							flag = 1;
							break
						end
						rfalse("���ͼ�����Ϣ��������  skillid:" .. skillid)
						SendToServer( { ids={2,1}, taskid = taskid, opkey = "us",opvalue=k } )
					end
				end	
				
				if 1 == flag then
					break;
				end
			end
		end
	end
end

---BUFF
function checkbuff( buffname )
	for k, v in pairs(saveTaskData.current) do
		if not IsRingTask(k) then
			local taskinfo = GetTaskConfig(k, saveTaskData)
			local conditions = taskinfo.�������
			
			if conditions and not table.empty(conditions ) and conditions.buff then
				local buffindex = itemExist(conditions.buff, buffname)
				if 0~=buffindex then 
					SendToServer( {ids={2,1}, taskid = k, opkey = 'buff', opvalue =  buffindex  } )
					return
				end
			end
		end
	end	
end

--�������
function checkteamcounter()	
	local teamcounter = GetPlayerData(35)
	for k, v in pairs(saveTaskData.current) do	
		if not IsRingTask(k) then
			local taskinfo = GetTaskConfig(k, saveTaskData)
			local conditions = taskinfo.�������.tmc
			if type(conditions) == type(0) then 		--���������
				if teamcounter >= conditions then
					SendToServer( {ids={2,1}, taskid = k, opkey = 'tmc'} )
					return
				end
			elseif type(condition)==type({}) then		--����Ǳ�
				if teamcounter>=conditions[1] and  teamcounter<=conditions[2] then
					SendToServer( {ids={2,1}, taskid = k, opkey = 'tmc'} )
					return
				end			
			end
		end
	end
end

--�ķ��ȼ�
function checkTL( tlid)
	local telergyLevel = GetPlayerData(37, tlid)
		rfalse("checkTL  " .. tlid .. " level: " .. telergyLevel)
	for k, v in pairs(saveTaskData.current) do
		local mainid, subid  = GetSubID(k )
		if not IsRingTask(k) then
			local taskinfo = GetTaskConfig(k, saveTaskData)
			local conditions = taskinfo.�������.tl
			if type({})==type(conditions) then
				if type(conditions[1])== type( {} ) then
					for t,l in pairs(conditions) do
						if l[1]==tlid and telergyLevel>=l[2] then
							--ST( {ids={1,4}, taskid=k, opkey='tl', opvalue=tlid})
							SendToServer( {ids={1,4}, taskid=k, opkey='tl', opvalue=tlid} )
							return
						end
					end
				elseif type(conditions[1])==type(0) then
					if tlid == v[1] and telergyLevel>=v[2] then
						--ST( {ids={1,4}, taskid=k, opkey='tl', opvalue=tlid}  )
						SendToServer( {ids={1,4}, taskid=k, opkey='tl', opvalue=tlid} )
						return
					end
				end
			end
		end
	end
end

--���ܵȼ�
function checkSL( slid )
    if saveTaskData.current==nil then
        return 
    end
	
	rfalse( "SL id: " .. tostring(slid))
	local skillLevel = GetPlayerData(36, slid)
	rfalse( "SL id: " .. tostring(slid) .. "   " ..  tostring(skillLevel))
	for k, v in pairs(saveTaskData.current) do
		local taskInfo = GetTaskConfig( k, saveTaskData )
	 
		local conditions = taskInfo.�������.sl
		if conditions then
			if type(conditions[1])==type({}) then
				for t,l in pairs(conditions) do
					if l[1]==slid and skillLevel>=l[2] then
						rfalse('SL SendToServer(table):')
						ST({ids={1,4}	, taskid=k, opken ='sl', opvalue=slid})
						
						SendToServer( {ids={1,4}, taskid=k, opkey ='sl', opvalue=slid} )
						return
					end
				end
			elseif type(conditions[1])==type(0) then
				if slid == conditions[1] and skillLevel>=conditions[2] then
					rfalse('SL SendToServer(number):')
					ST({ids={1,4}	, taskid=k, opken ='sl', opvalue=slid})
					
					SendToServer( {ids={1,4}, taskid=k, opkey ='sl', opvalue=slid} )
					return
				end
			end				
		end
	end
end

function dropTask(tid)
	if tid and TableHasKeys(saveTaskData, {"current", tid}) then
		SendToServer( {ids={1,6}, taskid=tid })
	end
end