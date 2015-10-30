
function OnClickTestCopyScene(npcid)
	rfalse('on click test copy scene npc['..tostring(npcid)..']')
	if npcid == 1 then 
		-- 显示
		CS_OnProcListDisplay(npcid)
	elseif npcid == 2 then 
		-- 打开准备面板
		ret, info = CS_OnOpenCSPanel( )
		rfalse('code: '..tostring(ret)..'   '..tostring(info))
	--[[elseif npcid == 3 then
		-- 准备
		CS_OnProcReady()]]--
	elseif npcid == 4 then
		-- 取得奖励
		CS_OnProcAward()
	else
		SetMessage(80000,副本NPC[npcid].talk,0,0)
	end

end

-- 通知客户端显示可接副本任务列表
g_ListCopySceneID = {}
local function __SendListCSID( listCopySceneID )
	local sbuff = "您可以去的副本有：#"
	for k,v in pairs(listCopySceneID) do
		if v ~= nil then
			sbuff = sbuff..副本配置[v].副本名字.."#"
		else
			break
		end
	end
	sbuff = sbuff.."关闭#"
	SetMessage( MENU.打开副本界面, sbuff, 0, 0)

	--需要把 listCopySceneID 临时保存一下,方便选择副本以后查找副本编号，最后一个默认是关闭键
	local sid = GetPlayerData(17)
	g_ListCopySceneID[sid] = listCopySceneID
end

-- 过滤显示的副本ID列表
local function __FilterDisplay( playerLevel, listCopySceneID)
	local listID = {}	--显示的副本编号
	local i = 1
	for k,v in pairs(listCopySceneID) do
		if v ~= nil then
			if 副本配置[v].显示等级限制 <= playerLevel then
				local teamInfo = GetTeamInfo()
				if teamInfo == nil or 副本配置[v].最大人数 >= table.maxn(teamInfo) then
					listID[i] = v
					i = i + 1
				end
			end
		else
			break
		end
	end
	return listID
end

-- 根据npcID取得对应的NPC所带的所有副本任务ID列表
local function __GetIDListFromNPC(npcID)
	return NPC所带任务列表[npcID]
end

-- 判断是否可以准备当前副本任务
local function __OnCheckReadyCondition(condition, playerSID)
	rfalse('__OnCheckReadyCondition')

	if condition == nil or playerSID == nil then
		return false, '参数错误'
	end
	-- 判断等级 
	local level = GetPlayerData(1)
	if level < condition.等级 then
		return false, '等级不足'
	end
	
	-- 判断具体副本的准备条件
	local money = GetPlayerData(48)
	if money<condition.金钱 then
		return false,'您的金钱不足'
	end

	local rt;
	for k,v in pairs(condition.道具) do
		rt = CheckGoods(v.id,v.num,1,playerSID)
		if rt==false or rt==0 then
			return false, '您的'..v.name..'不足'
		end
	end

	return true
end

--显示队员准备信息的字符串
local function __CS_GetTeamPrepareInfo( copyScene)
	local teamPrepare = ""
	local teamInfo = GetTeamInfo()
	if teamInfo ~= nil and copyScene ~= nil then
		for i = 1, table.maxn( teamInfo), 1 do
			local name = string.format("%11s", teamInfo[i].name)
			if copyScene.PlayerSIDList[teamInfo[i].staticId] == true then
				teamPrepare = teamPrepare .. name .. "  已准备\n"
			else
				teamPrepare = teamPrepare .. name .. "  未准备\n"
			end
		end
	else
		return ""
	end
	return teamPrepare
end

