CreateNpc(6, "装备打孔",3,67,88,0,0,0,1000,0,3,708)

function OnClick1000()
	MakeEquipHole()
end

function ClickMenu30000()
	MakeEquipHole()
end

-- 为装备打孔
function MakeEquipHole()
	wndItemMakeHole = wndItemMakeHole or
	{
		cleanup = true,
		image_1 	= "100,100,interface/EquipConstruction/MakeHole/装备打孔.spr",
		
		image_2 = "",
		image_3 = "",
		image_4 = "",
		image_5 = "",
		image_6 = "",
		
		image_7 	= "114, 195,interface/EquipConstruction/MakeHole/物品玉石镶嵌框封印.spr",
		image_8 	= "165, 195,interface/EquipConstruction/MakeHole/物品玉石镶嵌框封印.spr",
		image_9 	= "216, 195,interface/EquipConstruction/MakeHole/物品玉石镶嵌框封印.spr",
		image_10 	= "267, 195,interface/EquipConstruction/MakeHole/物品玉石镶嵌框封印.spr",
		image_11 	= "318, 195,interface/EquipConstruction/MakeHole/物品玉石镶嵌框封印.spr",
		image_40 	= "",
		image_41	= "",
		SprButton_7 = 		-- 关闭按钮
		{
			pos = "350, 103",
			image = "interface/EquipConstruction/CommonBtn/面板按键关闭",
			action = "@rc,90,@rv,18,@E",
			ToolTip = "关闭"
		},
		SprButton_8	=		-- 帮助按钮
		{
			pos = "333, 103",
			image = "interface/EquipConstruction/CommonBtn/面板按键帮助",
			ToolTip = "帮助",
			action = "@rc,90,@E"	-- 暂时设定为关闭
		},
		SprButton_9 =		-- 开始打孔
		{
			pos = "182, 302",
			image = "interface/EquipConstruction/CommonBtn/按键确定",
			ToolTip = "开始打单个孔",
			action = "@rc,5,@rv,18,@rv,19"
		},
		SprButton_10 = 		-- 取消打孔
		{
			pos = "295, 302",
			image = "interface/EquipConstruction/CommonBtn/按键取消",
			ToolTip = "取消打孔",
			action = "@rc,99,@rv,18,@E"
		},
		SprButton_11 = 		-- 开始批量打孔
		{
			pos = "295, 339",
			image = "interface/EquipConstruction/CommonBtn/按键开始",
			ToolTip = "开始批量打孔",
			action = "@rc,30,@rv,18,@rv,19"
		},
		SprButton_12 =
		{
			pos = "230, 340",
			image = "interface/EquipConstruction/CommonBtn/小左箭头按键",
			--ToolTip = "减少批量打孔数",
			enable = false,
			action = "@rc,10,@rv,18,@rv,19"
		},
		SprButton_13 =
		{
			pos = "266, 340",
			image = "interface/EquipConstruction/CommonBtn/小右箭头按键",
			--ToolTip = "增加批量打孔数",
			enable = false,
			action = "@rc,11,@rv,18,@rv,19"
		},
		ItemHolder_18 =							-- 装备
		{
			pos = "225, 146",
			dragable = true,
			action = "@rc,1,@rv,18"
		},
		ItemHolder_19 =							-- 材料
		{
			pos = "124, 256",
			dragable = false,
			action = "@rc,4,@rv,18,@rv,19"
		},
		ItemHolder_20 =							-- 位置一
		{
			pos = "122, 202",
			dragable = false,
		},
		ItemHolder_21 =							-- 位置二
		{
			pos = "173, 202",
			dragable = false,
		},
		ItemHolder_22 =							-- 位置三
		{
			pos = "224, 202",
			dragable = false,
		},
		ItemHolder_23 =							-- 位置四
		{
			pos = "275, 202",
			dragable = false,
		},
		ItemHolder_24 =							-- 位置五
		{
			pos = "326, 202",
			dragable = false,
		},
		text_14 = "217, 279, %\41,8",
		text_15 = "307, 279, %\041,8",
		text_16 = "245, 342, %\0410,8",
		text_20 = "115, 367, %\41请拖入您要打孔的装备！,10",
		WndItem = { pos = "400,100", visiable = "true" },
		ChatPanel = {visiable = "true"}
	}	
	WndCustomize(wndItemMakeHole, "MakeHoleFunc")
