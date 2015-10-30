-- 套装
SuitEquipAttriTable = 
{
	-- 套装ID
	[1] = 
	{
		-- 套装元素的个数
		[2] = 
		{
			--属性的 type, value
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

--计算套装属性(wSuitEquipID-套装ID， bySuitNum-套装单元数目)
function CalclulateSuitExtraAttribute(wSuitEquipID, bySuitNum)	
	local Tb = SuitEquipAttriTable[wSuitEquipID]
	if (type(Tb) ~= "table") then
		return false
	end
	
	-- 查找有效的加成属性
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
	
	-- 将有效数据放入一个表中，方便读取
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
