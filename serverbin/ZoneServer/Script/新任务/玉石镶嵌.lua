CreateNpc(6,"��ʯ��Ƕ",3,63,89,0,0,0,10492,0,3,799)

RemoveObjectIndirect(1,2185)

function OnClick10492()
	InlayJewel()
end

function InlayJewel()
	wndItemInlayJewel = wndItemInlayJewel or
	{
		cleanup = true,  
		image_1 = "100,100,interface/EquipConstruction/BowlderInlay/��Ƕ.spr",
		SprButton_2 = 
		{ 
			pos = "332,103", 
			SprFileName_Normal = "interface/common/��尴������1.spr", 
			SprFileName_Down = "interface/common/��尴������3.spr", 
			SprFileName_Active = "interface/common/��尴������2.spr", 
			action = "" 
		},
		SprButton_3 = 
		{ 
			pos = "350,103", 
			SprFileName_Normal = "interface/common/��尴���ر�1.spr", 
			SprFileName_Down = "interface/common/��尴���ر�3.spr", 
			SprFileName_Active = "interface/common/��尴���ر�2.spr", 
			action = "@rc,13,@E"
		},
		SprButton_4 = 
		{ 
			pos = "148,248", 
			SprFileName_Normal = "interface/common/����ȷ��1.spr", 
			SprFileName_Down = "interface/common/����ȷ��3.spr", 
			SprFileName_Active = "interface/common/����ȷ��2.spr", 
			action = "@rc,12,@rv,6,@rv,7,@rv,8,@rv,9,@rv,10,@rv,11" 
		},
		SprButton_5 = 
		{ 
			pos = "264,248", 
			SprFileName_Normal = "interface/common/����ȡ��1.spr", 
			SprFileName_Down = "interface/common/����ȡ��3.spr", 
			SprFileName_Active = "interface/common/����ȡ��2.spr", 
			action = "@rc,13,@E"
		}, 
		ItemHolder_6 = { pos = "224,146", dragable = true, action = "@rc,1,@rv,6,@rv,7,@rv,8,@rv,9,@rv,10,@rv,11"},
		ItemHolder_7 = { pos = "122,203", dragable = false, action = "@rc,7,@rv,7,@rv,7,@rv,8,@rv,9,@rv,10,@rv,11"},
        ItemHolder_8 = { pos = "173,203", dragable = false, action = "@rc,8,@rv,8,@rv,7,@rv,8,@rv,9,@rv,10,@rv,11"},
        ItemHolder_9 = { pos = "224,203", dragable = false, action = "@rc,9,@rv,9,@rv,7,@rv,8,@rv,9,@rv,10,@rv,11"},
        ItemHolder_10 = { pos = "275,203", dragable = false, action = "@rc,10,@rv,10,@rv,7,@rv,8,@rv,9,@rv,10,@rv,11"},
        ItemHolder_11 = { pos = "326,203", dragable = false, action = "@rc,11,@rv,11,@rv,7,@rv,8,@rv,9,@rv,10,@rv,11"},
		
		-- ��ͼƬ
		image_12 = "114,195,interface/EquipConstruction/BowlderInlay/��Ʒ��ʯ��Ƕ���ӡ.spr",
		image_13 = "165,195,interface/EquipConstruction/BowlderInlay/��Ʒ��ʯ��Ƕ���ӡ.spr",
        image_14 = "216,195,interface/EquipConstruction/BowlderInlay/��Ʒ��ʯ��Ƕ���ӡ.spr",
        image_15 = "267,195,interface/EquipConstruction/BowlderInlay/��Ʒ��ʯ��Ƕ���ӡ.spr",
        image_16 = "318,195,interface/EquipConstruction/BowlderInlay/��Ʒ��ʯ��Ƕ���ӡ.spr",
				
		-- ��ʯͼƬ
		-- x: base 122, increse 51, y: 203
		image_2 = "",
        image_3 = "",
        image_4 = "",
        image_5 = "",
        image_6 = "", 
			  
		text_30	= "121, 290,%\041��������Ҫ��Ƕ��ʯ��װ����,10",
		WndItem = { pos = "380,100", visiable = "true" },           -- �򿪵������
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
        temp.text_30	= "121, 290,%\041��������Ҫ��Ƕ��ʯ��װ��!,10"
	  	UpdateCustomWnd( temp )
		return
	end
	local equipDetail = GetItemDetails(equip)
	if (equipDetail == nil) then
		temp.text_30	= "121, 290,%\041��������Ҫ��Ƕ��ʯ��װ��!,10"
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
			rfalse("λ��: "..i.."���ı�ʯ��Ϣ����ȷ")
		else
			rfalse("λ��: "..i.."���ı�ʯ��Ϣ��������ҽ�Ƕ��˱�ʯ")
		end
	end
	
	--���жϴ�װ���Ŀ������
	local emptyslotsset = ""
	
	for i=1, 5 do
		if (1 == equipDetail.slots[i]) then
			emptyslotsset = emptyslotsset..tostring(i)
		end
	end
		
	if ("" == emptyslotsset) then
		temp.text_30 = "121, 290,%\041����װ��û�пտ׿�����Ƕ��ʯ��,10"
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
			rfalse("���棺λ��"..i.."�ı�ʯ����Ϊ��"..(det.index))
		end
	end
	
	rfalse("����λ�õı�ʯ��Ϣ�Ѿ�ȫ��ȡ��"..playerput)
	
	if ("" == playerput) then
		temp.text_30 = "121, 290,%\041���ڿ��з��뱦ʯ��,10"
		UpdateCustomWnd(temp)
		return
	end
	
	rfalse("���������λ�÷����˱�ʯ: "..playerput)

	-- �����λ��
	local count = #playerput
	rfalse("����ҪǶ��"..count.."����ʯ��"..playerput)
	local empty = #emptyslotsset
	rfalse("��λ����"..empty.."��")
	rfalse(emptyslotsset)
	local index = 1
		
	repeat 
		local origPos = tonumber(string.sub(playerput,index,index))
		rfalse("ԭ����λ��Ϊ: "..origPos.." ��ʯ����Ϊ:"..JewelTypeInfo[origPos])
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
	
	-- ����װ��
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
		temp["image_"..(11+i)] = (114+51*(i-1))..",195,interface/EquipConstruction/BowlderInlay/��Ʒ��ʯ��Ƕ���ӡ.spr"
		temp["ItemHolder_"..(6+i)] = 
		{
			pos = (122+51*(i-1))..",203", 
			dragable = false, 
			action = "@rc,"..(6+i)..",@rv,"..(6+i),
		}
	end
	temp.text_30 = "121, 290,%\041��ϲ����Ƕ��ʯ�ɹ���,10"
	temp.SprButton_4 = 
	{ 
		pos = "148,248", 
		SprFileName_Normal = "interface/common/����ȷ��1.spr", 
		SprFileName_Down = "interface/common/����ȷ��3.spr", 
		SprFileName_Active = "interface/common/����ȷ��2.spr", 
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

	-- ����Ƿ�Ϊ��ʯ����
	if ((jewelDetail.index < 101) or (jewelDetail.index>500 ) or ((jewelDetail.index%100)>30)) then
		temp.text_30 = "121, 290,%\041ֻ�б�ʯ�ܱ���Ƕ�������ϣ�,10"
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
		temp.text_30 = "121, 290,%\041����ȷ����Ƕ��ʯ��,10"
		
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
				jewelName = jewelName.."��"..(set.name).."��"
			end
		end
		--rfalse("��ǰ "..jewelName)	
		temp.SprButton_4 = 
		{ 
			pos = "148,248", 
			SprFileName_Normal = "interface/common/����ȷ��1.spr", 
			SprFileName_Down = "interface/common/����ȷ��3.spr", 
			SprFileName_Active = "interface/common/����ȷ��2.spr", 
			action = "@box,�Ƿ�Ҫ�� %\041"..jewelName.." %0��Ƕ��װ������?,@rc,12,@rv,6,@rv,7,@rv,8,@rv,9,@rv,10,@rv,11"
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
		--ͳ���Ƿ�װ��û�д�� 2010.3.17 jym
		--���жϴ�װ���Ѿ���Ƕ�˼�����ʯ
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
			temp.text_30 = "121, 290,%\041����װ�����ܽ�����Ƕ�����ȶ�װ����ף�,10"
			--TalkToPlayer(0,"����װ�����ܽ�����Ƕ�����ȶ�װ����ף�")
			temp.ItemHolder_6 = { pos = "224,146", dragable = true, action = "@rc,1,@rv,6,@rv,7,@rv,8,@rv,9,@rv,10,@rv,11" }
			temp.image_12 = "114,195,interface/EquipConstruction/BowlderInlay/��Ʒ��ʯ��Ƕ���ӡ.spr"
			temp.image_13 = "165,195,interface/EquipConstruction/BowlderInlay/��Ʒ��ʯ��Ƕ���ӡ.spr"
			temp.image_14 = "216,195,interface/EquipConstruction/BowlderInlay/��Ʒ��ʯ��Ƕ���ӡ.spr"
			temp.image_15 = "267,195,interface/EquipConstruction/BowlderInlay/��Ʒ��ʯ��Ƕ���ӡ.spr"
			temp.image_16 = "318,195,interface/EquipConstruction/BowlderInlay/��Ʒ��ʯ��Ƕ���ӡ.spr"
			UpdateCustomWnd(temp)
			return
		end

		if ("" == emptyslotsset) then
			temp.text_30 = "121, 290,%\041����װ��û�пտ׿�����Ƕ��ʯ��,10"
			--TalkToPlayer(0,"����װ��û�пտ׿�����Ƕ��ʯ��")
			temp.ItemHolder_6 = { pos = "224,146", dragable = true, action = "@rc,1,@rv,6,@rv,7,@rv,8,@rv,9,@rv,10,@rv,11" }
			temp.image_12 = "114,195,interface/EquipConstruction/BowlderInlay/��Ʒ��ʯ��Ƕ���ӡ.spr"
			temp.image_13 = "165,195,interface/EquipConstruction/BowlderInlay/��Ʒ��ʯ��Ƕ���ӡ.spr"
			temp.image_14 = "216,195,interface/EquipConstruction/BowlderInlay/��Ʒ��ʯ��Ƕ���ӡ.spr"
			temp.image_15 = "267,195,interface/EquipConstruction/BowlderInlay/��Ʒ��ʯ��Ƕ���ӡ.spr"
			temp.image_16 = "318,195,interface/EquipConstruction/BowlderInlay/��Ʒ��ʯ��Ƕ���ӡ.spr"
			UpdateCustomWnd(temp)
			return
		end
		
		for i=1, 5 do
			if (0 == detail.slots[i]) then				-- ��Ч
				temp["image_"..(11+i)] = (114+51*(i-1))..",195,interface/EquipConstruction/BowlderInlay/��Ʒ��ʯ��Ƕ���ӡ.spr"
			elseif (1 == detail.slots[i]) then			-- Ϊ��
				temp["image_"..(11+i)] = (114+51*(i-1))..",195,interface/EquipConstruction/BowlderInlay/��Ʒ��δ��Ƕ.spr"
				-- �������뱦ʯ
				temp["ItemHolder_"..(6+i)] =
				{
					pos = (122+51*(i-1))..",203", 
					dragable = true, 
					action = "@rc,"..(i+6)..",@rv,"..(i+6)..",@rv,7,@rv,8,@rv,9,@rv,10,@rv,11", 
				}
			else										-- �б�ʯǶ��
				temp["image_"..(11+i)] = (114+51*(i-1))..",195,interface/EquipConstruction/BowlderInlay/��Ʒ������Ƕ��Ƕ.spr"
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
		temp.text_30 = "121, 290,%\041�������Ҫ��Ƕ�ı�ʯ��,10"
		temp.previous_6 = 
		{
			dragable = false, 
		}
	else
		temp.text_30 = "121, 290,%\041�������Ҫ��Ƕ��ʯ��װ����,10"
		temp.ItemHolder_6 = { pos = "224,146", dragable = true, action = "@rc,1,@rv,6,@rv,7,@rv,8,@rv,9,@rv,10,@rv,11" }
		temp.image_12 = "114,195,interface/EquipConstruction/BowlderInlay/��Ʒ��ʯ��Ƕ���ӡ.spr"
		temp.image_13 = "165,195,interface/EquipConstruction/BowlderInlay/��Ʒ��ʯ��Ƕ���ӡ.spr"
        temp.image_14 = "216,195,interface/EquipConstruction/BowlderInlay/��Ʒ��ʯ��Ƕ���ӡ.spr"
		temp.image_15 = "267,195,interface/EquipConstruction/BowlderInlay/��Ʒ��ʯ��Ƕ���ӡ.spr"
        temp.image_16 = "318,195,interface/EquipConstruction/BowlderInlay/��Ʒ��ʯ��Ƕ���ӡ.spr"
		UpdateCustomWnd(temp)
		return
	end
	UpdateCustomWnd(temp)
end