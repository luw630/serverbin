--[[
file:	MissionData.lua
author:	Jonson
update:	2015-06-19
desc:萌斗三国的任务相关数据存储
]]--

local MissionType = {
	MonthCard = 0,	--月卡任务
	Sweep = 1,		--扫荡令任务
	Lunch = 2,		--午餐任务
	Dinner = 3,		--晚餐任务
	Supper = 4,		--夜宵任务
	Duplicate = 5,	--副本任务
	EliteDuplicate = 6,--精英故事副本任务
	TreasureHunting = 7,--秘境寻宝副本任务
	LeagueOfLegends = 8,--将神传说副本任务
	Arena = 9,		--练武场副本任务
	SkillUpgrade = 10,		--技能升级任务
	Forging = 11,	--锻造任务
	Blessing = 12,	--祈福任务
	Expedition = 13,	--过关斩将副本任务
}

--任务数据的差异化获取或设置选项
local MissionDataType = {
	completedTiems = 1, --获取或设置指定任务的完成次数
	visible = 2,--获取或设置指定任务的可见的状况
	accomplished = 3,--获取或设置指定任务的完成状况
}

--取得玩家的任务的相关数据
local function Mission_getdata( sid )
	if dbMgr[sid]==nil or  dbMgr[sid].data==nil then 
		return
	end
	if dbMgr[sid].data['mission_data'] == nil then --初始化任务的lua层数据
		--个分位、十分位表示任务的完成次数；百分位表示任务是否可见；千分位表示任务是否已经完成；万分位及其以上为任务的ID
		dbMgr[sid].data['mission_data'] = {}
		dbMgr[sid].data['mission_data'][50] = 500100
		dbMgr[sid].data['mission_data'][51] = 510100
		dbMgr[sid].data['mission_data'][52] = 520100
		dbMgr[sid].data['mission_data'][53] = 530100
		dbMgr[sid].data['mission_data'][54] = 540100
		dbMgr[sid].data['mission_data'][55] = 550100
		dbMgr[sid].data['mission_data'][56] = 560100
		dbMgr[sid].data['mission_data'][57] = 570100
		dbMgr[sid].data['mission_data'][58] = 580100
		dbMgr[sid].data['mission_data'][59] = 590100
		dbMgr[sid].data['mission_data'][60] = 600100
		dbMgr[sid].data['mission_data'][61] = 610100
		dbMgr[sid].data['mission_data'][62] = 620100
		dbMgr[sid].data['mission_data'][63] = 630100
		dbMgr[sid].data['mission_data'][64] = 640000--暂时关闭该任务
	end
	return dbMgr[sid].data['mission_data']
end

--改变指定的任务的数据中的某一类值
local function SetSpecificMissionData(datas, missionID, missionDataType, data)
	--要设置的数据的位数
	if missionDataType == MissionDataType.completedTiems then
		--因为任务的完成次数占位为个分位，十分位，故在此特别考虑
		local tempData1, tempData2 = math.modf(datas[missionID] / 100)
		datas[missionID] = tempData1 * 100 + data
	else
		local datasit = math.pow(10, missionDataType)
		local tempData1, tempData2 = math.modf(datas[missionID] / datasit)
		tempData1 = math.floor(tempData1 / 10) * 10
		datas[missionID] = (tempData1 + data) * datasit + tempData2 * datasit
	end
end

--任务是否是可操作的
local function MissionOperable(sid, missionDatas, missionID)
	--判断该任务是否可见
	local datasit = math.pow(10, MissionDataType.visible)--要取的数据的位数
	--获得截取掉某一位后面的数据后的数据
	local tempData = math.floor(missionDatas / datasit)
	tempData = tempData % 10
	if tempData == 0 then
		return false
	end
	
	--判断该任务是否已经完成
	datasit = math.pow(10, MissionDataType.accomplished)
	tempData = math.floor(missionDatas / datasit)
	tempData = tempData % 10
	if tempData ~= 0 then
		return false
	end
	
	--如果不是月卡会员，则返回false
	if missionID == 50 and not IsMonthlyMem(sid) then
		return false
	end
	
	return true
end

--missionDataType表示获取任务的全部的相关数据
function GetMissionData(sid, missionID, missionDataType)
	local pdata = Mission_getdata(sid)
	if pdata == nil then 
		return 
	end
	
	--获取指定的任务数据
	local missionDatas = pdata[missionID]
	if (missionDatas == nil) then
		return
	end

	--要取的数据的位数
	local datasit = math.pow(10, missionDataType)
	--获得截取掉某一位后面的数据后的数据
	local tempData = math.floor(missionDatas / datasit)
	--返回要获得的数据
	return tempData % 10
end

