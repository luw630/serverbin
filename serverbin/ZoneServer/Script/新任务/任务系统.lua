NPC_OnClick =
{
	[7089]=OnClick7089,
	[7090]=OnClick7090,
	[4]=NewXYDbuy,
	[7092]=OnClick7092,
	[7093]=OnClick7093
}


function IsTaskNpc(npcid)
	return ����NPC���ñ�[npcid] ~= nil
end

-- ����NPC�����ͳһ������
function OnClick30000()
	rfalse("OnClick30000...")
	local npcid, monid, playerid = GetObjectUniqueId()
	npcid = npcid - 100000

	if npcid>=300000 and npcid < 400000 then
		rfalse("OnClickTestCopyScene")
		OnClickTestCopyScene( npcid-300000 )
		return
	elseif npcid>=100000 and npcid<200000 then -- ͨ�����������ǳ����ϵ���Ʒ
		OnClickItem(playerid,npcid)
		return
	elseif(NPC_OnClick[npcid] ~= nil) then
		NPC_OnClick[npcid]()
		return
	end

	--��ˢ����,���ظ���������
	local temp = GetTaskTemp( playerid )

	local ringtaskid
	local ok, ringId, taskConf = ringCouldAccept( npcid, taskData)
	if ok  then
		ringtaskid = temp.ringtaskid or ringRandomTask( ringId, taskConf, taskData)
		if ringtaskid  and ringtaskid~=temp.ringtaskid then
			temp.ringtaskid = ringtaskid
			rfalse("����ringttakid: " .. ringtaskid)
		end
	end

	SendLuaMsg( 0, { ids = {1,1}, npcid = npcid, ringid=ringtaskid }, 9 )
end

-- ͨ�����SID��ȡ����Ҷ�Ӧ���������ݱ�
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

--taskid һ��Ϊѡ��,ֻ���ܻ�����������
function SendStoryData(storyid, npcid, taskid)
	--[[
	if nil==npcname and nil~=taskid then
		local taskconf = GetTaskConfig(taskid, GetCurDBTaskData())
		if nil~=taskconf and nil~=taskconf.������npcid then
			npcname = ����NPC���ñ�[taskconf.������npcid].NpcCreate.name
		end
	end
	if nil~=npcname	then
		�����[storyid].npcName = npcname
	end
	--]]

	--Ϊ�ܻ������� taskѡ��
	rfalse("storyid: " .. storyid)
	local story = �����[storyid]

	--��¼cg id
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

function ��������( playerid, npcid, taskid, index, tp )
	-- ֪ͨ�ͻ��˴�������
	local taskData = GetDBTaskData( playerid )
	local taskTemp = GetTaskTemp(playerid)
	local storyid = nil

	rfalse("��������")
	if taskid ~=nil  then
		local taskInfo = GetTaskConfig( taskid, taskData)
		if nil==taskInfo then
			return
		end

		if tp == 1 then
			storyid = taskInfo.���������id

			--�ܻ�����Ϸ�����֤
			if IsRingTask(taskid) and taskTemp.ringtaskid~=taskid  then
				return
			end
		elseif tp == 2 then
			if npcid == taskInfo.������npcid and taskInfo.������δ��ɾ���id~=nil then
				storyid = taskInfo.������δ��ɾ���id
			elseif npcid == taskInfo.������npcid and taskInfo.������δ��ɾ���id~=nil then
				storyid = taskInfo.������δ��ɾ���id
				rfalse("������,storyid="..tostring(storyid).." taskname="..tostring(taskInfo.��������).." taskid" .. taskid )
			end
		end
	elseif tp == 3 then
		if TableHasKeys(����NPC���ñ�, {npcid, "NpcFunction", index}) then
			local FunItem = ����NPC���ñ�[npcid].NpcFunction[index]
			if type(FunItem[3]) == type({}) then
				local ok = ͨ�������жϱ�.CheckConditions(FunItem[3], saveTaskData, 0)
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
		rfalse( "���������id: " .. tostring(storyid))
		SendStoryData(storyid, npcid, taskid)

		taskTemp.storyid = storyid
		taskTemp.npcid = npcid
	end
