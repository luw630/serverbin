CreateNpc(6, "��ʯȡ��",3,65,86,0,0,0,1111,0,3,709)

function OnClick1111()
	TakeOutJewel()
end

-- ȡ����ʯ
function TakeOutJewel()
	wndTakeOutJewel = wndTakeOutJewel or
	{
		cleanup = true,
		image_1 = "100,100,interface/EquipConstruction/JewelOut/��ʯȡ��.spr",
		
		image_2 = "",
		image_3 = "",
		image_4 = "",
		image_5 = "",
		image_6 = "",
		
		image_7 = "114, 195,interface/EquipConstruction/MakeHole/��Ʒ��ʯ��Ƕ���ӡ.spr",
		image_8 = "165, 195,interface/EquipConstruction/MakeHole/��Ʒ��ʯ��Ƕ���ӡ.spr",
		image_9 = "216, 195,interface/EquipConstruction/MakeHole/��Ʒ��ʯ��Ƕ���ӡ.spr",
		image_10 = "267, 195,interface/EquipConstruction/MakeHole/��Ʒ��ʯ��Ƕ���ӡ.spr",
		image_11 = "318, 195,interface/EquipConstruction/MakeHole/��Ʒ��ʯ��Ƕ���ӡ.spr",

		image_12 = "",		-- ��Ƥ
		
		SprButton_20 = 		-- �رհ�ť
		{
			pos = "350, 103",
			image = "interface/EquipConstruction/CommonBtn/��尴���ر�",
			action = "@E",
			ToolTip = "�ر�"
		},
		SprButton_21	=		-- ������ť
		{
			pos = "333, 103",
			image = "interface/EquipConstruction/CommonBtn/��尴������",
			ToolTip = "����",
			action = "@E"		-- ��ʱ�趨Ϊ�ر�
		},
		SprButton_22 = 	
		{
			pos = "208, 300",
			image = "interface/EquipConstruction/CommonBtn/����ȷ��",
			ToolTip = "ȡ����ʯ",
			action = "@rc,3,@rv,30,@rv,36,@rv,70"
		},
		SprButton_23 = 	
		{
			pos = "287, 300",
			image = "interface/EquipConstruction/CommonBtn/����ȡ��",
			ToolTip = "ȡ��",
			action = "@E"
		},
		ItemHolder_30 =							-- װ��
		{
			pos = "225, 146",
			dragable = true,
			action = "@rc,1,@rv,30"
		},
		ItemHolder_31 =							-- λ��һ
		{
			pos = "123, 204",
			action = "@rc,31,@rv,30,@rv,36"
		},
		ItemHolder_32 =							-- λ�ö�
		{
			pos = "174, 204",
			action = "@rc,32,@rv,30,@rv,36"
		},
		ItemHolder_33 =							-- λ����
		{
			pos = "225, 204",
			action = "@rc,33,@rv,30,@rv,36"
		},
		ItemHolder_34 =							-- λ����
		{
			pos = "276, 204",
			action = "@rc,34,@rv,30,@rv,36"
		},
		ItemHolder_35 =							-- λ����
		{
			pos = "327, 204",
			action = "@rc,35,@rv,30,@rv,36"
		},
		ItemHolder_36 =							-- ����
		{
			pos = "124, 257",
			dragable = false,
			action = "@rc,2,@rv,30,@rv,36"
		},
		RadioGroup_70 = 
		{
			image = "interface/EquipConstruction/Light/����c1.spr",
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
		text_40 = "115, 350, %\41��������Ҫȡ����ʯ��װ����,10",
		text_41 = "210, 278, %\41, 10",
		text_50 = "175, 256",							-- ��Ʒ������
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
		-- ���Ȼ�ȡȡ����radio�鱦ʯ��Ҫ�Ĳ��Ϻ���Ŀ
		local JMMap = TakeOutJMMap(equipDetail.slots[radio])
		rfalse("��Ҫ����Ϊ:"..JMMap[1].." "..JMMap[2].."��")
		
		local strNeeds = tostring(JMMap[2])
		temp.previous_36 = {itemid = JMMap[1]}
		temp.text_41 = (210+(9-(#strNeeds-1)*3))..", 278, %\41"..JMMap[2]..", 8"
--		temp.text_50 = "120, 256, %\41"..JMMap[2]..", 8"
		
		local normalItemTable = {}
		normalItemTable = GetItemSetting(JMMap[1])
		
		if (0 == CheckGoods(JMMap[1], JMMap[2], 1)) then
			temp.image_12 = "124, 256,interface/EquipConstruction/�ڿ�.spr"
			temp.text_40 = "115, 350, %\41���ϲ��㣬ȡ���˱�ʯ��Ҫ["..(normalItemTable.name).."]"..(JMMap[2]).."����,8"
		else
			temp.text_40 = "115, 350, %\41���ȷ��ȡ���˱�ʯ��,8"
			temp.image_12 = ""

            local normalItemTable = {}
			normalItemTable = GetItemSetting(equipDetail.slots[radio])
			temp.SprButton_22 = 	
			{
				pos = "208, 300",
				image = "interface/EquipConstruction/CommonBtn/����ȷ��",
				ToolTip = "ȡ����ʯ",
				action = "@box,�Ƿ�Ҫ�� %\41"..(normalItemTable.name).." %0ȡ����,@rc,3,@rv,30,@rv,36,@rv,70"
			}
			UpdateCustomWnd(temp)
			return 
		end
	else
		temp.text_41 = ""
		temp.text_50 = ""
		temp.ItemHolder_36 =								-- ����
		{
			pos 		= "124, 257",
			dragable 	= false,
			action 		= "@rc,2,@rv,30,@rv,36",
		}
		temp.image_12 = ""
		temp.text_40 = "115, 350, %\41����ѡ����Ҫȡ���ı�ʯ��,10"
		temp.SprButton_22 = 	
		{
			pos = "208, 300",
			image = "interface/EquipConstruction/CommonBtn/����ȷ��",
			ToolTip = "ȡ����ʯ",
			action = "@rc,3,@rv,30,@rv,36,@rv,70"
		}
		rfalse("�û�ȡ����ѡ��")
	end
	UpdateCustomWnd(temp)
end

function StartTakeOut(equip, material, radio)	
    local equipDetails = GetItemDetails(equip)
	
	local temp = {}
	
	if (nil == equipDetails) then
		temp.text_40 = "115, 350, %\41��������Ҫȡ����ʯ��װ����,10"
		UpdateCustomWnd(temp)
		return
	end
	
	local embedSlots = 0								-- ����Ƕ
	for i=1, 5 do
		if (equipDetails.slots[i] >= 101) then			
			embedSlots = embedSlots+1
		end
	end
	
	if (0 == embedSlots) then
		temp.text_40 = "115, 350, %\41��װ��û��Ƕ���κα�ʯ��,10"
		UpdateCustomWnd(temp)
		return
	end
	
	local position = radio
	rfalse("λ����: "..position)
	if (0 == position) then
		return
	end
	
	local jtype = equipDetails.slots[position]
	rfalse("λ��"..position.."����ʯ��������:"..jtype)
	local JMMap = TakeOutJMMap(jtype)
	rfalse("��Ҫ����Ϊ:"..JMMap[1].." "..JMMap[2].."��")
	
	local normalItemTable = {}
	normalItemTable = GetItemSetting(JMMap[1])
	
	if (0 == CheckGoods(JMMap[1], JMMap[2], 1)) then
		temp.image_12 = "124, 256,interface/EquipConstruction/�ڿ�.spr"
		temp.text_40 = "115, 350, %\41���ϲ��㣬ȡ���˱�ʯ��Ҫ["..(normalItemTable.name).."]"..(JMMap[2]).."����,8"
		UpdateCustomWnd(temp)
		return
	end
	
	-- �˴���鱳���Ƿ����㹻��λ��
	local pakagenum = isFullNum()
	if (pakagenum < 1) then
		temp.text_40 = "115, 350, %\41���ı���û��ʣ��Ŀռ䣡,10"
		UpdateCustomWnd(temp)
		return
	end
	rfalse("������ʣ��ռ�Ϊ: "..pakagenum)
	
	--��ʼȡ����ʯ���� 
	CheckGoods(JMMap[1], JMMap[2], 0)
	
	-- ����װ������
	local delta = 0;
	for i=1, 5 do
		if (0 == equipDetails.slots[i]) then				-- ��Ч
			delta = delta+1
		end
	end
	rfalse("��ǰ��Ч�Ŀ׸���Ϊ: "..delta)

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
			equipDetails.slots[5-delta] = 1					-- ����Ϊ���׵�δ��Ƕ
		end
		rfalse("λ��:"..position.."�ı�ʯ��ȡ��")
	end
	UpdateItemDetails(equip, equipDetails)
			
	temp.ItemHolder_30 =								-- װ��
	{
		pos 		= "225, 146",
		dragable 	= true,
		action 		= "@rc,1,@rv,30",
	}
	
	temp.ItemHolder_36 =								-- ����
	{
		pos 		= "124, 257",
		dragable 	= false,
		action 		= "@rc,2,@rv,30,@rv,36",
	}
	
	-- �������
	local invalidSlots = 0				-- �ɴ��
	local emptySlots = 0				-- ����Ƕ
	embedSlots = 0						-- ����Ƕ
	local slotstate = {}
	local posHas = ""
	
	for i=1, 5 do
		if (0 == equipDetails.slots[i]) then				-- ��Ч
			slotstate[i+1] = 0
			invalidSlots = invalidSlots+1
		elseif (1 == equipDetails.slots[i]) then			-- Ϊ��
			slotstate[i+1] = 1
			emptySlots = emptySlots+1
		else											-- �б�ʯǶ��
			slotstate[i+1] = 2
			embedSlots = embedSlots+1
			posHas = posHas..tostring(i)
		end
	end
	
	-- �����ȼ�
	temp.RadioGroup_70 = 
	{
		image = "interface/EquipConstruction/Light/����c2.spr",
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
	
	rfalse("ȡ������:"..embedSlots.."����ʯ")
	
	-- ���ݿ�״̬�������
	local basepos = 114
	for i=2, 6 do
		temp["image_"..(5+i)] = 114+ 51*(i-2)..", 195,interface/EquipConstruction/MakeHole/��Ʒ��ʯ��Ƕ���ӡ.spr"
		temp["ItemHolder_"..(i+29)]=
		{
			pos = (123+51*(i-2))..", 204",
			action = "@rc,31,@rv,30,@rv,36",
		}
	end
	temp.text_50 = ""
	temp.text_41 = ""
	
	--�ڱ����з���һ����ʯ
	rfalse("���ڱ����в���һ������Ϊ:"..jtype.."�ı�ʯ")
	GiveGoods(jtype, 1)
	temp.text_40 = "115, 350, %\41��ʯ�ѷ��뱳����,10"
	temp.SprButton_22 = 	
	{
		pos = "208, 300",
		image = "interface/EquipConstruction/CommonBtn/����ȷ��",
		ToolTip = "ȡ����ʯ",
		action = "@rc,3,@rv,30,@rv,36,@rv,70"
	}
	UpdateCustomWnd(temp)
end
------------------------------------------------

function TJCheckMaterial(equip, material)
end

function TJCheckEquip(equip)
	local detail = GetItemDetails(equip)
	local invalidSlots = 0				-- �ɴ��
	local emptySlots = 0				-- ����Ƕ
	local embedSlots = 0				-- ����Ƕ
	local slotstate = {}
	local temp = {}
	local posHas = ""
	
	if (detail.type >= 101 and detail.type <= 114) then
		for i=1, 5 do
			if (0 == detail.slots[i]) then				-- ��Ч
				slotstate[i+1] = 0
				invalidSlots = invalidSlots+1
			elseif (1 == detail.slots[i]) then			-- Ϊ��
				slotstate[i+1] = 1
				emptySlots = emptySlots+1
			else										-- �б�ʯǶ��
				slotstate[i+1] = 2
				embedSlots = embedSlots+1
				posHas = posHas..tostring(i)
			end
		end
	else												-- ������Ч��װ�����ߣ���ʾ���
		temp.ItemHolder_30 =
		{
			pos = "225, 146",
			dragable = true,
			action = "@rc,1,@rv,30"
		}
		temp.text_40 = "115, 350, %\41����Ʒ�޷���������У�,10"
		UpdateCustomWnd(temp);
		return
	end
	
	if (0 ~= embedSlots ) then
		temp.text_40 = "115, 350, %\41����ѡ����Ҫȡ���ı�ʯλ�ã�,10"
	else
		temp.text_40 = "115, 350, %\41��װ��û��Ƕ���κα�ʯ��,10"
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
	
	rfalse("����λ���б�ʯ:"..posHas)
	
	-- �����ȼ�
	temp.RadioGroup_70 = 
	{
		image = "interface/EquipConstruction/Light/����c2.spr",
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
	
	-- ���ݿ�״̬�������
	local basepos = 114
	for i=2, 6 do
		if (0 == slotstate[i]) then
			temp["image_"..(5+i)] = 114+ 51*(i-2)..", 195,interface/EquipConstruction/MakeHole/��Ʒ��ʯ��Ƕ���ӡ.spr"
		elseif (1 == slotstate[i]) then
			temp["image_"..(5+i)] = 114+ 51*(i-2)..", 195,interface/EquipConstruction/MakeHole/��Ʒ��δ��Ƕ.spr"
			temp["image_"..i] = ""
		else
			temp["image_"..(5+i)] = 114+ 51*(i-2)..", 195,interface/EquipConstruction/MakeHole/��Ʒ������Ƕ��Ƕ.spr"
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