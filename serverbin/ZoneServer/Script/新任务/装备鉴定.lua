dofile '新任务\\装备鉴定配置.lua'

CreateNpc(6, "装备鉴定",3,70,90,0,0,0,1099,0,3,7777)

function OnClick1099()
	QulifyEquip()
end

function QulifyEquip()
	wndQulifyEquip = wndQulifyEquip or
	{
		cleanup = true,
		image_1 = "100,100,interface/EquipConstruction/Qualify/装备鉴定.spr",
		image_2 = "",
		image_3 = "",
		
		text_10 = "",
		text_11 = "",
		text_12 = "",
		text_13 = "",
		text_14 = "",
		text_15 = "",
		text_16 = "",
		text_17 = "",
		text_18 = "",
		text_19 = "",
		text_20 = "",
		
		text_30 = "",
		text_31 = "",
		text_32 = "",
		text_33 = "",
		text_34 = "",
		text_35 = "",
		text_36 = "",
		text_37 = "",
		text_38 = "",
		text_39 = "",
		text_40 = "",
		
		text_50 = "118, 425, %\041请拖入您要鉴定的装备！",
		text_51 = "259, 376, %\041",
		text_52 = "353, 376, %\041",
		
		SprButton_20 = { pos = "423, 103", image = "interface/EquipConstruction/CommonBtn/面板按键关闭", action = "@E", ToolTip = "关闭" },
		SprButton_21 = { pos = "403, 103", image = "interface/EquipConstruction/CommonBtn/面板按键帮助", action = "", ToolTip = "帮助" },
		SprButton_22 = { pos = "185, 510", image = "interface/EquipConstruction/CommonBtn/按键确定", ToolTip = "开始鉴定", action = "@rc,4,@rv,5,@rv,6,@rv,7" },
		SprButton_23 = { pos = "300, 510", image = "interface/EquipConstruction/CommonBtn/按键取消", ToolTip = "取消鉴定", action = "@E" },
		
		ItemHolder_5 = { pos = "165, 376", dragable = true, action = "@rc,1,@rv,5,@rv,6,@rv,7" },	-- 装备
		ItemHolder_6 = { pos = "259, 376", dragable = false, action = "@rc,2,@rv,5,@rv,6" },		-- 材料
		ItemHolder_7 = { pos = "353, 376", dragable = false, action = "@rc,3,@rv,5,@rv,7" },		-- 记忆材料
		
		WndItem = { pos = "460,100", visiable = "true" },
		ChatPanel = {visiable = "true"}
	}
	WndCustomize(wndQulifyEquip, "QulifyEquipArg")
end

function QulifyEquipArg(ops, arg1, arg2, arg3, att1, att2, att3, att4, att5, att6, att7, att8, att9, att10, att11)
	if (ops == 1) then
		QECheckEquip(arg1)
	elseif (ops == 2) then
		QECheckMaterial(arg1, arg2)
	elseif (ops == 3) then
		QECheckMemMate(arg1, arg2)
	elseif (ops == 4) then
		StartQualify(arg1, arg2, arg3)
	elseif (ops == 40) then
		BindAtt(arg1, arg2, arg3, att1, att2, att3, att4, att5, att6, att7, att8, att9, att10, att11)
	elseif (ops == 41) then
		RollBackAtt(arg1, arg2, arg3)
	end
end

