-- ���ӵ�һ������

function OnInitTask()
	local status = GetTaskStatus(1)
	if (status ~= TS_NOTACCEPT) then
		return
	end
	SetTaskData(1,0)

	local flagindex = 1
	for k, v in pairs(TaskTable[1].CompleteCondition) do
		for i, j in pairs(v) do
			SetTaskFlag(1, TS_FINISHED, TaskFlagTable[k], j[1], j[2])
		end
	end
	
--------------------------------gw ���Գ�ʼ���ݿ�ʼ --------------------------------------
			
--------------------------------gw ���Գ�ʼ���ݽ��� --------------------------------------

	-- ͬ����Ϣ���ͻ���
	SynTaskStatus(1)
	return
end

function CheckSchl(School)
	local Sch = GetPlayerData(0,GPP_SCHOOL)
	local schoolOK = 0
	if (nil ~= School) then
		if Sch == School then
			schoolOK = 1
		else
			schoolOK = 0
		end
	else
		schoolOK = 1
	end

	return schoolOK
end

function CheckLeve(Level)
	local Lev = GetPlayerData(0,GPP_LEVEL)
	local levelOK = 0
	if (nil ~= Level) then
		if (Lev >= Level[1] and Lev <= Level[2]) then
			levelOK = 1
		end
	else
		levelOK = 1
	end
	return levelOK
end
function CheckLeveNew(Level,Lev)
	local levelOK = 0
	if (nil ~= Level) then
		if (Lev >= Level[1] and Lev <= Level[2]) then
			levelOK = 1
		end
	else
		levelOK = 1
	end
	return levelOK
end
function CheckSex(Sex)
	local sex = GetPlayerData(0,GPP_SEX)
	local SexOK = 0
	if (nil ~= Sex) then
		if (sex == Sex) then
			SexOK = 1
		end
	else
		SexOK = 1
	end

	return SexOK
end

function CheckTask(AheadTask)
	local taskOK = 1

	if (nil == AheadTask) then
		return taskOK
	end

	if (nil ~= AheadTask.allNeed) then
		for k, v in pairs(AheadTask.allNeed) do
			local status = GetTaskStatus(v[1])
			if (status ~= v[2]) then
				taskOK = 0
				break
			end
		end
	end

	if (nil ~= AheadTask.oneNeed and 1 == taskOK) then
		taskOK = 0

		for k, v in pairs(AheadTask.oneNeed) do
			local status = GetTaskStatus(v[1])
			if (status == v[2]) then
				taskOK = 1
				break
			end
		end
	end

	return taskOK
end

function CheckAcceptCondition(npcid, condition, taskid)
	if (nil == npcid or nil == condition or nil == taskid or 'table' ~= type(condition)) then
		return false
	end

	if (0 == taskid) then
		return false
	end
	local schoolOK	= CheckSchl(condition.school)
	local levelOK	= CheckLeve(condition.level)
	local sexOK		= CheckSex(condition.sex)
	local taskOK	= CheckTask(condition.task)
	--rfalse("Task:"..taskid.."S:"..schoolOK.." L:"..levelOK.." S:"..sexOK.." T:"..taskOK.."")
	if (levelOK ~= 1) then
		--TalkToPlayer(2,"��ĵȼ����������ύ�������")
	end
	if (1 == schoolOK and 1 == levelOK and 1 == sexOK and 1 == taskOK) then
		return true
	else
		return false
	end
end

function GetNpcAccpetUplimt(NpcID)--�õ�Npc�ɽ���������
	return NpcTable[NpcID].NpcCreate.AcceptLimt;
end

function GetNpcIDByTaskID(taskID)
	return TaskTable[taskID].AcceptNpc
