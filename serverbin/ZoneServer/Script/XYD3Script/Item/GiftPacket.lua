YuanBaoGiftTable = {
	IsExtraCell = 0;	--是否有额外的第九个格子,如果有，则为新礼包的ID号，为0表示没有第九个格子
	--ItemTypeCount = 7;	--有多少类道具
	GiftPrice = 1;

	--[[--礼包数据
	{ CurIDItemCount = 1, ItemID = 9000002 },
	{ CurIDItemCount = 2, ItemID = 3450001 },
	{ CurIDItemCount = 3, ItemID = 1111002 },--]]
	{ CurIDItemCount = 1, ItemID = 999998 },
	{ CurIDItemCount = 1, ItemID = 999997 },
	{ CurIDItemCount = 1, ItemID = 190613 },
	{ CurIDItemCount = 1, ItemID = 190600 }
};

function GetYuanBaoGiftBaseInf()
	return YuanBaoGiftTable.IsExtraCell, table.getn(YuanBaoGiftTable)
end
function GetYuanBaoGiftInfo(YuanBaoGiftIndex)	--获取元宝礼包的信息
	return YuanBaoGiftTable[YuanBaoGiftIndex].CurIDItemCount, YuanBaoGiftTable[YuanBaoGiftIndex].ItemID
end


function BuyYuanBaoGift(CurYuanBaoItemPos, IsBuyed)
	if IsBuyed == 0 then		--表示购买操作
		local bMoneyEnough = CheckPlayerMoney(1, YuanBaoGiftTable.GiftPrice, 1)
		if bMoneyEnough == 0 or bMoneyEnough == nil  then	--核对金币是否足够
			return 0
		else	--可以购买
			ChangeMoney(1, -YuanBaoGiftTable.GiftPrice);  --购买(0 - YuanBaoGiftTable.GiftPrice)
			--判断背包是否已满
			Res = AddGiftJudgePackage(CurYuanBaoItemPos, YuanBaoGiftTable.IsExtraCell, table.getn(YuanBaoGiftTable))  --判断背包是否足够。如果够，则添加礼包中的道具到背包中
			if Res == 0 then
				return 1
			end
			return 2
		end
	else	--表示领取操作
			--判断背包是否已满
			Res = AddGiftJudgePackage(CurYuanBaoItemPos, YuanBaoGiftTable.IsExtraCell, table.getn(YuanBaoGiftTable))		--判断背包是否足够。如果够，则添加礼包中的道具到背包中
			if Res == 0 then
				return 1
			end
			return 2
	end
end

--[[
CurPlayerOfGiftTable = {};	--玩家的元宝礼包购买情况

function GetYuanBaoGiftBaseInf11(PlayerName, ClickYuanBaoItemPos)
	if not CurPlayerOfGiftTable[PlayerName] then	--玩家还没有购买元宝礼包
	CurPlayerOfGiftTable[PlayerName] = {}
	CurPlayerOfGiftTable[PlayerName].IsBuyed = 0;
	end
	CurPlayerOfGiftTable[PlayerName].CurYuanBaoItemPos = ClickYuanBaoItemPos;  --当前礼包的CellPos
	return YuanBaoGiftTable.IsExtraCell, CurPlayerOfGiftTable[PlayerName].IsBuyed, table.getn(YuanBaoGiftTable)
end

function GetYuanBaoGiftInfo(YuanBaoGiftIndex)	--获取元宝礼包的信息
	return YuanBaoGiftTable[YuanBaoGiftIndex].CurIDItemCount, YuanBaoGiftTable[YuanBaoGiftIndex].ItemID
end


function BuyYuanBaoGift11(PlayerName)
	if CurPlayerOfGiftTable[PlayerName].IsBuyed == 0 then		--表示购买操作
		if not CheckPlayerMoney(2, YuanBaoGiftTable.GiftPrice, 1) then	--核对金币是否足够
			return 0
		else	--可以购买
			ChangeMoney(2, -YuanBaoGiftTable.GiftPrice);  --购买(0 - YuanBaoGiftTable.GiftPrice)
			CurPlayerOfGiftTable[PlayerName].IsBuyed = 1
			--判断背包是否已满
			Res = AddGiftJudgePackage(CurPlayerOfGiftTable[PlayerName].CurYuanBaoItemPos, YuanBaoGiftTable.IsExtraCell, table.getn(YuanBaoGiftTable))  --判断背包是否足够。如果够，则添加礼包中的道具到背包中
			if Res == 0 then
				return 1
			end
			CurPlayerOfGiftTable[PlayerName] = nil
			return 2
		end
	else	--表示领取操作
			--判断背包是否已满
			Res = AddGiftJudgePackage(CurPlayerOfGiftTable[PlayerName].CurYuanBaoItemPos, YuanBaoGiftTable.IsExtraCell, table.getn(YuanBaoGiftTable))		--判断背包是否足够。如果够，则添加礼包中的道具到背包中
			if Res == 0 then
				return 1
			end
			CurPlayerOfGiftTable[PlayerName] = nil
			return 2
	end
end
--]]
