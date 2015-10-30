TaskTable[101] =
{
	TaskTitle= "�����ߡ�Ͷʯ��·", 
	TaskInfo= "",
	AcceptNpc= 101,
	HandoverNpc= 102,
	RecycleItem= nil,
	giveTool= nil,
	--taskType= 1, 		--�C��������(	2�������)
	--cyctype= nil,  --

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{14, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		empty = {{1,1}},
	},

	CompleteAward=
	{
		exps= CommonExp[15],
		money= CommonMoney[15],
	},
}
TaskTable[102] =
{
	TaskTitle= "�����ߡ�Ѱ��", 
	TaskInfo= "",
	AcceptNpc= 102,
	HandoverNpc= 103,
	RecycleItem= nil,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{101, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		empty = {{1,1}},
	},

	CompleteAward=
	{
		exps= CommonExp[16],
		money= CommonMoney[16],

	},
}
TaskTable[103] =
{
	TaskTitle= "�����ߡ�����", 
	TaskInfo= "",
	AcceptNpc= 103,
	HandoverNpc= 103,
	RecycleItem= nil,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{102, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		kill = {{51,5}},			--Ұ��
	},

	CompleteAward=
	{
		exps= CommonExp[17],
		money= CommonMoney[17],
		item=
		{
			fix=
			{
				{school= nil, sex= nil, itemid= 2000007, itemnum= 1,},  --��3��������
			},
		},
	},
}
TaskTable[104] =
{
	TaskTitle= "�����ߡ�����", 
	TaskInfo= "",
	AcceptNpc= 103,
	HandoverNpc= 102,
	RecycleItem= nil,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{103, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		empty = {{1,1}},			
	},

	CompleteAward=
	{
		exps= CommonExp[18],
		money= CommonMoney[18],
	},
}
TaskTable[105] =
{
	TaskTitle= "�����ߡ���֪����", 
	TaskInfo= "",
	AcceptNpc= 102,
	HandoverNpc= 104,
	RecycleItem= true,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{104, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		empty = {{1,1}},
	},

	CompleteAward=
	{
		exps= CommonExp[19],
		money= CommonMoney[19],
	},
}
TaskTable[106] =
{
	TaskTitle= "�����ߡ���������", 
	TaskInfo= "",
	AcceptNpc= 104,
	HandoverNpc= 105,
	RecycleItem= nil,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{105, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		empty = {{1,1}},
	},

	CompleteAward=
	{
		exps= CommonExp[20],
		money= CommonMoney[20],
	},
}
TaskTable[107] =
{
	TaskTitle= "�����ߡ��ٺϲ�", 
	TaskInfo= "",
	AcceptNpc= 105,
	HandoverNpc= 105,
	RecycleItem= true,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{106, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		item= {{3530003,5}},			--�ٺϲ�
	},

	CompleteAward=
	{
		exps= CommonExp[21],
		money= CommonMoney[21],
	},
}
TaskTable[108] =
{
	TaskTitle= "�����ߡ���ҩ", 
	TaskInfo= "",
	AcceptNpc= 105,
	HandoverNpc= 106,
	RecycleItem= true,
	giveTool= {{3530004,1}},

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{107, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		item = {{3530004,1}},--�纮ҩ
	},

	CompleteAward=
	{
		exps= CommonExp[22],
		money= CommonMoney[22],
	},
}
TaskTable[109] =
{
	TaskTitle= "�����ߡ���Ƥ����", 
	TaskInfo= "",
	AcceptNpc= 106,
	HandoverNpc= 106,
	RecycleItem= true,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{108, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		item = {{3530005,5}},  --��Ƥ
	},

	CompleteAward=
	{
		exps= CommonExp[23],
		money= CommonMoney[23],
	},
}
TaskTable[110] =
{
	TaskTitle= "�����ߡ�����", 
	TaskInfo= "",
	AcceptNpc= 106,
	HandoverNpc= 107,
	RecycleItem= true,
	giveTool= {{3530006,1}},

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{109, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		item = {{3530006,1}},--��Ƥ����
	},

	CompleteAward=
	{
		exps= CommonExp[24],
		money= CommonMoney[24],
	},
}
TaskTable[111] =
{
	TaskTitle= "�����ߡ�������", 
	TaskInfo= "",
	AcceptNpc= 107,
	HandoverNpc= 107,
	RecycleItem= true,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{110, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		item = {{3530007,5}},  --������
	},

	CompleteAward=
	{
		exps= CommonExp[25],
		money= CommonMoney[25],
	},
}
TaskTable[112] =
{
	TaskTitle= "�����ߡ��ظ��峤", 
	TaskInfo= "",
	AcceptNpc= 107,
	HandoverNpc= 104,
	RecycleItem= nil,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{111, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		empty = {{1,1}},
	},

	CompleteAward=
	{
		exps= CommonExp[26],
		money= CommonMoney[26],
	},
}
TaskTable[113] =
{
	TaskTitle= "�����ߡ��ٵ����Ϸ�", 
	TaskInfo= "",
	AcceptNpc= 104,
	HandoverNpc= 108,
	RecycleItem= nil,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{112, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		empty = {{1,1}},
	},

	CompleteAward=
	{
		exps= CommonExp[27],
		money= CommonMoney[27],
	},
}
TaskTable[114] =
{
	TaskTitle= "�����ߡ�ժ��", 
	TaskInfo= "",
	AcceptNpc= 108,
	HandoverNpc= 108,
	RecycleItem= true,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{113, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		item = {{3530008,5}},
	},

	CompleteAward=
	{
		exps= CommonExp[28],
		money= CommonMoney[28],
	},
}
TaskTable[115] =
{
	TaskTitle= "�����ߡ��յ�����", 
	TaskInfo= "",
	AcceptNpc= 108,
	HandoverNpc= 109,
	RecycleItem= true,
	giveTool= {{3530009,1}},

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{114, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		item = {{3530009,1}},
	},

	CompleteAward=
	{
		exps= CommonExp[29],
		money= CommonMoney[29],
	},
}
TaskTable[116] =
{
	TaskTitle= "�����ߡ�����ʥ��", 
	TaskInfo= "",
	AcceptNpc= 109,
	HandoverNpc= 110,
	RecycleItem= nil,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{115, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		empty = {{1,1}},
	},

	CompleteAward=
	{
		exps= CommonExp[30],
		money= CommonMoney[30],
	},
}
TaskTable[117] =
{
	TaskTitle= "�����ߡ������·", 
	TaskInfo= "",
	AcceptNpc= 110,
	HandoverNpc= 110,
	RecycleItem= nil,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{116, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		kill = {{53,10}},
	},

	CompleteAward=
	{
		exps= CommonExp[31],
		money= CommonMoney[31],
	},
}
TaskTable[118] =
{
	TaskTitle= "�����ߡ����븹��", 
	TaskInfo= "",
	AcceptNpc= 110,
	HandoverNpc= 111,
	RecycleItem= nil,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{117, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		empty = {{1,1}},
	},

	CompleteAward=
	{
		exps= CommonExp[32],
		money= CommonMoney[32],
	},
}
TaskTable[119] =
{
	TaskTitle= "�����ߡ�����ʥӡ��һ��", 
	TaskInfo= "",
	AcceptNpc= 111,
	HandoverNpc= 111,
	RecycleItem= nil,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{118, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		kill = {{54,10}},
	},

	CompleteAward=
	{
		exps= CommonExp[33],
		money= CommonMoney[33],
	},
}
TaskTable[120] =
{
	TaskTitle= "�����ߡ�����ʥӡ������", 
	TaskInfo= "",
	AcceptNpc= 111,
	HandoverNpc= 111,
	RecycleItem= true,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{119, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		item = {{3530010,1}},
	},

	CompleteAward=
	{
		exps= CommonExp[34],
		money= CommonMoney[34],
	},
}
TaskTable[121] =
{
	TaskTitle= "�����ߡ��󹦸��", 
	TaskInfo= "",
	AcceptNpc= 111,
	HandoverNpc= 110,
	RecycleItem= true,
	giveTool= {{3530011,1}},

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{120, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		item = {{3530011,1}},
	},

	CompleteAward=
	{
		exps= CommonExp[35],
		money= CommonMoney[35],
	},
}
TaskTable[122] =
{
	TaskTitle= "�����ߡ�ʥӡ����", 
	TaskInfo= "",
	AcceptNpc= 110,
	HandoverNpc= 110,
	RecycleItem= nil,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{121, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		empty = {{1,1}},
	},

	CompleteAward=
	{
		exps= CommonExp[36],
		money= CommonMoney[36],
	},
}
TaskTable[123] =
{
	TaskTitle= "�����ߡ���ȡ����", 
	TaskInfo= "",
	AcceptNpc= 110,
	HandoverNpc= 112,
	RecycleItem= true,
	giveTool= {{3530012,1}},

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{122, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		item = {{3530012,1}},
	},

	CompleteAward=
	{
		exps= CommonExp[37],
		money= CommonMoney[37],
	},
}
TaskTable[124] =
{
	TaskTitle= "�����ߡ�������֮·", 
	TaskInfo= "",
	AcceptNpc= 112,
	HandoverNpc= 201,
	RecycleItem= true,
	giveTool= {{3530013,1}},

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{123, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		item = {{3530013,1}},
	},

	CompleteAward=
	{
		exps= CommonExp[38],
		money= CommonMoney[38],
	},
}