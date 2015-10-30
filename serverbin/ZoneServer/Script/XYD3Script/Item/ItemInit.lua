dofile("XYD3Script\\Item\\UseItemReCall.lua")
dofile("XYD3Script\\Item\\新手礼包回调.lua")
dofile("XYD3Script\\Item\\货币道具回调.lua")
dofile("XYD3Script\\Item\\回神丹使用回调.lua")
dofile("XYD3Script\\Item\\体质成长道具使用回调.lua")
dofile("XYD3Script\\Item\\活动天魔入侵道具回调.lua")
dofile("XYD3Script\\Item\\ItemFactorCfg.lua")
dofile("XYD3Script\\Item\\BlessItem.lua")
dofile("XYD3Script\\Item\\Strengthen.lua")
dofile("XYD3Script\\Item\\SuitEquipment.lua")
dofile("XYD3Script\\Item\\ExtendPackage.lua")
dofile("XYD3Script\\Item\\QiDaoHandle.lua")
dofile("XYD3Script\\Item\\GiftPacket.lua")
function InitItemFactor()
	-- 先配置值修正
	for k, v in pairs(ItemFactorPointTable) do
		for p, q in pairs(v) do
			SetItemValueFactor(k, p, q)
		end
	end

	-- 再配置百分修正
	for k, v in pairs(ItemFactorPrecentTable) do
		for p, q in pairs(v) do
			SetItemPrecentFactor(k, p, q[1], q[2])
		end
	end
end