end
function OnHandleCycTask_Lua(taskID)
	local hed = TaskTable[taskID].HeadTotail
	local heda = TaskTable[taskID].Head
	local HeadTaskID = 0
	if (heda == nil) then --ͷΪnil �ַ��������������˵����ѭ������ �������1�����
		local Flag = false
		if (taskID > 50000 and taskID < 51200) then --ʦ������
			Flag = true
		elseif (taskID > 51200 and taskID < 51500) then	--��������A
			Flag = true
		elseif (taskID > 52000 and taskID < 53000) then	--�ɼ�����
			Flag = true
		elseif (taskID > 53000 and taskID < 54000) then	--��������
			Flag = true
		elseif (taskID > 54000 and taskID < 55000) then	--����ͬ��
			Flag = true
		elseif (taskID > 55000 and taskID < 56000) then	--�ݻ�����
			Flag = true
		elseif (taskID > 56000 and taskID < 57000) then	--Ԫ͢�߹�
			Flag = true
		elseif (taskID > 57000 and taskID < 58000) then	--������ս
			Flag = true
		elseif (taskID > 58000 and taskID < 59000) then	--����
			Flag = true
		end
		if (Flag == true) then
			--�������������
			local NpcID = TaskTable[taskID].AcceptNpc
			HeadTaskID = taskID
			OnHandleCycTask(NpcID)
		end
	end

	if (hed ~= nil) then--˵������������β��
		HeadTaskID = GetHeadIDByStr(hed)
		rfalse("HeadTaskID: "..HeadTaskID);
		local Flag = false
		if (HeadTaskID > 50000 and HeadTaskID < 51200) then --ʦ������
			Flag = true
		elseif (HeadTaskID > 51200 and HeadTaskID < 51500) then	--��������A
			Flag = true
		elseif (HeadTaskID > 52000 and HeadTaskID < 53000) then	--�ɼ�����
			Flag = true
		elseif (HeadTaskID > 53000 and HeadTaskID < 54000) then	--��������
			Flag = true
		elseif (HeadTaskID > 54000 and HeadTaskID < 55000) then	--����ͬ��
			Flag = true
		elseif (HeadTaskID > 55000 and HeadTaskID < 56000) then	--�ݻ�����
			Flag = true
		elseif (HeadTaskID > 56000 and HeadTaskID < 57000) then	--Ԫ͢�߹�
			Flag = true
		elseif (HeadTaskID > 57000 and HeadTaskID < 58000) then	--������ս
			Flag = true
		elseif (HeadTaskID > 58000 and HeadTaskID < 59000) then	--����
			Flag = true
		end
		if (Flag == true) then
			--�������������
			local NpcID = TaskTable[HeadTaskID].AcceptNpc
			OnHandleCycTask(NpcID)
		end
	end
	return HeadTaskID
end
function SendHandlableTask(npcid)
	if (nil == npcid) then
		return
	end

	-- �鿴������Npc�Ͽɽ�������
	if (TaskToNpc[npcid] ~= nil) then
		for k, v in pairs(TaskToNpc[npcid]) do
			local status = GetTaskStatus(v)
			if (status == TS_FINISHED) then
				SetTaskInfo(v, status)
			elseif (status == TS_ACCEPTED) then
				if ((TaskTable[v].CompleteCondition.get == nil) and (TaskTable[v].CompleteCondition.give == nil) and (TaskTable[v].CompleteCondition.talk == nil)) then
				--	rfalse("Task Can Handle:"..v.." Status:"..status.." Added".."")
					SetTaskInfo(v, status)
				else
					local foundGet  = 0
					local foundGive = 0
					local foundTalk = 0
					local compGet	= 1
					local compGive	= 2
					local compTalk	= 1

					if (TaskTable[v].CompleteCondition.get ~= nil) then
						for p, q in pairs(TaskTable[v].CompleteCondition.get) do
							if (q[1] == npcid) then
								foundGet = 1
								local completed = IsTaskFlagComplete(v, 5, npcid, q[2], q[3])
								if (completed == 0) then
									compGet = 0
									break
								end
							end
						end
					else
						compGet = 1
					end

					if (TaskTable[v].CompleteCondition.give ~= nil) then
						for p, q in pairs(TaskTable[v].CompleteCondition.give) do
							if (q[1] == npcid) then
								foundGive = 1
								local completed = IsTaskFlagComplete(v, 4, npcid, q[2], q[3])
								if (completed == 0 or completed == 1) then
									compGive = completed
									break
								end
							end
						end
					else
						compGive = 2
					end

					if (TaskTable[v].CompleteCondition.talk ~= nil) then
						
						for p, q in pairs(TaskTable[v].CompleteCondition.talk) do
							if (q[1] == npcid) then
								foundTalk = 1
								local completed = IsTaskFlagComplete(v, 3, npcid)
								if (completed == 0) then
									compTalk = 0
									break
								end
							end
						end
					else
						compTalk = 1
					end

					--rfalse("FoundGet:"..foundGet.." FoundGive:"..foundGive.." FoundTalk:"..foundTalk.."")
					--rfalse("CompGet:"..compGet.." CompGive:"..compGive.." CompTalk:"..compTalk.."")
					rfalse("CompleteCondition.talk  ---"..status)
					if (foundGet == 0 and foundGive == 0 and foundTalk == 0) then
						--rfalse("Task Can Handle 11: "..v.." Status:"..status.." Added".."")
						SetTaskInfo(v, status)
					else
						if (compGet == 1 and compGive == 2 and compTalk == 1) then
							--rfalse("Task Can Handle 22: "..v.." Status:"..status.." Added".."")
							SetTaskInfo(v, status)
						end
					end
				end
			end
		end
	end
