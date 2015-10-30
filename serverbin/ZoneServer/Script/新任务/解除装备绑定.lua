--dofile '新任务\\解除装备绑定配置表.lua'

CreateNpc(6,"解除装备绑定",3,69,85,0,0,0,10499,0,3,727)

--RemoveObjectIndirect(1,2185)

function OnClick10499()
	ClickMenu10499(1)
end

function ClickMenu10499(index)
	if(index == 1)then
		wndItemUnlock = wndItemUnlock or 
		{	
			cleanup = true,
			image_1	= "100,100,interface/EquipConstruction/EquipBind/装备绑定.spr",			
			SprButton_2 = { pos = "332,103", SprFileName_Normal = "interface/common/面板按键帮助1.spr", SprFileName_Down = "interface/common/面板按键帮助3.spr", SprFileName_Active = "interface/common/面板按键帮助2.spr", action = "" },
			SprButton_3 = { pos = "350,103", SprFileName_Normal = "interface/common/面板按键关闭1.spr", SprFileName_Down = "interface/common/面板按键关闭3.spr", SprFileName_Active = "interface/common/面板按键关闭2.spr", action = "@E" }	,
			text_4 = "225,228,%\050,12",
			SprButton_5 = { pos = "183,251", SprFileName_Normal = "interface/common/按键确定1.spr", SprFileName_Down = "interface/common/按键确定3.spr", SprFileName_Active = "interface/common/按键确定2.spr", action = "@rc,1,@rv,7,@rv,8" },
			SprButton_6 = { pos = "287,251", SprFileName_Normal = "interface/common/按键取消1.spr", SprFileName_Down = "interface/common/按键取消3.spr", SprFileName_Active = "interface/common/按键取消2.spr", action = "@E" }	,
			ItemHolder_7 = { pos = "224,146", dragable = true, border = false,action = "@rc,2,@rv,7" },
			ItemHolder_8 = { pos = "125,207", dragable = false, border = false, action = "@rc,3,@rv,7,@rv,8" },
			
			image_12 = "",		-- 蒙皮
			
			text_30	= "121, 300,%\050请放入需要解除绑定的装备！,10",
			WndItem = { pos = "380,100", visiable = "true" },
			ChatPanel = {visiable = "true"}
		}
		WndCustomize( wndItemUnlock, "wndItemUnlockCheckup" )
	end
end

function wndItemUnlockCheckup( arg1, arg2,arg3)
	if(arg1 == 1) then
		wndItemUnlockCheckup2(arg2)
	elseif (arg1 == 2) then
		CheckValidItemUnlock(arg2)
	elseif (arg1 == 3) then
		CheckValidItemUnlock2(arg2)
	end	
end


function CheckValidItemUnlock(EquipHandle)
	local temp = {}
	local details = GetItemDetails(EquipHandle)
	if ( details == nil or details.type <= 100 or details.type >= 115) then
		temp.text_30	= "121, 300,%\050该物品无法放入面板中！,10"
		temp.previous_7 = { itemid = -1, }
		UpdateCustomWnd( temp )
		return
	end
	
	--如已是未绑定的装备则不能解除绑定
	if( details.flags ~= 1)then
  		temp.text_30	= "121, 300,%\050请拖入非系统绑定的装备类道具！,10"
		temp.previous_7 = { itemid = -1, }
		UpdateCustomWnd( temp )
		return
	end
	
	--如果是系统绑定，则无法解除  color的第二位被设置
	if(details.color >= 2) then
		temp.text_30	= "121, 300,%\050系统绑定的装备不能解除,10"
		temp.previous_7 = { itemid = -1, }
	  	UpdateCustomWnd( temp )----显示以上状态
		return
	end
	
	temp.previous_7 = { dragable = false,}
	
	--根据道具ID查找配置表，提示需要的材料与金钱
	local itemTable = nil   		--查找结果表
	local itemDetailsTable = {}    	--材料信息表
	local count = 0                 --材料数
	local needMoney = 0             --需要金钱
	for k,v in pairs(解除装备绑定配置表) do
		--rfalse(""..(details.level).." "..(v.equipLevel))
		if(details.levelEM < v.equipLevel )then
				itemTable = v
				break
		end
	end
	--找到了配置项
	if(itemTable ~= nil) then
    	itemDetailsTable = GetItemSetting(itemTable.stuffID)
    	count = itemTable.stuffNum
    	needMoney = itemTable.needMoney
    	temp.text_4 = "225,228,%\050"..(itemDetailsTable.name).."x"..count.." 金钱x"..needMoney..",12"
    	temp.previous_8 = { itemid = itemTable.stuffID,}
    	
		--检查材料
		if (0 == CheckGoods(itemTable.stuffID, count, 1)) then
			temp.image_12 = "125,207,interface/EquipConstruction/黑框.spr"
	        temp.text_30	= "121, 300,%\050材料不足，不能解除装备的绑定！,10"
			UpdateCustomWnd( temp )
			return
		end
		--检查金钱
  		if(itemTable.needMoney ~= 0) then
		 	local money = CheckGoods(0,itemTable.needMoney,1)
	   		if(money == 0)then
	         	temp.image_12 = "125,207,interface/EquipConstruction/黑框.spr"
		        temp.text_30	= "121, 300,%\050金钱不足，不能解除装备的绑定！,10"
				UpdateCustomWnd( temp )
	      		return
	      	end
		end
	else
		rfalse("解除装备配置表BUG") 
		return
	end
    
	temp.text_30 = "121, 300,%\050请点击确定解除装备的绑定！,10"
	local equipDetailsTable = GetItemSetting(details.index)
	--temp.previous_5 = { action = "@box,是否要将 %\050"..(equipDetailsTable.name).." 绑定?,@rc,1,@rv,7"  }
	temp.SprButton_5 = 
	{ 
		pos = "183,251",
		SprFileName_Normal = "interface/common/按键确定1.spr", 
		SprFileName_Down = "interface/common/按键确定3.spr", 
		SprFileName_Active = "interface/common/按键确定2.spr", 
		action = "@box,是否要解除装备 %\050"..(equipDetailsTable.name).." %0的绑定?,@rc,1,@rv,7" 
	} 
	UpdateCustomWnd( temp )
    
 	return
