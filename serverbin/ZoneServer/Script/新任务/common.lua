
--һ���ʱ��(��)
DAY_TIME = 60*60*24

--RING_TASK_ID_BASE 

TP_FUNC = type( function() end)

TASK_ID_GAP = 1000

TASK_COMPLETED = 3
TASK_CANACCEPT = 2
TASK_CURR = 1

TASK_COULD_TALK = 4
TASK_TIMEOUT = 5

TASK_FUNCTION = 6

DYN_NPC_ID = 400000

--	�����б� { ����ֵ = {GetPlayerData����, ���֣���λ}}
PropertyTable = { MaxHP = { 26, "��������", "��"},
				  MaxMP = { 41, "��������", "��"},
				  MaxSP = { 42, "��������", "��"},
				  OAttBase = { 43, "�⹦����", "��" },
				  IAttBase = { 44, "�ڹ�����", "��"},
				  ODefBase = { 45, "�������", "��"},
				  IDefBase = { 46, "�ڷ�����", "��"},
				  AG = { 7, "��", "��"},
				  Amuck = { 47, "ɱ��", "��"},
				  Money = { 48, "��Ǯ", ""},
				}

TASK_ID_RING_GAP = 1000*1000
function IsRingTask(id)
	return id>TASK_ID_RING_GAP
end
function IsReeligible(id)
	task = id/10000
	step = id-task
	if �����[task] == nil or �����[task][step] == nil then
		return false
	end
	if �����[task][step].ѭ������ == nil or �����[task][step].ѭ������ == false then
		return false
	end
	return true
end
function GetRingTaskId( mainid, subid)
	return TASK_ID_RING_GAP + GetTaskId(mainid, subid)
end

function GetRingSubID(id)
	mainid, subid = GetSubID( id - TASK_ID_RING_GAP)
	
	return mainid, subid
end

function GetTaskId(mainid, subid)
	--rfalse(debug.traceback())
	return mainid* TASK_ID_GAP + subid
end

function GetSubID(taskid)
	local mainid = rint( taskid / TASK_ID_GAP )
	local subid = rint( taskid%TASK_ID_GAP )

	return mainid,subid
end

function ST(v) ShowTable(v,rfalse) end

function itemExist(t,value)
	rfalse(debug.traceback())
	local ok
	for k,v in pairs(t) do
		if v == value then
			return k
		end
	end

	return 0
end


