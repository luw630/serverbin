CreateNpc(6, "װ�����",3,67,88,0,0,0,1000,0,3,708)

function OnClick1000()
	MakeEquipHole()
end

function ClickMenu30000()
	MakeEquipHole()
end

-- Ϊװ�����
function MakeEquipHole()
	wndItemMakeHole = wndItemMakeHole or
	{
		cleanup = true,
		image_1 	= "100,100,interface/EquipConstruction/MakeHole/װ�����.spr",
		
		image_2 = "",
		image_3 = "",
		image_4 = "",
		image_5 = "",
		image_6 = "",
		
		image_7 	= "114, 195,interface/EquipConstruction/MakeHole/��Ʒ��ʯ��Ƕ���ӡ.spr",
		image_8 	= "165, 195,interface/EquipConstruction/MakeHole/��Ʒ��ʯ��Ƕ���ӡ.spr",
		image_9 	= "216, 195,interface/EquipConstruction/MakeHole/��Ʒ��ʯ��Ƕ���ӡ.spr",
		image_10 	= "267, 195,interface/EquipConstruction/MakeHole/��Ʒ��ʯ��Ƕ���ӡ.spr",
		image_11 	= "318, 195,interface/EquipConstruction/MakeHole/��Ʒ��ʯ��Ƕ���ӡ.spr",
		image_40 	= "",
		image_41	= "",
		SprButton_7 = 		-- �رհ�ť
		{
			pos = "350, 103",
			image = "interface/EquipConstruction/CommonBtn/��尴���ر�",
			action = "@rc,90,@rv,18,@E",
			ToolTip = "�ر�"
		},
		SprButton_8	=		-- ������ť
		{
			pos = "333, 103",
			image = "interface/EquipConstruction/CommonBtn/��尴������",
			ToolTip = "����",
			action = "@rc,90,@E"	-- ��ʱ�趨Ϊ�ر�
		},
		SprButton_9 =		-- ��ʼ���
		{
			pos = "182, 302",
			image = "interface/EquipConstruction/CommonBtn/����ȷ��",
			ToolTip = "��ʼ�򵥸���",
			action = "@rc,5,@rv,18,@rv,19"
		},
		SprButton_10 = 		-- ȡ�����
		{
			pos = "295, 302",
			image = "interface/EquipConstruction/CommonBtn/����ȡ��",
			ToolTip = "ȡ�����",
			action = "@rc,99,@rv,18,@E"
		},
		SprButton_11 = 		-- ��ʼ�������
		{
			pos = "295, 339",
			image = "interface/EquipConstruction/CommonBtn/������ʼ",
			ToolTip = "��ʼ�������",
			action = "@rc,30,@rv,18,@rv,19"
		},
		SprButton_12 =
		{
			pos = "230, 340",
			image = "interface/EquipConstruction/CommonBtn/С���ͷ����",
			--ToolTip = "�������������",
			enable = false,
			action = "@rc,10,@rv,18,@rv,19"
		},
		SprButton_13 =
		{
			pos = "266, 340",
			image = "interface/EquipConstruction/CommonBtn/С�Ҽ�ͷ����",
			--ToolTip = "�������������",
			enable = false,
			action = "@rc,11,@rv,18,@rv,19"
		},
		ItemHolder_18 =							-- װ��
		{
			pos = "225, 146",
			dragable = true,
			action = "@rc,1,@rv,18"
		},
		ItemHolder_19 =							-- ����
		{
			pos = "124, 256",
			dragable = false,
			action = "@rc,4,@rv,18,@rv,19"
		},
		ItemHolder_20 =							-- λ��һ
		{
			pos = "122, 202",
			dragable = false,
		},
		ItemHolder_21 =							-- λ�ö�
		{
			pos = "173, 202",
			dragable = false,
		},
		ItemHolder_22 =							-- λ����
		{
			pos = "224, 202",
			dragable = false,
		},
		ItemHolder_23 =							-- λ����
		{
			pos = "275, 202",
			dragable = false,
		},
		ItemHolder_24 =							-- λ����
		{
			pos = "326, 202",
			dragable = false,
		},
		text_14 = "217, 279, %\41,8",
		text_15 = "307, 279, %\041,8",
		text_16 = "245, 342, %\0410,8",
		text_20 = "115, 367, %\41��������Ҫ��׵�װ����,10",
		WndItem = { pos = "400,100", visiable = "true" },
		ChatPanel = {visiable = "true"}
	}	
	WndCustomize(wndItemMakeHole, "MakeHoleFunc")