-- 处理副本任务列表显示
function CS_OnProcListDisplay(npcID)

	-- 取得玩家的副本状态数据
	local sid = GetPlayerData(17)
	local playerData = CS_GetPlayerData(sid)

	-- 如果上一次的副本奖励还没领取,那么不能接受新的副本
	if playerData.Complete ~= nil then
		SendTipsMsg(1,'上一次的副本奖励还未领取')
		return false, '上一次的副本奖励还未领取'
	end

	local playerTemp = CS_GetPlayerTemp(sid)
	if playerTemp.TaskID ~= nil then
		SendTipsMsg(1,'已经领取副本任务')
		return false, '已经领取副本任务'
	end

	local teamID = GetPlayerData(12)
	local isTeamLeader = GetPlayerData(13)
	local leader = true
	if teamID ~= 0 and isTeamLeader == 0 then
		SendTipsMsg(1,'你不是队长，不能接受任务')
		return false, '非队长不能接受任务'
	end
	rfalse('准备领取副本任务')

	-- 取得玩家的SID
	local level = GetPlayerData( PlayerProperty.等级 )

	-- 从NPC处取得完整的副本任务ID列表
	local listCopySceneID = __GetIDListFromNPC(npcID)

	-- 通过过滤条件过滤掉不可见的副本任务ID
	local listCopySceneID = __FilterDisplay( level, listCopySceneID)

	-- 通知客户端显示可接副本任务列表
	local SendListCSID = __SendListCSID( listCopySceneID)

end