end

function MakeHoleFunc(ops, arg1, arg2)
	rfalse(ops)
	if (1 == ops ) then						-- ops == 1 表示玩家将装备拖入了装备栏
		CheckEquip(arg1)
	elseif (ops>=10 and ops<=15) then
		rfalse(ops)
		ChangeHoleBatch(ops, arg1 ,arg2)
	elseif (4 == ops) then					-- ops == 4 表示玩家拖入了材料
		CheckMaterial(arg1, arg2)
	elseif (5 == ops) then					-- 打单个孔
		MakeSingleHole(arg1, arg2)
	elseif (ops>=30 and ops <= 35 ) then	-- 批量打孔
		MakeBatchHoles(ops, arg1, arg2)
	elseif (ops == 90) then
		Close(arg1)
	elseif (ops == 99 ) then
		NoEnoughMa(ops)
	end
end

function NoEnoughMa(ops)
	-- do nothing
end

function Close(equip)
	local detail = GetItemDetails(equip)
	if (nil == detail ) then
		return
	end
	
	if (detail.flags == 3) then
		rfalse("flags is 3")
		detail.flags = 1
	elseif (detail.flags == 2) then
		rfalse("flags is 2")
		detail.flags = 0
	end
	
	UpdateItemDetails(equip, detail)
end

-- 增加或者减少批量打孔的数目
function ChangeHoleBatch(ops, equip, material)
	local detail = GetItemDetails(equip)
	-- material为无效handle，因为材料holder并没有保存材料的handle
	--local materialDetails = GetItemDetails(material)
	if (nil == detail) then
		rfalse("装备无效...")
		return
	end
	
	local temp = {}
	
	local currentNum = ops - 10
	
	-- 获取装备的最大可打孔数
	local invalidSlots = 0
	for i=1, 5 do
		if (0 == detail.slots[i] ) then
			invalidSlots = invalidSlots + 1
		end
	end
	rfalse("装备目前的最大可打孔数是:"..invalidSlots)

	if (0 == invalidSlots ) then
		return
	end
	
	if (0 == currentNum ) then
		rfalse("come to here again")
		temp.SprButton_12 =
		{
			pos = "230, 340",
			image = "interface/EquipConstruction/CommonBtn/小左箭头按键",
			ToolTip = "减少批量打孔数",
			action = "@rc,10,@rv,18,@rv,19"
		}
		temp.SprButton_13 =
		{
			pos = "266, 340",
			image = "interface/EquipConstruction/CommonBtn/小右箭头按键",
			ToolTip = "增加批量打孔数",
			action = "@rc,11,@rv,18,@rv,19"
		}
		temp.text_16 = "245, 342, %\41"..tostring(0)..",8"
	elseif (invalidSlots == currentNum) then
		rfalse("将处于最大值")
		temp.SprButton_12 =
		{
			pos = "230, 340",
			image = "interface/EquipConstruction/CommonBtn/小左箭头按键",
			ToolTip = "减少批量打孔数",
			action = "@rc,"..(10+currentNum-1)..",@rv,18,@rv,19"
		}
		rfalse("Left: "..(10+currentNum-1))
		temp.SprButton_13 =
		{
			pos = "266, 340",
			image = "interface/EquipConstruction/CommonBtn/小右箭头按键",
			ToolTip = "增加批量打孔数",
			action = "@rc,"..(10+invalidSlots)..",@rv,18,@rv,19"
		}
		rfalse("right: "..(10+invalidSlots))
		temp.text_16 = "245, 342, %\41"..tostring(invalidSlots)..",8"
	else
		temp.SprButton_12 =
		{
			pos = "230, 340",
			image = "interface/EquipConstruction/CommonBtn/小左箭头按键",
			ToolTip = "减少批量打孔数",
			action = "@rc,"..(10+currentNum-1)..",@rv,18,@rv,19"
		}
		temp.SprButton_13 =
		{
			pos = "266, 340",
			image = "interface/EquipConstruction/CommonBtn/小右箭头按键",
			ToolTip = "增加批量打孔数",
			action = "@rc,"..(10+currentNum+1)..",@rv,18,@rv,19"
		}
		temp.text_16 = "245, 342, %\41"..tostring(currentNum)..",8"
	end
	
	if(currentNum ~= 0)then
		temp.SprButton_11 = 		-- 开始批量打孔
		{
			pos = "295, 339",
			image = "interface/EquipConstruction/CommonBtn/按键开始",
			ToolTip = "开始批量打孔",
			action = "@box,是否要批量打孔 %\050"..tostring(currentNum).." %0个?,@rc,"..(30+currentNum)..",@rv,18,@rv,19"
		}
	else
	    temp.SprButton_11 = 		-- 开始批量打孔
		{
			pos = "295, 339",
			image = "interface/EquipConstruction/CommonBtn/按键开始",
			ToolTip = "开始批量打孔",
			action = "@rc,"..(30+currentNum)..",@rv,18,@rv,19"
		}
	end
	UpdateCustomWnd(temp);
