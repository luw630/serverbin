--[[
file:	ChargeSsumConfig.lua
author:	lpd
update:	2015-11-04
desc:累计充值活动逻辑
]]--

ChargeSumReward =  Activitymodule:new()
ChargeSumReward:Init(3)
ActivityRegister(ChargeSumReward)
chargeSumData = ChargeSumReward:LoadData()	--玩家的聚宝盆数据

function ChargeSumReward:OnTrigger(actParam) --当触发时做的事情,根据需要传递不同的参数，活动不同可以传递不同
	local sid
	local chargeNum
	for k,v in pairs(actParam) do
		sid = k
		chargeNum = v
	end
	
	if sid == nil or chargeNum == nil then
		return
	end
	look("ChargeSumReward:OnTrigger sid is "..sid.." \n chargeNum is "..chargeNum)
	local playerActData = ChargeSumReward:GetChargeSumData(sid) --获取玩家活动数据
	if playerActData ~= nil then--更新玩家充值记录
		playerActData.charge = playerActData.charge + chargeNum
		look("sum of "..sid.." charge num during the activity is "..playerActData.charge)
		chargeSumData[sid] = playerActData
		self:SaveData(chargeSumData)
		SendRewardState(sid)
	end
	
end


function ChargeSumReward:GetChargeSumData(sid) --获取玩家充值累计数据
	if chargeSumData ~= nil then
		if chargeSumData[sid] == nil then
			chargeSumData[sid] = 
			{
				charge = 0, --代表充值记录
			}
		end
	end
	return chargeSumData[sid]
end

function ChargeSumReward:setChargeSumReward(sid, rewardIndex)
	local playerActData = ChargeSumReward:GetChargeSumData(sid)
	local result = 0
	if playerActData == nil then 
		CI_ActResult(act_type.chargeSum,rewardIndex,result) --反馈客户端
	end
	
	if playerActData[rewardIndex] == nil then
		if playerActData.charge >= ChargeSumConfig[rewardIndex].miniCharge and  playerActData[rewardIndex] == nil then --满足最小的充值数额
		--发送奖励 
			for key, value in pairs(ChargeSumConfig[rewardIndex].reward) do      
				CI_AddGoods_SG(value[1], value[2], value[3], GoodsWay.active)
				--look("领取奖励了" ..value[1]..";" ..value[2]..";"..value[3]..";"..index)
			end  
			--标记此奖励领取状况为已领取
			playerActData[rewardIndex] = -1;
			look(sid.." get the charge sum activity reward which its reward index is "..rewardIndex)
			chargeSumData[sid] = playerActData
			self:SaveData(chargeSumData)
			result = 1
		end
	else
		look(sid.." has  recived  the reward which its reward index is "..rewardIndex)	
	end	
	CI_ActResult(act_type.chargeSum,rewardIndex,result) --反馈客户端
end

function GetChargeSumReward(sid, rewardIndex) --获取充值奖励
	local actmodule = ActivityGetmodulebyIndex(1002)  --自己的活动ID，可以定义为枚举方便识别
	if actmodule ~= nil then
		actmodule:setChargeSumReward(sid, rewardIndex)
	end
end



function Act_getRewardState(sid) --获取领取状态
	local rewardState = ""
	local playerActData = ChargeSumReward:GetChargeSumData(sid)
	--look(playerActData)
	--look("ChargeSumConfig length is "..#ChargeSumConfig)
	for i = 1, #ChargeSumConfig do --循环遍历领取状态，转换为字符串，"1"表示未领取，"0"表示已经领取
		if playerActData[i] == nil then
			rewardState = rewardState.."1"
		else
			rewardState = rewardState.."0"
		end
	end
	--look("reward state is ".. rewardState)
	return rewardState
end


function SendRewardState(sid)
	local rewardState = Act_getRewardState(sid)
	local playerActData = ChargeSumReward:GetChargeSumData(sid)
	if playerActData ~= nil then
		CI_SendChargeSumResult(sid, playerActData.charge,rewardState)
	end
end

function ResetChargeSumData()
	--look(chargeSumData)
	if ChargeSumConfig.isResetEveryDay==1 then
		local _isonline = IsOnline
		for k,v in pairs(chargeSumData) do
			if type(v) == type({}) then
				for i,j in pairs(v) do
					if type(i) == type(0) then --如果是值，则赋空
						v[i] = nil
					elseif type(i) == type("") then --如果是charge 归零
						v[i] = 0
					end	
				end
				if _isonline(k) == true then
					SendRewardState(k)
				end
			end
		end

		ChargeSumReward:SaveData(chargeSumData)
	end
end

-- function ChargeSumTest()+
	-- local actParam = {}
	-- --actParam[1000101307] = 500
	-- --ChargeSumReward:OnTrigger(actParam)
	-- --Act_getRewardState(100001)
	-- --GetChargeSumReward(100001, 1)
-- end


--ChargeSumTest()
