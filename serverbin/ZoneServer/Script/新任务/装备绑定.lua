--BindEquip( ����ItemHolder, ������  )

--dofile '������\\װ�������ñ�.lua'

CreateNpc(6,"װ����",1,69,95,0,0,0,10490,0,3,705)

RemoveObjectIndirect(1,2185)
--CreateObjectIndirect( { regionId = 6,name = "װ����",imageId = 1,  x = 102, y = 149,  clickScript = 10490, dir = 5,objectType = 1, controlId = 2185}  )

function OnClick10490()
	--SetMessage(92285,"�ֽ�����̫�࣬��ʹ��������Ҳ�ѱ����ᶪʧ�����������ʲô�õ�װ����Ҫ���ܣ��ҿ��԰��㽫���󶨣���֮�����Ʒ����ʹ�ã������ܽ��ף����������̵꣬���ܶ��������ᱻ����NPC���ߣ�ֻ�дﵽ��ʱ�޲Ż����󶨣������Ϳɱ�����һʧ�ˣ�������Ҫ������Ϊ�󶨵ĳ��ͣ�#�����װ��#�Ҳ���Ҫ#",0,0)
	ClickMenu92285()
end

function ClickMenu92285()
	wndItemLock = wndItemLock or 
	{	
		cleanup = true,
		image_1	= "100,100,interface/EquipConstruction/EquipBind/װ����.spr",
		SprButton_2 = { pos = "332,103", SprFileName_Normal = "interface/common/��尴������1.spr", SprFileName_Down = "interface/common/��尴������3.spr", SprFileName_Active = "interface/common/��尴������2.spr", action = "" },
		SprButton_3 = { pos = "350,103", SprFileName_Normal = "interface/common/��尴���ر�1.spr", SprFileName_Down = "interface/common/��尴���ر�3.spr", SprFileName_Active = "interface/common/��尴���ر�2.spr", action = "@E" }	,
		text_4 = "225,228,%\050,12",
		SprButton_5 = { pos = "183,251", SprFileName_Normal = "interface/common/����ȷ��1.spr", SprFileName_Down = "interface/common/����ȷ��3.spr", SprFileName_Active = "interface/common/����ȷ��2.spr", action = "@rc,1,@rv,7" },
		SprButton_6 = { pos = "287,251", SprFileName_Normal = "interface/common/����ȡ��1.spr", SprFileName_Down = "interface/common/����ȡ��3.spr", SprFileName_Active = "interface/common/����ȡ��2.spr", action = "@E" }	,
		ItemHolder_7 = { pos = "224,146", dragable = true, border = false,action = "@rc,2,@rv,7" },
		ItemHolder_8 = { pos = "125,207", dragable = false, border = false,action = "@rc,3,@rv,7,@rv,8" },
        image_12 = "",		-- ��Ƥ
		text_30	= "121, 300,%\050�������Ҫ�󶨵�װ����,10",
		WndItem = { pos = "380,100", visiable = "true" },
		ChatPanel = {visiable = "true"}
	}
	WndCustomize( wndItemLock, "wndItemLockCheckup1" )
end

function wndItemLockCheckup1( arg1, arg2,arg3)
	if(arg1 == 1) then
		wndItemLockCheckup2(arg2)
	elseif (arg1 == 2) then
		CheckValidItemLock(arg2)
	elseif (arg1 == 3) then
		ChechValidItem(arg2,arg3)
	end	
end

