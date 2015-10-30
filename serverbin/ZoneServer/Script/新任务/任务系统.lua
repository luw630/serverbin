NPC_OnClick =
{
	[7089]=OnClick7089,
	[7090]=OnClick7090,
	[4]=NewXYDbuy,
	[7092]=OnClick7092,
	[7093]=OnClick7093
}


function IsTaskNpc(npcid)
	return 任务NPC配置表[npcid] ~= nil
end

-- 任务NPC点击的统一处理函数
function OnClick30000()
	rfalse("OnClick30000...")
	local npcid, monid, playerid = GetObjectUniqueId()
	npcid = npcid - 100000

	if npcid>=300000 and npcid < 400000 then
		rfalse("OnClickTestCopyScene")
		OnClickTestCopyScene( npcid-300000 )
		return
	elseif npcid>=100000 and npcid<200000 then -- 通常这里点击的是场景上的物品
		OnClickItem(playerid,npcid)
		return
	elseif(NPC_OnClick[npcid] ~= nil) then
		NPC_OnClick[npcid]()
		return
	end

	--防刷任务,不重复生成任务
	local temp = GetTaskTemp( playerid )

	local ringtaskid
	local ok, ringId, taskConf = ringCouldAccept( npcid, taskData)
	if ok  then
		ringtaskid = temp.ringtaskid or ringRandomTask( ringId, taskConf, taskData)
		if ringtaskid  and ringtaskid~=temp.ringtaskid then
			temp.ringtaskid = ringtaskid
			rfalse("生成ringttakid: " .. ringtaskid)
		end
	end

	SendLuaMsg( 0, { ids = {1,1}, npcid = npcid, ringid=ringtaskid }, 9 )
end

-- 通过玩家SID获取该玩家对应的任务数据表！
function GetDBTaskData( playerid )
	if( playerid == nil or playerid == 0 )then
		return
	end
	if dbMgr[ playerid ].data == nil then
		dbMgr[ playerid ].data = {}
	end
	if dbMgr[ playerid ].data.taskData == nil then
		dbMgr[ playerid ].data.taskData = { __x = 2048 }
	end
	if dbMgr[ playerid ].data.taskData.completed == nil then
		dbMgr[ playerid ].data.taskData.completed = {}
	end
	if dbMgr[ playerid ].data.taskData.current == nil then
		dbMgr[ playerid ].data.taskData.current = {}
	end
	return dbMgr[ playerid ].data.taskData
end

function GetCurDBTaskData()
	return GetDBTaskData(GetCurPlayerID())
end

function GetTaskTemp( playerid )
	if( playerid == nil or playerid == 0 )then
		return
	end
	if dbMgr[ playerid ].temp == nil then
		dbMgr[ playerid ].temp = {}
	end
	return dbMgr[ playerid ].temp
end

function GetCurTaskTemp()
	return GetTaskTemp(GetCurPlayerID())
end

--taskid 一般为选填,只对跑环任务有意义
function SendStoryData(storyid, npcid, taskid)
	--[[
	if nil==npcname and nil~=taskid then
		local taskconf = GetTaskConfig(taskid, GetCurDBTaskData())
		if nil~=taskconf and nil~=taskconf.接任务npcid then
			npcname = 任务NPC配置表[taskconf.接任务npcid].NpcCreate.name
		end
	end
	if nil~=npcname	then
		剧情表[storyid].npcName = npcname
	end
	--]]

	--为跑环任务构造 task选项
	rfalse("storyid: " .. storyid)
	local story = 剧情表[storyid]

	--记录cg id
	GetCurTaskTemp().cgid = nil
	function _recordcg()
		for _,v in pairs(story) do
			if type({})==type(v) then
				if nil~=v.cg then
					GetCurTaskTemp().cgid = v.cg
					break
				end
			end
		end
	end
	_recordcg()

	if nil~=taskid then
	    ReBuildRingStory( story, taskid)
	end

	if nil~= story then
		GetCurTaskTemp().storyid = storyid
		GetCurTaskTemp().story = story
		SendLuaMsg( 0, { ids = {1,2}, data = story, npcid = npcid }, 9 )
	end
end