end

function MakeHoleFunc(ops, arg1, arg2)
	rfalse(ops)
	if (1 == ops ) then						-- ops == 1 ��ʾ��ҽ�װ��������װ����
		CheckEquip(arg1)
	elseif (ops>=10 and ops<=15) then
		rfalse(ops)
		ChangeHoleBatch(ops, arg1 ,arg2)
	elseif (4 == ops) then					-- ops == 4 ��ʾ��������˲���
		CheckMaterial(arg1, arg2)
	elseif (5 == ops) then					-- �򵥸���
		MakeSingleHole(arg1, arg2)
	elseif (ops>=30 and ops <= 35 ) then	-- �������
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

-- ���ӻ��߼���������׵���Ŀ
function ChangeHoleBatch(ops, equip, material)
	local detail = GetItemDetails(equip)
	-- materialΪ��Чhandle����Ϊ����holder��û�б�����ϵ�handle
	--local materialDetails = GetItemDetails(material)
	if (nil == detail) then
		rfalse("װ����Ч...")
		return
	end
	
	local temp = {}
	
	local currentNum = ops - 10
	
	-- ��ȡװ�������ɴ����
	local invalidSlots = 0
	for i=1, 5 do
		if (0 == detail.slots[i] ) then
			invalidSlots = invalidSlots + 1
		end
	end
	rfalse("װ��Ŀǰ�����ɴ������:"..invalidSlots)

	if (0 == invalidSlots ) then
		return
	end
	
	if (0 == currentNum ) then
		rfalse("come to here again")
		temp.SprButton_12 =
		{
			pos = "230, 340",
			image = "interface/EquipConstruction/CommonBtn/С���ͷ����",
			ToolTip = "�������������",
			action = "@rc,10,@rv,18,@rv,19"
		}
		temp.SprButton_13 =
		{
			pos = "266, 340",
			image = "interface/EquipConstruction/CommonBtn/С�Ҽ�ͷ����",
			ToolTip = "�������������",
			action = "@rc,11,@rv,18,@rv,19"
		}
		temp.text_16 = "245, 342, %\41"..tostring(0)..",8"
	elseif (invalidSlots == currentNum) then
		rfalse("���������ֵ")
		temp.SprButton_12 =
		{
			pos = "230, 340",
			image = "interface/EquipConstruction/CommonBtn/С���ͷ����",
			ToolTip = "�������������",
			action = "@rc,"..(10+currentNum-1)..",@rv,18,@rv,19"
		}
		rfalse("Left: "..(10+currentNum-1))
		temp.SprButton_13 =
		{
			pos = "266, 340",
			image = "interface/EquipConstruction/CommonBtn/С�Ҽ�ͷ����",
			ToolTip = "�������������",
			action = "@rc,"..(10+invalidSlots)..",@rv,18,@rv,19"
		}
		rfalse("right: "..(10+invalidSlots))
		temp.text_16 = "245, 342, %\41"..tostring(invalidSlots)..",8"
	else
		temp.SprButton_12 =
		{
			pos = "230, 340",
			image = "interface/EquipConstruction/CommonBtn/С���ͷ����",
			ToolTip = "�������������",
			action = "@rc,"..(10+currentNum-1)..",@rv,18,@rv,19"
		}
		temp.SprButton_13 =
		{
			pos = "266, 340",
			image = "interface/EquipConstruction/CommonBtn/С�Ҽ�ͷ����",
			ToolTip = "�������������",
			action = "@rc,"..(10+currentNum+1)..",@rv,18,@rv,19"
		}
		temp.text_16 = "245, 342, %\41"..tostring(currentNum)..",8"
	end
	
	if(currentNum ~= 0)then
		temp.SprButton_11 = 		-- ��ʼ�������
		{
			pos = "295, 339",
			image = "interface/EquipConstruction/CommonBtn/������ʼ",
			ToolTip = "��ʼ�������",
			action = "@box,�Ƿ�Ҫ������� %\050"..tostring(currentNum).." %0��?,@rc,"..(30+currentNum)..",@rv,18,@rv,19"
		}
	else
	    temp.SprButton_11 = 		-- ��ʼ�������
		{
			pos = "295, 339",
			image = "interface/EquipConstruction/CommonBtn/������ʼ",
			ToolTip = "��ʼ�������",
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
		temp.text_20 = "115, 367, %\41��������Ҫ��׵�װ����,8"
		UpdateCustomWnd(temp)
		return
	end
	
	if (nil == materialDetails) then
		temp.text_20 = "115, 367, %\41��������Ҫ��׵Ĳ��ϣ�,8"
		UpdateCustomWnd(temp)
		return
	end
	
	-- ��ȡĿǰ��Ч�׵ĸ���
	local validSlots=0
	for i=1, 5 do
		if (0 ~= equipDetails.slots[i]) then			
			validSlots = validSlots+1
		end
	end
	
	-- ��ȡ���������
	local totalholes = count-30
	
	if (0 == totalholes) then
		temp.text_20 = "115, 367, %\41��ѡ��������׵���Ŀ��,10"
		UpdateCustomWnd(temp)
		return
	end
		
	-- ��ȡ���ײ�������
	local realNeed = CheckEMMatch(equipDetails.levelEM, materialDetails.index)
	if (nil == realNeed) then
		rfalse("��bug")
		return
	end
	
	-- ��ȡ������index���ߵĸ���
	local totalAmount = GetItemNum(materialDetails.index)
	rfalse("�����й���:"..totalAmount)
	
	-- �����������㣬��ʼ�������
	local realHave = totalAmount
	local maked = 0		-- �Ѵ�׵ĸ���
	local failed = 0	-- ʧ��
	local last = realHave
	
	repeat
		-- �����жϲ����Ƿ��㹻
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
			rfalse("�����"..randomRatio)
			if (randomRatio <= succRatio ) then 
				equipDetails.slots[pos] = 1
				UpdateItemDetails(equip, equipDetails)
				maked = maked + 1
	
				-- ���Ĳ���
				last = last-realNeed
				totalholes = totalholes - 1
			else
				last = last-realNeed
				failed = failed + 1
			end
			
			-- ��ȡװ�������ɴ����
			local invalidHoles = 0
			for i=1, 5 do
				if (0 == equipDetails.slots[i] ) then
					invalidHoles = invalidHoles + 1
				end
			end
			rfalse("InvalidHoles is:"..invalidHoles)
		else		
			temp.image_41 = "124,256,interface/EquipConstruction/�ڿ�.spr"
			temp.SprButton_11 = 		-- ��ʼ�������
			{
				pos = "295, 339",
				image = "interface/EquipConstruction/CommonBtn/������ʼ",
				ToolTip = "��ʼ�������",
				action = "@rc,99"
			}
			temp.SprButton_9 =			-- ��ʼ���
			{
				pos = "182, 302",
				image = "interface/EquipConstruction/CommonBtn/����ȷ��",
				ToolTip = "��ʼ�򵥸���",
				action = "@rc,99"
			}
			temp.text_20 = "115, 367, %\41������Ŀ���㣬�޷�����Ϊװ����ף�,10"
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
		image = "interface/EquipConstruction/CommonBtn/С���ͷ����",
		--ToolTip = "�������������",
		enable = false,
		action = "@rc,10,@rv,18,@rv,19"
	}
	temp.SprButton_13 =
	{
		pos = "266, 340",
		image = "interface/EquipConstruction/CommonBtn/С�Ҽ�ͷ����",
		--ToolTip = "�������������",
		enable = false,
		action = "@rc,11,@rv,18,@rv,19"
	}
	temp.SprButton_11 =
	{
		pos = "295, 339",
		image = "interface/EquipConstruction/CommonBtn/������ʼ",
		ToolTip = "��ʼ�������",
		action = "@rc,"..(30)..",@rv,18,@rv,19"
	}
	temp.text_16 = "245, 342, %\41"..tostring(0)..",8"
	
	if (0 ~= maked) then
		temp.text_20 = "115, 367, %\41���γɹ�����"..maked.."���ף�����"..(realHave-last).."������,10"
	end
	
	CheckGoods(materialDetails.index, totalAmount-last, 0)

	temp.ItemHolder_19 =							-- ����
	{
		pos 		= "124, 256",
		dragable 	= false,
		action 		= "@rc,4,@rv,18,@rv,19",
	}
		
	temp.image_40 = ""
	
	-- ���ݿ�״̬�������
	local basepos = 114
	for i=2, 6 do
		temp["image_"..(i+5)] = 114+ 51*(i-2)..", 195,interface/EquipConstruction/MakeHole/��Ʒ��ʯ��Ƕ���ӡ.spr"
	end

	temp.text_14 = "217, 279, %\41,8"
	temp.text_16 = "245, 342, %\41"..tostring(0)..",8"
	temp.text_15 = "307, 279, %\0410��,8"
	UpdateCustomWnd(temp)
