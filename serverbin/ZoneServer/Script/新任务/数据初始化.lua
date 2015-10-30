function InitTaskNpc()
	if RemoveObjectIndirect == nil then
		return
	end
	
	for k, v in pairs(任务NPC配置表) do
		if k<DYN_NPC_ID then
			v.NpcCreate.controlId = 100000 + k
			v.NpcCreate.clickScript = 30000
			RemoveObjectIndirect(v.NpcCreate.regionId, v.NpcCreate.controlId)
			CreateObjectIndirect(v.NpcCreate)
		end
	end
	rfalse("新任务NPC配置完毕！")
end

--[[
-- 通过主任务表,检测任务环节和NPC的关联性！
function InitTaskNpcRelations()
	local taskCount = 0
	for k,v in ipairs( 任务表 ) do -- k=任务id v=任务配置数据
		for sk,sv in pairs( v ) do -- sk=任务步骤 sv=该步任务配置数据
			taskCount = taskCount+1
			if( type(sk) == "number" and type(sv) == "table" )then
				if sv.接任务npcid ~= nil then
					npc = 任务NPC配置表[sv.接任务npcid]
					if( npc ~= nil )then -- 任务NPC可能用以前的旧NPC
						local tabName, taskKey
						--任务关联表
						tabName = 'taskRelation'
						taskKey = k * 100000 + sk --任务id*100000 + 子任务ID

						if npc[tabName] == nil then
							npc[tabName] = {}
						end

						npc[tabName][ taskKey ] = 1 -- 可以在这个NPC身上操作这个任务的这一步
					else
						rfalse( "任务关联的NPC没有配置:taskid="..k.." npcid="..tostring(sv.npcid).." subid="..sk )
					end
				end
			end
		end
	end
	rfalse("新任务数量="..taskCount)
end
--]]

--InitTaskNpc()
--InitTaskNpcRelations()

--初始化任务库分类
function initRingTaskLib()
	for _,lib in pairs(跑环任务库) do
		lib.libType = {}
		for k2,v2 in pairs(lib) do
			if type(0)==type(k2) then
				local tp = v2[1]
				if nil==lib.libType[tp] then
					lib.libType[tp] = {}
				end
				table.push(lib.libType[tp], k2)
			end
		end
	end
end
initRingTaskLib()

function initTaskTrigger()
	_fastMETable ={}
	function _fastExtend(id, m, s, index)
		if nil==_fastMETable[id] then
			_fastMETable[id]= {}
		end
		table.push(_fastMETable[id], {GetTaskId(m,s), index} )
	end
	
	for mainid,maintask in pairs(任务表) do
		for subid,task in pairs(maintask) do
			if TableHasKeys(task, {"完成条件", "me"}) then
				local me = task.完成条件.me
				for k, v in pairs(me) do
					--添加
					local id = ( v[1] * 1000 + v[2] ) * 1000 + v[3]
					_fastExtend( id, mainid,subid, k)
					
					--设置Trigger
					rfalse("SetMapEvent : " .. id)
					SetMapEvent(v[1], v[2], v[3], 30000, v[4], id)					
				end
			end	
		end
	end
	
	dbMgr.ShowTable(_fastMETable, rfalse)
end

initTaskTrigger()
initToObjItems()
