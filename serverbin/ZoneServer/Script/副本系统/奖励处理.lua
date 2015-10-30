
--[[
/*
result = {
	Exp,
	Money,
	ItemList = {}		(itemIDX -> ItemCount)
}

*/
--]]

if ������������� == nil then
	������������� = {
		Award = function (taskID, playerData)
			local copySceneConfig = ��������[taskID]
			if copySceneConfig == nil then
				return false, 'û�ж�Ӧ��������'
			end
			
			local result = {}
			for k, param in pairs(copySceneConfig.����) do
				local func = �������������[k]
				if func ~= nil then
					func(param, result)
				end
			end
			
			playerData.Complete = {
				['TaskID'] = taskID,
				['Award'] = result
			}
			
			return true
			
		end,
		
		Exp = function (exp, result)
			if type(exp) == 'number' then
				result.Exp = exp
			end
		end,
		
		Money = function (money, result)
			if type(money) == 'number' then
				result.Money = money
			end
		end,
		
		ItemList = function (itemList, result)
			result.ItemList = {}
			local r = math.random(1, 100)
			for _, itemConfig in pairs(itemList) do
				local chance = itemConfig.����
				if r >= chance[1] and r <= chance[2] then
					local countChange = itemConfig.����
					result.ItemList[itemConfig.��ƷID] = math.random(countChange[1], countChange[2])
				end
			end
		end,
	}	
end