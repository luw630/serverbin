VIPList = {
--���ID��Ӧ�������GiftIfo������
--����Ѫ�� ���ӹ��� ���ӷ��� ������ID �����ȡ���� �������ID ���ѿɹ������ ��������Ľ������ �����������������
{30, 5, 5, 1, 1, 11, 1, 10, 0},		--VIP�ȼ�1

{90, 15, 15, 2, 1, 12, 1, 10, 0},		--VIP�ȼ�2

{180, 30, 30, 3, 1, 13, 1, 10, 0},		--VIP�ȼ�3

{300, 50, 50, 4, 1, 14, 1, 10, 0},		--VIP�ȼ�4

{449, 75, 75, 5, 1, 15, 1, 10, 0},		--VIP�ȼ�5

{628, 105, 105, 6, 1, 16, 1, 10, 0},		--VIP�ȼ�6

{837, 140, 140, 7, 1, 17, 1, 10, 0},		--VIP�ȼ�7

{1076, 180, 180, 8, 1, 18, 1, 10, 0},		--VIP�ȼ�8

{1345, 225, 225, 9, 1, 19, 1, 10, 0},		--VIP�ȼ�9

{1644, 275, 275, 10, 1, 20, 1, 10, 0},		--VIP�ȼ�10
}


--������� ���20�����
GiftIfo =
{
	--����ID  ��������
	[1] = {910012, 2, 910022, 2, 910032, 2,9100201, 2},
	[2] = {910012, 4, 910022, 4, 910032, 4,9100201, 4},
	[3] = {910012, 6, 910022, 6, 910032, 6,9100201, 6},
	[4] = {910013, 2, 910023, 4, 910033, 4,9100201, 8},
	[5] = {910013, 4, 910023, 4, 910033, 4,9100202, 2},
	[6] = {910013, 6, 910023, 6, 910033, 6,9100202, 4},
	[7] = {910013, 8, 910023, 8, 910033, 8,9100202, 6},
	[8] = {910013, 10, 910023, 10, 910033, 10,9100202, 8},
	[9] = {910013, 20, 910023, 20, 910033, 20,9100202, 15},
	[10] ={910013, 40, 910023, 40, 910033, 40,9100202, 20},
	[11] ={910012, 2, 910022, 2, 910032, 2,9100201, 2},
	[12] ={910012, 2, 910022, 2, 910032, 2,9100201, 2},
	[13] ={910012, 2, 910022, 2, 910032, 2,9100201, 2},
	[14] ={910012, 2, 910022, 2, 910032, 2,9100201, 2},
	[15] ={910012, 2, 910022, 2, 910032, 2,9100201, 2},
	[16] ={910012, 2, 910022, 2, 910032, 2,9100201, 2},
	[17] ={910012, 2, 910022, 2, 910032, 2,9100201, 2},
	[18] ={910012, 2, 910022, 2, 910032, 2,9100201, 2},
	[19] ={910012, 2, 910022, 2, 910032, 2,9100201, 2},
	[20] ={910012, 2, 910022, 2, 910032, 2,9100201, 2},
}

PlayerVipData = tostring("PlayerVipInfo")	--���������ص�VIP�����Ϣ

--��ʼ�����VIP����	��ҵ�һ��ע������
function InitPlayerVipData(PlayerVipInfo, playergid)
	if PlayerVipInfo == nil then
		PlayerVipInfo = {}
	end
	for i = 1, 10 do
		--iΪVIP�ȼ�
		PlayerVipInfo[i] = {}
		--��������Ϊ����ҿ���ȡ������������  ��Ҹ��ѿɹ�������Ĵ���
		PlayerVipInfo[i][1] = VIPList[i][5]
		PlayerVipInfo[i][2] = VIPList[i][7]
	end
	WeekReturnChargeData(PlayerVipData,PlayerVipInfo, playergid)
end

--��ʼ����ҵ�ǰVIP��������
function InitVipData()
	--��ȡVip�ȼ�
	local VipLevel = GetPlayerData(0, 101)
	if VipLevel == 0 or VIPList[VipLevel] == nil then
		SetCurVipFactor(0, 0, 0)
		return
	end
	SetCurVipFactor(VIPList[VipLevel][1], VIPList[VipLevel][2], VIPList[VipLevel][3])
end

