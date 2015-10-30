DynamicNpcTable = {}
dofile("XYD3Script\\Npc\\DynamicNpc\\动态模型.lua")
-- 动态创建NPC的Wrap函数
function DynamicCreateNpc(npcid, region, x, y, liveTime)
	if (nil == DynamicNpcTable[npcid]) then
		return
	end
	
	DynamicNpcTable[npcid].NpcCreate.regionId 		= region
	DynamicNpcTable[npcid].NpcCreate.x 				= x
	DynamicNpcTable[npcid].NpcCreate.y 				= y
	DynamicNpcTable[npcid].NpcCreate.LiveTime 		= liveTime	
	DynamicNpcTable[npcid].NpcCreate.controlId  	= 0
	DynamicNpcTable[npcid].NpcCreate.clickScript 	= npcid
		
	CreateObjectIndirect(DynamicNpcTable[npcid].NpcCreate)
	return
end