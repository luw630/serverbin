TaskTable[1] =
{
	TaskTitle= "焦急的兔子", 
	TaskInfo= "",
	AcceptNpc= 1,
	HandoverNpc= 1,
	RecycleItem= nil,
	giveTool= nil,
			--当前任务完成时打开的关卡1,关卡2
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
		empty = {{2,1}},
	},

	CompleteAward=                              ---------------奖励
	{
		exps= CommonExp[1],                      
		money = CommonMoney[1],	
		Sp = CommonSp[1],
		PetID = {205},
		item=
		{
			fix=
			{
				{school= 1, sex= nil, itemid= 110301, itemnum= 1,}, 
				{school= 2, sex= nil, itemid= 120301, itemnum= 1,},
				{school= 3, sex= nil, itemid= 130301, itemnum= 1,},
				{school= nil, sex= nil, itemid= 176000, itemnum= 1,},
				{school= nil, sex= nil, itemid= 176000, itemnum= 1,},
				{school= nil, sex= nil, itemid= 176000, itemnum= 1,},
				{school= nil, sex= nil, itemid= 176000, itemnum= 1,},
				{school= nil, sex= nil, itemid= 176000, itemnum= 1,},
			},
		},
	},
}
TaskTable[2] =
{
	TaskTitle= "倒霉的杰克", 
	TaskInfo= "",
	AcceptNpc= 1,
	HandoverNpc= 3,
	RecycleItem= nil,
	giveTool= nil,
	----taskscene = {2},
			--当前任务完成时打开的关卡1,关卡2

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
		empty = {{2,1}},
	                                   -------------签到功能未开发
	},

	CompleteAward=
	{
		exps= CommonExp[2],
		money = CommonMoney[2],	
		Sp = CommonSp[2], ---------------------信仰
		item=                             ------------------------------道具 
		{
			fix=
			{
				--{school= 1, sex= nil, itemid= 190611, itemnum= 1,},
			},
		},
	},
}
TaskTable[3] =
{
	TaskTitle= "杰克的烦恼", 
	TaskInfo= "",
	AcceptNpc= 3,
	HandoverNpc= 5,
	RecycleItem= nil,
	giveTool= nil,
	--mtdynamicregion = {10000,20,15},
	taskscene = {2},				--当前任务完成时打开的关卡1,关卡2
	BAutoUse = 1,
	
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
		addnew = {{TASK_SCENE,1,2}},   --类型，道具或技能ID,次数，
	},

	CompleteAward=
	{
		exps= CommonExp[3],
		money = CommonMoney[3],
		Sp = CommonSp[3],
	
		item=
		{
			fix=
			{
				----{school= {1}, sex= nil, itemid= 110201, itemnum= 1,}, 
				--------{school= {2}, sex= nil, itemid= 120201, itemnum= 1,}, 
				-------{school= {3}, sex= nil, itemid= 130201, itemnum= 1,}, 
			},
		},
	},
}
TaskTable[4] =
{
	TaskTitle= "打探消息", 
	TaskInfo= "",
	AcceptNpc= 5,
	HandoverNpc= 4,
	RecycleItem= nil,
	giveTool= nil,
	taskscene = {2},	
	
	
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
		 empty = {{2,1}},	             --类型，道具或技能ID,次数，
	},

	CompleteAward=
	{
		exps= CommonExp[4],
		money = CommonMoney[4],
		Sp = CommonSp[4],
		PetID = {401},
	item=
		{
			fix=
			{
				{school= 1, sex= nil, itemid= 110201, itemnum= 1,}, 
				{school= 2, sex= nil, itemid= 120201, itemnum= 1,},
				{school= 3, sex= nil, itemid= 130201, itemnum= 1,},
			},
		},
	},
}
TaskTable[5] =
{
	TaskTitle= "丢失的鞋子", 
	TaskInfo= "",
	AcceptNpc= 4,
	HandoverNpc= 4,
	RecycleItem= true,
	giveTool= nil,
	--mtdynamicregion = {10001,20,15},
	taskscene = {3},		--任务关联关卡，章节。关卡

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
			addnew = {{TASK_SCENE,1,3}},                                     -------------背包未开发
	},

	CompleteAward=
	{
		exps= CommonExp[5],
		money = CommonMoney[5],
		Sp = CommonSp[5],
		item=
		{
			fix=
			{
			--------------{school= nil, sex= nil, itemid= 190650, itemnum= 10,},
			},
		},
	},
}
TaskTable[6] =
{
	TaskTitle= "准备营救", 
	TaskInfo= "",
	AcceptNpc= 4,
	HandoverNpc= 4,
	RecycleItem= nil,
	giveTool= nil,
	--mtdynamicregion = {10002,20,15},
	taskscene = {4},

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
		empty = {{2,1}},  --类型，道具或技能ID,次数，
	},

	CompleteAward=
	{
		exps= CommonExp[6],                      
		money = CommonMoney[6],	
		Sp = CommonSp[6],
		
	},
}
TaskTable[7] =
{
	TaskTitle= "营救爱丽丝", 
	TaskInfo= "",
	AcceptNpc= 4,
	HandoverNpc= 2,
	RecycleItem= nil,
	giveTool= nil,
	taskscene = {5},		--任务关联关卡，章节。关卡

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
		addnew = {{TASK_SCENE,1,4}}, --类型，道具或技能ID,次数，
	},

	CompleteAward=
	{
		exps= CommonExp[7],
		Sp = CommonSp[7],
		money= CommonMoney[7],
		item=
		{
			fix=
			{
				{school= nil, sex= nil, itemid= 176000, itemnum= 1,},
				{school= nil, sex= nil, itemid= 176000, itemnum= 1,},
				{school= nil, sex= nil, itemid= 176000, itemnum= 1,},
				{school= nil, sex= nil, itemid= 176000, itemnum= 1,},
				{school= nil, sex= nil, itemid= 176000, itemnum= 1,},
			},
		},
	},
}
TaskTable[8] =
{
	TaskTitle= "森林奇兵", 
	TaskInfo= "",
	AcceptNpc= 2,
	HandoverNpc= 2,
	RecycleItem= nil,
	giveTool= nil,
	taskscene = {5},

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
		 
		addnew = {{TASK_SCENE,1,5}}, 
	},

	CompleteAward=
	{
		exps= CommonExp[8],                      
		money = CommonMoney[8],	
		Sp = CommonSp[8],
		item=
		{
			fix=
			{
				{school= nil, sex= nil, itemid= 9000001, itemnum= 1,},  --第2本技能书
			},
		},
	},
}
TaskTable[9] =
{
	TaskTitle= "夺回钥匙", 
	TaskInfo= "",
	AcceptNpc= 2,
	HandoverNpc= 2,
	RecycleItem= nil,
	giveTool= nil,  
	taskscene = {6},

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
		addnew = {{TASK_SCENE,1,6}},
	},

	CompleteAward=
	{
		exps= CommonExp[9],                      
		money = CommonMoney[9],	
		Sp = CommonSp[9],
	},
}
TaskTable[10] =
{
	TaskTitle= "寻找神灯", 
	TaskInfo= "",
	AcceptNpc= 2,
	HandoverNpc= 11,
	RecycleItem= nil,
	giveTool= nil,
	taskscene = {6},

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
		empty = {{2,1}}, 
	},

	CompleteAward=
	{
		exps= CommonExp[10],                      
		money = CommonMoney[10],	
		Sp = CommonSp[10],
		item=
		{
			fix=
			{
			{school= nil, sex= nil, itemid= 9000002, itemnum= 1,},
			},
		},
	},
}
TaskTable[11] =
{
	TaskTitle= "寻找阿拉丁", 
	TaskInfo= "",
	AcceptNpc= 11,
	HandoverNpc=11,
	RecycleItem= nil,
	giveTool= nil,
	taskscene = {7},

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
		addnew = {{TASK_SCENE,1,7}},                       ------------功能未开发
	},

	CompleteAward=
	{
		exps= CommonExp[11],
		money= CommonMoney[11],
		Sp = CommonSp[11],
		item=
		{
			fix=
			{
			--{school= nil, sex= nil, itemid= 190101, itemnum= 4,},
			--{school= nil, sex= nil, itemid= 190103, itemnum= 8,},
			},
		},
	},
}
TaskTable[12] =
{
	TaskTitle= "拯救水源", 
	TaskInfo= "",
	AcceptNpc= 11,
	HandoverNpc= 12,
	RecycleItem= true,
	giveTool= nil,
	--mtdynamicregion = {10006,20,15},
	taskscene = {8},

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
		addnew = {{TASK_SCENE,1,8}}, --竞技场功能未开发
	},

	CompleteAward=
	{
		exps= CommonExp[12],                      
		money = CommonMoney[12],	
		Sp = CommonSp[12],
		item=
		{
			fix=
			{
			--{school= nil, sex= nil, itemid= 190101, itemnum= 4,},
			--{school= nil, sex= nil, itemid= 190103, itemnum= 8,},
			},
		},
	},
}
TaskTable[13] =
{
	TaskTitle= "盟军的危机", 
	TaskInfo= "",
	AcceptNpc= 12,
	HandoverNpc= 14,
	RecycleItem= true,
	giveTool= nil,
	--mtdynamicregion = {10006,20,15},
	taskscene = {9},

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
		addnew= {{TASK_SCENE,1,9}},--天仙果
	},

	CompleteAward=
	{
		exps= CommonExp[13],
		money= CommonMoney[13],
		Sp = CommonSp[13],
		item=
		{
			fix=
			{
		{school= nil, sex= nil, itemid= 9000003, itemnum= 1,},
			},
		},
	},
}
TaskTable[14] =
{
	TaskTitle= "奸细", 
	TaskInfo= "",
	AcceptNpc= 14,
	HandoverNpc= 14,
	RecycleItem= nil,
	giveTool= nil,
	taskscene = {10},

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
	addnew= {{TASK_SCENE,1,10}},                --功能未开发
	},

	CompleteAward=
	{
		exps= CommonExp[14],                      
		money = CommonMoney[14],	
		Sp = CommonSp[14],
		item=
		{
			fix=
			{
			--	{school= nil, sex= nil, itemid= 2100002, itemnum= 1,},
			},
		},
	},
}
TaskTable[15] =
{
	TaskTitle= "爱丽丝的背叛？", 
	TaskInfo= "",
	AcceptNpc= 14,
	HandoverNpc= 14,
	RecycleItem= nil,
	giveTool= nil,
	taskscene = {11,12},

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
		empty = {{2,1}},
	},

	CompleteAward=
	{
		exps= CommonExp[15],                      
		money = CommonMoney[15],	
		Sp = CommonSp[15],
	},
}
TaskTable[16] =
{
	TaskTitle= "追击贾方", 
	TaskInfo= "",
	AcceptNpc= 14,
	HandoverNpc= 11,
	RecycleItem= nil,
	giveTool= nil,
	taskscene = {13},
	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{15, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
	addnew = {{TASK_SCENE,1,11}}, 
	},

	CompleteAward=
	{
		exps= CommonExp[16],
		money= CommonMoney[16],
		Sp = CommonSp[16],
	},
}
TaskTable[17] =
{
	TaskTitle= "信仰之力", 
	TaskInfo= "",
	AcceptNpc= 11,
	HandoverNpc= 12,
	RecycleItem= nil,
	giveTool= nil,
	taskscene = {13},

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{16, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		addnew = {{TASK_SCENE,1,12}}, 
	},

	CompleteAward=
	{
		exps= CommonExp[17],                      
		money = CommonMoney[17],	
		Sp = CommonSp[17],
	},
}