--[[
/*
处理副本任务准备

返回值:
true: 成功
false, xxx: 失败，xxx为错误信息
*/
--]]
function CS_OnOpenCSPanel( )

	-- 取得玩家的副本状态数据
	local sid = GetPlayerData(17)
	local playerData = CS_GetPlayerData(sid)

	-- 如果上一次的副本奖励还没领取,那么不能接受新的副本
	if playerData.Complete ~= nil then
		SendTipsMsg(1,'上一次的副本奖励还未领取')
		return false, '上一次的副本奖励还未领取'
	end

	local playerTemp = CS_GetPlayerTemp(sid)
	local teamID = GetPlayerData(12)
	local isTeamLeader = GetPlayerData(13)
	
	if playerTemp.CopySceneGID ~= nil then
		local copySceneInfo = CS_GetData(playerTemp.CopySceneGID)
		if copySceneInfo~=nil then
			return false, '重复打开'
		else
			rfalse('发现无效的CopySceneGID,可能有无效数据存在')
			dbMgr[sid].temp.CopySceneData = nil
		end
	end

	-- 判断是否是队长，或者是单人
	local leader = true
	if teamID ~= 0 and isTeamLeader == 0 then
		leader = false
	end

	local TaskID = 0
	if teamID ~= 0 and leader == false then
		--取队长的任务编号
		local teamInfo = GetTeamInfo( )
		local teamLeaderSID = teamInfo[1].staticId
		local leaderTemp = CS_GetPlayerTemp(teamLeaderSID)

		if leaderTemp.TaskID==nil then
			SendTipsMsg(1,'队长未接副本任务')
			return false, '队长未接副本任务'
		end
		TaskID = leaderTemp.TaskID
	else
		if playerTemp.TaskID==nil then
			SendTipsMsg(1,'未接副本任务')
			return false, '未接副本任务'
		end
		TaskID = playerTemp.TaskID
	end

	local copySceneConfig = 副本配置[TaskID]
	if copySceneConfig == nil then
		return false, '副本配置不存在'
	end

	-- 取得临时副本ID
	local playerTemp = CS_GetCopySceneInfo( TaskID )
	if playerTemp == nil then    -- 队员的任务和队长的不一致
		return false, '临时副本创建失败'
	end
	--rfalse( 'playerTemp.CopySceneGID = ' .. tostring(playerTemp.CopySceneGID) )
	local copySceneInfo = CS_GetData(playerTemp.CopySceneGID)
	if copySceneInfo==nil then
		rfalse('发现无效的CopySceneGID,可能有无效数据存在')
		dbMgr[sid].temp.CopySceneData = nil
		return
	end

	if copySceneInfo.PlayerCount >= copySceneConfig.最大人数 then
		SendTipsMsg(1,'超过副本最大人数')
		return false, '超过副本最大人数'
	end
	local wndCopyScene = {}

	if leader == true then
		--显示队员准备信息的字符串
		local teamPrepare = __CS_GetTeamPrepareInfo( copySceneInfo )

		-- 通知客户端显示副本窗口
		wndCopyScene = {
			cleanup = true,
			image_1	=  '200,100,interface/CopyScene/副本底板.spr',
			image_2	=  '209,132,interface/CopyScene/副本'..tostring(TaskID)..'.spr',
			Static_6 = { pos = '423,373,', Text = copySceneConfig.描述, setsize = '259,170'},
			text_7 = '696,373,'..teamPrepare..',12,124',				-- 队员准备列表
			text_80 = '278,375,'..copySceneConfig.准备条件.等级..'级,12,124',
			text_81 = '278,395,'
				..string.format("%02s",tostring(copySceneConfig.开放时间.开始.hour))..':'
				..string.format("%02s", tostring(copySceneConfig.开放时间.开始.min))..'——'
				..string.format("%02s",tostring(copySceneConfig.开放时间.结束.hour))..':'
				..string.format("%02s",tostring(copySceneConfig.开放时间.结束.min))..',12,124',
			text_82 = '278,415,'..copySceneConfig.最大人数..'人,12,124',
			text_83 = '278,435,'..copySceneConfig.准备条件.金钱..',12,124',
			text_84 = '278,515,'..copySceneConfig.完成目标..',12,124',
			SprButton_1 = { pos = '343,564', image = 'Interface/CopyScene/进入副本.spr', action = '@rc,1' },
			SprButton_2 = { pos = '480,564', image = 'Interface/CopyScene/放弃按钮.spr', action = '@rc,2,@E' },
			SprButton_4 = { pos = '620,564', image = 'Interface/CopyScene/取消.spr', action = '@rc,4,@E' },
			SprButton_5 = { pos = '785,103', image = 'Interface/CopyScene/关闭.spr', action = '@rc,4,@E' },
		}

		for k, v in pairs( copySceneConfig.准备条件.道具 ) do
			if v.id ~= nil then
				local str = "ItemHolder_9" .. tostring(k)
				local x = 218 + ( k - 1 ) * 39
				wndCopyScene[str] = {
					pos = tostring(x)..",470",					
					dragable = false,
					itemIDandNum = tostring(v.id)..","..tostring(v.num),
				}
			end
		end

	else
		local teamPrepare = __CS_GetTeamPrepareInfo( copySceneInfo)
		wndCopyScene = {
			cleanup = true,
			image_1	=  '200,100,interface/CopyScene/副本底板.spr',
			image_2	=  '209,132,interface/CopyScene/副本'..tostring(TaskID)..'.spr',
			Static_6 = { pos = '423,373,', Text = copySceneConfig.描述, setsize = '259,170'},
			text_7 = '696,373,'..teamPrepare..',12,124',
			text_80 = '278,375,'..copySceneConfig.准备条件.等级..'级,12,124',
			text_81 = '278,395,'
				..string.format("%02s",tostring(copySceneConfig.开放时间.开始.hour))..':'
				..string.format("%02s", tostring(copySceneConfig.开放时间.开始.min))..'——'
				..string.format("%02s",tostring(copySceneConfig.开放时间.结束.hour))..':'
				..string.format("%02s",tostring(copySceneConfig.开放时间.结束.min))..',12,124',
			text_82 = '278,415,'..copySceneConfig.最大人数..'人,12,124',
			text_83 = '278,435,'..copySceneConfig.准备条件.金钱..',12,124',
			text_84 = '278,515,'..copySceneConfig.完成目标..',12,124',
			SprButton_2 = { pos = '343,564', image = 'Interface/CopyScene/放弃按钮.spr', action = '@rc,2,@E' },
			SprButton_3 = { pos = '480,564', image = 'Interface/CopyScene/准备.spr', action = '@rc,3' },
			SprButton_4 = { pos = '620,564', image = 'Interface/CopyScene/取消.spr', action = '@rc,4,@E' },
			SprButton_5 = { pos = '785,103', image = 'Interface/CopyScene/关闭.spr', action = '@rc,4,@E' },
		}
	end
	for k, v in pairs( copySceneConfig.准备条件.道具 ) do
		if v.id ~= nil then
			local str = "ItemHolder_9" .. tostring(k)
			local x = 218 + ( k - 1 ) * 39
			wndCopyScene[str] = {
				pos = tostring(x)..",470",
				dragable = false,
				itemIDandNum = tostring(v.id)..","..tostring(v.num),
			}
			end
	end

	WndCustomize( wndCopyScene, "WaitForCopySceneStart", copySceneInfo.CopySceneGID )
	
	copySceneInfo.PlayerCount = copySceneInfo.PlayerCount + 1
	
	return true,'打开副本界面'

