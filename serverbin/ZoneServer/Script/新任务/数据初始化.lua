function InitTaskNpc()
	if RemoveObjectIndirect == nil then
		return
	end
	
	for k, v in pairs(����NPC���ñ�) do
		if k<DYN_NPC_ID then
			v.NpcCreate.controlId = 100000 + k
			v.NpcCreate.clickScript = 30000
			RemoveObjectIndirect(v.NpcCreate.regionId, v.NpcCreate.controlId)
			CreateObjectIndirect(v.NpcCreate)
		end
	end
	rfalse("������NPC������ϣ�")
end

--[[
-- ͨ���������,������񻷽ں�NPC�Ĺ����ԣ�
function InitTaskNpcRelations()
	local taskCount = 0
	for k,v in ipairs( ����� ) do -- k=����id v=������������
		for sk,sv in pairs( v ) do -- sk=������ sv=�ò�������������
			taskCount = taskCount+1
			if( type(sk) == "number" and type(sv) == "table" )then
				if sv.������npcid ~= nil then
					npc = ����NPC���ñ�[sv.������npcid]
					if( npc ~= nil )then -- ����NPC��������ǰ�ľ�NPC
						local tabName, taskKey
						--���������
						tabName = 'taskRelation'
						taskKey = k * 100000 + sk --����id*100000 + ������ID

						if npc[tabName] == nil then
							npc[tabName] = {}
						end

						npc[tabName][ taskKey ] = 1 -- ���������NPC���ϲ�������������һ��
					else
						rfalse( "���������NPCû������:taskid="..k.." npcid="..tostring(sv.npcid).." subid="..sk )
					end
				end
			end
		end
	end
	rfalse("����������="..taskCount)
end
--]]

--InitTaskNpc()
--InitTaskNpcRelations()

--��ʼ����������
function initRingTaskLib()
	for _,lib in pairs(�ܻ������) do
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
	
	for mainid,maintask in pairs(�����) do
		for subid,task in pairs(maintask) do
			if TableHasKeys(task, {"�������", "me"}) then
				local me = task.�������.me
				for k, v in pairs(me) do
					--���
					local id = ( v[1] * 1000 + v[2] ) * 1000 + v[3]
					_fastExtend( id, mainid,subid, k)
					
					--����Trigger
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
