--���ʹ������Ľű�����
function AddItem_С��Ѫҩ( )
	local rt = nil;
	if( GetPlayerData(PlayerProperty.MP)>=0 ) then
		Dismount( )			--����
		rt = GiveGoods(1,1)	--��һ��С��Ѫҩ		
		if rt==1 then AddPlayerProperty(0,0,0) end --����10����
		return 1;
	else 
		SetTips("MPֵ����,�޷�ʹ�ü���")
		return 0;
	end	
end

SkillTable = {
[500] = AddItem_С��Ѫҩ,
}

function UseMountSkill( skillId )
	local rt = 0;
	if(SkillTable[skillId] ~= nil) then
		rt = SkillTable[skillId]()
	end
	return rt;
end