end

function ��������( playerid, npcid, taskid, nocheck )
	rfalse("��������,taskid="..tostring(taskid))

	local taskData = GetDBTaskData( playerid )
	local taskInfo = GetTaskConfig( taskid, taskData)
	rfalse("playerid=="..tostring(playerid).." taskid="..tostring(taskid))

	if taskInfo ~= nil then
		if taskData.current[taskid] == nil and taskData.completed[taskid] == nil then
			--����Ƿ���������������
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
					if ( taskInfo.�������� == nil ) then
						rfalse( "�������� == nil" )
					else
						actionIndex, failInfo = ͨ�������жϱ�.CheckConditions(
							taskInfo.��������, taskData, taskid )
						if actionIndex ~= 1 then
							rfalse( "��������ʧ�ܣ�" )
							return
						end
					end
				end
			end

			taskData.current[taskid] = {}
			-- chenj ����׷�ٲ���
			taskData.current[taskid].track = 1
			taskData.current[taskid].start = GetServerTime()

			-- �����������ʱ���ݵ�ע��
			-- ��ֵ�����ע�ᣡ
			rfalse( "��ʼ���ɱ����Ϣ" .. tostring(taskid) )
			MarkKillInfo( taskData, taskid )

			if taskInfo.�����¼� ~= nil then
				�����¼���.OnEvent(taskInfo.�����¼�)
			end

			if IsRingTask(taskid) then	--��¼��ʼʱ��
				ringAccept(taskid, taskData )
			end

			--���ͽ�������Ϣ
			SendLuaMsg(0, { ids = {1,4}, data = {accept = true, id = taskid} },9 )
		end
	end
end

function ������( playerid, npcid, taskid, goodid )
	local taskData = GetDBTaskData( playerid )
	local taskInfo = GetTaskConfig(taskid, taskData)

	if( taskInfo == nil or taskData.current[taskid] == nil ) then
		return
	end

	if (taskData.current[taskid].state ~= nil) then
		taskData.current[taskid] = nil
		taskData.completed[taskid] = true
		--SendLuaMsg( 0, { ids = {1,2}, data = �����[ taskInfo.���������id ],npcid=npcid }, 9 )
		SendStoryData(taskInfo.���������id, npcid, taskid )
		return
	end

	--����Ƿ���������������
	if ( taskInfo.������� == nil ) then
		rfalse( "������� == nil" )
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
		actionIndex, failInfo = ͨ�������жϱ�.CheckAndDelete( taskInfo.�������, taskData, taskid )
	end

	if actionIndex == nil or actionIndex ~= 1 then
		rfalse( "�������ʧ�ܣ�actionIndex = " .. tostring(actionIndex ) )
		return
	elseif ͨ�������жϱ�.CheckTimeout(taskInfo, taskid,taskData) then
		rfalse("�������,taskid="..tostring(taskid))

		--���������Ʒ������ܻ����һЩ����
		if not award(playerid,taskData,taskid, goodid) then
			SendTipsMsg(1,'���������������������')
			return
		end


		taskData.current[taskid] = nil

		if TableHasKeys(taskInfo, {"��������", "refresh"} ) then -- �ճ�����
			if taskData.refresh==nil then
				taskData.refresh = {}
			end
			taskData.refresh[taskid] = GetServerTime()
		elseif IsRingTask(taskid) then
			ringSubmit(taskid, taskData, playerid)
		elseif not IsReeligible(taskid) then
			-- �������
			taskData.completed[taskid] = true
		end

		--���ͽ�������Ϣ
		SendLuaMsg( 0, { ids = {1,4}, data = {accept = false, id = taskid, good = goodid } },9)

		--���;�����Ϣ
		local story = �����[ taskInfo.���������id ]
		-- �ܻ�������ҪԤ����
		if Ԥ�������( playerid, story, taskData, npcid) then
			--SendLuaMsg( 0, { ids = {1,2}, data = story, npcid=npcid }, 9 )
			SendStoryData(taskInfo.���������id, npcid, taskid)
        end
	else
		rfalse(" ���� " .. taskid .. " ��ʱ, ��������!!!")
		taskData.current[taskid] = nil
	end
