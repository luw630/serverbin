CreateNpc(6,"宝石镶嵌",3,63,89,0,0,0,10492,0,3,799)

RemoveObjectIndirect(1,2185)

function OnClick10492()
	InlayJewel()
end

function InlayJewel()
	wndItemInlayJewel = wndItemInlayJewel or
	{
		cleanup = true,  
		image_1 = "100,100,interface/EquipConstruction/BowlderInlay/镶嵌.spr",
		SprButton_2 = 
		{ 
			pos = "332,103", 
			SprFileName_Normal = "interface/common/面板按键帮助1.spr", 
			SprFileName_Down = "interface/common/面板按键帮助3.spr", 
			SprFileName_Active = "interface/common/面板按键帮助2.spr", 
			action = "" 
		},
		SprButton_3 = 
		{ 
			pos = "350,103", 
			SprFileName_Normal = "interface/common/面板按键关闭1.spr", 
			SprFileName_Down = "interface/common/面板按键关闭3.spr", 
			SprFileName_Active = "interface/common/面板按键关闭2.spr", 
			action = "@rc,13,@E"
		},
		SprButton_4 = 
		{ 
			pos = "148,248", 
			SprFileName_Normal = "interface/common/按键确定1.spr", 
			SprFileName_Down = "interface/common/按键确定3.spr", 
			SprFileName_Active = "interface/common/按键确定2.spr", 
			action = "@rc,12,@rv,6,@rv,7,@rv,8,@rv,9,@rv,10,@rv,11" 
		},
		SprButton_5 = 
		{ 
			pos = "264,248", 
			SprFileName_Normal = "interface/common/按键取消1.spr", 
			SprFileName_Down = "interface/common/按键取消3.spr", 
			SprFileName_Active = "interface/common/按键取消2.spr", 
			action = "@rc,13,@E"
		}, 
		ItemHolder_6 = { pos = "224,146", dragable = true, action = "@rc,1,@rv,6,@rv,7,@rv,8,@rv,9,@rv,10,@rv,11"},
		ItemHolder_7 = { pos = "122,203", dragable = false, action = "@rc,7,@rv,7,@rv,7,@rv,8,@rv,9,@rv,10,@rv,11"},
        ItemHolder_8 = { pos = "173,203", dragable = false, action = "@rc,8,@rv,8,@rv,7,@rv,8,@rv,9,@rv,10,@rv,11"},
        ItemHolder_9 = { pos = "224,203", dragable = false, action = "@rc,9,@rv,9,@rv,7,@rv,8,@rv,9,@rv,10,@rv,11"},
        ItemHolder_10 = { pos = "275,203", dragable = false, action = "@rc,10,@rv,10,@rv,7,@rv,8,@rv,9,@rv,10,@rv,11"},
        ItemHolder_11 = { pos = "326,203", dragable = false, action = "@rc,11,@rv,11,@rv,7,@rv,8,@rv,9,@rv,10,@rv,11"},
		
		-- 框图片
		image_12 = "114,195,interface/EquipConstruction/BowlderInlay/物品玉石镶嵌框封印.spr",
		image_13 = "165,195,interface/EquipConstruction/BowlderInlay/物品玉石镶嵌框封印.spr",
        image_14 = "216,195,interface/EquipConstruction/BowlderInlay/物品玉石镶嵌框封印.spr",
        image_15 = "267,195,interface/EquipConstruction/BowlderInlay/物品玉石镶嵌框封印.spr",
        image_16 = "318,195,interface/EquipConstruction/BowlderInlay/物品玉石镶嵌框封印.spr",
				
		-- 宝石图片
		-- x: base 122, increse 51, y: 203
		image_2 = "",
        image_3 = "",
        image_4 = "",
        image_5 = "",
        image_6 = "", 
			  
		text_30	= "121, 290,%\041请拖入您要镶嵌宝石的装备！,10",
		WndItem = { pos = "380,100", visiable = "true" },           -- 打开道具面板
		ChatPanel = {visiable = "true"},
	}
	WndCustomize( wndItemInlayJewel, "InlayOps" )
end

function InlayOps(ops, arg2, arg3, arg4, arg5, arg6, arg7)
	if (1 == ops) then
		CheckingEquip(arg2, arg3, arg4, arg5, arg6, arg7)
	elseif (ops>=7 and ops<=11) then
		DragJewel(ops, arg2 , arg3, arg4, arg5, arg6, arg7)
	elseif (12 == ops ) then
		StartInlay(arg2, arg3, arg4, arg5, arg6, arg7)
	elseif (13 == ops) then
		CloseAll()
	end
