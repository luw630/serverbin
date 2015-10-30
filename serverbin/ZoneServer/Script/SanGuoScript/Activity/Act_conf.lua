--[[
file:	Act_func.lua
author:	lpd
update:	2015-05-13
desc:活动功能
]]--

--活动类型
act_type = {
	betaTestGift = 1,	--封测豪礼大放送,
	betaLucky = 2 ,		--封测狂欢-幸运连连
	chekinHeroGift =3, 	--签到送武将
	lvUpGift = 4, 		--冲级好礼连连送
	packGift = 5,       -- 兑换礼包
	--betaDoubleExpGift = 5, --封测狂欢-奖励翻倍
	
	diamondEveryday=6,--天天领元宝
	boxEveryday=7,--天天领宝箱
	duanwu=8, --端午活动 6月19日、20日、21日
	chargeSum = 10, --累计充值活动
}


--活动配置表
act_conf={
	[1] = { -- 第一个活动配置表（封测豪礼大放送）
			begintime = os.time({year=2015, month=5, day=14, hour=0, sec=0}),--活动开始时间
			endtime = os.time({year=2015, month=5, day=20, hour=0, sec=0}),--活动结束时间
			[1] = {--第一天奖励配置 
					[1]={GoodsType.diamond, 0, 100 },--{类型，itemID, 数量} （如果类型不等于item，则不填）
					[2]={GoodsType.item, 20001, 5 },-- 第二种奖励
					[3]={GoodsType.item, 20011, 2 },
				 },
			[2] ={--第二天奖励配置
		        	[1]={GoodsType.hero, 144, 1 },--{类型，itemID, 数量} （如果类型不等于item，则不填）
					[2]={GoodsType.item, 20001, 5 },-- 第二种奖励
					[3]={GoodsType.item, 20007, 2 },
				 },
			[3] ={--第三天奖励配置
		        	[1]={GoodsType.diamond, 0, 150 },--{类型，itemID, 数量} （如果类型不等于item，则不填）
					[2]={GoodsType.item, 20001, 5 },-- 第二种奖励
					[3]={GoodsType.item, 20007, 2 },
				 },
			[4] ={--第四天奖励配置
			        [1]={GoodsType.item, 90105, 20 },--{类型，itemID, 数量} （如果类型不等于item，则不填）
					[2]={GoodsType.item, 20001, 5 },-- 第二种奖励
					[3]={GoodsType.item, 20007, 2 },
				 },
			[5] ={--第五天奖励配置
			        [1]={GoodsType.diamond, 0, 200 },--{类型，itemID, 数量} （如果类型不等于item，则不填）
					[2]={GoodsType.item, 20001, 5 },-- 第二种奖励
					[3]={GoodsType.item, 20007, 2 },
				 },
			[6] ={--第六天奖励配置
			        [1]={GoodsType.item, 90105, 20 },--{类型，itemID, 数量} （如果类型不等于item，则不填）
					[2]={GoodsType.item, 20001, 5 },-- 第二种奖励
					[3]={GoodsType.item, 20007, 2 },
				 },
			[7] ={--第七天奖励配置
			        [1]={GoodsType.diamond, 0, 500 },--{类型，itemID, 数量} （如果类型不等于item，则不填）
					[2]={GoodsType.item, 90105, 30 },-- 第二种奖励
					[3]={GoodsType.item, 20001, 5 },
					[4]={GoodsType.item, 20007, 2 },
				 },
		  },
		  
	[2] ={ --第二个活动（封测狂欢-幸运连连）
			begintime = os.time({year=2015, month=5, day=5, hour=0, sec=0}),--活动开始时间
			endtime = os.time({year=2015, month=5, day=20, hour=0, sec=0}),--活动结束时间
		[1] = {--第一天奖励配置 
					[1]={GoodsType.item, 20012, 5 },--{类型，itemID, 数量} （如果类型不等于item，则填0）
					[2]={GoodsType.item, 20011, 10 },-- 第二种奖励
			   	 }, 
			[2] = {--第二天奖励配置 
					[1]={GoodsType.item, 20013, 5 },
					[2]={GoodsType.item, 20011, 10},
			   	 },
			[3] = {--第三天奖励配置 
					[1]={GoodsType.item, 20017, 10 },
					[2]={GoodsType.item, 20011, 10 },
				 },
			[4] = {--第四天奖励配置 
					[1]={GoodsType.item, 20012, 10 },
					[2]={GoodsType.item, 20011, 10 },
				 },
			[5] = {--第五天奖励配置 
					[1]={GoodsType.item, 20014, 5 },
					[2]={GoodsType.item, 20011, 10 },
				 },
			[6] = {--第六天奖励配置 
					[1]={GoodsType.item, 20017, 10 },
					[2]={GoodsType.item, 20011, 10 },
				 },
		    [7] = {--第七天奖励配置 
					[1]={GoodsType.item, 20015, 10 },
					[2]={GoodsType.item, 20011, 10 },
				 },
		    [8] = {--第八天奖励配置 
					[1]={GoodsType.item, 20012, 20 },
					[2]={GoodsType.item, 20011, 10 },
				 },
			[9] = {--第九天奖励配置 
					[1]={GoodsType.item, 20017, 10 },--{类型，itemID, 数量} （如果类型不等于item，则填0）
					[2]={GoodsType.item, 20011, 10 },-- 第二种奖励
			   	 }, 
			[10] = {--第十天奖励配置 
					[1]={GoodsType.item, 20012, 5 },
					[2]={GoodsType.item, 20011, 10},
			   	 },
			[11] = {--第十一天奖励配置 
					[1]={GoodsType.item, 20017, 10 },
					[2]={GoodsType.item, 20011, 10 },
				 },
			[12] = {--第十二天奖励配置 
					[1]={GoodsType.item, 20012, 10 },
					[2]={GoodsType.item, 20011, 10 },
				 },
			[13] = {--第十三天奖励配置 
					[1]={GoodsType.item, 20017, 15 },
					[2]={GoodsType.item, 20011, 10 },
				 },
			[14] = {--第十四天奖励配置 
					[1]={GoodsType.item, 20015, 5 },
					[2]={GoodsType.item, 20011, 10 },
				 },
		    [15] = {--第十五天奖励配置 
					[1]={GoodsType.item, 20012, 30 },
					[2]={GoodsType.item, 20011, 10 },
				 },
		    [16] = {--第十六天奖励配置 
					[1]={GoodsType.item, 20015, 10 },
					[2]={GoodsType.item, 20011, 10 },
				 },	 
		  },
	[3] ={ --第三个活动（签到送大乔）
			begintime = os.time({year=2015, month=5, day=5, hour=0, sec=0}),--活动开始时间
			endtime = os.time({year=2015, month=5, day=20, hour=0, sec=0}),--活动结束时间
			[1] = {--第一天奖励配置
					[1]={GoodsType.diamond, 0, 100 },--{类型，itemID, 数量} （如果类型不等于item，则填0）
				 }, 
			[2] = {--第二天奖励配置 
					[1]={GoodsType.hero, 144, 1  },	
			   	 },
			[3] = {--第三天奖励配置 
					[1]={GoodsType.diamond, 0, 200 },
				 },
			[4] = {--第四天奖励配置 
					[1]={GoodsType.diamond, 0, 200 },
				 },
			[5] = {--第五天奖励配置 
					[1]={GoodsType.diamond, 0, 200 },
				 },
			[6] = {--第六天奖励配置 
					[1]={GoodsType.diamond, 0, 200 },
				 },
		    [7] = {--第七天奖励配置 
					[1]={GoodsType.item, 90105, 70 },
				 },

		  },
	[4] ={ --限时冲级好礼连连送
			begintime = os.time({year=2015, month=9, day=11, hour=0, sec=0}),--活动开始时间
			endtime = os.time({year=2015, month=9, day=18, hour=0, sec=0}),--活动结束时间
			con = {5,10,15,20,25,30,37,40,41,42,43,44,45}, --获取活动奖励的条件
			[1] = {--到达5级时的奖励
					[1]={GoodsType.item, 90121, 5 },--{类型，itemID, 数量} （如果类型不等于item，则不填）
			   	    [2]={GoodsType.item, 20001, 1 },
					[3]={GoodsType.item, 20013, 2 },
				  },
			[2] = {--到达10级时的奖励
					[1]={GoodsType.item, 90102, 5 },--{类型，itemID, 数量} （如果类型不等于item，则不填）
			   	    [2]={GoodsType.item, 20001, 2 },
					[3]={GoodsType.item, 20013, 2 },
					[4]={GoodsType.item, 20007, 3 },
				  },
            [3] = {--到达15级时的奖励
					[1]={GoodsType.item, 90101, 5 },--{类型，itemID, 数量} （如果类型不等于item，则不填）
			   	    [2]={GoodsType.item, 20001, 3 },
					[3]={GoodsType.item, 20013, 2 },
					[4]={GoodsType.item, 20007, 6 },
					},
			[4] = {--到达20级时的奖励
					[1]={GoodsType.money, 0, 100000 },--{类型，itemID, 数量} （如果类型不等于item，则不填）
			   	    [2]={GoodsType.item, 20001, 4 },
					[3]={GoodsType.item, 20014, 2 },
					[4]={GoodsType.item, 20007, 9 },
				  },
			[5] = {--到达25级时的奖励
					[1]={GoodsType.diamond, 0, 100 },--{类型，itemID, 数量} （如果类型不等于item，则不填）
			   	    [2]={GoodsType.item, 20001, 5 },
					[3]={GoodsType.item, 20014, 2 },
					[4]={GoodsType.item, 20007, 12 },
				  },
            [6] = {--到达30级时的奖励
					[1]={GoodsType.diamond, 0, 200 },--{类型，itemID, 数量} （如果类型不等于item，则不填）
			   	    [2]={GoodsType.item, 20001, 10 },
					[3]={GoodsType.item, 20014, 2 },
					[4]={GoodsType.item, 20007, 15 },
				   },
		    [7] = {--到达37级时的奖励
					[1]={GoodsType.diamond, 0, 300 },--{类型，itemID, 数量} （如果类型不等于item，则不填）
			   	    [2]={GoodsType.item, 20002, 5 },
					[3]={GoodsType.item, 20014, 5 },
					[4]={GoodsType.item, 20008, 5 },	
				   },
			[8] = {--到达40级时的奖励
					[1]={GoodsType.diamond, 0, 500 },--{类型，itemID, 数量} （如果类型不等于item，则不填）
			   	    [1]={GoodsType.item, 90130, 5 },
			   	    [2]={GoodsType.item, 20002, 5 },
					[3]={GoodsType.item, 20014, 5 },
					[4]={GoodsType.item, 20008, 5 },		
				   },
			[9] = {--到达41级时的奖励
					[1]={GoodsType.item, 90130, 5 },--{类型，itemID, 数量} （如果类型不等于item，则不填）
			   	    [2]={GoodsType.item, 20002, 10 },
					[3]={GoodsType.item, 20014, 5 },
					[4]={GoodsType.item, 20008, 10 },
				  },
            [10] = {--到达42级时的奖励
					[1]={GoodsType.item, 90130, 10 },--{类型，itemID, 数量} （如果类型不等于item，则不填）
			   	    [2]={GoodsType.item, 20002, 10 },
					[3]={GoodsType.item, 20014, 5 },
					[4]={GoodsType.item, 20008, 10 },
				   },
		    [11] = {--到达43级时的奖励
					[1]={GoodsType.item, 90130, 15 },--{类型，itemID, 数量} （如果类型不等于item，则不填）
			   	    [2]={GoodsType.item, 20002, 15 },
					[3]={GoodsType.item, 20015, 5 },
					[4]={GoodsType.item, 20008, 15 },
				   },	
			[12] = {--到达44级时的奖励
					[1]={GoodsType.item, 90130, 20 },--{类型，itemID, 数量} （如果类型不等于item，则不填）
			   	    [2]={GoodsType.item, 20002, 15 },
					[3]={GoodsType.item, 20015, 5 },
					[4]={GoodsType.item, 20008, 15 },		
				   },	
			[13] = {--到达45级时的奖励
					[1]={GoodsType.diamond, 0, 6666 },--{类型，itemID, 数量} （如果类型不等于item，则不填）
			   	    [2]={GoodsType.item, 90130, 25 },--{类型，itemID, 数量} （如果类型不等于item，则不填）
			   	    [3]={GoodsType.item, 20002, 50 },
					[4]={GoodsType.item, 20015, 5 },
					[5]={GoodsType.item, 20009, 20 },		
				   },
	   
			},
	

	[5] ={--兑换码功能
			[1] = {
					[1]= {GoodsType.item, 20016, 1},--此处是神秘宝箱
				  },
		 },
		 
	[6] ={--天天领元宝,8天一个轮回
			[1] = {
				[1]= {GoodsType.diamond, 0, 300},
				[2]= {GoodsType.money,  0,15000},
				[3]= {GoodsType.item, 20001, 5},
				[4]= {GoodsType.item, 20011, 4},
			  },
			[2] = {
				[1]= {GoodsType.diamond, 0, 300},
				[2]= {GoodsType.money,  0,15000},
				[3]= {GoodsType.item, 20001, 5},
				[4]= {GoodsType.item, 20011, 4},
			  },
			 [3] = {
				[1]= {GoodsType.diamond, 0, 300},
				[2]= {GoodsType.money,  0,15000},
				[3]= {GoodsType.item, 20001, 5},
				[4]= {GoodsType.item, 20011, 4},
			  },
			 [4] = {
				[1]= {GoodsType.diamond, 0, 300},
				[2]= {GoodsType.money,  0,15000},
				[3]= {GoodsType.item, 20001, 5},
				[4]= {GoodsType.item, 20011, 4},
			  },
			 [5] = {
				[1]= {GoodsType.diamond, 0, 300},
				[2]= {GoodsType.money,  0,15000},
				[3]= {GoodsType.item, 20001, 5},
				[4]= {GoodsType.item, 20011, 4},
			  },
			 [6] = {
				[1]= {GoodsType.diamond, 0, 300},
				[2]= {GoodsType.money,  0,15000},
				[3]= {GoodsType.item, 20001, 5},
				[4]= {GoodsType.item, 20011, 4},
			  },
			 [7] = {
				[1]= {GoodsType.diamond, 0, 300},
				[2]= {GoodsType.money,  0,15000},
				[3]= {GoodsType.item, 20001, 5},
				[4]= {GoodsType.item, 20011, 4},
			  },
			 [8] = {
				[1]= {GoodsType.diamond, 0, 300},
				[2]= {GoodsType.money,  0,15000},
				[3]= {GoodsType.item, 20001, 5},
				[4]= {GoodsType.item, 20011, 4},
			  },
		 },
	[7] ={--天天领宝箱,8天一个轮回
			[1] = {
				[1]= {GoodsType.item, 20012, 1},
			  },
			 [2] = {
				[1]= {GoodsType.item, 20015, 1},
			  },
			 [3] = {
				[1]= {GoodsType.item, 20012, 1},
			  },
			 [4] = {
				[1]= {GoodsType.item, 20015, 1},
			  },
			 [5] = {
				[1]= {GoodsType.item, 20012, 1},
			  },
			 [6] = {
				[1]= {GoodsType.item, 20015, 1},
			  },
			 [7] = {
				[1]= {GoodsType.item, 20012, 1},
			  },
			 [8] = {
				[1]= {GoodsType.item, 20015, 1},
			  },
		 },
	[8] ={--端午活动 6月19日、20日、21日
			[1] = {
				[1]= {GoodsType.diamond, 0, 500},
			  },
			 [2] = {
				[1]= {GoodsType.hero, 143, 1},
			  },
			 [3] = {
				[1]= {GoodsType.diamond, 0, 500},
			  },
		 },			 
}
