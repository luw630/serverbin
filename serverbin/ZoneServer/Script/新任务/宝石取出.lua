CreateNpc(6, "玉石取出",3,65,86,0,0,0,1111,0,3,709)

function OnClick1111()
	TakeOutJewel()
end

-- 取出玉石
function TakeOutJewel()
	wndTakeOutJewel = wndTakeOutJewel or
	{
		cleanup = true,
		image_1 = "100,100,interface/EquipConstruction/JewelOut/玉石取出.spr",
		
		image_2 = "",
		image_3 = "",
		image_4 = "",
		image_5 = "",
		image_6 = "",
		
		image_7 = "114, 195,interface/EquipConstruction/MakeHole/物品玉石镶嵌框封印.spr",
		image_8 = "165, 195,interface/EquipConstruction/MakeHole/物品玉石镶嵌框封印.spr",
		image_9 = "216, 195,interface/EquipConstruction/MakeHole/物品玉石镶嵌框封印.spr",
		image_10 = "267, 195,interface/EquipConstruction/MakeHole/物品玉石镶嵌框封印.spr",
		image_11 = "318, 195,interface/EquipConstruction/MakeHole/物品玉石镶嵌框封印.spr",

		image_12 = "",		-- 蒙皮
		
		SprButton_20 = 		-- 关闭按钮
		{
			pos = "350, 103",
			image = "interface/EquipConstruction/CommonBtn/面板按键关闭",
			action = "@E",
			ToolTip = "关闭"
		},
		SprButton_21	=		-- 帮助按钮
		{
			pos = "333, 103",
			image = "interface/EquipConstruction/CommonBtn/面板按键帮助",
			ToolTip = "帮助",
			action = "@E"		-- 暂时设定为关闭
		},
		SprButton_22 = 	
		{
			pos = "208, 300",
			image = "interface/EquipConstruction/CommonBtn/按键确定",
			ToolTip = "取出宝石",
			action = "@rc,3,@rv,30,@rv,36,@rv,70"
		},
		SprButton_23 = 	
		{
			pos = "287, 300",
			image = "interface/EquipConstruction/CommonBtn/按键取消",
			ToolTip = "取消",
			action = "@E"
		},
		ItemHolder_30 =							-- 装备
		{
			pos = "225, 146",
			dragable = true,
			action = "@rc,1,@rv,30"
		},
		ItemHolder_31 =							-- 位置一
		{
			pos = "123, 204",
			action = "@rc,31,@rv,30,@rv,36"
		},
		ItemHolder_32 =							-- 位置二
		{
			pos = "174, 204",
			action = "@rc,32,@rv,30,@rv,36"
		},
		ItemHolder_33 =							-- 位置三
		{
			pos = "225, 204",
			action = "@rc,33,@rv,30,@rv,36"
		},
		ItemHolder_34 =							-- 位置四
		{
			pos = "276, 204",
			action = "@rc,34,@rv,30,@rv,36"
		},
		ItemHolder_35 =							-- 位置五
		{
			pos = "327, 204",
			action = "@rc,35,@rv,30,@rv,36"
		},
		ItemHolder_36 =							-- 材料
		{
			pos = "124, 257",
			dragable = false,
			action = "@rc,2,@rv,30,@rv,36"
		},
		RadioGroup_70 = 
		{
			image = "interface/EquipConstruction/Light/光蓝c1.spr",
			pos = "100, 100",
			cannil = true,
			multi = false,
			action = "@rc,4,@rv,30,@rv,70",
			[1] = "",--"123,204,32,32",
			[2] = "",--"174,204,32,32",
			[3] = "",--"225,204,32,32",
			[4] = "",--"276,204,32,32",
			[5] = "",--"327,204,32,32"
		},
		text_40 = "115, 350, %\41请拖入您要取出宝石的装备！,10",
		text_41 = "210, 278, %\41, 10",
		text_50 = "175, 256",							-- 物品需求数
		image_60 = "100, 100,",
		
		WndItem = { pos = "400,100", visiable = "true" },
		ChatPanel = {visiable = "true"}
	}
	WndCustomize(wndTakeOutJewel, "TakeOutJewelArg")
