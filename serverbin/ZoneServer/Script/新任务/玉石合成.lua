dofile '������\\��ʯ�ϳ�����.lua'

CreateNpc(6,"��ʯ�ϳ�",2,65,92,0,0,0,10491,0,3,776)

RemoveObjectIndirect(1,2185)

function OnClick10491()
	ClickMenu92286(1)
end

function ClickMenu92286(index)
	BowlderCrasisItemSelector = BowlderCrasisItemSelector or 
	{
		cleanup = true,   
		image_1 = "100,100,interface/EquipConstruction/BowlderCrasis/��ʯ����.spr",
		image_2 = "131,155",
		image_3 = "",
		image_18	= "",			-- ��Ƥ
		
		SprButton_20 = { pos = "332,103", SprFileName_Normal = "interface/common/��尴������1.spr", SprFileName_Down = "interface/common/��尴������3.spr", SprFileName_Active = "interface/common/��尴������2.spr", action = "" },
		SprButton_30 = { pos = "350,103", SprFileName_Normal = "interface/common/��尴���ر�1.spr", SprFileName_Down = "interface/common/��尴���ر�3.spr", SprFileName_Active = "interface/common/��尴���ر�2.spr", action = "@E" }	,
		SprButton_40 = { pos = "148,452", SprFileName_Normal = "interface/common/����ȷ��1.spr", SprFileName_Down = "interface/common/����ȷ��3.spr", SprFileName_Active = "interface/common/����ȷ��2.spr", action = "@rc,3,@rv,600,@rv,700" },
		SprButton_50 = { pos = "264,452", SprFileName_Normal = "interface/common/����ȡ��1.spr", SprFileName_Down = "interface/common/����ȡ��3.spr", SprFileName_Active = "interface/common/����ȡ��2.spr", action = "@E" }	, 

		ItemHolder_600 = { pos = "131,155", dragable = true, action = "@rc,1,@rv,600" },
		ItemHolder_700 = { pos = "131,211", dragable = false, action = ""},
		ItemHolder_800 = { pos = "164,289", dragable= false, action = ""},
		
		text_9 = "",
		text_10 = "",
		text_19	= "121,371,%\41��������Ҫ�ϳɵı�ʯ��,10",
        text_20 = "",				-- ���������
		WndItem = { pos = "380,100", visiable = "true" },           -- �򿪵������
		ChatPanel = {visiable = "true"}
		}
		WndCustomize( BowlderCrasisItemSelector, "BowlderCrasis1" )--��ʾ�������趨�Ĵ��ڿ�ܶ�ֲ��   
end
----------------------------------------------------------------------------------
function BowlderCrasis1(arg1,arg2,arg3)
	if ( arg1 == 1 ) then
		BowlderCheck(arg2)
	elseif( arg1 == 2 ) then
		BCCheckMaterial(arg2, arg3)
	elseif (arg1 == 3) then
		BowlderCrasis2(arg2, arg3)
    end
end

