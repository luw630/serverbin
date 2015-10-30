--[[
file:	StorageOperation.lua
author:	Jonson
update:	2015-05-13
desc:�ȶ������ı�����������߼�
]]--

local useComsumableProcessor = ComsumableProcessor
--ʹ������Ʒ�Ĵ���args��itemID����ʹ�õ�����Ʒ��ID��itemNum����ʹ�ö��ٸ�����Ʒ��itemAblity����ʹ�õ�����Ʒ������������Ӷ���Ѫ���Ӷ�������
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