-- ##################################################################
msgDispatcher = msgDispatcher or{
		[1] = {},	-- 新任务相关
		[2] = {},	-- 客户端完成操作
		[3] = {},
		[4] = {},	-- 副本相关
		[10] = {},  -- RPC调用
		[11] = {},  --装备打造脚本相关 jym
}

-- 注意，消息处理函数的注册放在具体的功能脚本里边。。。
-- 客户端直接发送一个table过来，msg是客户端脚本系统中，直接序列化好的消息
-- 消息表中需要包含消息ID序列，用于对应消息处理脚本函数
function OnLuaMessage( playerid, msg )
	local idx = 1
	local func = msgDispatcher
	local msgids = msg.ids
	while jex.ttype( func ) == 5 do
		func = func[msgids[idx]]
		idx = idx + 1
	end
	if ( jex.ttype( func ) == 6 ) then
		func( playerid, msg )
	end
end

-- ##################################################################

-- 任务NPC点击的统一处理函数
msgDispatcher[1][1] = function ( playerid, msg )
	--rfalse("收到触发剧情消息..")
	if CheckPlayerPos(playerid,msg.npcid)~=true then
		rfalse("位置错误")
		return
	end
	触发剧情( playerid, msg.npcid, msg.taskid, msg.index, msg.type )
end

msgDispatcher[1][2] = function ( playerid, msg )
	if nil==msg.super and CheckPlayerPos(playerid,msg.npcid)~=true then
		return 
	end
	接受任务( playerid, msg.npcid, msg.taskid )
end

msgDispatcher[1][3] = function ( playerid, msg )
	--rfalse("收到完成任务消息..")
	if CheckPlayerPos(playerid,msg.npcid) ~= true then
		return
	end
	交任务( playerid, msg.npcid, msg.taskid, msg.goodid )
end

msgDispatcher[1][4] = function ( playerid, msg )
	--rfalse("收到完成任务消息..")
	完成子任务( playerid, msg.npcid, msg.taskid,msg.opkey,msg.opvalue )
end

msgDispatcher[1][5] = function ( playerid, msg )
	--rfalse("收到任务追踪消息.." .. "playerid: " .. tostring(playerid))
	任务追踪( playerid, msg.taskid, msg.op)
end

msgDispatcher[1][6] = function ( playerid, msg )
	放弃任务( playerid, msg.taskid)
end

msgDispatcher[1][7] = function ( playerid, msg )
	if msg.taskid and msg.key then
		markTimeoutFinished( playerid, msg.taskid, msg.key)
	end
end

msgDispatcher[1][8] = function ( playerid, msg )
	if CheckPlayerPos(playerid,msg.npcid)~=true then
		rfalse("位置错误")
		return
	end

	点击非剧情NPC(playerid ,msg)
end

msgDispatcher[1][9] = function ( playerid, msg )
	动态场景点击剧情(playerid, msg.step)
end

msgDispatcher[2][1] = function ( playerid, msg )
	完成操作( playerid, msg.npcid, msg.taskid,msg.opkey,msg.opvalue)
end

msgDispatcher[2][2] = function ( playerid, msg )
	完成点击NPC操作( playerid, msg.npcid, msg.taskid )
end

msgDispatcher[2][3] = function ( playerid, msg )
	local taskdata = GetDBTaskData(playerid)
	if taskdata then
		ringRefresh(taskdata)
	end
end

msgDispatcher[3][1] = function ( playerid, msg )
	if nil==msg.npcid or CheckPlayerPos(playerid,msg.npcid)~=true then
		return
	end
	点击剧情(playerid, msg.npcid, msg.step)
end

msgDispatcher[3][2] = function ( playerid, msg )
	local cgid = GetTaskTemp( playerid ).cgid

	rfalse("save cg id :" .. cgid )
	local f = msg.f
	if nil~=cgid and msg.cgid ==cgid then 
		if type('')==type(f) and nil~=_G[f] then
			_G[f]()
		end

		GetTaskTemp( playerid ).cgid = nil
	end
end

-- 处理接受副本奖励的消息
msgDispatcher[4][1] = function ( playerid, msg )
	CS_DoAward()
end

-- 处理确认强制进入副本的消息
msgDispatcher[4][2] = function ( playerid, msg )
	ret, info = CS_ForceEnter( msg.PlayerSID )
	if ret == false then rfalse(info) end
end

-- 处理确认装备打造相关 jym
msgDispatcher[11][1] = function ( playerid, msg )
	if(msg.type == 1) then
        wndItemLockCheckup3()
	elseif (msg.type == 2) then
	    wndItemUnlockCheckup3()
	elseif (msg.type == 3) then
	    BowlderCrasis3()
	elseif (msg.type == 4) then    
	    StartTakeOut2()
	elseif (msg.type == 5) then    
	    MakeBatchHoles2()
	elseif (msg.type == 6) then    
	    StartInlay2()
	elseif (msg.type == 7) then    
	    --JDZB()
	end

end

if RPCFunctions == nil then
	local RPCFunctions = {}
end
msgDispatcher[10][1] = function( playerid, msg )
	local func = RPCFunctions[msg.func]
	if func == nil or type(func)~='function' then
		rfalse("函数不存在")
		return
	end

	if msg == nil or type(msg) ~= 'table' or #msg==0 then
		func()
	else
		msg.func = nil
		func(unpack(msg.args))
	end
end

function CheckPlayerPos(playerid,npcid)
	local x,y,regionid = getplayercurpos()
	local npcinfo = 任务NPC配置表[npcid].NpcCreate

	--x,y,regionid = getplayercurpos()
	local xdistance = math.abs(npcinfo.x-x)
	local ydistance = math.abs(npcinfo.y-y)

	if xdistance <= 5 and ydistance <=5 then
		return true
	else
		rfalse("非法位置")
		rfalse("x="..tostring(x).." y="..tostring(y).." info.x="..tostring(npcinfo.x).." info.y="..tostring(npcinfo.y).." npcid="..tostring(npcid))
		return false
	end
end
