--封测活动怪物掉落

function OnDropItem328(monstid)
	DropPublicFun(monstid)

	monsterdropitem(8005010,1) --掉落真气丹
	monsterdropitem(290005,1) --掉落侠客令
	monsterdropitem(8022005,1) --掉落礼券
	monsterdropitem(8021004,1) --掉落银两票

	local tempTongRenValue1 = math.random(1,172) --掉落经脉铜人
	local TongRenItemID1 = Common[tempTongRenValue1]
	monsterdropitem(TongRenItemID1,1)

	DropPublicFun(monstid)
	monsterdropitem(8005010,1) --掉落真气丹
	monsterdropitem(290005,1) --掉落侠客令
	monsterdropitem(8022005,1) --掉落礼券
	monsterdropitem(8021004,1) --掉落银两票

	local tempTongRenValue2 = math.random(1,172) --掉落经脉铜人
	local TongRenItemID2 = Common[tempTongRenValue2]
	monsterdropitem(TongRenItemID2,1)

	local tempZQ_Value = math.random(1,2) --掉落坐骑道具
	if tempZQ_Value == 1 then
		monsterdropitem(8002018,1)
	else
		monsterdropitem(8002019,1)
	end



	local tempWQ_Value11 = math.random(6,64)--掉落紫色装备
	local WQ_ItemID11 = LevelItemEquipment_Orange_20[tempWQ_Value11]
	monsterdropitem(WQ_ItemID11,1)
	local tempWQ_Value22 = math.random(6,64)--掉落紫色装备
	local WQ_ItemID22 = LevelItemEquipment_Orange_30[tempWQ_Value22]
	monsterdropitem(WQ_ItemID22,1)
	local tempWQ_Value33 = math.random(6,64)--掉落紫色装备
	local WQ_ItemID33 = LevelItemEquipment_Orange_40[tempWQ_Value33]
	monsterdropitem(WQ_ItemID33,1)

	local tempZB_Value11 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID11 = LevelItemEquipment_Orange_20[tempZB_Value11]
	monsterdropitem(ZB_ItemID11,1)
	local tempZB_Value22 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID22 = LevelItemEquipment_Orange_30[tempZB_Value22]
	monsterdropitem(ZB_ItemID22,1)
	local tempZB_Value33 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID33 = LevelItemEquipment_Orange_40[tempZB_Value33]
	monsterdropitem(ZB_ItemID33,1)
	local tempZB_Value44 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID44 = LevelItemEquipment_Orange_20[tempZB_Value44]
	monsterdropitem(ZB_ItemID44,1)
	local tempZB_Value55 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID55 = LevelItemEquipment_Orange_30[tempZB_Value55]
	monsterdropitem(ZB_ItemID55,1)
	local tempZB_Value6 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID66 = LevelItemEquipment_Orange_40[tempZB_Value66]
	monsterdropitem(ZB_ItemID66,1)
	local tempZB_Value77 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID77 = LevelItemEquipment_Orange_20[tempZB_Value77]
	monsterdropitem(ZB_ItemID77,1)
	local tempZB_Value88 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID88 = LevelItemEquipment_Orange_30[tempZB_Value88]
	monsterdropitem(ZB_ItemID88,1)
	local tempZB_Value99 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID99 = LevelItemEquipment_Orange_40[tempZB_Value99]
	monsterdropitem(ZB_ItemID99,1)
	local tempZB_Value100 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID100 = LevelItemEquipment_Orange_40[tempZB_Value100]
	monsterdropitem(ZB_ItemID100,1)

end