function BowlderCrasis2(jewel, material)
	local jdetail = GetItemDetails(jewel)
	local temp = {}
	
	if (nil == jdetail) then
		temp.text_19 = "121,371,%\41�������Ҫ�����ı�ʯ��"
		UpdateCustomWnd(temp)
		return
	end
	
	-- �жϲ��ϵ���Ч��
	local itemTable = {}
	local findItem = 0
	
	for k,v in pairs(��ʯ�ϳ����ñ�) do 
		if(v.stuffMost == jdetail.index)then
			itemTable = v
			findItem = 1
			break
		end
	end
	
	if (0 ~= findItem) then
		--��ʾ�����Ҫ�Ĳ���
		local normalItemTable = {}
		local resultItemTable = {}
		normalItemTable = GetItemSetting(itemTable.stuffNorm)
		resultItemTable = GetItemSetting(itemTable.resultObj)
		
		-- ��鱳���в��ϵ���Ŀ�Ƿ��㹻
		if (0 == CheckGoods(itemTable.stuffNorm, itemTable.normalNum, 1)) then
			temp.image_18 = "131,211,interface/EquipConstruction/�ڿ�.spr"
			temp.text_19 = "121,371,%\41�����еĲ��ϲ��㣬��Ҫ["..(normalItemTable.name).."]"..(itemTable.normalNum).."����"
			UpdateCustomWnd(temp)
			return
		end
		
		-- ���Ǯ
		local Money = CheckGoods(0,itemTable.needMoney,1)
		if(Money == 0) then
	      	temp.text_19 = "121,371,%\41��û���㹻�Ľ�Ǯ��"
	      	UpdateCustomWnd(temp)
			return
		end
		
		-- ��鱳��
		local pakagenum = isFullNum()
		if (pakagenum < 1) then
			temp.text_19 = "121,371,%\41����û��ʣ��Ŀռ䣡"
			UpdateCustomWnd(temp)
			return
		end

		temp.SprButton_40 = { pos = "148,452", SprFileName_Normal = "interface/common/����ȷ��1.spr", SprFileName_Down = "interface/common/����ȷ��3.spr", SprFileName_Active = "interface/common/����ȷ��2.spr", 
			action = "@rc,3,@rv,600,@rv,700" }
			
		-- ��ʼ�ϳ�
		local succRatio = itemTable.successOdds
		rfalse("��������Ϊ:"..succRatio)
		local randomRatio = math.random(1,100)
		if (randomRatio <= succRatio ) then 
			-- �۳���ʯ�����Ϻ�Ǯ
			CheckGoods(0, itemTable.needMoney,0)
			CheckGoods(itemTable.stuffNorm,itemTable.normalNum,0)
			CheckGoods(itemTable.stuffMost,itemTable.mostlyNum,0)
			GiveGoods(itemTable.resultObj, itemTable.resultNum)
			
			temp.ItemHolder_600 = { pos = "131,155", dragable = true, action = "@rc,1,@rv,600" }
			temp.ItemHolder_700 = { pos = "131,211", dragable = false, action = "@rc,2,@rv,600,@rv,700"}
			temp.ItemHolder_800 = { pos = "164,289", dragable= false, action = "@rc,99"}
			temp.image_2 = ""
			temp.image_3 = ""
			temp.text_9 = ""
			temp.text_10 = ""
			temp.text_20 = ""
			temp.text_19 = "121,371,%\41��ϲ����ʯ�����ɹ���"
			JewelUpdateShow(1)
			UpdateCustomWnd(temp)
		else
			-- �۳�Ǯ�Ͳ���
			CheckGoods(0, itemTable.needMoney,0)
			CheckGoods(itemTable.stuffNorm,itemTable.normalNum,0)
			temp.ItemHolder_600 = { pos = "131,155", dragable = true, action = "@rc,1,@rv,600" }
			temp.ItemHolder_700 = { pos = "131,211", dragable = false, action = "@rc,2,@rv,600,@rv,700"}
			temp.ItemHolder_800 = { pos = "164,289", dragable= false, action = "@rc,99"}
			temp.image_2 = ""
			temp.image_3 = ""
			temp.text_9 = ""
			temp.text_10 = ""
			temp.text_20 = ""
			temp.text_19 = "121,371,%\41��ʯ����ʧ�ܣ�"
			JewelUpdateShow(0)
			UpdateCustomWnd(temp)
			return
		end
	else
		rfalse("��ʯ�ϳ����ô��󣡣�")
		return
	end	
end
----------------------------------------------------
function BCEffect(ops)
end

function SetIconPath(iconID)
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

