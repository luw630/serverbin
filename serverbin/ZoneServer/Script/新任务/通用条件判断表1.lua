
ͨ�������жϱ� = {

	SchoolInfo = { "����", "�䵱", "��ü", "����", "ħ��" },

	CheckConditions = function ( conditions, taskData, taskid, dodel )
		-- �����������������������ݣ�����һ����������
		if type( conditions ) == 'table' then 
			-- �����ñ������ݴ���ʱ��û������˳�������luakey������п��ƣ�
			-- ֮���Բ�ʹ����ǰ�Ķ�ά������Ϊ�˱�֤�ж��߼��ļ��ԣ�
			local ck = nil
			local info
			for k,v in pairs( conditions ) do -- �������б����ÿһ������ʽ��
				if type( v ) == "function" then
					ck, info = v( k, taskData, taskid, false ) -- ����Ǻ�������ֱ��ִ�к��ȡ����ֵ
				elseif ͨ�������жϱ�[k] ~= nil then
					ck, info = ͨ�������жϱ�[k]( v, taskData, taskid, dodel ) -- ���������ʽ����ͨ��ģʽƥ�䣬ȥִ��ԭע��������жϺ���
				else
					ck, info = ( tostring( k ) .. ' ' .. tostring( v ) .. ' : ��Ч����������' )
				end
				if ck ~= true then
					return 0, info -- ���ʧ�ܣ�ֱ�ӷ���ʧ�ܽ�����ݣ�����Ҫ����ִ���ˣ�
				end
			end
			return 1
		elseif type( conditions ) == 'function' then
			return conditions( conditions,taskData, taskid, dodel ) -- �п���������������һ�������жϺ������Ǿ�ֱ��ִ�к󷵻أ�
		end
		return 0, "��Ч��������"
	end,

	CheckAndDelete = function ( conditions, taskData, taskid )
		-- ��飬����ɾ����ЩӦ�ñ�ɾ���ĵ��ߣ�
		local ck, info = ͨ�������жϱ�.CheckConditions( conditions, taskData, taskid )
		if ck ~= 0 then
			ck, info = ͨ�������жϱ�.CheckConditions( conditions, taskData, taskid, 1 )
		end
		return ck, info
	end,
	
	--����ʱ���
	CheckTimeout = function ( taskconf, taskid, taskdata )		
		if taskconf and type(taskconf.timeout)==type({}) and TableHasKeys(taskdata,{"current",taskid, "start"}) then
			local timepass = GetServerTime() - taskdata.current[taskid].start
			
			--��������ĳ�ʱ
			if taskconf.timeout[1] and taskconf.timeout[1]<timepass then
				return false
			end
			
			for k,v in pairs(taskconf.timeout) do
				if type('')==type(k) and TableHasKeys(taskconf, "�������", k) then
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
		if type(taskconf.�����ʱ)==type(0) and TableHasKeys(taskdata,{"current", taskid, "start"}) then
			local past = GetServerTime() - taskdata.current[taskid].start
			if past>0 and past>=taskconf.�����ʱ then
				return true
			end
			return false
		end	
		return true
	end,

	-- ͳһ˵���������жϵķ���ֵͳһΪ��������
	-- �ж�������,Ĭ���������¼�� : taskData.step
	-- �������� completed = {10001}
	completed = function ( condition, taskData, taskid )
		if table.empty(condition) then
			return true
		end
		
		if taskData == nil or taskData.completed == nil then
			return false,"û�������������"
		end
		local completed = taskData.completed
		if type( condition ) == type({}) then
			for k,v in pairs(condition) do 
				if type(0)==type(v) then
					if completed[v] == nil then
						return false, "����"..v.."δ��ɣ�"
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
						return false, "����" ..  uncompletedid ..  "δ��ɣ�"
					end
				end
			end
			return true
		end
		return false
	end,

	-- �жϵȼ�����,��Ҫͨ��GetPlayerData��ȡ
	level = function ( condition )	
		local level = GetPlayerData( 1 )
		if type( condition ) == 'number' then
			return level >= condition or "�ȼ�δ�ﵽ" .. condition .. "��"
		elseif type(condition ) == 'table' then
			if condition[2] == nil then
				return level >= condition[1] or "�ȼ�δ�ﵽ" .. condition[1] .. "��"
			else
				return level >= condition[1] and level <= condition[2]
			end
		end
		return false
	end,

	-- �ж����ɲ���,��Ҫͨ��GetPlayerData��ȡ
	school = function (condition)
		local zschool = GetPlayerData( 2 )
		if type(condition) == 'table' then
			if (#condition == 1) then
				-- �������ɣ�Ӧ��ֻ��һ���ӱ�
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
--			return zschool == condition or "������%4" .. tostring( ͨ�������жϱ�.SchoolInfo[condition + 1].."�ĵ���%0�Ұﲻ����" )
--		end
	end,

	-- �жϵ��߲���,��Ҫͨ��CheckGoods���
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
					return false,"������ߴ���"
					--local tab = GetItemSetting( v[1] )
					--if dodel == 1 then
					--	return "��Ҫ".. ( tab and tab.name or "���߱��"..v[1] ) .. v[2] .. "��"
					--else
					--	return "��ȡ".. ( tab and tab.name or "���߱��"..v[1] ) .. v[2] .. "��ʧ��"
					--end
					
				end
			end
			return true
		elseif type( condition ) == 'function' then
			return condition( dodel )
		end
		return false,"������ߴ���"

	end,
	
	-- ɱ�ִ���
	kill = function ( condition, taskData, taskid )
		if taskData == nil or taskData.current == nil or 
			taskData.current[taskid] == nil or taskData.current[taskid].kill == nil then
			return "û��ɱ������"
		end
		local kill = taskData.current[taskid].kill
		if type(condition[1])==type({}) then
			for k,v in pairs( condition ) do --{��������, ����, {region, x,y}}
				local num = kill[ v[1] ]
				
				if num == nil then
					return false, "û��".. v[1].."������"
				end
				
				if num < v[2] then
					return false, "����"..( v[2]-num).."��" .. v[1]
				end
			end
		else
			local num = kill[ condition[1] ]
			
			if num == nil then
				return false, "û��".. condition[1].."������"
			end
			
			if num < condition[2] then
				return false, "����"..( condition[2]-num).."��" .. condition[1]
			end
		end
		return true
	end,

	-- ����������
	area = function( condition, taskData,taskid )
		if taskData == nil or taskData.current == nil or taskData.current[taskid]==nil then
			rfalse("û�������������")
			return false
		end

		if(taskData.current[taskid]["area"] ~= nil) then
			return true
		end

		local mainid, subid= GetSubID(taskid)
		local area = �����[mainid][subid].�������.area
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

		for k,_ in pairs(taskConf.�������[opkey]) do
			if not TableHasKeys( taskData,{"current",taskid,opkey, k}) then
				return false 
			end
		end
		return true
	end,

	-- ������
	click = function(condition,taskData,taskid)
		return ͨ�������жϱ�.op(condition,taskData,taskid,"click")
	end,

	-- ʹ�ü���
	us = function(condition,taskData,taskid)
		return ͨ�������жϱ�.op(condition,taskData,taskid,"us")
	end,

	-- ����ĳ��װ��
	ei = function(condition,taskData,taskid)
		return ͨ�������жϱ�.op(condition,taskData,taskid,"ei")
	end,

	-- ʹ�õ���
	ug = function(condition,taskData,taskid)
		return ͨ�������жϱ�.op(condition,taskData,taskid,"ug")
	end,

	-- �������
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

	-- �书�ȼ�
	-- �ȼ������÷�ʽΪ{{�书ID���书�ȼ�},{�书ID���书�ȼ�},{�书ID���书�ȼ�}...}
	sl = function(condition)
		if type(condition) == 'table' then
			rfalse("��ǰ���书������"..#condition.."��")
			for i=1, #condition do
				local skill = condition[i][1]
				local level = condition[i][2]
				rfalse("�书:"..skill.."��Ҫ�ȼ�"..level)
				
				-- ��ȡ�书�ĵ�ǰֵ
				local curLevel = GetPlayerData(36,skill)
				if (curLevel < level) then
					return false
				end
			end
			return true
		end
		rfalse("������������...");
		return false
	end,

	-- �ķ��ȼ�
	tl = function(condition)
		if type(condition) == 'table' then
			rfalse("��ǰ���ķ�������"..#condition.."��")
			for i=1, #condition do
				local skill = condition[i][1]
				local level = condition[i][2]
				rfalse("�ķ�:"..skill.."��Ҫ�ȼ�"..level)
				
				-- ��ȡ�书�ĵ�ǰֵ
				local curLevel = GetPlayerData(37,skill)
				rfalse("�ķ�:"..skill.."��ǰ�ĵȼ�Ϊ:"..curLevel)
				if (curLevel < level) then
					return false
				end
			end
			return true
		end
		rfalse("�ķ���������...");
		return false
	end,

	buff = function(condition)
		if type(condition)==type({}) then
			for _, v in pairs(condition) do	
				local hasBuff = GetPlayerData(38, v)
				if hasBuff==false then
					return false, "������BUFF: " ..  v
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
			return false, "��Ʊ����: " .. condition .. "  Only:" .. moneyHave
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
		return ͨ�������жϱ�.op(condition,taskdata,taskid,"col")
	end,
	
	nu = function( conditions, taskdata, taskid)
		return ͨ�������жϱ�.op(condition,taskdata,taskid,"nu")
	end,
		
	cap = function( conditions, taskdata, taskid)
		for k, v in pairs(conditions) do
			if not TableHasKeys(taskdata, {"current", taskid, "cap", k}) 
			   or taskdata.current[taskid].cap[k] < v[2] then
				return false, v[1].."����"
			end
		end
		return true
	end,
	
	me = function ( conditions, taskdata, taskid)
		return ͨ�������жϱ�.op(condition,taskdata,taskid,"me")
	end,
	
	copy=function( conditions, taskdata, taskid )
		rfalse('�жϸ��������Ƿ����')
		for k,v in pairs(conditions) do
		end
	end,

	nc = function( condition,taskData,taskid )
		return ͨ�������жϱ�.op(condition,taskData,taskid,"nc")
	end
}