function OnDropItem329(monstid)
	DropPublicFun(monstid)
	monsterdropitem(8005010,1) --掉落真气丹
	monsterdropitem(290005,1) --掉落侠客令
	monsterdropitem(8022005,1) --掉落礼券
	monsterdropitem(8021004,1) --掉落银两票

	local tempTongRenValue1 = math.random(1,172) --掉落经脉铜人
	local TongRenItemID1 = Common[tempTongRenValue1]
	monsterdropitem(TongRenItemID1,1)

	DropPublicFun(monstid)
	monsterdropitem(8005010,1) --掉落真气丹
	monsterdropitem(290005,1) --掉落侠客令
	monsterdropitem(8022005,1) --掉落礼券
	monsterdropitem(8021004,1) --掉落银两票

	local tempTongRenValue2 = math.random(1,172) --掉落经脉铜人
	local TongRenItemID2 = Common[tempTongRenValue2]
	monsterdropitem(TongRenItemID2,1)

	local tempZQ_Value = math.random(1,2) --掉落坐骑道具
	if tempZQ_Value == 1 then
		monsterdropitem(8002018,1)
	else
		monsterdropitem(8002019,1)
	end

	local tempWQ_Value11 = math.random(6,64)--掉落紫色装备
	local WQ_ItemID11 = LevelItemEquipment_Orange_20[tempWQ_Value11]
	monsterdropitem(WQ_ItemID11,1)
	local tempWQ_Value22 = math.random(6,64)--掉落紫色装备
	local WQ_ItemID22 = LevelItemEquipment_Orange_30[tempWQ_Value22]
	monsterdropitem(WQ_ItemID22,1)
	local tempWQ_Value33 = math.random(6,64)--掉落紫色装备
	local WQ_ItemID33 = LevelItemEquipment_Orange_40[tempWQ_Value33]
	monsterdropitem(WQ_ItemID33,1)

	local tempZB_Value11 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID11 = LevelItemEquipment_Orange_20[tempZB_Value11]
	monsterdropitem(ZB_ItemID11,1)
	local tempZB_Value22 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID22 = LevelItemEquipment_Orange_30[tempZB_Value22]
	monsterdropitem(ZB_ItemID22,1)
	local tempZB_Value33 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID33 = LevelItemEquipment_Orange_40[tempZB_Value33]
	monsterdropitem(ZB_ItemID33,1)
	local tempZB_Value44 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID44 = LevelItemEquipment_Orange_20[tempZB_Value44]
	monsterdropitem(ZB_ItemID44,1)
	local tempZB_Value55 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID55 = LevelItemEquipment_Orange_30[tempZB_Value55]
	monsterdropitem(ZB_ItemID55,1)
	local tempZB_Value6 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID66 = LevelItemEquipment_Orange_40[tempZB_Value66]
	monsterdropitem(ZB_ItemID66,1)
	local tempZB_Value77 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID77 = LevelItemEquipment_Orange_20[tempZB_Value77]
	monsterdropitem(ZB_ItemID77,1)
	local tempZB_Value88 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID88 = LevelItemEquipment_Orange_30[tempZB_Value88]
	monsterdropitem(ZB_ItemID88,1)
	local tempZB_Value99 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID99 = LevelItemEquipment_Orange_40[tempZB_Value99]
	monsterdropitem(ZB_ItemID99,1)
	local tempZB_Value100 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID100 = LevelItemEquipment_Orange_40[tempZB_Value100]
	monsterdropitem(ZB_ItemID100,1)
end

function OnDropItem330(monstid)
	DropPublicFun(monstid)
	monsterdropitem(8005010,1) --掉落真气丹
	monsterdropitem(290005,1) --掉落侠客令
	monsterdropitem(8022005,1) --掉落礼券
	monsterdropitem(8021004,1) --掉落银两票

	local tempTongRenValue1 = math.random(1,172) --掉落经脉铜人
	local TongRenItemID1 = Common[tempTongRenValue1]
	monsterdropitem(TongRenItemID1,1)

	DropPublicFun(monstid)
	monsterdropitem(8005010,1) --掉落真气丹
	monsterdropitem(290005,1) --掉落侠客令
	monsterdropitem(8022005,1) --掉落礼券
	monsterdropitem(8021004,1) --掉落银两票

	local tempTongRenValue2 = math.random(1,172) --掉落经脉铜人
	local TongRenItemID2 = Common[tempTongRenValue2]
	monsterdropitem(TongRenItemID2,1)

	local tempZQ_Value = math.random(1,2) --掉落坐骑道具
	if tempZQ_Value == 1 then
		monsterdropitem(8002018,1)
	else
		monsterdropitem(8002019,1)
	end

	local tempWQ_Value11 = math.random(6,64)--掉落紫色装备
	local WQ_ItemID11 = LevelItemEquipment_Orange_20[tempWQ_Value11]
	monsterdropitem(WQ_ItemID11,1)
	local tempWQ_Value22 = math.random(6,64)--掉落紫色装备
	local WQ_ItemID22 = LevelItemEquipment_Orange_30[tempWQ_Value22]
	monsterdropitem(WQ_ItemID22,1)
	local tempWQ_Value33 = math.random(6,64)--掉落紫色装备
	local WQ_ItemID33 = LevelItemEquipment_Orange_40[tempWQ_Value33]
	monsterdropitem(WQ_ItemID33,1)

	local tempZB_Value11 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID11 = LevelItemEquipment_Orange_20[tempZB_Value11]
	monsterdropitem(ZB_ItemID11,1)
	local tempZB_Value22 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID22 = LevelItemEquipment_Orange_30[tempZB_Value22]
	monsterdropitem(ZB_ItemID22,1)
	local tempZB_Value33 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID33 = LevelItemEquipment_Orange_40[tempZB_Value33]
	monsterdropitem(ZB_ItemID33,1)
	local tempZB_Value44 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID44 = LevelItemEquipment_Orange_20[tempZB_Value44]
	monsterdropitem(ZB_ItemID44,1)
	local tempZB_Value55 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID55 = LevelItemEquipment_Orange_30[tempZB_Value55]
	monsterdropitem(ZB_ItemID55,1)
	local tempZB_Value6 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID66 = LevelItemEquipment_Orange_40[tempZB_Value66]
	monsterdropitem(ZB_ItemID66,1)
	local tempZB_Value77 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID77 = LevelItemEquipment_Orange_20[tempZB_Value77]
	monsterdropitem(ZB_ItemID77,1)
	local tempZB_Value88 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID88 = LevelItemEquipment_Orange_30[tempZB_Value88]
	monsterdropitem(ZB_ItemID88,1)
	local tempZB_Value99 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID99 = LevelItemEquipment_Orange_40[tempZB_Value99]
	monsterdropitem(ZB_ItemID99,1)
	local tempZB_Value100 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID100 = LevelItemEquipment_Orange_40[tempZB_Value100]
	monsterdropitem(ZB_ItemID100,1)
