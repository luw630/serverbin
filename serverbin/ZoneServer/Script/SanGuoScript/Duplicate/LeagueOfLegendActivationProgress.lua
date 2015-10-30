--[[
file:	LeagueOfLegendActivationConfig.lua
author:	Jonson
update:	2015-04-14
desc:三国将神传说副本的激活逻辑处理
]]--

local _activeDateConfig = activeDateConfig
--取将神传说激活模块的玩家相关数据
local function LOLActivation_getdata( sid )
	if dbMgr[sid]==nil or  dbMgr[sid].data==nil then 
		return
	end
	if dbMgr[sid].data['lolactive']==nil then --初始化将神传说副本开放的功能数据
		dbMgr[sid].data['lolactive']={
			[1]=700001,--开启神工鬼力副本
			[2]=700002,--开启智勇双全副本
			[3]=700003,--开启身手不凡副本
		}
	end
	return dbMgr[sid].data['lolactive']
end

--更新最新的开放关卡数据
local function LOLActivation(pdata)
	if pdata == nil then return end
	
	local curTime = GetServerTime()
	local dt = os.date("*t", curTime)
	
	local tempTable
	--暂时为凌晨5点更新将神传说副本
	if dt.hour < 5 then
		--应该为前一天的开放配置
		curTime = curTime - 86400
		dt = os.date("*t", curTime)
	end
	--获取当前的开放副本的配置
	tempTable = _activeDateConfig[dt.wday]
	--修改玩家的数据
	pdata[1] = tempTable[1] or 0
	pdata[2] = tempTable[2] or 0
	pdata[3] = tempTable[3] or 0
end

--第一次登陆的时候讲开放信息传到客户端
function LOLActivation_firstlogin(sid,dataTb,index)
	local pdata = LOLActivation_getdata( sid )	
	if pdata == nil then
		return
	end
	
	--更新下今天的开放数据
	LOLActivation(pdata)
	CI_ActiveLeagueOfLegendDuplicate(pdata)
	
	for i=1,3 do
		if pdata[i] == nil then
			dataTb[index + i - 1] = 0 --不足的填0
		else
			dataTb[index + i - 1] = pdata[i]
		end
	end
	return index+3 --下个位置从4开始
end

--判断今天可以开启那些副本并将相关信息同步到客户端
function SI_JudgeLOLActiveState(sid)
	local pdata = LOLActivation_getdata( sid )
	if pdata == nil then
		return
	end
	
	--更新下今天的开放数据
	LOLActivation(pdata)
	
	--激活相关的将神传说副本，并视情况将激活的信息发送到客户端（有C++端代码决定）
	CI_ActiveLeagueOfLegendDuplicate(pdata)
end