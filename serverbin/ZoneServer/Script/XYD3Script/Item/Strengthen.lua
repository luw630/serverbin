ProtectTS =
{
	{4010002,2,500}, 		 --成功符   欧冶子秘籍 列1 道具ID，列2 钱类型(1是银币,2是银两) 列数3 要扣的钱
	{4010001,2,50},  		 --保护石	玉髓
}
function LoadProtectTS()
	for k, v in pairs(ProtectTS)	do
		LoadProtectInfo( k, v[1], v[2], v[3] )
	end
end

LoadProtectTS()

--[[
	升等级的换算公式
--]]
function GetNextUpdateLevelItemID(ItemID)
	return ItemID + 1
end
--[[
	升品质的换算公式
--]]
function GetNextUpdateQualityItemID(ItemID)
	return ItemID + 1000
end