function 触发剧情( playerid, npcid, taskid, index, tp )
	-- 通知客户端触发剧情
	local taskData = GetDBTaskData( playerid )
	local taskTemp = GetTaskTemp(playerid)
	local storyid = nil

	rfalse("触发剧情")
	if taskid ~=nil  then
		local taskInfo = GetTaskConfig( taskid, taskData)
		if nil==taskInfo then
			return
		end

		if tp == 1 then
			storyid = taskInfo.接任务剧情id

			--跑环任务合法新验证
			if IsRingTask(taskid) and taskTemp.ringtaskid~=taskid  then
				return
			end
		elseif tp == 2 then
			if npcid == taskInfo.交任务npcid and taskInfo.交任务未完成剧情id~=nil then
				storyid = taskInfo.交任务未完成剧情id
			elseif npcid == taskInfo.接任务npcid and taskInfo.接任务未完成剧情id~=nil then
				storyid = taskInfo.接任务未完成剧情id
				rfalse("接任务,storyid="..tostring(storyid).." taskname="..tostring(taskInfo.任务名称).." taskid" .. taskid )
			end
		end
	elseif tp == 3 then
		if TableHasKeys(任务NPC配置表, {npcid, "NpcFunction", index}) then
			local FunItem = 任务NPC配置表[npcid].NpcFunction[index]
			if type(FunItem[3]) == type({}) then
				local ok = 通用条件判断表.CheckConditions(FunItem[3], saveTaskData, 0)
				if ok == 1 then
					storyid = FunItem[1]
				end
			else
				storyid = FunItem[1]
			end
		end
	end
	
	if storyid ~= nil then
		rfalse( "PlayerID: " .. playerid )
		rfalse( "接任务剧情id: " .. tostring(storyid))
		SendStoryData(storyid, npcid, taskid)

		taskTemp.storyid = storyid
		taskTemp.npcid = npcid
	end
end

function 接受任务( playerid, npcid, taskid, nocheck )
	rfalse("接受任务,taskid="..tostring(taskid))

	local taskData = GetDBTaskData( playerid )
	local taskInfo = GetTaskConfig( taskid, taskData)
	rfalse("playerid=="..tostring(playerid).." taskid="..tostring(taskid))

	if taskInfo ~= nil then
		if taskData.current[taskid] == nil and taskData.completed[taskid] == nil then
			--检查是否满足接任务的条件
			if nil==nocheck then
				local ringid
				if IsRingTask(taskid) then
					ringid = GetRingSubID(taskid)
					ok = ringCouldAccept(npcid, taskData)
					if not ok then
						return
					end
				else
					local failInfo = nil
					local actionIndex = nil
					if ( taskInfo.接受条件 == nil ) then
						rfalse( "接受条件 == nil" )
					else
						actionIndex, failInfo = 通用条件判断表.CheckConditions(
							taskInfo.接受条件, taskData, taskid )
						if actionIndex ~= 1 then
							rfalse( "接受条件失败：" )
							return
						end
					end
				end
			end

			taskData.current[taskid] = {}
			-- chenj 任务追踪测试
			taskData.current[taskid].track = 1
			taskData.current[taskid].start = GetServerTime()

			-- 任务所需的临时数据的注册
			-- 打怪的数据注册！
			rfalse( "开始检查杀怪信息" .. tostring(taskid) )
			MarkKillInfo( taskData, taskid )

			if taskInfo.接受事件 ~= nil then
				任务事件表.OnEvent(taskInfo.接受事件)
			end

			if IsRingTask(taskid) then	--记录开始时间
				ringAccept(taskid, taskData )
			end

			--发送接任务消息
			SendLuaMsg(0, { ids = {1,4}, data = {accept = true, id = taskid} },9 )
		end
	end
end

