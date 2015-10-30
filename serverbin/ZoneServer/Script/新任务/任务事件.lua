
任务事件表 = {
	OnEvent = function(events,taskData,taskid)
		for k,v in pairs(events) do
			任务事件表[k](v,taskData,taskid)
		end
	end,

	items = function(opData,taskData,taskid)
		if opData == nil then
			rfasle("opData is nil")
			return false
		end


		if type(opData[1])~='table' then
			GiveGoods(opData[1],opData[2])
			return true
		end

		for k,v in pairs(opData) do
			GiveGoods(v[1],v[2])
		end	

		return true
	end,

	callFunction = function(functionName)
		_G[functionName]()
	end
}
