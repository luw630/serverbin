dofile("XYD3Script\\Npc\\GatherNpc\\弑魂任务采集用模型.lua")
function CollectIt(NpcID)
	StartCollect(NpcID, NpcTable[NpcID].Collect.preTime, NpcTable[NpcID].NpcCreate.x, NpcTable[NpcID].NpcCreate.y, NpcTable[NpcID].Collect.callback)
end
