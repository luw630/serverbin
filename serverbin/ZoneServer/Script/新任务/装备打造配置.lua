-- 宝石和显示图像的配置
function JWTypeImageMap(level)
	rfalse("查询宝石和图像，类型为:"..level)
	local TIMap = {}
	if (level >= 101 and level <= 130 ) then
		return "0023.spr"
	elseif (level >= 201 and level <= 230) then
		return "0034.spr"
	elseif (level >= 301 and level <= 330) then
		return "0035.spr"
	elseif (level >= 401 and level <= 430 ) then
		return "0036.spr"
	else
		return nil
	end
end

-- 检查装备等级和材料ID是否匹配
-- 函数逻辑为：通过装备等级查看材料是否匹配，如果匹配，则返回需要的材料数，否则返回nil
-- 函数调用者得到装备所需要的材料数后，可以检查拖入的材料数是否足够

-- 装备打孔配置 注：修改该配置，请一并修改下方的查询函数的配置
function CheckEMMatch(equipLevel, materialID)
	local EMMap = {}		-- Equipment<-->Material
	EMMap[1] = {1, 1}		-- 此处为了测试，ID改为1~8，以后修改为宝石的ID
	EMMap[2] = {2, 1}		--每个阶对应的材料ID和个数。
	EMMap[3] = {3, 1}
	EMMap[4] = {4, 1}
	EMMap[5] = {5, 1}
	EMMap[6] = {6, 1}
	EMMap[7] = {7, 1}
	EMMap[8] = {8, 1}

	-- 首先圆整等级
	local matchLevel = 0
	if (equipLevel <= 20 ) then
		matchLevel = 1
	elseif (equipLevel <= 40 ) then
		matchLevel = 2
	elseif (equipLevel <= 60 ) then
		matchLevel = 3
	elseif (equipLevel <= 80 ) then
		matchLevel = 4
	elseif (equipLevel <= 100 ) then
		matchLevel = 5
	elseif (equipLevel <= 120 ) then
		matchLevel = 6
	elseif (equipLevel <= 140 ) then
		matchLevel = 7
	elseif (equipLevel <= 150 ) then
		matchLevel = 8
	else
		return nil
	end

	local baseIndex = matchLevel
	for i=baseIndex, 8 do
		if (materialID == EMMap[i][1]) then
			rfalse(equipLevel.." Matches "..EMMap[i][1].." with the amount of "..EMMap[i][2])
			return EMMap[i][2]
		end
	end
	return nil
end
-- 装备打孔配置,该方法提供查询
function GetEMMatchMaterials(equipLevel)
	local EMMap = {}		-- Equipment<-->Material
	EMMap[1] = {1, 1}		-- 此处为了测试，ID改为1~8，以后修改为宝石的ID
	EMMap[2] = {2, 1}
	EMMap[3] = {3, 1}
	EMMap[4] = {4, 1}
	EMMap[5] = {5, 1}
	EMMap[6] = {6, 1}
	EMMap[7] = {7, 1}
	EMMap[8] = {8, 1}

	-- 首先圆整等级
	local matchLevel = 0
	if (equipLevel <= 20 ) then
		matchLevel = 1
	elseif (equipLevel <= 40 ) then
		matchLevel = 2
	elseif (equipLevel <= 60 ) then
		matchLevel = 3
	elseif (equipLevel <= 80 ) then
		matchLevel = 4
	elseif (equipLevel <= 100 ) then
		matchLevel = 5
	elseif (equipLevel <= 120 ) then
		matchLevel = 6
	elseif (equipLevel <= 140 ) then
		matchLevel = 7
	elseif (equipLevel <= 150 ) then
		matchLevel = 8
	else
		return nil
	end
	return EMMap[matchLevel][1],EMMap[matchLevel][2]
end

-- 取宝石配置, JewelID为宝石的ID
function TakeOutJMMap(JewelID)
	rfalse("查询取宝石配置的宝石ID为:"..JewelID)
	local JMMap = {}
	JMMap[101] = {1, 2}				-- 需要的材料ID + 材料数
	JMMap[201] = {1, 2}
	return JMMap[101]				--所有宝石都是用101的配置。
	--	return JMMap[JewelID]
end

解除装备绑定配置表 = {}
解除装备绑定配置表 =
{   --[[
	[1] =
	{
		equipLevel = 10,            --等级需求
		stuffID = 1,				--需要材料编号
		stuffNum = 1,				--需要材料个数
		needMoney = 0,				--需要金钱
	},   --]]
	[2] =
	{
		equipLevel = 20,            --等级需求
		stuffID = 1,				--需要材料编号
		stuffNum = 1,				--需要材料个数
		needMoney = 2,				--需要金钱
	},
	[3] =
	{
		equipLevel = 40,            --等级需求
		stuffID = 1,				--需要材料编号
		stuffNum = 2,				--需要材料个数
		needMoney = 0,				--需要金钱
	},
	[4] =
	{
		equipLevel = 80,           --等级需求
		stuffID = 1,				--需要材料编号
		stuffNum = 6,				--需要材料个数
		needMoney = 0,				--需要金钱
	},
}

装备绑定配置表 = {}
装备绑定配置表 =
{   --[[
	[1] =
	{
		equipLevel = 10,            --等级需求
		stuffID = 1,				--需要材料编号
		stuffNum = 1,				--需要材料个数
		needMoney = 0,				--需要金钱
	},  --]]
	[2] =
	{
		equipLevel = 10,            --等级需求
		stuffID = 1,				--需要材料编号
		stuffNum = 2,				--需要材料个数
		needMoney = 0,				--需要金钱
	},
	[3] =
	{
		equipLevel = 40,            --等级需求
		stuffID = 1,				--需要材料编号
		stuffNum = 4,				--需要材料个数
		needMoney = 0,				--需要金钱
	},
	[4] =
	{
		equipLevel = 80,           --等级需求
		stuffID = 1,				--需要材料编号
		stuffNum = 6,				--需要材料个数
		needMoney = 0,				--需要金钱
	},
}

function GetIconPath(iconID)
		curLen = 0
		retStr = ""
		retStr = "000" .. iconID .. ".spr"
		if((iconID / 10) > 1) then 
			curLen = 1
			retStr = "00" .. iconID .. ".spr"
		end
		if((iconID / 100) > 1) then 
			curLen = 2
			retStr = "0" .. iconID .. ".spr"
		end
		if((iconID / 1000) > 1) then 
			curLen = 3
			retStr = "" .. iconID .. ".spr"
		end
		 
		return retStr
end