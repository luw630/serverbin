dofile '新任务\\玉石合成配置.lua'

CreateNpc(6,"宝石合成",2,65,92,0,0,0,10491,0,3,776)

RemoveObjectIndirect(1,2185)

function OnClick10491()
	ClickMenu92286(1)
end

function ClickMenu92286(index)
	BowlderCrasisItemSelector = BowlderCrasisItemSelector or 
	{
		cleanup = true,   
		image_1 = "100,100,interface/EquipConstruction/BowlderCrasis/玉石升级.spr",
		image_2 = "131,155",
		image_3 = "",
		image_18	= "",			-- 蒙皮
		
		SprButton_20 = { pos = "332,103", SprFileName_Normal = "interface/common/面板按键帮助1.spr", SprFileName_Down = "interface/common/面板按键帮助3.spr", SprFileName_Active = "interface/common/面板按键帮助2.spr", action = "" },
		SprButton_30 = { pos = "350,103", SprFileName_Normal = "interface/common/面板按键关闭1.spr", SprFileName_Down = "interface/common/面板按键关闭3.spr", SprFileName_Active = "interface/common/面板按键关闭2.spr", action = "@E" }	,
		SprButton_40 = { pos = "148,452", SprFileName_Normal = "interface/common/按键确定1.spr", SprFileName_Down = "interface/common/按键确定3.spr", SprFileName_Active = "interface/common/按键确定2.spr", action = "@rc,3,@rv,600,@rv,700" },
		SprButton_50 = { pos = "264,452", SprFileName_Normal = "interface/common/按键取消1.spr", SprFileName_Down = "interface/common/按键取消3.spr", SprFileName_Active = "interface/common/按键取消2.spr", action = "@E" }	, 

		ItemHolder_600 = { pos = "131,155", dragable = true, action = "@rc,1,@rv,600" },
		ItemHolder_700 = { pos = "131,211", dragable = false, action = ""},
		ItemHolder_800 = { pos = "164,289", dragable= false, action = ""},
		
		text_9 = "",
		text_10 = "",
		text_19	= "121,371,%\41请拖入您要合成的宝石！,10",
        text_20 = "",				-- 所需材料数
		WndItem = { pos = "380,100", visiable = "true" },           -- 打开道具面板
		ChatPanel = {visiable = "true"}
		}
		WndCustomize( BowlderCrasisItemSelector, "BowlderCrasis1" )--显示上面所设定的窗口框架定植表   
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
		temp.text_19 = "121,371,%\41请放入您要升级的宝石！"
		UpdateCustomWnd(temp)
		return
	end
	
	-- 判断材料的有效性
	local itemTable = {}
	local findItem = 0
	
	for k,v in pairs(玉石合成配置表) do 
		if(v.stuffMost == jdetail.index)then
			itemTable = v
			findItem = 1
			break
		end
	end
	
	if (0 ~= findItem) then
		--提示玩家需要的材料
		local normalItemTable = {}
		local resultItemTable = {}
		normalItemTable = GetItemSetting(itemTable.stuffNorm)
		resultItemTable = GetItemSetting(itemTable.resultObj)
		
		-- 检查背包中材料的数目是否足够
		if (0 == CheckGoods(itemTable.stuffNorm, itemTable.normalNum, 1)) then
			temp.image_18 = "131,211,interface/EquipConstruction/黑框.spr"
			temp.text_19 = "121,371,%\41背包中的材料不足，需要["..(normalItemTable.name).."]"..(itemTable.normalNum).."个！"
			UpdateCustomWnd(temp)
			return
		end
		
		-- 检查钱
		local Money = CheckGoods(0,itemTable.needMoney,1)
		if(Money == 0) then
	      	temp.text_19 = "121,371,%\41您没有足够的金钱！"
	      	UpdateCustomWnd(temp)
			return
		end
		
		-- 检查背包
		local pakagenum = isFullNum()
		if (pakagenum < 1) then
			temp.text_19 = "121,371,%\41背包没有剩余的空间！"
			UpdateCustomWnd(temp)
			return
		end

		temp.SprButton_40 = { pos = "148,452", SprFileName_Normal = "interface/common/按键确定1.spr", SprFileName_Down = "interface/common/按键确定3.spr", SprFileName_Active = "interface/common/按键确定2.spr", 
			action = "@rc,3,@rv,600,@rv,700" }
			
		-- 开始合成
		local succRatio = itemTable.successOdds
		rfalse("升級几率为:"..succRatio)
		local randomRatio = math.random(1,100)
		if (randomRatio <= succRatio ) then 
			-- 扣除宝石，材料和钱
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
			temp.text_19 = "121,371,%\41恭喜，宝石升级成功！"
			JewelUpdateShow(1)
			UpdateCustomWnd(temp)
		else
			-- 扣除钱和材料
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
			temp.text_19 = "121,371,%\41宝石升级失败！"
			JewelUpdateShow(0)
			UpdateCustomWnd(temp)
			return
		end
	else
		rfalse("玉石合成配置错误！！")
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
	
	-- 检查宝石类型
	if (detail.index < 101 or detail.index > 430 ) then
		temp.text_19 = "121,371,%\41请放入要升级的宝石类型！"
		temp.ItemHolder_600 = { pos = "131,155", dragable = true, action = "@rc,1,@rv,600,@rv,700" }
	    UpdateCustomWnd( temp )----显示以上状态
		return
	end
		
	-- 宝石的等级不能为最高级
	if (detail.index == 130 or detail.index == 230 or detail.index == 330 or detail.index == 430) then
		temp.text_19 = "121,371,%\41宝石已经是最高级，无法升级！"
		temp.ItemHolder_600 = { pos = "131,155", dragable = true, action = "@rc,1,@rv,600,@rv,700" }
		temp.image_2 = ""
	    UpdateCustomWnd( temp )----显示以上状态
		return
	end
	
	-- 宝石可以升级(显示宝石的类型)
	local normalItemTable = {}
	normalItemTable = GetItemSetting(detail.index)
	local imageIndex = GetIconPath(normalItemTable.iconID)
	temp.image_2 = "131,155,interface/goods/"..imageIndex
	temp.text_19 = "121,371,%\41"
	
	-- 禁止拖入其他宝石
	temp.previous_600 = {dragable = false,}
	
	local itemTable = {}
	local findItem = 0
	
	for k,v in pairs(玉石合成配置表) do 
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
		
		-- 找到了匹配项
		temp.text_9 = "178,343,%\41"..itemTable.needMoney
		temp.text_10 = "326,343,%\41"..itemTable.successOdds.."％"
		temp.previous_700 = { itemid = itemTable.stuffNorm}
		temp.text_20 = "131,211,%\41"..itemTable.normalNum..",6"
	
		local normalItemTable2 = {}
		normalItemTable2 = GetItemSetting(itemTable.resultObj)
		local path = GetIconPath(normalItemTable2.iconID)	
		temp.image_3 = "164,289,interface/goods/"..imageIndex
		temp.previous_800 = {itemid = itemTable.resultObj}
		
		-- 检查背包中材料的数目是否足够
		if (0 == CheckGoods(itemTable.stuffNorm, itemTable.normalNum, 1)) then
			temp.image_18 = "131,211,interface/EquipConstruction/黑框.spr"
			temp.text_19 = "121,371,%\41背包中的材料不足，需要["..(normalItemTable.name).."]"..(itemTable.normalNum).."个！"
			UpdateCustomWnd(temp)
			return
		end
		
		-- 检查钱
		local Money = CheckGoods(0,itemTable.needMoney,1)
		if(Money == 0) then
	      	temp.text_19 = "121,371,%\41您没有足够的金钱！"
	      	UpdateCustomWnd(temp)
			return
		end
		
		--提示玩家需要的材料
		temp.text_19 = "121,371,%\41可以开始升级宝石了！"
		
		temp.SprButton_40 = { pos = "148,452", SprFileName_Normal = "interface/common/按键确定1.spr", SprFileName_Down = "interface/common/按键确定3.spr", SprFileName_Active = "interface/common/按键确定2.spr", 
			action = "JewelUp,您确定要升级宝石吗？,@rc,3,@rv,600,@rv,700" }
		
		UpdateCustomWnd( temp )
	else
		rfalse("玉石合成配置错误！！")
		return
	end
end

