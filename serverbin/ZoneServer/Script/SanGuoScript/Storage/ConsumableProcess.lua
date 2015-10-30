--[[
file:	ConsumableProcess.lua
author:	Jonson
update:	2015-05-13
desc:�ȶ�����������Ʒ��صĴ����߼�
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

--ʹ������ҩ���Ĵ���
local function UseEndurancePotion(itemID, itemNum, itemAbility)
	--��������ҩ���ĸ���
	CI_DecGoods_SG(_GoodsType.item, itemID, itemNum, GoodsWay.itemUse)
	--���Ӷ�Ӧ������ֵ
	CI_AddGoods_SG(_GoodsType.endurance, 0, itemNum * itemAbility, GoodsWay.itemUse)
	--���߷�����ʹ�����ĸ���Ʒ������ʹ���˶���
	CI_UseComsumable(_GoodsType.item, itemID, itemNum)
end

--ʹ�ü��ܵ�ҩ���Ĵ���
local function UseSkillPointPotion(itemID, itemNum, itemAbility)
	--���ټ��ܵ�ҩ���ĸ���
	CI_DecGoods_SG(_GoodsType.item, itemID, itemNum, GoodsWay.itemUse)
	--��ʼ֪ͨ�������˼Ӽ��ܵ�
	CI_AddSkillPoint(itemNum * itemAbility)
	--���߷�����ʹ�����ĸ���Ʒ������ʹ���˶���
	CI_UseComsumable(_GoodsType.item, itemID, itemNum)
end

--����Ʒ�еĿ����������ı�����߼�����
local function RandomChestProcess(itemID, itemNum, chestConfig)
	if type(chestConfig) ~= "table" or not chestConfig.totalWeight then
		return
	end
	
	local _totalWeight = chestConfig.totalWeight
	local _maxRandomCount = chestConfig.MaxRandomCount
	local itemTypePool = {}--���ڽ�ͬ�����͵���Ʒ��������
	local itemPool = {}--�������濪���俪����������Ʒ
	local achievedItemNum
	local randomValue
	itemPool.types = {}
	itemPool.id = {}
	itemPool.num = {}
	--��ָ���ı����������һһ��
	for i = 1, itemNum do
		--�������ο��������Ὺ�����ٸ����
		achievedItemNum = math.random(_maxRandomCount)
		for j = 1, achievedItemNum do
			randomValue = math.random(_totalWeight)
			
			--��ʼ���������������Ʒ���ñ�
			for _,itemInfor in ipairs(chestConfig) do
				--��ñ���Ʒ����ļ��ʣ���ʱ���жϲ߻����õ�itemInfor�Ƿ��ϸ����Ҫ���������
				if randomValue <= itemInfor[1] then
					itemPool.types[i] = itemInfor[2][1]
					itemPool.id[i] = itemInfor[2][2]
					itemPool.num[i] = itemInfor[2][3]
					
					if itemNum == 1 and achievedItemNum == 1 then
						CI_AddGoods_SG(itemPool.types[1], itemPool.id[1], itemPool.num[1], GoodsWay.itemUse)
						break
					end
					
					--��ͬ�����͵���Ʒ��������
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
	
	--�ж��Ƿ�����������ӿ�������Ʒ���߼�
	if itemNum ~= 1 or achievedItemNum ~= 1 then
		for iType, subTab in pairs(itemTypePool) do
			if subTab ~= nil then
				CI_AddGoodsArray_SG(iType, subTab.id, subTab.num,GoodsWay.itemUse)
			end
		end
	end
	
	--��ʱ�Դ��ַ����ж��Ƿ�����˶���
	if not itemPool.types[1] or not itemPool.id[1] or not itemPool.num[1] then
		return
	end
	
	--ɾ����Ӧ�ı���
	CI_DecGoods_SG(_GoodsType.item, itemID, itemNum,GoodsWay.itemUse)
	--���ɷ�����ͳһ������л����Ʒ�����ط����ͻ��������Ϣ
	CI_UseComsumable(itemPool.types, itemPool.id, itemPool.num)
end

--����Ʒ�еĿ��̶�����ı�����߼�����
local function SimpleChestProcess(itemID, itemNum, chestConfig)
	local chestItemNum = 0 --��¼����������Ʒ�ĸ���
	local itemTypePool = {}--���ڽ�ͬ�����͵���Ʒ��������
	local itemPool = {}--�������濪���俪����������Ʒ
	itemPool.types = {}
	itemPool.id = {}
	itemPool.num = {}
	--��ָ���ı����������һһ��
	for i = 1, itemNum do
		--��ʼ���������������Ʒ�б�
		for index, itemInfor in ipairs(chestConfig) do
			chestItemNum = chestItemNum + 1
			--��ñ�����������Ʒ
			itemPool.types[index] = itemInfor[1]
			itemPool.id[index] = itemInfor[2]
			itemPool.num[index] = (itemPool.num[index] or 0) + itemInfor[3]
			--��ͬ�����͵���Ʒ��������
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
	
	--�ж��Ƿ�����������ӿ�������Ʒ���߼�
	if itemNum ~= 1 or chestItemNum ~= 1 then
		for iType, subTab in pairs(itemTypePool) do
			if subTab ~= nil then
				CI_AddGoodsArray_SG(iType, subTab.id, subTab.num, GoodsWay.itemUse)
			end
		end
	end
	--ɾ����Ӧ�ı���
	CI_DecGoods_SG(_GoodsType.item, itemID, itemNum, GoodsWay.itemUse)
	--���ɷ�����ͳһ������л����Ʒ�����ط����ͻ��������Ϣ
	CI_UseComsumable(itemPool.types, itemPool.id, itemPool.num)
end

--�����ر���Ĵ���
local function openMysteriousChest(itemID, itemNum)
	RandomChestProcess(itemID, itemNum, _MysteriousChestConfig)
end

--����ɫ����Ĵ���
local function openPurpleEquipChest(itemID, itemNum)
	RandomChestProcess(itemID, itemNum, _PurpleEquipmentChestConfig)
end

--����ɫ����Ĵ���
local function openBlueEquipChest(itemID, itemNum)
	RandomChestProcess(itemID, itemNum, _BlueEquipmentChestConfig)
end

--����ɫ����Ĵ���
local function openGreenEquipChest(itemID, itemNum)
	RandomChestProcess(itemID, itemNum, _GreenEquipmentChestConfig)
end

--���򵥱���Ĵ���
local function openSimpleChest(itemID, itemNum)
	SimpleChestProcess(itemID, itemNum, _QqunChestConfig)
end

--��Ӣ�۽��걦��Ĵ���
local function openHeroSoulChest(itemID, itemNum)
	RandomChestProcess(itemID, itemNum, _HeroSoulChestConfig)
end

--�������ﱦ��Ĵ���
local function openMidAutumnChest(itemID, itemNum)
	RandomChestProcess(itemID, itemNum, _MidAutumnChestConfig)
end

--��������é®����Ĵ���
local function openFledglingChest(itemID, itemNum)
	RandomChestProcess(itemID, itemNum, _FledglingChestConfig)
end

--���ʹ������Ʒ�Ĵ����߼�
ComsumableProcessor = {
	[20011] = UseEndurancePotion, --ʹ������ҩ����keyֵΪ����ҩ����ID��
	[20012] = openMysteriousChest,--�������ر��䣬keyֵΪ���ر����ID��
	[20013] = openPurpleEquipChest,--������ɫ���䣬keyֵΪ��ɫ�����ID��
	[20014] = openBlueEquipChest,--������ɫ���䣬keyֵΪ��ɫ�����ID��
	[20015] = openGreenEquipChest,--������ɫ���䣬keyֵΪ��ɫ�����ID��
	[20016] = openSimpleChest,--�����򵥵ı��䣬keyֵΪ���걦���ID��
	[20017] = openHeroSoulChest,--�������걦�䣬keyֵΪ���걦���ID��
	[20018] = UseSkillPointPotion,--ʹ�ü��ܵ�ҩ����keyֵΪ���ܵ�ҩ����ID��
	[20019] = openMidAutumnChest,--�������ﱦ��,keyֵΪ���ﱦ���ID��
	[20020] = openFledglingChest,--��������é®����,keyֵΪ����é®�����ID��
}

return ComsumableProcessor