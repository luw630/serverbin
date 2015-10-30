--玩家使用坐骑的脚本技能
function AddItem_小回血药( )
	local rt = nil;
	if( GetPlayerData(PlayerProperty.MP)>=0 ) then
		Dismount( )			--下马
		rt = GiveGoods(1,1)	--给一个小回血药		
		if rt==1 then AddPlayerProperty(0,0,0) end --消耗10点蓝
		return 1;
	else 
		SetTips("MP值不够,无法使用技能")
		return 0;
	end	
end

SkillTable = {
[500] = AddItem_小回血药,
}

function UseMountSkill( skillId )
	local rt = 0;
	if(SkillTable[skillId] ~= nil) then
		rt = SkillTable[skillId]()
	end
	return rt;
end