function 交任务( playerid, npcid, taskid, goodid )
	local taskData = GetDBTaskData( playerid )
	local taskInfo = GetTaskConfig(taskid, taskData)

	if( taskInfo == nil or taskData.current[taskid] == nil ) then
		return
	end

	if (taskData.current[taskid].state ~= nil) then
		taskData.current[taskid] = nil
		taskData.completed[taskid] = true
		--SendLuaMsg( 0, { ids = {1,2}, data = 剧情表[ taskInfo.交任务剧情id ],npcid=npcid }, 9 )
		SendStoryData(taskInfo.交任务剧情id, npcid, taskid )
		return
	end

	--检查是否满足接任务的条件
	if ( taskInfo.完成条件 == nil ) then
		rfalse( "完成条件 == nil" )
		return
	end

	local failInfo
	local actionIndex

	if IsRingTask(taskid) then
		local ok = ringCouldComplted(taskid, taskData)
		if ok then
			actionIndex=1
		end
	else
		actionIndex, failInfo = 通用条件判断表.CheckAndDelete( taskInfo.完成条件, taskData, taskid )
	end

	if actionIndex == nil or actionIndex ~= 1 then
		rfalse( "完成条件失败：actionIndex = " .. tostring(actionIndex ) )
		return
	elseif 通用条件判断表.CheckTimeout(taskInfo, taskid,taskData) then
		rfalse("完成任务,taskid="..tostring(taskid))

		--奖励多个物品这里可能会出现一些问题
		if not award(playerid,taskData,taskid, goodid) then
			SendTipsMsg(1,'背包已满，不能完成任务')
			return
		end


		taskData.current[taskid] = nil

		if TableHasKeys(taskInfo, {"接受条件", "refresh"} ) then -- 日常任务
			if taskData.refresh==nil then
				taskData.refresh = {}
			end
			taskData.refresh[taskid] = GetServerTime()
		elseif IsRingTask(taskid) then
			ringSubmit(taskid, taskData, playerid)
		elseif not IsReeligible(taskid) then
			-- 完成任务
			taskData.completed[taskid] = true
		end

		--发送交任务消息
		SendLuaMsg( 0, { ids = {1,4}, data = {accept = false, id = taskid, good = goodid } },9)

		--发送剧情消息
		local story = 剧情表[ taskInfo.交任务剧情id ]
		-- 跑环任务需要预处理
		if 预处理剧情( playerid, story, taskData, npcid) then
			--SendLuaMsg( 0, { ids = {1,2}, data = story, npcid=npcid }, 9 )
			SendStoryData(taskInfo.交任务剧情id, npcid, taskid)
        end
	else
		rfalse(" 任务 " .. taskid .. " 超时, 放弃任务!!!")
		taskData.current[taskid] = nil
	end
end

function 放弃任务( playerid, taskid )
	local taskData = GetDBTaskData( playerid )
	if taskid and TableHasKeys(taskData, {"current", taskid} ) then
		taskData.current[taskid] = nil

		if IsRingTask(taskid) then
			ringDropTask(taskid, taskData)
		end
	end
end

function 完成子任务( playerid, npcid, taskid,opkey,opvalue )
	local mainid,subid = GetSubID(taskid)
	local taskData = GetDBTaskData( playerid )
	local taskInfo = GetTaskConfig(taskid, taskData)

	if taskInfo == nil or taskData.current == nil	or taskData.current[taskid] == nil then
		return
	end

	if taskData.completed[taskid] ~= nil then
		return
	end

	if ( taskInfo.完成条件 == nil ) then
		rfalse( "完成条件 == nil" )
		return
	end

	local failInfo = nil
	local actionIndex = nil

	if not TableHasKeys(taskInfo, {"完成条件",opkey} ) then
		return
	end
	if 通用条件判断表[opkey]==nil then
	    return
	end

	actionIndex, failInfo = 通用条件判断表[opkey](taskInfo.完成条件[opkey], taskData, taskid )
	if actionIndex ~= true then
		if __debug then
			rfalse( "检查完成条件失败：actionIndex = " .. tostring(actionIndex ) .. failInfo )
		end
		return
	end

	if opvalue == nil then
		taskData.current[taskid][opkey] = 1 -- 记录完成一个子任务
		return
	end


	if taskData.current[taskid][opkey] == nil then
		taskData.current[taskid][opkey] = {}
	end

	taskData.current[taskid][opkey][opvalue] = 1
end