function RollBackAtt(equip, material, memmate)
	-- 表示用户要恢复原来的属性
	local temp = {}
	local equipDetail = GetItemDetails(equip)
	local materialDetail = GetItemDetails(material,true)
	local memmate = GetItemDetails(memmate,true)
	
	if (nil == equipDetail or nil == materialDetail or nil == memmate) then
		return
	end
	
	temp.text_50 = "118, 425, %\041恭喜，属性恢复成功！"
	
	temp.SprButton_20 = { pos = "423, 103", image = "interface/EquipConstruction/CommonBtn/面板按键关闭", action = "@E", ToolTip = "关闭" }
	temp.SprButton_22 = { pos = "185, 510", image = "interface/EquipConstruction/CommonBtn/按键确定", ToolTip = "开始鉴定", action = "@rc,4,@rv,5,@rv,6,@rv,7" }
	temp.SprButton_23 = { pos = "300, 510", image = "interface/EquipConstruction/CommonBtn/按键取消", ToolTip = "取消鉴定", action = "@E" }
	
	-- 重新显示
	local count = 1
	for i=1, 6 do
		rfalse("before is: "..equipDetail.qualitys[i])
		local real = equipDetail.qualitys[i] - rint(equipDetail.qualitys[i]/10000)*10000
		if (real ~= 0) then
			temp["text_"..(29+i)] = "305, "..(20*(count-1)+147)..", %\041"..(EquipAttNameMap[i]).."：%\169"..(real)..",8"
			count = count + 1
		else
			temp["text_"..(29+i)] = ""
		end
	end
	
	for i=1, 5 do
		local real = equipDetail.inherits[i] - rint(equipDetail.inherits[i]/10000)*10000
		if (real ~= 0 ) then
			temp["text_"..(35+i)] = "305, "..(20*(count-1)+147)..", %\041"..(EquipAttNameMap[i+6]).."：%\169"..(real)..",8"
			count = count + 1
		else
			temp["text_"..(35+i)] = ""
		end
	end
	
	UpdateCustomWnd(temp)
end

function BindAtt(equip, material, memmate, att1, att2, att3, att4, att5, att6, att7, att8, att9, att10, att11)
	-- 表示用户要绑定获得的属性
	local temp = {}
	local equipDetail = GetItemDetails(equip)
	local materialDetail = GetItemDetails(material,true)
	local memmate = GetItemDetails(memmate,true)
	
	if (nil == equipDetail or nil == materialDetail or nil == memmate) then
		return
	end
	
	-- 修改属性
	equipDetail.qualitys[1] = rint(equipDetail.qualitys[1]/10000)*10000 + att1
	equipDetail.qualitys[2] = rint(equipDetail.qualitys[2]/10000)*10000 + att2
	equipDetail.qualitys[3] = rint(equipDetail.qualitys[3]/10000)*10000 + att3
	equipDetail.qualitys[4] = rint(equipDetail.qualitys[4]/10000)*10000 + att4
	equipDetail.qualitys[5] = rint(equipDetail.qualitys[5]/10000)*10000 + att5
	equipDetail.qualitys[6] = rint(equipDetail.qualitys[6]/10000)*10000 + att6

	for i = 1, 6 do
		rfalse(equipDetail.qualitys[i])
	end
	
	equipDetail.inherits[1] = rint(equipDetail.inherits[1]/10000)*10000 + att7
	equipDetail.inherits[2] = rint(equipDetail.inherits[2]/10000)*10000 + att8
	equipDetail.inherits[3] = rint(equipDetail.inherits[3]/10000)*10000 + att9
	equipDetail.inherits[4] = rint(equipDetail.inherits[4]/10000)*10000 + att10
	equipDetail.inherits[5] = rint(equipDetail.inherits[5]/10000)*10000 + att11
	
	for i = 1, 5 do
		rfalse(equipDetail.inherits[i])
	end
	
	UpdateItemDetails(equip, equipDetail)
	
	temp.ItemHolder_5 = { pos = "165, 376", dragable = true, action = "@rc,1,@rv,5,@rv,6,@rv,7"}
	temp.ItemHolder_6 = { pos = "259, 376", dragable = false, action = "@rc,2,@rv,5,@rv,6" }
	temp.ItemHolder_7 = { pos = "353, 376", dragable = false, action = "@rc,3,@rv,5,@rv,7" }
	temp.text_51 = ""
	temp.text_52 = ""
	temp.image_2 = ""
	temp.image_3 = ""
	temp.text_50 = "118, 425, %\041恭喜，装备鉴定完毕！"
	
	temp.SprButton_20 = { pos = "423, 103", image = "interface/EquipConstruction/CommonBtn/面板按键关闭", action = "@E", ToolTip = "关闭" }
	temp.SprButton_22 = { pos = "185, 510", image = "interface/EquipConstruction/CommonBtn/按键确定", ToolTip = "开始鉴定", action = "@rc,4,@rv,5,@rv,6,@rv,7" }
	temp.SprButton_23 = { pos = "300, 510", image = "interface/EquipConstruction/CommonBtn/按键取消", ToolTip = "取消鉴定", action = "@E" }
	UpdateCustomWnd(temp)
end

