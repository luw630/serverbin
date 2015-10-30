TaskTable[51201] =
{
	TaskTitle			= "�����͡��ռ�",
	TaskInfo  			= "",

	AcceptNpc			= 58,
	HandoverNpc 		= 47,
	RecycleItem			= true,
    Head = 1,

	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = nil,
	},

	CompleteCondition =
	{
		item	=  {{2530011,3}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51501] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",

	AcceptNpc			= 47,
	HandoverNpc 		= 49,


	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51201, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		kill	=  {{54,10}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51502] =
{
	TaskTitle			= "�����͡�Ϯ��",
	TaskInfo  			= "",

	AcceptNpc			= 49,
	HandoverNpc 		= 50,
	RecycleItem			= true,
	giveTool			= {{3100512,1}},

	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51501, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		useitem	=  {{3100512,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51503] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",

	AcceptNpc			= 50,
	HandoverNpc 		= 57,


	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51502, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		talk	=  {{513,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51504] =
{
	TaskTitle			= "�����͡��ս�",
	TaskInfo  			= "",

	AcceptNpc			= 57,
	HandoverNpc 		= 44,
	RecycleItem			= true,

	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51503, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{3100530,5}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51505] =
{
	TaskTitle			= "�����͡���̽",
	TaskInfo  			= "",

	AcceptNpc			= 44,
	HandoverNpc 		= 58,
	taskType            = 2,		--�C��������(	2�������)
	cyctype             = 1,
    HeadTotail ="51201:51501:51502:51503:51504:51505",


	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51504, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		map	=  {{2,293,988}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51202] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",

	AcceptNpc			= 58,
	HandoverNpc 		= 49,
    Head = 1,

	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = nil,
	},

	CompleteCondition =
	{
		kill	=  {{66,10}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51506] =
{
	TaskTitle			= "�����͡��ռ�",
	TaskInfo  			= "",

	AcceptNpc			= 49,
	HandoverNpc 		= 47,
	RecycleItem			= true,

	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51202, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{2530012,3}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51507] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",

	AcceptNpc			= 47,
	HandoverNpc 		= 57,

	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51506, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		talk	=  {{514,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51508] =
{
	TaskTitle			= "�����͡��ս�",
	TaskInfo  			= "",

	AcceptNpc			= 57,
	HandoverNpc 		= 44,
	RecycleItem			= true,

	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51507, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{3100531,5}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51509] =
{
	TaskTitle			= "�����͡���̽",
	TaskInfo  			= "",

	AcceptNpc			= 44,
	HandoverNpc 		= 50,


	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51508, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		map	=  {{2,937,1272}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51510] =
{
	TaskTitle			= "�����͡�Ϯ��",
	TaskInfo  			= "",

	AcceptNpc			= 50,
	HandoverNpc 		= 58,
	RecycleItem			= true,
	giveTool			= {{3100513,1}},
	taskType            = 2,		--�C��������(	2�������)
	cyctype             = 1,
    HeadTotail ="51202:51506:51507:51508:51509:51510",

	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51509, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		useitem	=  {{3100513,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51203] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",

	AcceptNpc			= 58,
	HandoverNpc 		= 50,
	RecycleItem			= true,
	giveTool			= {{3100403,1}},
    Head = 1,

	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = nil,
	},

	CompleteCondition =
	{
		useitem	=  {{3100403,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51511] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",

	AcceptNpc			= 50,
	HandoverNpc 		= 57,


	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51203, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		talk	=  {{516,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51512] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",

	AcceptNpc			= 57,
	HandoverNpc 		= 49,


	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51511, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		kill	=  {{56,10}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51513] =
{
	TaskTitle			= "�����͡���̽",
	TaskInfo  			= "",

	AcceptNpc			= 49,
	HandoverNpc 		= 44,


	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51512, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		map	=  {{2,1341,488}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51514] =
{
	TaskTitle			= "�����͡��ռ�",
	TaskInfo  			= "",

	AcceptNpc			= 44,
	HandoverNpc 		= 47,
	RecycleItem			= true,

	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51513, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{2530020,3}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51515] =
{
	TaskTitle			= "�����͡��ս�",
	TaskInfo  			= "",

	AcceptNpc			= 47,
	HandoverNpc 		= 58,
	RecycleItem			= true,
	taskType            = 2,		--�C��������(	2�������)
	cyctype             = 1,
    HeadTotail ="51203:51511:51512:51513:51514:51515",

	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51514, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{3100532,5}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51204] =
{
	TaskTitle			= "�����͡��ս�",
	TaskInfo  			= "",

	AcceptNpc			= 58,
	HandoverNpc 		= 44,
	RecycleItem			= true,
    Head = 1,

	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = nil,
	},

	CompleteCondition =
	{
		item	=  {{3100405,5}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51516] =
{
	TaskTitle			= "�����͡���̽",
	TaskInfo  			= "",

	AcceptNpc			= 44,
	HandoverNpc 		= 49,


	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51204, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		map	=  {{2,691,687}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51517] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",

	AcceptNpc			= 49,
	HandoverNpc 		= 50,


	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51516, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		talk	=  {{517,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51518] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",

	AcceptNpc			= 50,
	HandoverNpc 		= 57,


	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51517, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		kill	=  {{69,10}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51519] =
{
	TaskTitle			= "�����͡��ռ�",
	TaskInfo  			= "",

	AcceptNpc			= 57,
	HandoverNpc 		= 47,
	RecycleItem			= true,

	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51518, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{2530065,3}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51520] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",

	AcceptNpc			= 47,
	HandoverNpc 		= 58,
	RecycleItem			= true,
	giveTool			= {{3100515,1}},
	taskType            = 2,		--�C��������(	2�������)
	cyctype             = 1,
    HeadTotail ="51204:51516:51517:51518:51519:51520",

	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51519, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		useitem	=  {{3100515,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51205] =
{
	TaskTitle			= "�����͡���̽",
	TaskInfo  			= "",

	AcceptNpc			= 58,
	HandoverNpc 		= 57,
    Head = 1,

	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = nil,
	},

	CompleteCondition =
	{
		map	=  {{2,1227,980}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51521] =
{
	TaskTitle			= "�����͡��ռ�",
	TaskInfo  			= "",

	AcceptNpc			= 57,
	HandoverNpc 		= 47,
	RecycleItem			= true,

	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51205, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{2530002,3}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51522] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",

	AcceptNpc			= 47,
	HandoverNpc 		= 49,

	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51521, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		kill	=  {{70,10}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51523] =
{
	TaskTitle			= "�����͡��ź�",
	TaskInfo  			= "",

	AcceptNpc			= 49,
	HandoverNpc 		= 44,
	giveTool			= {{3100516,1}},
	RecycleItem			= true,

	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51522, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		useitem	=  {{3100516,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51524] =
{
	TaskTitle			= "�����͡��ս�",
	TaskInfo  			= "",

	AcceptNpc			= 44,
	HandoverNpc 		= 50,
	RecycleItem			= true,

	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51523, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{3100533,5}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51525] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",

	AcceptNpc			= 50,
	HandoverNpc 		= 58,
	taskType            = 2,		--�C��������(	2�������)
	cyctype             = 1,
    HeadTotail ="51205:51521:51522:51523:51524:51525",

	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51524, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		talk	=  {{540,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51206] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",

	AcceptNpc			= 58,
	HandoverNpc 		= 6,
	Head = 1,

	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = nil,
	},

	CompleteCondition =
	{
		talk	=  {{547,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51526] =
{
	TaskTitle			= "�����͡��ս�",
	TaskInfo  			= "",

	AcceptNpc			= 6,
	HandoverNpc 		= 50,
	RecycleItem			= true,

	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51206, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{3100534,5}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51527] =
{
	TaskTitle			= "�����͡��ռ�",
	TaskInfo  			= "",

	AcceptNpc			= 50,
	HandoverNpc 		= 44,
	RecycleItem			= true,

	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51526, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{2530009,3}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51528] =
{
	TaskTitle			= "�����͡���̽",
	TaskInfo  			= "",

	AcceptNpc			= 44,
	HandoverNpc 		= 57,


	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51527, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		map	=  {{2,548,229}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51529] =
{
	TaskTitle			= "�����͡�Ϯ��",
	TaskInfo  			= "",

	AcceptNpc			= 57,
	HandoverNpc 		= 49,
	RecycleItem			= true,
	giveTool			= {{3100526,1}},

	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51528, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		useitem	=  {{3100526,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51530] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",

	AcceptNpc			= 49,
	HandoverNpc 		= 58,
	taskType            = 2,		--�C��������(	2�������)
	cyctype             = 1,
    HeadTotail ="51206:51526:51527:51528:51529:51530",

	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = {{51529, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		kill	=  {{73,10}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51207] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",

	AcceptNpc			= 58,
	HandoverNpc 		= 43,
    Head = 1,

	AcceptCondition =
	{
		school 	= nil,
		level	= {20,150},
		sex		= nil,
		task    = {
					allNeed = nil,
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		kill	=  {{68,10}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51531] =
{
	TaskTitle			= "�����͡�Ϯ��",
	TaskInfo  			= "",


	AcceptNpc			= 43,	-- ������Npc
	HandoverNpc 		= 43,	-- ������Npc
	RecycleItem			= true,
	giveTool            = {{3100528,1}},

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51207, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		useitem = {{3100528,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51532] =
{
	TaskTitle			= "�����͡���̽",
	TaskInfo  			= "",


	AcceptNpc			= 43,	-- ������Npc
	HandoverNpc 		= 51,	-- ������Npc

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51531, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		map  =  {{2,247,759}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51533] =
{
	TaskTitle			= "�����͡��ռ�",
	TaskInfo  			= "",


	AcceptNpc			= 51,	-- ������Npc
	HandoverNpc 		= 51,	-- ������Npc
	RecycleItem			= true,

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51532, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{2530011,3}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51534] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 51,	-- ������Npc
	HandoverNpc 		= 46,	-- ������Npc


	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51533, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		talk = {{518,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51535] =
{
	TaskTitle			= "�����͡��ս�",
	TaskInfo  			= "",


	AcceptNpc			= 46,	-- ������Npc
	HandoverNpc 		= 58,	-- ������Npc
	RecycleItem			= true,
	taskType            = 2,		--�C��������(	2�������)
	cyctype             = 1,
    HeadTotail ="51207:51531:51532:51533:51534:51535",

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51534, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{3100535,5}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51208] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 58,	-- ������Npc
	HandoverNpc 		= 51,	-- ������Npc
    Head = 1,

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = nil,
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		talk = {{515,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51536] =
{
	TaskTitle			= "�����͡�Ϯ��",
	TaskInfo  			= "",


	AcceptNpc			= 51,	-- ������Npc
	HandoverNpc 		= 51,	-- ������Npc
	RecycleItem			= true,
	giveTool            = {{3100527,1}},

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51208, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		useitem = {{3100527,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51537] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 51,	-- ������Npc
	HandoverNpc 		= 46,	-- ������Npc

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51536, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
	    kill	=  {{74,10}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51538] =
{
	TaskTitle			= "�����͡���̽",
	TaskInfo  			= "",


	AcceptNpc			= 46,	-- ������Npc
	HandoverNpc 		= 46,	-- ������Npc

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51537, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		map  =  {{2,548,587}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51539] =
{
	TaskTitle			= "�����͡��ս�",
	TaskInfo  			= "",


	AcceptNpc			= 46,	-- ������Npc
	HandoverNpc 		= 43,	-- ������Npc
	RecycleItem			= true,

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51538, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{3100536,5}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51540] =
{
	TaskTitle			= "�����͡��ռ�",
	TaskInfo  			= "",


	AcceptNpc			= 43,	-- ������Npc
	HandoverNpc 		= 58,	-- ������Npc
	RecycleItem			= true,
	taskType            = 2,		--�C��������(	2�������)
	cyctype             = 1,
    HeadTotail ="51208:51536:51537:51538:51539:51540",

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51539, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{2530065,3}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51209] =
{
	TaskTitle			= "�����͡��ս�",
	TaskInfo  			= "",


	AcceptNpc			= 58,	-- ������Npc
	HandoverNpc 		= 46,	-- ������Npc
	RecycleItem			= true,
    Head = 1,

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = nil,
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{3100406,5}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51541] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 46,	-- ������Npc
	HandoverNpc 		= 46,	-- ������Npc

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51209, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		talk = {{508,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51542] =
{
	TaskTitle			= "�����͡��ռ�",
	TaskInfo  			= "",


	AcceptNpc			= 46,	-- ������Npc
	HandoverNpc 		= 43,	-- ������Npc
	RecycleItem			= true,

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51541, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{2530012,3}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}

TaskTable[51543] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 43,	-- ������Npc
	HandoverNpc 		= 43,	-- ������Npc

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51542, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
	    kill	=  {{54,10}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51544] =
{
	TaskTitle			= "�����͡���̽",
	TaskInfo  			= "",


	AcceptNpc			= 43,	-- ������Npc
	HandoverNpc 		= 51,	-- ������Npc

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51543, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		map  =  {{2,676,370}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51545] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 51,	-- ������Npc
	HandoverNpc 		= 58,	-- ������Npc
	RecycleItem			= true,
	giveTool            = {{3100514,1}},
	taskType            = 2,		--�C��������(	2�������)
	cyctype             = 1,
    HeadTotail ="51209:51541:51542:51543:51544:51545",

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51544, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		useitem = {{3100514,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51210] =
{
	TaskTitle			= "�����͡��ռ�",
	TaskInfo  			= "",


	AcceptNpc			= 58,	-- ������Npc
	HandoverNpc 		= 501,	-- ������Npc
	RecycleItem			= true,
    Head = 1,

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = nil,
	},

	CompleteCondition =
	{
		item	=  {{2560002,3}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51546] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 501,	-- ������Npc
	HandoverNpc 		= 502,	-- ������Npc

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51210, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
	    kill	=  {{202,10}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51547] =
{
	TaskTitle			= "�����͡��ź�",
	TaskInfo  			= "",


	AcceptNpc			= 502,	-- ������Npc
	HandoverNpc 		= 503,	-- ������Npc
	RecycleItem			= true,
	giveTool            = {{3100517,1}},

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51546, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		useitem = {{3100517,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51548] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 503,	-- ������Npc
	HandoverNpc 		= 504,	-- ������Npc

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51547, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		talk = {{1004,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51549] =
{
	TaskTitle			= "�����͡��ս�",
	TaskInfo  			= "",


	AcceptNpc			= 504,	-- ������Npc
	HandoverNpc 		= 512,	-- ������Npc
	RecycleItem			= true,

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51548, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{3100537,5}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51550] =
{
	TaskTitle			= "�����͡���̽",
	TaskInfo  			= "",


	AcceptNpc			= 512,	-- ������Npc
	HandoverNpc 		= 58,	-- ������Npc
	taskType            = 2,		--�C��������(	2�������)
	cyctype             = 1,
    HeadTotail ="51210:51546:51547:51548:51549:51550",

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51549, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		map  =  {{4,474,301}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51211] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 58,	-- ������Npc
	HandoverNpc 		= 502,	-- ������Npc
    Head = 1,

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = nil,
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
	    kill	=  {{216,10}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51551] =
{
	TaskTitle			= "�����͡��ռ�",
	TaskInfo  			= "",


	AcceptNpc			= 502,	-- ������Npc
	HandoverNpc 		= 504,	-- ������Npc
	RecycleItem			= true,

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51211, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{2560005,3}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51552] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 504,	-- ������Npc
	HandoverNpc 		= 512,	-- ������Npc

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51551, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		talk = {{1005,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51553] =
{
	TaskTitle			= "�����͡��ս�",
	TaskInfo  			= "",


	AcceptNpc			= 512,	-- ������Npc
	HandoverNpc 		= 503,	-- ������Npc
	RecycleItem			= true,

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51552, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{3100538,5}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51554] =
{
	TaskTitle			= "�����͡���̽",
	TaskInfo  			= "",


	AcceptNpc			= 503,	-- ������Npc
	HandoverNpc 		= 501,	-- ������Npc

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51553, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		map  =  {{4,198,1196}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51555] =
{
	TaskTitle			= "�����͡�Ϯ��",
	TaskInfo  			= "",


	AcceptNpc			= 501,	-- ������Npc
	HandoverNpc 		= 58,	-- ������Npc
	RecycleItem			= true,
	giveTool            = {{3100518,1}},
	taskType            = 2,		--�C��������(	2�������)
	cyctype             = 1,
    HeadTotail ="51211:51551:51552:51553:51554:51555",

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51554, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		useitem = {{3100518,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51212] =
{
	TaskTitle			= "�����͡�·��",
	TaskInfo  			= "",


	AcceptNpc			= 58,	-- ������Npc
	HandoverNpc 		= 503,	-- ������Npc
	RecycleItem			= true,
	giveTool            = {{3100519,1}},
    Head = 1,

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = nil,
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		useitem = {{3100519,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51556] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 503,	-- ������Npc
	HandoverNpc 		= 512,	-- ������Npc

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51212, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		talk = {{1006,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51557] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 512,	-- ������Npc
	HandoverNpc 		= 501,	-- ������Npc

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51556, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
	    kill	=  {{204,10}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51558] =
{
	TaskTitle			= "�����͡���̽",
	TaskInfo  			= "",


	AcceptNpc			= 501,	-- ������Npc
	HandoverNpc 		= 502,	-- ������Npc

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51557, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		map  =  {{4,1023,463}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51559] =
{
	TaskTitle			= "�����͡��ռ�",
	TaskInfo  			= "",


	AcceptNpc			= 502,	-- ������Npc
	HandoverNpc 		= 503,	-- ������Npc
	RecycleItem			= true,

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51558, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{2560016,3}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51560] =
{
	TaskTitle			= "�����͡��ս�",
	TaskInfo  			= "",


	AcceptNpc			= 503,	-- ������Npc
	HandoverNpc 		= 58,	-- ������Npc
	RecycleItem			= true,
	taskType            = 2,		--�C��������(	2�������)
	cyctype             = 1,
    HeadTotail ="51212:51556:51557:51558:51559:51560",

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51559, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{3100539,5}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51213] =
{
	TaskTitle			= "�����͡��ս�",
	TaskInfo  			= "",


	AcceptNpc			= 58,	-- ������Npc
	HandoverNpc 		= 504,	-- ������Npc
	RecycleItem			= true,
    Head = 1,

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = nil,
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{3100407,5}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51561] =
{
	TaskTitle			= "�����͡���̽",
	TaskInfo  			= "",


	AcceptNpc			= 504,	-- ������Npc
	HandoverNpc 		= 501,	-- ������Npc

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51213, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		map  =  {{4,768,715}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51562] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 501,	-- ������Npc
	HandoverNpc 		= 512,	-- ������Npc

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51561, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		talk = {{1009,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51563] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 512,	-- ������Npc
	HandoverNpc 		= 503,	-- ������Npc

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51562, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
	    kill	=  {{218,10}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51564] =
{
	TaskTitle			= "�����͡��ռ�",
	TaskInfo  			= "",


	AcceptNpc			= 503,	-- ������Npc
	HandoverNpc 		= 502,	-- ������Npc
	RecycleItem			= true,

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51563, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{2560017,3}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51565] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 502,	-- ������Npc
	HandoverNpc 		= 58,	-- ������Npc
	RecycleItem			= true,
	giveTool            = {{3100520,1}},
	taskType            = 2,		--�C��������(	2�������)
	cyctype             = 1,
    HeadTotail ="51213:51561:51562:51563:51564:51565",

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51564, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		useitem = {{3100520,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51214] =
{
	TaskTitle			= "�����͡���̽",
	TaskInfo  			= "",


	AcceptNpc			= 58,	-- ������Npc
	HandoverNpc 		= 512,	-- ������Npc
    Head = 1,

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = nil,
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		map  =  {{4,1014,1382}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51566] =
{
	TaskTitle			= "�����͡��ռ�",
	TaskInfo  			= "",


	AcceptNpc			= 512,	-- ������Npc
	HandoverNpc 		= 502,	-- ������Npc
	RecycleItem			= true,

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51214, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{2560028,3}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51567] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 502,	-- ������Npc
	HandoverNpc 		= 503,	-- ������Npc

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51566, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
	    kill	=  {{206,10}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51568] =
{
	TaskTitle			= "�����͡����",
	TaskInfo  			= "",


	AcceptNpc			= 503,	-- ������Npc
	HandoverNpc 		= 501,	-- ������Npc
	RecycleItem			= true,
	giveTool            = {{3100521,1}},

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51567, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		useitem = {{3100521,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51569] =
{
	TaskTitle			= "�����͡��ս�",
	TaskInfo  			= "",


	AcceptNpc			= 501,	-- ������Npc
	HandoverNpc 		= 504,	-- ������Npc
	RecycleItem			= true,

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51568, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{3100540,5}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51570] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 504,	-- ������Npc
	HandoverNpc 		= 58,	-- ������Npc
	taskType            = 2,		--�C��������(	2�������)
	cyctype             = 1,
    HeadTotail ="51214:51566:51567:51568:51569:51570",

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51569, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		talk = {{1011,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51215] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 58,	-- ������Npc
	HandoverNpc 		= 521,	-- ������Npc
    Head = 1,

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = nil,
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		talk = {{1007,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51571] =
{
	TaskTitle			= "�����͡��ս�",
	TaskInfo  			= "",


	AcceptNpc			= 521,	-- ������Npc
	HandoverNpc 		= 512,	-- ������Npc
	RecycleItem			= true,

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51215, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{3100541,5}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51572] =
{
	TaskTitle			= "�����͡��ռ�",
	TaskInfo  			= "",


	AcceptNpc			= 512,	-- ������Npc
	HandoverNpc 		= 504,	-- ������Npc
	RecycleItem			= true,

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51571, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{2560002,3}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51573] =
{
	TaskTitle			= "�����͡���̽",
	TaskInfo  			= "",


	AcceptNpc			= 504,	-- ������Npc
	HandoverNpc 		= 503,	-- ������Npc

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51572, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		map  =  {{4,1369,1276}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51574] =
{
	TaskTitle			= "�����͡�Ϯ��",
	TaskInfo  			= "",


	AcceptNpc			= 503,	-- ������Npc
	HandoverNpc 		= 502,	-- ������Npc
	RecycleItem			= true,
	giveTool            = {{3100522,1}},

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51573, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		useitem = {{3100522,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51575] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 502,	-- ������Npc
	HandoverNpc 		= 58,	-- ������Npc
	taskType            = 2,		--�C��������(	2�������)
	cyctype             = 1,
    HeadTotail ="51215:51571:51572:51573:51574:51575",

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51574, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
	    kill	=  {{204,10}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51216] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 58,	-- ������Npc
	HandoverNpc 		= 505,	-- ������Npc
    Head = 1,

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = nil,
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
	    kill	=  {{222,10}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51576] =
{
	TaskTitle			= "�����͡�Ϯ��",
	TaskInfo  			= "",


	AcceptNpc			= 505,	-- ������Npc
	HandoverNpc 		= 505,	-- ������Npc
	RecycleItem			= true,
	giveTool            = {{3100523,1}},

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51216, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		useitem = {{3100523,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51577] =
{
	TaskTitle			= "�����͡���̽",
	TaskInfo  			= "",


	AcceptNpc			= 505,	-- ������Npc
	HandoverNpc 		= 506,	-- ������Npc

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51576, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		map  =  {{4,1382,1105}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51578] =
{
	TaskTitle			= "�����͡��ռ�",
	TaskInfo  			= "",


	AcceptNpc			= 506,	-- ������Npc
	HandoverNpc 		= 506,	-- ������Npc
	RecycleItem			= true,

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51577, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{2560005,3}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51579] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 506,	-- ������Npc
	HandoverNpc 		= 507,	-- ������Npc

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51578, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		talk = {{1014,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51580] =
{
	TaskTitle			= "�����͡��ս�",
	TaskInfo  			= "",


	AcceptNpc			= 507,	-- ������Npc
	HandoverNpc 		= 58,	-- ������Npc
	RecycleItem			= true,
	taskType            = 2,		--�C��������(	2�������)
	cyctype             = 1,
    HeadTotail ="51216:51576:51577:51578:51579:51580",

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51579, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{3100542,5}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51217] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 58,	-- ������Npc
	HandoverNpc 		= 506,	-- ������Npc
    Head = 1,

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = nil,
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		talk = {{1016,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51581] =
{
	TaskTitle			= "�����͡��ź�",
	TaskInfo  			= "",


	AcceptNpc			= 506,	-- ������Npc
	HandoverNpc 		= 506,	-- ������Npc
	RecycleItem			= true,
	giveTool            = {{3100524,1}},

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51217, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		useitem = {{3100524,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51582] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 506,	-- ������Npc
	HandoverNpc 		= 507,	-- ������Npc

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51581, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
	    kill	=  {{221,10}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51583] =
{
	TaskTitle			= "�����͡���̽",
	TaskInfo  			= "",


	AcceptNpc			= 507,	-- ������Npc
	HandoverNpc 		= 507,	-- ������Npc

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51582, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		map  =  {{4,1387,898}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51584] =
{
	TaskTitle			= "�����͡��ս�",
	TaskInfo  			= "",


	AcceptNpc			= 507,	-- ������Npc
	HandoverNpc 		= 505,	-- ������Npc
	RecycleItem			= true,

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51583, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{3100543,5}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51585] =
{
	TaskTitle			= "�����͡��ռ�",
	TaskInfo  			= "",


	AcceptNpc			= 505,	-- ������Npc
	HandoverNpc 		= 58,	-- ������Npc
	RecycleItem			= true,
	taskType            = 2,		--�C��������(	2�������)
	cyctype             = 1,
    HeadTotail ="51217:51581:51582:51583:51584:51585",

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51584, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{2560016,3}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51218] =
{
	TaskTitle			= "�����͡��ս�",
	TaskInfo  			= "",


	AcceptNpc			= 58,	-- ������Npc
	HandoverNpc 		= 507,	-- ������Npc
	RecycleItem			= true,
    Head = 1,

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = nil,
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{3100408,5}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51586] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 507,	-- ������Npc
	HandoverNpc 		= 507,	-- ������Npc

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51218, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		talk = {{1008,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51587] =
{
	TaskTitle			= "�����͡��ռ�",
	TaskInfo  			= "",


	AcceptNpc			= 507,	-- ������Npc
	HandoverNpc 		= 505,	-- ������Npc
	RecycleItem			= true,

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51586, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		item	=  {{2560017,3}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51588] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 505,	-- ������Npc
	HandoverNpc 		= 505,	-- ������Npc

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51587, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
	    kill	=  {{212,10}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51589] =
{
	TaskTitle			= "�����͡���̽",
	TaskInfo  			= "",


	AcceptNpc			= 505,	-- ������Npc
	HandoverNpc 		= 506,	-- ������Npc

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51588, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		map  =  {{4,243,230}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51590] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 506,	-- ������Npc
	HandoverNpc 		= 58,	-- ������Npc
	RecycleItem			= true,
	giveTool            = {{3100525,1}},
	taskType            = 2,		--�C��������(	2�������)
	cyctype             = 1,
    HeadTotail ="51218:51586:51587:51588:51589:51590",

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51589, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
		useitem = {{3100525,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}

--[[TaskTable[51219] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 58,	-- ������Npc
	HandoverNpc 		= 51,	-- ������Npc
    Head = 1,

	AcceptCondition =
	{
		school 	= nil,				-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = nil,
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
	    empty	=  {{1,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
TaskTable[51591] =
{
	TaskTitle			= "�����͡�����",
	TaskInfo  			= "",


	AcceptNpc			= 51,	-- ������Npc
	HandoverNpc 		= 58,	-- ������Npc
	taskType            = 2,		--�C��������(	2�������)
	cyctype             = 1,
    HeadTotail ="51219:51591",

	AcceptCondition =
	{
		school 	= nil,			-- �����޶�
		level	= {20,150},			-- �ȼ��޶�
		sex		= nil,
		task    = {
					allNeed = {{51219, TS_COMPLETE}},
					oneNeed = nil,
				  }
	},

	CompleteCondition =
	{
	    empty	=  {{1,1}},
	},

	CompleteAward =
	{
		exps   = CommonExp[20],
		money  = CommonMoney[20],
	},
}
--]]


































