TaskTable = {}
dofile("XYD3Script\\Task\\任务奖励.lua")
--dofile("XYD3Script\\Task\\任务奖励装备.lua")
dofile("XYD3Script\\Task\\TaskEveryDay.lua")
dofile("XYD3Script\\Task\\弑魂1-10级Task.lua")
dofile("XYD3Script\\Task\\TaskConfig.lua")
--dofile("XYD3Script\\Task\\少林师门任务Task.lua")
--dofile("XYD3Script\\Task\\五岳师门任务Task.lua")
--dofile("XYD3Script\\Task\\日月师门任务Task.lua")
--dofile("XYD3Script\\Task\\蜀山师门任务Task.lua")
--dofile("XYD3Script\\Task\\侠客任务Task.lua")
--dofile("XYD3Script\\Task\\日常寻找任务Task.lua")
--dofile("XYD3Script\\Task\\日常采集Task.lua")
--dofile("XYD3Script\\Task\\任务寻路Server.lua")

TaskFromNpc   = {}		-- NPC和NPC所挂载的任务的映射表
TaskToNpc     = {}		-- NPC和NPC所能交任务的映射表
TaskTalkInfo  = {}		-- NPC和要和他对话的任务列表
TaskGiveInfo  = {}		-- NPC和要给他东西的任务列表
TaskGetInfo   = {}      -- NPC和NPC所要给道具的映射表

-- 旗标类型配置表
TaskFlagTable =
{
	item  	= 1,		-- 物品需求
	kill  	= 2,		-- 杀怪
	talk  	= 3,		-- 对话
	give  	= 4,		-- 给物品
	get  	= 5,		-- 获取物品
	useitem = 6,		-- 使用道具
	map 	= 7,		-- 跑地图
	scene 	= 8,		-- 关卡
	addnew  = 9,		--新增任务
	empty	= 100,		-- 空旗标
}

-- 旗标新增类型配置表
TaskNewFlagTable =
{
	TASK_EINTENSIFY = 0 , --装备强化
	TASK_EJDING = 1, -- //装备鉴定
	TASK_ERISE = 2,-- //装备升星
	TASK_EKEYIN = 3 , --//装备刻印
	TASK_EQUALITY = 4 ,-- //装备升阶
	TASK_XINYANG = 5, --//信仰任务
	TASK_TRANSFORMERS = 6,--//变身任务
	TASK_SKILL = 7, --//技能任务 技能升级
	TASK_SCENE = 8 ,--//关卡完成次数
}




-- 遍历任务表，填充NPC任务挂载信息
function InitNpcTaskInfo()
	for k, v in pairs(TaskTable) do
		local fromNpc = v.AcceptNpc
		local toNpc   = v.HandoverNpc

		if (TaskFromNpc[fromNpc] == nil) then
			TaskFromNpc[fromNpc] = {}
		end
		local fromCount = #TaskFromNpc[fromNpc]
		TaskFromNpc[fromNpc][fromCount+1] = k

		if (TaskToNpc[toNpc] == nil) then
			TaskToNpc[toNpc] = {}
		end
		local toCount = #TaskToNpc[toNpc]
		TaskToNpc[toNpc][toCount+1] = k

		if (v.CompleteCondition.talk ~= nil) then
			for i, j in pairs(v.CompleteCondition.talk) do
				if (TaskTalkInfo[j[1]] == nil) then
					TaskTalkInfo[j[1]] = {}
				end

				local talkCount = #TaskTalkInfo[j[1]]
				TaskTalkInfo[j[1]][talkCount+1] = k
			end
		end

		if (v.CompleteCondition.give ~= nil) then
			for i, j in pairs(v.CompleteCondition.give) do
				if (TaskGiveInfo[j[1]] == nil) then
					TaskGiveInfo[j[1]] = {}
				end

				local giveCount = #TaskGiveInfo[j[1]]

				local alreadyhas = false
				for i, j in pairs(TaskGiveInfo[j[1]]) do
					if (j == k) then
						alreadyhas = true
						break
					end
				end

				if (alreadyhas ~= true) then
					TaskGiveInfo[j[1]][giveCount+1] = k
				end
			end
		end

		if (v.CompleteCondition.get ~= nil) then
			for i, j in pairs(v.CompleteCondition.get) do
				if (TaskGetInfo[j[1]] == nil) then
					TaskGetInfo[j[1]] = {}
				end

				local getCount = #TaskGetInfo[j[1]]

				local alreadyhas = false
				for i, j in pairs(TaskGetInfo[j[1]]) do
					if (j == k) then
						alreadyhas = true
						break
					end
				end

				if (alreadyhas ~= true) then
					TaskGetInfo[j[1]][getCount+1] = k
				end
			end
		end
	end
end

InitNpcTaskInfo()


function printtask(index)
	printtable(TaskTable[index])
end

dofile("XYD3Script\\Task\\TaskUtility.lua")