function QECheckMemMate(equip, material)
	local equipDetail = GetItemDetails(equip)
	local mateDetail = GetItemDetails(material)
	if (nil == equipDetail or nil == mateDetail ) then
		return
	end
	
	local temp = {}
	
	local rank = EQGetEquipRank(equipDetail.levelEM)
	rfalse("鉴定此装备所需记忆材料ID为："..EquipQualifyMemoryMap[rank][1].."，个数为："..EquipQualifyMemoryMap[rank][2].."个")
	local needMate = EquipQualifyMemoryMap[rank][1]
	local needNum  = EquipQualifyMemoryMap[rank][2]
	local normalItemTable = {}
	normalItemTable = GetItemSetting(needMate)
	
	-- 检查材料是否符合，如果不符合，则弹出
	if (mateDetail.index ~= needMate) then
		temp.ItemHolder_7 = { pos = "353, 376", dragable = true, action = "@rc,3,@rv,5,@rv,7" }
		temp.text_50 = "118, 425, %\041记忆材料需要["..(normalItemTable.name).."]"..(needNum).."个！"
		temp.text_52 = ""
		temp.image_3 = ""
		UpdateCustomWnd(temp)
		return
	end
	
	-- 如果材料类型符合，则显示图标及所需数量
	temp.previous_7 = { itemid = needMate }
	temp.text_52 = "349, 376, %\041"..needNum
	
	-- 统计背包中是否有足够的材料
	if (0 == CheckGoods(needMate, needNum, 1)) then
		-- 不够
		temp.image_3 = "353,376,interface/EquipConstruction/黑框.spr"
		temp.text_50 = "118, 425, %\041记忆材料不足，无法记忆，需要["..(normalItemTable.name).."]"..(needNum).."个！"
		UpdateCustomWnd(temp)
		return
	end
	UpdateCustomWnd(temp)
end

function QECheckMaterial(equip, material)
	local equipDetail = GetItemDetails(equip)
	local mateDetail = GetItemDetails(material)
	if (nil == equipDetail or nil == mateDetail ) then
		return
	end
	
	local temp = {}
	
	-- 获取要鉴定此装备需要的材料ID和数目
	local rank = EQGetEquipRank(equipDetail.levelEM)
	rfalse("鉴定此装备所需材料ID为："..EquipQualifyMaterialMap[rank][1].."，个数为："..EquipQualifyMaterialMap[rank][2].."个")
	local needMate = EquipQualifyMaterialMap[rank][1]
	local needNum  = EquipQualifyMaterialMap[rank][2]
	local normalItemTable = {}
	normalItemTable = GetItemSetting(needMate)
		
	-- 检查材料是否符合，如果不符合，则弹出
	if (mateDetail.index ~= needMate) then
		temp.ItemHolder_6 = { pos = "259, 376", dragable = true, action = "@rc,2,@rv,5,@rv,6" }
		temp.text_50 = "118, 425, %\041鉴定此装备需要["..(normalItemTable.name).."]"..(needNum).."个！"
		temp.text_51 = ""
		temp.image_2 = ""
		UpdateCustomWnd(temp)
		return
	end
	
	-- 如果材料类型符合，则显示图标及所需数量
	temp.previous_6 = { itemid = needMate }
	temp.text_51 = "255, 376, %\041"..needNum
	
	-- 统计背包中是否有足够的材料
	if (0 == CheckGoods(needMate, needNum, 1)) then
		-- 不够
		temp.image_2 = "259,376,interface/EquipConstruction/黑框.spr"
		temp.text_50 = "118, 425, %\041材料数目不足，需要["..(normalItemTable.name).."]"..(needNum).."个！"
		UpdateCustomWnd(temp)
		return
	end
	temp.previous_7 = { dragable = true}			-- 记忆材料
	temp.text_50 = "118, 425, %\041点击【确定】开始鉴定装备。"
	UpdateCustomWnd(temp)
end

