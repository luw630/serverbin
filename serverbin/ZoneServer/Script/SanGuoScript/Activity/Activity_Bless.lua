--[[
file:	BlessActivity.lua
author:	lpd
update:	2015-11-03
desc:祈福活动相关逻辑
]]--

BlessActivity =  Activitymodule:new()
BlessActivity:Init(ActIndex.bless)
ActivityRegister(BlessActivity)
BlessActData = BlessActivity:LoadData()	--玩家的聚宝盆数据
local _blessConfig =  BlessActConfig
local _bless_msg = msgh_s2c_def[s2c_msg.act][4] --祈福消息头
function BlessActivity:GetBlessData (sid) --获取玩家祈福数据
	-- look("BlessActivity:GetBlessData")
	-- look(sid)
	if BlessActData ~= nil then
		if BlessActData[sid] == nil then
			BlessActData[sid] = 
			{
				[1] = 0, --累计祈福次数
				[2] = {}
			}
		end
	end
	return BlessActData[sid]
end

function OnBlessOver(sid,blessType, blessCount) --祈福完毕后的回调函数 blessType祈福类型，blessCount祈福次数
	look("OnBlessOver")
	look(sid)
	look(blessType)
	look(blessCount)
	local  blessData = BlessActivity:GetBlessData(sid) 

	if blessData ~= nil then
		blessData[1] = blessData[1] + blessCount
	end
end 

function GetBlessActReward(sid, rewardIndex) --获取祈福活动奖励 sid玩家唯一标识，rewardIndex奖品下标
	if BlessActivity:GetActivityEnable() == false then
		return
	end
	local  blessData = BlessActivity:GetBlessData(sid) 
	-- look("GetBlessActReward" )
	-- look(sid)
	-- look(rewardIndex)
	-- look(blessData)
	if _blessConfig[rewardIndex] ~= nil and blessData ~= nil then 
		local condition = _blessConfig[rewardIndex].blessCount
		if blessData[1] >= condition and  blessData[2][rewardIndex] == nil then --满足条件 且 未领取过
			blessData[2][rewardIndex] = 1 --标记为已领取
			for k, v in pairs(_blessConfig[rewardIndex].reward) do 
				CI_AddGoods_SG(v[1], v[2], v[3], GoodsWay.exchangeACT)
			end
			SendBlessActData(sid) 
		end
	end  

end


function SendBlessActData(sid)--发送祈福活动状态
	if BlessActivity:GetActivityEnable() == false then
		return
	end

	local  blessData = BlessActivity:GetBlessData(sid) 
	if blessData ~= nil then
		-- look("SendBlessActData1111111111111")
		-- look("_bless_msg")
		-- look(_bless_msg)
		-- look("blessData")
		-- look(blessData)
		SendLuaMsg(sid, { ids = _bless_msg, blessData[1] , blessData[2] })
	end
end

function BlessActivity:OnActivityClosed(actParam)
 	-- body
 	--BlessActData = {}
end 