end

function CloseAll()
end

function StartInlay(equip, hole1, hole2, hole3, hole4, hole5)
	local temp = {}	
	if (equip == nil) then
        temp.text_30	= "121, 290,%\041请拖入您要镶嵌宝石的装备!,10"
	  	UpdateCustomWnd( temp )
		return
	end
	local equipDetail = GetItemDetails(equip)
	if (equipDetail == nil) then
		temp.text_30	= "121, 290,%\041请拖入您要镶嵌宝石的装备!,10"
	  	UpdateCustomWnd( temp )
		return
	end
	
	local HandleMap = {}
	HandleMap[1] = hole1
	HandleMap[2] = hole2
	HandleMap[3] = hole3
	HandleMap[4] = hole4
	HandleMap[5] = hole5
	
	for i=1, 5 do
		if (HandleMap[i] == nil ) then
			rfalse("位置: "..i.."处的宝石信息不正确")
		else
			rfalse("位置: "..i.."处的宝石信息正常，玩家将嵌入此宝石")
		end
	end
	
	--先判断此装备的空余孔数
	local emptyslotsset = ""
	
	for i=1, 5 do
		if (1 == equipDetail.slots[i]) then
			emptyslotsset = emptyslotsset..tostring(i)
		end
	end
		
	if ("" == emptyslotsset) then
		temp.text_30 = "121, 290,%\041您的装备没有空孔可以镶嵌宝石！,10"
		UpdateCustomWnd(temp)
		return
	end
	
	local JewelTypeInfo = {}
	local playerput = ""
	for i=1, 5 do
		local det = GetItemDetails(HandleMap[i])
		if (nil ~= det) then
			playerput = playerput..tostring(i)
			JewelTypeInfo[i] = det.index
			rfalse("缓存：位置"..i.."的宝石类型为："..(det.index))
		end
	end
	
	rfalse("以下位置的宝石信息已经全部取出"..playerput)
	
	if ("" == playerput) then
		temp.text_30 = "121, 290,%\041请在孔中放入宝石！,10"
		UpdateCustomWnd(temp)
		return
	end
	
	rfalse("玩家在以下位置放置了宝石: "..playerput)

	-- 计算空位置
	local count = #playerput
	rfalse("本次要嵌入"..count.."个宝石："..playerput)
	local empty = #emptyslotsset
	rfalse("空位置有"..empty.."个")
	rfalse(emptyslotsset)
	local index = 1
		
	repeat 
		local origPos = tonumber(string.sub(playerput,index,index))
		rfalse("原来的位置为: "..origPos.." 宝石类型为:"..JewelTypeInfo[origPos])
		local exactPos = tonumber(string.sub(emptyslotsset,index,index))
		equipDetail.slots[exactPos] = JewelTypeInfo[origPos]
		CheckGoods(JewelTypeInfo[origPos], 1, 0)
		temp["ItemHolder_"..(exactPos+6)] = 
		{
			pos = (122+51*(exactPos-1))..",203", 
			dragable = false, 
			action = "@rc,"..(exactPos+6)..",@rv,"..(exactPos+6)
		}
		index = index + 1
		count = count - 1
	until 0 == count	
	
	UpdateItemDetails(equip,equipDetail)
	
	-- 弹出装备
	temp.ItemHolder_6 = 
	{
		pos = "224,146", 
		dragable = true, 
		action = "@rc,1,@rv,6,@rv,7,@rv,8,@rv,9,@rv,10,@rv,11",
	}
	
	--UpdateCustomWnd(temp)
	
	for i=1, 5 do
		rfalse(i.." is "..equipDetail.slots[i])
	end
	
	for i=1, 5 do
		temp["image_"..(11+i)] = (114+51*(i-1))..",195,interface/EquipConstruction/BowlderInlay/物品玉石镶嵌框封印.spr"
		temp["ItemHolder_"..(6+i)] = 
		{
			pos = (122+51*(i-1))..",203", 
			dragable = false, 
			action = "@rc,"..(6+i)..",@rv,"..(6+i),
		}
	end
	temp.text_30 = "121, 290,%\041恭喜您镶嵌宝石成功！,10"
	temp.SprButton_4 = 
	{ 
		pos = "148,248", 
		SprFileName_Normal = "interface/common/按键确定1.spr", 
		SprFileName_Down = "interface/common/按键确定3.spr", 
		SprFileName_Active = "interface/common/按键确定2.spr", 
		action = "@rc,12,@rv,6,@rv,7,@rv,8,@rv,9,@rv,10,@rv,11" 
	}
	UpdateCustomWnd(temp)
