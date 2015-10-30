
--�������Ƿ�����
function ringCouldComplted(taskid, taskData)
	local ringid = GetRingSubID(taskid)
	if nil==taskData.ring  then
		return false
	end
		
	--����������
	local taskInfo = GetTaskConfig( taskid, taskData )
	if taskInfo then
		local ok, info = ͨ�������жϱ�.CheckConditions( taskInfo.�������, taskData, taskid)
		if 1==ok then
			return true
		end
	end
	
	return false
end

--��ȡ����������Ϣ
function GetTaskConfig( taskid, taskData )
	if IsRingTask(taskid) then
		local ringid, subid = GetRingSubID(taskid)
		if �ܻ��������ñ�[ringid] then
			local mainid = �ܻ��������ñ�[ringid].�������
			if taskData and TableHasKeys( �ܻ������, { mainid, subid} ) then
				local ringConf = �ܻ������[ mainid ][ subid ]
				
				return buildRingTaskInfo( ringid, ringConf, taskData)
			end
		end		
	else
		local mainid,subid = GetSubID(taskid)
		if TableHasKeys( �����, { mainid, subid} ) then
			return �����[ mainid ][ subid]
		end
	end
end

--������������Ϣ
function buildRingTaskInfo( ringid, ringConf, taskData)
	function _buildGive(temp, goods)
		if nil==temp.��ɽ���.giveGoods then
			temp.��ɽ���.giveGoods = {}
		end
		if nil==temp.��ɽ���.giveGoods.give then
			temp.��ɽ���.giveGoods.give= {}
		end
		table.cat( temp.��ɽ���.giveGoods.give, goods )
	end
	
	local taskType = ringConf[1]
	local ringTemplate = �ܻ�����ģ���[taskType]
	local ringTask = �ܻ��������ñ�[ringid]
	
	ringTemplate.������npcid = ringTask.������npcid
	ringTemplate.������npcid = ringTask.������npcid
	
	if ringTemplate and ringTask then
		--[[
		--��������
		ringTemplate.�������� = {}
		
		--level
		ringTemplate.��������.level=ringConf.�ȼ���Χ
		
		--money
		local moenyRequest = v.��Ҫ��Ǯ or 0
		if type(moneyRequest)==TP_FUNC then		--money�����Ǻ���
			moenyRequest = moenyRequest()
		end
		ringTemplate.��������.money=moenyRequest
		--]]		
	
		--�������
		if 1==taskType then
			ringTemplate.������� = buildRingFindObj(ringConf)
		elseif 2==taskType then
			ringTemplate.������� = buildRingFindNpc(ringConf)
		elseif 3==taskType then
			ringTemplate.������� = buildRingKill(ringConf)
		elseif 4==taskType then
			ringTemplate.������� = buildRingAbttribute(ringConf)
		end
		
		--��ɽ���
		ringTemplate.��ɽ��� = table.copy(ringTask.��ɽ���) or {}
		buildRingAward(ringTemplate.��ɽ���, ringConf)
		
		--���⽱��
		local startring 
		if TableHasKeys( taskData, {"ring", "sring"} ) then
			startring = taskData.ring.sring
		end
		if startring and TableHasKeys( �ܻ��������ñ�, {startring, "���⽱��"}) then
			local doneRingTimes = taskData.ring.count or 0
		
			local times = doneRingTimes+1
			local goods = ringTask.���⽱��[ times ]
			local finalGive = ringTask.���⽱��.final
			if times == �ܻ��������ñ�.����� then
				_buildGive( ringTemplate, finalGive)
			elseif nil~=goods then
				_buildGive( ringTemplate, goods)
			end
		end
	end

	return ringTemplate
end

--����������Ϣ
function buildRingAward( awardRet, ringConf)
	local awardInfo = ringConf.��ɽ��� 
	if nil~=awardInfo then
		--��������
		local gexp = awardInfo.giveExp
		if type(0)==type(money) then
			awardRet.giveExp = gexp
		elseif TP_FUNC==type(money) then
			arardRet.giveExp = gexp()
		end
		
		--������Ǯ
		
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

-- npc���Ƿ������һ�����������
-- return: true, ������id, taskConfig
function ringCouldAccept( npcid, taskData, notupdate)
    if taskData==nil then
        return false
    end
	-- ring copy		
	for k,v in ipairs(�ܻ��������ñ�) do
		if v.������npcid == npcid then
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

--ĳ���Ƿ���Խ�
function ringCouldAcceptRing( ringid, taskConfig, taskData, notupdate)
	taskConfig = taskConfig or �ܻ��������ñ�[ringid]
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
	local levelRequest = taskConfig.�ȼ���Χ
	local ok, info = ͨ�������жϱ�.level( levelRequest )
	
	
	local finishcount = 0
	if TableHasKeys(taskData, {"ring", "count"} ) then
		finshicount = taskData.ring.count
	end

	if ok and finishcount<�ܻ��������ñ�.����� then
		--2. money check
		local moenyRequest = taskConfig.��Ҫ��Ǯ or 0
		if type(moneyRequest)==TP_FUNC then		--money�����Ǻ���
			moenyRequest = moenyRequest()
		end				
		ok = ͨ�������жϱ�.money( moenyRequest )
		
		if ok then
			--ˢ�´���
			ringRefresh( taskData )
			-- 3. ������ҵ�ǰ��û�д��ڵ�����������
			ok = ringCurrHasTheRing( ringid, taskData )
			if not ok then
				-- 4. ������ÿ�տ���ɴ�����ÿ���ܹ�����ɴ����������ɵ���
				if (�ܻ��������ñ�.�ɽӴ��� and _checkTimes( "acc", �ܻ��������ñ�.�ɽӴ���, ringid)) then					
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
function Ԥ�������( playerid, story, taskData, npcid )
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
--����һ���������,����������ѡ��
--return: taskid
function ringGenerateTask(npcid, taskData)
	local ok, ringId, taskConf = ringCouldAccept( npcid, taskData)
	if ok then
		return ringRandomTask( ringId, taskConf, taskData)
	end	
end

-- �������һ�����������id
--return: taskid, ringid, subid
function ringRandomTask( ringId, taskConf, taskData)
	local taskLib = �ܻ������[taskConf.�������]

	if taskLib then
		local randIndex
		if taskConf.������� then
			local taskType = fastRandomRate(taskConf.�������)
			
			--һ��������������ô���
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
		
		--��subid��������ʱ��������ﻹ��Ҫ���⴦��
		--�����������͸�������
		
		local subid = randIndex		
		return GetRingTaskId(ringId, subid), ringId, subid
	end
end

--ˢ�»�����ʱ��
--return: drops��Ҫ�����������б�
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
		
	local refresh = �ܻ��������ñ�.ˢ��
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

--����
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
		if TableHasKeys(taskInfo, {"�������",npc}) then
			local condition = taskInfo.�������.npc
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