end

function TakeOutJewelArg(ops, arg1, arg2, arg3)
	rfalse(ops)
	if (1==ops) then
		TJCheckEquip(arg1)
	elseif (2 == ops ) then
		TJCheckMaterial(arg1, arg2)
	elseif (3 == ops ) then
		StartTakeOut(arg1, arg2, arg3)
	elseif (4 == ops ) then
		SelectOne(arg1, arg2)
	end
end

function SelectOne(equip, radio)
	
	local equipDetail = GetItemDetails(equip)
	if (nil == equipDetail ) then
		return
	end
	
	local temp = {}
	
	if (nil ~= radio ) then	
		-- 首先获取取出第radio块宝石需要的材料和数目
		local JMMap = TakeOutJMMap(equipDetail.slots[radio])
		rfalse("需要类型为:"..JMMap[1].." "..JMMap[2].."个")
		
		local strNeeds = tostring(JMMap[2])
		temp.previous_36 = {itemid = JMMap[1]}
		temp.text_41 = (210+(9-(#strNeeds-1)*3))..", 278, %\41"..JMMap[2]..", 8"
--		temp.text_50 = "120, 256, %\41"..JMMap[2]..", 8"
		
		local normalItemTable = {}
		normalItemTable = GetItemSetting(JMMap[1])
		
		if (0 == CheckGoods(JMMap[1], JMMap[2], 1)) then
			temp.image_12 = "124, 256,interface/EquipConstruction/黑框.spr"
			temp.text_40 = "115, 350, %\41材料不足，取出此宝石需要["..(normalItemTable.name).."]"..(JMMap[2]).."个！,8"
		else
			temp.text_40 = "115, 350, %\41点击确定取出此宝石。,8"
			temp.image_12 = ""

            local normalItemTable = {}
			normalItemTable = GetItemSetting(equipDetail.slots[radio])
			temp.SprButton_22 = 	
			{
				pos = "208, 300",
				image = "interface/EquipConstruction/CommonBtn/按键确定",
				ToolTip = "取出宝石",
				action = "@box,是否要将 %\41"..(normalItemTable.name).." %0取出？,@rc,3,@rv,30,@rv,36,@rv,70"
			}
			UpdateCustomWnd(temp)
			return 
		end
	else
		temp.text_41 = ""
		temp.text_50 = ""
		temp.ItemHolder_36 =								-- 材料
		{
			pos 		= "124, 257",
			dragable 	= false,
			action 		= "@rc,2,@rv,30,@rv,36",
		}
		temp.image_12 = ""
		temp.text_40 = "115, 350, %\41请点击选择您要取出的宝石！,10"
		temp.SprButton_22 = 	
		{
			pos = "208, 300",
			image = "interface/EquipConstruction/CommonBtn/按键确定",
			ToolTip = "取出宝石",
			action = "@rc,3,@rv,30,@rv,36,@rv,70"
		}
		rfalse("用户取消了选择")
	end
	UpdateCustomWnd(temp)
end

function StartTakeOut(equip, material, radio)	
    local equipDetails = GetItemDetails(equip)
	
	local temp = {}
	
	if (nil == equipDetails) then
		temp.text_40 = "115, 350, %\41请拖入您要取出宝石的装备！,10"
		UpdateCustomWnd(temp)
		return
	end
	
	local embedSlots = 0								-- 已镶嵌
	for i=1, 5 do
		if (equipDetails.slots[i] >= 101) then			
			embedSlots = embedSlots+1
		end
	end
	
	if (0 == embedSlots) then
		temp.text_40 = "115, 350, %\41此装备没有嵌入任何宝石！,10"
		UpdateCustomWnd(temp)
		return
	end
	
	local position = radio
	rfalse("位置是: "..position)
	if (0 == position) then
		return
	end
	
	local jtype = equipDetails.slots[position]
	rfalse("位置"..position.."处宝石的类型是:"..jtype)
	local JMMap = TakeOutJMMap(jtype)
	rfalse("需要类型为:"..JMMap[1].." "..JMMap[2].."个")
	
	local normalItemTable = {}
	normalItemTable = GetItemSetting(JMMap[1])
	
	if (0 == CheckGoods(JMMap[1], JMMap[2], 1)) then
		temp.image_12 = "124, 256,interface/EquipConstruction/黑框.spr"
		temp.text_40 = "115, 350, %\41材料不足，取出此宝石需要["..(normalItemTable.name).."]"..(JMMap[2]).."个！,8"
		UpdateCustomWnd(temp)
		return
	end
	
	-- 此处检查背包是否有足够的位置
	local pakagenum = isFullNum()
	if (pakagenum < 1) then
		temp.text_40 = "115, 350, %\41您的背包没有剩余的空间！,10"
		UpdateCustomWnd(temp)
		return
	end
	rfalse("背包的剩余空间为: "..pakagenum)
	
	--开始取出玉石操作 
	CheckGoods(JMMap[1], JMMap[2], 0)
	
	-- 修正装备属性
	local delta = 0;
	for i=1, 5 do
		if (0 == equipDetails.slots[i]) then				-- 无效
			delta = delta+1
		end
	end
	rfalse("当前无效的孔个数为: "..delta)

	local temppos = position
	
	if (temppos == 5 ) then
		equipDetails.slots[5] = 1	
	else
		local left = 5-delta-position
		if (0 == left ) then
			equipDetails.slots[5-delta] = 1		
		else
			repeat
				equipDetails.slots[temppos] = equipDetails.slots[temppos+1]
				left = left - 1
				temppos = temppos + 1
			until 0 == left
			equipDetails.slots[5-delta] = 1					-- 设置为开孔但未镶嵌
		end
		rfalse("位置:"..position.."的宝石被取出")
	end
	UpdateItemDetails(equip, equipDetails)
			
	temp.ItemHolder_30 =								-- 装备
	{
		pos 		= "225, 146",
		dragable 	= true,
		action 		= "@rc,1,@rv,30",
	}
	
	temp.ItemHolder_36 =								-- 材料
	{
		pos 		= "124, 257",
		dragable 	= false,
		action 		= "@rc,2,@rv,30,@rv,36",
	}
	
	-- 更新面板
	local invalidSlots = 0				-- 可打孔
	local emptySlots = 0				-- 可镶嵌
	embedSlots = 0						-- 已镶嵌
	local slotstate = {}
	local posHas = ""
	
	for i=1, 5 do
		if (0 == equipDetails.slots[i]) then				-- 无效
			slotstate[i+1] = 0
			invalidSlots = invalidSlots+1
		elseif (1 == equipDetails.slots[i]) then			-- 为空
			slotstate[i+1] = 1
			emptySlots = emptySlots+1
		else											-- 有宝石嵌入
			slotstate[i+1] = 2
			embedSlots = embedSlots+1
			posHas = posHas..tostring(i)
		end
	end
	
	-- 更新热键
	temp.RadioGroup_70 = 
	{
		image = "interface/EquipConstruction/Light/光蓝c2.spr",
		cannil = true,
		multi = false,
		action = "@rc,4,@rv,30,@rv,70",
		[1] = "",
		[2] = "",
		[3] = "",
		[4] = "",
		[5] = ""
	}
	--[[for i=1, #posHas do
		local pos = tonumber(string.sub(posHas, i, i))
		rfalse(pos)
		local posset = (122 + 51*(pos-1))..",203,32,32"
		rfalse(posset)
		temp.RadioGroup_70[pos] = posset
	end--]]
	
	rfalse("取出后有:"..embedSlots.."个宝石")
	
	-- 根据孔状态更新面板
	local basepos = 114
	for i=2, 6 do
		temp["image_"..(5+i)] = 114+ 51*(i-2)..", 195,interface/EquipConstruction/MakeHole/物品玉石镶嵌框封印.spr"
		temp["ItemHolder_"..(i+29)]=
		{
			pos = (123+51*(i-2))..", 204",
			action = "@rc,31,@rv,30,@rv,36",
		}
	end
	temp.text_50 = ""
	temp.text_41 = ""
	
	--在背包中放置一个宝石
	rfalse("将在背包中产生一个类型为:"..jtype.."的宝石")
	GiveGoods(jtype, 1)
	temp.text_40 = "115, 350, %\41宝石已放入背包！,10"
	temp.SprButton_22 = 	
	{
		pos = "208, 300",
		image = "interface/EquipConstruction/CommonBtn/按键确定",
		ToolTip = "取出宝石",
		action = "@rc,3,@rv,30,@rv,36,@rv,70"
	}
	UpdateCustomWnd(temp)
end
------------------------------------------------

function TJCheckMaterial(equip, material)
end

function TJCheckEquip(equip)
	local detail = GetItemDetails(equip)
	local invalidSlots = 0				-- 可打孔
	local emptySlots = 0				-- 可镶嵌
	local embedSlots = 0				-- 已镶嵌
	local slotstate = {}
	local temp = {}
	local posHas = ""
	
	if (detail.type >= 101 and detail.type <= 114) then
		for i=1, 5 do
			if (0 == detail.slots[i]) then				-- 无效
				slotstate[i+1] = 0
				invalidSlots = invalidSlots+1
			elseif (1 == detail.slots[i]) then			-- 为空
				slotstate[i+1] = 1
				emptySlots = emptySlots+1
			else										-- 有宝石嵌入
				slotstate[i+1] = 2
				embedSlots = embedSlots+1
				posHas = posHas..tostring(i)
			end
		end
	else												-- 不是有效的装备道具，提示玩家
		temp.ItemHolder_30 =
		{
			pos = "225, 146",
			dragable = true,
			action = "@rc,1,@rv,30"
		}
		temp.text_40 = "115, 350, %\41该物品无法放入面板中！,10"
		UpdateCustomWnd(temp);
		return
	end
	
	if (0 ~= embedSlots ) then
		temp.text_40 = "115, 350, %\41请点击选择您要取出的宝石位置！,10"
	else
		temp.text_40 = "115, 350, %\41此装备没有嵌入任何宝石！,10"
		temp.ItemHolder_30 = 
		{ 
			pos = "225, 146",
			dragable = true,
			action = "@rc,1,@rv,30",
		}
		UpdateCustomWnd(temp);
		return	
	end
		
	temp.previous_30 =
	{
		dragable = false,
	}
	
	rfalse("以下位置有宝石:"..posHas)
	
	-- 更新热键
	temp.RadioGroup_70 = 
	{
		image = "interface/EquipConstruction/Light/光蓝c2.spr",
		cannil = true,
		multi = false,
		action = "@rc,4,@rv,30,@rv,70",
		[1] = "",
		[2] = "",
		[3] = "",
		[4] = "",
		[5] = ""
	}
	for i=1, #posHas do
		local pos = tonumber(string.sub(posHas, i, i))
		rfalse(pos)
		local posset = (122 + 51*(pos-1))..",203,32,32"
		rfalse(posset)
		temp.RadioGroup_70[pos] = posset
	end
	
	-- 根据孔状态更新面板
	local basepos = 114
	for i=2, 6 do
		if (0 == slotstate[i]) then
			temp["image_"..(5+i)] = 114+ 51*(i-2)..", 195,interface/EquipConstruction/MakeHole/物品玉石镶嵌框封印.spr"
		elseif (1 == slotstate[i]) then
			temp["image_"..(5+i)] = 114+ 51*(i-2)..", 195,interface/EquipConstruction/MakeHole/物品框未镶嵌.spr"
			temp["image_"..i] = ""
		else
			temp["image_"..(5+i)] = 114+ 51*(i-2)..", 195,interface/EquipConstruction/MakeHole/物品框已镶嵌镶嵌.spr"
			local normalItemTable = {}
			normalItemTable = GetItemSetting(detail.slots[i-1])
			local imageIndex = GetIconPath(normalItemTable.iconID)
			temp["image_"..i] = (122+51*(i-2))..", 203,interface/goods/"..imageIndex
			temp["ItemHolder_"..(i+29)]=
			{
				pos = (123+51*(i-2))..", 204",
				action = "@rc,31,@rv,30,@rv,36",
				itemid = detail.slots[i-1]
			}
		end
	end
	UpdateCustomWnd(temp);
end