end
-----------------------------------------

function DragJewel(index, jewel, hole1, hole2, hole3, hole4, hole5)
	local jewelDetail = GetItemDetails(jewel)
	if (nil == jewelDetail) then
		rfalse("Oh....")
		return
	end
	
	local pos = index-6
	local temp = {}

	-- 检查是否为宝石类型
	if ((jewelDetail.index < 101) or (jewelDetail.index>500 ) or ((jewelDetail.index%100)>30)) then
		temp.text_30 = "121, 290,%\041只有宝石能被镶嵌到道具上！,10"
		temp["ItemHolder_"..index] =
		{
			pos = (122+51*(index-7))..",203", 
			dragable = true, 
			action = "@rc,"..index..",@rv,"..index
		}
		UpdateCustomWnd(temp)
		return
	else
		local normalItemTable = {}
		normalItemTable = GetItemSetting(jewelDetail.index)
		local path = GetIconPath(normalItemTable.iconID)
		temp["image_"..(pos+1)] = (122+51*(pos-1))..",203,interface/goods/"..path
        temp["previous_"..index] =
		{
			dragable = false,
		}
		temp.text_30 = "121, 290,%\041请点击确定镶嵌宝石！,10"
		
		local HandleMap = {}
		HandleMap[1] = hole1
		HandleMap[2] = hole2
		HandleMap[3] = hole3
		HandleMap[4] = hole4
		HandleMap[5] = hole5
		
		local jewelName = ""
		for i=1, 5 do
			local det = GetItemDetails(HandleMap[i])
			if (nil ~= det) then
				local set = GetItemSetting(det.index)
				jewelName = jewelName.."【"..(set.name).."】"
			end
		end
		--rfalse("当前 "..jewelName)	
		temp.SprButton_4 = 
		{ 
			pos = "148,248", 
			SprFileName_Normal = "interface/common/按键确定1.spr", 
			SprFileName_Down = "interface/common/按键确定3.spr", 
			SprFileName_Active = "interface/common/按键确定2.spr", 
			action = "@box,是否要将 %\041"..jewelName.." %0镶嵌在装备中吗?,@rc,12,@rv,6,@rv,7,@rv,8,@rv,9,@rv,10,@rv,11"
		}
		UpdateCustomWnd(temp)
		return
	end
end

