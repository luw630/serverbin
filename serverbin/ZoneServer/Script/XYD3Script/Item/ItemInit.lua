dofile("XYD3Script\\Item\\UseItemReCall.lua")
dofile("XYD3Script\\Item\\��������ص�.lua")
dofile("XYD3Script\\Item\\���ҵ��߻ص�.lua")
dofile("XYD3Script\\Item\\����ʹ�ûص�.lua")
dofile("XYD3Script\\Item\\���ʳɳ�����ʹ�ûص�.lua")
dofile("XYD3Script\\Item\\���ħ���ֵ��߻ص�.lua")
dofile("XYD3Script\\Item\\ItemFactorCfg.lua")
dofile("XYD3Script\\Item\\BlessItem.lua")
dofile("XYD3Script\\Item\\Strengthen.lua")
dofile("XYD3Script\\Item\\SuitEquipment.lua")
dofile("XYD3Script\\Item\\ExtendPackage.lua")
dofile("XYD3Script\\Item\\QiDaoHandle.lua")
dofile("XYD3Script\\Item\\GiftPacket.lua")
function InitItemFactor()
	-- ������ֵ����
	for k, v in pairs(ItemFactorPointTable) do
		for p, q in pairs(v) do
			SetItemValueFactor(k, p, q)
		end
	end

	-- �����ðٷ�����
	for k, v in pairs(ItemFactorPrecentTable) do
		for p, q in pairs(v) do
			SetItemPrecentFactor(k, p, q[1], q[2])
		end
	end
end