end

--向除本人外的所有队员发MessageBox(队员还没有加入副本)
function CS_SentTeamMemberMsg( str)
	local teamInfo = GetTeamInfo()
	local sid = GetPlayerData(17)
	if teamInfo ~= nil then
		for i = 1, table.maxn( teamInfo), 1 do
			if teamInfo[i].staticId ~= sid then
				SendLuaMsg( teamInfo[i].staticId, { ids = IDS.显示MessageBox, Desc = str }, 10 )
			end
		end
	end
end

function WaitForCopySceneStart(GID, param1)
	if param1 == 1 then			-- 进入
		CS_OnCopySceneStart()
	elseif param1 == 2 then		-- 放弃
    	CS_OnDropTask()
	elseif param1 == 3 then		-- 准备
		ret, info = CS_OnProcReady()
		if ret~= ture then -- 通知状态改变
			SendLuaMsg( 0, { ids = IDS.显示MessageBox, Desc = info }, 9 )
		end
		rfalse(tostring(ret)..'         '..tostring(info))
	elseif param1 == 4 then	-- 取消
		CS_OnCancelPrepare()
	end
end

function CS_OnCancelPrepare()
	local sid = GetPlayerData(17)
	local copyScene = CS_GetCopyScene()
	if copyScene == nil then
		rfalse('副本未创建')
	    return
	end
	
	local taskid = copyScene.TaskID;
	CS_OnCleanUp( sid )
	local teamID = GetPlayerData(12)
	local isleader = GetPlayerData(13)
	if teamID == 0 or isleader == 1 then
		--如果是队长,则保存任务
		rfalse('则保存任务ID')
		CS_GetPlayerTemp( sid ).TaskID = taskid;
	end

	SetPlyaerCopySceneState( playerCSState.接受副本任务 )
	-- 刷新队友的准备列表
	local temp = {}
	local teamPrepare = __CS_GetTeamPrepareInfo( copyScene )
	temp.text_7 = '696,373,'..teamPrepare..',12,124'
	local teamInfo = GetTeamInfo()
	if teamInfo ~= nil then
      for k,v in pairs (teamInfo) do
      	if v.staticId ~= sid then		-- 不用刷新自己的
      		if isleader == true	then
      			CustomWndClose( v.staticId ) --关闭窗口
      		else
      			UpdateCustomWnd( v.staticId, temp)
      		end          
        end
      end
	end

end

function CS_OnDropTask()
	rfalse('放弃副本任务')
	local sid = GetPlayerData(17)
	local copyScene = CS_GetCopyScene()
	if copyScene == nil then
	    return
	end

	local isleader = GetPlayerData(13)
	CustomWndClose( sid) --关闭窗口

	if copyScene.PlayerSIDList[sid] == nil then
	    return
	end

	copyScene.PlayerSIDList[sid] = nil
	SetPlyaerCopySceneState( playerCSState.没有副本任务 )

	-- 刷新队友的准备列表
	local temp = {}
	local teamPrepare = __CS_GetTeamPrepareInfo( copyScene )
	temp.text_7 = '696,373,'..teamPrepare..',12,124'
	local teamInfo = GetTeamInfo()
	if teamInfo ~= nil then
      for k,v in pairs (teamInfo) do
      	if v.staticId ~= sid then		-- 不用刷新自己的
      		if isleader==true	then
      			CustomWndClose( v.staticId ) --关闭窗口
      		else
      			UpdateCustomWnd( v.staticId, temp)
      		end          
        end
      end
	end
	CS_RemovePlyaer( sid )
end

