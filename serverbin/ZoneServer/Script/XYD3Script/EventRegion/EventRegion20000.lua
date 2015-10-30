-----------------------------------------------------------------------------------------
-----������������-----
EventRegion[20000] =
{
	MapID 	= 100,

	Npc   	=
	{
	},

	Monster =--������Ҫ����������֣�û��AI, Ҳ������Ϊ�˳��������ж�����������ͳ��������ͨ�֣�
	{
		{monsterId = 2, x = 20, y = 20, refreshTime = 36000000, objectType = 0},
		{monsterId = 2, x = 20, y = 18, refreshTime = 36000000, objectType = 0},
	},
	MonsterCount = 2,				--�ܹ�Ҫ�����ٹ�
}

-----������������-----
EventRegionList[20000] =
{
	--ÿ��AIID�����˹���Ӧ���е���Ϊ
  AIMonsterList =
  {
		{monsterId = 2, x = 30, y = 30, refreshTime = 36000000, AIID = 1, GroupID=2},
		--GroupID���������Ӫ�������Ӫ��ͬ������֮��Ҫ���๥��, ��ҵ���ӪIDȱʡ��1
		--�����X,Y�ǹ���ĳ����
		--refreshTime�������ˢ��ʱ��
		--AIID =1 �������͵�BOSS, ɱ֮�ͻᴫ������
  },
}

PathList[20000] =
{
  AIPath_1 =
  {
	--{x = 211, 	y = 203},
  },
}

-----------------------------------------------------------------------------------------
g_TimeCtrl = {}

function Init_20000(regionGID,regionID)
	g_TimeCtrl[regionGID] = 0
	
	--����AI����
	local mCreateAI = EventRegionList[regionID].AIMonsterList[1]
	mCreateAI.RegionGID = regionGID
    CreateAIMonster(mCreateAI,PathList[regionID].AIPath_1)	
end

function Run_20000(regionGID, RegionExistTime,RegionID)
end

function End_20000(regionGID, RegionExistTime, RegionEndTime,regionID,EventRegionEnd)

	local nTime = RegionEndTime / 1000;
    nTime = math.floor (nTime)
	if(nTime - g_TimeCtrl[regionGID] > 1) then
		g_TimeCtrl[regionGID] = g_TimeCtrl[regionGID] + 1
		if (g_TimeCtrl[regionGID]==1 or g_TimeCtrl[regionGID]==6 or g_TimeCtrl[regionGID]==10) then
			local Msg ="������������ʱ��" .. (11-g_TimeCtrl[regionGID]);
			rfalse(Msg)
			SendMsgForEventRegion(regionGID, Msg);
		end
	end

	if (g_TimeCtrl[regionGID]==12) then
		PutPlayerForEventRegion(true, regionGID)
		g_TimeCtrl[regionGID] = nil
	end	
end
-----------------------------------------------------------------------------------------