function BowlderCheck(jewel)
	local detail = GetItemDetails(jewel)
	if (nil == detail) then
		return
	end
	
	local temp = {}
	
	-- ��鱦ʯ����
	if (detail.index < 101 or detail.index > 430 ) then
		temp.text_19 = "121,371,%\41�����Ҫ�����ı�ʯ���ͣ�"
		temp.ItemHolder_600 = { pos = "131,155", dragable = true, action = "@rc,1,@rv,600,@rv,700" }
	    UpdateCustomWnd( temp )----��ʾ����״̬
		return
	end
		
	-- ��ʯ�ĵȼ�����Ϊ��߼�
	if (detail.index == 130 or detail.index == 230 or detail.index == 330 or detail.index == 430) then
		temp.text_19 = "121,371,%\41��ʯ�Ѿ�����߼����޷�������"
		temp.ItemHolder_600 = { pos = "131,155", dragable = true, action = "@rc,1,@rv,600,@rv,700" }
		temp.image_2 = ""
	    UpdateCustomWnd( temp )----��ʾ����״̬
		return
	end
	
	-- ��ʯ��������(��ʾ��ʯ������)
	local normalItemTable = {}
	normalItemTable = GetItemSetting(detail.index)
	local imageIndex = GetIconPath(normalItemTable.iconID)
	temp.image_2 = "131,155,interface/goods/"..imageIndex
	temp.text_19 = "121,371,%\41"
	
	-- ��ֹ����������ʯ
	temp.previous_600 = {dragable = false,}
	
	local itemTable = {}
	local findItem = 0
	
	for k,v in pairs(��ʯ�ϳ����ñ�) do 
		if(v.stuffMost == detail.index) then
			itemTable = v
			findItem = 1
			break
		end
	end
	
	if (0 ~= findItem ) then
		local normalItemTable = {}
		local resultItemTable = {}
		normalItemTable = GetItemSetting(itemTable.stuffNorm)
		resultItemTable = GetItemSetting(itemTable.resultObj)
		
		-- �ҵ���ƥ����
		temp.text_9 = "178,343,%\41"..itemTable.needMoney
		temp.text_10 = "326,343,%\41"..itemTable.successOdds.."��"
		temp.previous_700 = { itemid = itemTable.stuffNorm}
		temp.text_20 = "131,211,%\41"..itemTable.normalNum..",6"
	
		local normalItemTable2 = {}
		normalItemTable2 = GetItemSetting(itemTable.resultObj)
		local path = GetIconPath(normalItemTable2.iconID)	
		temp.image_3 = "164,289,interface/goods/"..imageIndex
		temp.previous_800 = {itemid = itemTable.resultObj}
		
		-- ��鱳���в��ϵ���Ŀ�Ƿ��㹻
		if (0 == CheckGoods(itemTable.stuffNorm, itemTable.normalNum, 1)) then
			temp.image_18 = "131,211,interface/EquipConstruction/�ڿ�.spr"
			temp.text_19 = "121,371,%\41�����еĲ��ϲ��㣬��Ҫ["..(normalItemTable.name).."]"..(itemTable.normalNum).."����"
			UpdateCustomWnd(temp)
			return
		end
		
		-- ���Ǯ
		local Money = CheckGoods(0,itemTable.needMoney,1)
		if(Money == 0) then
	      	temp.text_19 = "121,371,%\41��û���㹻�Ľ�Ǯ��"
	      	UpdateCustomWnd(temp)
			return
		end
		
		--��ʾ�����Ҫ�Ĳ���
		temp.text_19 = "121,371,%\41���Կ�ʼ������ʯ�ˣ�"
		
		temp.SprButton_40 = { pos = "148,452", SprFileName_Normal = "interface/common/����ȷ��1.spr", SprFileName_Down = "interface/common/����ȷ��3.spr", SprFileName_Active = "interface/common/����ȷ��2.spr", 
			action = "JewelUp,��ȷ��Ҫ������ʯ��,@rc,3,@rv,600,@rv,700" }
		
		UpdateCustomWnd( temp )
	else
		rfalse("��ʯ�ϳ����ô��󣡣�")
		return
	end
end

