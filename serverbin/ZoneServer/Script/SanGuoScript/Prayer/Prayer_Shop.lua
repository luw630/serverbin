--积分商店
local SHOPFLUSHTIME = 60 * 60 * 8
local PrayerShopData = nil
local ShopDataName = tostring("PrayerShop")
function OnInitShop( sid )
	if PrayerShopData == nil or PrayerShopData.Sid ~= sid then
		PrayerShopData = LoadLuaData(sid,ShopDataName)
	end

	if PrayerShopData == 0 then
		look("Init PrayerShopData Faile")
		return
	end

	local level = CI_GetPlayerDataSG(sid,3)  --等级 
	local binit = 1
	if level > 0 then
		assert(PrayerShop_Config ~= nil,"PrayerShop_Config nil")
		local levelRegion = {}
		for k,v in pairs(PrayerShop_Config) do
			table.insert(levelRegion,k)
		end

		table.sort( levelRegion)
		for i,v in ipairs(levelRegion) do
			if level <= v then
				level = v 
				break
			end
		end
		--look("OnInitShop "..level)
		assert(PrayerShop_Config[level] ~= nil," PrayerShop_Config[level] == nil")
		if PrayerShop_Config[level] ~= nil then
			for i,v in ipairs(PrayerShop_Config[level]) do
				local itemindex,itemnum = GetCellItem(level,i)
				--look("itemindex itemnum "..itemindex.."    "..itemnum)
				local itemprice = GetShopPriceNum(itemindex)
				if itemindex > 0 and itemprice > 0 then
					PrayerShopData[i] = {itemindex,itemnum,itemprice * itemnum}   --记录刷新的道具 ,数量，价格
				else
					look("OnGetShopData Faile "..itemindex.." itemprice  "..itemprice.."    level  "..level.."  index "..i)
					binit = 0
					return 0
				end
			end
			if binit == 1 then
				PrayerShopData.rt = os.time()	--记录刷新时间
				SaveLuaData(sid,ShopDataName,PrayerShopData)
				return 1
			end
		end
	end
	return 0
end

function GetShopPriceNum( itemindex ) --获取道具售价
	if ShopItemList ~= nil then
		for k,v in pairs(ShopItemList) do
			if v[1] == itemindex then
				return v[2]
			end
		end
	end
	return 0
end

function GetCellItem(level,index) --获取某一格的道具
	--math.randomseed(os.clock() * 10000)
	if PrayerShop_Config[level] ~= nil then
		local Shopitem = PrayerShop_Config[level][index]
		if Shopitem ~= nil then
		    local allchance = 0
			for k,v in pairs(Shopitem) do
				if type(k) == "number" then
					allchance = allchance + k
				end
			end
			local chance = {}
			--local random = math.random(10000)    --10000以内随机
			local random = LuaRandRange(1,10000)
			if allchance > 0 then  --计算总和
				for k,v in pairs(Shopitem) do
					if type(k) == "number" then
						local itemchance = k / allchance * 10000
						table.insert(chance,{k,itemchance})
					end
				end
				table.sort(chance,function(t1,t2)return t1[2]<t2[2] end)
				--look("GetCellItem    "..random)

				--math.randomseed(os.clock() * 10000)
				local addnum = 0
				for i,v in ipairs(chance) do
					addnum = addnum + v[2]
					if random <= addnum then
						local randindex = v[1]
						--look(Shopitem[randindex])
						local itemsize = #Shopitem[randindex]
						random = LuaRandRange(1,itemsize)
						--random = math.random(itemsize)
						--look(" random   "..random.."    item "..Shopitem[randindex][random])
						return Shopitem[randindex][random],Shopitem.Itemnum
					end
				end

				look("GetCellItem Faile  "..random)
				look(chance)
			end
		end
	end
	return 0
end

function OnGetShopData( sid,brefreshtype )
	if PrayerShopData == nil or PrayerShopData.Sid ~= sid then
		PrayerShopData = LoadLuaData(sid,ShopDataName,PrayerShopData)
	end

	if PrayerShopData == 0 then
		PrayerShopData = nil
		look("Init PrayerShopData Faile")
		return
	end

	--look(PrayerShopData)
	local brefresh = 0
	
	local PricePoint = 0
	if brefreshtype == 0 then   --初始化商店
		if PrayerShopData.rt == nil then  --没有数据刷新过
			PrayerShopData.rcount = 1     --记录次数
			brefresh = 1
		else
			local PrayerData = tonumber(os.date("%Y%m%d",PrayerShopData.rt))
			local nowhour = os.date("*t",os.time()).hour
			local nowdata = tonumber(os.date("%Y%m%d",os.time()))
			if PrayerData < nowdata then
				local RefreshHour =  os.date("*t",PrayerShopData.rt).hour