function table.push(t, data)
	t[ #t+ 1] = data
	return t
end

--[[
function itemExist(t,value) 
	if t==nil or value ==nil then
		return false
	end
	
	for k,v in pairs(t) do
		if v == value then
			return true
		end
	end

	return false
end
--]]
function TableHasKeys( t, keys )
	if type(t)==type({}) then	
		if type(keys)==type({}) then
			local tb = { t }
			for k,v in pairs(keys) do
				if type(tb[#tb])==type({}) and tb[#tb][v]~=nil then
					table.push(tb, tb[#tb][v])
				else
					return false
				end
			end
			return true
		else
			return t[keys]~=nil	
		end
	else
		return false
	end
end


function  SetTrapEx(regionID, listID, type, x, y, scriptID, var)
   local ret = 0
   if(type == 0)then
      ret = SetTrap(regionID, listID, 0)
   else
      SetTrap(regionID, listID, 0)
      ret = SetTrap(regionID, listID, type, x, y, scriptID, 0, var)
   end
   return ret
end

if mapID == nil then
	mapID = {}
end

function SetOneMapEvent(regionID,x,y,EventID, var)
	if #mapID == 0 then
		mapID[1] = 1
	else
		mapID[#mapID+1] = mapID[#mapID]+1
	end
	SetTrapEx(regionID,mapID[#mapID],7,x,y,EventID, var)
end

function SetMapEvent(regionID,x,y,EventID,length, var)
	if length == nil then
		length = 3 -- Ĭ��Ϊ3X3 9������
	end
	if length == 1 then
		SetOneMapEvent(regionID,x,y,EventID, var)
	else
		for i=0,length-1 do
			for j=0,length-1 do
				SetOneMapEvent(regionID,x+i-((length-1)/2),y+j-((length-1)/2),EventID, var)
			end
		end
	end
end

function table.cat(t1, t2)
	if type(t1)==type({}) then
		if type(t2) ==type({}) then
			for k,v in pairs(t2) do
				table.push(t1, v)
			end
		elseif type(t2)~=type(nil) then
			table.push(t1, t2)
		end
	end
end

function table.copy(t)
	if type(t)~=type({}) then
		return nil
	end
	
	local newtable={}
	for k,v in pairs(t) do
		if type(v)==type({}) then
			newtable[k] = table.copy(v)
		else
			newtable[k] = v			
		end
	end
	
	return newtable
end

table.empty = function ( tab )
	for k,v in pairs( tab ) do
		return false
	end
	return true
end

--���������ʽ
math.randomseed( os.time() )

function IN_ODDS_N( ODDS)
	local odds = ODDS
	function odds_func( p)
		return p > (math.random()*odds)
	end
	return odds_func 
end

IN_ODDS = IN_ODDS_N(100)

--
--return: n  0:invalid
function fastRandomRate(rateTable)
	local rnd = rint(100*math.random())+1
	local total = 0
	for k,v in ipairs(rateTable) do
		total = total + v
		if rnd < total then
			return k
		end
	end
	return 0	
end

-- now�Ƿ���� h:m��ʱ��
function isPassedThisDay(h, m, tm)
	local now = GetServerTime()
	local dt = os.date("*t", now)
	dt.hour = h
	dt.min = m
	dt.sec = 0
	local basetime = os.time(dt)
	return basetime < tm
end

-- now�Ƿ����wday:h:m��ʱ��
function isPassedThisWeek(wd, h, m, tm )
	wd = wd + 1
	if wd == 8 then
		wd =1
	end

	local now = GetServerTime()
	local dt = os.date("*t", now)
	local subtime = (((dt.wday-1)*24 +dt.hour)*60 + dt.min)*60 + dt.sec
	local addtime = (((wd-1)*24+h)*60 + m)*60
	local basetime = tm - subtime + addtime
	return basetime < tm
end

function initToObjItems()
	_use2ObjItems = {}
	for mid, mtask in pairs(�����) do
		for subid, task in pairs(mtask) do
			if TableHasKeys(task, {"�������", "nu"} ) then
				local nu = task.�������.nu
				for _,v  in pairs(nu) do
					_use2ObjItems[ v[2] ] = 1
				end
			end
			
			if TableHasKeys(task, {"�������", "cap"} ) then
				local cap = task.�������.cap
				for _, v in pairs(cap) do
					_use2ObjItems[v[3]] = 1
				end
			end
		end
	end
end
	
function ItemCouldUseToObj( itemid)
	return nil~=_use2ObjItems[itemid]
end

----------------------------------------------
_ncTasks = {}
_isInitNcTable = nil
function initNc()
	if nil~=_isInitNcTable then
		return
	end

	for mainid, v in pairs(�����) do
		for subid, task in pairs(v) do
			if TableHasKeys(task, {"�������", "nc"}) then
				local nc = task.�������.nc
				for index, npcid in pairs(nc) do
					--Լ��������������ϵͳ��nc�������ܳ��� ��� Ŀ�궼Ϊ ĳһ��npc�����
					if nil~=_ncTasks[npcid] then
						rfalse("**WARNING: nc�������ô���: ����" .. _ncTasks[npcid][1] .. " �� ����"
								..GetTaskId(mainid, subid).. "  npcid:" .. npcid .. "��ͻ.\n")
					end

					_ncTasks[npcid] = { GetTaskId(mainid, subid), index } 
				end
			end
		end
	end

	_isInitNcTable = true
end

function GetNcInfo(npcid)
	initNc()
	return _ncTasks[npcid]
end

function IsNcNpc( npcid )
	initNc()

	local nc = _ncTasks[npcid]
	if nil~=nc then
		return true, nc[1], nc[2]
	end

	return false
end

--�������taskid�ɿ��ټ��
--[[
function IsNcNpc( npcid , taskdata, taskid )
	function _isNC(taskid)
		local taskinfo = GetTaskConfig(taskid, taskdata)
		if TableHasKeys(taskinfo, {"�������", "nc"}) then
			local nc = taskinfo.�������.nc
			for k,v in pairs(nc) do
				if v[1]==npcid then
					return true, k
				end
			end
		end
		false
	end

	if nil==taskid then
		for taskid, task in pairs(taskdata.current) do
			local ok, index = _isNC(taskid)
			if ok then
				return true, taskid, index
			end
		end
		
		return false
	else
		local ok, index = _isNC(taskid)
		if ok then
			return true, taskid, index
		end

		return false
	end
end
--]]

function callTableFuncs(t, param1)
	for _,v in ipairs(t) do
		_G[v](param1)
	end
end

NC_NONE	=	0
NC_STORY =	1
NC_CLICK =	2
NC_COLLECT = 3

function IsCollectNpc(npcid)
	local npc = ����NPC���ñ�[npcid]
	return nil~=npc and nil~=npc.product
end

function GetNpcNcState(npcid, taskdata)
	function _checkFinish( taskdata, taskid , index )
		return TableHasKeys(taskdata,{"completed", taskid}) or TableHasKeys(taskdata,{"current", taskid, "nc", index})
	end

	local ok ,taskid, index = IsNcNpc(npcid)
	if ok then
		if _checkFinish(taskdata, taskid, index) or not TableHasKeys(taskdata,{"current", taskid})  then
			return 	NC_STORY	--����
		else
			return NC_CLICK
		end
	elseif IsCollectNpc(npcid) then
		local npc = ����NPC���ñ�[npcid]
		if ͨ�������жϱ�.CheckConditions( npc.conditions, taskData, taskid ) then
			return NC_COLLECT
		end

		return NC_NONE
	else 

		return NC_STORY
	end
end