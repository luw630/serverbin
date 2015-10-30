--一些 VIP 相关函数
PlayerVipLimitData = tostring("PlayerVipLimitData")  --世界喊话数据
PlayerVipLimitItem = tostring("PlayerVipLimitItem")  --VIP使用道具限制
local dwSmallHornIndex = 8001001 -- 小喇叭道具索引 

function GetWorldTalkLimit() --获取玩家能否世界喊话
	local PlayerLimitData = LoadPlayerTable(PlayerVipLimitData)
	if PlayerLimitData == nil then
		PlayerLimitData = {}
		PlayerLimitData.worldtalkcount = 0    --世界喊话次数
		PlayerLimitData.worldtalktime = 0    --世界喊话时间
		WeekReturnChargeData(PlayerVipLimitData,PlayerLimitData)
	end

	if PlayerLimitData.worldtalktime > 0 then  --根据购买时间重置购买次数以及时间
		local nowdate = tonumber(os.date("%Y%m%d",os.time()))
		local buydate = tonumber(os.date("%Y%m%d",PlayerLimitData.worldtalktime))
		if nowdate - buydate > 0 then   --超过1天，次数重置
			PlayerLimitData.worldtalkcount = 0    --世界喊话次数
			PlayerLimitData.worldtalktime = 0    --世界喊话时间
		end
		WeekReturnChargeData(PlayerVipLimitData,PlayerLimitData)
	end

	local viplevel = GetPlayerData(0,GPP_VIPLEVEL)
	viplevel = viplevel + 1
	if viplevel > 0 then
		if VIPWORLDTALK~= nil and VIPWORLDTALK[viplevel] ~= nil then        --vip喊话次数
			if PlayerLimitData.worldtalkcount < VIPWORLDTALK[viplevel] then
				PlayerLimitData.worldtalkcount = PlayerLimitData.worldtalkcount + 1
				PlayerLimitData.worldtalktime = os.time()
				WeekReturnChargeData(PlayerVipLimitData,PlayerLimitData)
				--rfalse("worldtalkcount "..PlayerLimitData.worldtalkcount.."")
				CompleteAndActiveness(6)
				return 1
			end
		end
	end

	if GetItemNum(dwSmallHornIndex) > 0 then
		if DeleteItem(dwSmallHornIndex,1) == 1 then    --删除道具小喇叭
			CompleteAndActiveness(6)
			return 1
		end
	end
	local str = MystringFormat("NOSMALLHORN")
	TalkToPlayer(2,str)
	return 0
end 


function  VipAddMonsterExp(dmonsterexp) --VIP额外增加经验
	if dmonsterexp <= 0 then
		return 0
	end

	local viplevel = GetPlayerData(0,GPP_VIPLEVEL)
	viplevel = viplevel + 1
	if viplevel > 0 then
		if VIPMONSTEREXP~= nil and VIPMONSTEREXP[viplevel] ~= nil then
			dmonsterexp = dmonsterexp + dmonsterexp * VIPMONSTEREXP[viplevel]
		end
	end
	return dmonsterexp
end


function  GetItemUseLimit(ditemIndex)  --VIP道具使用限制
	local PlayerLimitItem = LoadPlayerTable(PlayerVipLimitItem)
	local bisfinditem = 0
	if PlayerLimitItem == nil then
		PlayerLimitItem = {}
		WeekReturnChargeData(PlayerVipLimitItem,PlayerLimitItem)
	end
	for k,v in pairs(PlayerLimitItem) do
		if v.UseItemTime > 0 and v.UseItemIndex > 0 then
			local nowdate = tonumber(os.date("%Y%m%d",os.time()))
			local usedate = tonumber(os.date("%Y%m%d",v.UseItemTime))
			if nowdate - usedate > 0 then   --超过1天，次数重置
				v.UseItemCount = 0    --道具使用次数
				v.UseItemTime = 0    --道具使用时间
				v.UseItemIndex = 0 	 --道具ID
			end
		end
	end
	WeekReturnChargeData(PlayerVipLimitItem,PlayerLimitItem)

	local viplevel = GetPlayerData(0,GPP_VIPLEVEL)
	viplevel = viplevel + 1
	local itemlimit = nil
	if VIPITEMLIMIT ~= nil and VIPITEMLIMIT[ditemIndex] ~= nil then
		itemlimit = VIPITEMLIMIT[ditemIndex][viplevel]
	end

	if itemlimit == nil then   						--没有找到的话应该不是限制的道具，所以直接可以使用
		return 1
	end

	for k,v in pairs(PlayerLimitItem) do
		if v.UseItemIndex == ditemIndex then
			bisfinditem = 1
			if v.UseItemCount >= itemlimit then
				local str = MystringFormat("VIPLEVELNOTENOUGH")
				TalkToPlayer(2,str)
				return 0
			end 
			v.UseItemCount = v.UseItemCount + 1
			v.UseItemTime = os.time()
			break
		end
	end

	if bisfinditem == 0 then
		local useitem = {}
		useitem.UseItemCount = 0
		if useitem.UseItemCount >= itemlimit then
			local str = MystringFormat("VIPLEVELNOTENOUGH")
			TalkToPlayer(2,str)
			return 0
		end
		useitem.UseItemCount = useitem.UseItemCount + 1
		useitem.UseItemTime = os.time()
		useitem.UseItemIndex = ditemIndex
		table.insert(PlayerLimitItem,useitem)
	end
	--printtable(PlayerLimitItem)
	WeekReturnChargeData(PlayerVipLimitItem,PlayerLimitItem)
	return 1
end