end

function MakeBatchHoles(count, equip, material)
	local temp = {}
	local equipDetails = GetItemDetails(equip)
	local materialDetails = GetItemDetails(material, true)
	local temp = {}
	
	if (nil == equipDetails ) then
		temp.text_20 = "115, 367, %\41请拖入您要打孔的装备！,8"
		UpdateCustomWnd(temp)
		return
	end
	
	if (nil == materialDetails) then
		temp.text_20 = "115, 367, %\41请拖入您要打孔的材料！,8"
		UpdateCustomWnd(temp)
		return
	end
	
	-- 获取目前有效孔的个数
	local validSlots=0
	for i=1, 5 do
		if (0 ~= equipDetails.slots[i]) then			
			validSlots = validSlots+1
		end
	end
	
	-- 获取批量打孔数
	local totalholes = count-30
	
	if (0 == totalholes) then
		temp.text_20 = "115, 367, %\41请选择批量打孔的数目！,10"
		UpdateCustomWnd(temp)
		return
	end
		
	-- 获取单孔材料需求
	local realNeed = CheckEMMatch(equipDetails.levelEM, materialDetails.index)
	if (nil == realNeed) then
		rfalse("有bug")
		return
	end
	
	-- 获取背包中index道具的个数
	local totalAmount = GetItemNum(materialDetails.index)
	rfalse("背包中共有:"..totalAmount)
	
	-- 所有需求都满足，开始批量打孔
	local realHave = totalAmount
	local maked = 0		-- 已打孔的个数
	local failed = 0	-- 失败
	local last = realHave
	
	repeat
		-- 首先判断材料是否足够
		if (last >= realNeed) then
			local tempInvalid = 0
			for i=1, 5 do
				if (0 == equipDetails.slots[i] ) then
					tempInvalid = tempInvalid + 1
				end
			end
			
			local pos = 5-tempInvalid+1
			
			local succRatio = SucceedRatio(pos)
			local randomRatio = math.random(1,100)
			rfalse("随机率"..randomRatio)
			if (randomRatio <= succRatio ) then 
				equipDetails.slots[pos] = 1
				UpdateItemDetails(equip, equipDetails)
				maked = maked + 1
	
				-- 消耗材料
				last = last-realNeed
				totalholes = totalholes - 1
			else
				last = last-realNeed
				failed = failed + 1
			end
			
			-- 获取装备的最大可打孔数
			local invalidHoles = 0
			for i=1, 5 do
				if (0 == equipDetails.slots[i] ) then
					invalidHoles = invalidHoles + 1
				end
			end
			rfalse("InvalidHoles is:"..invalidHoles)
		else		
			temp.image_41 = "124,256,interface/EquipConstruction/黑框.spr"
			temp.SprButton_11 = 		-- 开始批量打孔
			{
				pos = "295, 339",
				image = "interface/EquipConstruction/CommonBtn/按键开始",
				ToolTip = "开始批量打孔",
				action = "@rc,99"
			}
			temp.SprButton_9 =			-- 开始打孔
			{
				pos = "182, 302",
				image = "interface/EquipConstruction/CommonBtn/按键确定",
				ToolTip = "开始打单个孔",
				action = "@rc,99"
			}
			temp.text_20 = "115, 367, %\41材料数目不足，无法继续为装备打孔！,10"
			break
		end
	until totalholes == 0
		
	temp.ItemHolder_18 =
	{
		pos = "225, 146",
		dragable = true,
		action = "@rc,1,@rv,18",
	}
	
	temp.SprButton_12 =
	{
		pos = "230, 340",
		image = "interface/EquipConstruction/CommonBtn/小左箭头按键",
		--ToolTip = "减少批量打孔数",
		enable = false,
		action = "@rc,10,@rv,18,@rv,19"
	}
	temp.SprButton_13 =
	{
		pos = "266, 340",
		image = "interface/EquipConstruction/CommonBtn/小右箭头按键",
		--ToolTip = "增加批量打孔数",
		enable = false,
		action = "@rc,11,@rv,18,@rv,19"
	}
	temp.SprButton_11 =
	{
		pos = "295, 339",
		image = "interface/EquipConstruction/CommonBtn/按键开始",
		ToolTip = "开始批量打孔",
		action = "@rc,"..(30)..",@rv,18,@rv,19"
	}
	temp.text_16 = "245, 342, %\41"..tostring(0)..",8"
	
	if (0 ~= maked) then
		temp.text_20 = "115, 367, %\41本次成功打了"..maked.."个孔，消耗"..(realHave-last).."个材料,10"
	end
	
	CheckGoods(materialDetails.index, totalAmount-last, 0)

	temp.ItemHolder_19 =							-- 材料
	{
		pos 		= "124, 256",
		dragable 	= false,
		action 		= "@rc,4,@rv,18,@rv,19",
	}
		
	temp.image_40 = ""
	
	-- 根据孔状态更新面板
	local basepos = 114
	for i=2, 6 do
		temp["image_"..(i+5)] = 114+ 51*(i-2)..", 195,interface/EquipConstruction/MakeHole/物品玉石镶嵌框封印.spr"
	end

	temp.text_14 = "217, 279, %\41,8"
	temp.text_16 = "245, 342, %\41"..tostring(0)..",8"
	temp.text_15 = "307, 279, %\0410％,8"
	UpdateCustomWnd(temp)
