--dofile("XYD3Script\\Npc\\X3_Normal\\NormalNpcInit.lua")
dofile("XYD3Script\\Npc\\NormalNpc\\NormalNpcInit.lua")
--dofile("XYD3Script\\Npc\\GatherNpc\\GatherNpcInit.lua")
function InitNpc()
	if nil == RemoveObjectIndirect then
		return
	end

	for k, v in pairs(NpcTable) do
		v.NpcCreate.controlId 	= k
		v.NpcCreate.clickScript = k
		RemoveObjectIndirect(v.NpcCreate.regionId, v.NpcCreate.controlId)
		CreateObjectIndirect(v.NpcCreate)
	end

	SetNpcGoodCount(0)

	for k, v in pairs(NpcSaleTable) do
		for p, q in pairs(v) do
			LoadItem(k, q[1], q[2])
		end
	end
end

InitNpc()

dofile("XYD3Script\\Npc\\DynamicNpc\\DynamicNpcInit.lua")
dofile("XYD3Script\\Npc\\NpcRecall\\CollectCallback.lua")
dofile("XYD3Script\\Npc\\NpcRecall\\MenuCallBack.lua")
dofile("XYD3Script\\Npc\\NpcRecall\\NpcCallBack.lua")

