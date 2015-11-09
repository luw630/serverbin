Variable_X = 2.75
Variable_Y = 0.05
PRAYERCOST_TEN = 0.9     --10连抽优惠比例
PRAYERSHOPCOLSETIME = 24 * 60 * 60  --祈福商城的结束延时
PRAYERSHOPOPENED = 0    --商城是否开启

Prayer_Type = 
{
	Prayer_Type_Item = 1 ,  --祈福得到道具
	Prayer_Type_Knight = 2 ,  --祈福得到武将
}
Prayer_FreeTime = 60 * 60 * 24 * 2   -- 48小时

PrayerConfig =
{
	Prayer_Cost = 280,
	Prayer_Point = 10,   --单次祈福积分 
	Prayer_Item =  		--抽取道具和数量				,配置时需要根据抽取的几率从大到小。因为几率判断是根据这里来
	{
		[1] = 								--蓝色
		{
			Chances = 40,
			ItemList = {
			            11304,1,11104,1,11204,1,11503,1,11403,1,
			            11603,1,11305,1,11105,1,11205,1,11503,1,
						11403,1,11603,1,11305,1,11105,1,11205,1,
						11504,1,11404,1,11604,1,12304,1,12104,1,
						12204,1,12503,1,12403,1,12603,1,12305,1,
						12105,1,12205,1,12503,1,12403,1,12603,1,
						12305,1,12105,1,12205,1,12504,1,12404,1,
						12604,1,13304,1,13104,1,13204,1,13503,1,
						13403,1,13603,1,13305,1,13105,1,13205,1,
						13503,1,13403,1,13603,1,13305,1,13105,1,
						13205,1,13504,1,13404,1,13604,1
						},
		},

		[2] = 									--绿色
		{
			Chances = 35,
			ItemList = {
			            90115,3,90131,3,90133,3,90129,3,90141,3,
						90109,3,90117,3,90118,3,90121,3,90125,3,
						90127,3,90144,3,90102,3,90104,3,90108,3,
						90112,3,90113,3,90119,3,90120,3,90122,3,
						90130,3,90138,3,90142,3
						},
		},

		[3] = 								--紫色
		{
			Chances = 20,
			ItemList = {
			            11306,1,11106,1,11206,1,11505,1,11405,1,
						11605,1,11307,1,11107,1,11207,1,11505,1,
						11405,1,11605,1,11307,1,11107,1,11207,1,
						11506,1,11406,1,11606,1,11308,1,11108,1,
						11208,1,11506,1,11406,1,11606,1,12306,1,
						12106,1,12206,1,12505,1,12405,1,12605,1,
						12307,1,12107,1,12207,1,12505,1,12405,1,
						12605,1,12307,1,12107,1,12207,1,12506,1,
						12406,1,12606,1,12308,1,12108,1,12208,1,
						12506,1,12406,1,12606,1,13306,1,13106,1,
						13206,1,13505,1,13405,1,13605,1,13307,1,
						13107,1,13207,1,13505,1,13405,1,13605,1,
						13307,1,13107,1,13207,1,13506,1,13406,1,
						13606,1,13308,1,13108,1,13208,1,13506,1,
						13406,1,13606,1,20002,3,20001,5,20003,3,
						20004,1,20008,3,20006,5,20009,1,20018,1
			            },
		},

		[4] =    --白色道具
		{
			Chances = 5,							--机率
			ItemList = {
			            20004,1,20002,5,90102,3,90104,3,90111,3,
						90119,3,90120,3,90130,3,90142,3,90112,3,
						90138,3
						},	--道具列表
		},

	},

	Prayer_Knight =  		--抽取武将
	{
		[1] = 		--一星武将				配置时需要根据抽取的几率从大到小。因为几率判断是根据这里来
		{
			Chances = 60,
			ItemList = {115,1,131,1,133,1,129,1,141,1,},
		},

		[2] = 		--二星武将
		{
			Chances = 30,
			ItemList = {109,1,117,1,118,1,121,1,127,1,124,1},
		},

		[3] = 		--三星武将
		{
			Chances = 10,
			ItemList = {102,1,104,1,108,1,113,1,119,1,120,1,122,1,130,1,138,1,146,1,142,1},
		},
	},

}