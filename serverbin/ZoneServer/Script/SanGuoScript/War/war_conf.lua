--[[
file:	war_conf.lua
author:	wk
update:	2015-8-20
desc:国战配置
]]--


--机器人配置
war_conf={
	
	--单轮奖励配置,胜利
	war_rewardWin={
		{GoodsType.Prestige,0, 20 },--声望
		{GoodsType.item, 20002, 3 },--灵芝
	},
	--单轮奖励配置,失败
	war_rewardFali={
		{GoodsType.Prestige, 0, 5 },--声望
		{GoodsType.item, 20002, 1 },--灵芝
	},
	--国战结束奖励配置
	war_end_rewardConf={
		{GoodsType.Prestige, 0, 300 },
	},
		--国战结束奖励配置 --平局
	war_end_rewardConf_draw={
		{GoodsType.Prestige, 0, 150 },
	},
	
	 addScore=10, --胜利给阵营增加积分
	 winExtra =5, --连胜额外奖励声望值  每次连胜奖励荣誉递增
	-- TurnTime= 30,--每轮间隔时间
	-- MaxTurn=2, --最大轮数

	 TurnTime=72, --每轮间隔时间
	 MaxTurn=25, --最大轮数
	
	robotNumPercent=0.1, --机器人增加比例,相乘往上取整
	warThreshold=1.3, --国战报名阵营分配战力阀值
	lvLimit=40,--参战等级限制
	name={--名字库,开服会随机排序一次
			'太史颖方','卧龙顾危','太守道男','蛮夷无色','令尹无色','镇南睐世','司徒若颜','偏将若颜','鬼才莆单','太尉莆单','天辨伯云','司马老头','卫尉问芫','都统问芫','征西语飞','上将半山','太师文一','凤雏鸣','左徒半山',
			'刺虎顾危','巡抚道男','白马无色','郡主无色','镇北睐世','都爵睐世','伏波若颜','恶来莆单','太史莆单','卧龙伯云','太守老头','蛮夷问芫','令尹问芫','镇南语飞','司徒文一','偏将文一','鬼才顾危','太尉半山','天辨臻菲',
			'校尉道男','飞熊无色','刺史无色','镇西睐世','文将睐世','骁骑若颜','武痴莆单','尚书莆单','刺虎伯云','巡抚老头','白马问芫','郡主问芫','镇北语飞','都爵语飞','伏波文一','恶来顾危','太史半山','卧龙臻菲','太守二巫',
			'虎豹士萧','提辖无色','镇东睐世','龙将睐世','征东若颜','武神莆单','学士莆单','锦帆伯云','校尉老头','飞熊问芫','刺史问芫','镇西语飞','文将语飞','骁骑文一','武痴顾危','尚书半山','刺虎臻菲','巡抚二巫','白马珩尤',
			'丞相无色','车骑睐世','虎将睐世','征南若颜','侍中莆单','少保莆单','上将伯云','教头老头','虎豹嫣诸','提辖问芫','镇东语飞','龙将语飞','征东文一','武神顾危','学士半山','锦帆臻菲','校尉二巫','飞熊珩尤','刺史桃秋',
			'骠骑睐世','都尉睐世','征北若颜','都督莆单','太傅莆单','武圣伯云','从事老头','小兵嫣诸','丞相问芫','车骑语飞','虎将语飞','征南文一','侍中顾危','少保半山','上将臻菲','教头二巫','虎豹乞蓉','提辖桃秋','镇东青岩',
			'都统睐世','征西若颜','上将莆单','太师莆单','凤雏伯云','左徒老头','军师嫣诸','御史问芫','骠骑语飞','都尉语飞','征北文一','都督顾危','太傅半山','武圣臻菲','从事二巫','小兵乞蓉','丞相桃秋','车骑青岩','虎将青岩',
			'镇南若颜','司徒莆单','偏将莆单','鬼才老头','太尉老头','天辨嫣诸','司马问芫','卫尉语飞','都统语飞','征西文一','上将顾危','太师半山','凤雏臻菲','左徒二巫','军师乞蓉','御史桃秋','骠骑青岩','都尉青岩','征北桃',
			'都爵若颜','伏波莆单','恶来老头','太史老头','卧龙嫣诸','太守问芫','蛮夷语飞','令尹语飞','镇南文一','司徒半山','偏将半山','鬼才二巫','太尉二巫','天辨乞蓉','司马桃秋','卫尉青岩','都统青岩','征西桃','上将摇伽',
			'骁骑莆单','武痴老头','尚书老头','刺虎嫣诸','巡抚问芫','白马语飞','郡主语飞','镇北文一','都爵文一','伏波半山','恶来二巫','太史二巫','卧龙乞蓉','太守桃秋','蛮夷鬼神','令尹青岩','镇南桃','司徒摇伽','偏将摇伽',
			'武神老头','学士老头','锦帆嫣诸','校尉问芫','飞熊语飞','刺史语飞','镇西文一','文将文一','骁骑半山','武痴二巫','尚书二巫','刺虎乞蓉','巡抚桃秋','白马鬼神','郡主青岩','镇北桃','都爵桃','伏波摇伽','恶来睐世',
			'少保老头','文将珊天','教头问芫','虎豹冰叶','提辖语飞','镇东文一','龙将文一','征东半山','武神二巫','学士二巫','锦帆乞蓉','校尉桃秋','飞熊鬼神','刺史青岩','镇西桃','文将桃','骁骑摇伽','武痴睐世','尚书鬼神',
			'武圣嫣诸','从事问芫','小兵冰叶','丞相语飞','车骑文一','虎将文一','征南半山','侍中二巫','少保二巫','虎豹余乾 ','教头桃秋','虎豹鬼神','提辖青岩','镇东桃','龙将桃','征东摇伽','武神睐世','学士鬼神','锦帆半邪',
			'左徒问芫','军师冰叶','御史语飞','骠骑文一','都尉文一','征北半山','都督二巫','太傅二巫','征西珊天','从事桃秋','小兵鬼神','丞相青岩','车骑桃','虎将桃','征南摇伽','侍中睐世','少保鬼神','恶来冰叶','教头箴水',
			'天辨冰叶','司马语飞','卫尉文一','都统文一','征西半山','上将二巫','太师二巫','凤雏乞蓉','左徒桃秋','军师鬼神','御史青岩','骠骑桃','都尉桃','征北摇伽','都督睐世','太傅鬼神','武圣半邪','从事箴水','小兵箴水',
			'太守语飞','蛮夷半山','令尹文一','镇南半山','司徒二巫','偏将二巫','鬼才珩尤','太尉桃秋','天辨鬼神','司马青岩','卫尉桃','都统桃','征西摇伽','上将睐世','太师鬼神','凤雏半邪','左徒箴水','军师箴水','御史愁茗',
			'白马半山','郡主文一','镇北半山','都爵半山','伏波二巫','恶来珩尤','太史桃秋','卧龙鬼神','太守青岩','蛮夷桃','令尹桃','镇南摇伽','司徒鬼神','偏将鬼神','鬼才箴水','太尉箴水','天辨箴水','司马愁茗','卫尉龙梦',
			'刺史文一','镇西半山','文将半山','骁骑二巫','武痴珩尤','尚书桃秋','刺虎鬼神','巡抚青岩','白马桃','郡主桃','镇北摇伽','都爵摇伽','伏波鬼神','恶来箴水','太史箴水','卧龙箴水','太守愁茗','蛮夷乐奄','令尹龙梦',
			'镇东半山','龙将半山','征东二巫','武神珩尤','学士桃秋','锦帆鬼神','校尉青岩','飞熊桃','刺史桃','镇西摇伽','文将摇伽','骁骑鬼神','武痴箴水','尚书箴水','刺虎箴水','巡抚愁茗','白马乐奄','郡主龙梦','镇北言',
			'虎将半山','征南二巫','侍中珩尤','少保桃秋','上将鬼神','教头青岩','虎豹半山','提辖桃','镇东摇伽','龙将摇伽','征东鬼神','武神箴水','学士箴水','锦帆箴水','校尉愁茗','飞熊乐奄','刺史龙梦','镇西言','文将言',
			'征北二巫','都督珩尤','太傅桃秋','武圣鬼神','从事青岩','小兵半山','丞相桃','车骑摇伽','虎将摇伽','征南鬼神','侍中箴水','少保箴水','上将箴水','教头愁茗','虎豹迟紊','提辖龙梦','镇东言','龙将言','征东迟紊',
			'上将珩尤','太师桃秋','凤雏鬼神','左徒青岩','军师半山','御史桃','骠骑摇伽','都尉摇伽','征北鬼神','都督箴水','太傅箴水','武圣箴水','从事愁茗','小兵迟紊','丞相龙梦','车骑言','虎将言','征南迟紊','侍中半邪',
			'偏将桃秋','鬼才鬼神','太尉青岩','天辨半山','司马桃','卫尉摇伽','都统摇伽','征西鬼神','都统珊天','太师箴水','凤雏箴水','左徒愁茗','军师迟紊','御史龙梦','骠骑言','都尉言','征北迟紊','都督半邪','太傅乐奄',
			'恶来鬼神','太史青岩','卧龙半山','太守桃','蛮夷摇伽','令尹摇伽','镇南鬼神','司徒箴水','偏将箴水','鬼才愁茗','太尉愁茗','天辨迟紊','司马龙梦','卫尉言','都统言','征西迟紊','上将半邪','太师乐奄','凤雏周新',
			'尚书青岩','刺虎半山','巡抚桃','白马摇伽','郡主摇伽','镇北鬼神','都爵鬼神','伏波箴水','恶来愁茗','太史愁茗','卧龙迟紊','太守龙梦','蛮夷言','令尹言','镇南迟紊','司徒乐奄','偏将乐奄','鬼才余乾 ','太尉余乾 ',
			'锦帆半山','校尉桃','飞熊摇伽','刺史摇伽','镇西鬼神','文将鬼神','骁骑箴水','武痴愁茗','尚书愁茗','刺虎迟紊','巡抚龙梦','白马言','郡主言','镇北迟紊','都爵迟紊','伏波乐奄','恶来余乾 ','太史余乾 ','卧龙龙梦',
			'教头桃','虎豹姚山','提辖摇伽','镇东鬼神','龙将鬼神','征东箴水','武神愁茗','学士愁茗','锦帆迟紊','校尉龙梦','飞熊言','刺史言','镇西迟紊','文将迟紊','骁骑乐奄','武痴余乾 ','尚书余乾 ','刺虎龙梦','巡抚初连',
			'小兵姚山','丞相摇伽','车骑鬼神','虎将鬼神','征南箴水','侍中愁茗','少保愁茗','上将迟紊','教头龙梦','虎豹萧冥','提辖言','镇东迟紊','龙将迟紊','征东乐奄','武神余乾 ','学士余乾 ','锦帆龙梦','校尉初连','飞熊士萧',
			'御史摇伽','骠骑鬼神','都尉鬼神','征北箴水','都督愁茗','太傅愁茗','武圣迟紊','从事龙梦','小兵萧冥','丞相言','车骑迟紊','虎将迟紊','征南乐奄','侍中余乾 ','少保余乾 ','上将龙梦','教头初连','虎豹桃','提辖士萧',
			'卫尉鬼神','都统鬼神','征西箴水','上将愁茗','太师愁茗','凤雏迟紊','左徒龙梦','军师萧冥','御史言','骠骑迟紊','都尉迟紊','征北乐奄','都督余乾 ','太傅余乾 ','武圣龙梦','从事初连','小兵桃','丞相士萧','车骑姚山',
			'令尹鬼神','镇南箴水','司徒愁茗','偏将愁茗','鬼才乐奄','太尉龙梦','天辨萧冥','司马言','卫尉迟紊','都统迟紊','征西乐奄','上将余乾 ','太师余乾 ','凤雏龙梦','左徒初连','军师桃','御史士萧','骠骑姚山','都尉姚山',
			'镇北箴水','都爵箴水','伏波愁茗','恶来乐奄','太史龙梦','卧龙萧冥','太守言','蛮夷迟紊','令尹迟紊','镇南乐奄','司徒余乾 ','偏将余乾 ','鬼才道男','太尉初连','天辨桃','司马士萧','卫尉姚山','都统姚山','征西周天',
			'文将箴水','骁骑愁茗','武痴乐奄','尚书龙梦','刺虎萧冥','巡抚言','白马迟紊','郡主迟紊','镇北乐奄','都爵乐奄','伏波余乾 ','恶来道男','太史初连','卧龙桃','太守士萧','蛮夷姚山','令尹姚山','镇南周天','司徒盈乔',
			'征东愁茗','武神乐奄','学士龙梦','锦帆萧冥','校尉言','飞熊迟紊','刺史迟紊','镇西乐奄','文将乐奄','骁骑余乾 ','武痴道男','尚书初连','刺虎桃','巡抚士萧','白马姚山','郡主姚山','镇北周天','都爵周天','伏波盈乔',
			'侍中乐奄','少保龙梦','太傅珊天','教头言','虎豹小人','提辖迟紊','镇东乐奄','龙将乐奄','征东余乾 ','武神道男','学士初连','锦帆桃','校尉士萧','飞熊姚山','刺史姚山','镇西周天','文将周天','骁骑盈乔','武痴珠中',
			'太傅龙梦','武圣萧冥','从事言','小兵小人','丞相迟紊','车骑乐奄','虎将乐奄','征南余乾 ','侍中道男','少保初连','上将桃','教头士萧','虎豹叔一','提辖姚山','镇东周天','龙将周天','征东盈乔','武神珠中','学士冰叶',
			'凤雏萧冥','左徒言','军师小人','御史迟紊','骠骑乐奄','都尉乐奄','征北余乾 ','都督道男','太傅初连','武圣桃','从事士萧','小兵叔一','丞相姚山','车骑周天','虎将周天','征南盈乔','侍中珠中','少保冰叶','上将扬安',
			'太尉言','天辨小人','司马迟紊','卫尉乐奄','都统乐奄','征西余乾 ','上将道男','太师初连','凤雏桃','左徒士萧','军师叔一','御史姚山','骠骑周天','都尉周天','征北盈乔','都督珠中','太傅冰叶','武圣扬安','从事成败',
			'卧龙小人','太守迟紊','蛮夷半邪','令尹乐奄','镇南余乾 ','司徒初连','偏将初连','鬼才士萧','太尉士萧','天辨叔一','司马姚山','卫尉周天','都统周天','征西盈乔','上将珠中','太师冰叶','凤雏扬安','左徒成败','军师成败',


	},
	
	
	
	--武将属性配置  --16个基础属性数据(1-16)+8个技能数据(17-24)+2个血量怒气(25-26)+1武将id(27)
	--1-16 力量,敏捷,智力,最大生命值,物理攻击强度,法术攻击强度,物理护甲,法术抗性,物理暴击,生命回复,能量回复,吸血等级,穿透物理护甲,忽略法术抗性,治疗效果提升,闪避
	--17-24 技能id,技能等级....4组
	--25,26  血量,怒气
	--27 武将id
	attribute={
		[1] = {35,18,26,11728,758,452,374,150,111,1626,45,0,0,0,0,0,10200001,40,10200002,40,10200003,40,10200004,40,11728,0,102},
        [2] = {22,36,24,4583,782,1117,180,327,140,398,69,0,0,45,0,5,10300001,40,10300002,40,10300003,40,10300004,40,4583,0,103},
        [3] = {28,24,30,5924,928,515,317,144,228,504,45,31,40,0,0,0,10400001,40,10400002,40,10400003,40,10400004,40,5924,0,104},
        [4] = {16,16,19,3939,646,899,162,269,135,398,69,0,0,45,0,5,10500001,40,10500002,40,10500003,40,10500004,40,3939,0,105},
        [5] = {22,28,24,5711,735,1055,207,309,136,398,69,0,0,45,0,5,10600001,40,10600002,40,10600003,40,10600004,40,5711,0,106},
        [6] = {20,34,20,4357,713,1017,173,297,141,398,69,0,0,45,0,5,10700001,40,10700002,40,10700003,40,10700004,40,4357,0,107},
        [7] = {22,29,15,11436,734,651,356,214,90,1626,45,0,0,0,0,0,10800001,40,10800002,40,10800003,40,10800004,40,11436,0,108},
        [8] = {17,24,19,5893,775,728,265,211,143,504,45,31,40,0,0,0,10900001,40,10900002,40,10900003,40,10900004,40,5893,0,109},
        [9] = {16,21,16,4360,622,883,170,260,129,398,69,0,0,45,0,5,11000001,40,11000002,40,11000003,40,11000004,40,4360,0,110},
        [10] = {36,17,26,12005,808,420,397,144,137,1626,45,0,0,0,0,0,11100001,40,11100002,40,11100003,40,11100004,40,12005,0,111},
        [11] = {19,32,25,4451,737,1024,180,302,147,398,69,0,0,45,0,5,11200001,40,11200002,40,11200003,40,11200004,40,4451,0,112},
        [12] = {34,24,26,11472,751,445,369,159,122,1626,45,0,0,0,0,0,11300001,40,11300002,40,11300003,40,11300004,40,11472,0,113},
        [13] = {25,19,30,7369,777,568,344,162,210,504,45,31,40,0,0,0,11400001,40,11400002,40,11400003,40,11400004,40,7369,0,114},
        [14] = {22,13,17,9915,643,451,319,158,98,1626,45,0,0,0,0,0,11500001,40,11500002,40,11500003,40,11500004,40,9915,0,115},
        [15] = {25,21,26,7179,842,559,336,154,204,504,45,31,40,0,0,0,11700001,40,11700002,40,11700003,40,11700004,40,7179,0,117},
        [16] = {29,18,22,11163,722,531,345,183,91,1626,45,0,0,0,0,0,11800001,40,11800002,40,11800003,40,11800004,40,11163,0,118},
        [17] = {29,18,30,6454,908,520,324,146,222,504,45,31,40,0,0,0,11900001,40,11900002,40,11900003,40,11900004,40,6454,0,119},
        [18] = {32,28,23,12278,780,543,383,179,104,1626,45,0,0,0,0,0,12000001,40,12000002,40,12000003,40,12000004,40,12278,0,120},
        [19] = {24,20,18,11375,748,485,365,163,109,1626,45,0,0,0,0,0,12100001,40,12100002,40,12100003,40,12100004,40,11375,0,121},
        [20] = {31,22,24,11982,771,537,379,182,107,1626,45,0,0,0,0,0,12200001,40,12200002,40,12200003,40,12200004,40,11982,0,122},
        [21] = {20,16,617,11698,743,400,367,136,100,1626,45,0,0,0,0,0,12400001,40,12400002,40,12400003,40,12400004,40,11698,0,124},
        [22] = {18,26,20,4756,644,896,187,260,141,398,69,0,0,45,0,5,12500001,40,12500002,40,12500003,40,12500004,40,4756,0,125},
        [23] = {18,26,17,4897,670,955,183,281,127,398,69,0,0,45,0,5,12700001,40,12700002,40,12700003,40,12700004,40,4897,0,127},
        [24] = {18,25,11,5049,605,862,183,254,118,398,69,0,0,45,0,5,12900001,40,12900002,40,12900003,40,12900004,40,5049,0,129},
        [25] = {15,21,22,5981,644,883,219,260,137,398,69,0,0,45,0,5,13000001,40,13000002,40,13000003,40,13000004,40,5981,0,130},
        [26] = {21,15,17,10094,673,375,334,131,112,1626,45,0,0,0,0,0,13100001,40,13100002,40,13100003,40,13100004,40,10094,0,131},
        [27] = {23,17,14,10343,669,419,335,145,100,1626,45,0,0,0,0,0,13300001,40,13300002,40,13300003,40,13300004,40,10343,0,133},
        [28] = {24,18,19,10011,642,487,315,166,91,1626,45,0,0,0,0,0,13500001,40,13500002,40,13500003,40,13500004,40,10011,0,135},
        [29] = {19,24,16,4328,631,896,168,262,129,398,69,0,0,45,0,5,13700001,40,13700002,40,13700003,40,13700004,40,4328,0,137},
        [30] = {31,22,24,5842,893,587,308,168,217,504,45,31,40,0,0,0,13800001,40,13800002,40,13800003,40,13800004,40,5842,0,138},
        [31] = {17,18,24,5835,883,469,309,130,217,504,45,31,40,0,0,0,14000001,40,14000002,40,14000003,40,14000004,40,5835,0,140},
        [32] = {19,16,21,6679,761,440,312,123,182,504,45,31,40,0,0,0,14100001,40,14100002,40,14100003,40,14100004,40,6679,0,141},
        [33] = {31,22,25,11979,768,447,375,152,102,1626,45,0,0,0,0,0,14200001,40,14200002,40,14200003,40,14200004,40,11979,0,142},
        [34] = {23,23,26,6417,592,786,239,227,160,398,69,0,0,45,0,5,14300001,40,14300002,40,14300003,40,14300004,40,6417,0,143},
        [35] = {26,30,28,5286,683,947,202,281,144,398,69,0,0,45,0,5,14400001,40,14400002,40,14400003,40,14400004,40,5286,0,144},
        [36] = {24,19,25,4949,654,911,181,280,121,314,57,0,0,36,0,2,14600001,40,14600002,40,14600003,40,14600004,40,4949,0,146},

		
	},
}