TaskTable[18] =
{
	TaskTitle= "釜底抽薪", 
	TaskInfo= "",
	AcceptNpc= 12,
	HandoverNpc= 13,
	RecycleItem= nil,
	giveTool= nil,
	taskscene = {13,14},

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{17, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		addnew = {{TASK_SCENE,1,14}}, 
	},

	CompleteAward=
	{
		exps= CommonExp[18],                      
		money = CommonMoney[18],	
		Sp = CommonSp[18],
	item=
		{
			fix=
			{
				{school= nil, sex= nil, itemid= 9000004, itemnum= 1,},  --第2本技能书
			},
		},
	},
}
TaskTable[19] =
{
	TaskTitle= "试探", 
	TaskInfo= "",
	AcceptNpc= 13,
	HandoverNpc= 13,
	RecycleItem= nil,
	giveTool= nil,
	taskscene = {14,15},
	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{18, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		addnew ={{TASK_SCENE,1,15}},
	},

	CompleteAward=
	{
		exps= CommonExp[19],                      
		money = CommonMoney[19],	
		Sp = CommonSp[19],
		item=
		{
			fix=
			{
			--{school= nil, sex= nil, itemid= 190650, itemnum= 10,},  --成就道具
			},
		},
	},
}
TaskTable[20] =
{
	TaskTitle= "匪徒的秘密", 
	TaskInfo= "",
	AcceptNpc= 13,
	HandoverNpc= 13,
	RecycleItem= nil,
	giveTool= nil,
	taskscene = {15,16},
	
	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{19, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		addnew ={{TASK_SCENE,1,16}},
	},

	CompleteAward=
	{
		exps= CommonExp[20],                      
		money = CommonMoney[20],	
		Sp = CommonSp[20],
		item=
		{
			fix=
			{
			{school= nil, sex= nil, itemid= 190101, itemnum= 12,},  --第2本技能书
			{school= nil, sex= nil, itemid= 190103, itemnum= 36,},
			},
		},
	},
}
TaskTable[21] =
{
	TaskTitle= "营救阿拉丁", 
	TaskInfo= "",
	AcceptNpc= 13,
	HandoverNpc= 11,
	RecycleItem= nil,
	giveTool= nil,
	taskscene = {17,18},

	AcceptCondition=
	{
		school= nil,
		level= {1,150},
		sex= nil,
		task= {
				 allNeed = {{20, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		addnew= {{TASK_SCENE,1,18}},
	},

	CompleteAward=
	{
		exps= CommonExp[21],                      
		money = CommonMoney[21],	
		Sp = CommonSp[21],
		PetID = {201,202},
item=
		{
			fix=
			{
				{school= nil, sex= nil, itemid= 9000005, itemnum= 1,},  
			},
		},
	},
}
TaskTable[22] =
{
	TaskTitle= "悲伤的茉莉", 
	TaskInfo= "",
	AcceptNpc= 11,
	HandoverNpc= 14,
	RecycleItem= nil,
	giveTool= nil,
	taskscene = {19.20},

	AcceptCondition=
	{
		school= nil,
		level= {10,150},
		sex= nil,
		task= {
				 allNeed = {{21, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		addnew= {{TASK_SCENE,1,20}},
	},

	CompleteAward=
	{
		exps= CommonExp[22],                      
		money = CommonMoney[22],	
		Sp = CommonSp[22],
	},
}
TaskTable[23] =
{
	TaskTitle= "神秘人", 
	TaskInfo= "",
	AcceptNpc= 14,
	HandoverNpc= 11,
	RecycleItem= nil,
	giveTool= nil,
	taskscene = {19},

	AcceptCondition=
	{
		school= nil,
		level= {10,150},
		sex= nil,
		task= {
				 allNeed = {{22, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		empty= {{1,13}},
	},

	CompleteAward=
	{
		exps= CommonExp[23],                      
		money = CommonMoney[23],	
		Sp = CommonSp[23],
	},
}
TaskTable[24] =
{
	TaskTitle= "挖掘真相", 
	TaskInfo= "",
	AcceptNpc= 11,
	HandoverNpc= 14,
	RecycleItem= nil,
	giveTool= nil,
	taskscene = {20,21,22,23},

	AcceptCondition=
	{
		school= nil,
		level= {10,150},
		sex= nil,
		task= {
				 allNeed = {{23, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		addnew= {{TASK_SCENE,1,21}},
	},

	CompleteAward=
	{
		exps= CommonExp[24],
		money= CommonMoney[24],
		Sp = CommonSp[24],
		item=
		{
			fix=
			{
			----{school= nil, sex= nil, itemid= 190301, itemnum= 2,},  
			},
		},
	},
}
TaskTable[25] =
{
	TaskTitle= "封印之石", 
	TaskInfo= "",
	AcceptNpc= 14,
	HandoverNpc= 11,
	RecycleItem= nil,
	giveTool= nil,
	taskscene = {23},

	AcceptCondition=
	{
		school= nil,
		level= {10,150},
		sex= nil,
		task= {
				 allNeed = {{24, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		addnew= {{TASK_SCENE,1,22}},
	},

	CompleteAward=
	{
		exps= CommonExp[25],
		money= CommonMoney[25],
		Sp = CommonSp[25],
		item=
		{
			fix=
			{
			{school= nil, sex= nil, itemid= 190201, itemnum= 2,},  
			},
		},
	},
}
TaskTable[26] =
{
	TaskTitle= "求助桃乐丝", 
	TaskInfo= "",
	AcceptNpc= 11,
	HandoverNpc= 14,
	RecycleItem= nil,
	giveTool= nil,
	taskscene = {23,24},

	AcceptCondition=
	{
		school= nil,
		level= {10,150},
		sex= nil,
		task= {
				 allNeed = {{25, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		addnew= {{TASK_SCENE,1,24}},
	},

	CompleteAward=
	{
		exps= CommonExp[26],                      
		money = CommonMoney[26],	
		Sp = CommonSp[26],
item=
		{
			fix=
			{
				{school= nil, sex= nil, itemid= 9000006, itemnum= 1,},  --第2本技能书
			},
		},
	},
}
TaskTable[27] =
{
	TaskTitle= "历练", 
	TaskInfo= "",
	AcceptNpc= 14,
	HandoverNpc= 14,
	RecycleItem= nil,
	giveTool= nil,
	taskscene = {23},

	AcceptCondition=
	{
		school= nil,
		level= {10,150},
		sex= nil,
		task= {
				 allNeed = {{26, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		addnew= {{TASK_SCENE,1,25}},
	},

	CompleteAward=
	{
		exps= CommonExp[27],                      
		money = CommonMoney[27],	
		Sp = CommonSp[27],
	},
}
TaskTable[28] =
{
	TaskTitle= "阿拉丁的失踪", 
	TaskInfo= "",
	AcceptNpc= 14,
	HandoverNpc= 11,
	RecycleItem= nil,
	giveTool= nil,
	taskscene = {23,24},

	AcceptCondition=
	{
		school= nil,
		level= {10,150},
		sex= nil,
		task= {
				 allNeed = {{27, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		empty= {{1,13}},
	},

	CompleteAward=
	{
		exps= CommonExp[28],                      
		money = CommonMoney[28],	
		Sp = CommonSp[28],
		item=
		{
			fix=
			{
			{school= nil, sex= nil, itemid= 190301, itemnum= 2,},  
			},
		},
	},
}
TaskTable[29] =
{
	TaskTitle= "营救阿拉丁29", 
	TaskInfo= "",
	AcceptNpc= 11,
	HandoverNpc= 14,
	RecycleItem= nil,
	giveTool= nil,
	taskscene = {25,26,27},

	AcceptCondition=
	{
		school= nil,
		level= {10,150},
		sex= nil,
		task= {
				 allNeed = {{28, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		addnew= {{TASK_SCENE,1,26}},
	},

	CompleteAward=
	{
		exps= CommonExp[29],                      
		money = CommonMoney[29],	
		Sp = CommonSp[29],
	},
}
TaskTable[30] =
{
	TaskTitle= "营救阿拉丁30", 
	TaskInfo= "",
	AcceptNpc= 14,
	HandoverNpc= 14,
	RecycleItem= nil,
	giveTool= nil,
	taskscene = {27},

	AcceptCondition=
	{
		school= nil,
		level= {10,150},
		sex= nil,
		task= {
				 allNeed = {{29, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		addnew= {{TASK_SCENE,1,27}},
	},

	CompleteAward=
	{
		exps= CommonExp[30],                      
		money = CommonMoney[30],	
		Sp = CommonSp[30],
	},
}
TaskTable[31] =
{
	TaskTitle= "营救阿拉丁31", 
	TaskInfo= "",
	AcceptNpc= 14,
	HandoverNpc= 14,
	RecycleItem= nil,
	giveTool= nil,
	taskscene = {28},

	AcceptCondition=
	{
		school= nil,
		level= {10,150},
		sex= nil,
		task= {
				 allNeed = {{30, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		addnew= {{TASK_SCENE,1,28}},
	},

	CompleteAward=
	{
		exps= CommonExp[31],                      
		money = CommonMoney[31],	
		Sp = CommonSp[31],
	},
}
TaskTable[32] =
{
	TaskTitle= "营救阿拉丁32", 
	TaskInfo= "",
	AcceptNpc= 14,
	HandoverNpc= 4,
	RecycleItem= nil,
	giveTool= nil,
	taskscene = {29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50},

	AcceptCondition=
	{
		school= nil,
		level= {10,150},
		sex= nil,
		task= {
				 allNeed = {{31, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		addnew= {{TASK_SCENE,1,29}},
	},

	CompleteAward=
	{
		exps= CommonExp[32],                      
		money = CommonMoney[32],	
		Sp = CommonSp[32],
	},
}
TaskTable[33] =
{
	TaskTitle= "营救阿拉丁32", 
	TaskInfo= "",
	AcceptNpc= 4,
	HandoverNpc= 4,
	RecycleItem= nil,
	giveTool= nil,
	taskscene = {50},

	AcceptCondition=
	{
		school= nil,
		level= {10,150},
		sex= nil,
		task= {
				 allNeed = {{32, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		addnew= {{TASK_SCENE,1,50}},
	},

	CompleteAward=
	{
		exps= CommonExp[33],                      
		money = CommonMoney[33],	
		Sp = CommonSp[33],
	},
}

TaskTable[200] =
{
	TaskTitle= "【主线】得知秘密", 
	TaskInfo= "",
	AcceptNpc= 13,
	HandoverNpc= 13,
	RecycleItem= nil,
	giveTool= nil,

	AcceptCondition=
	{
		school= nil,
		level= {29,150},
		sex= nil,
		task= {
				 allNeed = {{199, TS_COMPLETE}},
				 oneNeed = nil,
			  }
	},

	CompleteCondition= 
	{
		addnew= {{TASK_SCENE,1,28}},
	},

	CompleteAward=
	{
		exps= CommonExp[20],
		money= CommonMoney[20],
	},
}




-- TaskTable[15] =
-- {
-- 	TaskTitle= "【日常】1号任务", 
-- 	TaskInfo= "",
-- 	AcceptNpc= 2,
-- 	HandoverNpc= 3,
-- 	RecycleItem= nil,
-- 	giveTool= nil,
  
-- 	AcceptCondition=
-- 	{
-- 		school= nil,
-- 		level= {1,150},
-- 		sex= nil,
-- 		task= nil,
-- 	},

-- 	CompleteCondition= 
-- 	{
-- 		empty = {{1,1}},
-- 	},

-- 	CompleteAward=
-- 	{
-- 		exps= CommonExp[1],
-- 		money= CommonMoney[1],		
-- 	},
-- }
-- TaskTable[16] =
-- {
-- 	TaskTitle= "【日常】2号任务", 
-- 	TaskInfo= "",
-- 	AcceptNpc= 2,
-- 	HandoverNpc= 3,
-- 	RecycleItem= nil,
-- 	giveTool= nil,
  
-- 	AcceptCondition=
-- 	{
-- 		school= nil,
-- 		level= {1,150},
-- 		sex= nil,
-- 		task= nil,
-- 	},

-- 	CompleteCondition= 
-- 	{
-- 		empty = {{1,1}},
-- 	},

-- 	CompleteAward=
-- 	{
-- 		exps= CommonExp[1],
-- 		money= CommonMoney[1],
		
-- 	},
-- }
-- TaskTable[17] =
-- {
-- 	TaskTitle= "【日常】3号任务", 
-- 	TaskInfo= "",
-- 	AcceptNpc= 2,
-- 	HandoverNpc= 3,
-- 	RecycleItem= nil,
-- 	giveTool= nil,
  
-- 	AcceptCondition=
-- 	{
-- 		school= nil,
-- 		level= {1,150},
-- 		sex= nil,
-- 		task= nil,
-- 	},

-- 	CompleteCondition= 
-- 	{
-- 		empty = {{1,1}},
-- 	},

-- 	CompleteAward=
-- 	{
-- 		exps= CommonExp[1],
-- 		money= CommonMoney[1],
		
-- 	},
-- }
-- TaskTable[18] =
-- {
-- 	TaskTitle= "【日常】4号任务", 
-- 	TaskInfo= "",
-- 	AcceptNpc= 2,
-- 	HandoverNpc= 3,
-- 	RecycleItem= nil,
-- 	giveTool= nil,
  
-- 	AcceptCondition=
-- 	{
-- 		school= nil,
-- 		level= {1,150},
-- 		sex= nil,
-- 		task= nil,
-- 	},

-- 	CompleteCondition= 
-- 	{
-- 		empty = {{1,1}},
-- 	},

-- 	CompleteAward=
-- 	{
-- 		exps= CommonExp[1],
-- 		money= CommonMoney[1],
		
-- 	},
-- }
-- TaskTable[19] =
-- {
-- 	TaskTitle= "【日常】5号任务", 
-- 	TaskInfo= "",
-- 	AcceptNpc= 2,
-- 	HandoverNpc= 3,
-- 	RecycleItem= nil,
-- 	giveTool= nil,
  
-- 	AcceptCondition=
-- 	{
-- 		school= nil,
-- 		level= {1,150},
-- 		sex= nil,
-- 		task= nil,
-- 	},

-- 	CompleteCondition= 
-- 	{
-- 		empty = {{1,1}},
-- 	},

-- 	CompleteAward=
-- 	{
-- 		exps= CommonExp[1],
-- 		money= CommonMoney[1],
		
-- 	},
-- }
-- TaskTable[20] =
-- {
-- 	TaskTitle= "【日常】6号任务", 
-- 	TaskInfo= "",
-- 	AcceptNpc= 2,
-- 	HandoverNpc= 3,
-- 	RecycleItem= nil,
-- 	giveTool= nil,
  
-- 	AcceptCondition=
-- 	{
-- 		school= nil,
-- 		level= {1,150},
-- 		sex= nil,
-- 		task= nil,
-- 	},

-- 	CompleteCondition= 
-- 	{
-- 		empty = {{1,1}},
-- 	},

-- 	CompleteAward=
-- 	{
-- 		exps= CommonExp[1],
-- 		money= CommonMoney[1],
		
-- 	},
-- }
-- TaskTable[21] =
-- {
-- 	TaskTitle= "【日常】7号任务", 
-- 	TaskInfo= "",
-- 	AcceptNpc= 2,
-- 	HandoverNpc= 3,
-- 	RecycleItem= nil,
-- 	giveTool= nil,
  
-- 	AcceptCondition=
-- 	{
-- 		school= nil,
-- 		level= {1,150},
-- 		sex= nil,
-- 		task= nil,
-- 	},

-- 	CompleteCondition= 
-- 	{
-- 		empty = {{1,1}},
-- 	},

-- 	CompleteAward=
-- 	{
-- 		exps= CommonExp[1],
-- 		money= CommonMoney[1],
		
-- 	},
-- }
-- TaskTable[22] =
-- {
-- 	TaskTitle= "【日常】8号任务", 
-- 	TaskInfo= "",
-- 	AcceptNpc= 2,
-- 	HandoverNpc= 3,
-- 	RecycleItem= nil,
-- 	giveTool= nil,
  
-- 	AcceptCondition=
-- 	{
-- 		school= nil,
-- 		level= {1,150},
-- 		sex= nil,
-- 		task= nil,
-- 	},

-- 	CompleteCondition= 
-- 	{
-- 		empty = {{1,1}},
-- 	},

-- 	CompleteAward=
-- 	{
-- 		exps= CommonExp[1],
-- 		money= CommonMoney[1],
		
-- 	},
-- }
-- TaskTable[23] =
-- {
-- 	TaskTitle= "【日常】9号任务", 
-- 	TaskInfo= "",
-- 	AcceptNpc= 2,
-- 	HandoverNpc= 3,
-- 	RecycleItem= nil,
-- 	giveTool= nil,
  
-- 	AcceptCondition=
-- 	{
-- 		school= nil,
-- 		level= {1,150},
-- 		sex= nil,
-- 		task= nil,
-- 	},

-- 	CompleteCondition= 
-- 	{
-- 		empty = {{1,1}},
-- 	},

-- 	CompleteAward=
-- 	{
-- 		exps= CommonExp[1],
-- 		money= CommonMoney[1],
		
-- 	},
-- }
-- TaskTable[24] =
-- {
-- 	TaskTitle= "【日常】10号任务", 
-- 	TaskInfo= "",
-- 	AcceptNpc= 2,
-- 	HandoverNpc= 3,
-- 	RecycleItem= nil,
-- 	giveTool= nil,
  
-- 	AcceptCondition=
-- 	{
-- 		school= nil,
-- 		level= {1,150},
-- 		sex= nil,
-- 		task= nil,
-- 	},

-- 	CompleteCondition= 
-- 	{
-- 		empty = {{1,1}},
-- 	},

-- 	CompleteAward=
-- 	{
-- 		exps= CommonExp[1],
-- 		money= CommonMoney[1],
		
-- 	},
-- }