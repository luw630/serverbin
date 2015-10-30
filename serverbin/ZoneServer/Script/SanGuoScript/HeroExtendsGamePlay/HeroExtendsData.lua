--[[
file:	HeroExtendsData.lua
author:	Jonson
update:	2015-07-03
desc:	三国的武将英雄的额外数据的管理，比如说玩家武将是否在训练，是否在挂机寻宝等等
]]--

--英雄扩展性玩法的类型
HeroExGameplayMode = {
	Training = 1, --训练英雄
	HuntingTreasure = 2, --挂机寻宝
}

--主要用来获取英雄扩展性玩法的基础数据中的某一类数据
HeroExDataType = {
	trainingState = 3, --千分位
	trainingType = 4,--万分位
	hungingHuntingState = 5,--十万分位
	surprisedTimes = 6,--百万分位，代表已经申请掉宝的次数
	cachedLevel = 7,--千万分位及其以上代表的是开始这一玩法的时候武将(或者君主)的等级
}

-- 记录了整个服务器的所有在线玩家的武将中，进行训练的武将的个数，正在挂机寻宝的武将个数等待，只存在于内存中，不会写入到数据库中
local classifiedExHeroNumData = {}
local _HeroExDataType = HeroExDataType

--取得玩家的英雄的扩展的相关数据
local function heroEx_getdata( sid )
	if dbMgr[sid]==nil or  dbMgr[sid].data==nil then 
		return
	end
	if dbMgr[sid].data['heroEx_data'] == nil then --初始化lua层数据
		dbMgr[sid].data['heroEx_data'] = {
		}
	end
	return dbMgr[sid].data['heroEx_data']
end

--获取某一个指定英雄的扩展性玩法相关的数据，如果不存在该英雄，则默认新建个
local function _GetHeroExData(sid, heroID)
	local pData = heroEx_getdata(sid)
	if pData == nil then 
		return
	end
	
	if pData[heroID] == nil then
		pData[heroID] = {
			[1] = heroID, --假如英雄ID是101，那么这里存的基础数据就是0000000101，个位到百位代表英雄ID，千分位代表是否在进行训练、万分位代表的是训练的类型，十万分位代表是否在进行寻宝，百万分位代表请求掉宝的次数，千万分位及其以上暂时表示开始该玩法时武将(或君主)的等级
			[2] = 0,--玩法的开始时间
		}
	end
	
	return pData[heroID]
end

local function cacheClassifiedHeroNum(sid)
	local trainingHeroNum = 0
	local huntingHeroNum = 0
	local pData = heroEx_getdata(sid)
	for _, value in pairs(pData) do
		if value ~= nil and value[1] ~= nil then
			--获取武将的训练状态
			local datasit = math.pow(10, _HeroExDataType.trainingState)
			--获得截取掉某一位后面的数据后的数据
			local tempData = math.floor(value[1] / datasit)
			--等到某一位存储的要找的数据
			if tempData % 10 ~= 0 then
				trainingHeroNum = trainingHeroNum + 1
			end
			
			--获取武将的挂机寻宝状态
			datasit = math.pow(10, _HeroExDataType.hungingHuntingState)
			tempData = math.floor(value[1] / datasit)
			if tempData % 10 ~= 0 then
				huntingHeroNum = huntingHeroNum + 1
			end
		end
	end
	
	classifiedExHeroNumData[sid] = {
		[HeroExGameplayMode.Training] = trainingHeroNum,
		[HeroExGameplayMode.HuntingTreasure] = huntingHeroNum,
	}
end

--获取某一个玩家的所有武将中正在进行某一项武将的扩展性玩法的数量
function GetClassifiedHeroNum(sid, heroExGameplayMode)
	--首先判断在内存中是否有玩家的对应的数据，如果没有，则新建一个
	if classifiedExHeroNumData[sid] == nil then
		cacheClassifiedHeroNum(sid)
	end
	
	return classifiedExHeroNumData[sid][heroExGameplayMode]
end

--增加某一个玩家的参加某一个扩展性玩法的武将的数量
function IncClassifiedHeroNum(sid, heroExGameplayMode)
	--首先判断在内存中是否有玩家的对应的数据，如果没有，则新建一个
	if classifiedExHeroNumData[sid] == nil then
		cacheClassifiedHeroNum(sid)
	end
	
	classifiedExHeroNumData[sid][heroExGameplayMode] = classifiedExHeroNumData[sid][heroExGameplayMode] + 1
end

--减少某一个玩家的参加某一个扩展性玩法的武将的数量
function DecClassifiedHeroNum(sid, heroExGameplayMode)
	--首先判断在内存中是否有玩家的对应的数据，如果没有，则新建一个
	if classifiedExHeroNumData[sid] == nil then
		cacheClassifiedHeroNum(sid)
	end
	
	classifiedExHeroNumData[sid][heroExGameplayMode] = classifiedExHeroNumData[sid][heroExGameplayMode] - 1
end

--获取玩法在数据库中所存储的时间参数（代表的是该武将开始进入某一玩法的具体时间）
function GetGameplayTimeParam(sid, heroID)
	local pHeroData = _GetHeroExData(sid, heroID)
	return pHeroData[2]
end

--设置玩法在数据库中所存储的时间参数（代表的是该武将开始进入某一玩法的具体时间）
function SetGameplayTimeParam(sid, heroID, data)
	local pHeroData = _GetHeroExData(sid, heroID)
	pHeroData[2] = data
end

--获取英雄武将的扩展性玩法相关数据中的某一类数据
function GetSpecifyExBaseData(sid, heroID, heroExDataType)
	local pHeroData = _GetHeroExData(sid, heroID)
	--要取的数据的位数
	local datasit = math.pow(10, heroExDataType)
	--获得截取掉某一位后面的数据后的数据
	local tempData = math.floor(pHeroData[1] / datasit)
	--返回要获得的数据
	if heroExDataType == _HeroExDataType.cachedLevel then
		return tempData
	else
		return tempData % 10
	end
end

--重置玩家某一个武将对应的扩展性玩法相关的数据
function ResetExBaseData(sid, heroID)
	--将该玩家的数据从表中移除
	local pData = heroEx_getdata(sid)
	pData[heroID] = nil
end

--设置英雄武将的扩展性玩法相关数据中的某一类数据
function SetSpecifyExBaseData(sid, heroID, heroExDataType, data)
	local pHeroData = _GetHeroExData(sid, heroID)
	--要设置的数据的位数
	local datasit = math.pow(10, heroExDataType)
	--存好要设置的数据的“前”、“后”
	local tempData1, tempData2 = math.modf(pHeroData[1] / datasit)
	pHeroData[1] = (tempData1 + data) * datasit + tempData2 * datasit
end

--开始训练武将，简化数据的设置操作，是对SetSpecifyExBaseData的一种形式的简化
function StartToTrainingHero(sid, heroID, masterLevel, trainingType)
	local pHeroData = _GetHeroExData(sid, heroID)
	pHeroData[1] = masterLevel * 10000000 + trainingType * 10000 + 1000 + heroID
end

--开始将某一个武将挂机寻宝，简化数据的设置操作，是对SetSpecifyExBaseData的一种形式的简化
function StartToHunting(sid, heroID, masterLevel)
	local pHeroData = _GetHeroExData(sid, heroID)
	pHeroData[1] = masterLevel * 10000000 + 100000 + heroID
end

--将玩家武将的扩展性玩法
function SynHeroExDataToClient(sid)
	CI_SynHeroExtendsData(heroEx_getdata(sid))
end