end
function ProcessDaysCycTask(npcSID)
	--rfalse("dddddddddddddddddd����"..npcSID)
	local leftnum = GetRdTasksNum(npcSID)
	local rightnum = GetNpcAccpetUplimt(npcSID)
	--rfalse("leftnum  "..leftnum)
	--rfalse("rightnum  "..rightnum)
	if (GetRdNpcNum() > 80) then
		--rfalse("�ű����ݳ���")
	elseif (leftnum == nil or rightnum == nil) then
		--rfalse("�ű��������쳣")
	elseif (leftnum == rightnum) then
		TalkToPlayer(2,Prompt[1])
	elseif (leftnum < rightnum) then
		local Isrand = true
		local completeTasknum = 0
		for i, j in pairs(TaskFromNpc[npcSID]) do
			if(GetTaskStatus(j) > TS_NOTACCEPT and GetTaskStatus(j) < TS_COMPLETE) then
				if(Isrand == true) then
					Isrand = false
					TalkToPlayer(2, Prompt[2])
					--rfalse("TaskStatus"..GetTaskStatus(j).."")
				end
			end
			if(GetTaskStatus(j) == TS_COMPLETE) then
				completeTasknum = completeTasknum + 1
			end
		end
		local Tasknum = table.getn(TaskFromNpc[npcSID])
			if((Tasknum - completeTasknum) == 0) then
				TalkToPlayer(2, Prompt[3])
				Isrand = false
			end
		local TaskID = GetCurrentNpcTaskID(npcSID)--�¼ӽӿ�
		--rfalse("npcSID "..npcSID)
		--rfalse("TaskID:"..TaskID)
		if (TaskID == 0) then
			Isrand = false
			local LevoF = GetPlayerData(0,GPP_LEVEL)
			for k,v in pairs(TaskFromNpc[npcSID]) do
				local ltable = CheckLeve(TaskTable[v].AcceptCondition.level)
				local status = GetTaskStatus(v)
				--rfalse(ltable.."  "..status.."  "..v)
				if (ltable == 1 and TS_NOTACCEPT == status) then 
					Isrand = true
					--rfalse("dd")
					break
				end
			end
			--rfalse("ISrand:: "..Isrand)
			--if (Isrand == false) then
				--rfalse("�������������⣬����NPCID���������:  "..npcSID)
			--end
			while (Isrand == true) do --����ܽ��ڿ�ѡ�����������ѡ��һ��
				local Taskid  = math.random(1,Tasknum+1)
				Taskid = TaskFromNpc[npcSID][Taskid]
				local LevelFlag = CheckLeve(TaskTable[Taskid].AcceptCondition.level)
				local status = GetTaskStatus(Taskid)
				if (TS_NOTACCEPT == status and LevelFlag == 1) then
					local res = CheckAcceptCondition(npcSID, TaskTable[Taskid].AcceptCondition, Taskid)
					if (res == true) then
						--rfalse("Task Can Accepted:"..Taskid.." Status:"..status.." Added".."")
						SetTaskInfo(Taskid, status) --����������Ϣ
						InsertPlayerRdTaskInfo(npcSID,Taskid) --�¼ӽӿ� //��¼��ǰ�����Ѿ�����
						Isrand = false
					else
						Isrand = false
					end
				end
			end
		else
			local status = GetTaskStatus(TaskID)
			if (status == TS_NOTACCEPT) then
				SetTaskInfo(TaskID, status)
			end
		end
	end
end

function CommonNpcClick(npcSID)
	if (nil == npcSID or 0 == npcSID) then
		return
	end

	ClearPlayerInfo()
	-- ��������Ļ�ȡ��������
	if (nil ~= TaskGetInfo[npcSID]) then
		for i, j in pairs(TaskGetInfo[npcSID]) do
			rfalse("taskgetInfo" .. j)
			local status = GetTaskStatus(j)
			if (TS_ACCEPTED == status) then
				local completed = 1
				for p, q in pairs(TaskTable[j].CompleteCondition.get) do
					if (q[1] == npcSID) then
						completed = IsTaskFlagComplete(j, 5, npcSID, q[2], q[3])
						if (completed == 0) then
							break
						end
					end
				end

				if (completed == 0) then
					SetTaskInfo(j, TS_GET)
				end
			end
		end
	end
	-- �������������Ʒ����
	if (nil ~= TaskGiveInfo[npcSID]) then
		for i, j in pairs(TaskGiveInfo[npcSID]) do
			rfalse("TaskGiveInfo" .. j)			
			local status = GetTaskStatus(j)
			if (TS_ACCEPTED == status) then
				local completed = 2
				for p, q in pairs(TaskTable[j].CompleteCondition.give) do
					if (q[1] == npcSID) then
						completed = IsTaskFlagComplete(j, 4, npcSID, q[2], q[3])
						if (completed == 0 or completed == 1) then
							break
						end
					end
				end

				if (completed == 0 or completed == 1) then
					SetTaskInfo(j, TS_GIVE)
				end
			end
		end
	end
	-- ��������ĶԻ�����
	if (nil ~= TaskTalkInfo[npcSID]) then
		for i, j in pairs(TaskTalkInfo[npcSID]) do		
			local status = GetTaskStatus(j)
			rfalse("TaskTalkInfo:" .. j.."   TaskStatus ="..status.."\r\n")	
			if (TS_ACCEPTED == status) then
				local completed = IsTaskFlagComplete(j, 3, npcSID)
				if (completed == 0) then
					SetTaskInfo(j, TS_TALKIMME)
				end
			end
		end
	end

	if CheckEDTaskNpc(npcSID) == true then
		local PlayerTaskInfo = LoadPlayerTable("PlayerEDTask")  --����ճ�����
		if PlayerTaskInfo ~= nil then
			if PlayerTaskInfo.everydaytasktable ~= nil and GetTableLenth(PlayerTaskInfo.everydaytasktable) > 0 then
				for k,v in pairs(PlayerTaskInfo.everydaytasktable) do		
					local status = GetTaskStatus(v)
					if (TS_NOTACCEPT == status) then
						local res = CheckAcceptCondition(npcSID, TaskTable[v].AcceptCondition, v)
						if (res == true) then
							rfalse("EveryTask Can Accepted ID = :"..v.." Status:"..status.."")
							SetTaskInfo(v, status)
						end
					end
				end
			end
		end
	end
	local isaccept = 0
		-- ����ɽ�����
		if (nil ~= TaskFromNpc[npcSID]) then
			for k, v in pairs(TaskFromNpc[npcSID]) do
				local status = GetTaskStatus(v)	
