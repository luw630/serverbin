dofile("XYD3Script\\Npc\\GatherNpc\\߱������ɼ���ģ��.lua")
function CollectIt(NpcID)
	StartCollect(NpcID, NpcTable[NpcID].Collect.preTime, NpcTable[NpcID].NpcCreate.x, NpcTable[NpcID].NpcCreate.y, NpcTable[NpcID].Collect.callback)
end