end
-----------------------------------------

function MakeSingleHole(equip, material)
	local equipDetail = GetItemDetails(equip)
	local materialDetail = GetItemDetails(material, true)
	
	local temp = {}
	
	if (nil == equipDetail ) then
		temp.text_20 = "115, 367, %\41请拖入您要打孔的装备！,8"
		UpdateCustomWnd(temp)
		return
	end
	
	if (nil == materialDetail) then
		temp.text_20 = "115, 367, %\41请拖入您要打孔的材料！,8"
		UpdateCustomWnd(temp)
		return
	end
	
	-- 获取目前有效孔的个数
	local validSlots=0
	for i=1, 5 do
		if (0 ~= equipDetail.slots[i]) then			
			validSlots = validSlots+1
		end
	end
	
	local mNeed = CheckEMMatch(equipDetail.levelEM, materialDetail.index)
	if (nil == result) then 		-- 表示材料ID和装备不匹配
		rfalse("有bug")
	end
	
	-- 开始打孔
	local succRatio = SucceedRatio(validSlots+1)
	local randomRatio = math.random(1,100)
	if (randomRatio <= succRatio ) then 			-- 成功
		equipDetail.slots[validSlots+1] = 1
		UpdateItemDetails(equip, equipDetail)
		temp.text_20 = "115, 367, %\41恭喜，装备打孔成功！,10"
	else
		temp.text_20 = "115, 367, %\41装备打孔失败！,10"
	end
	
	temp.image_40 = ""
	
	-- 弹出装备
	temp.ItemHolder_18 =
	{
		pos = "225, 146",
		dragable = true,
		action = "@rc,1,@rv,18",
	}
	
	-- 扣除材料
	CheckGoods(materialDetail.index, mNeed, 0)
	
	-- 弹出材料
	temp.ItemHolder_19 =							-- 材料
	{
		pos 		= "124, 256",
		dragable 	= false,
		action 		= "@rc,4,@rv,18,@rv,19",
	}
	
	local basepos = 114
	for i=2, 6 do
		temp["image_"..(i+5)] = 114+ 51*(i-2)..", 195,interface/EquipConstruction/MakeHole/物品玉石镶嵌框封印.spr"
	end

	temp.SprButton_12 =
	{
		pos = "230, 340",
		image = "interface/EquipConstruction/CommonBtn/小左箭头按键",
		--ToolTip = "减少批量打孔数",
		enable = false,
		action = "@rc,10,@rv,18,@rv,19"
	}
	temp.SprButton_13 =
	{
		pos = "266, 340",
		image = "interface/EquipConstruction/CommonBtn/小右箭头按键",
		--ToolTip = "增加批量打孔数",
		enable = false,
		action = "@rc,11,@rv,18,@rv,19"
	}
	temp.SprButton_11 = 		-- 开始批量打孔
	{
		pos = "295, 339",
		image = "interface/EquipConstruction/CommonBtn/按键开始",
		ToolTip = "开始批量打孔",
		action = "@rc,"..(30)..",@rv,18,@rv,19"
	}
	
	temp.text_14 = "217, 279, %\41,8"
	temp.text_16 = "245, 342, %\41"..tostring(0)..",8"
	temp.text_15 = "307, 279, %\0410％,8"
	UpdateCustomWnd(temp)
