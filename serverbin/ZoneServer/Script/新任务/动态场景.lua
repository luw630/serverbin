_onDynamicFinish = {}

--[[function CreateDynamicRegionxxx( regionid, putconf)
	local dyconf = ��̬�������ñ�[regionid] 
	if nil==dyconf then
		return
	end

	--��������
	rfalse("�����Ķ�̬����IDΪ:"..dyconf.��ͼid)
	local mapx = CreateRegion(dyconf.��ͼid)
	rfalse("MapXΪ:"..mapx)
	if nil==mapx then
		rfalse("������̬����ʧ��   " .. regionid)
		return
	end
	
	--����npc
	if type(dyconf.npc)==type({}) then
		for _, npcid in pairs(dyconf.npc) do
			local npcCreate = table.copy(����NPC���ñ�[npcid].NpcCreate)
			npcCreate.controlId = 100000+npcid
			npcCreate.clickScript = 30000
			npcCreate.regionId = mapx
			CreateObjectIndirect(npcCreate)
		end
	end

	--����Monster
	if type({})==type(dyconf.����) then
		for k, mCreate in pairs(dyconf.����) do
			local mc = table.copy(mCreate)
			mc.regionId = mapx
			CreateObjectIndirect( mc)
		end
	end
	
	if putconf==1 then
		rfalse("����:"..mapx.."�ڹ����������ҷ���ԭ���ĳ���")
		_onDynamicFinish[mapx] = 1
	elseif type({}) == type(putconf) then
		rfalse("����:"..mapx.."�ڹ�������󣬽������������"..putconf[1].."["..putconf[2].." "..putconf[3].."]")
		_onDynamicFinish[mapx] = putconf
	else
		-- �����κ�δ֪����������ǰ�����ͻ�ԭ���ĳ���
		rfalse("���棺δ���ù���������Ķ�����������ԭ���ĳ���")
		_onDynamicFinish[mapx] = 1
	end
	
	return mapx
end--]]