--				look("PrayerData "..PrayerData.."  hour "..RefreshHour)
				if RefreshHour < PrayerShop_RefreshTime then --在刷新时间以前刷新过
					brefresh = 1
				end
			else
				if nowhour >= PrayerShop_RefreshTime then
					local RefreshHour  = os.date("*t",PrayerShopData.rt).hour
					if RefreshHour < PrayerShop_RefreshTime then --在刷新时间以前刷新过
						brefresh = 1
					end		
				end
			end
		end
	else
		if PrayerShopData.rcount == nil and PrayerShopData.rt == nil then --这里应该是客户端发错了类型,先初始化
			OnGetShopData(sid,0)
			return
		end

		PricePoint = GetRefreshPoint(PrayerShopData.rcount)
		local PrayerPoint = GetPrayerPoint(sid,1)
		if PrayerPoint == nil or PrayerPoint < PricePoint then
			look("RefreshPoint is n't enough "..PrayerPoint.."  Price "..PricePoint)
			return
		end
		if ChangePrayerPoint(sid,1,-PricePoint) == nil then
			look("ChangePrayerPoint Faile")
			return
		end
		brefresh = 1
		PrayerShopData.rcount = PrayerShopData.rcount + 1
	end
	PricePoint = GetRefreshPoint(PrayerShopData.rcount)

	local senditemlist = {}
	if brefresh == 1 then
		if OnInitShop(sid) == 0 then
			look("shop refresh faile")
			return 0
		end
	end

	for i,v in ipairs(PrayerShopData) do
		if type(i) == "number" and type(v) == "table" then
			senditemlist[i] = v
		end
	end
	local nowtime = os.date("*t",os.time())
	local endtime = 0
	-- if nowtime.hour >= PrayerShop_RefreshTime then
	-- 	endtime = (23 - nowtime.hour + PrayerShop_RefreshTime) * 60 * 60 + ((60 - nowtime.min) * 60)
	-- 	look(endtime)
	-- end

--	look(" SendShopItemList to "..sid.."  PricePoint "..PricePoint.." brefreshtype "..brefreshtype)
	
	--look(senditemlist)
	SendShopItemList(sid,PrayerShop_RefreshTime,GoodsType.blessPoints,PricePoint,senditemlist)

end

function GetRefreshPoint( rcount ) --获取刷新次数花费
	if rcount == nil then
		look("GetRefreshPoint nil")
		return
	end
	local PricePoint = 0
	if PrayerShop_RefreshPoint ~= nil then
		local nlenth = #PrayerShop_RefreshPoint
		if rcount <= nlenth then
			PricePoint = PrayerShop_RefreshPoint[rcount]
		else
			PricePoint = PrayerShop_RefreshPoint[nlenth]
		end
	end
	return PricePoint
end

function stest( sid )
	for i,v in ipairs(PrayerShop_Config[80]) do
		local itemindex,itemnum = GetCellItem(80,i)
		look(" itemindex "..itemindex.."    itemnum "..itemnum.."     i "..i)
	end


end

function OnShopBuyItem(sid,btype,shopIndex )
	if PrayerShopData == nil or PrayerShopData.Sid ~= sid then
		PrayerShopData = LoadLuaData(sid,ShopDataName,PrayerShopData)
	end

	if PrayerShopData == 0 then
		look("Init PrayerShopData Faile")
		return
	end

	shopIndex = shopIndex + 1

	local  bresult = 0
	if btype == 0 then --购买
		if PrayerShopData ~= nil  then
			if PrayerShopData[shopIndex] ~= nil then
				local PrayerItem = PrayerShopData[shopIndex]
				if PrayerItem[2] == 0 then
					look("item number  0")
					SendShopBuyResult(sid,0)
					return
				end

				local PrayerPoint = GetPrayerPoint(sid,1)
				if PrayerPoint == nil or PrayerPoint < PrayerItem[3]  then
					look("PrayerPoint isn't enough "..PrayerPoint.." PrayerItem  "..PrayerItem[3] )
					SendShopBuyResult(sid,2)  
					return
				end

				if ChangePrayerPoint(sid,1,-PrayerItem[3]  ) == nil then
					look("ChangePrayerPoint Faile")
					SendShopBuyResult(sid,3)  
					return
				end
				
				CI_AddGoods_SG(3,PrayerItem[1],PrayerItem[2],0,sid)
				PrayerItem[2] = 0
				SaveLuaData(sid,ShopDataName,PrayerShopData)
				SendShopBuyResult(sid,1)
				look("SendShopBuyResult  1")
				return
			end
		end
	end
	SendShopBuyResult(sid,4)  
	look(" SendShopBuyResult 4 "..btype.." shopIndex "..shopIndex)
end