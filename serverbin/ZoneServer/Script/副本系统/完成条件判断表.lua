
������������жϱ� = ������������жϱ� or {
	CheckCompleteCondition = function (copyScene)
		local copySceneConfig = ��������[copyScene.TaskID]
		if copySceneConfig == nil then
			return false
		end
		
		local completeCondition = copySceneConfig.�������
		for condition, param in pairs(completeCondition) do
			local conditionFunc = ������������жϱ�[condition]
			if conditionFunc ~= nil then
				if conditionFunc(copyScene, param) ~= true then
					return false
				end
			end
		end
		
		return true
		
	end,
	
	�������� = function (copyScene, param)
		if type(param) ~= 'table' then
			return false
		end
		
		for _, v in pairs(param) do
			if type(v) == 'table' and v.id~=nil then
				--�ж�ɱ��ָ����,���û��ɱ��,���ж�û���������			
				if copyScene.MonsterDeadList[v.id] ~= nil and copyScene.MonsterDeadList[v.id].num ~= 0 then
					return false
				end
			end
		end
		
		return true
		
	end,
	
	ɱ������ = function( )
	end,
	
	
}
����׷�� = ����׷�� or {
	GetTips = function(copyScene,str)
		local copySceneConfig = ��������[copyScene.TaskID]
		if copySceneConfig == nil then
			return nil
		end
		
		local strTips={[1]=str or "%\73-��������׷��\r\n"};
		local completeCondition = copySceneConfig.�������
		--�����������
		for condition, param in pairs(completeCondition) do
			local conditionFunc = ����׷��[condition]
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
	
	�������� = function (copyScene,param,strTips)

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
						str = str..'  %\121-�ѻ���:'..v.name..'('..tostring(n)..'/'..tostring(v.num)..')\r\n'
					else
						str = str..'  %\25-�ѻ���:'..v.name..'('..tostring(n)..'/'..tostring(v.num)..')\r\n'
					end
				end				
			end
		end
		str=str..'%0'
		table.push(strTips,str)
		return true		
	end,
}
