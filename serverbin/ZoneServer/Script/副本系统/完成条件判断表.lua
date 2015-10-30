
副本完成条件判断表 = 副本完成条件判断表 or {
	CheckCompleteCondition = function (copyScene)
		local copySceneConfig = 副本配置[copyScene.TaskID]
		if copySceneConfig == nil then
			return false
		end
		
		local completeCondition = copySceneConfig.完成条件
		for condition, param in pairs(completeCondition) do
			local conditionFunc = 副本完成条件判断表[condition]
			if conditionFunc ~= nil then
				if conditionFunc(copyScene, param) ~= true then
					return false
				end
			end
		end
		
		return true
		
	end,
	
	怪物死亡 = function (copyScene, param)
		if type(param) ~= 'table' then
			return false
		end
		
		for _, v in pairs(param) do
			if type(v) == 'table' and v.id~=nil then
				--判断杀死指定怪,如果没有杀完,则判断没有完成任务			
				if copyScene.MonsterDeadList[v.id] ~= nil and copyScene.MonsterDeadList[v.id].num ~= 0 then
					return false
				end
			end
		end
		
		return true
		
	end,
	
	杀怪数量 = function( )
	end,
	
	
}
副本追踪 = 副本追踪 or {
	GetTips = function(copyScene,str)
		local copySceneConfig = 副本配置[copyScene.TaskID]
		if copySceneConfig == nil then
			return nil
		end
		
		local strTips={[1]=str or "%\73-副本任务追踪\r\n"};
		local completeCondition = copySceneConfig.完成条件
		--遍历完成条件
		for condition, param in pairs(completeCondition) do
			local conditionFunc = 副本追踪[condition]
			if conditionFunc ~= nil then
				if conditionFunc(copyScene,param,strTips) ~= true then
					return false
				end
			end
		end
		local str=""
		for _, v in pairs(strTips) do
			str = str..v
		end
		rfalse('----------------')
		rfalse(str)
		return str
	end,
	
	怪物死亡 = function (copyScene,param,strTips)

		if type(param) ~= 'table' then
			return false
		end
		local n=0
		dbMgr.ShowTable(param,rfalse)
		local str=""
		for _, v in pairs(param) do
			if type(v) == 'table' and v.id~=nil then
				if copyScene.MonsterDeadList[v.id] ~= nil then
					n = v.num - copyScene.MonsterDeadList[v.id].num
					if n==v.num then
						str = str..'  %\121-已击败:'..v.name..'('..tostring(n)..'/'..tostring(v.num)..')\r\n'
					else
						str = str..'  %\25-已击败:'..v.name..'('..tostring(n)..'/'..tostring(v.num)..')\r\n'
					end
				end				
			end
		end
		str=str..'%0'
		table.push(strTips,str)
		return true		
	end,
}
