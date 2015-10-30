function GetBlessInfo()
	ProcessBlessInfo()--处理
end
function LuaProcessNotice()
	OnProcessNotice()
end
LowTableItem ={}
HightTableItem ={}

Bless_UPLIMET = 12  	--上限12个
Bless_Radix	  = 100   --基数
HIGH_LEVEL    = 3		--高级道具掉落
LOW_level     = Bless_Radix - HIGH_LEVEL --低级道具
HIGH_Radix	  = HIGH_LEVEL / Bless_Radix --高级道具掉落几率
LOW_Radix     = LOW_level / Bless_Radix	 --低级道具掉落几率


LowTableItem ={7000015,7000016,7010015,7010016,7020015,7020016,8011001,8003001,8003002,8003003,8003004,8003005,8020001,8020002,8020003} --低级道具
HightTableItem ={4004020,4004120,4004220,4004320,4031001,4031002,4031003,4031004,4000001,4000002,4000003,4003001} --高级道具

Bless_UPLIMET = 12  	--上限12个
Bless_Radix	  = 100   	--基数
HIGH_LEVEL    = 3		--高级道具掉落
LOW_level     = Bless_Radix - HIGH_LEVEL --低级道具
HIGH_Radix	  = HIGH_LEVEL / Bless_Radix --高级道具掉落几率
LOW_Radix     = LOW_level / Bless_Radix	 --低级道具掉落几率
HIGH_DISNUM   = 4						 --高级道具最多能显示的个数 0 ~ 3
CMoney        = 100                      --银两扣除数
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
	local Money = GetPlayerMoney(2)--1是银币，2银两
	--rfalse("Money "..Money)
	--rfalse("FlagX "..FlagX)
	if ( FlagX == 0 ) then --用的是免费和能使用免费
		if ( Flss ~= 0 ) then
			--这里是乱发协议
			--rfalse("这里是乱发协议")
			return 0
		end
	else
		if (Money < CMoney ) then
			--这里反馈不能再发数据了
			OnErrorStopBless(1)--钱不够中断
			--rfalse("钱不够中断")
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
		TalkToPlayer(2, "道具背包空间不足,无法放置道具！")
		OnErrorStopBless(2)--背包满了中断
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
	if (FlagX == 0) then --说明是免费祈福的 不用扣钱
		if ( Flss == 0 ) then
			--这里是乱发协议
			OnPlayerBlessTime()
			return 0
		end
	else
		ChangeMoney(2,-CMoney) ----1是银币，2银两
	end
end

