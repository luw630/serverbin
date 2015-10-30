function GetBlessInfo()
	ProcessBlessInfo()--����
end
function LuaProcessNotice()
	OnProcessNotice()
end
LowTableItem ={}
HightTableItem ={}

Bless_UPLIMET = 12  	--����12��
Bless_Radix	  = 100   --����
HIGH_LEVEL    = 3		--�߼����ߵ���
LOW_level     = Bless_Radix - HIGH_LEVEL --�ͼ�����
HIGH_Radix	  = HIGH_LEVEL / Bless_Radix --�߼����ߵ��伸��
LOW_Radix     = LOW_level / Bless_Radix	 --�ͼ����ߵ��伸��


LowTableItem ={7000015,7000016,7010015,7010016,7020015,7020016,8011001,8003001,8003002,8003003,8003004,8003005,8020001,8020002,8020003} --�ͼ�����
HightTableItem ={4004020,4004120,4004220,4004320,4031001,4031002,4031003,4031004,4000001,4000002,4000003,4003001} --�߼�����

Bless_UPLIMET = 12  	--����12��
Bless_Radix	  = 100   	--����
HIGH_LEVEL    = 3		--�߼����ߵ���
LOW_level     = Bless_Radix - HIGH_LEVEL --�ͼ�����
HIGH_Radix	  = HIGH_LEVEL / Bless_Radix --�߼����ߵ��伸��
LOW_Radix     = LOW_level / Bless_Radix	 --�ͼ����ߵ��伸��
HIGH_DISNUM   = 4						 --�߼������������ʾ�ĸ��� 0 ~ 3
CMoney        = 100                      --�����۳���
function RandomHightOrLow(Radix)
	return math.random(1,Radix)
end

function OnProcessGetBless(FlagX,QuickFlag)
	local n = RandomHightOrLow(Bless_Radix)
	--rfalse("n "..n)
	local Flss = GetPlayerData(0,GPP_BLess)
	--rfalse("Flss "..Flss)
	local Index = 0
	local Result = 0
	local HIGHNum = RandomHightOrLow(HIGH_DISNUM) - 1
	--rfalse("HIGHNum "..HIGHNum)
	local lowDnum = 0
	local Flag = 0
	local HN = table.getn(HightTableItem)
	--rfalse("HN "..HN)
	local LN = table.getn(LowTableItem)
	--rfalse("LN "..LN)
	local Money = GetPlayerMoney(2)--1�����ң�2����
	--rfalse("Money "..Money)
	--rfalse("FlagX "..FlagX)
	if ( FlagX == 0 ) then --�õ�����Ѻ���ʹ�����
		if ( Flss ~= 0 ) then
			--�������ҷ�Э��
			--rfalse("�������ҷ�Э��")
			return 0
		end
	else
		if (Money < CMoney ) then
			--���ﷴ�������ٷ�������
			OnErrorStopBless(1)--Ǯ�����ж�
			--rfalse("Ǯ�����ж�")
			return 0
		end
	end


	if n <= HIGH_LEVEL then
		Index  = RandomHightOrLow(HN)
		Result = HightTableItem[Index]
		HIGHNum = HIGHNum + 1
		Flag = 1
	else
		Index = RandomHightOrLow(LN)
		Result = LowTableItem[Index]
	end
	if (Result == nil) then
		Result = LowTableItem[1]
	end
	--Result = 700001
	local result = IsHaveSpaceCell()
	--rfalse("result "..result)
	if (0 == result) then
		TalkToPlayer(2, "���߱����ռ䲻��,�޷����õ��ߣ�")
		OnErrorStopBless(2)--���������ж�
		return 0
	end
	if (Flag == 1) then
	  HIGHNum = HIGHNum - 1
	end
	lowDnum = Bless_UPLIMET - 1 - HIGHNum
	--rfalse("HIGHNum "..HIGHNum)
	--rfalse("lowDnum "..lowDnum)

	local i = 0
	while (i < lowDnum) do
	   local ItemID = RandomHightOrLow(LN)
	   ItemID = LowTableItem[ItemID]
	   --rfalse("DNUM: "..(i+1).." "..ItemID)
	   FillBlessData(ItemID)
	   i = i + 1
	end
	--rfalse("///////////////////////")
	i = 0
	while (i < HIGHNum) do
	   local ItemID = RandomHightOrLow(HN)
	   ItemID = HightTableItem[ItemID]
	   --rfalse("HNUM: "..(i+1).." "..ItemID)
	   FillBlessData(ItemID)
	   i = i + 1
	end
	--rfalse("Result: "..Result)
	--rfalse("Flag: "..Flag)

	OnBlessResult(Flag,Result,FlagX,QuickFlag)
	if (FlagX == 0) then --˵����������� ���ÿ�Ǯ
		if ( Flss == 0 ) then
			--�������ҷ�Э��
			OnPlayerBlessTime()
			return 0
		end
	else
		ChangeMoney(2,-CMoney) ----1�����ң�2����
	end
end

