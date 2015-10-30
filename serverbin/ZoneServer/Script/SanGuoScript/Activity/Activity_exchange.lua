--[[
file:	Activity_exchange.lua
author:	wk
update:	2015-9-8
desc:兑换活动
]]--
local exchangeACT_cfg=exchangeACT_cfg

exchangeACT =  Activitymodule:new()
exchangeACT:Init(ActIndex.exchange)
ActivityRegister(exchangeACT)
exchangeActData = exchangeACT:LoadData()	--玩家的兑换活动数据

--获取玩家兑换数据
function exchangeACT:GetData(sid) 
		if exchangeActData[sid] == nil then
			exchangeActData[sid] = 
			{--[[
					[1]=1,  --兑换次数
					[2]=2,
				]]
			}
		end
	return exchangeActData[sid]
end

--兑换物品 itype=1为取兑换数据 ,2兑换道具;Index 第几个,num 兑换几次
function exchangeACT_getAwards(sid,itype, Index,num)
look ("exchangeACT_getAwards")
look(sid)
look(itype)
look(Index)
look(num)
	local actmodule = ActivityGetmodulebyIndex(g_ActivifyConfig[ActIndex.exchange].ActivityID)  --自己的活动ID，可以定义为枚举方便识别
	if actmodule == nil then return end
	local res    -- res=1 成功,2次数不足,3需要物品不足,4活动未开启
	--判断活动是否开启
	if actmodule:GetActivityEnable()==false then
			look("exchangeACT_getAwards  date error")
			res=4
			CI_exchangeActRes(res,Index,0) 
		return
	end
	local pActData = exchangeACT:GetData(sid)
	
	if itype==1 then 
		local getMsg ={}
		for i = 1, #exchangeACT_cfg do
			getMsg[i]=pActData[i] or 0
		end
		look(11111)
		look(getMsg)
		CI_exchangeActSendData(getMsg)
		return 
	end
	
	
	local vipLv=SI_vip_getlv(sid)
	if exchangeACT_cfg[Index]==nil or num<1 then return  end
	--次数判断
	if exchangeACT_cfg[Index].vipTime[vipLv+1] <( pActData[Index] or 0)+num then
		res=2
		CI_exchangeActRes(res,Index,pActData[Index]) 
		return 
	end
	
	--需要物品判断
	for k, v in pairs(exchangeACT_cfg[Index].need) do 
		if -1==CI_CheckGoods_SG(v[1], v[2], v[3]*num) then
			res=3
			CI_exchangeActRes(res,Index,0) 
			return
		end
	end  
	
	--扣物品
	for k, v in pairs(exchangeACT_cfg[Index].need) do 
		CI_DecGoods_SG(v[1], v[2], v[3]*num, GoodsWay.exchangeACT)
	end  
	--给物品
	for k, v in pairs(exchangeACT_cfg[Index].gain) do      
		CI_AddGoods_SG(v[1], v[2], v[3]*num, GoodsWay.exchangeACT)
	end  
	pActData[Index] = (pActData[Index]  or 0) +num 
	
	res=1
	CI_exchangeActRes(res,Index,pActData[Index])
	actmodule:SaveData(exchangeActData)
end