function QECheckEquip(equip)
	local detail = GetItemDetails(equip)
	local temp = {}
	
	if (nil == detail) then
		return
	end
	
	-- 检查是否为装备
	if (detail.type < 101 or detail.type > 114 ) then
		temp.text_50 = "118, 425, %\041请拖入您要鉴定的装备！"
		temp.ItemHolder_5 = { pos = "165, 376", dragable = true, action = "@rc,1,@rv,5,@rv,6,@rv,7" }
		UpdateCustomWnd(temp)
		return
	end
	
	-- 如果是装备，则列出所有的随机属性
	local count = 1
	for i=1, 6 do
		rfalse("before is: "..detail.qualitys[i])
		local real = detail.qualitys[i] - rint(detail.qualitys[i]/10000)*10000
		if (real ~= 0) then
			temp["text_"..(9+i)] = "120, "..(20*(count-1)+147)..", %\041"..(EquipAttNameMap[i]).."：%\169"..(real)..",8"
			count = count + 1
		else
			temp["text_"..(9+i)] = ""
		end
	end
	
	for i=1, 5 do
		local real = detail.inherits[i] - rint(detail.inherits[i]/10000)*10000
		if (real ~= 0 ) then
			temp["text_"..(15+i)] = "120, "..(20*(count-1)+147)..", %\041"..(EquipAttNameMap[i+6]).."：%\169"..(real)..",8"
			count = count + 1
		else
			temp["text_"..(15+i)] = ""
		end
	end
	
	for i=1, 11 do
		temp["text_"..(29+i)] = ""
	end
	
	-- 禁止拖入其他装备
	temp.previous_5 = { dragable = false}			-- 装备
	temp.previous_6 = { dragable = true}			-- 材料
	temp.text_50 = "118, 425, %\041请拖入鉴定装备所需的材料！"
	
	UpdateCustomWnd(temp)
end