end
-----------------------------------------

function MakeSingleHole(equip, material)
	local equipDetail = GetItemDetails(equip)
	local materialDetail = GetItemDetails(material, true)
	
	local temp = {}
	
	if (nil == equipDetail ) then
		temp.text_20 = "115, 367, %\41��������Ҫ��׵�װ����,8"
		UpdateCustomWnd(temp)
		return
	end
	
	if (nil == materialDetail) then
		temp.text_20 = "115, 367, %\41��������Ҫ��׵Ĳ��ϣ�,8"
		UpdateCustomWnd(temp)
		return
	end
	
	-- ��ȡĿǰ��Ч�׵ĸ���
	local validSlots=0
	for i=1, 5 do
		if (0 ~= equipDetail.slots[i]) then			
			validSlots = validSlots+1
		end
	end
	
	local mNeed = CheckEMMatch(equipDetail.levelEM, materialDetail.index)
	if (nil == result) then 		-- ��ʾ����ID��װ����ƥ��
		rfalse("��bug")
	end
	
	-- ��ʼ���
	local succRatio = SucceedRatio(validSlots+1)
	local randomRatio = math.random(1,100)
	if (randomRatio <= succRatio ) then 			-- �ɹ�
		equipDetail.slots[validSlots+1] = 1
		UpdateItemDetails(equip, equipDetail)
		temp.text_20 = "115, 367, %\41��ϲ��װ����׳ɹ���,10"
	else
		temp.text_20 = "115, 367, %\41װ�����ʧ�ܣ�,10"
	end
	
	temp.image_40 = ""
	
	-- ����װ��
	temp.ItemHolder_18 =
	{
		pos = "225, 146",
		dragable = true,
		action = "@rc,1,@rv,18",
	}
	
	-- �۳�����
	CheckGoods(materialDetail.index, mNeed, 0)
	
	-- ��������
	temp.ItemHolder_19 =							-- ����
	{
		pos 		= "124, 256",
		dragable 	= false,
		action 		= "@rc,4,@rv,18,@rv,19",
	}
	
	local basepos = 114
	for i=2, 6 do
		temp["image_"..(i+5)] = 114+ 51*(i-2)..", 195,interface/EquipConstruction/MakeHole/��Ʒ��ʯ��Ƕ���ӡ.spr"
	end

	temp.SprButton_12 =
	{
		pos = "230, 340",
		image = "interface/EquipConstruction/CommonBtn/С���ͷ����",
		--ToolTip = "�������������",
		enable = false,
		action = "@rc,10,@rv,18,@rv,19"
	}
	temp.SprButton_13 =
	{
		pos = "266, 340",
		image = "interface/EquipConstruction/CommonBtn/С�Ҽ�ͷ����",
		--ToolTip = "�������������",
		enable = false,
		action = "@rc,11,@rv,18,@rv,19"
	}
	temp.SprButton_11 = 		-- ��ʼ�������
	{
		pos = "295, 339",
		image = "interface/EquipConstruction/CommonBtn/������ʼ",
		ToolTip = "��ʼ�������",
		action = "@rc,"..(30)..",@rv,18,@rv,19"
	}
	
	temp.text_14 = "217, 279, %\41,8"
	temp.text_16 = "245, 342, %\41"..tostring(0)..",8"
	temp.text_15 = "307, 279, %\0410��,8"
	UpdateCustomWnd(temp)
