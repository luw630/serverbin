
--[[
/*
result = {
	Exp,
	Money,
	ItemList = {}		(itemIDX -> ItemCount)
}

*/
--]]

if 副本奖励处理表 == nil then
	副本奖励处理表 = {
		Award = function (taskID, playerData)
			local copySceneConfig = 副本配置[taskID]
			if copySceneConfig == nil then
				return false, '没有对应副本配置'
			end
			
			local result = {}
			for k, param in pairs(copySceneConfig.奖励) do
				local func = 副本奖励处理表[k]
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
				local chance = itemConfig.概率
				if r >= chance[1] and r <= chance[2] then
					local countChange = itemConfig.数量
					result.ItemList[itemConfig.物品ID] = math.random(countChange[1], countChange[2])
				end
			end
		end,
	}	
end