-- 处理队伍中队员准备副本任务的请求
function CS_OnProcReady()
	local copyScene = CS_GetCopyScene()
	if copyScene == nil then
		return false, '准备场景不存在'
	end

	local taskID = copyScene.TaskID
	local copySceneConfig = 副本配置[taskID]
	if copySceneConfig == nil then
		return false, '副本配置不存在'
	end
	
	-- 判断开放时间
	local curTime = os.time()	
	local curDate = os.date('*t',os.time())
	
	local dateBegin = copySceneConfig.开放时间.开始; 
	dateBegin.year = curDate.year;
	dateBegin.month = curDate.month;
	dateBegin.day = curDate.day;
	dateBegin.isdst = curDate.isdst;
	
	local dateEnd = copySceneConfig.开放时间.结束; 
	dateEnd.year = curDate.year;
	dateEnd.month = curDate.month;
	dateEnd.day = curDate.day;
	dateEnd.isdst = curDate.isdst;
	
	local timeBegin = os.time( dateBegin )
	local timeEnd = os.time( dateEnd )
	if curTime<timeBegin or curTime>=timeEnd then
		SendTipsMsg(1,'副本已经关闭')
		return false, '副本已经关闭'
	end
	
	-- 判断人数
	if copyScene.PlayerCount > copySceneConfig.最大人数 then
		SendTipsMsg(1,'超过副本最大人数')
		return false, '超过副本最大人数'
	end	
	
	local sid = GetPlayerData(17)
	-- 次数判断
	if CS_CheckEnterCount(taskID,sid)==false then
		SendTipsMsg(1,'超过副本最大进入次数')
		return false, '超过副本最大进入次数'
	end
	
	-- 判断是否可以准备

	local rt,msg = __OnCheckReadyCondition(copySceneConfig.准备条件, sid)
	if not rt then
		SendTipsMsg(1,msg)
		return false, msg
	end

	-- 把玩家加入到副本玩家列表
	copyScene.PlayerSIDList[sid] = true
	SetPlyaerCopySceneState( playerCSState.准备进入副本)

	--显示队员准备信息的字符串
	local temp = {}
	local teamPrepare = __CS_GetTeamPrepareInfo( copyScene)
	temp.text_7 = '696,373,'..teamPrepare..',12,124'
	local teamInfo = GetTeamInfo()
	if teamInfo ~= nil then
      for k,v in pairs (teamInfo) do
      	UpdateCustomWnd( v.staticId, temp)
      end
	end

	return true
end

--取消锁定
function OnUnLockeOperator( sid )

	SendTipsMsg(1,'解除锁定状态',sid)
	local playerData = CS_GetPlayerData(sid)

	if playerData~=nil and playerData.Complete~=nil then
		--完成任务,切出场景
		CS_Back( sid )
	end
end

-- 处理副本进入请求
function CS_OnCopySceneStart(prompt)
	rfalse('request enter copy scene')

	-- 单人或者队长
	local IsReady,msg = CS_OnProcReady()
	if IsReady ~= true then
		return false, msg
	end

	-- 取得对应副本数据
	sid = GetPlayerData(17)
	local copyScene = CS_GetCopyScene()

	local copySceneGID = copyScene.CopySceneGID
	if copySceneGID == nil or copyScene == nil then
		return false, '副本不存在'
	end
	-- 检查副本任务ID
	local taskID = copyScene.TaskID
	if taskID == nil then
		return false, '副本任务ID不存在'
	end
	-- 检查副本配置
	local copySceneConfig = 副本配置[taskID]
	if copySceneConfig == nil then
		return false, '副本配置不存在'
	end

    local teamInfo = GetTeamInfo()
	if teamInfo ~= nil then
		for k, v in pairs(teamInfo) do
			if copyScene.PlayerSIDList[v.staticId] ~= true then
				SendLuaMsg( 0, { ids = {3, 2}, Desc = '还有队员没有准备好，是否立即出发？', cbOkName = 'CS_ClientConfirmForceEnter', PlayerSID = sid }, 9 )
				return false, '等待确认是否强制进入'
			end
		end
	end
		
	return CS_DoEnter( )

end

-- 强制进入副本
function CS_ForceEnter(playerSID)

	local teamInfo = GetTeamInfo()
	local copyScene = CS_GetCopyScene()
	if copyScene == nil then
		return false, '无法找到对应副本'
	end

	if teamInfo == nil then
		return false, '队伍信息不正确'
	end

	return CS_DoEnter( )

