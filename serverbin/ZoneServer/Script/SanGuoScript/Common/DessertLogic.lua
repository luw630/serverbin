--[[
file:	DessertLogic.lua
author:	Jonson
update:	2015-04-23
desc:三国的小型奖励的发放逻辑处理
]]--

local configInfor = DessertConfig

--取得小型奖励的玩家相关数据
local function Dessert_getdata( sid )
	if dbMgr[sid]==nil or  dbMgr[sid].data==nil then 
		return
	end
	if dbMgr[sid].data['dessert_count'] == nil then --初始化小型奖励的lua层数据
		dbMgr[sid].data['dessert_count'] = {
			[1] = 0,--默认每天已经领取小型奖励的次数为0
			[2] = false,--是否有奖励可以领取
			[3] = 0,--可领取的奖励的类型，1代表金钱、2代表宝石
			[4] = 0,--奖励的东西的个数
		}
	end
	return dbMgr[sid].data['dessert_count']
end

--判断是否可以发放奖励，只有判断可以发放奖励了，才跟C++交互
function SI_DispachDessert(sid)
	--获取玩家的小额奖励已经领取的次数
	local pdata = Dessert_getdata( sid )
	if pdata == nil or pdata[1] >= configInfor.CountLimitted then
		CI_DessertDispachInfor(false, 0, 0) --奖励已经领取完了，不予再次领取奖励了
		return
	end
	
	--首次进主城必掉落金币的处理
	local newbieGoldGained = get_Exdata(sid, SG_ExDataType.NewbieGoldFlag)
	if newbieGoldGained == nil or newbieGoldGained == 0 then
		pdata[2] = true
		pdata[3] = 1--此处这样赋值是跟DessertConfig严格耦合的
		pdata[4] = 10000--金币数量
		set_Exdata(sid, SG_ExDataType.NewbieGoldFlag, 1)
		--通知客户端，可以领取奖励
		CI_DessertDispachInfor(true, pdata[3], pdata[4])
		return
	end

	pdata[2] = false
	pdata[3] = 0
	pdata[4] = 0
	--根据配置的几率来随机奖励的类型，奖励的个数
	local randomValue = math.random(100)
	local weightAll = 0
	local probabilityInfor = configInfor.probability
	for i, v in ipairs(probabilityInfor) do
		weightAll = weightAll + v
		if randomValue <= weightAll then
			--随机到了要奖励的类型
			--接下来随机要奖励的个数
			local specifyConfigInfor = configInfor[i]
			local dessertUnitWeight = specifyConfigInfor.unitWeight
			local numRandomValue = math.random(100)--随机掉多少个数量的随机数
			local numWeightAll = 0
			
			for subIndex, subValue in ipairs(dessertUnitWeight) do
				numWeightAll = numWeightAll + subValue
				if numRandomValue <= numWeightAll then
					pdata[2] = true
					pdata[3] = i--此处这样赋值是跟DessertConfig严格耦合的
					pdata[4] = specifyConfigInfor.nums[subIndex]--获取要随机掉落的个数
					--通知客户端，可以领取奖励
					CI_DessertDispachInfor(pdata[2], pdata[3], pdata[4])
					return
				end
			end
			return
		end
	end
end

--领取小额奖励
function SI_ClaimDessert(sid)
	--获取玩家的小额奖励已经领取的次数
	local pdata = Dessert_getdata( sid )
	if pdata == nil then
		return
	end
	
	--查看是否有奖励可以领取，并判断今日的领取次数是否已经达到最大值
	if pdata[2] == false and pdata[1] >= configInfor.CountLimitted then
		return
	end
	
	--调用服务器提供的接口来加钱，dessertType跟CI_AddGoods_SG给定的接口中，GoodsType的前一部分是对应的
	CI_AddGoods_SG(pdata[3], 0, pdata[4], GoodsWay.mainCityActive)
	pdata[1] = pdata[1] + 1
end

--重置小额奖励已经领取的次数
function SI_ResetDesserBakedCount( sid )
	--获取玩家的小额奖励已经领取的次数
	local pdata = Dessert_getdata( sid )
	if pdata == nil then
		return
	end
	
	pdata[1] = 0--将每天已经领取小型奖励的次数置为0
end