--��ʼ��VIP��ȡ�͹���״̬��Ϣ�������͸����
function InitVipAndSendState(playergid)
	local PlayerVipInfo = LoadPlayerTable(PlayerVipData, playergid)		--����VIP�����Ϣ
	if PlayerVipInfo == nil then
		InitPlayerVipData(PlayerVipInfo, playergid)
		PlayerVipInfo = LoadPlayerTable(PlayerVipData, playergid)
	end
	local FreeState = 0
	local PayState = 0
	local FreeAndPayStateTable = {}
	for n, v in pairs(PlayerVipInfo) do
		if v[1] ~= 0 then
			FreeState = 1
		else
			FreeState = 0
		end
		if v[2] ~= 0 then
			PayState = 2
		else
			PayState = 0
		end
		FreeAndPayStateTable[n] = FreeState + PayState
	end

	--����VIP��ȡ�͹���״̬��Ϣ
	SendVipStateInf(FreeAndPayStateTable)
end

--��ȡ�����Ϣ
function GetGiftInfOpt(VipLevel, GetType)
	if VIPList[VipLevel] == nil then	--��ȡʧ��
		--����ʧ��
        local str = MystringFormat("OPTFAIL")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
		return
	end
	local GiftID = 0
	if GetType == 0 then 	--��ȡ��������Ϣ
		GiftID = VIPList[VipLevel][4]
	else	--��ȡ���������Ϣ
		GiftID = VIPList[VipLevel][6]
	end

	--�����������
	SendGiftInfo(GiftIfo[GiftID])
end

--��ȡ�������
function GetOrBuyGiftOpt(VipLevel, GetType)
	local PlayerVipInfo = LoadPlayerTable(PlayerVipData, 0)		--����VIP�����Ϣ
	if PlayerVipInfo == nil then
		--����ʧ��
        local str = MystringFormat("OPTFAIL")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
		return
	end

	if VIPList[VipLevel] == nil then	--��ȡʧ��
        local str = MystringFormat("OPTFAIL")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
		return
	end

	--��ȡVip�ȼ�
	local TempVipLevel = GetPlayerData(0, 101)
	if VipLevel > TempVipLevel then
        local str = MystringFormat("VIPLEVELNOTENOUGH")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
		return
	end

	local GiftID = 0
	if GetType == 0 then 	--��ȡ��������Ϣ
		GiftID = VIPList[VipLevel][4]
		if GiftIfo[GiftID] == nil then --û�и��������
        	local str = MystringFormat("NOTGIFTINFO")
        	if str ~= nil then
            	TalkToPlayer(2,str)
        	end
			return
		end
		if PlayerVipInfo[VipLevel][1] <= 0 then
        local str = MystringFormat("OPTFAIL")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
			return
		end
		--��ȡ����
		local res = AddSomeGoods(GiftIfo[GiftID])
		if res == 0 then
        	local str = MystringFormat("BAGISFULL")
        	if str ~= nil then
            	TalkToPlayer(2,str)
        	end
			return
		end
	else	--��ȡ���������Ϣ
		GiftID = VIPList[VipLevel][4]
		if GiftIfo[GiftID] == nil then --û�и��������
        	local str = MystringFormat("NOTGIFTINFO")
        	if str ~= nil then
            	TalkToPlayer(2,str)
        	end
			return
		end
		if PlayerVipInfo[VipLevel][2] <= 0 then
        	local str = MystringFormat("OPTFAIL")
        	if str ~= nil then
            	TalkToPlayer(2,str)
        	end
			return
		end
		local bMoneyEnough = CheckPlayerMoney(1, VIPList[VipLevel][8], 1)
		local bMoneyEnough1 = CheckPlayerMoney(2, VIPList[VipLevel][9], 1)
		if bMoneyEnough == 0 or bMoneyEnough == nil  then	--�˶Խ���Ƿ��㹻
			--��ʾ��Ҳ���
        	local str = MystringFormat("NOGOLD")
        	if str ~= nil then
            	TalkToPlayer(2,str)
        	end
			SendGetOrButGiftRes(2)	--��Ҳ���
			return
		end
		if bMoneyEnough1 == 0 or bMoneyEnough1 == nil  then	--�˶������Ƿ��㹻
			--��ʾ���Ҳ���
        	local str = MystringFormat("NOCOIN")
        	if str ~= nil then
            	TalkToPlayer(2,str)
        	end
			return
		end	
		--��ȡ����
		local res = AddSomeGoods(GiftIfo[GiftID])
		if res == 0 then
        	local str = MystringFormat("BAGISFULL")
        	if str ~= nil then
            	TalkToPlayer(2,str)
        	end
			return
		end

		ChangeMoney(1, -VIPList[VipLevel][8])
		ChangeMoney(2, -VIPList[VipLevel][9])
	end

	--������ȡ����ɹ�
	if GetType == 0 then
		PlayerVipInfo[VipLevel][1] = PlayerVipInfo[VipLevel][1] - 1
	else
		PlayerVipInfo[VipLevel][2] = PlayerVipInfo[VipLevel][2] - 1
	end
	WeekReturnChargeData(PlayerVipData,PlayerVipInfo, 0)
	SendGetOrButGiftRes(1)
end