end

--开始检查拖入的材料
function CheckMaterial(equip, material)
	local equipDetail = GetItemDetails(equip)
	local materialDetail = GetItemDetails(material)
	
	local temp = {}
	
	if (nil == equipDetail or nil == materialDetail) then
		return
	end

	local result = CheckEMMatch(equipDetail.levelEM, materialDetail.index)
	if (nil == result) then 		-- 表示材料ID和装备不匹配
		temp.ItemHolder_19 ={ pos = "124, 256", dragable = true, action = "@rc,4,@rv,18,@rv,19"}		-- 弹出材料
		temp.text_20 = "115, 367, %\41此道具无法为装备打孔，请放入合适的材料！,10"
		--temp.text_14 = "217, 279, %\41,8"
		temp.text_16 = "245, 342, %\41"..tostring(0)..",8"
		--[[temp.SprButton_12 =
		{
			pos = "230, 340",
			image = "interface/EquipConstruction/CommonBtn/小左箭头按键",
			ToolTip = "减少批量打孔数",
			action = "@rc,10,@rv,18,@rv,19"
		}
		temp.SprButton_13 =
		{
			pos = "266, 340",
			image = "interface/EquipConstruction/CommonBtn/小右箭头按键",
			ToolTip = "增加批量打孔数",
			action = "@rc,11,@rv,18,@rv,19"
		} --]]
		temp.SprButton_11 = 		-- 开始批量打孔
		{
			pos = "295, 339",
			image = "interface/EquipConstruction/CommonBtn/按键开始",
			ToolTip = "开始批量打孔",
			action = "@rc,"..(30)..",@rv,18,@rv,19"
		}
		UpdateCustomWnd(temp)
		return
	end
		
	--temp.text_14 = "217, 279, %\41"..tostring(result)..",8"
	temp.ItemHolder_19 =		
	{
		pos = "124, 256",
		dragable = true,
		itemid = materialDetail.index,
		action = "@rc,4,@rv,18,@rv,19"
	}
	temp.text_16 = "245, 342, %\41"..tostring(0)..",8"
	temp.SprButton_12 =
	{
		pos = "230, 340",
		image = "interface/EquipConstruction/CommonBtn/小左箭头按键",
		ToolTip = "减少批量打孔数",
		action = "@rc,10,@rv,18,@rv,19"
	}
	temp.SprButton_13 =
	{
		pos = "266, 340",
		image = "interface/EquipConstruction/CommonBtn/小右箭头按键",
		ToolTip = "增加批量打孔数",
		action = "@rc,11,@rv,18,@rv,19"
	}
	temp.SprButton_11 = 		-- 开始批量打孔
	{
		pos = "295, 339",
		image = "interface/EquipConstruction/CommonBtn/按键开始",
		ToolTip = "开始批量打孔",
		action = "@rc,"..(30)..",@rv,18,@rv,19"
	}
	local normalItemTable = {}
	normalItemTable = GetItemSetting(materialDetail.index)
	
	if (0 == CheckGoods(materialDetail.index, result, 1)) then
		temp.image_41 = "124,256,interface/EquipConstruction/黑框.spr"
		temp.text_20 = "115, 367, %\41材料数目不足，需要["..(normalItemTable.name).."]"..(result).."个！,10"
        temp.SprButton_12 =
		{
			pos = "230, 340",
			image = "interface/EquipConstruction/CommonBtn/小左箭头按键",
			--ToolTip = "减少批量打孔数",
			enable = false,
			action = "@rc,10,@rv,18,@rv,19"
		}
		temp.SprButton_13 =
		{
			pos = "266, 340",
			image = "interface/EquipConstruction/CommonBtn/小右箭头按键",
			--ToolTip = "增加批量打孔数",
			enable = false,
			action = "@rc,11,@rv,18,@rv,19"
		}
		temp.SprButton_11 = 		-- 开始批量打孔
		{
			pos = "295, 339",
			image = "interface/EquipConstruction/CommonBtn/按键开始",
			ToolTip = "开始批量打孔",
			action = "@rc,99"
		}
		temp.SprButton_9 =			-- 开始打孔
		{
			pos = "182, 302",
			image = "interface/EquipConstruction/CommonBtn/按键确定",
			ToolTip = "开始打单个孔",
			action = "@rc,99"
		}
	else
		temp.image_41 = ""
		SprButton_11 = 		-- 开始批量打孔
		{
			pos = "295, 339",
			image = "interface/EquipConstruction/CommonBtn/按键开始",
			ToolTip = "开始批量打孔",
			action = "@rc,30,@rv,18,@rv,19"
		}
		SprButton_9 =		-- 开始打孔
		{
			pos = "182, 302",
			image = "interface/EquipConstruction/CommonBtn/按键确定",
			ToolTip = "开始打单个孔",
			action = "@rc,5,@rv,18,@rv,19"
		}
		temp.text_20 = "115, 367, %\41请点击[确定]或[开始]为装备打孔。,10"
	end	
	UpdateCustomWnd(temp);
