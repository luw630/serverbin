--[[
file:	ConsumableProcess.lua
author:	Jonson
update:	2015-05-13
desc:萌斗三国的消耗品相关的处理逻辑
]]--

local _GoodsType = GoodsType
local _MysteriousChestConfig = MysteriousChestConfig
local _PurpleEquipmentChestConfig = PurpleEquipmentChestConfig
local _BlueEquipmentChestConfig = BlueEquipmentChestConfig
local _GreenEquipmentChestConfig = GreenEquipmentChestConfig
local _HeroSoulChestConfig = HeroSoulChestConfig
local _QqunChestConfig = QqunChestConfig
local _MidAutumnChestConfig = MidAutumnChestConfig
local _FledglingChestConfig = FledglingChestConfig

--使用体力药剂的处理
local function UseEndurancePotion(itemID, itemNum, itemAbility)
	--减少体力药剂的个数
	CI_DecGoods_SG(_GoodsType.item, itemID, itemNum, GoodsWay.itemUse)
	--增加对应的体力值
	CI_AddGoods_SG(_GoodsType.endurance, 0, itemNum * itemAbility, GoodsWay.itemUse)
	--告诉服务器使用了哪个物品，具体使用了多少
	CI_UseComsumable(_GoodsType.item, itemID, itemNum)
end

--使用技能点药剂的处理
local function UseSkillPointPotion(itemID, itemNum, itemAbility)
	--减少技能点药剂的个数
	CI_DecGoods_SG(_GoodsType.item, itemID, itemNum, GoodsWay.itemUse)
	--开始通知服务器端加技能点
	CI_AddSkillPoint(itemNum * itemAbility)
	--告诉服务器使用了哪个物品，具体使用了多少
	CI_UseComsumable(_GoodsType.item, itemID, itemNum)
end

--消耗品中的开带随机掉落的宝箱的逻辑处理
local function RandomChestProcess(itemID, itemNum, chestConfig)
	if type(chestConfig) ~= "table" or not chestConfig.totalWeight then
		return
	end
	
	local _totalWeight = chestConfig.totalWeight
	local _maxRandomCount = chestConfig.MaxRandomCount
	local itemTypePool = {}--用于将同种类型的物品归纳起来
	local itemPool = {}--用来缓存开宝箱开到的所有物品
	local achievedItemNum
	local randomValue
	itemPool.types = {}
	itemPool.id = {}
	itemPool.num = {}
	--将指定的宝箱的数量都一一打开
	for i = 1, itemNum do
		--随机出这次开宝箱最多会开出多少个物件
		achievedItemNum = math.random(_maxRandomCount)
		for j = 1, achievedItemNum do
			randomValue = math.random(_totalWeight)
			
			--开始遍历宝箱会掉落的物品配置表
			for _,itemInfor in ipairs(chestConfig) do
				--获得本物品的配的几率，暂时不判断策划配置的itemInfor是否严格符合要求，提高性能
				if randomValue <= itemInfor[1] then
					itemPool.types[i] = itemInfor[2][1]
					itemPool.id[i] = itemInfor[2][2]
					itemPool.num[i] = itemInfor[2][3]
					
					if itemNum == 1 and achievedItemNum == 1 then
						CI_AddGoods_SG(itemPool.types[1], itemPool.id[1], itemPool.num[1], GoodsWay.itemUse)
						break
					end
					
					--将同种类型的物品集合起来
					itemTypePool[itemPool.types[i]] = itemTypePool[itemPool.types[i]] or {}
					itemTypePool[itemPool.types[i]].num = itemTypePool[itemPool.types[i]].num or {}
					itemTypePool[itemPool.types[i]].id = itemTypePool[itemPool.types[i]].id or {}
					
					if not itemTypePool[itemPool.types[i]].num[itemPool.id[i]] then
						itemTypePool[itemPool.types[i]].num[itemPool.id[i]] = itemPool.num[i] 
						itemTypePool[itemPool.types[i]].id[itemPool.id[i]] = itemPool.id[i]
					else
						itemTypePool[itemPool.types[i]].num[itemPool.id[i]] = itemTypePool[itemPool.types[i]].num[itemPool.id[i]] +  itemPool.num[i]
					end
					break
				end
			end
			
		end
		
	end
	
	--判断是否可以走批量加开出的物品的逻辑
	if itemNum ~= 1 or achievedItemNum ~= 1 then
		for iType, subTab in pairs(itemTypePool) do
			if subTab ~= nil then
				CI_AddGoodsArray_SG(iType, subTab.id, subTab.num,GoodsWay.itemUse)
			end
		end
	end
	
	--暂时以此种方法判断是否掉落了东西
	if not itemPool.types[1] or not itemPool.id[1] or not itemPool.num[1] then
		return
	end
	
	--删掉对应的宝箱
	CI_DecGoods_SG(_GoodsType.item, itemID, itemNum,GoodsWay.itemUse)
	--交由服务器统一添加所有获得物品，并回发给客户端相关信息
	CI_UseComsumable(itemPool.types, itemPool.id, itemPool.num)
