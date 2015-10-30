--һЩ VIP ��غ���
PlayerVipLimitData = tostring("PlayerVipLimitData")  --���纰������
PlayerVipLimitItem = tostring("PlayerVipLimitItem")  --VIPʹ�õ�������
local dwSmallHornIndex = 8001001 -- С���ȵ������� 

function GetWorldTalkLimit() --��ȡ����ܷ����纰��
	local PlayerLimitData = LoadPlayerTable(PlayerVipLimitData)
	if PlayerLimitData == nil then
		PlayerLimitData = {}
		PlayerLimitData.worldtalkcount = 0    --���纰������
		PlayerLimitData.worldtalktime = 0    --���纰��ʱ��
		WeekReturnChargeData(PlayerVipLimitData,PlayerLimitData)
	end

	if PlayerLimitData.worldtalktime > 0 then  --���ݹ���ʱ�����ù�������Լ�ʱ��
		local nowdate = tonumber(os.date("%Y%m%d",os.time()))
		local buydate = tonumber(os.date("%Y%m%d",PlayerLimitData.worldtalktime))
		if nowdate - buydate > 0 then   --����1�죬��������
			PlayerLimitData.worldtalkcount = 0    --���纰������
			PlayerLimitData.worldtalktime = 0    --���纰��ʱ��
		end
		WeekReturnChargeData(PlayerVipLimitData,PlayerLimitData)
	end

	local viplevel = GetPlayerData(0,GPP_VIPLEVEL)
	viplevel = viplevel + 1
	if viplevel > 0 then
		if VIPWORLDTALK~= nil and VIPWORLDTALK[viplevel] ~= nil then        --vip��������
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
		if DeleteItem(dwSmallHornIndex,1) == 1 then    --ɾ������С����
			CompleteAndActiveness(6)
			return 1
		end
	end
	local str = MystringFormat("NOSMALLHORN")
	TalkToPlayer(2,str)
	return 0
end 


function  VipAddMonsterExp(dmonsterexp) --VIP�������Ӿ���
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


function  GetItemUseLimit(ditemIndex)  --VIP����ʹ������
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
			if nowdate - usedate > 0 then   --����1�죬��������
				v.UseItemCount = 0    --����ʹ�ô���
				v.UseItemTime = 0    --����ʹ��ʱ��
				v.UseItemIndex = 0 	 --����ID
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

	if itemlimit == nil then   						--û���ҵ��Ļ�Ӧ�ò������Ƶĵ��ߣ�����ֱ�ӿ���ʹ��
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