--				rfalse("Task Status:"..k.." Status:"..status.."")
				if (TS_NOTACCEPT == status) then
					local res = CheckAcceptCondition(npcSID, TaskTable[v].AcceptCondition, v)
					if (res == true and v < 1000 ) then
						--rfalse("Task Can Accepted:"..v.." Status:"..status.." Added".."")
						SetTaskInfo(v, status)
						isaccept = 1
					end
				end
			end
		end
	


	-- �鿴������Npc�Ͽɽ�������
	SendHandlableTask(npcSID)
	-- ���Ͳ˵���Ϣ
	if (nil ~= NpcTable[npcSID].NpcMenu) then
		for k, v in pairs(NpcTable[npcSID].NpcMenu) do
			local schoolOK = CheckSchl(v.school)
			local levelOK  = CheckLeve(v.level)
			local sexOK    = CheckSex(v.sex)
			local taskOK   = CheckTask(v.task)
			if (1 == schoolOK and 1 == levelOK and 1 == sexOK and 1 == taskOK) then
				SetMenuInfo(v.id)
			end
		end
	end
	SetMessage(npcSID)
	if isaccept == 1 then  --���Ϳɽ�����
		SendRoleTaskInfo()
	end
end

function AcceptTask_InternalScript(npcScriptID, taskID)	
--	rfalse("npcScriptID:"..npcScriptID.." taskID:"..taskID)
	-- if TaskTable[taskID].mtdynamicregion ~= nil  then
	-- 	local regionId = TaskTable[taskID].mtdynamicregion[1]
	-- 	local x = TaskTable[taskID].mtdynamicregion[2]
	-- 	local y = TaskTable[taskID].mtdynamicregion[3]
	-- 	if PutPlayerToDynamicRegion(regionId,x,y) == nil then
	-- 		rfalse("PutPlayerToDynamicRegion "..regionId.."faile")
	-- 	end
	-- end

	-- if TaskTable[taskID].taskscene ~= nil  then
	-- 	local scenemap = TaskTable[taskID].taskscene[1]
	-- 	local sceneindex = TaskTable[taskID].taskscene[2]
	-- 	onSelectSceneMap(scenemap,sceneindex,taskID)
	-- end
	--PutPlayerToDynamicRegion(20000,20,15)	
	-- if (taskID == 2) then
		
	-- 	-- PutPlayerToEventRegion(20000,20,15)	
	-- 	rfalse("����"..taskID .."��������");
	-- end
end

