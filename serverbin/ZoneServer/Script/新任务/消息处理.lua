-- ##################################################################
msgDispatcher = msgDispatcher or{
		[1] = {},	-- ���������
		[2] = {},	-- �ͻ�����ɲ���
		[3] = {},
		[4] = {},	-- �������
		[10] = {},  -- RPC����
		[11] = {},  --װ������ű���� jym
}

-- ע�⣬��Ϣ��������ע����ھ���Ĺ��ܽű���ߡ�����
-- �ͻ���ֱ�ӷ���һ��table������msg�ǿͻ��˽ű�ϵͳ�У�ֱ�����л��õ���Ϣ
-- ��Ϣ������Ҫ������ϢID���У����ڶ�Ӧ��Ϣ����ű�����
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

-- ����NPC�����ͳһ������
msgDispatcher[1][1] = function ( playerid, msg )
	--rfalse("�յ�����������Ϣ..")
	if CheckPlayerPos(playerid,msg.npcid)~=true then
		rfalse("λ�ô���")
		return
	end
	��������( playerid, msg.npcid, msg.taskid, msg.index, msg.type )
end

msgDispatcher[1][2] = function ( playerid, msg )
	if nil==msg.super and CheckPlayerPos(playerid,msg.npcid)~=true then
		return 
	end
	��������( playerid, msg.npcid, msg.taskid )
end

msgDispatcher[1][3] = function ( playerid, msg )
	--rfalse("�յ����������Ϣ..")
	if CheckPlayerPos(playerid,msg.npcid) ~= true then
		return
	end
	������( playerid, msg.npcid, msg.taskid, msg.goodid )
end

msgDispatcher[1][4] = function ( playerid, msg )
	--rfalse("�յ����������Ϣ..")
	���������( playerid, msg.npcid, msg.taskid,msg.opkey,msg.opvalue )
end

msgDispatcher[1][5] = function ( playerid, msg )
	--rfalse("�յ�����׷����Ϣ.." .. "playerid: " .. tostring(playerid))
	����׷��( playerid, msg.taskid, msg.op)
end

msgDispatcher[1][6] = function ( playerid, msg )
	��������( playerid, msg.taskid)
end

msgDispatcher[1][7] = function ( playerid, msg )
	if msg.taskid and msg.key then
		markTimeoutFinished( playerid, msg.taskid, msg.key)
	end
end

msgDispatcher[1][8] = function ( playerid, msg )
	if CheckPlayerPos(playerid,msg.npcid)~=true then
		rfalse("λ�ô���")
		return
	end

	����Ǿ���NPC(playerid ,msg)
end

msgDispatcher[1][9] = function ( playerid, msg )
	��̬�����������(playerid, msg.step)
end

msgDispatcher[2][1] = function ( playerid, msg )
	��ɲ���( playerid, msg.npcid, msg.taskid,msg.opkey,msg.opvalue)
end

msgDispatcher[2][2] = function ( playerid, msg )
	��ɵ��NPC����( playerid, msg.npcid, msg.taskid )
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
	�������(playerid, msg.npcid, msg.step)
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

-- ������ܸ�����������Ϣ
msgDispatcher[4][1] = function ( playerid, msg )
	CS_DoAward()
end

-- ����ȷ��ǿ�ƽ��븱������Ϣ
msgDispatcher[4][2] = function ( playerid, msg )
	ret, info = CS_ForceEnter( msg.PlayerSID )
	if ret == false then rfalse(info) end
end

-- ����ȷ��װ��������� jym
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
		rfalse("����������")
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
	local npcinfo = ����NPC���ñ�[npcid].NpcCreate

	--x,y,regionid = getplayercurpos()
	local xdistance = math.abs(npcinfo.x-x)
	local ydistance = math.abs(npcinfo.y-y)

	if xdistance <= 5 and ydistance <=5 then
		return true
	else
		rfalse("�Ƿ�λ��")
		rfalse("x="..tostring(x).." y="..tostring(y).." info.x="..tostring(npcinfo.x).." info.y="..tostring(npcinfo.y).." npcid="..tostring(npcid))
		return false
	end
end