end

function OnDropItem331(monstid)
	DropPublicFun(monstid)

	monsterdropitem(8005010,1) --掉落真气丹
	monsterdropitem(290005,1) --掉落侠客令
	monsterdropitem(8022005,1) --掉落礼券
	monsterdropitem(8021004,1) --掉落银两票

	local tempTongRenValue1 = math.random(1,172) --掉落经脉铜人
	local TongRenItemID1 = Common[tempTongRenValue1]
	monsterdropitem(TongRenItemID1,1)

	DropPublicFun(monstid)
	monsterdropitem(8005010,1) --掉落真气丹
	monsterdropitem(290005,1) --掉落侠客令
	monsterdropitem(8022005,1) --掉落礼券
	monsterdropitem(8021004,1) --掉落银两票

	local tempTongRenValue2 = math.random(1,172) --掉落经脉铜人
	local TongRenItemID2 = Common[tempTongRenValue2]
	monsterdropitem(TongRenItemID2,1)

	local tempZQ_Value = math.random(1,2) --掉落坐骑道具
	if tempZQ_Value == 1 then
		monsterdropitem(8002018,1)
	else
		monsterdropitem(8002019,1)
	end

	local tempWQ_Value11 = math.random(6,64)--掉落紫色装备
	local WQ_ItemID11 = LevelItemEquipment_Orange_20[tempWQ_Value11]
	monsterdropitem(WQ_ItemID11,1)
	local tempWQ_Value22 = math.random(6,64)--掉落紫色装备
	local WQ_ItemID22 = LevelItemEquipment_Orange_30[tempWQ_Value22]
	monsterdropitem(WQ_ItemID22,1)
	local tempWQ_Value33 = math.random(6,64)--掉落紫色装备
	local WQ_ItemID33 = LevelItemEquipment_Orange_40[tempWQ_Value33]
	monsterdropitem(WQ_ItemID33,1)

	local tempZB_Value11 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID11 = LevelItemEquipment_Orange_20[tempZB_Value11]
	monsterdropitem(ZB_ItemID11,1)
	local tempZB_Value22 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID22 = LevelItemEquipment_Orange_30[tempZB_Value22]
	monsterdropitem(ZB_ItemID22,1)
	local tempZB_Value33 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID33 = LevelItemEquipment_Orange_40[tempZB_Value33]
	monsterdropitem(ZB_ItemID33,1)
	local tempZB_Value44 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID44 = LevelItemEquipment_Orange_20[tempZB_Value44]
	monsterdropitem(ZB_ItemID44,1)
	local tempZB_Value55 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID55 = LevelItemEquipment_Orange_30[tempZB_Value55]
	monsterdropitem(ZB_ItemID55,1)
	local tempZB_Value6 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID66 = LevelItemEquipment_Orange_40[tempZB_Value66]
	monsterdropitem(ZB_ItemID66,1)
	local tempZB_Value77 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID77 = LevelItemEquipment_Orange_20[tempZB_Value77]
	monsterdropitem(ZB_ItemID77,1)
	local tempZB_Value88 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID88 = LevelItemEquipment_Orange_30[tempZB_Value88]
	monsterdropitem(ZB_ItemID88,1)
	local tempZB_Value99 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID99 = LevelItemEquipment_Orange_40[tempZB_Value99]
	monsterdropitem(ZB_ItemID99,1)
	local tempZB_Value100 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID100 = LevelItemEquipment_Orange_40[tempZB_Value100]
	monsterdropitem(ZB_ItemID100,1)

end

