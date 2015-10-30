VIPList = {
--礼包ID对应礼包数据GiftIfo的索引
--增加血量 增加攻击 增加防御 免费礼包ID 免费领取次数 付费礼包ID 付费可购买次数 付费礼包的金币消耗 付费礼包的银币消耗
{30, 5, 5, 1, 1, 11, 1, 10, 0},		--VIP等级1

{90, 15, 15, 2, 1, 12, 1, 10, 0},		--VIP等级2

{180, 30, 30, 3, 1, 13, 1, 10, 0},		--VIP等级3

{300, 50, 50, 4, 1, 14, 1, 10, 0},		--VIP等级4

{449, 75, 75, 5, 1, 15, 1, 10, 0},		--VIP等级5

{628, 105, 105, 6, 1, 16, 1, 10, 0},		--VIP等级6

{837, 140, 140, 7, 1, 17, 1, 10, 0},		--VIP等级7

{1076, 180, 180, 8, 1, 18, 1, 10, 0},		--VIP等级8

{1345, 225, 225, 9, 1, 19, 1, 10, 0},		--VIP等级9

{1644, 275, 275, 10, 1, 20, 1, 10, 0},		--VIP等级10
}


--礼包数据 最多20个礼包
GiftIfo =
{
	--道具ID  道具数量
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

PlayerVipData = tostring("PlayerVipInfo")	--保存玩家相关的VIP相关信息

--初始化玩家VIP数据	玩家第一次注册后调用
function InitPlayerVipData(PlayerVipInfo, playergid)
	if PlayerVipInfo == nil then
		PlayerVipInfo = {}
	end
	for i = 1, 10 do
		--i为VIP等级
		PlayerVipInfo[i] = {}
		--参数依次为：玩家可领取的免费礼包次数  玩家付费可购买礼包的次数
		PlayerVipInfo[i][1] = VIPList[i][5]
		PlayerVipInfo[i][2] = VIPList[i][7]
	end
	WeekReturnChargeData(PlayerVipData,PlayerVipInfo, playergid)
end

--初始化玩家当前VIP附加属性
function InitVipData()
	--获取Vip等级
	local VipLevel = GetPlayerData(0, 101)
	if VipLevel == 0 or VIPList[VipLevel] == nil then
		SetCurVipFactor(0, 0, 0)
		return
	end
	SetCurVipFactor(VIPList[VipLevel][1], VIPList[VipLevel][2], VIPList[VipLevel][3])
end

--初始化VIP领取和购买状态信息，并发送给玩家
function InitVipAndSendState(playergid)
	local PlayerVipInfo = LoadPlayerTable(PlayerVipData, playergid)		--加载VIP相关信息
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

	--发送VIP领取和购买状态信息
	SendVipStateInf(FreeAndPayStateTable)
end

--获取礼包信息
function GetGiftInfOpt(VipLevel, GetType)
	if VIPList[VipLevel] == nil then	--获取失败
		--发送失败
        local str = MystringFormat("OPTFAIL")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
		return
	end
	local GiftID = 0
	if GetType == 0 then 	--获取免费礼包信息
		GiftID = VIPList[VipLevel][4]
	else	--获取付费礼包信息
		GiftID = VIPList[VipLevel][6]
	end

	--发送相关数据
	SendGiftInfo(GiftIfo[GiftID])
end

--领取或购买礼包
function GetOrBuyGiftOpt(VipLevel, GetType)
	local PlayerVipInfo = LoadPlayerTable(PlayerVipData, 0)		--加载VIP相关信息
	if PlayerVipInfo == nil then
		--操作失败
        local str = MystringFormat("OPTFAIL")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
		return
	end

	if VIPList[VipLevel] == nil then	--获取失败
        local str = MystringFormat("OPTFAIL")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
		return
	end

	--获取Vip等级
	local TempVipLevel = GetPlayerData(0, 101)
	if VipLevel > TempVipLevel then
        local str = MystringFormat("VIPLEVELNOTENOUGH")
        if str ~= nil then
            TalkToPlayer(2,str)
        end
		return
	end

	local GiftID = 0
	if GetType == 0 then 	--获取免费礼包信息
		GiftID = VIPList[VipLevel][4]
		if GiftIfo[GiftID] == nil then --没有该礼包数据
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
		--领取或购买
		local res = AddSomeGoods(GiftIfo[GiftID])
		if res == 0 then
        	local str = MystringFormat("BAGISFULL")
        	if str ~= nil then
            	TalkToPlayer(2,str)
        	end
			return
		end
	else	--获取付费礼包信息
		GiftID = VIPList[VipLevel][4]
		if GiftIfo[GiftID] == nil then --没有该礼包数据
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
		if bMoneyEnough == 0 or bMoneyEnough == nil  then	--核对金币是否足够
			--提示金币不足
        	local str = MystringFormat("NOGOLD")
        	if str ~= nil then
            	TalkToPlayer(2,str)
        	end
			SendGetOrButGiftRes(2)	--金币不足
			return
		end
		if bMoneyEnough1 == 0 or bMoneyEnough1 == nil  then	--核对银币是否足够
			--提示银币不足
        	local str = MystringFormat("NOCOIN")
        	if str ~= nil then
            	TalkToPlayer(2,str)
        	end
			return
		end	
		--领取或购买
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

	--发送领取或购买成功
	if GetType == 0 then
		PlayerVipInfo[VipLevel][1] = PlayerVipInfo[VipLevel][1] - 1
	else
		PlayerVipInfo[VipLevel][2] = PlayerVipInfo[VipLevel][2] - 1
	end
	WeekReturnChargeData(PlayerVipData,PlayerVipInfo, 0)
	SendGetOrButGiftRes(1)
end