end

-- 直接进入副本
function CS_DoEnter( )
	rfalse('do enter')
	local teamID = GetPlayerData(12)
	local copyScene = CS_GetCopyScene()
	local copySceneConfig = 副本配置[copyScene.TaskID]

	local teamInfo = GetTeamInfo()
	if teamInfo ~= nil then
    	for k, v in pairs( teamInfo) do
	    	if copyScene.PlayerSIDList[v.staticId] ~= true then
		    	DeleteTeamMember(teamID, v.staticId)	--如果队员没有准备好,则踢出队伍(准备状态)
		    	CS_OnCleanUp( v.staticId)
	    	end
    	end
	end
	rfalse('再次检查队员有没有准备好')
	-- 再次检查队员有没有准备好(准备条件)
	for sid, v in pairs(copyScene.PlayerSIDList) do
		if sid ~= '' then
			if not __OnCheckReadyCondition(copySceneConfig.准备条件, sid) then
				DeleteTeamMember(teamID, sid)
				CS_OnCleanUp( v.staticId)
			end
		end
	end

	-- 加载副本场景
	rfalse('加载副本场景')
	local taskID = copyScene.TaskID
	local copySceneConfig = 副本配置[taskID]
	local ret = CS_LoadScene(copyScene, copySceneConfig, taskID)
	if ret == nil then
		return false, '加载副本失败'
	end

	-- 开始删每个人的东西
	local condition = copySceneConfig.准备条件
	local money = GetPlayerData(PlayerProperty.金钱)
 
	for sid,v in pairs( copyScene.PlayerSIDList ) do
		if sid ~= '' and v == true then
            if CheckMoney(money,true,k)==false then
                return false,'角色金钱不足'
            end

            for kItem,vItem in pairs(condition.道具) do
                if CheckGoods(vItem.id,vItem.num,0,k)==0 then
                    return false, '角色的'..vItem.name..'不足'
                end
            end
        end
	end

	-- ...
	rfalse('进入副本场景')

	-- 进入副本场景
	local completeTime = copySceneConfig.时间限制;
	local i = 1
	copyScene.PlayerCount = 0
	local 追踪信息 = 副本追踪.GetTips(copyScene)
	for sid, _ in pairs(copyScene.PlayerSIDList) do
		if sid ~= '' then
		    CustomWndClose(sid)
		
			if CS_PutPlayerTo(copySceneConfig, sid, i, copyScene) ~= true then
				rfalse('Put player to copy scene failed')
			end

			-- 次数
			CS_AddEnterCount(taskID,sid)
		
			local playerTemp = CS_GetPlayerTemp(sid)
			playerTemp.CopySceneGID = copyScene.CopySceneGID
			playerTemp.TaskID = copyScene.TaskID

			SetPlyaerCopySceneState( playerCSState.副本中, k)
			copyScene.PlayerCount = copyScene.PlayerCount+1
			
			--如果有完成时间限制,开始计时
			if completeTime~=nil then
				SendLuaMsg( sid, { ids = IDS.副本任务计时 , time=completeTime*60 }, 10 )
			end
			
			--发送追踪信息
			SendLuaMsg( sid, { ids = IDS.副本任务追踪 , tips=追踪信息 }, 10 )
			i = i + 1
		end
	end	

	--清空临时数据
	local teamID = GetPlayerData(12)
	PrepareScene[teamID] = nil
	
	-- 开始计时
	--如果有完成时间限制,开始计时
	if completeTime~=nil then
		completeTime = completeTime * 60
		copyScene.Timer = SetEvent(completeTime, nil, 'OnCopySceneOverTime', copyScene.TaskID, copyScene.CopySceneGID )
	end
	
	return true
end

