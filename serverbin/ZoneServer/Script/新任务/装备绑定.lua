--BindEquip( 道具ItemHolder, 绑定天数  )

--dofile '新任务\\装备绑定配置表.lua'

CreateNpc(6,"装备绑定",1,69,95,0,0,0,10490,0,3,705)

RemoveObjectIndirect(1,2185)
--CreateObjectIndirect( { regionId = 6,name = "装备绑定",imageId = 1,  x = 102, y = 149,  clickScript = 10490, dir = 5,objectType = 1, controlId = 2185}  )

function OnClick10490()
	--SetMessage(92285,"现今贼人太多，即使刀不离身也难保不会丢失。如果少侠有什么好的装备需要保管，我可以帮你将它绑定，绑定之后的物品可以使用，但不能交易，不能卖给商店，不能丢弃，不会被任务NPC收走，只有达到绑定时限才会解除绑定，这样就可保万无一失了，不过需要绑定锁作为绑定的酬劳！#我想绑定装备#我不需要#",0,0)
	ClickMenu92285()
end

function ClickMenu92285()
	wndItemLock = wndItemLock or 
	{	
		cleanup = true,
		image_1	= "100,100,interface/EquipConstruction/EquipBind/装备绑定.spr",
		SprButton_2 = { pos = "332,103", SprFileName_Normal = "interface/common/面板按键帮助1.spr", SprFileName_Down = "interface/common/面板按键帮助3.spr", SprFileName_Active = "interface/common/面板按键帮助2.spr", action = "" },
		SprButton_3 = { pos = "350,103", SprFileName_Normal = "interface/common/面板按键关闭1.spr", SprFileName_Down = "interface/common/面板按键关闭3.spr", SprFileName_Active = "interface/common/面板按键关闭2.spr", action = "@E" }	,
		text_4 = "225,228,%\050,12",
		SprButton_5 = { pos = "183,251", SprFileName_Normal = "interface/common/按键确定1.spr", SprFileName_Down = "interface/common/按键确定3.spr", SprFileName_Active = "interface/common/按键确定2.spr", action = "@rc,1,@rv,7" },
		SprButton_6 = { pos = "287,251", SprFileName_Normal = "interface/common/按键取消1.spr", SprFileName_Down = "interface/common/按键取消3.spr", SprFileName_Active = "interface/common/按键取消2.spr", action = "@E" }	,
		ItemHolder_7 = { pos = "224,146", dragable = true, border = false,action = "@rc,2,@rv,7" },
		ItemHolder_8 = { pos = "125,207", dragable = false, border = false,action = "@rc,3,@rv,7,@rv,8" },
        image_12 = "",		-- 蒙皮
		text_30	= "121, 300,%\050请放入需要绑定的装备！,10",
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

--检查装备是否合法 
function CheckValidItemLock(EquipHandle)
	local temp = {}
	local details = GetItemDetails(EquipHandle)
	if ( details == nil or details.type <= 100 or details.type >= 115) then  --为非装备道具 
		temp.text_30	= "121, 300,%\050该物品无法放入面板中！,10"
		temp.previous_7 = { itemid = -1 }
		UpdateCustomWnd( temp )
		return
	end

	--这里还需要做其他检查,如已是绑定的装备则不能再绑定 2010.3.16 jym
	if( not (details.flags == 0 or 
	  (details.prefix == 1 and details.flags == 1)) )then
	  	temp.text_30	= "121, 300,%\050该装备无法绑定！,10"
		temp.previous_7 = { itemid = -1 }
		UpdateCustomWnd( temp )
		return
	elseif(details.prefix == 2)then
		temp.text_30	= "121, 300,%\050租赁的装备不可绑定！,10"
		temp.previous_7 = { itemid = -1 }
		UpdateCustomWnd( temp )
		return
	end
	
	temp.previous_7 = { dragable = false,}
	
	--根据道具ID查找配置表，提示需要的材料与金钱
	local itemTable = nil   		--查找结果表
	local itemDetailsTable = {}    	--材料信息表
	local count = 0                 --材料数
	local needMoney = 0             --需要金钱
	for k,v in pairs(装备绑定配置表) do
		if(details.levelEM < v.equipLevel)then
				itemTable = v
				break
		end
	end
	--找到了配置项
	if(itemTable ~= nil) then
    	itemDetailsTable = GetItemSetting(itemTable.stuffID)
    	count = itemTable.stuffNum
    	needMoney = itemTable.needMoney  
    	temp.text_4 = "225,228,%\050"..(itemDetailsTable.name).."x"..count..",12"--" 金钱x"..needMoney..",12"
    	temp.previous_8 = { itemid = itemTable.stuffID,}
    	--检查材料
    	if (0 == CheckGoods(itemTable.stuffID, count, 1)) then
			temp.image_12 = "125,207,interface/EquipConstruction/黑框.spr"
	        temp.text_30	= "121, 300,%\050材料不足，不能绑定装备！,10"
			UpdateCustomWnd( temp )
			return
		end
		--检查金钱
  		if(itemTable.needMoney ~= 0) then
		 	local money = CheckGoods(0,itemTable.needMoney,1)
	   		if(money == 0)then
	         	temp.image_12 = "125,207,interface/EquipConstruction/黑框.spr"
		        temp.text_30	= "121, 300,%\050金钱不足，不能绑定装备！,10"
				UpdateCustomWnd( temp )
	      		return
	      	end
		end
	else
		refalse("装备绑定配置表BUG")
		return
	end
	
	local equipDetailsTable = GetItemSetting(details.index)
	temp.text_30	= "121, 300,%\050请点击确定绑定装备！,10"
	--temp.previous_5 = { action = "@box,是否要将 %\050"..(equipDetailsTable.name).." 绑定?,@rc,1,@rv,7"  }
	temp.SprButton_5 = 
	{ 
		pos = "183,251",
		SprFileName_Normal = "interface/common/按键确定1.spr", 
		SprFileName_Down = "interface/common/按键确定3.spr", 
		SprFileName_Active = "interface/common/按键确定2.spr", 
		action = "@box,是否要将 %\050"..(equipDetailsTable.name).." %0绑定?,@rc,1,@rv,7" 
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
	--以前的绑定时间 DayNum
	local DayNum = 1
	
	local temp = {}
	
	if (EquipHandle == nil) then
        temp.text_30	= "121, 300,%\050请放入需要绑定的装备！,10"
	  	UpdateCustomWnd( temp )
		return
	end
	local equipDetails = GetItemDetails(EquipHandle)
	if (equipDetails == nil) then
		temp.text_30	= "121, 300,%\050请放入需要绑定的装备！,10"
	  	UpdateCustomWnd( temp )
		return
	end

 	--根据道具ID查找配置表，提示需要的材料与金钱
	local itemTable = nil   		--查找结果表
	local itemDetailsTable = {}    	--材料信息表
	local count = 0                 --材料数
	local needMoney = 0             --需要金钱
	for k,v in pairs(装备绑定配置表) do
		if(equipDetails.levelEM < v.equipLevel)then
				itemTable = v
				break
		end
	end
	--找到了配置项
	if(itemTable ~= nil) then
    	itemDetailsTable = GetItemSetting(itemTable.stuffID)
    	count = itemTable.stuffNum
    	needMoney = itemTable.needMoney

    	--检查材料
    	if (0 == CheckGoods(itemTable.stuffID, count, 1)) then
			temp.image_12 = "125,207,interface/EquipConstruction/黑框.spr"
	        temp.text_30	= "121, 300,%\050材料不足，不能绑定装备！,10"
			UpdateCustomWnd( temp )
			return
		end
		--检查金钱
  		if(itemTable.needMoney ~= 0) then
		 	local money = CheckGoods(0,itemTable.needMoney,1)
	   		if(money == 0)then
	         	temp.image_12 = "125,207,interface/EquipConstruction/黑框.spr"
		        temp.text_30	= "121, 300,%\050金钱不足，不能绑定装备！,10"
				UpdateCustomWnd( temp )
	      		return
	      	end
		end
	else
		refalse("装备绑定配置表BUG")
		return
	end

	if(equipDetails.flags == 0 or
	  (equipDetails.prefix == 1 and equipDetails.flags == 1))then

		BindEquip(EquipHandle,DayNum*24,1)
		
		--删除物品
		CheckGoods(itemTable.stuffID,count,0)
		--删除金钱
		CheckMoney(0,needMoney,0)

		UpdateCustomWnd( wndItemLock )
		temp.text_30	= "121, 300,%\050您的装备绑定完成，已放入您的背包中。,10"
		TalkToPlayer(0,"恭喜你，绑定装备成功！")
	  	UpdateCustomWnd( temp )----显示以上状态
		return
	end
end