--任务奖励
function award(playerid, taskData, taskid,choosegoods)
	local taskInfo = GetTaskConfig(taskid, taskData)
	local awardInfo = taskInfo.完成奖励

	if nil==awardInfo or table.empty(awardInfo) then
		return true
	end

	local ischoose = false
	if( awardInfo.giveGoods ~= nil ) then
		--奖励物品时，先把所有奖励的物品统计出来
		local addGood = {}
		if awardInfo.giveGoods.options ~= nil then
			for k,v in pairs(awardInfo.giveGoods.options) do
				if choosegoods == v[1] then
					addGood = { v[1], v[2] }
					ischoose = true
					break
				end
			end

			if not ischoose then
				return false --没有选择奖励
			end
		end

		if awardInfo.giveGoods.give ~= nil then
			for k,v in pairs(awardInfo.giveGoods.give) do
				addGood = { v[1], v[2] }
			end
		end

		--再判断是否可以添加这些物品
		if CheckAddGoods( addGood) == false then
			return false
		end

		--合格后再真的给物品
		if awardInfo.giveGoods.options ~= nil then
			for k,v in pairs(awardInfo.giveGoods.options) do
				if choosegoods == v[1] then
					GiveGoods( v[1], v[2] )
					break
				end
			end
		end

		if awardInfo.giveGoods.give ~= nil then
			for k,v in pairs(awardInfo.giveGoods.give) do
				if(GiveGoods(v[1],v[2])~=1) then
					return false
				end
			end
		end
	end

	local gexp = awardInfo.giveExp
	if(  gexp~= nil )   then
		PayThePlayer(1,gexp)
	end

	local gmoeny = awardInfo.giveMoney
	if( gmoeny ~= nil ) then
		if(GiveGoods(0,gmoeny) ~= 1) then
			return false
		end
	end

	local skill = awardInfo.skill
	if nil~=skill then
		for _,sk in pairs(skill) do
			ActiveSkill(sk[1], sk[2]);
		end
	end

	return true
end

--开启或取消任务追踪
function 任务追踪( playerid, taskid, op)
	-- op: 0 取消任务跟踪, 1 开启任务跟踪
	--rfalse("task id :" .. tostring(taskid) .. " id: " .. tostring(op) )
	local taskData = GetDBTaskData( playerid )
	if taskData and taskData.current and taskData.current[taskid] then
		if op==1 then
			taskData.current[taskid].track = 1
		elseif op==0 then
			taskData.current[taskid].track = nil
		end
	end
end

function 完成操作(playerid,npcid,taskid,opkey,opvalue)
	local mainid,subid = GetSubID(taskid)
	local taskData = GetDBTaskData( playerid )
	local taskInfo = GetTaskConfig(taskid, taskData)

	local op = taskInfo.完成条件
	if op == nil or op[opkey] == nil then
		return
	end

	rfalse("opkey=="..tostring(opkey).." opvalue="..tostring(opvalue))
	if op[opkey][opvalue] == nil then
		return
	end

	if opvalue==nil then
		rfalse("opkey111 == "..tostring(opkey))
		taskData.current[taskid][opkey] = 1
		return
	else
		rfalse("opkey222 == "..tostring(opkey))
		rfalse("opvalue222 == "..tostring(opvalue))
		if taskData.current[taskid][opkey] == nil then
			taskData.current[taskid][opkey] = {}
		end

		taskData.current[taskid][opkey][opvalue] = 1
	end

end

function PlayerInRange(region,x,y, len)
	local cx,cy, cregion = getplayercurpos()
	if cregion~=nil and region == cregion then
		if 1==len then
			return x==cx and cy==y
		else
			local half = rint( (len-1)/2)
			local left = x - half
			local top = y - half
			return cx>=left and cx<left+len and cy>=top and cy<top+len
		end
	end

	return false
end

--使用物品回调
function UseItem(playerid,goodsid)
	rfalse("使用物品回调:"..playerid.."+"..goodsid.."！老版本，Bug始作俑者！")
end

--装备物品回调
function EquipItem(playerid,equipid)
	rfalse("playerid = "..tostring(playerid).." 装备ID="..tostring(equipid))
	local taskData = GetDBTaskData( playerid )

	dbMgr.ShowTable(taskData.current,rfalse)

	for taskid,v in pairs(taskData.current) do
		if taskid ~= "" then
			local taskinfo = GetTaskConfig(taskid, taskData)
			if taskinfo.完成条件.ei ~= nil then
				if v.ei == nil then
					v.ei = {}
				end

				--[[
				local index = itemExist(taskinfo.完成条件.ei,equipid)
				if index~=0 then
					rfalse("找到装备..")
					v.ei[index] = 1
					dbMgr.ShowTable(v,rfalse)
					break
				end
				--]]

				for index, eq in pairs(taskinfo.完成条件.ei) do
					if type(eq)==type(0) then
						if eq==equipid then
							v.ei[index] = 1
							break
						end
					elseif type({}) == type(eq) then
						local flag = false
						for _, subeq in pairs(eq) do
							if subeq==equipid then
								flag = true
								v.ei[index] = 1
								break
							end
						end

						if flag then
							break
						end
					end
				end
			end
		end
	end