function OnCopySceneOverTime( taskid, copySceneGID )
	rfalse('副本任务超时. taskid='..tostring(taskid)..',副本GID='..tostring(copySceneGID))
	local csdata = CS_GetData( copySceneGID )
	if csdata==nil then
		return
	end

	--
 	for sid, v in pairs(csdata.PlayerSIDList) do
 		if sid ~= '' then
 			SendTipsMsg(1,'副本任务超时',sid)
 			CS_OnCleanUp(sid)
	 		CS_Back(sid)	
 		end
 	end	
end

-- 队伍解散
function OnReleaseTeam( teamID)
	rfalse('--队伍解散')
	CS_OnDelPrepareScene( teamID)
end

-- 退出队伍
function CS_OnQuitTeam( )
	rfalse('--退出队伍')
	local sid = GetPlayerData(17)
	
	--处理副本
	local playerTemp = CS_GetPlayerTemp(sid)	
	if playerTemp ~= nil then
		rfalse('清理临时数据')
		ClearPlayerItem( )		--清除玩家从副本仓库中取得的道具
		CustomWndClose( sid)	--关闭窗口
		g_ListCopySceneID[sid] = nil
	end
end

-- 退出副本
function CS_DoExit()
	rfalse('--退出副本')
	CS_OnCleanUp( GetPlayerData(17) )
end
-- 从副本返回
function CS_Back( sid )
	-- 判断是否在副本状态
	-- 直接从复活点返回
	BackFromDynamicScene( sid )
end
--清理 当前玩家 的 临时数据
function CS_OnCleanUp( sid )
	rfalse('清理临时数据')
	if sid==nil then return end

	ClearPlayerItem( )		--清除玩家从副本仓库中取得的道具
	CustomWndClose( sid)	--关闭窗口

	g_ListCopySceneID[sid] = nil

	local playerData = CS_GetPlayerData( sid)
	--如果副本任务没有完成,则设置为没有副本状态
	if playerData ~= nil and playerData.Complete ~= nil then
		SetPlyaerCopySceneState( playerCSState.接受副本任务, sid)
	else
		SetPlyaerCopySceneState( playerCSState.没有副本任务, sid)
	end
	SendLuaMsg( sid, { ids = IDS.副本任务追踪 , tips=nil}, 10 )
	SendLuaMsg( sid, { ids = IDS.副本任务计时 , time=0 }, 10 )
	CS_RemovePlyaer( sid )
end

 -- 副本完成
 -- 副本完成并不马上退出副本地图,而是锁定10秒钟的CG时间,再退出
 function CS_Complete(copyScene)
 	rfalse('----完成副本任务--------')
 
 	--取消计时
 	if copyScene.Timer~=nil then 
 		rfalse('清理计时器')
 		ClrEvent(copyScene.Timer)
 	end
 	
 	local taskID = copyScene.TaskID
 	local copySceneConfig = 副本配置[taskID]
 	if copySceneConfig == nil then
 		rfalse('副本配置不存在')
 		return
 	end
 	local member = {}
 	for sid, v in pairs(copyScene.PlayerSIDList) do
 		if sid ~= '' then 			
	 		member[sid] = GetPlayerGID( sid )
 		end
 	end
 	for sid, v in pairs(copyScene.PlayerSIDList) do
 		if sid ~= '' then
	 		local playerData = CS_GetPlayerData(sid)
	 		副本奖励处理表.Award(taskID, playerData)
	 		SendTipsMsg(1,'完成副本任务',sid)
	 		SendLuaMsg( sid, { ids = IDS.副本任务完成 , team=member }, 10 )
	 		LockPlayer( 5000,sid )			
 		end
 	end
 	
 end

-- 检查奖励是否能给予
local function __CanGiveAward(award)
	return true
end

-- 给予奖励
function __GiveAward(award)

	--奖励物品时，先把所有奖励的物品统计出来
	local addGood = {}
	for itemIdx, count in pairs(award.ItemList) do
		if itemIdx ~= '' then
			addGood = { itemIdx, count }
		end
	end
	
	--再判断是否可以添加这些物品
	if CheckAddGoods( addGood) == false then
		SendTipsMsg(1,'背包已满，不能完成任务')
		return false
	end
	
	-- 道具
	for itemIdx, count in pairs(award.ItemList) do
		GiveGoods(itemIdx, count)
	end
	
	-- 经验
	if award.Exp ~= nil then
		PayThePlayer(1, award.Exp)
	end

	-- 心法熟练度

	-- 武功熟练度