end

function ��������( playerid, taskid )
	local taskData = GetDBTaskData( playerid )
	if taskid and TableHasKeys(taskData, {"current", taskid} ) then
		taskData.current[taskid] = nil

		if IsRingTask(taskid) then
			ringDropTask(taskid, taskData)
		end
	end
end

function ���������( playerid, npcid, taskid,opkey,opvalue )
	local mainid,subid = GetSubID(taskid)
	local taskData = GetDBTaskData( playerid )
	local taskInfo = GetTaskConfig(taskid, taskData)

	if taskInfo == nil or taskData.current == nil	or taskData.current[taskid] == nil then
		return
	end

	if taskData.completed[taskid] ~= nil then
		return
	end

	if ( taskInfo.������� == nil ) then
		rfalse( "������� == nil" )
		return
	end

	local failInfo = nil
	local actionIndex = nil

	if not TableHasKeys(taskInfo, {"�������",opkey} ) then
		return
	end
	if ͨ�������жϱ�[opkey]==nil then
	    return
	end

	actionIndex, failInfo = ͨ�������жϱ�[opkey](taskInfo.�������[opkey], taskData, taskid )
	if actionIndex ~= true then
		if __debug then
			rfalse( "����������ʧ�ܣ�actionIndex = " .. tostring(actionIndex ) .. failInfo )
		end
		return
	end

	if opvalue == nil then
		taskData.current[taskid][opkey] = 1 -- ��¼���һ��������
		return
	end


	if taskData.current[taskid][opkey] == nil then
		taskData.current[taskid][opkey] = {}
	end

	taskData.current[taskid][opkey][opvalue] = 1
end

--������
function award(playerid, taskData, taskid,choosegoods)
	local taskInfo = GetTaskConfig(taskid, taskData)
	local awardInfo = taskInfo.��ɽ���

	if nil==awardInfo or table.empty(awardInfo) then
		return true
	end

	local ischoose = false
	if( awardInfo.giveGoods ~= nil ) then
		--������Ʒʱ���Ȱ����н�������Ʒͳ�Ƴ���
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
				return false --û��ѡ����
			end
		end

		if awardInfo.giveGoods.give ~= nil then
			for k,v in pairs(awardInfo.giveGoods.give) do
				addGood = { v[1], v[2] }
			end
		end

		--���ж��Ƿ���������Щ��Ʒ
		if CheckAddGoods( addGood) == false then
			return false
		end

		--�ϸ������ĸ���Ʒ
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

--������ȡ������׷��
function ����׷��( playerid, taskid, op)
	-- op: 0 ȡ���������, 1 �����������
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

function ��ɲ���(playerid,npcid,taskid,opkey,opvalue)
	local mainid,subid = GetSubID(taskid)
	local taskData = GetDBTaskData( playerid )
	local taskInfo = GetTaskConfig(taskid, taskData)

	local op = taskInfo.�������
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

--ʹ����Ʒ�ص�
function UseItem(playerid,goodsid)
	rfalse("ʹ����Ʒ�ص�:"..playerid.."+"..goodsid.."���ϰ汾��Bugʼ��ٸ�ߣ�")
end

--װ����Ʒ�ص�
function EquipItem(playerid,equipid)
	rfalse("playerid = "..tostring(playerid).." װ��ID="..tostring(equipid))
	local taskData = GetDBTaskData( playerid )

	dbMgr.ShowTable(taskData.current,rfalse)

	for taskid,v in pairs(taskData.current) do
		if taskid ~= "" then
			local taskinfo = GetTaskConfig(taskid, taskData)
			if taskinfo.�������.ei ~= nil then
				if v.ei == nil then
					v.ei = {}
				end

				--[[
				local index = itemExist(taskinfo.�������.ei,equipid)
				if index~=0 then
					rfalse("�ҵ�װ��..")
					v.ei[index] = 1
					dbMgr.ShowTable(v,rfalse)
					break
				end
				--]]

				for index, eq in pairs(taskinfo.�������.ei) do
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

