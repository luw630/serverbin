local PlayerPrayerData = nil
local PlayerPrayerList = nil     --抽到的物品列表
local PRAYER_MAIL_EXTIME = 60 * 24 * 2   --2天
local PRAYER_RECHARGE_LIMIT = 0  --充值总额限制
local PRAYERDATANAME = tostring("PrayerData")
function SavePlayerPrayerData(sid)
	SaveLuaData(sid,PRAYERDATANAME,PlayerPrayerData)
end

function LoadPlayerPrayerData( sid )
	if PlayerPrayerData == nil then
		PlayerPrayerData = {}
	end
	
	PlayerPrayerData = LoadLuaData(sid,PRAYERDATANAME)
	if PlayerPrayerData.Prayersid == nil then
		look("PlayerPrayerData.Prayersid == nil")
		local newPrayerData = CreatePrayerData(sid)
		PlayerPrayerData = deepcopy(newPrayerData)
		SaveLuaData(sid,PRAYERDATANAME,PlayerPrayerData)
		--look(PlayerPrayerData)
	end
	--look("LoadPlayerPrayerData  ")
	--look(PlayerPrayerData)
end

function CreatePrayerData(sid)
	local PrayerData = {}
	PrayerData[1] = 1  	--元宝祈福次数
	PrayerData[2] = 1	--元宝免费次数
	PrayerData[3] = 0	--元宝免费抽取时间
	PrayerData[4] = 1	--铜钱祈福次数
	PrayerData[5] = 5	--铜钱免费次数
	PrayerData[6] = 0	--铜钱免费抽取时间
	PrayerData[7] = 1	--是否是第一次元宝抽取
	PrayerData[8] = 1	--是否是第一次铜钱抽取
	PrayerData[9] = 0	--玩家祈福积分总数
	PrayerData[10] = 0	--玩家祈福积分实际数量
	PrayerData[11] = 0	--玩家祈福积分全服排名
	PrayerData[12] = 0	--玩家祈福数据重置时间
	PrayerData.Prayersid = sid
	-- PrayerData.GPCount = 1     
	-- PrayerData.GFCount = 1		
	-- PrayerData.GFTime = 0			
	-- PrayerData.MPCount = 1		
	-- PrayerData.MFCount = 5		
	-- PrayerData.MFTime = 0		
	return PrayerData
end


function GetPrayerType(sid ) --获取抽取到的是武将还是道具
	--math.randomseed(os.time())
	-- local seed = os.time() % 10000
	-- math.randomseed(os.clock() * seed )
	--LuaRandomSeed()
	if PlayerPrayerData == nil or  PlayerPrayerData.Prayersid ~= sid then
		LoadPlayerPrayerData(sid)
	end
	local GoldPrayerCount = PlayerPrayerData[1] - 1
	local KnightChange = math.pow(Variable_X,GoldPrayerCount) * Variable_Y
	--look("GetPrayerType "..KnightChange)
	--local random = math.random(100)   
	local random = LuaRandRange(1,100)/100 --100以内随机
	if random <= KnightChange then
		return Prayer_Type.Prayer_Type_Knight
	else
		return Prayer_Type.Prayer_Type_Item
	end

end

function PlayerGoldPrayer( sid ,bcount) --元宝祈福
	if PlayerPrayerData == nil or  PlayerPrayerData.Prayersid ~= sid then
		LoadPlayerPrayerData(sid)
	end
	assert(PlayerPrayerData~=nil,"PlayerPrayerData nil")

	if GetPrayerEnable() == false then
		look("PlayerGoldPrayer Enable false ")
		SendPrayerResult(sid,0,0)
		return
	end

	if GetGoldPrayerEnable(sid) == 0 then
		look("PRAYER_RECHARGE_LIMIT LIMIT ")
		SendPrayerResult(sid,0,0)
		return
	end


	if bcount == nil then
		bcount = 1
	end

	if bcount < 1 then
		look("Prayer Count "..bcount)
		SendPrayerResult(sid,0,0)
		return
	end

	if PrayerConfig ~= nil then

		local  bIsfree = false

		if bcount == 1 then
			if PlayerPrayerData[3] ~= 0 then --元宝免费抽取时间
				if os.difftime(os.time(),PlayerPrayerData[3]) >= Prayer_FreeTime then  --免费抽取时间
					bIsfree = true
					PlayerPrayerData[3] = os.time()
				end
			else
					bIsfree = true
					PlayerPrayerData[3] = os.time()
			end
		end

		local costgold = 0   --花费的元宝
		if bIsfree == false then
			local gold = CI_GetPlayerDataSG(sid,2) --元宝数量
			if bcount == 10 then  --10连抽
				costgold = PrayerConfig.Prayer_Cost * bcount * PRAYERCOST_TEN
			else
				costgold = PrayerConfig.Prayer_Cost * bcount
			end
			if gold < costgold then
				look("PlayerGoldPrayer gold not Enough")
				SendPrayerResult(sid,0,0)
				return
			end
			CI_DecGoods_SG(2,0,costgold,0,sid)
		end


		PlayerPrayerList = {}

		if bcount == 10 then  --10连抽
			PlayerPrayerData[10] = PlayerPrayerData[10] + PrayerConfig.Prayer_Point   --多增加1次积分
			PlayerPrayerData[9] = PlayerPrayerData[9] + PrayerConfig.Prayer_Point   --多增加1次积分
		end
		local PType= {}
		for i=1,bcount do
			local  PrayerType = GetPrayerType(sid) 
			--table.insert(PType,PrayerType)
			
			if PrayerType == Prayer_Type.Prayer_Type_Knight then --抽到了武将
				PlayerPrayerData[1] = 1       --重置次数
			else
				PlayerPrayerData[1] = PlayerPrayerData[1]  + 1
			end
			PlayerPrayerData[10] = PlayerPrayerData[10] + PrayerConfig.Prayer_Point
			PlayerPrayerData[9] = PlayerPrayerData[9] + PrayerConfig.Prayer_Point
			BeginPrayerData(sid,PrayerType)
		end
		--look(PType)
		local playername = CI_GetPlayerDataSG(sid,4)
		PlayerPrayerData[11] = OnUpdataPrayerPoint(playername,PlayerPrayerData[9],PlayerPrayerData[11])
		SavePlayerPrayerData(sid)
		if PlayerPrayerList ~= nil then
			--look("SendPrayerResult     ")
			--look(PlayerPrayerList)
			SendPrayerResult(sid,1,PlayerPrayerList)
			OnInitPrayer(sid)
		end

	end