function AcceptTask(npcScriptID, taskID)
	if (nil == npcScriptID or 0 == taskID) then
		return 0
	end

	if (nil == TaskFromNpc[npcScriptID]) then
		return 0
	end
	--rfalse("accepttask _ 1")
	-- ���Npc���Ƿ��д�����
	local hasTask = false
	for k, v in pairs(TaskFromNpc[npcScriptID]) do
		if (taskID == v ) then
			hasTask = true
			break
		end
	end

	if (hasTask == false ) then
		return 0
	end

	--rfalse("accepttask _ 2")
	-- ��������״̬
	local status = GetTaskStatus(taskID)
	if (status ~= TS_NOTACCEPT) then  --δ��
		return 0
	end

	--rfalse("accepttask _ 3")
	-- ����ܷ������
	local canAccept = CheckAcceptCondition(npcScriptID, TaskTable[taskID].AcceptCondition, taskID)

	if (canAccept == false) then
		return 0
	end

	-- �鿴�����ܷ������������
	if (nil ~= TaskTable[taskID].giveTool) then
		for k, v in pairs(TaskTable[taskID].giveTool) do
			local hasNumber = GetItemNum(v[1])
			if (hasNumber < v[2]) then
				CanAddItems(1, v[1], v[2]-hasNumber)
			end
		end

		local result = CanAddItems(2, 1, 1)
		if (0 == result) then
			TalkToPlayer(0, Prompt[7])
			return 0
		end
	end

	-- �ٴ��ж�����������������ظ����
	if (TaskTable[taskID].giveTool ~= nil ) then
		for k, v in pairs(TaskTable[taskID].giveTool) do
			local hasNumber = GetItemNum(v[1])
			if (hasNumber < v[2]) then
				GiveGoods(v[1], v[2]-hasNumber)
			end
		end
	end

	-- ���ˣ���������ǿ��Խӵģ�������������ͬ�����ͻ���
	local timelim = TaskTable[taskID].TimeLimit;
	SetTaskData(taskID,timelim)
	--GetTaskNextSceneIndex(taskID)   --������������Ĺؿ�

	local flagindex = 1
	for k, v in pairs(TaskTable[taskID].CompleteCondition) do
		for i, j in pairs(v) do
			if (k == 'give' or k == 'get' or k == 'map') then
				SetTaskFlag(taskID, flagindex, TaskFlagTable[k], j[1], j[3], j[2])
			else if k == 'addnew' then
				--if TaskNewFlagTable[j[1]] ~= nil then
					SetTaskFlag(taskID, flagindex, TaskFlagTable[k], j[1], j[2],j[3])
				--end
			else
				SetTaskFlag(taskID, flagindex, TaskFlagTable[k], j[1], j[2])
			end
			--rfalse("TaskType: "..k.." TaskFlagTable =  "..TaskFlagTable[k].."")
				--SetTaskFlag(taskID, flagindex, TaskFlagTable[k], j[1], j[2])
			end
			flagindex = flagindex + 1
		end
	end

	-- ͬ����Ϣ���ͻ���
	SynTaskStatus(taskID)

	-- �ж��Ƿ���Ҫ����CG
	if (nil ~= TaskTable[taskID].AcceptCGID) then
		PlayCG(TaskTable[taskID].AcceptCGID)
	end

	--�Ƿ�̬����npc
	local HandoverNpc = TaskTable[taskID].HandoverNpc
	if(NpcTable[HandoverNpc].NpcCreate.IsCreate ~= nil) then
		if(NpcTable[HandoverNpc].NpcCreate.IsCreate == 0) then
			CreateObjectIndirect(NpcTable[HandoverNpc].NpcCreate)
			NpcTable[HandoverNpc].NpcCreate.IsCreate = 1
		end
	end

	--�Ƿ�̬��������
	if type({}) == type (TaskTable[taskID].createmonster) then
	--	rfalse("createmonster")
		for k, mCreate in pairs(TaskTable[taskID].createmonster) do
			mCreate.refreshTime = -1
			mCreate.objectType = 0
			mCreate.mygid = CreateObjectIndirect(mCreate)
		end
	end

	--UpdateEDTask(taskID)
	return 1
end

function GiveUpTask(taskID)
	local status = GetTaskStatus(taskID)
	if (status == 1 or status == 4) then
		rfalse("status = "..status.."")
		return 0
	end


	--ɾ����ʱ������NPC
	local HandoverNpc = TaskTable[taskID].HandoverNpc
	if(NpcTable[HandoverNpc].NpcCreate.IsCreate ~= nil) then
		if(NpcTable[HandoverNpc].NpcCreate.IsCreate == 1) then
			RemoveObjectIndirect(NpcTable[HandoverNpc].NpcCreate.regionId, NpcTable[HandoverNpc].NpcCreate.controlId)
			NpcTable[HandoverNpc].NpcCreate.IsCreate = 0
		end
	end


	--ɾ����ʱ�����Ĺ���
	if type({}) == type (TaskTable[taskID].createmonster) then
		for k, mCreate in pairs(TaskTable[taskID].createmonster) do
			if (mCreate.mygid ~= 0) then
				DelMonster(mCreate.regionId,mCreate.mygid)
			end
		end
	end


	-- ɾ�������ӳ��
	DelTaskMap(taskID)

	-- ɾ��������Ϊ���ˣ�
	DelRoleTask(taskID, 1)

	return 1
end

function OnCycTask(taskID,HeadTaskID)--������ӿ�
	local ttype = TaskTable[taskID].taskType  --��������
	local cyctype = TaskTable[taskID].cyctype  --����ʱ������
	if (ttype == nil or ttype == 0 ) then
--		rfalse( "�����ճ����� " )
		return 0;
	end

	if (cyctype == nil) then
	    rfalse( "�ճ�����ID : "..taskID.."  û���ճ�ʱ������" )
		return 0;
	end

	if (TaskTable[taskID].HeadTotail == nil and ttype == 2) then
		rfalse( "�ճ�����ID: "..taskID.." û������������table")
		return 0;
	end
	OnPlayerCycTask(taskID,ttype,cyctype,HeadTaskID)
	return 1;