end

-- 取得奖励
function CS_DoAward()

	local sid = GetPlayerData(17)
	local playerData = CS_GetPlayerData(sid)
	if playerData == nil or playerData.Complete == nil then
		return
	end

	-- 检查奖励是否能给予
	local award = playerData.Complete.Award
	if not __CanGiveAward(award) then
		return
	end

	-- 给予奖励
	__GiveAward(award)

	playerData.Complete = nil
	playerData.TaskID = nil
	CS_RemovePlyaer( sid )
	SetPlyaerCopySceneState( playerCSState.没有副本任务 )
end

-- 处理奖励流程
function CS_OnProcAward()

	local sid = GetPlayerData(17)
	local playerData = CS_GetPlayerData(sid)
	if playerData == nil or playerData.Complete == nil then
		return
	end

	local award = playerData.Complete.Award
	local goods = { give = {} }
	for itemIdx, count in pairs(award.ItemList) do
		if itemIdx ~= '' then
			table.push(goods.give, {itemIdx, count})
		end
	end

	local taskAward = {
		完成奖励 = {
			giveExp = award.Exp,
			giveMoney = award.Money,
			giveGoods = goods,
		}
	}

	SendLuaMsg( 0, { ids = {3, 1}, taskID = playerData.Complete.TaskID, awardInfo = taskAward }, 9 )

end

--与NPC对话
function ClickMenu80000(index)
	local npcid = GetObjectUniqueId()
	npcid = npcid - 400000
	if 副本NPC[npcid]~=nil and 副本NPC[npcid].ClickMenu~=nil then
		rfalse('与NPC对话 id='..tostring(npcid))
		副本NPC[npcid].ClickMenu( index );
	end
end

--接受副本任务
function ClickMenu80001(index)
	local sid = GetPlayerData(17)
	local lsID = g_ListCopySceneID[sid]
	if lsID ~= nil then
		if index <= table.maxn( lsID) then
			SendTipsMsg(1,'接受副本任务')
			local csTemp = CS_GetPlayerTemp(sid)
			csTemp.TaskID = lsID[index]
			SetPlyaerCopySceneState( playerCSState.接受副本任务)
		end
	end
	--删除临时变量
	g_ListCopySceneID[sid] = nil
end
--取仓库物品
msgDispatcher[4][1000] = function ( playerid, msg )
	local sid = GetPlayerData(17)	--获取角色id
	local csTemp = CS_GetPlayerTemp(sid)
	if ( csTemp.CopySceneGID == nill or csTemp.CopySceneGID==0 ) then return; end;

	--获取副本数据
	local copyScene = CS_GetData(csTemp.CopySceneGID)

	--取副本仓库
	local src = msg.src;
	local to = msg.to;
	local index_src = src.y*8+src.x+1;
	local item = copyScene.Storage[index_src];
	if ( item == nil ) then
		--与客户端同步,通知客户端此位置已经没有了
		SendLuaMsg( 0, { ids = {5,1}, Desc = '道具已经被其它玩家领取了!' }, 9 )
		return;
	end
	local rt = GiveGoods(item[1],1);--AddGoods( item, to.x, to.y, 1 );
	if rt==nil or rt==0 then
		SendLuaMsg( 0, { ids = {5,1}, Desc = '包裹已经满了!' }, 9 )
		return;
	end

	--删除道具
	item[2] = item[2] - 1
	if item[2]<=0 then
		copyScene.Storage[index_src] = nil
		item = nil
	end

	for k,v in pairs(copyScene.PlayerSIDList) do
		if k ~= '' and v == true then
		 SendLuaMsg( k, { ids = IDS.删除副本仓库道具, pos=src }, 10 )
		end
	end
end

--清除玩家从副本仓库中获得到的道具
function ClearPlayerItem( )

	--如果角色身有这些段以内的道具,则删除
	for k,v in pairs(副本道具表) do
		if v~=nil then
			ClearPlayerCSItem(v[1],v[2]);
		end
	end
end