--���װ���Ƿ�Ϸ� 
function CheckValidItemLock(EquipHandle)
	local temp = {}
	local details = GetItemDetails(EquipHandle)
	if ( details == nil or details.type <= 100 or details.type >= 115) then  --Ϊ��װ������ 
		temp.text_30	= "121, 300,%\050����Ʒ�޷���������У�,10"
		temp.previous_7 = { itemid = -1 }
		UpdateCustomWnd( temp )
		return
	end

	--���ﻹ��Ҫ���������,�����ǰ󶨵�װ�������ٰ� 2010.3.16 jym
	if( not (details.flags == 0 or 
	  (details.prefix == 1 and details.flags == 1)) )then
	  	temp.text_30	= "121, 300,%\050��װ���޷��󶨣�,10"
		temp.previous_7 = { itemid = -1 }
		UpdateCustomWnd( temp )
		return
	elseif(details.prefix == 2)then
		temp.text_30	= "121, 300,%\050���޵�װ�����ɰ󶨣�,10"
		temp.previous_7 = { itemid = -1 }
		UpdateCustomWnd( temp )
		return
	end
	
	temp.previous_7 = { dragable = false,}
	
	--���ݵ���ID�������ñ���ʾ��Ҫ�Ĳ������Ǯ
	local itemTable = nil   		--���ҽ����
	local itemDetailsTable = {}    	--������Ϣ��
	local count = 0                 --������
	local needMoney = 0             --��Ҫ��Ǯ
	for k,v in pairs(װ�������ñ�) do
		if(details.levelEM < v.equipLevel)then
				itemTable = v
				break
		end
	end
	--�ҵ���������
	if(itemTable ~= nil) then
    	itemDetailsTable = GetItemSetting(itemTable.stuffID)
    	count = itemTable.stuffNum
    	needMoney = itemTable.needMoney  
    	temp.text_4 = "225,228,%\050"..(itemDetailsTable.name).."x"..count..",12"--" ��Ǯx"..needMoney..",12"
    	temp.previous_8 = { itemid = itemTable.stuffID,}
    	--������
    	if (0 == CheckGoods(itemTable.stuffID, count, 1)) then
			temp.image_12 = "125,207,interface/EquipConstruction/�ڿ�.spr"
	        temp.text_30	= "121, 300,%\050���ϲ��㣬���ܰ�װ����,10"
			UpdateCustomWnd( temp )
			return
		end
		--����Ǯ
  		if(itemTable.needMoney ~= 0) then
		 	local money = CheckGoods(0,itemTable.needMoney,1)
	   		if(money == 0)then
	         	temp.image_12 = "125,207,interface/EquipConstruction/�ڿ�.spr"
		        temp.text_30	= "121, 300,%\050��Ǯ���㣬���ܰ�װ����,10"
				UpdateCustomWnd( temp )
	      		return
	      	end
		end
	else
		refalse("װ�������ñ�BUG")
		return
	end
	
	local equipDetailsTable = GetItemSetting(details.index)
	temp.text_30	= "121, 300,%\050����ȷ����װ����,10"
	--temp.previous_5 = { action = "@box,�Ƿ�Ҫ�� %\050"..(equipDetailsTable.name).." ��?,@rc,1,@rv,7"  }
	temp.SprButton_5 = 
	{ 
		pos = "183,251",
		SprFileName_Normal = "interface/common/����ȷ��1.spr", 
		SprFileName_Down = "interface/common/����ȷ��3.spr", 
		SprFileName_Active = "interface/common/����ȷ��2.spr", 
		action = "@box,�Ƿ�Ҫ�� %\050"..(equipDetailsTable.name).." %0��?,@rc,1,@rv,7" 
	} 
	UpdateCustomWnd( temp )
	return
end

function wndItemLockCheckup2(EquipHandle )
    local name = GetPlayerData(3)
	local year = GetCurTime(0)
	local month = GetCurTime(1)
	local date = GetCurTime(2)
	local hour = GetCurTime(4)
	local minute = GetCurTime(5)
	--��ǰ�İ�ʱ�� DayNum
	local DayNum = 1
	
	local temp = {}
	
	if (EquipHandle == nil) then
        temp.text_30	= "121, 300,%\050�������Ҫ�󶨵�װ����,10"
	  	UpdateCustomWnd( temp )
		return
	end
	local equipDetails = GetItemDetails(EquipHandle)
	if (equipDetails == nil) then
		temp.text_30	= "121, 300,%\050�������Ҫ�󶨵�װ����,10"
	  	UpdateCustomWnd( temp )
		return
	end

 	--���ݵ���ID�������ñ���ʾ��Ҫ�Ĳ������Ǯ
	local itemTable = nil   		--���ҽ����
	local itemDetailsTable = {}    	--������Ϣ��
	local count = 0                 --������
	local needMoney = 0             --��Ҫ��Ǯ
	for k,v in pairs(װ�������ñ�) do
		if(equipDetails.levelEM < v.equipLevel)then
				itemTable = v
				break
		end
	end
	--�ҵ���������
	if(itemTable ~= nil) then
    	itemDetailsTable = GetItemSetting(itemTable.stuffID)
    	count = itemTable.stuffNum
    	needMoney = itemTable.needMoney

    	--������
    	if (0 == CheckGoods(itemTable.stuffID, count, 1)) then
			temp.image_12 = "125,207,interface/EquipConstruction/�ڿ�.spr"
	        temp.text_30	= "121, 300,%\050���ϲ��㣬���ܰ�װ����,10"
			UpdateCustomWnd( temp )
			return
		end
		--����Ǯ
  		if(itemTable.needMoney ~= 0) then
		 	local money = CheckGoods(0,itemTable.needMoney,1)
	   		if(money == 0)then
	         	temp.image_12 = "125,207,interface/EquipConstruction/�ڿ�.spr"
		        temp.text_30	= "121, 300,%\050��Ǯ���㣬���ܰ�װ����,10"
				UpdateCustomWnd( temp )
	      		return
	      	end
		end
	else
		refalse("װ�������ñ�BUG")
		return
	end

	if(equipDetails.flags == 0 or
	  (equipDetails.prefix == 1 and equipDetails.flags == 1))then

		BindEquip(EquipHandle,DayNum*24,1)
		
		--ɾ����Ʒ
		CheckGoods(itemTable.stuffID,count,0)
		--ɾ����Ǯ
		CheckMoney(0,needMoney,0)

		UpdateCustomWnd( wndItemLock )
		temp.text_30	= "121, 300,%\050����װ������ɣ��ѷ������ı����С�,10"
		TalkToPlayer(0,"��ϲ�㣬��װ���ɹ���")
	  	UpdateCustomWnd( temp )----��ʾ����״̬
		return
	end
end