end

--开始检查拖入的装备
function CheckEquip(itemHandle)
	local detail = GetItemDetails(itemHandle)
	local invalidSlots = 0				-- 可打孔
	local emptySlots = 0				-- 可镶嵌
	local embedSlots = 0				-- 已镶嵌
	local slotstate = {}
	local temp = {}
	
	if (detail.type < 101 or detail.type > 114) then
		temp.ItemHolder_18 =
		{
			pos = "225, 146",
			dragable = true,
			action = "@rc,1,@rv,18"
		}
		temp.text_20 = "115, 367, %\41请放入需要打孔的装备！,10"
		TalkToPlayer(0,"该物品无法进行打孔！")
		UpdateCustomWnd(temp);
		return
	end
	
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
		end
	end
	rfalse("Invalid: "..invalidSlots.." Empty: "..emptySlots.." Embed: "..embedSlots)
	
	if (0 == invalidSlots ) then
		temp.ItemHolder_18 =
		{
			pos = "225, 146",
			dragable = true,
			action = "@rc,1,@rv,18",
		}
		temp.text_20 = "115, 367, %\41您的装备孔数已满，无法进行打孔！,10"--jym
		TalkToPlayer(0,"您的装备孔数已满，无法进行打孔！")
		temp.text_16 = "245, 342, %\0410,8"
		temp.image_40 = ""
		UpdateCustomWnd(temp);
		return
	end
	
	-- 允许玩家拖入材料
	temp.previous_19 = { dragable = true }
	
	-- 禁止用户拖入其他的装备		
	temp.previous_18 = { dragable = false }
	
	-- 设置批量孔数的初始值为最大数
	temp.text_16 = "245, 342, %\41"..tostring(0)..",8"
	temp.text_20 = "115, 367, %\41,10"
	temp.text_15 = "307, 279, %\41"..tostring(SucceedRatio(emptySlots+1)).."％,8"
		
	-- 提示玩家下一个要被打的孔
	local highLightX = 121 + (5-invalidSlots)*51
	temp.image_40 = ""..highLightX..", 202,interface/EquipConstruction/Light/光蓝a1.spr"
			
	-- 根据孔状态更新面板
	local basepos = 114
	for i=2, 6 do
		if (0 == slotstate[i]) then
			temp["image_"..(i+5)] = 114+ 51*(i-2)..", 195,interface/EquipConstruction/MakeHole/物品玉石镶嵌框封印.spr"
		elseif (1 == slotstate[i]) then
			temp["image_"..(i+5)] = 114+ 51*(i-2)..", 195,interface/EquipConstruction/MakeHole/物品框未镶嵌.spr"
			temp["image_"..i] = ""
		else
			temp["image_"..(i+5)] = 114+ 51*(i-2)..", 195,interface/EquipConstruction/MakeHole/物品框已镶嵌镶嵌.spr"
			local normalItemTable = {}
			normalItemTable = GetItemSetting(detail.slots[i-1])
			local imageIndex = GetIconPath(normalItemTable.iconID)
			temp["image_"..i] = (122+51*(i-2))..", 203,interface/goods/"..imageIndex
			temp["ItemHolder_"..(i+18)] = 
			{
				pos = (122+(i-2)*51)..", 202",
				dragable = false,
				itemid = detail.slots[i-1]
			}
		end
	end
	local materialID,materialNum = GetEMMatchMaterials(detail.levelEM)
	local materialTable = GetItemSetting(materialID)
	temp.text_14 = "217, 279, %\41"..(materialTable.name).."x"..materialNum..",8"
	temp.text_20 = "115, 367, %\41请拖入合适的打孔材料！,8"--jym
	UpdateCustomWnd(temp)
end

function SucceedRatio(holeIndex)
	if (1 == holeIndex) then
		return 100
	elseif (2 == holeIndex ) then
		return 75
	elseif (3 == holeIndex ) then
		return 50
	elseif (4 == holeIndex ) then
		return 30
	elseif (5 == holeIndex ) then
		return 20
	else
		return "???"
	end
end
--[[
-- 检查装备等级和材料ID是否匹配
-- 函数逻辑为：通过装备等级查看材料是否匹配，如果匹配，则返回需要的材料数，否则返回nil
-- 函数调用者得到装备所需要的材料数后，可以检查拖入的材料数是否足够
function CheckEMMatch(equipLevel, materialID)
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
	
	local baseIndex = matchLevel
	for i=baseIndex, 8 do
		if (materialID == EMMap[i][1]) then
			rfalse(equipLevel.." Matches "..EMMap[i][1].." with the amount of "..EMMap[i][2])
			return EMMap[i][2]
		end
	end
	return nil
end

function JWTypeImageMap(level)
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
end  --]]