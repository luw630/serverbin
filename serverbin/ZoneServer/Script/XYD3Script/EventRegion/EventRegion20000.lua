-----------------------------------------------------------------------------------------
-----副本基本数据-----
EventRegion[20000] =
{
	MapID 	= 100,

	Npc   	=
	{
	},

	Monster =--根据需要来配置任务怪，没有AI, 也不能作为退出副本的判断条件。（传统的任务普通怪）
	{
		{monsterId = 2, x = 20, y = 20, refreshTime = 36000000, objectType = 0},
		{monsterId = 2, x = 20, y = 18, refreshTime = 36000000, objectType = 0},
	},
	MonsterCount = 2,				--总共要出多少怪
}

-----副本怪物数据-----
EventRegionList[20000] =
{
	--每个AIID代表了怪物应该有的行为
  AIMonsterList =
  {
		{monsterId = 2, x = 30, y = 30, refreshTime = 36000000, AIID = 1, GroupID=2},
		--GroupID：怪物的阵营，如果阵营不同，怪物之间要互相攻击, 玩家的阵营ID缺省是1
		--这里的X,Y是怪物的出身点
		--refreshTime：怪物的刷新时间
		--AIID =1 基础类型的BOSS, 杀之就会传出副本
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
	
	--创建AI怪物
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
			local Msg ="副本结束倒计时：" .. (11-g_TimeCtrl[regionGID]);
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
