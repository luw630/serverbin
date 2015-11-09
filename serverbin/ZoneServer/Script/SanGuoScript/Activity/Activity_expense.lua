--[[
file:	Activity_expense.lua
author:	wk
update:	2015-11-4
desc:消费领奖活动
]]--
local expenseMsg=msgh_s2c_def[s2c_msg.act][1] 
local  expenseMsg_res=msgh_s2c_def[s2c_msg.act][2] --res=1 重置,2已领取,3消费金额不足,4活动未开启
local expenseActConfig=expenseActConfig
local g_ActivifyConfig=g_ActivifyConfig
local _isonline = IsOnline

expenseACT =  Activitymodule:new()
expenseACT:Init(ActIndex.expense)
ActivityRegister(expenseACT)
expenseActData = expenseACT:LoadData()	--玩家的消费领奖活动数据

--获取玩家消费领奖活动数据
function expenseACT:GetData(sid) 
		if expenseActData[sid] == nil then
			expenseActData[sid] = 
			{--[[
					"expense"=110, --活动期间消费总额
					[1]=1,  --领奖次数
					[2]=2,
				]]
			}
		end
	return expenseActData[sid]
end

--登陆数据同步
function  expenseACT_online(sid)
	local actmodule = ActivityGetmodulebyIndex(g_ActivifyConfig[ActIndex.expense].ActivityID)  --自己的活动ID，可以定义为枚举方便识别
	if actmodule == nil then return end
	local pActData = expenseACT:GetData(sid)
	SendLuaMsg(0,{ids=expenseMsg,pdata=pActData})
end
--消费加消费数据
function expenseACT_add(sid,num)
	local actmodule = ActivityGetmodulebyIndex(g_ActivifyConfig[ActIndex.expense].ActivityID)  --自己的活动ID，可以定义为枚举方便识别
	if actmodule == nil then return end
	local pActData = expenseACT:GetData(sid)
	pActData.expense =(pActData.expense or 0) + num
end

--领奖;Index 第几个
function expenseACT_getAwards(sid, Index)
	local actmodule = ActivityGetmodulebyIndex(g_ActivifyConfig[ActIndex.expense].ActivityID)  --自己的活动ID，可以定义为枚举方便识别
	if actmodule == nil then 
		SendLuaMsg(k,{ids=expenseMsg_res,res=4})
		return 
	end
	--判断活动是否开启
	if actmodule:GetActivityEnable()==false then
			look("expenseACT_getAwards  date error")
			SendLuaMsg(k,{ids=expenseMsg_res,res=4})
		return
	end
	local pActData = expenseACT:GetData(sid)

	if expenseActConfig[Index]==nil  then return  end
	--次数判断
	if 0 <( pActData[Index] or 0) then
		SendLuaMsg(k,{ids=expenseMsg_res,res=3})
		return 
	end
	
	--需求判断
	if (pActData.expense or 0)<expenseActConfig[Index].need then
		look("pActData.expense  not enough ")
		SendLuaMsg(k,{ids=expenseMsg_res,res=2})
		return
	end

	--给物品
	for k, v in pairs(expenseActConfig[Index].gain) do      
		CI_AddGoods_SG(v[1], v[2], v[3], GoodsWay.expenseACT)
	end  
	pActData[Index] = (pActData[Index]  or 0) +1 
	
	SendLuaMsg(0,{ids=expenseMsg,pdata=pActData})
end

--每日重置
function ResetExpenseData()
		for k,v in pairs(expenseActData) do
			if type(v) == type({}) then
				expenseActData[k]=nil
				if _isonline(k) then
					SendLuaMsg(k,{ids=expenseMsg_res,res=1})
				end
			end
		end
end