end


function BeginPrayerData( sid,PrayerType ) --祈福
	if PrayerConfig == nil then
		return
	end
	--math.randomseed(os.clock() * 1000)
	--LuaRandomSeed()
	local PrayerTable = nil
	if PrayerType == Prayer_Type.Prayer_Type_Item then
		PrayerTable = PrayerConfig.Prayer_Item
	elseif PrayerType == Prayer_Type.Prayer_Type_Knight then
		PrayerTable = PrayerConfig.Prayer_Knight
	end

	if PrayerTable ~= nil then
		--local random = math.random(100)    --100以内随机
		local random = LuaRandRange(1,100)    --100以内随机
		
		local Prayernum = #PrayerTable
		local addnum = 0
		--look("BeginPrayerData   "..random)
		while true do
			if Prayernum < 1 then
				break
			end
			local PrayerData = PrayerTable[Prayernum]
			addnum = addnum + PrayerData.Chances
			--look("  Chances "..addnum)
			if random <= addnum then
				break
			end
			Prayernum = Prayernum - 1
		end

		--look("  Prayernum "..Prayernum)

		-- local seed = math.random(os.clock() * 1000)
		-- math.randomseed(seed)
		LuaRandomSeed()
		if Prayernum > 0 then
			local PrayerDataList = PrayerTable[Prayernum].ItemList
			local DataMax= #PrayerDataList 
			local random = LuaRandRange(1,DataMax)

			if random % 2 == 0 then
				random = random - 1
			end
			--look("BeginPrayerData "..random)

			local ItemIndex = PrayerDataList[random]
			local ItemNum = PrayerDataList[random + 1]
			if PrayerType == Prayer_Type.Prayer_Type_Item then
				if CI_AddGoods_SG(3,ItemIndex,ItemNum,0,sid) ~= nil then
					local temp = {itype = 3,inum = ItemNum,iindex = ItemIndex}   --类型s，数量, ID
					table.insert(PlayerPrayerList,temp)
					--look("PrayerItem Sucess")
				end
			elseif PrayerType == Prayer_Type.Prayer_Type_Knight then
				if CI_AddGoods_SG(4,ItemIndex,1,0,sid) ~= nil  then
					--look("PrayerKnight Sucess")
					local temp = {itype = 4,inum = ItemNum,iindex = ItemIndex}   --类型s，数量, ID
					table.insert(PlayerPrayerList,temp)
				end

			end
			return
		end
	end
end

function GetPrayerFreeTime(sid  )
	if PlayerPrayerData == nil or  PlayerPrayerData.Prayersid ~= sid then
		LoadPlayerPrayerData(sid)
	end
	assert(PlayerPrayerData~= nil," LoadPlayerPrayerData nil ")

	if PlayerPrayerData[3] ~= 0 then
		local difftime = os.difftime(os.time(),PlayerPrayerData[3])
		if difftime >= Prayer_FreeTime then  --免费抽取时间
			PlayerPrayerData[3] = 0
			return 0	
		end
		return Prayer_FreeTime - difftime
	end
	return 0
end

function GetGoldPrayerEnable(sid)
	local rechargenum = CI_GetPlayerDataSG(sid,7) --充值总额
	--look("Player rechargenum = "..rechargenum)
	if rechargenum < PRAYER_RECHARGE_LIMIT then
		look("PRAYER_RECHARGE_LIMIT LIMIT ")
		return 0
	end
	return 1
end