--missionDataType表示获取任务的某一项具体的数据，设置指定任务的某一项的数据
function SetMissionData(sid, missionID, missionDataType, data)
	local pdata = Mission_getdata(sid)
	if pdata == nil then 
		return 
	end
	
	--获取指定的任务数据
	if (pdata[missionID] == nil) then
		return
	end
	
	SetSpecificMissionData(pdata, missionID, missionDataType, data)
end

--屏蔽掉某一个任务
function ShieldingMission(sid, missionID)
	local pdata = Mission_getdata(sid)
	if pdata == nil then 
		return 
	end
	
	--获取指定的任务数据
	if (pdata[missionID] == nil) then
		return
	end
	
	--直接这样屏蔽掉，不显示，没完成，没有完成次数
	pdata[missionID] = missionID * 10000
end

--开关月卡相关的任务（现在月卡的任务的ID为50）
function SwitchMounthCardMission(sid, accessible, sendMsg)
	local pdata = Mission_getdata(sid)
	if pdata == nil then 
		return 
	end
	
	--获取指定的任务数据
	if (pdata[50] == nil) then
		return
	end
	
	if accessible then
		--判断任务是否已经完成，完成了的话，直接退出，不然会“重置”
		local tempData = pdata[50] % 10000
		if tempData >= 1000 then
			return
		end
		--加101是指任务可见、任务完成次数为1
		pdata[50] = 50 * 10000 + 101
		if sendMsg then
			CI_UpdateMissionState(sid, 50, true, 1)
		end
	else
		--直接这样屏蔽掉，不显示，没完成，没有完成次数
		pdata[50] = 50 * 10000
		if sendMsg then
			CI_UpdateMissionState(sid, 50, false, 0)
		end
	end
end

--设置任务的完成次数
function SetMissionCompletedTimes(sid, missionID, times, maxAccomplishedTimes)
	local pdata = Mission_getdata(sid)
	if pdata == nil then 
		return 0
	end
	
	local missionDatas = pdata[missionID]
	if (missionDatas == nil) then
		return 0
	end

	--判断任务是否可以操作
	if MissionOperable(sid, missionDatas) == false then
		return 0
	end
	
	--再判断完成次数是否已经满了
	local tempData = missionDatas % 100
	if tempData >= maxAccomplishedTimes then
		return 0
	end

	times = math.min(times + tempData, maxAccomplishedTimes)
	SetSpecificMissionData(pdata, missionID, MissionDataType.completedTiems, times)
	return times
end

--完成某一项任务
function SetMissionAccompulished(sid, missionID, times)
	local pdata = Mission_getdata(sid)
	if pdata == nil then 
		return 0
	end
	
	local missionDatas = pdata[missionID]
	if (missionDatas == nil) then
		return 0
	end
	
	--判断任务是否可以操作
	if MissionOperable(sid, missionDatas, missionID) == false then
		return 0
	end
	
	--判断完成次数是否已经满了
	local tempData = missionDatas % 100
	if tempData < times then
		return 0
	end
	
	--设置某一项任务已经完成
	SetSpecificMissionData(pdata, missionID, MissionDataType.accomplished, 1)
	return 1
end

--关闭所有的体力礼包任务
function CloseTimeEnduranceMission(sid)
	local pdata = Mission_getdata(sid)
	if pdata == nil then 
		return 
	end
	
	--开始遍历所有的体力礼包任务，将其“关闭掉”
	for i = 52, 54 do
		if pdata[i] ~= nil then
			SetSpecificMissionData(pdata, i, MissionDataType.visible, 0)
		end
	end
end

--重置任务数据
function ResetMission(sid)
	local pdata = Mission_getdata(sid)
	if pdata == nil then 
		return 
	end
	
	pdata[50] = 500100
	pdata[51] = 510100
	pdata[52] = 520100
	pdata[53] = 530100
	pdata[54] = 540100
	pdata[55] = 550100
	pdata[56] = 560100
	pdata[57] = 570100
	pdata[58] = 580100
	pdata[59] = 590100
	pdata[60] = 600100
	pdata[61] = 610100
	pdata[62] = 620100
	pdata[63] = 630100
	pdata[64] = 640000--暂时关闭该任务
	
	--判断是否是月卡用户，是月卡用户就激活对应的月卡任务
	if not IsMonthlyMem(sid) then
		SwitchMounthCardMission(sid,false)
	else
		SwitchMounthCardMission(sid,true)
	end
end

--将玩家的任务数据同步到客户端
function SynMissionDataToClient(sid)
	--判断是否是月卡用户，是月卡用户就激活对应的月卡任务
	if not IsMonthlyMem(sid) then
		SwitchMounthCardMission(sid,false)
	else
		SwitchMounthCardMission(sid,true)
	end
	
	CI_SynMissionData(Mission_getdata(sid))
end