function �������(playerid, npcid, step)
	local temp = GetTaskTemp(playerid)	
	rfalse("�������")
	if nil==temp.story then
		return		
	end

	if(temp.story[step] == nil or temp.story[step].onClick==nil) then
		return
	end

	_G[temp.story[step].onClick]( npcid, step )
end

function ��̬�����������(playerid, step )
	local npcid = GetTaskTemp( playerid ).dynpcid
	if nil==npcid or not TableHasKeys(��̬����NPC����, {npcid, playerid, "sel", step-1, 2}) then
		return 
	end

	local func = ��̬����NPC����[npcid][playerid].sel[step-1][2]
	if type('')==type(func) and nil~=_G[func] then
		_G[func]()
	end
end

--��ǲɼ�������
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
            if TableHasKeys(taskconf, {"�������", col}) then
                local col = taskconf.�������.col
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

--�����ܻ�����
function ReBuildRingStory( story, taskid )
	if IsRingTask(taskid) then
		for _, v in ipairs(story) do
			if nil~=v.task and v.task[1]<0 then	--����v.task[1]<0 ����̫��
				local mainid = GetRingSubID(taskid)
				v.task[2] = taskid
			end
		end
	end
end

--�ӻ�����
function ringAccept( taskid, taskData )
	--��Ǯ
	if TableHasKeys(�ܻ��������ñ�, {ringid, "��Ҫ��Ǯ"}) then
		local moneyNeed = �ܻ��������ñ�[ringid].��Ҫ��Ǯ
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
					rstart,		--����ʼʱ��
					slevel,		--��ʼ�ȼ�
					sring��		--��ʼ��id
					id,			--��ǰ����id
					cstart,		--��ǰ�ӻ���ʼʱ��
					acc = {		--���������
						day,	--����
						week,	--��
						}
			}
	--]]
	local now = GetServerTime()

	ring.id = taskid				--��ǰ������id

	if nil==ring.rstart then
		ring.rstart = now			--����ʼʱ��
		ring.sring = GetRingSubID(taskid)		--	��ʼ��id
		ring.slevel = GetPlayerData(1)	--��ʼ�ȼ�

		--���ܼǴ�
		if nil==ring.acc then
			ring.acc = {}
		end
		ring.acc.day = (ring.acc.day or 0 ) + 1
		ring.acc.week = (ring.acc.week or 0 ) + 1
	end

	ring.cstart = now				--��ǰ�ӻ���ʼʱ��

	ring.refresh ={ day = now, week = now}

	rfalse("Accept ++++++++")
	dbMgr.ShowTable( os.date("*t", ring.refresh.day), rfalse)
end

--��������
function ringSubmit( taskid, taskData, playerid)
	--�ܻ����񲻷���completed��,����rings�������Ǵ�
	local ringid = GetRingSubID(taskid)
	if nil==taskData.ring then
		taskData.ring = {}
	end

	local ring = taskData.ring

	ring.id = nil
	ring.cstart = nil

	ring.count = (ring.count or 0) +1

	--����������񻺳�
	if GetTaskTemp( playerid ).ringtaskid==taskid then
		GetTaskTemp( playerid ).ringtaskid = nil
	end
end

--�ܻ����� ��ɵ��NPC����
function ��ɵ��NPC����( playerid, npcid, taskid)
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

--��ǳ�ʱ��������ɣ����ڴ�����ʱ��������
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
				if ͨ�������жϱ�.CheckConditions( taskInfo.�������, taskData,taskid) then
					taskData.current[taskid].to[1] = 1
				end
			elseif ͨ�������жϱ�[key] and ͨ�������жϱ�[key](taskInfo.�������[key], taskData, taskid) then
				taskData.current[taskid].to[key] = 1
			end
		end
	end
end