function OnInitPrayer( sid ) --玩家祈福初始化
	if PlayerPrayerData == nil or  PlayerPrayerData.Prayersid ~= sid then
		LoadPlayerPrayerData(sid)
	end
	local playername = CI_GetPlayerDataSG(sid,4)
	--look("OnInitPrayer ")
	--look(PlayerPrayerData)
	local Prayer = {}
	if PlayerPrayerData[12] == 0 or PlayerPrayerData[12] ~= StringDate(GetActivityStartTime())  then
		PlayerPrayerData[12] = StringDate(GetActivityStartTime())
		PlayerPrayerData[10] = 0
		PlayerPrayerData[9] = 0
		PlayerPrayerData[3] = 0
		--look("OnInitPrayer Save")
		--look(StringDate(GetActivityStartTime()))
		SavePlayerPrayerData(sid)
	end

	Prayer.wCurrentPoint = PlayerPrayerData[10]
	Prayer.wHistoryPoint = PlayerPrayerData[9]
	Prayer.wRemainDay = OnGetPrayerDayRemain()
	Prayer.dfreetime = GetPrayerFreeTime(sid)
	Prayer.dclosetime = GetShopCloseTime()
	Prayer.bShopOpened = PRAYERSHOPOPENED
	--Prayer.bShopOpened = GetGoldPrayerEnable(sid)
	--look("OnInitPrayer   "..sid)
	SendInitPrayer(sid,GetPrayerPointRank(),Prayer)
	--look(Prayer)
end




function GetPrayerPoint(sid,Ptype ) --获取玩家积分 0 --玩家祈福积分总数  1 --玩家祈福积分实际数量
	if PlayerPrayerData == nil or  PlayerPrayerData.Prayersid ~= sid then
		LoadPlayerPrayerData(sid)
	end
	if Ptype == 0 then
		return PlayerPrayerData[9]
	elseif Ptype == 1 then
		return PlayerPrayerData[10]
	end
	return nil
end

function ChangePrayerPoint( sid,Ptype,ChangePoint ) --积分变更   0 --玩家祈福积分总数  1 --玩家祈福积分实际数量
	if PlayerPrayerData == nil or  PlayerPrayerData.Prayersid ~= sid then
		LoadPlayerPrayerData(sid)
	end
	if Ptype == 0 then  --更改祈福积分总数，刷新排行榜
		if PlayerPrayerData[9] + ChangePoint < 0 then
			PlayerPrayerData[9] = 0
			look(" Ptype "..Ptype.."  ChangePoint < 0  ")
		else
			PlayerPrayerData[9] = PlayerPrayerData[9]  + ChangePoint
		end
		local playername = CI_GetPlayerDataSG(sid,4)
		PlayerPrayerData[11] = OnUpdataPrayerPoint(playername,PlayerPrayerData[9],PlayerPrayerData[11])
		SavePlayerPrayerData(sid)
		OnInitPrayer(sid)
		return PlayerPrayerData[9]
	elseif Ptype == 1 then
		if PlayerPrayerData[10] + ChangePoint < 0 then
			PlayerPrayerData[10] = 0
			look(" Ptype "..Ptype.."  ChangePoint < 0  ")
		else
			PlayerPrayerData[10] = PlayerPrayerData[10]  + ChangePoint
		end
		SavePlayerPrayerData(sid)
		return PlayerPrayerData[10]
	end
	return nil
end

function SendPrayerReward( ) --发送祈福排行榜的奖励
	if PrayerShop_RankReward ~= nil then
		local rank = GetPrayerPointRank()
		
		if rank ~= nil then
			local sendnum = #PrayerShop_RankReward
			local MailInfo = {}    -- 邮件信息
			local RewardList = {}  --道具列表
			local temp = {}
			
			MailInfo.senderName = MystringFormat("MAIL_SENDER")
			--MailInfo.title = MystringFormat("MAIL_FACTION_TITLE")
			--MailInfo.content = MystringFormat("MAIL_FACTION_TITLE")
			MailInfo.title = MystringFormat("MAIL_PRAYER_TITLE")
			MailInfo.content = MystringFormat("MAIL_PRAYER_CONTENT")
			MailInfo.expiretime = PRAYER_MAIL_EXTIME
			
			for i,v in ipairs(PrayerShop_RankReward) do
				local itemlist = v.itemlist
				if v.range ~= nil and itemlist ~= nil then
					for k=v.range[1],v.range[2] do
						MailInfo.recvname = GetPrayerPlayerName(k)
						if MailInfo.recvname ~= nil then
							--look("SendPrayerReward Player"..MailInfo.recvname)
							temp = {}
							RewardList = {}
							for m,n in pairs(itemlist) do
								temp.itype = n[1]
								temp.itemid = n[2]
								temp.num =  n[3]
								table.insert(RewardList,deepcopy(temp))
							end


							--look(RewardList)
							SendMailToPlayer(MailInfo,RewardList,2)
						end
					end
				end
			end

		end
	end
	
end


function Prayertest(  )
	local prank = GetPrayerPointRank()
	look(prank)

end