end

--��ʼ�������Ĳ���
function CheckMaterial(equip, material)
	local equipDetail = GetItemDetails(equip)
	local materialDetail = GetItemDetails(material)
	
	local temp = {}
	
	if (nil == equipDetail or nil == materialDetail) then
		return
	end

	local result = CheckEMMatch(equipDetail.levelEM, materialDetail.index)
	if (nil == result) then 		-- ��ʾ����ID��װ����ƥ��
		temp.ItemHolder_19 ={ pos = "124, 256", dragable = true, action = "@rc,4,@rv,18,@rv,19"}		-- ��������
		temp.text_20 = "115, 367, %\41�˵����޷�Ϊװ����ף��������ʵĲ��ϣ�,10"
		--temp.text_14 = "217, 279, %\41,8"
		temp.text_16 = "245, 342, %\41"..tostring(0)..",8"
		--[[temp.SprButton_12 =
		{
			pos = "230, 340",
			image = "interface/EquipConstruction/CommonBtn/С���ͷ����",
			ToolTip = "�������������",
			action = "@rc,10,@rv,18,@rv,19"
		}
		temp.SprButton_13 =
		{
			pos = "266, 340",
			image = "interface/EquipConstruction/CommonBtn/С�Ҽ�ͷ����",
			ToolTip = "�������������",
			action = "@rc,11,@rv,18,@rv,19"
		} --]]
		temp.SprButton_11 = 		-- ��ʼ�������
		{
			pos = "295, 339",
			image = "interface/EquipConstruction/CommonBtn/������ʼ",
			ToolTip = "��ʼ�������",
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
		image = "interface/EquipConstruction/CommonBtn/С���ͷ����",
		ToolTip = "�������������",
		action = "@rc,10,@rv,18,@rv,19"
	}
	temp.SprButton_13 =
	{
		pos = "266, 340",
		image = "interface/EquipConstruction/CommonBtn/С�Ҽ�ͷ����",
		ToolTip = "�������������",
		action = "@rc,11,@rv,18,@rv,19"
	}
	temp.SprButton_11 = 		-- ��ʼ�������
	{
		pos = "295, 339",
		image = "interface/EquipConstruction/CommonBtn/������ʼ",
		ToolTip = "��ʼ�������",
		action = "@rc,"..(30)..",@rv,18,@rv,19"
	}
	local normalItemTable = {}
	normalItemTable = GetItemSetting(materialDetail.index)
	
	if (0 == CheckGoods(materialDetail.index, result, 1)) then
		temp.image_41 = "124,256,interface/EquipConstruction/�ڿ�.spr"
		temp.text_20 = "115, 367, %\41������Ŀ���㣬��Ҫ["..(normalItemTable.name).."]"..(result).."����,10"
        temp.SprButton_12 =
		{
			pos = "230, 340",
			image = "interface/EquipConstruction/CommonBtn/С���ͷ����",
			--ToolTip = "�������������",
			enable = false,
			action = "@rc,10,@rv,18,@rv,19"
		}
		temp.SprButton_13 =
		{
			pos = "266, 340",
			image = "interface/EquipConstruction/CommonBtn/С�Ҽ�ͷ����",
			--ToolTip = "�������������",
			enable = false,
			action = "@rc,11,@rv,18,@rv,19"
		}
		temp.SprButton_11 = 		-- ��ʼ�������
		{
			pos = "295, 339",
			image = "interface/EquipConstruction/CommonBtn/������ʼ",
			ToolTip = "��ʼ�������",
			action = "@rc,99"
		}
		temp.SprButton_9 =			-- ��ʼ���
		{
			pos = "182, 302",
			image = "interface/EquipConstruction/CommonBtn/����ȷ��",
			ToolTip = "��ʼ�򵥸���",
			action = "@rc,99"
		}
	else
		temp.image_41 = ""
		SprButton_11 = 		-- ��ʼ�������
		{
			pos = "295, 339",
			image = "interface/EquipConstruction/CommonBtn/������ʼ",
			ToolTip = "��ʼ�������",
			action = "@rc,30,@rv,18,@rv,19"
		}
		SprButton_9 =		-- ��ʼ���
		{
			pos = "182, 302",
			image = "interface/EquipConstruction/CommonBtn/����ȷ��",
			ToolTip = "��ʼ�򵥸���",
			action = "@rc,5,@rv,18,@rv,19"
		}
		temp.text_20 = "115, 367, %\41����[ȷ��]��[��ʼ]Ϊװ����ס�,10"
	end	
	UpdateCustomWnd(temp);
