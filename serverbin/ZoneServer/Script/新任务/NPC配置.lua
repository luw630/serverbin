-- NPC的controlId实际是100000+编号
-- NPC的clickScript实际是30000+编号
--

任务NPC配置表 = {}

任务NPC配置表 = {
	[1] = {
			NpcCreate = { regionId = 1 , name = "玄慈" , title = '少林寺方丈' , npcimg="spr/头像/10.spr", imageId = 6 , x = 116 , y = 139 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '入我佛门，修行自身，终成正果，普度众生。', },
			},
	[2] = {
			NpcCreate = { regionId = 106 , name = "澄受" , title = '戒律院首座' , npcimg="spr/头像/11.spr", imageId = 7 , x = 37 , y = 103 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '巍巍嵩山，禅宗少林，尔等弟子莫不要负了少林寺这几百年的名声。', },
			},
	[3] = {
			NpcCreate = { regionId = 1 , name = "澄观" , title = '藏经阁首座' , npcimg="spr/头像/12.spr", imageId = 8 , x = 60 , y = 136 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = ' 一花一世界，一叶一如来。', },
			},
	[4] = {
			NpcCreate = { regionId = 1 , name = "澄武" , title = '罗汉堂首座' , npcimg="spr/头像/13.spr", imageId = 9 , x = 27 , y = 58 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '达摩祖师创立少林武学本为强身健体，却不知有多少世人曲解我佛门本来的意愿。', },
			},
	[5] = {
			NpcCreate = { regionId = 1 , name = "澄空" , title = '演武堂首座' , npcimg="spr/头像/14.spr", imageId = 10 , x = 70 , y = 90 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '少林威名绝不容外人挑衅！', },
			},
	[6] = {
			NpcCreate = { regionId = 104 , name = "晦明" , title = '木人巷管事' , npcimg="spr/头像/15.spr", imageId = 11 , x = 26 , y = 101 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '要想通过此处，先得通过少林木人桩、铁钉阵', },
			},
   [7] = {
			NpcCreate = { regionId = 108 , name = "晦恶" , title = '木人巷管事' , npcimg="spr/头像/16.spr", imageId = 31 , x = 37 , y = 103 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '奶奶的，这个地方连个苍蝇也飞不进来，真是寂寞死我了', },
			},
   [8] = {
			NpcCreate = { regionId = 1 , name = "伙头师兄" , title = '' , npcimg="spr/头像/17.spr", imageId = 32 , x = 7 , y = 10 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '谁要敢偷半点懒，就给我劈一天的柴、担一天的水去，在这里，只有我说了算。', },
			},
   [11] = {
			NpcCreate = { regionId = 100 , name = "止清" , title = '木人巷看守' , imageId = 14 , x = 63 , y = 39 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '少林弟子不得方丈法谕，不可擅闯木人巷。', },
			},
   [12] = {
			NpcCreate = { regionId = 102 , name = "止湛" , title = '基本功考师' , imageId = 15 , x = 32 , y = 84 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '十年磨一剑，没有扎实的基本功，何来更高深的武学。', },
			},
   [13] = {
			NpcCreate = { regionId = 109 , name = "止渊" , title = '禁地看守' , imageId = 33 , x = 9 , y = 80 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '前方乃木人巷禁地，历来只有方丈可以进入，除此之外任何人不得踏入半步。', },
			},
  	[14] = {
			NpcCreate = { regionId = 2 , name = "灭绝师太" , title = '峨眉派掌门' , npcimg="spr/头像/2.spr", imageId = 2 , x = 57, y = 61 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '魔教中人，个个阴险狡诈、作恶多端，有朝一日，我定要将其斩杀殆尽。', },
			},
   [15] = {
			NpcCreate = { regionId = 7 , name = "静慈师太" , title = '' , npcimg="spr/头像/1.spr", imageId = 1 , x = 143 , y = 77 , dir = 4 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '峨眉在掌门带领下，必能日益强大。', },
			},
   [16] = {
			NpcCreate = { regionId = 2 , name = "静念师太" , title = '' , npcimg="spr/头像/1.spr", imageId = 1 , x = 16 , y = 125 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '峨眉在掌门带领下，必能日益强大。', },
			},
	[18] = {
			NpcCreate = { regionId = 7 , name = "梅剑" , title = '金顶管事' , npcimg="spr/头像/4.spr", imageId =53  , x = 12 , y = 165 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '我峨眉不仅武功卓然出群，茶道更是冠绝天下。', },
			},
	[19] = {
			NpcCreate = { regionId = 2 , name = "周芷若" , title = '首席大弟子' , npcimg="spr/头像/3.spr", imageId = 3 , x = 73 , y = 135 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '一别经年，不知无忌哥哥是否一切安好', },
			},
	[20] = {
			NpcCreate = { regionId = 2 , name = "纪晓芙" , title = '' , npcimg="spr/头像/5.spr", imageId = 5 , x = 102 , y = 82, dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '不悔仲子逾我墙。', },
			},
	[21] = {
			NpcCreate = { regionId = 2 , name = "丁敏君" , title = '' , npcimg="spr/头像/9.spr", imageId = 57 , x = 97 , y =142 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '师父总是偏袒纪晓芙和周芷若，我得多做打算，免得掌门之位落入那二人之手', },
			},
   [23] = {
			NpcCreate = { regionId = 2 , name = "梅竹" , title = '仓库总管' , imageId = 54 , x = 6 , y = 100 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
   [24] = {
			NpcCreate = { regionId = 2 , name = "梅兰" , title = '杂货总管' , imageId = 55 , x = 9 , y = 96 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
   [25] = {
			NpcCreate = { regionId = 2 , name = "梅菊" , title = '装备总管' , imageId = 56 , x = 10 , y = 102 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
	[27] = {
			NpcCreate = { regionId = 4 , name = "杨逍" , title = '光明左使' , npcimg="spr/头像/28.spr", imageId = 18 , x = 109 , y = 64 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '生亦何欢，死亦何苦？', },
			},
   [28] = {
			NpcCreate = { regionId = 4 , name = "范遥" , title = '光明右使' , npcimg="spr/头像/29.spr", imageId = 19 , x = 74 , y = 77 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '熊熊圣火，焚我残躯。', },
			},
   [29] = {
			NpcCreate = { regionId = 9 , name = "谢逊" , title = '金毛狮王' , npcimg="spr/头像/24.spr", imageId = 17 , x = 58 , y = 24 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '武林至尊，宝刀屠龙！有朝一日，我定要拿屠龙刀手刃成昆那个恶贼！', },
			},
	[30] = {
			NpcCreate = { regionId = 4 , name = "黛绮丝" , title = '紫衫龙王' , npcimg="spr/头像/25.spr", imageId = 34 , x = 77 , y = 47 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '来如流水兮逝如风，不知何处来兮何所终', },
			},
   [31] = {
			NpcCreate = { regionId = 4 , name = "殷天正" , title = '白眉鹰王' , npcimg="spr/头像/26.spr", imageId = 35 ,  x = 73 , y = 48 , dir = 3 ,objectType = 1 , mType = 0,},
			NpcInfo = { talk = '我那外孙无忌，可真是有出息', },
			},
	[32] = {
			NpcCreate = { regionId = 4 , name = "韦一笑" , title = '青翼蝠王' , npcimg="spr/头像/27.spr", imageId = 52 , x = 76 , y = 51 , dir = 7 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '这世间最美味的，嘿嘿，莫过于人血了', },
			},
	[33] = {
			NpcCreate = { regionId = 9 , name = "说不得" , title = '布袋和尚' , npcimg="spr/头像/30.spr", imageId = 20 , x = 132 , y = 196 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '凡是说不得之事，我是不说的', },
			},
	[36] = {
			NpcCreate = { regionId = 4 , name = "小昭" , title = '' , npcimg="spr/头像/31.spr", imageId = 21 , x = 97 , y = 17 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '我只盼能一生一世服侍公子，永不分离', },
			},
   [38] = {
			NpcCreate = { regionId = 4 , name = "赵友来" , title = '仓库总管' , imageId = 36 , x = 82 , y = 14 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
   [39] = {
			NpcCreate = { regionId = 4 , name = "钱通" , title = '杂货总管' , imageId = 37 , x = 84 , y = 12 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
   [40] = {
			NpcCreate = { regionId = 4 , name = "孙铁" , title = '装备总管' , imageId = 38 , x = 86 , y = 10 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
   [41] = {
			NpcCreate = { regionId = 5 , name = "阿紫" , title = '小师妹' , npcimg="spr/头像/45.spr", imageId = 49 , x = 36 , y = 111 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '等我把化功大法练成了，大师兄他们就得改口管我叫大师姐了，哈哈。', },
			},
   [42] = {
			NpcCreate = { regionId = 5 , name = "丁春秋" , title = '星宿派掌门' , npcimg="spr/头像/44.spr", imageId = 43 , x = 11 , y = 19 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '星宿派源自天山逍遥一派，祖师乃逍遥子，不过此人我已不想再提。', },
			},
	[43] = {
			NpcCreate = { regionId = 5 , name = "出尘子" , title = '八师兄' , imageId = 50 , x = 29 , y = 39 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '师父他人家最器重的是武功最高的人，至于人品麽，嗯..嗯..那要排到最后去了。', },
			},
   [44] = {
			NpcCreate = { regionId = 10 , name = "天狼子" , title = '三师兄' , npcimg="spr/头像/47.spr", imageId = 44 , x = 154 , y = 192 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '若要人不知，除非己莫为，嘿嘿。', },
			},
   [45] = {
			NpcCreate = { regionId = 5 , name = "云中子" , title = '二师兄' , imageId = 4 , x = 46 , y = 13 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
	[46] = {
			NpcCreate = { regionId = 5 , name = "摘星子" , title = '首席大弟子' , npcimg="spr/头像/49.spr", imageId = 44 , x = 50 , y = 20 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '要想在星宿派中站稳这大师兄的位置，除了要有高深的武功之外，还得有敏锐的头脑。', },
			},
	[47] = {
			NpcCreate = { regionId = 10 , name = "采花子" , title = '五代弟子' , npcimg="spr/头像/48.spr", imageId = 25 , x = 158 , y = 50 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '这附近的人家都快被我逛完了，看来我得另觅他处了。', },
			},
	[48] = {
			NpcCreate = { regionId = 10 , name = "游坦之" , title = '铁丑' , npcimg="spr/头像/46.spr", imageId = 24 , x = 49 , y = 157 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '若是能长久的伴在她身边，即使每天只能望上一眼那也心满意足了。', },
			},
	[50] = {
			NpcCreate = { regionId = 5 , name = "巴司空" , title = '仓库总管' , imageId = 50 , x = 112 , y = 116 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
	[51] = {
			NpcCreate = { regionId = 5 , name = "巴温图" , title = '杂货总管' , imageId = 26 , x = 112 , y = 120 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
   [52] = {
			NpcCreate = { regionId = 5 , name = "巴德洛" , title = '装备总管' , imageId = 51 , x = 112 , y = 124 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
	[53] = {
			NpcCreate = { regionId = 3 , name = "张三丰" , title = '武当派掌门' , npcimg="spr/头像/35.spr", imageId = 22 , x = 10 , y = 70 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '武当之人，务必以修身、自律、节制为基本，时时为念，一生为念。', },
			},
   [54] = {
			NpcCreate = { regionId = 3 , name = "宋远桥" , title = '武当七侠' , npcimg="spr/头像/36.spr", imageId = 39 , x = 53 , y = 108 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '我一生授徒无数，竟没把自己的孩儿给教好，真是可悲可笑啊！', },
			},
   [55] = {
			NpcCreate = { regionId = 3 , name = "俞莲舟" , title = '武当七侠' , imageId = 4 , x = 6 , y = 66 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
   [56] = {
			NpcCreate = { regionId = 3 , name = "俞岱岩" , title = '武当七侠' , imageId = 4 , x = 6 , y = 47 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
   [57] = {
			NpcCreate = { regionId = 3 , name = "张松溪" , title = '武当七侠' , npcimg="spr/头像/37.spr", imageId = 40 , x = 9 , y = 63 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
   [58] = {
			NpcCreate = { regionId = 3 , name = "殷梨亭" , title = '武当七侠' , imageId = 3 , x = 3 , y = 69 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
	[59] = {
			NpcCreate = { regionId = 3 , name = "天枢道人" , title = '北斗名宿' , npcimg="spr/头像/40.spr", imageId = 42 , x = 72 , y = 76 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '武当山云雾袅绕，苍松挺拔，正是潜心修习的好地方。', },
			},
	[60] = {
			NpcCreate = { regionId = 8 , name = "天璇道人" , title = '北斗名宿' , imageId = 42 , x = 147 , y = 177 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '真武道场之中玄妙横生，入内之人当需格外小心才是', },
			},
	[61] = {
			NpcCreate = { regionId = 8 , name = "天权道人" , title = '北斗名宿' , imageId = 42 , x = 125, y = 155 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '老夫归隐于这真武道场之中多年，从不问世事，一心潜习道法，才能得今日的造化。', },
			},
	[62] = {
			NpcCreate = { regionId = 3 , name = "宋青书" , title = '首席大弟子' , npcimg="spr/头像/38.spr", imageId = 41 , x = 32 , y = 22 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '长江后浪推前浪，该是我们这些青年才俊一展抱负的时候了。', },
			},
	[64] = {
			NpcCreate = { regionId = 3 , name = "涵湘子" , title = '仓库总管' , imageId = 46 , x = 54 , y = 18 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
	[65] = {
			NpcCreate = { regionId = 3 , name = "涵萧子" , title = '杂货总管' , imageId = 47, x = 57 , y = 21 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
	[66] = {
			NpcCreate = { regionId = 3 , name = "涵山子" , title = '装备总管' , imageId = 48 , x = 60 , y = 24 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '', },
			},
	[67] = {
			NpcCreate = { regionId = 999 , name = "宋远桥" , title = '武当七侠' , npcimg="spr/头像/36.spr", imageId = 39 , x = 58 , y = 21 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '青书这孩子，老夫本指望着他能继承我的衣钵，哎，如今看来这希望实在渺茫！', },
			},
	[68] = {
			NpcCreate = { regionId = 7 , name = "枯萎的茶树" , title = '' , imageId = 62 , x = 143 , y = 87 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '因为严重缺乏养分，已经奄奄一息的茶树', },
			action = { 995, 3},
				
			condition = {
					completed = {2010}
				},
          
			},
	[69] = {
			NpcCreate = { regionId = 7 , name = "枯萎的茶树" , title = '' , imageId = 62 , x = 145 , y = 89 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '因为严重缺乏养分，已经奄奄一息的茶树', },
			action = { 995, 3},
				
			condition = {
					completed = {2010}
				},
			 
			},
	[70] = {
			NpcCreate = { regionId = 7 , name = "枯萎的茶树" , title = '' , imageId = 62 , x = 147 , y = 91 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '因为严重缺乏养分，已经奄奄一息的茶树', },
			action = { 995, 3},
			 
			condition = {
					completed = {2010}
				},
			 
			},
	[71] = {
			NpcCreate = { regionId = 0 , name = "武当弟子" , title = '北斗天权' , imageId = 22 , x = 14 , y = 102 , dir = 4 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '足踏七星，剑指北斗！', },
			},
	[72] = {
			NpcCreate = { regionId = 0 , name = "武当弟子" , title = '北斗玉衡' , imageId = 5 , x = 6 , y = 18 , dir = 7 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '足踏七星，剑指北斗！', },
			},
	[73] = {
			NpcCreate = { regionId = 0 , name = "武当弟子" , title = '北斗开阳' , imageId = 5 , x = 4 , y = 16 , dir = 7 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '足踏七星，剑指北斗！', },
			},
   [76] = {
			NpcCreate = { regionId = 7 , name = "虫蛀的茶树" , title = '' , npcimg="spr/头像/10.spr", imageId = 62 , x = 145 , y = 84 , dir = 3 , objectType = 1 , mType = 0,},
		        NpcInfo = { talk = '... ...', },
                        action = { 995,3},
				
			product = { {4033, 1,99}},
			condition = {
			                completed = {2010}
				},
			},		
   [77] = {
			NpcCreate = { regionId = 7 , name = "虫蛀的茶树" , title = '' , npcimg="spr/头像/10.spr", imageId = 62 , x = 145 , y = 84 , dir = 3 , objectType = 1 , mType = 0,},
		        NpcInfo = { talk = '... ...', },
                        action = {995,3},
				
			product = { {4033, 1,99}},
			condition = {
			                completed = {2010}
				},
			},
	[400000] = {
			NpcCreate = { name = "七巧机关" , title = '' , npcimg="spr/头像/10.spr", imageId = 63 , x = 80 , y = 102, dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '... ...', },
			action = { 995, 3},
				
			product = { {4001,1}},
			condition = {
					completed = {1012}
				},
			 完成事件 = { "GiveSP"},
			},
   [400001] = {
			NpcCreate = { name = "矿石" , title = '' , npcimg="spr/头像/10.spr", imageId = 60 , x = 73 , y = 17, dir = 5 , objectType = 1 , mType = 0,},
		        NpcInfo = { talk = '... ...', },
			action = {995,3},
				
			product = { {4029,1}},
			condition = {
					completed = {5004}
				},
			 完成事件 = { "GiveSP"},
			},
   [400002] = {
			NpcCreate = {name = "灯心草" , title = '' , npcimg="spr/头像/10.spr", imageId = 61 , x = 102 , y = 7, dir = 4 , objectType = 1 , mType = 0,},
		        NpcInfo = { talk = '... ...', },
			action = {995, 3},
				
		        product = { {4019,1}},
			condition = {
					completed = {2005}
				},
			 完成事件 = { "GiveSP"},
			},
   [400003] = {
			NpcCreate = { name = "迷迭香" , title = '' , npcimg="spr/头像/10.spr", imageId = 61 , x = 40 , y = 136, dir = 4 , objectType = 1 , mType = 0,},
		        NpcInfo = { talk = '... ...', },
			action = {995, 3},
				
		        product = { {4020,1}},
			condition = {
					completed = {4016}
				},
			 完成事件 = { "GiveSP"},
			},
   [400004] = {
			NpcCreate = {name = "紫悬草" , title = '' , npcimg="spr/头像/10.spr", imageId = 61 , x = 118 , y = 30, dir = 4 , objectType = 1 , mType = 0,},
		        NpcInfo = { talk = '... ...', },
			action = {995, 3},
				
		        product = { {4003,1}},
			condition = {
					completed = {3007}
				},
			 完成事件 = { "GiveSP"},
			},
   [400005] = {
			NpcCreate = {name = "宋远桥" , title = '武当七侠' , npcimg="spr/头像/36.spr", imageId = 39 , x = 58 , y = 21 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '青书乃是武当新一代弟子中的好手，等你学习护体神功后，与之交手才更有把握。', },
			},
	[82] = {
			NpcCreate = { regionId = 9 , name = "说不得" , title = '分身壹重' , npcimg="spr/头像/30.spr", imageId = 20 , x = 85 , y = 138 , dir = 4 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '凡是说不得之事，我是不说的', },
			},
	[83] = {
			NpcCreate = { regionId = 9 , name = "说不得" , title = '分身贰重' , npcimg="spr/头像/30.spr", imageId = 20 , x = 53 , y = 197 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '凡是说不得之事，我是不说的', },
			},
	[84] = {
			NpcCreate = { regionId = 9 , name = "说不得" , title = '分身叁重' , npcimg="spr/头像/30.spr", imageId = 20 , x = 50 , y = 32 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '凡是说不得之事，我是不说的', },
			},
   [85] = {
			NpcCreate = { regionId = 9 , name = "万年玄冰" , title = '' , npcimg="spr/头像/10.spr", imageId = 60 , x = 31 , y = 163, dir = 4 , objectType = 1 , mType = 0,},
		        NpcInfo = { talk = '... ...', },
			action = {995, 3},
				 
		        product = { {4026,1}},
			condition = {
					completed = {3012}
				},
           
			},
	[86] = {
			NpcCreate = { regionId = 17 , name = "武林盟使者" , title = '京城接引' , npcimg="spr/头像/36.spr", imageId = 51 , x = 32 , y = 136 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '武林盟盛邀江湖各路豪杰，前往华山一聚。', },
			},
	[87] = {
			NpcCreate = { regionId = 73 , name = "武林盟使者" , title = '华山接引' , npcimg="spr/头像/36.spr", imageId = 51 , x = 13 , y = 204 , dir = 4 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '武林盟盛邀江湖各路豪杰，前往华山一聚。', },
			},
	[88] = {
			NpcCreate = { regionId = 73 , name = "武林盟使者" , title = '华山接引' , npcimg="spr/头像/36.spr", imageId = 51 , x = 19 , y = 204 , dir = 4 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '武林盟盛邀江湖各路豪杰，前往华山一聚。', },
			},
	[89] = {
			NpcCreate = { regionId = 1 , name = "门派传送" , title = '驿站' , npcimg="spr/头像/36.spr", imageId = 26 , x = 35 , y = 155 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '少林弟子由我这里可前往京城。', },
		   NpcFunction = {
									{10000, "驿站传送",{school = 0}},
							},
			},
	[90] = {
			NpcCreate = { regionId = 2 , name = "门派传送" , title = '驿站' , npcimg="spr/头像/36.spr", imageId = 26 , x = 5 , y = 149 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '峨眉弟子由我这里可前往京城。', },
		   NpcFunction = {
									{10001, "驿站传送",{school = 1}},
							},
			},
	[91] = {
			NpcCreate = { regionId = 3 , name = "门派传送" , title = '驿站' , npcimg="spr/头像/36.spr", imageId = 26 , x = 5 , y = 103 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '武当弟子由我这里可前往京城。', },
		   NpcFunction = {
									{10002, "驿站传送",{school = 2}},
							},
			},
	[92] = {
			NpcCreate = { regionId = 4 , name = "门派传送" , title = '驿站' , npcimg="spr/头像/36.spr", imageId = 26 , x = 42 , y = 116 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '圣火弟子由我这里可前往京城。', },
		   NpcFunction = {
									{10003, "驿站传送",{school = 3}},
							},
			},
	[93] = {
			NpcCreate = { regionId = 5 , name = "门派传送" , title = '驿站' , npcimg="spr/头像/36.spr", imageId = 26 , x = 14 , y = 158 , dir = 5 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '星宿弟子由我这里可前往京城。', },
		   NpcFunction = {
									{10004, "驿站传送",{school = 4}},
							},
			},
	[100] = {
			NpcCreate = { regionId = 17 , name = "驿站传送" , title = '' , npcimg="spr/头像/36.spr", imageId = 26 , x = 24 , y = 14 , dir = 4 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '由我这里可返回门派。', },
		   NpcFunction = {
									{10005, "驿站传送"},
							},
			},
	[94] = {
			NpcCreate = { regionId = 73 , name = "少林派弟子" , title = '' , npcimg="spr/头像/36.spr", imageId = 68 , x = 12 , y = 176 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '天下武学皆出少林，这华山论剑单论武艺来说，其他门派只怕是及不上了。', },
			},
	[95] = {
			NpcCreate = { regionId = 73 , name = "峨嵋派弟子" , title = '' , npcimg="spr/头像/36.spr", imageId = 69 , x = 10 , y = 136 , dir = 4 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '峨眉弟子虽皆是女儿之身，武艺之上却从不曾输给男子。', },
			},
	[96] = {
			NpcCreate = { regionId = 73 , name = "武当派弟子" , title = '' , npcimg="spr/头像/36.spr", imageId = 70 , x = 12 , y = 114 , dir = 4 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '华山论剑之期十年方才一至，我辈同人都想前去一睹各位武林前辈的风采。', },
			},
	[97] = {
			NpcCreate = { regionId = 73 , name = "圣火教弟子" , title = '' , npcimg="spr/头像/36.spr", imageId = 72 , x = 20 , y = 84 , dir = 4 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '圣火教向来为外人所误解，此次正好借华山论剑盛事向众武林同道亮亮我教派的声威，也好让他们今后闭口。', },
			},
	[98] = {
			NpcCreate = { regionId = 73 , name = "星宿派弟子" , title = '' , npcimg="spr/头像/36.spr", imageId = 71 , x = 10 , y = 70 , dir = 3 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '如此千载难逢的机会，岂能少了我星宿派的位置。', },
			},
	[99] = {
			NpcCreate = { regionId = 73 , name = "武林盟使者" , title = '华山接引' , npcimg="spr/头像/36.spr", imageId = 51 , x = 14 , y = 60 , dir = 4 , objectType = 1 , mType = 0,},
			NpcInfo = { talk = '再往前走几步便是众英雄华山论剑的地方了。', },
			},

}