end

function 点击剧情(playerid, npcid, step)
	local temp = GetTaskTemp(playerid)	
	rfalse("点击剧情")
	if nil==temp.story then
		return		
	end

	if(temp.story[step] == nil or temp.story[step].onClick==nil) then
		return
	end

	_G[temp.story[step].onClick]( npcid, step )
end

function 动态场景点击剧情(playerid, step )
	local npcid = GetTaskTemp( playerid ).dynpcid
	if nil==npcid or not TableHasKeys(动态场景NPC配置, {npcid, playerid, "sel", step-1, 2}) then
		return 
	end

	local func = 动态场景NPC配置[npcid][playerid].sel[step-1][2]
	if type('')==type(func) and nil~=_G[func] then
		_G[func]()
	end
end

--标记采集子任务
function markCollectTask(npcid, taskdata)
	function _mark(taskid,index)
		if nil==taskdata.current[taskid].col then
			taskdata.current[taskid].col = {}
		end
		taskdata.current[taskid].col[index] = 1
	end

	if nil==taskdata or nil==taskdata.current then
		return
	end

	for taskid in pairs(taskdata.current) do
	    if type(taskid)==type(0) then
            local taskconf = GetTaskConfig(taskid, taskdata)
            if TableHasKeys(taskconf, {"完成条件", col}) then
                local col = taskconf.完成条件.col
                if col then
                    for k, v in pairs(col) do
                        if v==npcid then
                            _mark(taskid,k)
                        end
                    end
                end
            end
        end
	end
end

--处理跑环剧情
function ReBuildRingStory( story, taskid )
	if IsRingTask(taskid) then
		for _, v in ipairs(story) do
			if nil~=v.task and v.task[1]<0 then	--这里v.task[1]<0 不是太好
				local mainid = GetRingSubID(taskid)
				v.task[2] = taskid
			end
		end
	end
end

--接环任务
function ringAccept( taskid, taskData )
	--扣钱
	if TableHasKeys(跑环任务配置表, {ringid, "需要金钱"}) then
		local moneyNeed = 跑环任务配置表[ringid].需要金钱
		if type(moneyNeed) == TP_FUNC then
			moneyNeed = moneyNeed()
		end

		GiveGoods(0,-moneyNeed)
	end

	if nil==taskData.ring then
		taskData.ring = {}
	end
	local ring = taskData.ring
	--[[
	 ring = {
					rstart,		--环开始时间
					slevel,		--初始等级
					sring，		--起始环id
					id,			--但前任务id
					cstart,		--但前子环开始时间
					acc = {		--接任务计数
						day,	--当天
						week,	--周
						}
			}
	--]]
	local now = GetServerTime()

	ring.id = taskid				--当前环任务id

	if nil==ring.rstart then
		ring.rstart = now			--环开始时间
		ring.sring = GetRingSubID(taskid)		--	起始环id
		ring.slevel = GetPlayerData(1)	--开始等级

		--接受记次
		if nil==ring.acc then
			ring.acc = {}
		end
		ring.acc.day = (ring.acc.day or 0 ) + 1
		ring.acc.week = (ring.acc.week or 0 ) + 1
	end

	ring.cstart = now				--当前子环开始时间

	ring.refresh ={ day = now, week = now}

	rfalse("Accept ++++++++")
	dbMgr.ShowTable( os.date("*t", ring.refresh.day), rfalse)
end

--交环任务
function ringSubmit( taskid, taskData, playerid)
	--跑环任务不放入completed表,放入rings表中做记次
	local ringid = GetRingSubID(taskid)
	if nil==taskData.ring then
		taskData.ring = {}
	end

	local ring = taskData.ring

	ring.id = nil
	ring.cstart = nil

	ring.count = (ring.count or 0) +1

	--清空生成任务缓冲
	if GetTaskTemp( playerid ).ringtaskid==taskid then
		GetTaskTemp( playerid ).ringtaskid = nil
	end
end

--跑环任务 完成点击NPC操作
function 完成点击NPC操作( playerid, npcid, taskid)
	local taskdata = GetDBTaskData(playerid)
	if taskid and npcid and taskdata then
		checkClickNpcTask(taskdata, npcid)
	end
end

