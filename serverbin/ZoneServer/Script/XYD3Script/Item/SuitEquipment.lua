-- ��װ
SuitEquipAttriTable = 
{
	-- ��װID
	[1] = 
	{
		-- ��װԪ�صĸ���
		[2] = 
		{
			--���Ե� type, value
			{tp = 0, val = 10},
			{tp = 3, val = 5},
		},
		[4] = 
		{
			{tp = 0, val = 11},
			{tp = 3, val = 9},
			{tp = 4, val = 8},			
		},
	},
	[2] = 
	{
		[2] =
		{
			{tp = 1, val = 3},
			{tp = 2, val = 12},			
		},
		[10] =
		{
			{tp = 11, val = 4},
			{tp = 12, val = 2},			
		},
	}	
}

--������װ����(wSuitEquipID-��װID�� bySuitNum-��װ��Ԫ��Ŀ)
function CalclulateSuitExtraAttribute(wSuitEquipID, bySuitNum)	
	local Tb = SuitEquipAttriTable[wSuitEquipID]
	if (type(Tb) ~= "table") then
		return false
	end
	
	-- ������Ч�ļӳ�����
	local TAttri = nil
	local VaildSuitNum = bySuitNum
	while VaildSuitNum >= 0 do 
		if (type(Tb[VaildSuitNum]) == "table") then
			TAttri = Tb[VaildSuitNum]
			break
		end	
		VaildSuitNum = VaildSuitNum - 1	
	end
	if TAttri == nil then
		return false	
	end		
	
	-- ����Ч���ݷ���һ�����У������ȡ
	local tmpT = {}
	local tmpnum = 0
	for i,v in ipairs(TAttri) do
		if (type(v) == "table") then						
			tmpT[(tmpnum*2)+1] = v.tp
			tmpT[(tmpnum*2)+2] = v.val
			tmpnum = tmpnum + 1			
		end
	end
	
	if (tmpnum > 0) then
		ModifyPlayerAttributes(tmpT)
	end	
	return true
end