end

--��ʼ��������װ��
function CheckEquip(itemHandle)
	local detail = GetItemDetails(itemHandle)
	local invalidSlots = 0				-- �ɴ��
	local emptySlots = 0				-- ����Ƕ
	local embedSlots = 0				-- ����Ƕ
	local slotstate = {}
	local temp = {}
	
	if (detail.type < 101 or detail.type > 114) then
		temp.ItemHolder_18 =
		{
			pos = "225, 146",
			dragable = true,
			action = "@rc,1,@rv,18"
		}
		temp.text_20 = "115, 367, %\41�������Ҫ��׵�װ����,10"
		TalkToPlayer(0,"����Ʒ�޷����д�ף�")
		UpdateCustomWnd(temp);
		return
	end
	
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
		temp.text_20 = "115, 367, %\41����װ�������������޷����д�ף�,10"--jym
		TalkToPlayer(0,"����װ�������������޷����д�ף�")
		temp.text_16 = "245, 342, %\0410,8"
		temp.image_40 = ""
		UpdateCustomWnd(temp);
		return
	end
	
	-- ��������������
	temp.previous_19 = { dragable = true }
	
	-- ��ֹ�û�����������װ��		
	temp.previous_18 = { dragable = false }
	
	-- �������������ĳ�ʼֵΪ�����
	temp.text_16 = "245, 342, %\41"..tostring(0)..",8"
	temp.text_20 = "115, 367, %\41,10"
	temp.text_15 = "307, 279, %\41"..tostring(SucceedRatio(emptySlots+1)).."��,8"
		
	-- ��ʾ�����һ��Ҫ����Ŀ�
	local highLightX = 121 + (5-invalidSlots)*51
	temp.image_40 = ""..highLightX..", 202,interface/EquipConstruction/Light/����a1.spr"
			
	-- ���ݿ�״̬�������
	local basepos = 114
	for i=2, 6 do
		if (0 == slotstate[i]) then
			temp["image_"..(i+5)] = 114+ 51*(i-2)..", 195,interface/EquipConstruction/MakeHole/��Ʒ��ʯ��Ƕ���ӡ.spr"
		elseif (1 == slotstate[i]) then
			temp["image_"..(i+5)] = 114+ 51*(i-2)..", 195,interface/EquipConstruction/MakeHole/��Ʒ��δ��Ƕ.spr"
			temp["image_"..i] = ""
		else
			temp["image_"..(i+5)] = 114+ 51*(i-2)..", 195,interface/EquipConstruction/MakeHole/��Ʒ������Ƕ��Ƕ.spr"
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
	temp.text_20 = "115, 367, %\41��������ʵĴ�ײ��ϣ�,8"--jym
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
-- ���װ���ȼ��Ͳ���ID�Ƿ�ƥ��
-- �����߼�Ϊ��ͨ��װ���ȼ��鿴�����Ƿ�ƥ�䣬���ƥ�䣬�򷵻���Ҫ�Ĳ����������򷵻�nil
-- ���������ߵõ�װ������Ҫ�Ĳ������󣬿��Լ������Ĳ������Ƿ��㹻
function CheckEMMatch(equipLevel, materialID)
	local EMMap = {}		-- Equipment<-->Material 
	EMMap[1] = {1, 1}		-- �˴�Ϊ�˲��ԣ�ID��Ϊ1~8���Ժ��޸�Ϊ��ʯ��ID
	EMMap[2] = {2, 1}
	EMMap[3] = {3, 1}
	EMMap[4] = {4, 1}
	EMMap[5] = {5, 1}
	EMMap[6] = {6, 1}
	EMMap[7] = {7, 1}
	EMMap[8] = {8, 1}
	
	-- ����Բ���ȼ�
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