function checkClickNpcTask(taskdata, npcid)
	if nil==taskdata.ring then
		return
	end

	function _markTaskNpc( taskid, taskData,npcid )
		if nil==taskdata.current[taskid].npc then
			taskdata.current[taskid].npc = {}
		end
		taskdata.current[taskid].npc[npcid] = 1
	end

	if TableHasKeys( taskdata, {"ring", "id"})	then
		ringTaskClickNpc( taskdata.ring.id, taskdata, npcid,_markTaskNpc)
	end
end

--标记超时条件已完成，不在触发超时放弃任务
function markTimeoutFinished( playerid, taskid, key)
	rfalse("markTimeoutFinished: " .. taskid .. "  ".. key)

	local taskData = GetDBTaskData(playerid)
	local taskInfo = GetTaskConfig(taskid, taskData)
	if TableHasKeys(taskInfo, {"timeout", key}) and TableHasKeys(taskData, {"current", taskid}) then
		if nil==taskData.current[taskid].to then
			taskData.current[taskid].to = {}
		end
		if nil==taskData.current[taskid].to[key] then
			if 1==key then
				if 通用条件判断表.CheckConditions( taskInfo.完成条件, taskData,taskid) then
					taskData.current[taskid].to[1] = 1
				end
			elseif 通用条件判断表[key] and 通用条件判断表[key](taskInfo.完成条件[key], taskData, taskid) then
				taskData.current[taskid].to[key] = 1
			end
		end
	end
end

--对NPC使用Item的C回调函数
function OnUseItemOnNPC30000( itemid )
	local npcid, _, playerid = GetObjectUniqueId()
	npcid = npcid - 100000

	function _ComsumeItem(playerid)
		local taskdata = GetDBTaskData(playerid)
		for taskid, v in pairs(taskdata.current) do
		    if type(taskid)==type(0) then
                local taskConf = GetTaskConfig(taskid, taskdata)
                if taskConf and TableHasKeys(taskConf, {"完成条件", "nu"}) then
                    local nu = taskConf.完成条件.nu
                    for index, vv in pairs(nu) do
                        if npcid==vv[1] and itemid == vv[2] then
                            --根据配置决定是否删除itme
                            if vv[3]~=0 then
                                ---------------------------------------
                                CheckGoods(itemsid, 1, 0)
                            end
                            --标记
                            完成操作(playerid, 0, taskid, "nu", index)
                            break
                        end
                    end
                end
            end
		end
	end

	--1.扣除物品
	_ComsumeItem(playerid)

	--2.通知客服端
	rfalse("OnUseItemOnNPC30000  npcid: " .. npcid .. "  itemid: " .. itemid)
	SendLuaMsg( 0, { ids = {1,6}, npcid = npcid, item = itemid }, 9 )
end

--对Monster使用Item的C回调函数捕获
function OnCaptureMonster30000( itemid )
	local _, monid, playerid = GetObjectUniqueId()

	local currHP = GetMonsterData(6)
	local maxHP = GetMonsterData(7)

	if currHP>=maxHP*0.3 then
		--return
	end

	local mon_name = GetMonsterData(3)

	rfalse("OnCaptureMonster30000  monid: " .. monid .. "  itemid: " .. itemid .. "  name :" .. mon_name)

	--1.删除怪物
	RemoveCurrObj(1)

	--2.扣除物品,计数标记
	markAndDelCaptureMonster(playerid, itemid, mon_name)
end

function markAndDelCaptureMonster( playerid, itemid, mon_name)
	local taskdata = GetDBTaskData(playerid)

	function _incCapture(taskid, index)
		if taskdata.current[taskid].cap==nil then
			taskdata.current[taskid].cap = {}
		end

		taskdata.current[taskid].cap[index] = (taskdata.current[taskid].cap[index] or 0) + 1
	end

	function _eraseItem(conf)
	    local delit = conf[4]
	    if type({}) == type(delit) and conf[5]==type(0) then
	        delit = conf[5]
	    end

	    --默认是使用后消耗掉物品
	    if delit~=0 then
	        -------------------------
	        --删除物品
	        CheckGoods(itemid, 1, 0)
	    end
	end

	for taskid, v in pairs(taskdata.current) do
	    if type(taskid)==type(0) then
            local taskConf = GetTaskConfig(taskid, taskdata)
            if taskConf and TableHasKeys(taskConf, {"完成条件", "cap",} ) then
                for index,vv in pairs(taskConf.完成条件.cap) do
                    if itemid==vv[3] and mon_name==vv[1] then
                        _incCapture(taskid, index)

                        --根据配置决定是否删除itme
                        _eraseItem(taskConf)
                        break
                    end
                end
            end
        end
	end
