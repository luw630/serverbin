--[[
file:	Activity_expense_back.lua
author:	wk
update:	2015-11-5
desc:消费返还活动
]]--
local expense_backMsg=msgh_s2c_def[s2c_msg.act][1] 
local  expense_backMsg_res=msgh_s2c_def[s2c_msg.act][2] --res=1 重置,2已领取,3消费金额不足,4活动未开启
local expense_backActConfig=expense_backActConfig
local g_ActivifyConfig=g_ActivifyConfig
local _isonline = IsOnline

local backNum=0.1
local _ceil=math.ceil

expense_backACT =  Activitymodule:new()
expense_backACT:Init(ActIndex.expense_back)
ActivityRegister(expense_backACT)
expense_backActData = expense_backACT:LoadData()	--玩家的消费返还活动数据

--获取玩家消费返还活动数据
function expense_backACT:GetData(sid) 
		if expense_backActData[sid] == nil then
			expense_backActData[sid] = 
			{--[[
					"expense_back"=110, --活动期间消费总额
				]]
			}
		end
	return expense_backActData[sid]
end

--登陆数据同步
function  expense_backACT_online(sid)
	local actmodule = ActivityGetmodulebyIndex(g_ActivifyConfig[ActIndex.expense_back].ActivityID)  --自己的活动ID，可以定义为枚举方便识别
	if actmodule == nil then return end
	local pActData = expense_backACT:GetData(sid)
	SendLuaMsg(0,{ids=expense_backMsg,pdata=pActData})
end
--消费加消费数据
function expense_backACT_add(sid,num)
	local actmodule = ActivityGetmodulebyIndex(g_ActivifyConfig[ActIndex.expense_back].ActivityID)  --自己的活动ID，可以定义为枚举方便识别
	if actmodule == nil then return end
	local pActData = expense_backACT:GetData(sid)
	pActData.expense_back =(pActData.expense_back or 0) +num
end


--当活动关闭时   活动结束发放邮件
function expense_backACT:OnActivityClosed(actParam) 
	if expense_backActData.mark then 
		look("expense_backACT:OnActivityClosed(actParam)   mark==true  ")
		return 
	end
	
	for k,v in pairs(expense_backActData) do
		if type(v) == type({}) then
			CI_expense_backMail(k,_ceil((v.expense_back or 0)*backNum))
			CI_expense_backMail[k]=nil
		end
	end
	expense_backActData.mark=true
	
end



