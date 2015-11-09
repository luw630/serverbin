--[[
file:	Activity_DoubleDrop.lua
author:	lpd
update:	2015-11-06
desc:加倍掉落
]]--

DropActivity =  Activitymodule:new()
DropActivity:Init(ActIndex.doubleDrop)
ActivityRegister(DropActivity)
DropActData = DropActivity:LoadData()	--玩家加倍掉落数据

local DropActConfig = --掉落配置
{
	rate = 2,--掉率 目前掉率为2倍
}

function GetDropActRate()--获取掉落倍率
 	if not DropActivity.ActivityEnable then
		return 1
	end

	return DropActConfig.rate 
 end 