end

--消耗品中的开固定掉落的宝箱的逻辑处理
local function SimpleChestProcess(itemID, itemNum, chestConfig)
	local chestItemNum = 0 --记录宝箱掉落的物品的个数
	local itemTypePool = {}--用于将同种类型的物品归纳起来
	local itemPool = {}--用来缓存开宝箱开到的所有物品
	itemPool.types = {}
	itemPool.id = {}
	itemPool.num = {}
	--将指定的宝箱的数量都一一打开
	for i = 1, itemNum do
		--开始遍历宝箱会掉落的物品列表
		for index, itemInfor in ipairs(chestConfig) do
			chestItemNum = chestItemNum + 1
			--获得本宝箱掉落的物品
			itemPool.types[index] = itemInfor[1]
			itemPool.id[index] = itemInfor[2]
			itemPool.num[index] = (itemPool.num[index] or 0) + itemInfor[3]
			--将同种类型的物品集合起来
			itemTypePool[itemPool.types[index]] = itemTypePool[itemPool.types[index]] or {}
			itemTypePool[itemPool.types[index]].num = itemTypePool[itemPool.types[index]].num or {}
			itemTypePool[itemPool.types[index]].id = itemTypePool[itemPool.types[index]].id or {}
			
			if not itemTypePool[itemPool.types[index]].num[itemPool.id[index]] then
				itemTypePool[itemPool.types[index]].num[itemPool.id[index]] = itemPool.num[index] 
				itemTypePool[itemPool.types[index]].id[itemPool.id[index]] = itemPool.id[index]
			else
				itemTypePool[itemPool.types[index]].num[itemPool.id[index]] = itemTypePool[itemPool.types[index]].num[itemPool.id[index]] +  itemInfor[3]
			end
		end
	end
	
	--判断是否可以走批量加开出的物品的逻辑
	if itemNum ~= 1 or chestItemNum ~= 1 then
		for iType, subTab in pairs(itemTypePool) do
			if subTab ~= nil then
				CI_AddGoodsArray_SG(iType, subTab.id, subTab.num, GoodsWay.itemUse)
			end
		end
	end
	--删掉对应的宝箱
	CI_DecGoods_SG(_GoodsType.item, itemID, itemNum, GoodsWay.itemUse)
	--交由服务器统一添加所有获得物品，并回发给客户端相关信息
	CI_UseComsumable(itemPool.types, itemPool.id, itemPool.num)
end

--开神秘宝箱的处理
local function openMysteriousChest(itemID, itemNum)
	RandomChestProcess(itemID, itemNum, _MysteriousChestConfig)
end

--开紫色宝箱的处理
local function openPurpleEquipChest(itemID, itemNum)
	RandomChestProcess(itemID, itemNum, _PurpleEquipmentChestConfig)
end

--开蓝色宝箱的处理
local function openBlueEquipChest(itemID, itemNum)
	RandomChestProcess(itemID, itemNum, _BlueEquipmentChestConfig)
end

--开绿色宝箱的处理
local function openGreenEquipChest(itemID, itemNum)
	RandomChestProcess(itemID, itemNum, _GreenEquipmentChestConfig)
end

--开简单宝箱的处理
local function openSimpleChest(itemID, itemNum)
	SimpleChestProcess(itemID, itemNum, _QqunChestConfig)
end

--开英雄将魂宝箱的处理
local function openHeroSoulChest(itemID, itemNum)
	RandomChestProcess(itemID, itemNum, _HeroSoulChestConfig)
end

--开启中秋宝箱的处理
local function openMidAutumnChest(itemID, itemNum)
	RandomChestProcess(itemID, itemNum, _MidAutumnChestConfig)
end

--开启初出茅庐宝箱的处理
local function openFledglingChest(itemID, itemNum)
	RandomChestProcess(itemID, itemNum, _FledglingChestConfig)
end

--存好使用消耗品的处理逻辑
ComsumableProcessor = {
	[20011] = UseEndurancePotion, --使用体力药剂，key值为体力药剂的ID名
	[20012] = openMysteriousChest,--开启神秘宝箱，key值为神秘宝箱的ID名
	[20013] = openPurpleEquipChest,--开启紫色宝箱，key值为紫色宝箱的ID名
	[20014] = openBlueEquipChest,--开启蓝色宝箱，key值为蓝色宝箱的ID名
	[20015] = openGreenEquipChest,--开启绿色宝箱，key值为绿色宝箱的ID名
	[20016] = openSimpleChest,--开启简单的宝箱，key值为将魂宝箱的ID名
	[20017] = openHeroSoulChest,--开启将魂宝箱，key值为将魂宝箱的ID名
	[20018] = UseSkillPointPotion,--使用技能点药剂，key值为技能点药剂的ID名
	[20019] = openMidAutumnChest,--开启中秋宝箱,key值为中秋宝箱的ID名
	[20020] = openFledglingChest,--开启初出茅庐宝箱,key值为初出茅庐宝箱的ID名
}

return ComsumableProcessor