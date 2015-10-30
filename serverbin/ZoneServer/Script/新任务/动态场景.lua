_onDynamicFinish = {}

--[[function CreateDynamicRegionxxx( regionid, putconf)
	local dyconf = 动态场景配置表[regionid] 
	if nil==dyconf then
		return
	end

	--创建场景
	rfalse("创建的动态场景ID为:"..dyconf.地图id)
	local mapx = CreateRegion(dyconf.地图id)
	rfalse("MapX为:"..mapx)
	if nil==mapx then
		rfalse("创建动态场景失败   " .. regionid)
		return
	end
	
	--创建npc
	if type(dyconf.npc)==type({}) then
		for _, npcid in pairs(dyconf.npc) do
			local npcCreate = table.copy(任务NPC配置表[npcid].NpcCreate)
			npcCreate.controlId = 100000+npcid
			npcCreate.clickScript = 30000
			npcCreate.regionId = mapx
			CreateObjectIndirect(npcCreate)
		end
	end

	--创建Monster
	if type({})==type(dyconf.怪物) then
		for k, mCreate in pairs(dyconf.怪物) do
			local mc = table.copy(mCreate)
			mc.regionId = mapx
			CreateObjectIndirect( mc)
		end
	end
	
	if putconf==1 then
		rfalse("场景:"..mapx.."在怪物死完后，玩家返回原来的场景")
		_onDynamicFinish[mapx] = 1
	elseif type({}) == type(putconf) then
		rfalse("场景:"..mapx.."在怪物死完后，将玩家送至场景"..putconf[1].."["..putconf[2].." "..putconf[3].."]")
		_onDynamicFinish[mapx] = putconf
	else
		-- 其他任何未知的情况，都是把玩家送回原来的场景
		rfalse("警告：未设置怪物死亡后的动作，将返回原来的场景")
		_onDynamicFinish[mapx] = 1
	end
	
	return mapx
end--]]