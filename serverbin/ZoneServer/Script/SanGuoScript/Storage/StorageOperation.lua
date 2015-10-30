--[[
file:	StorageOperation.lua
author:	Jonson
update:	2015-05-13
desc:萌斗三国的背包操作相关逻辑
]]--

local useComsumableProcessor = ComsumableProcessor
--使用消耗品的处理，args：itemID代表使用的消耗品的ID，itemNum代表使用多少个消耗品，itemAblity代表使用的消耗品的能力，比如加多少血，加多少体力
function SI_UseComsumable(itemID, itemNum, itemAblity)
	if useComsumableProcessor ==  nil then
		return
	end
	local processor = useComsumableProcessor[itemID]
	if processor == nil then
		return
	end
	
	processor(itemID, itemNum, itemAblity)
end