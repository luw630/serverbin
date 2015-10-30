YuanBaoGiftTable = {
	IsExtraCell = 0;	--�Ƿ��ж���ĵھŸ�����,����У���Ϊ�������ID�ţ�Ϊ0��ʾû�еھŸ�����
	--ItemTypeCount = 7;	--�ж��������
	GiftPrice = 1;

	--[[--�������
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
function GetYuanBaoGiftInfo(YuanBaoGiftIndex)	--��ȡԪ���������Ϣ
	return YuanBaoGiftTable[YuanBaoGiftIndex].CurIDItemCount, YuanBaoGiftTable[YuanBaoGiftIndex].ItemID
end


function BuyYuanBaoGift(CurYuanBaoItemPos, IsBuyed)
	if IsBuyed == 0 then		--��ʾ�������
		local bMoneyEnough = CheckPlayerMoney(1, YuanBaoGiftTable.GiftPrice, 1)
		if bMoneyEnough == 0 or bMoneyEnough == nil  then	--�˶Խ���Ƿ��㹻
			return 0
		else	--���Թ���
			ChangeMoney(1, -YuanBaoGiftTable.GiftPrice);  --����(0 - YuanBaoGiftTable.GiftPrice)
			--�жϱ����Ƿ�����
			Res = AddGiftJudgePackage(CurYuanBaoItemPos, YuanBaoGiftTable.IsExtraCell, table.getn(YuanBaoGiftTable))  --�жϱ����Ƿ��㹻������������������еĵ��ߵ�������
			if Res == 0 then
				return 1
			end
			return 2
		end
	else	--��ʾ��ȡ����
			--�жϱ����Ƿ�����
			Res = AddGiftJudgePackage(CurYuanBaoItemPos, YuanBaoGiftTable.IsExtraCell, table.getn(YuanBaoGiftTable))		--�жϱ����Ƿ��㹻������������������еĵ��ߵ�������
			if Res == 0 then
				return 1
			end
			return 2
	end
end

--[[
CurPlayerOfGiftTable = {};	--��ҵ�Ԫ������������

function GetYuanBaoGiftBaseInf11(PlayerName, ClickYuanBaoItemPos)
	if not CurPlayerOfGiftTable[PlayerName] then	--��һ�û�й���Ԫ�����
	CurPlayerOfGiftTable[PlayerName] = {}
	CurPlayerOfGiftTable[PlayerName].IsBuyed = 0;
	end
	CurPlayerOfGiftTable[PlayerName].CurYuanBaoItemPos = ClickYuanBaoItemPos;  --��ǰ�����CellPos
	return YuanBaoGiftTable.IsExtraCell, CurPlayerOfGiftTable[PlayerName].IsBuyed, table.getn(YuanBaoGiftTable)
end

function GetYuanBaoGiftInfo(YuanBaoGiftIndex)	--��ȡԪ���������Ϣ
	return YuanBaoGiftTable[YuanBaoGiftIndex].CurIDItemCount, YuanBaoGiftTable[YuanBaoGiftIndex].ItemID
end


function BuyYuanBaoGift11(PlayerName)
	if CurPlayerOfGiftTable[PlayerName].IsBuyed == 0 then		--��ʾ�������
		if not CheckPlayerMoney(2, YuanBaoGiftTable.GiftPrice, 1) then	--�˶Խ���Ƿ��㹻
			return 0
		else	--���Թ���
			ChangeMoney(2, -YuanBaoGiftTable.GiftPrice);  --����(0 - YuanBaoGiftTable.GiftPrice)
			CurPlayerOfGiftTable[PlayerName].IsBuyed = 1
			--�жϱ����Ƿ�����
			Res = AddGiftJudgePackage(CurPlayerOfGiftTable[PlayerName].CurYuanBaoItemPos, YuanBaoGiftTable.IsExtraCell, table.getn(YuanBaoGiftTable))  --�жϱ����Ƿ��㹻������������������еĵ��ߵ�������
			if Res == 0 then
				return 1
			end
			CurPlayerOfGiftTable[PlayerName] = nil
			return 2
		end
	else	--��ʾ��ȡ����
			--�жϱ����Ƿ�����
			Res = AddGiftJudgePackage(CurPlayerOfGiftTable[PlayerName].CurYuanBaoItemPos, YuanBaoGiftTable.IsExtraCell, table.getn(YuanBaoGiftTable))		--�жϱ����Ƿ��㹻������������������еĵ��ߵ�������
			if Res == 0 then
				return 1
			end
			CurPlayerOfGiftTable[PlayerName] = nil
			return 2
	end
end
--]]
