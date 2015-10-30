TaskTable = {}
dofile("XYD3Script\\Task\\������.lua")
--dofile("XYD3Script\\Task\\������װ��.lua")
dofile("XYD3Script\\Task\\TaskEveryDay.lua")
dofile("XYD3Script\\Task\\߱��1-10��Task.lua")
dofile("XYD3Script\\Task\\TaskConfig.lua")
--dofile("XYD3Script\\Task\\����ʦ������Task.lua")
--dofile("XYD3Script\\Task\\����ʦ������Task.lua")
--dofile("XYD3Script\\Task\\����ʦ������Task.lua")
--dofile("XYD3Script\\Task\\��ɽʦ������Task.lua")
--dofile("XYD3Script\\Task\\��������Task.lua")
--dofile("XYD3Script\\Task\\�ճ�Ѱ������Task.lua")
--dofile("XYD3Script\\Task\\�ճ��ɼ�Task.lua")
--dofile("XYD3Script\\Task\\����Ѱ·Server.lua")

TaskFromNpc   = {}		-- NPC��NPC�����ص������ӳ���
TaskToNpc     = {}		-- NPC��NPC���ܽ������ӳ���
TaskTalkInfo  = {}		-- NPC��Ҫ�����Ի��������б�
TaskGiveInfo  = {}		-- NPC��Ҫ���������������б�
TaskGetInfo   = {}      -- NPC��NPC��Ҫ�����ߵ�ӳ���

-- ����������ñ�
TaskFlagTable =
{
	item  	= 1,		-- ��Ʒ����
	kill  	= 2,		-- ɱ��
	talk  	= 3,		-- �Ի�
	give  	= 4,		-- ����Ʒ
	get  	= 5,		-- ��ȡ��Ʒ
	useitem = 6,		-- ʹ�õ���
	map 	= 7,		-- �ܵ�ͼ
	scene 	= 8,		-- �ؿ�
	addnew  = 9,		--��������
	empty	= 100,		-- �����
}

-- ��������������ñ�
TaskNewFlagTable =
{
	TASK_EINTENSIFY = 0 , --װ��ǿ��
	TASK_EJDING = 1, -- //װ������
	TASK_ERISE = 2,-- //װ������
	TASK_EKEYIN = 3 , --//װ����ӡ
	TASK_EQUALITY = 4 ,-- //װ������
	TASK_XINYANG = 5, --//��������
	TASK_TRANSFORMERS = 6,--//��������
	TASK_SKILL = 7, --//�������� ��������
	TASK_SCENE = 8 ,--//�ؿ���ɴ���
}




-- ������������NPC���������Ϣ
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

