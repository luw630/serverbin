TaskTable[1] =
{
	TaskTitle= "【主线】乱世降临", 
	TaskInfo= "",
	AcceptNpc= 1,
	HandoverNpc= 1,
	RecycleItem= nil,
	giveTool= nil,
	--taskType= 1, 		--–单个任务(	2多个任务)
	--cyctype= nil,  --

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= nil,
	},

	CompleteCondition= 
	{
		empty = {{1,1}},
	},

	CompleteAward=
	{
		exps= CommonExp[1],
		money= CommonMoney[1],
		item=
		{
			fix=
			{
				{school= nil, sex= nil, itemid= 7000001, itemnum= 10,},
				{school= nil, sex= nil, itemid= 7010001, itemnum= 10,}
			},
		},
	},
}
TaskTable[2] =
{
	TaskTitle= "【主线】洗精伐髓(上)", 
	TaskInfo= "",
	AcceptNpc= 1,
	HandoverNpc= 2,
	RecycleItem= nil,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{1, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		empty = {{1,1}},
	},

	CompleteAward=
	{
		exps= CommonExp[2],
		money= CommonMoney[2],
		item=
		{
			fix=
			{
				{school= nil, sex= nil, itemid= 2000001, itemnum= 1,},
			},
		},
	},
}
TaskTable[3] =
{
	TaskTitle= "【主线】洗精伐髓(下)", 
	TaskInfo= "",
	AcceptNpc= 2,
	HandoverNpc= 3,
	RecycleItem= nil,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{2, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		kill = {{4,1}},			--妖狐
	},

	CompleteAward=
	{
		exps= CommonExp[3],
		money= CommonMoney[3],
		item=
		{
			fix=
			{
				{school= nil, sex= nil, itemid= 6020002, itemnum= 1,},
			},
		},
	},
}
TaskTable[4] =
{
	TaskTitle= "【主线】九幽密境", 
	TaskInfo= "",
	AcceptNpc= 3,
	HandoverNpc= 4,
	RecycleItem= nil,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{3, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		kill = {{51,1}},			--九幽蜂王
	},

	CompleteAward=
	{
		exps= CommonExp[4],
		money= CommonMoney[4],
		item=
		{
			fix=
			{
				{school= nil, sex= nil, itemid= 101001, itemnum= 1,},
			},
		},
	},
}
TaskTable[5] =
{
	TaskTitle= "【主线】落星石", 
	TaskInfo= "",
	AcceptNpc= 4,
	HandoverNpc= 5,
	RecycleItem= true,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{4, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		item = {{900001,3}},	----瓦砾
	},

	CompleteAward=
	{
		exps= CommonExp[5],
		money= CommonMoney[5],
		item=
		{
			fix=
			{
				{school= nil, sex= nil, itemid= 6100001, itemnum= 1,},
				{school= nil, sex= nil, itemid= 141001, itemnum= 1,},
			},
		},
	},
}
TaskTable[6] =
{
	TaskTitle= "【主线】忘忧水", 
	TaskInfo= "",
	AcceptNpc= 5,
	HandoverNpc= 6,
	RecycleItem= true,
	giveTool= {{900002,1}},

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{5, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		item = {{900003,1}},	----装满忘忧水的水瓶
	},

	CompleteAward=
	{
		exps= CommonExp[6],
		money= CommonMoney[6],
		item=
		{
			fix=
			{
				{school= nil, sex= nil, itemid= 6020006, itemnum= 1,},
			},
		},
	},
}
TaskTable[7] =
{
	TaskTitle= "【主线】凶兽", 
	TaskInfo= "",
	AcceptNpc= 6,
	HandoverNpc= 7,
	RecycleItem= nil,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{6, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		kill= {{2,5}},			---击杀凶兽
	},

	CompleteAward=
	{
		exps= CommonExp[7],
		money= CommonMoney[7],
		item=
		{
			fix=
			{
				{school= nil, sex= nil, itemid= 5000001, itemnum= 1,},
			},
		},
	},
}
TaskTable[8] =
{
	TaskTitle= "【主线】道算天机", 
	TaskInfo= "",
	AcceptNpc= 7,
	HandoverNpc= 8,
	RecycleItem= nil,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{7, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		empty = {{1,1}},
	},

	CompleteAward=
	{
		exps= CommonExp[8],
		money= CommonMoney[8],
		item=
		{
			fix=
			{
				{school= nil, sex= nil, itemid= 7000001, itemnum= 20,},
				{school= nil, sex= nil, itemid= 7010001, itemnum= 20,}
			},
		},
	},
}
TaskTable[9] =
{
	TaskTitle= "【主线】云梦白果", 
	TaskInfo= "",
	AcceptNpc= 8,
	HandoverNpc= 9,
	RecycleItem= true,
	giveTool= {{900004,1}},

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{8, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		item = {{900004,1}},
	},

	CompleteAward=
	{
		exps= CommonExp[9],
		money= CommonMoney[9],
		item=
		{
			fix=
			{
				{school= nil, sex= nil, itemid= 111001, itemnum= 1,},
			},
		},
	},
}
TaskTable[10] =
{
	TaskTitle= "【主线】意外之喜", 
	TaskInfo= "",
	AcceptNpc= 9,
	HandoverNpc= 10,
	RecycleItem= nil,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{9, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		empty = {{1,1}},
	},

	CompleteAward=
	{
		exps= CommonExp[10],
		money= CommonMoney[10],
		item=
		{
			fix=
			{
				{school= nil, sex= nil, itemid= 131001, itemnum= 1,},
				{school= nil, sex= nil, itemid= 6000001, itemnum= 1,},
			},
		},
	},
}
TaskTable[11] =
{
	TaskTitle= "【主线】隐世青龙", 
	TaskInfo= "",
	AcceptNpc= 10,
	HandoverNpc= 11,
	RecycleItem= true,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{10, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		item = {{900005,5}},
	},

	CompleteAward=
	{
		exps= CommonExp[11],
		money= CommonMoney[11],
		item=
		{
			fix=
			{
				{school= nil, sex= nil, itemid= 121001, itemnum= 1,},
			},
		},
	},
}
TaskTable[12] =
{
	TaskTitle= "【主线】终成大器", 
	TaskInfo= "",
	AcceptNpc= 11,
	HandoverNpc= 12,
	RecycleItem= nil,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{11, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		empty = {{1,1}},
	},

	CompleteAward=
	{
		exps= CommonExp[12],
		money= CommonMoney[12],
		item=
		{
			fix=
			{
				{school= nil, sex= nil, itemid= 6020008, itemnum= 1,},
			},
		},
	},
}
TaskTable[13] =
{
	TaskTitle= "【主线】戮人谷", 
	TaskInfo= "",
	AcceptNpc= 12,
	HandoverNpc= 13,
	RecycleItem= nil,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{12, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		empty = {{1,1}},
	},

	CompleteAward=
	{
		exps= CommonExp[12],
		money= CommonMoney[12],
	},
}
TaskTable[14] =
{
	TaskTitle= "【主线】爪牙必须死", 
	TaskInfo= "",
	AcceptNpc= 13,
	HandoverNpc= 14,
	RecycleItem= nil,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{13, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		kill = {{54,2},{55,2},{53,2},{56,2},},
	},

	CompleteAward=
	{
		exps= CommonExp[12],
		money= CommonMoney[12],
	},
}
TaskTable[15] =
{
	TaskTitle= "【主线】尸骨恶人", 
	TaskInfo= "",
	AcceptNpc= 14,
	HandoverNpc= 15,
	RecycleItem= nil,
	giveTool= nil,

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
		kill = {{52,1}},
	},

	CompleteAward=
	{
		exps= CommonExp[12],
		money= CommonMoney[12],
	},
}