--��NPCʹ��Item��C�ص�����
function OnUseItemOnNPC30000( itemid )
	local npcid, _, playerid = GetObjectUniqueId()
	npcid = npcid - 100000

	function _ComsumeItem(playerid)
		local taskdata = GetDBTaskData(playerid)
		for taskid, v in pairs(taskdata.current) do
		    if type(taskid)==type(0) then
                local taskConf = GetTaskConfig(taskid, taskdata)
                if taskConf and TableHasKeys(taskConf, {"�������", "nu"}) then
                    local nu = taskConf.�������.nu
                    for index, vv in pairs(nu) do
                        if npcid==vv[1] and itemid == vv[2] then
                            --�������þ����Ƿ�ɾ��itme
                            if vv[3]~=0 then
                                ---------------------------------------
                                CheckGoods(itemsid, 1, 0)
                            end
                            --���
                            ��ɲ���(playerid, 0, taskid, "nu", index)
                            break
                        end
                    end
                end
            end
		end
	end

	--1.�۳���Ʒ
	_ComsumeItem(playerid)

	--2.֪ͨ�ͷ���
	rfalse("OnUseItemOnNPC30000  npcid: " .. npcid .. "  itemid: " .. itemid)
	SendLuaMsg( 0, { ids = {1,6}, npcid = npcid, item = itemid }, 9 )
end

--��Monsterʹ��Item��C�ص���������
function OnCaptureMonster30000( itemid )
	local _, monid, playerid = GetObjectUniqueId()

	local currHP = GetMonsterData(6)
	local maxHP = GetMonsterData(7)

	if currHP>=maxHP*0.3 then
		--return
	end

	local mon_name = GetMonsterData(3)

	rfalse("OnCaptureMonster30000  monid: " .. monid .. "  itemid: " .. itemid .. "  name :" .. mon_name)

	--1.ɾ������
	RemoveCurrObj(1)

	--2.�۳���Ʒ,�������
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

	    --Ĭ����ʹ�ú����ĵ���Ʒ
	    if delit~=0 then
	        -------------------------
	        --ɾ����Ʒ
	        CheckGoods(itemid, 1, 0)
	    end
	end

	for taskid, v in pairs(taskdata.current) do
	    if type(taskid)==type(0) then
            local taskConf = GetTaskConfig(taskid, taskdata)
            if taskConf and TableHasKeys(taskConf, {"�������", "cap",} ) then
                for index,vv in pairs(taskConf.�������.cap) do
                    if itemid==vv[3] and mon_name==vv[1] then
                        _incCapture(taskid, index)

                        --�������þ����Ƿ�ɾ��itme
                        _eraseItem(taskConf)
                        break
                    end
                end
            end
        end
	end
end


--RPC Server��Client
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

--��ͼ�¼��� ����������
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
			local me = taskConf.�������.me[index]
			if type(me[5])==type('') and nil~=_G[me[5]] then
				_G[me[5]]()
			end
		end		
	end
end


--NC��ɻص�
function OnFinishClickNpcAction(npcid)
	local npcid = npcid
	local taskData = GetCurDBTaskData()

	local taskid = GetNcInfo(npcid)[1]
	local ncindex = GetNcInfo(npcid)[2]

	if nil==taskData.current[taskid].nc then
		taskData.current[taskid].nc = {}
	end
	taskData.current[taskid].nc[ncindex] = 1

	local npc = ����NPC���ñ�[npcid]
	if nil~=npc and type(npc.����¼�)==type({}) then
		callTableFuncs( npc.����¼� )
	end	
end

--�ɼ���ɻص�
function OnCollectFinish(npcid)
	local id = npcid
	local npc = ����NPC���ñ�[npcid]

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

	--���ɸ�����Ʒ�б�
	local give = {}
	for _,v in ipairs(npc.product) do
		if type(v)==type(0) then	--����Ʒ
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

	--give ��Ҫһ��ԭ�ӽӿ�
	for _, v in ipairs( give) do
		GiveGoods( v[1], v[2] )
		rfalse("give: " .. v[1] .. " ," .. v[2])
	end

	--����¼�
	if type({}) == type(npc.����¼�) then
		callTableFuncs(npc.����¼�, npcid)
	end

	--���Ͳɼ������Ϣ
	--SendLuaMsg( 0, { ids = {1,5}, npcid = npcid }, 9 )
	-- mark �ɼ���������
	markCollectTask(id, GetCurDBTaskData())
end

function ����Ǿ���NPC(playerid ,msg)
    local taskdata = GetCurDBTaskData()

	local npcid = msg.npcid
	local npc = ����NPC���ñ�[npcid]
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