end


--RPC Server调Client
function RPC( f, ...)
	if type(f)==type('') then
		if arg.n>0 then
			arg.n = nil
			SendLuaMsg( 0, { ids = {10}, f =f, arg = arg}, 9 )
		else
			SendLuaMsg( 0, { ids = {10}, f =f }, 9 )
		end
	end
end

--地图事件与 任务关联标记
function OnMapEvent30000( id )
	rfalse("OnMapEvent30000 id:" .. id)
	local region = rint(id/1000/1000)
	local x = rint(id/1000 % 1000)
	local y = rint(id%1000)

	local tasks = _fastMETable[id]
	if nil==tasks then
		return
	end
	
	local taskData = GetCurDBTaskData()
	for _, metask in pairs(tasks) do
		local taskid = metask[1]
		local index = metask[2]
		if TableHasKeys(taskData, {"current", taskid} ) then
			if nil==taskData.current[taskid].me then
				taskData.current[taskid].me = {}
			end
			taskData.current[taskid].me[index] = 1

			local taskConf = GetTaskConfig(taskid, GetCurDBTaskData())
			local me = taskConf.完成条件.me[index]
			if type(me[5])==type('') and nil~=_G[me[5]] then
				_G[me[5]]()
			end
		end		
	end
end


--NC完成回调
function OnFinishClickNpcAction(npcid)
	local npcid = npcid
	local taskData = GetCurDBTaskData()

	local taskid = GetNcInfo(npcid)[1]
	local ncindex = GetNcInfo(npcid)[2]

	if nil==taskData.current[taskid].nc then
		taskData.current[taskid].nc = {}
	end
	taskData.current[taskid].nc[ncindex] = 1

	local npc = 任务NPC配置表[npcid]
	if nil~=npc and type(npc.完成事件)==type({}) then
		callTableFuncs( npc.完成事件 )
	end	
end

--采集完成回调
function OnCollectFinish(npcid)
	local id = npcid
	local npc = 任务NPC配置表[npcid]

	function _selectOnlyOne(sels)
		local rates ={}
		local rand = rint(math.random()*100)+1
		local t = 0
		for k,v in pairs(sels) do
			t = t+v[3]
			if rand<t then
				return k,v
			end
		end
	end

	--生成给与物品列表
	local give = {}
	for _,v in ipairs(npc.product) do
		if type(v)==type(0) then	--给物品
			table.push(give, {v,1})

		elseif type(v)==type({}) then
			if type(v[1])~=type({}) then
				if 2==#v then
					table.push(give, v)
				elseif 3==#v and IN_ODDS(v[3]) then
					table.push(give, {v[1], v[2]} )
				end
			else
				local index, sel = _selectOnlyOne(v)
				if index then
					table.push(give, {sel[1], sel[2]} )
				end
			end
		elseif type(v)==type("") and nil~=_G[v] then
			_G[v]()
		end
	end

	--give 需要一个原子接口
	for _, v in ipairs( give) do
		GiveGoods( v[1], v[2] )
		rfalse("give: " .. v[1] .. " ," .. v[2])
	end

	--完成事件
	if type({}) == type(npc.完成事件) then
		callTableFuncs(npc.完成事件, npcid)
	end

	--发送采集完成消息
	--SendLuaMsg( 0, { ids = {1,5}, npcid = npcid }, 9 )
	-- mark 采集任务子项
	markCollectTask(id, GetCurDBTaskData())
end

function 点击非剧情NPC(playerid ,msg)
    local taskdata = GetCurDBTaskData()

	local npcid = msg.npcid
	local npc = 任务NPC配置表[npcid]
	if nil==npc then
		return
	end

	local state = GetNpcNcState( npcid, taskdata)
	if state==NC_CLICK then
		StartCollect(npcid, npc.action[1], npc.action[2], npc.NpcCreate.x, npc.NpcCreate.y, "OnFinishClickNpcAction")
	elseif state==NC_COLLECT then
		StartCollect(npcid, npc.action[1], npc.action[2], npc.NpcCreate.x, npc.NpcCreate.y, "OnCollectFinish" )
	end
end
