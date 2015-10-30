dofile '������\\װ����������.lua'

CreateNpc(6, "װ������",3,70,90,0,0,0,1099,0,3,7777)

function OnClick1099()
	QulifyEquip()
end

function QulifyEquip()
	wndQulifyEquip = wndQulifyEquip or
	{
		cleanup = true,
		image_1 = "100,100,interface/EquipConstruction/Qualify/װ������.spr",
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
		
		text_50 = "118, 425, %\041��������Ҫ������װ����",
		text_51 = "259, 376, %\041",
		text_52 = "353, 376, %\041",
		
		SprButton_20 = { pos = "423, 103", image = "interface/EquipConstruction/CommonBtn/��尴���ر�", action = "@E", ToolTip = "�ر�" },
		SprButton_21 = { pos = "403, 103", image = "interface/EquipConstruction/CommonBtn/��尴������", action = "", ToolTip = "����" },
		SprButton_22 = { pos = "185, 510", image = "interface/EquipConstruction/CommonBtn/����ȷ��", ToolTip = "��ʼ����", action = "@rc,4,@rv,5,@rv,6,@rv,7" },
		SprButton_23 = { pos = "300, 510", image = "interface/EquipConstruction/CommonBtn/����ȡ��", ToolTip = "ȡ������", action = "@E" },
		
		ItemHolder_5 = { pos = "165, 376", dragable = true, action = "@rc,1,@rv,5,@rv,6,@rv,7" },	-- װ��
		ItemHolder_6 = { pos = "259, 376", dragable = false, action = "@rc,2,@rv,5,@rv,6" },		-- ����
		ItemHolder_7 = { pos = "353, 376", dragable = false, action = "@rc,3,@rv,5,@rv,7" },		-- �������
		
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
	-- ��ʾ�û�Ҫ�ָ�ԭ��������
	local temp = {}
	local equipDetail = GetItemDetails(equip)
	local materialDetail = GetItemDetails(material,true)
	local memmate = GetItemDetails(memmate,true)
	
	if (nil == equipDetail or nil == materialDetail or nil == memmate) then
		return
	end
	
	temp.text_50 = "118, 425, %\041��ϲ�����Իָ��ɹ���"
	
	temp.SprButton_20 = { pos = "423, 103", image = "interface/EquipConstruction/CommonBtn/��尴���ر�", action = "@E", ToolTip = "�ر�" }
	temp.SprButton_22 = { pos = "185, 510", image = "interface/EquipConstruction/CommonBtn/����ȷ��", ToolTip = "��ʼ����", action = "@rc,4,@rv,5,@rv,6,@rv,7" }
	temp.SprButton_23 = { pos = "300, 510", image = "interface/EquipConstruction/CommonBtn/����ȡ��", ToolTip = "ȡ������", action = "@E" }
	
	-- ������ʾ
	local count = 1
	for i=1, 6 do
		rfalse("before is: "..equipDetail.qualitys[i])
		local real = equipDetail.qualitys[i] - rint(equipDetail.qualitys[i]/10000)*10000
		if (real ~= 0) then
			temp["text_"..(29+i)] = "305, "..(20*(count-1)+147)..", %\041"..(EquipAttNameMap[i]).."��%\169"..(real)..",8"
			count = count + 1
		else
			temp["text_"..(29+i)] = ""
		end
	end
	
	for i=1, 5 do
		local real = equipDetail.inherits[i] - rint(equipDetail.inherits[i]/10000)*10000
		if (real ~= 0 ) then
			temp["text_"..(35+i)] = "305, "..(20*(count-1)+147)..", %\041"..(EquipAttNameMap[i+6]).."��%\169"..(real)..",8"
			count = count + 1
		else
			temp["text_"..(35+i)] = ""
		end
	end
	
	UpdateCustomWnd(temp)
end

function BindAtt(equip, material, memmate, att1, att2, att3, att4, att5, att6, att7, att8, att9, att10, att11)
	-- ��ʾ�û�Ҫ�󶨻�õ�����
	local temp = {}
	local equipDetail = GetItemDetails(equip)
	local materialDetail = GetItemDetails(material,true)
	local memmate = GetItemDetails(memmate,true)
	
	if (nil == equipDetail or nil == materialDetail or nil == memmate) then
		return
	end
	
	-- �޸�����
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
	temp.text_50 = "118, 425, %\041��ϲ��װ��������ϣ�"
	
	temp.SprButton_20 = { pos = "423, 103", image = "interface/EquipConstruction/CommonBtn/��尴���ر�", action = "@E", ToolTip = "�ر�" }
	temp.SprButton_22 = { pos = "185, 510", image = "interface/EquipConstruction/CommonBtn/����ȷ��", ToolTip = "��ʼ����", action = "@rc,4,@rv,5,@rv,6,@rv,7" }
	temp.SprButton_23 = { pos = "300, 510", image = "interface/EquipConstruction/CommonBtn/����ȡ��", ToolTip = "ȡ������", action = "@E" }
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
	rfalse("������װ������������IDΪ��"..EquipQualifyMemoryMap[rank][1].."������Ϊ��"..EquipQualifyMemoryMap[rank][2].."��")
	local needMate = EquipQualifyMemoryMap[rank][1]
	local needNum  = EquipQualifyMemoryMap[rank][2]
	local normalItemTable = {}
	normalItemTable = GetItemSetting(needMate)
	
	-- �������Ƿ���ϣ���������ϣ��򵯳�
	if (mateDetail.index ~= needMate) then
		temp.ItemHolder_7 = { pos = "353, 376", dragable = true, action = "@rc,3,@rv,5,@rv,7" }
		temp.text_50 = "118, 425, %\041���������Ҫ["..(normalItemTable.name).."]"..(needNum).."����"
		temp.text_52 = ""
		temp.image_3 = ""
		UpdateCustomWnd(temp)
		return
	end
	
	-- ����������ͷ��ϣ�����ʾͼ�꼰��������
	temp.previous_7 = { itemid = needMate }
	temp.text_52 = "349, 376, %\041"..needNum
	
	-- ͳ�Ʊ������Ƿ����㹻�Ĳ���
	if (0 == CheckGoods(needMate, needNum, 1)) then
		-- ����
		temp.image_3 = "353,376,interface/EquipConstruction/�ڿ�.spr"
		temp.text_50 = "118, 425, %\041������ϲ��㣬�޷����䣬��Ҫ["..(normalItemTable.name).."]"..(needNum).."����"
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
	
	-- ��ȡҪ������װ����Ҫ�Ĳ���ID����Ŀ
	local rank = EQGetEquipRank(equipDetail.levelEM)
	rfalse("������װ���������IDΪ��"..EquipQualifyMaterialMap[rank][1].."������Ϊ��"..EquipQualifyMaterialMap[rank][2].."��")
	local needMate = EquipQualifyMaterialMap[rank][1]
	local needNum  = EquipQualifyMaterialMap[rank][2]
	local normalItemTable = {}
	normalItemTable = GetItemSetting(needMate)
		
	-- �������Ƿ���ϣ���������ϣ��򵯳�
	if (mateDetail.index ~= needMate) then
		temp.ItemHolder_6 = { pos = "259, 376", dragable = true, action = "@rc,2,@rv,5,@rv,6" }
		temp.text_50 = "118, 425, %\041������װ����Ҫ["..(normalItemTable.name).."]"..(needNum).."����"
		temp.text_51 = ""
		temp.image_2 = ""
		UpdateCustomWnd(temp)
		return
	end
	
	-- ����������ͷ��ϣ�����ʾͼ�꼰��������
	temp.previous_6 = { itemid = needMate }
	temp.text_51 = "255, 376, %\041"..needNum
	
	-- ͳ�Ʊ������Ƿ����㹻�Ĳ���
	if (0 == CheckGoods(needMate, needNum, 1)) then
		-- ����
		temp.image_2 = "259,376,interface/EquipConstruction/�ڿ�.spr"
		temp.text_50 = "118, 425, %\041������Ŀ���㣬��Ҫ["..(normalItemTable.name).."]"..(needNum).."����"
		UpdateCustomWnd(temp)
		return
	end
	temp.previous_7 = { dragable = true}			-- �������
	temp.text_50 = "118, 425, %\041�����ȷ������ʼ����װ����"
	UpdateCustomWnd(temp)
end

function QECheckEquip(equip)
	local detail = GetItemDetails(equip)
	local temp = {}
	
	if (nil == detail) then
		return
	end
	
	-- ����Ƿ�Ϊװ��
	if (detail.type < 101 or detail.type > 114 ) then
		temp.text_50 = "118, 425, %\041��������Ҫ������װ����"
		temp.ItemHolder_5 = { pos = "165, 376", dragable = true, action = "@rc,1,@rv,5,@rv,6,@rv,7" }
		UpdateCustomWnd(temp)
		return
	end
	
	-- �����װ�������г����е��������
	local count = 1
	for i=1, 6 do
		rfalse("before is: "..detail.qualitys[i])
		local real = detail.qualitys[i] - rint(detail.qualitys[i]/10000)*10000
		if (real ~= 0) then
			temp["text_"..(9+i)] = "120, "..(20*(count-1)+147)..", %\041"..(EquipAttNameMap[i]).."��%\169"..(real)..",8"
			count = count + 1
		else
			temp["text_"..(9+i)] = ""
		end
	end
	
	for i=1, 5 do
		local real = detail.inherits[i] - rint(detail.inherits[i]/10000)*10000
		if (real ~= 0 ) then
			temp["text_"..(15+i)] = "120, "..(20*(count-1)+147)..", %\041"..(EquipAttNameMap[i+6]).."��%\169"..(real)..",8"
			count = count + 1
		else
			temp["text_"..(15+i)] = ""
		end
	end
	
	for i=1, 11 do
		temp["text_"..(29+i)] = ""
	end
	
	-- ��ֹ��������װ��
	temp.previous_5 = { dragable = false}			-- װ��
	temp.previous_6 = { dragable = true}			-- ����
	temp.text_50 = "118, 425, %\041���������װ������Ĳ��ϣ�"
	
	UpdateCustomWnd(temp)
end

function StartQualify(equip, material, memory)
	local equipDetail = GetItemDetails(equip)
	local mateDetail  = GetItemDetails(material, true)
	local memDetail   = GetItemDetails(memory, true)
	
	local temp = {}
	
	if (nil == equipDetail) then
		temp.text_50 = "118, 425, %\041��������Ҫ������װ����"
		UpdateCustomWnd(temp)
		return
	end

	if (nil == mateDetail) then
		temp.text_50 = "118, 425, %\041���������װ������Ĳ��ϣ�"
		UpdateCustomWnd(temp)
		return
	end
	
	-- ��������Ŀ�Ƿ��㹻
	local rank = EQGetEquipRank(equipDetail.levelEM)
	rfalse("װ���ĵȼ�Ϊ:"..rank)
	rfalse("������װ���������IDΪ��"..EquipQualifyMaterialMap[rank][1].."������Ϊ��"..EquipQualifyMaterialMap[rank][2].."��")
	local needMate = EquipQualifyMaterialMap[rank][1]
	local needNum  = EquipQualifyMaterialMap[rank][2]
	local normalItemTable = {}
	normalItemTable = GetItemSetting(needMate)
	
	-- ͳ�Ʊ������Ƿ����㹻�Ĳ���
	if (0 == CheckGoods(needMate, needNum, 1)) then
		-- ����
		temp.image_2 = "259,376,interface/EquipConstruction/�ڿ�.spr"
		temp.text_50 = "118, 425, %\041������Ŀ���㣬��Ҫ"..(needNum).."����"
		UpdateCustomWnd(temp)
		return
	end
	
	local needMemMate = EquipQualifyMemoryMap[rank][1]
	local needMemNum  = EquipQualifyMemoryMap[rank][2]
	-- ������ϱ����㹻
	if (nil ~= memDetail) then
		rfalse("�û������˼�����ϣ�����Ŀһ��Ҫ�㹻")
		if (0 == CheckGoods(needMemMate, needMemNum, 1)) then
			temp.image_3 = "353,376,interface/EquipConstruction/�ڿ�.spr"
			temp.text_50 = "118, 425, %\041���������Ŀ���㣬��Ҫ"..(needNum).."����"
			UpdateCustomWnd(temp)
			return
		end
	end
	
	-- ����2�����ݽṹ
	local attBefore = {}
	local attAfter = {}
	
	-- ��ȡװ��Ŀǰ������
	for i=1, 6 do
		attBefore[i] = equipDetail.qualitys[i] - rint(equipDetail.qualitys[i]/10000)*10000
		attAfter[i] = equipDetail.qualitys[i] - rint(equipDetail.qualitys[i]/10000)*10000
	end
	for i=7, 11 do
		attBefore[i] = equipDetail.inherits[i-6] - rint(equipDetail.inherits[i-6]/10000)*10000
		attAfter[i] = equipDetail.inherits[i-6] - rint(equipDetail.inherits[i-6]/10000)*10000
	end
	
	-- ��ȡװ�����ܼ���������
	local maxAtt = QualifyEquipAttNum(equipDetail.levelEM)
	rfalse("������"..maxAtt.."������")
	local attTable = GenerateEquipAAttType(maxAtt)
	
	for i=1, 11 do
		attAfter[i] = 0
	end
	
	for i=1, maxAtt do
		local base = 2*i-1
		rfalse("����Ϊ:"..attTable[base].." ֵΪ:"..attTable[base+1])
		attAfter[EquipAttIndexMap[attTable[base]]] = attTable[base+1]
	end
	
	-- �г��ϳɺ������
	local count = 1
	for i=1, 11 do
		if (attAfter[i] ~= 0) then
			temp["text_"..(29+i)] = "305, "..(20*(count-1)+147)..", %\041"..(EquipAttNameMap[i]).."��%\169"..(attAfter[i])..",8"
			count = count + 1
		else
			temp["text_"..(29+i)] = ""
		end
	end

	-- �ж��û��Ƿ��м������
	if (nil == memDetail) then
		-- ���û�м�����ϣ���ֱ�Ӹ�������
		rfalse("���û������������")
		CheckGoods(needMate, needNum, 0)
		
		-- �޸�����
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
		temp.text_50 = "118, 425, %\041��ϲ��װ��������ϣ�"
	else
		-- ���ȿ۳��������Ϻͼ������
		CheckGoods(needMate, needNum, 0)
		CheckGoods(needMemMate, needMemNum, 0)
		
		-- ��鱳����ʣ������Ƿ��㹻
		if (0 == CheckGoods(needMate, needNum, 1)) then
			temp.image_2 = "259,376,interface/EquipConstruction/�ڿ�.spr"
		end
		
		-- ��鱳����ʣ������Ƿ��㹻
		if (0 == CheckGoods(needMemMate, needMemNum, 1)) then
			temp.image_3 = "353,376,interface/EquipConstruction/�ڿ�.spr"
		end
		
		temp.SprButton_20 = { pos = "423, 103", image = "interface/EquipConstruction/CommonBtn/��尴���ر�", action = "rc,99", ToolTip = "�ر�" }
		temp.SprButton_22 = { pos = "185, 510", image = "interface/EquipConstruction/CommonBtn/����ȷ��", ToolTip = "������", 
			action = "@rc,40,@rv,5,@rv,6,@rv,7,@rc,"..attAfter[1]..",@rc,"..attAfter[2]..",@rc,"..attAfter[3]..",@rc,"..attAfter[4]..",@rc,"..attAfter[5]..",@rc,"..attAfter[6]..",@rc,"..attAfter[7]..",@rc,"..attAfter[8]..",@rc,"..attAfter[9]..",@rc,"..attAfter[10]..",@rc,"..attAfter[11] }
		temp.SprButton_23 = { pos = "300, 510", image = "interface/EquipConstruction/CommonBtn/����ȡ��", ToolTip = "�ָ�����", action = "@rc,41,@rv,5,@rv,6,@rv,7" }
		temp.text_50 = "118, 425, %\041�����ȷ���������ԣ������ȡ�����ָ�ԭ�������ԣ�"
	end
	UpdateCustomWnd(temp)
end

function EQGetEquipRank(level)
	if (0 == level or nil == level) then
		rfalse("��bug")
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