function StartQualify(equip, material, memory)
	local equipDetail = GetItemDetails(equip)
	local mateDetail  = GetItemDetails(material, true)
	local memDetail   = GetItemDetails(memory, true)
	
	local temp = {}
	
	if (nil == equipDetail) then
		temp.text_50 = "118, 425, %\041请拖入您要鉴定的装备！"
		UpdateCustomWnd(temp)
		return
	end

	if (nil == mateDetail) then
		temp.text_50 = "118, 425, %\041请拖入鉴定装备所需的材料！"
		UpdateCustomWnd(temp)
		return
	end
	
	-- 检查材料数目是否足够
	local rank = EQGetEquipRank(equipDetail.levelEM)
	rfalse("装备的等级为:"..rank)
	rfalse("鉴定此装备所需材料ID为："..EquipQualifyMaterialMap[rank][1].."，个数为："..EquipQualifyMaterialMap[rank][2].."个")
	local needMate = EquipQualifyMaterialMap[rank][1]
	local needNum  = EquipQualifyMaterialMap[rank][2]
	local normalItemTable = {}
	normalItemTable = GetItemSetting(needMate)
	
	-- 统计背包中是否有足够的材料
	if (0 == CheckGoods(needMate, needNum, 1)) then
		-- 不够
		temp.image_2 = "259,376,interface/EquipConstruction/黑框.spr"
		temp.text_50 = "118, 425, %\041材料数目不足，需要"..(needNum).."个！"
		UpdateCustomWnd(temp)
		return
	end
	
	local needMemMate = EquipQualifyMemoryMap[rank][1]
	local needMemNum  = EquipQualifyMemoryMap[rank][2]
	-- 记忆材料必须足够
	if (nil ~= memDetail) then
		rfalse("用户放入了记忆材料，则数目一定要足够")
		if (0 == CheckGoods(needMemMate, needMemNum, 1)) then
			temp.image_3 = "353,376,interface/EquipConstruction/黑框.spr"
			temp.text_50 = "118, 425, %\041记忆材料数目不足，需要"..(needNum).."个！"
			UpdateCustomWnd(temp)
			return
		end
	end
	
	-- 定义2份数据结构
	local attBefore = {}
	local attAfter = {}
	
	-- 获取装备目前的属性
	for i=1, 6 do
		attBefore[i] = equipDetail.qualitys[i] - rint(equipDetail.qualitys[i]/10000)*10000
		attAfter[i] = equipDetail.qualitys[i] - rint(equipDetail.qualitys[i]/10000)*10000
	end
	for i=7, 11 do
		attBefore[i] = equipDetail.inherits[i-6] - rint(equipDetail.inherits[i-6]/10000)*10000
		attAfter[i] = equipDetail.inherits[i-6] - rint(equipDetail.inherits[i-6]/10000)*10000
	end
	
	-- 获取装备所能鉴定的条数
	local maxAtt = QualifyEquipAttNum(equipDetail.levelEM)
	rfalse("生成了"..maxAtt.."条属性")
	local attTable = GenerateEquipAAttType(maxAtt)
	
	for i=1, 11 do
		attAfter[i] = 0
	end
	
	for i=1, maxAtt do
		local base = 2*i-1
		rfalse("属性为:"..attTable[base].." 值为:"..attTable[base+1])
		attAfter[EquipAttIndexMap[attTable[base]]] = attTable[base+1]
	end
	
	-- 列出合成后的属性
	local count = 1
	for i=1, 11 do
		if (attAfter[i] ~= 0) then
			temp["text_"..(29+i)] = "305, "..(20*(count-1)+147)..", %\041"..(EquipAttNameMap[i]).."：%\169"..(attAfter[i])..",8"
			count = count + 1
		else
			temp["text_"..(29+i)] = ""
		end
	end

	-- 判断用户是否有记忆材料
	if (nil == memDetail) then
		-- 如果没有记忆材料，则直接更改属性
		rfalse("玩家没有拖入记忆材料")
		CheckGoods(needMate, needNum, 0)
		
		-- 修改属性
		for i=1, 6 do
			equipDetail.qualitys[i] = rint(equipDetail.qualitys[i]/10000)*10000 + attAfter[i]
		end
		
		for i=1, 5 do
			equipDetail.inherits[i] = rint(equipDetail.inherits[i]/10000)*10000 + attAfter[i+6]
		end
		
		UpdateItemDetails(equip, equipDetail)
		
		temp.ItemHolder_5 = { pos = "165, 376", dragable = true, action = "@rc,1,@rv,5,@rv,6,@rv,7"}
		temp.ItemHolder_6 = { pos = "259, 376", dragable = false, action = "@rc,2,@rv,5,@rv,6" }
		temp.ItemHolder_7 = { pos = "353, 376", dragable = false, action = "@rc,3,@rv,5,@rv,7" }
		temp.text_51 = ""
		temp.text_52 = ""
		temp.image_2 = ""
		temp.image_3 = ""
		temp.text_50 = "118, 425, %\041恭喜，装备鉴定完毕！"
	else
		-- 首先扣除鉴定材料和记忆材料
		CheckGoods(needMate, needNum, 0)
		CheckGoods(needMemMate, needMemNum, 0)
		
		-- 检查背包中剩余材料是否足够
		if (0 == CheckGoods(needMate, needNum, 1)) then
			temp.image_2 = "259,376,interface/EquipConstruction/黑框.spr"
		end
		
		-- 检查背包中剩余材料是否足够
		if (0 == CheckGoods(needMemMate, needMemNum, 1)) then
			temp.image_3 = "353,376,interface/EquipConstruction/黑框.spr"
		end
		
		temp.SprButton_20 = { pos = "423, 103", image = "interface/EquipConstruction/CommonBtn/面板按键关闭", action = "rc,99", ToolTip = "关闭" }
		temp.SprButton_22 = { pos = "185, 510", image = "interface/EquipConstruction/CommonBtn/按键确定", ToolTip = "绑定属性", 
			action = "@rc,40,@rv,5,@rv,6,@rv,7,@rc,"..attAfter[1]..",@rc,"..attAfter[2]..",@rc,"..attAfter[3]..",@rc,"..attAfter[4]..",@rc,"..attAfter[5]..",@rc,"..attAfter[6]..",@rc,"..attAfter[7]..",@rc,"..attAfter[8]..",@rc,"..attAfter[9]..",@rc,"..attAfter[10]..",@rc,"..attAfter[11] }
		temp.SprButton_23 = { pos = "300, 510", image = "interface/EquipConstruction/CommonBtn/按键取消", ToolTip = "恢复属性", action = "@rc,41,@rv,5,@rv,6,@rv,7" }
		temp.text_50 = "118, 425, %\041点击【确定】绑定属性，点击【取消】恢复原来的属性！"
	end
	UpdateCustomWnd(temp)
end

function EQGetEquipRank(level)
	if (0 == level or nil == level) then
		rfalse("有bug")
		return nil
	end
	
	if (level <= 10) then
		return 1
	elseif (level <= 30) then
		return 2
	elseif (level <= 50) then
		return 3
	elseif (level <= 70) then
		return 4
	elseif (level <= 90) then
		return 5
	elseif (level <= 110) then
		return 6
	elseif (level <= 120) then
		return 7
	elseif (level <= 140) then
		return 8
	else
		return nil
	end
end