function OnDropItem333(monstid)
	DropPublicFun(monstid)
	monsterdropitem(8005010,1) --掉落真气丹
	monsterdropitem(290005,1) --掉落侠客令
	monsterdropitem(8022005,1) --掉落礼券
	monsterdropitem(8021004,1) --掉落银两票

	local tempTongRenValue1 = math.random(1,172) --掉落经脉铜人
	local TongRenItemID1 = Common[tempTongRenValue1]
	monsterdropitem(TongRenItemID1,1)

	DropPublicFun(monstid)
	monsterdropitem(8005010,1) --掉落真气丹
	monsterdropitem(290005,1) --掉落侠客令
	monsterdropitem(8022005,1) --掉落礼券
	monsterdropitem(8021004,1) --掉落银两票

	local tempTongRenValue2 = math.random(1,172) --掉落经脉铜人
	local TongRenItemID2 = Common[tempTongRenValue2]
	monsterdropitem(TongRenItemID2,1)

	local tempZQ_Value = math.random(1,2) --掉落坐骑道具
	if tempZQ_Value == 1 then
		monsterdropitem(8002018,1)
	else
		monsterdropitem(8002019,1)
	end

		local tempWQ_Value111 = math.random(6,64)--掉落紫色装备
	local WQ_ItemID111 = LevelItemEquipment_Orange_20[tempWQ_Value111]
	monsterdropitem(WQ_ItemID111,1)
	local tempWQ_Value222 = math.random(6,64)--掉落紫色装备
	local WQ_ItemID222 = LevelItemEquipment_Orange_30[tempWQ_Value222]
	monsterdropitem(WQ_ItemID222,1)
	local tempWQ_Value333 = math.random(6,64)--掉落紫色装备
	local WQ_ItemID333 = LevelItemEquipment_Orange_40[tempWQ_Value333]
	monsterdropitem(WQ_ItemID333,1)

	local tempZB_Value111 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID111 = LevelItemEquipment_Orange_20[tempZB_Value111]
	monsterdropitem(ZB_ItemID111,1)
	local tempZB_Value222 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID222 = LevelItemEquipment_Orange_30[tempZB_Value222]
	monsterdropitem(ZB_ItemID222,1)
	local tempZB_Value333 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID333 = LevelItemEquipment_Orange_40[tempZB_Value333]
	monsterdropitem(ZB_ItemID333,1)
	local tempZB_Value444 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID444 = LevelItemEquipment_Orange_20[tempZB_Value444]
	monsterdropitem(ZB_ItemID444,1)
	local tempZB_Value555 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID555 = LevelItemEquipment_Orange_30[tempZB_Value555]
	monsterdropitem(ZB_ItemID555,1)
	local tempZB_Value666 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID666 = LevelItemEquipment_Orange_40[tempZB_Value666]
	monsterdropitem(ZB_ItemID666,1)
	local tempZB_Value777 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID777 = LevelItemEquipment_Orange_20[tempZB_Value777]
	monsterdropitem(ZB_ItemID777,1)
	local tempZB_Value888 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID888 = LevelItemEquipment_Orange_30[tempZB_Value888]
	monsterdropitem(ZB_ItemID888,1)
	local tempZB_Value999 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID999 = LevelItemEquipment_Orange_40[tempZB_Value999]
	monsterdropitem(ZB_ItemID999,1)
	local tempZB_Value1000 = math.random(6,64)--掉落紫色装备
	local ZB_ItemID1000 = LevelItemEquipment_Orange_40[tempZB_Value1000]
	monsterdropitem(ZB_ItemID1000,1)
end

function OnDropItem83(monstid)
	local temp = math.random(1,1000)
	if temp >= 900 and temp <= 1000 then
		local temp2 = math.random(200,209)
		monsterdropitem(Common[temp2],1) --掉落体质突破道具
	end
	local temp3 = math.random(190,199)
	monsterdropitem(Common[temp3],1) --掉落体质成长道具
	local temp4 = math.random(174,189)
	monsterdropitem(Common[temp4],1) --掉落强化道具
	monsterdropitem(8024001,1) --掉落经验丹
end

function OnDropItem3(monstid)
	monsterdropitem(9000001,1)
	monsterdropitem(9000002,1)
	monsterdropitem(9000003,1)
end

function OnDropItem89(monstid)
	local temp = math.random(1,1000)
	if temp >= 900 and temp <= 1000 then
		local temp2 = math.random(200,209)
		monsterdropitem(Common[temp2],1) --掉落体质突破道具
	end
	local temp3 = math.random(190,199)
	monsterdropitem(Common[temp3],1) --掉落体质成长道具
	local temp4 = math.random(174,189)
	monsterdropitem(Common[temp4],1) --掉落强化道具
	monsterdropitem(8024001,1) --掉落经验丹
end