end

function GetClearCycTaskData(taskID)--����ж��������������
	local valstr = TaskTable[taskID].HeadTotail;
	local errstr = 'faile'
	if (valstr == nil) then
		return errstr
	else
		return valstr;
	end
end
function GetHeadFlagData(taskID)--����ж��������������
	local valstr = TaskTable[taskID].Head;
	if (valstr == nil) then
		return 0
	else
		return 1;
	end
end
function HandInTask(taskID, awardIndex)
	if (nil == TaskTable[taskID]) then		-- ������Ҫ����
		return 0
	end

	if (nil == awardIndex) then
		return 0
	end



	if (nil ~= TaskTable[taskID].CompleteAward.item and nil ~= TaskTable[taskID].CompleteAward.item.sel) then
		if (0 == awardIndex or awardIndex > #TaskTable[taskID].CompleteAward.item.sel) then
			rfalse("������:"..#TaskTable[taskID].CompleteAward.item.sel.."����ѡ���������ǽ�������ȴ��:"..awardIndex.."")
			return 0
		end
	end

	local status = GetTaskStatus(taskID)
--	rfalse("����״̬"..status)
	if (status ~= TS_FINISHED) then
		return 0
	end

	local hasAnyAward = false

	-- ��齱������ı����Ƿ��㹻�����ȱ����̶�����
	if (nil ~= TaskTable[taskID].CompleteAward.item and nil ~= TaskTable[taskID].CompleteAward.item.fix) then
		for k, v in pairs(TaskTable[taskID].CompleteAward.item.fix) do
			local SchoolOK	= CheckSchl(v.school)		-- ��ȡ����
			local SexOK 	= CheckSex(v.sex)			-- ��ȡ�Ա�

			if (1 == SchoolOK and 1 == SexOK) then
				hasAnyAward = true
				CanAddItems(1, v.itemid, v.itemnum)
			end
		
		end
	end

	-- ��ȡ��ѡ����
	if (nil ~= TaskTable[taskID].CompleteAward.item and nil ~= TaskTable[taskID].CompleteAward.item.sel) then
		local ItemID  = TaskTable[taskID].CompleteAward.item.sel[awardIndex][1]
		local ItemNum = TaskTable[taskID].CompleteAward.item.sel[awardIndex][2]
		hasAnyAward = true
		CanAddItems(1, ItemID, ItemNum)
	end

	if (true == hasAnyAward) then
		local result = CanAddItems(2, 1, 1)
		if (0 == result) then
			TalkToPlayer(2, Prompt[8])
			return 0
		end
	end

	-- �鿴�ܷ����յ���
	if (nil ~= TaskTable[taskID].RecycleItem and true == TaskTable[taskID].RecycleItem) then
		for k, v in pairs(TaskTable[taskID].CompleteCondition) do
			if ('item' == k) then
				for p, q in pairs(v) do
					local result = CheckGoods(q[1], q[2], 1)
					if (0 == result) then
						return
					end
				end
			end
		end
	end

	-- ɾ�������ӳ�䣨��ִ�е��߲���֮ǰ��һ��Ҫ��ɾ�������ӳ�䣬�������ɴ��󣡣���
	DelTaskMap(taskID)


	-- ִ�н���
	if (nil ~= TaskTable[taskID].CompleteAward.item and nil ~= TaskTable[taskID].CompleteAward.item.fix) then
		for k, v in pairs(TaskTable[taskID].CompleteAward.item.fix) do
		
			local SchoolOK	= CheckSchl(v.school)		-- ��ȡ����
			local SexOK 	= CheckSex(v.sex)			-- ��ȡ�Ա�

			if (1 == SchoolOK and 1 == SexOK) then
				rfalse("Fix:"..(v.itemid).." "..(v.itemnum).."")
				if GetItemIsEquip(v.itemid) == true and v.itemnum == 1 then
					local itempos = AddItem(v.itemid)
					if itempos >= 0 then
						RecvUseItem(itempos)	--װ��
						TalkToPlayer(2,MystringFormat("EQUIPTITEM"))
					end
				else
					GiveGoods(v.itemid, v.itemnum)
				end
			end
			
		end
	end

	if (nil ~= TaskTable[taskID].CompleteAward.item and nil ~= TaskTable[taskID].CompleteAward.item.sel) then
		local ItemID  = TaskTable[taskID].CompleteAward.item.sel[awardIndex][1]
		local ItemNum = TaskTable[taskID].CompleteAward.item.sel[awardIndex][2]
		
		if GetItemIsEquip(ItemID) == true and ItemNum == 1 then
		local itempos = AddItem(ItemID)
			if itempos >= 0 then
				RecvUseItem(itempos)	--װ��
				TalkToPlayer(2,MystringFormat("EQUIPTITEM"))
			end
		else
			GiveGoods(ItemID, ItemNum)
		end
	end

	--��������
	if TaskTable[taskID].CompleteAward.PetID ~= nil and type(TaskTable[taskID].CompleteAward.PetID) == "table" then
		for n, v in pairs(TaskTable[taskID].CompleteAward.PetID) do
			UsePetItemGet(v)
		end
	end

	-- ��������
	if (TaskTable[taskID].CompleteAward.exps ~= nil) then
		GiveExp(TaskTable[taskID].CompleteAward.exps)
	end

	-- ��������
	if (TaskTable[taskID].CompleteAward.Sp ~= nil ) then
		GiveSp(TaskTable[taskID].CompleteAward.Sp)
	end

	-- ������Ǯ
	if (TaskTable[taskID].CompleteAward.money ~= nil) then
		--GiveMoney(1, TaskTable[taskID].CompleteAward.money)
		ChangeMoney(2,TaskTable[taskID].CompleteAward.money)
	end

	--�������Ԫ��
	if TaskTable[taskID].CompleteAward.gold ~= nil then
		ChangeMoney(1,TaskTable[taskID].CompleteAward.gold)
	end

	-- ���յ���
	if (nil ~= TaskTable[taskID].RecycleItem and true == TaskTable[taskID].RecycleItem) then
		for k, v in pairs(TaskTable[taskID].CompleteCondition) do
			if ('item' == k) then
				for p, q in pairs(v) do
					CheckGoods(q[1], q[2], 0)
				end
			end
		end
	end
--	rfalse("-- ɾ��������Ϊ���ˣ�"..taskID)
	-- ɾ��������Ϊ���ˣ�
	local flag = DelRoleTask(taskID, 0)
	if (flag == 1) then
		local HeadTaskID = OnHandleCycTask_Lua(taskID)
		OnCycTask(taskID,HeadTaskID)
	else
	  rfalse("-- OnCycTaskʧ��")
	end

	local HandoverNpc = TaskTable[taskID].HandoverNpc
	local Iscreated = NpcTable[HandoverNpc].NpcCreate.IsCreate
	if(Iscreated ~= nil and Iscreated == 1) then
	    RemoveObjectIndirect(NpcTable[HandoverNpc].NpcCreate.regionId, NpcTable[HandoverNpc].NpcCreate.controlId)
		NpcTable[HandoverNpc].NpcCreate.IsCreate = 0
	end

	CompleteEDTask(taskID) --����ճ��������
	return 1
end



function GetUIPageType(NpcSid)
	local Flag = NpcTable[NpcSid].NpcCreate.Page
	if (Flag == 1) then
		--rfalse("֧�ַ�ҳNpcID: "..NpcSid)
		return 0
	else
		--rfalse("��֧�ַ�ҳNpcID: "..NpcSid)
		return 1
	end
end

function CheckEveryDayTask() --ÿ������
	ClearPlayerInfo()
	local PlayerTaskInfo = LoadPlayerTable("PlayerEDTask")  --����ճ�����
	if PlayerTaskInfo == nil then
		PlayerTaskInfo = {}
		PlayerTaskInfo.everydaytask = 0   --ÿ���Ѿ���ɵ��ճ�����
		PlayerTaskInfo.everydaytasktotal = 0  --�ۼƵ�½������ʣ��û����ɵ��ճ�����
		PlayerTaskInfo.everydaytasktable = {} --ÿ�տɽ������б������ɽӵ�����
	end

	local LastLeavetime = GetPlayerTime(1) --�ϴ�����ʱ��
	local currenttime = GetPlayerTime(3) --��ǰʱ��

	local nowdate = tonumber(os.date("%Y%m%d",currenttime))		--����������
	local weekday = tonumber(os.date("%Y%m%d",LastLeavetime))	--����������
	--rfalse("nowdate = "..nowdate.."  weekday = "..weekday.." LastLeavetime = "..LastLeavetime.."")
	if true then
		return
	end

	if LastLeavetime > 0 then
		local passday = nowdate - weekday
		if passday > 0 then
			PlayerTaskInfo.everydaytask = 0   --ÿ���Ѿ���ɵ��ճ�����
			PlayerTaskInfo.everydaytasktable = {} --ÿ�տɽ������б������ɽӵ�����
			rfalse("clear everydaytask")
		end
	end

	if PlayerTaskInfo.everydaytasktable ~= nil and GetTableLenth(PlayerTaskInfo.everydaytasktable) > 0 then
		for k,v in pairs(PlayerTaskInfo.everydaytasktable) do		
			local status = GetTaskStatus(v)
			if (TS_NOTACCEPT == status) then
				local res = CheckAcceptCondition(1, TaskTable[v].AcceptCondition, v)
				if (res == true) then
					rfalse("Task Can Accepted ID = :"..v.." Status:"..status.."")
					SetTaskInfo(v, status)
				end
			end
		end
	else
		if TaskConfig ~= nil then
			local Lev = GetPlayerData(0,GPP_LEVEL)
			for k,v in pairs(TaskConfig) do
				if v.Level ~= nil then
					if Lev >= v.Level[1] and Lev <= v.Level[2] then
						local randnum = v.Tasknum
						if randnum > PlayerTaskInfo.everydaytask then
							randnum = randnum - PlayerTaskInfo.everydaytask
							if randnum > math.abs(v.TaskidTable[1] - v.TaskidTable[2]) then
								rfalse("randnum > tasknum "..randnum.."")
								return
							end
							rfalse("randnum = "..randnum.."")
							local i = 1
							while true do
								local taskid = LuaRandRange(v.TaskidTable[1],v.TaskidTable[2])
								local status = GetTaskStatus(taskid)	
								if TaskTable[taskid] ~= nil then
									if GetTableValueIsRepeat(PlayerTaskInfo.everydaytasktable,taskid) == false then
										if (TS_NOTACCEPT == status) then
											local res = CheckAcceptCondition(v.TaskFromNpc, TaskTable[taskid].AcceptCondition, taskid)
											if (res == true) then
												rfalse("Task Can Accepted ID = :"..taskid.." Status:"..status.."")
												SetTaskInfo(taskid, status)
												table.insert(PlayerTaskInfo.everydaytasktable,taskid)
												i = i + 1
											end
										end
									end
								end
								if i > randnum then
									break
								end
								--i = i+1
							end
							-- for i=1,randnum do

	
							-- end
						end
					end
				end
			end
		end
	end
	SendRoleTaskInfo()
	WeekReturnChargeData("PlayerEDTask",PlayerTaskInfo)
end

function CheckEDTaskNpc(NpcSid) --�Ƿ�Ϊ�����ճ�����NPC
	if TaskConfig ~= nil then
		for k,v in pairs(TaskConfig) do
			if v.TaskFromNpc == NpcSid then
				return true
			end
		end
	end
	return false
end

function CompleteEDTask(taskid) --����ճ�����
	local PlayerTaskInfo = LoadPlayerTable("PlayerEDTask")  --����ճ�����
	if PlayerTaskInfo ~= nil then
		if PlayerTaskInfo.everydaytasktable ~= nil then
			for k,v in pairs(PlayerTaskInfo.everydaytasktable) do
				if v == taskid then  --��ҽ��յ��ճ�����
					RemoveFromTable(PlayerTaskInfo.everydaytasktable,taskid)  --�Ƴ�����
					PlayerTaskInfo.everydaytask = PlayerTaskInfo.everydaytask + 1 --��������1
					WeekReturnChargeData("PlayerEDTask",PlayerTaskInfo)
					rfalse("CompleteEDTask "..PlayerTaskInfo.everydaytask.."")
					break
				end
			end
		end
	end
end

function CheckTaskState( )
	for k,v in pairs(TaskTable) do
		local status = GetTaskStatus(k)
		--rfalse("CheckTaskState  id = "..k.."   status = "..status.."")
		if status == TS_ACCEPTED or status == TS_FINISHED then
			rfalse("CheckTaskState  id = "..k.."")
		elseif status == TS_COMPLETE then
			rfalse("TS_COMPLETE  id = "..k.."")
		end
	end
end

function UpdateEDTask(taskid) --�����ճ�����״̬
	local bisupdata = 0
	ClearPlayerInfo()
	local PlayerTaskInfo = LoadPlayerTable("PlayerEDTask")  --����ճ�����
	if PlayerTaskInfo ~= nil then
		if PlayerTaskInfo.everydaytasktable ~= nil then
			for k,v in pairs(PlayerTaskInfo.everydaytasktable) do
				if v == taskid then  --��ҽ��յ��ճ�����
					local status = GetTaskStatus(taskid)	
					rfalse("UpdateEDTask taskid = "..taskid.."status = "..status.."")
					SetTaskInfo(taskid,status)
					bisupdata = 1	
				end
			end
		end
	end
	if bisupdata == 1 then
		SendRoleTaskInfo()
	end	
end

function CheckTaskAccept() --���߼���ܽ�ȡ������
	local isaccept = 0
	for k,v in pairs(NpcTable) do
		if (nil ~= TaskFromNpc[k]) then
			for k, v in pairs(TaskFromNpc[k]) do
				local status = GetTaskStatus(v)	
	--				rfalse("Task Status:"..k.." Status:"..status.."")
				if (TS_NOTACCEPT == status) then
					local res = CheckAcceptCondition(k, TaskTable[v].AcceptCondition, v)
					if (res == true and v < 1000 ) then
						rfalse("Task Can Accepted:"..v.." Status:"..status.." Added".."")
						SetTaskInfo(v, status)
						isaccept = 1
					end
				end
			end
		end
	end

	if isaccept == 1 then
		SendRoleTaskInfo()
	end
end