function CheckingEquip(equip, hole1, hole2, hole3, hole4, hole5)
	local detail = GetItemDetails(equip)
	local HandleMap = 
	{
		hole1,hole2,hole3,hole4,hole5
	}
	local temp = {}
	temp.image_2 = ""
    temp.image_3 = ""
    temp.image_4 = ""
    temp.image_5 = ""
    temp.image_6 = ""		

	if (detail.type >= 101 and detail.type <= 114) then
		--统计是否装备没有打孔 2010.3.17 jym
		--先判断此装备已经镶嵌了几个宝石
		local slotnumber = 0
		local emptyslotsset = ""
		for i=1, 5 do
			if (0 == detail.slots[i]) then
				slotnumber = slotnumber + 1
			elseif (1 == detail.slots[i]) then
				emptyslotsset = emptyslotsset..tostring(i)
			end
		end
		if (5 == slotnumber) then
			temp.text_30 = "121, 290,%\041您的装备不能进行镶嵌，请先对装备打孔！,10"
			--TalkToPlayer(0,"您的装备不能进行镶嵌，请先对装备打孔！")
			temp.ItemHolder_6 = { pos = "224,146", dragable = true, action = "@rc,1,@rv,6,@rv,7,@rv,8,@rv,9,@rv,10,@rv,11" }
			temp.image_12 = "114,195,interface/EquipConstruction/BowlderInlay/物品玉石镶嵌框封印.spr"
			temp.image_13 = "165,195,interface/EquipConstruction/BowlderInlay/物品玉石镶嵌框封印.spr"
			temp.image_14 = "216,195,interface/EquipConstruction/BowlderInlay/物品玉石镶嵌框封印.spr"
			temp.image_15 = "267,195,interface/EquipConstruction/BowlderInlay/物品玉石镶嵌框封印.spr"
			temp.image_16 = "318,195,interface/EquipConstruction/BowlderInlay/物品玉石镶嵌框封印.spr"
			UpdateCustomWnd(temp)
			return
		end

		if ("" == emptyslotsset) then
			temp.text_30 = "121, 290,%\041您的装备没有空孔可以镶嵌宝石！,10"
			--TalkToPlayer(0,"您的装备没有空孔可以镶嵌宝石！")
			temp.ItemHolder_6 = { pos = "224,146", dragable = true, action = "@rc,1,@rv,6,@rv,7,@rv,8,@rv,9,@rv,10,@rv,11" }
			temp.image_12 = "114,195,interface/EquipConstruction/BowlderInlay/物品玉石镶嵌框封印.spr"
			temp.image_13 = "165,195,interface/EquipConstruction/BowlderInlay/物品玉石镶嵌框封印.spr"
			temp.image_14 = "216,195,interface/EquipConstruction/BowlderInlay/物品玉石镶嵌框封印.spr"
			temp.image_15 = "267,195,interface/EquipConstruction/BowlderInlay/物品玉石镶嵌框封印.spr"
			temp.image_16 = "318,195,interface/EquipConstruction/BowlderInlay/物品玉石镶嵌框封印.spr"
			UpdateCustomWnd(temp)
			return
		end
		
		for i=1, 5 do
			if (0 == detail.slots[i]) then				-- 无效
				temp["image_"..(11+i)] = (114+51*(i-1))..",195,interface/EquipConstruction/BowlderInlay/物品玉石镶嵌框封印.spr"
			elseif (1 == detail.slots[i]) then			-- 为空
				temp["image_"..(11+i)] = (114+51*(i-1))..",195,interface/EquipConstruction/BowlderInlay/物品框未镶嵌.spr"
				-- 允许拖入宝石
				temp["ItemHolder_"..(6+i)] =
				{
					pos = (122+51*(i-1))..",203", 
					dragable = true, 
					action = "@rc,"..(i+6)..",@rv,"..(i+6)..",@rv,7,@rv,8,@rv,9,@rv,10,@rv,11", 
				}
			else										-- 有宝石嵌入
				temp["image_"..(11+i)] = (114+51*(i-1))..",195,interface/EquipConstruction/BowlderInlay/物品框已镶嵌镶嵌.spr"
				local normalItemTable = {}
				normalItemTable = GetItemSetting(detail.slots[i])
				local path = GetIconPath(normalItemTable.iconID)
				temp["image_"..(1+i)]  = (122+51*(i-1))..",203,interface/goods/"..path
				
				temp["ItemHolder_"..(6+i)] = 
				{
					pos = (122+51*(i-1))..",203", 
					dragable = false, 
					action = "@rc,"..(6+i)..",@rv,"..(6+i)..",@rv,7,@rv,8,@rv,9,@rv,10,@rv,11",
					itemid = detail.slots[i]
				}
			end
		end
		temp.text_30 = "121, 290,%\041请放入需要镶嵌的宝石！,10"
		temp.previous_6 = 
		{
			dragable = false, 
		}
	else
		temp.text_30 = "121, 290,%\041请放入需要镶嵌宝石的装备！,10"
		temp.ItemHolder_6 = { pos = "224,146", dragable = true, action = "@rc,1,@rv,6,@rv,7,@rv,8,@rv,9,@rv,10,@rv,11" }
		temp.image_12 = "114,195,interface/EquipConstruction/BowlderInlay/物品玉石镶嵌框封印.spr"
		temp.image_13 = "165,195,interface/EquipConstruction/BowlderInlay/物品玉石镶嵌框封印.spr"
        temp.image_14 = "216,195,interface/EquipConstruction/BowlderInlay/物品玉石镶嵌框封印.spr"
		temp.image_15 = "267,195,interface/EquipConstruction/BowlderInlay/物品玉石镶嵌框封印.spr"
        temp.image_16 = "318,195,interface/EquipConstruction/BowlderInlay/物品玉石镶嵌框封印.spr"
		UpdateCustomWnd(temp)
		return
	end
	UpdateCustomWnd(temp)
end