end

function wndItemUnlockCheckup2(tempEquipHandle )
	--时间信息
	local name = GetPlayerData(3)
	local year = GetCurTime(0)
	local month = GetCurTime(1)
	local date = GetCurTime(2)
	local hour = GetCurTime(4)
	local minute = GetCurTime(5)

	--以前的绑定时间 DayNum
	local DayNum = 1

	local temp = {}

	if (tempEquipHandle == nil) then
		temp.text_30	= "121, 300,%\050请放入需要解除绑定的装备！,10"
	  	UpdateCustomWnd( temp )----显示以上状态
		return
	end
	local equipDetails = GetItemDetails(tempEquipHandle)
	if (equipDetails == nil) then
		temp.text_30	= "121, 300,%\050请放入需要解除绑定的装备！,10"
	  	UpdateCustomWnd( temp )
		return
	end

  	--if(CheckGoods(6610,DayNum,1) ~= 1)then
	--   return rfalse( "121,250,%\124携带的绑定锁不足！,16" )
	--end

	--根据道具ID查找配置表，提示需要的材料与金钱
	local itemTable = nil   		--查找结果表
	local itemDetailsTable = {}    	--材料信息表
	local count = 0                 --材料数
	local needMoney = 0             --需要金钱
	for k,v in pairs(解除装备绑定配置表) do
		if(equipDetails.levelEM <= v.equipLevel )then
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
	        temp.text_30	= "121, 300,%\050材料不足，不能解除装备的绑定！,10"
			UpdateCustomWnd( temp )
			return
		end
		--检查金钱
  		if(itemTable.needMoney ~= 0) then
		 	local money = CheckGoods(0,itemTable.needMoney,1)
	   		if(money == 0)then
	         	temp.image_12 = "125,207,interface/EquipConstruction/黑框.spr"
		        temp.text_30	= "121, 300,%\050金钱不足，不能解除装备的绑定！,10"
				UpdateCustomWnd( temp )
	      		return
	      	end
		end
	else
		rfalse("解除装备配置表BUG")
		return
	end
	
	--开始解除绑定
	--CheckGoods(6610,DayNum)
	--UnbindEquip(EquipHandle,DayNum*24,1)

	--暂时的处理
	equipDetails.flags = 0
	UpdateItemDetails(tempEquipHandle, equipDetails)

	--DocumentNoteIN("记录文件\\装备绑定.txt",name.."在"..year.."年"..month.."月"..date.."日"..hour.."时"..minute.."分租赁"..equipdetails.index.."装备"..DayNum.."天","a")

	--删除物品
	CheckGoods(itemTable.stuffID, count, 0)
	--扣除金钱
    CheckGoods(0,needMoney,0)

	UpdateCustomWnd( wndItemUnlock )
	temp.text_30	= "121, 300,%\050解除绑定完成，装备已放入您的背包中。,10"
	TalkToPlayer(0,"恭喜你，解除绑定成功！")
  	UpdateCustomWnd( temp )----显示以上状态
end