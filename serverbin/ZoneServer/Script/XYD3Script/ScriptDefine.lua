-- 门派定义
XS_WUYUE 		= 1		-- 人类
XS_SHUSHAN		= 2		-- 狼人
XS_SHAOLIN		= 3		-- 吸血鬼
XS_CIHANG		= 4		-- 天使
XS_RIYUE		= 5		-- 日月
XS_SCHOOL_ALL	= 10	-- 不限

-- 性别定义
XS_FEMALE		= 0		-- 女性
XS_MALE			= 1		-- 男性
XS_SEX_ALL		= 2		-- 不限


-- 任务状态定义
TS_NOTACCEPT	= 1		-- 未接
TS_ACCEPTED		= 2		-- 已接（完成中）
TS_FINISHED		= 3		-- 已完成（未交）
TS_COMPLETE		= 4		-- 已交
TS_TALKIMME		= 5		-- 对话（中介）
TS_GIVE			= 6     -- 给NPC道具（中介）
TS_GET			= 7     -- 从NPC处获得道具（中介）

-- 获取玩家状态枚举(GetPlayerData函数参数)
GPP_GONGJILI	= 0		--攻击力
GPP_SCHOOL		= 23		-- 门派
GPP_LEVEL		= 10		-- 等级

GPP_MAXHP		= 4		-- 最大HP
GPP_TongName	= 5		--帮派名字
GPP_XYValue	= 6		--侠义值
GPP_PKValue	= 7		--杀孽值
GPP_JINGLI	= 8		--精力值
GPP_CUREXP	= 9		--当前经验
--GPP_CURSP	= 10		--真气
GPP_SPEED	= 11		--速度
GPP_ATTSPEED	= 12		--攻击速度
GPP_QINGSHEN	= 13		--轻功点数
GPP_JIANSHEN	= 14	--强健点数
GPP_LOVEER	= 15		--配偶名字
GPP_MAXMP	= 16		--最大MP
GPP_MAXTP	= 17		--最大TP
GPP_CURHP	= 18		--当前HP
GPP_CURMP	= 19		--当前MP
GPP_CURTP	= 20		--当前TP
GPP_CURSP   = 21        --真气


GPP_FANGYULI	= 1		--防御力
GPP_BAOJI	= 2		--暴击
GPP_SHANBI	= 3		--闪避
GPP_FANGYU	= 25		--防御点数
GPP_JIGONGPOINT	= 26		--进攻点数
GPP_REMAILPOINT	= 27		--剩余点数
GPP_MYName	= 28		--名字
GPP_MYACCOUNT	= 29		--账号
GPP_MYMONEY	= 30		--非绑定钱
GPP_MYBINDMONEY	= 31		--绑定钱
GPP_MYGOLD	= 32		--玩家当前元宝数量
GPP_SHANGHAIJIANMIAN= 33		--玩家伤害减免
GPP_JUEDUISHANGHAI	= 34		--玩家绝对伤害
GPP_WUSHIFANGYU	= 35		--玩家无视防御
GPP_QILINDENGJI	= 36		--玩家麒麟臂等级
GPP_QUANJUGID	= 37		--玩家全局GID
GPP_QUANJUSID	= 38		--玩家全局SID
GPP_QUANPOS		= 39		--玩家POS
GPP_ACTION		= 40		--玩家动作状态
GPP_CURPOS     = 41        --玩家浮点数POS
GPP_TRANSFORSTATE     = 42        --玩家变身状态
GPP_BLess   = 99        --玩家祈福是否扣钱
GPP_SEX			= 100		-- 性别
GPP_VIPLEVEL			= 101		-- VIP等级
-----------------------------------------------------
-- Buff可以修改的属性/状态列表
BAP_CHP			= 0			-- 当前生命
BAP_CMP			= 1			-- 当前内力
BAP_MHP			= 2			-- 生命上限
BAP_MMP			= 3			-- 内力上限
BAP_PHYATK		= 4			-- 外功攻击
BAP_FPATK		= 5			-- 内功攻击
BAP_PHYDEFENCE	= 6			-- 外功防御
BAP_FPDEFENCE	= 7			-- 内功防御
BAP_PHYHIT		= 8			-- 外功命中
BAP_FPHIT		= 9			-- 内功命中
BAP_PHYESCAPE	= 10		-- 外功躲避
BAP_FPESCAPE	= 11		-- 内功躲避
BAP_OUTCRIATT	= 12		-- 外功暴击
BAP_INCRIATT	= 13		-- 内功暴击
BAP_SPEED		= 14		-- 速度
BAP_SORBDAM		= 15		-- 伤害吸收值
BAP_SORBDAM_PER	= 16		-- 伤害吸收百分比

BAP_DIZZY		= 1000		-- 眩晕
BAP_LIMIT_SKILL	= 1001		-- 封招
BAP_HYPNOTISM	= 1002		-- 催眠

BAP_NULL 		= 0xffff	-- 什么都不修改

-- Buff事件的触发点
BATS_ADD 		= 0			-- 当Buff被添加到玩家身上时触发
BATS_REMOVE		= 1			-- 当Buff从玩家身上移除时触发
BATS_CANCEL		= 2			-- 当Buff被打断时触发
BATS_INTERVAL	= 3			-- 间隔触发

-- Buff值改变方式
BAM_POT 		= 0			-- 改变值
BAM_PRECENT		= 1			-- 改变百分比

-- 删除方式
BDT_NULL		= 0x00000000		-- 普通的到期删除/被顶替/下线删除
BDT_ATTACKED	= 0x00000001		-- 被攻击消失
BDT_DAMAGED		= 0x00000002		-- 受到伤害消失
BDT_DEAD		= 0x00000004		-- 死亡消失

-- 保存方式
BST_NULL			= 1				-- 不保存
BST_SAVE_WITH_TIME	= 2				-- 保存，但记录离线时间
BST_SAVE_NO_TIME	= 3				-- 保存，不记录离线时间


--登录奖励配置
REWARD_TOTAL = 1  --累计登录奖励
REWARD_CONTIN = 2  --连续登录奖励
REWARD_CHENJIU = 3  --成就奖励
REWARD_OFFLINE = 4  --离线奖励
REWARD_BUCHANG = 5  --补偿奖励
REWARD_CHONGZHI = 6  --充值奖励

--道具类型定义
ITEM_T_MEDICINE_HP		= 7		--// 生命药
ITEM_T_MEDICINE_MP		= 8		--// 内力药
ITEM_T_MEDICINE_TP		= 9		--// 体力药
ITEM_T_NORMAL			= 10	--// 普通道具
ITEM_T_JEWEL			= 11	--// 宝石道具
ITEM_T_CHANGE			= 12	--// 可变道具
ITEM_T_METRAIL			= 13	--// 材料道具
ITEM_T_TOOL				= 14	--// 工具道具
ITEM_T_BOOK				= 15	--// 书籍道具
ITEM_T_TASK				= 16	---// 任务道具
ITEM_T_RECYCLE			= 17	--// 定时回收道具
ITEM_T_FIGHT_PET		= 18	--// 侠客道具
ITEM_T_PRESENT          = 19	--// 礼包道具
ITEM_T_SUIT_SCROLL		= 20	--// 套装卷轴
ITEM_T_EQUIPMENT_BEGIN	= 101	--// 装备类道具（和EQUIP_TYPE对应）
ITEM_T_EQUIPMENT_END	= 114	 --


--// 装备位置定义
EQUIP_P_WEAPON 				= 	0					--// 武器
EQUIP_P_SHOSE 				= 	1					--// 鞋子
EQUIP_P_PAT 				= 	2						--// 护肩
EQUIP_P_WAIST 				= 	3					--// 腰带
EQUIP_P_WRIST 				= 	4					--	// 手套
EQUIP_P_CLOTH 				= 	5					--	// 衣服
EQUIP_P_HAT 				= 	6						--// 头部装备
EQUIP_P_MANTLE 				= 	7					--	// 披风
EQUIP_P_PENDANTS1 			= 	8				--	// 配饰1
EQUIP_P_PENDANTS2 			= 	9				--	// 配饰2
EQUIP_P_PROTECTION 			= 	10				--// 项链
EQUIP_P_RING1 				= 	11					--	// 戒指1
EQUIP_P_RING2 				= 	12					--	// 戒指2
EQUIP_P_PRECIOUS 			= 	13				--	// 武器2
EQUIP_P_SHIZHUANG_HAT1 	 	= 	14			--	//  武器3
EQUIP_P_SHIZHUANG_CLOTH1 	= 	15		--// 时装衣服1
EQUIP_P_MAX 			 	= 	16					--// Max


--// 玩家/侠客装备类型定义
EQUIP_T_WEAPON				= 		101			--// 武器1
EQUIP_T_HAT					= 		102				--// 头带
EQUIP_T_WRIST				= 		103				--// 护腕
EQUIP_T_PAT					= 		104				--// 裤子
EQUIP_T_WAIST				= 		105				--// 腰带
EQUIP_T_SHOSE				= 		106				--// 鞋子
EQUIP_T_CLOTH				= 		107				--// 衣服
EQUIP_T_MANTLE				= 		108				--// 备用1 宝物
EQUIP_T_PENDANTS			= 		109			--//  备用2 法器
EQUIP_T_PROTECTION			= 		110			--// 项链
EQUIP_T_RING				= 		111				--// 戒指
EQUIP_T_PRECIOUS			= 		112			--// 武器2
EQUIP_T_SHIZHUANG_HAT		= 		113		--// 武器3
EQUIP_T_SHIZHUANG_CLOTH		= 		114	--// 时装（衣服） t腰带

--道具品质定义
--青铜（暗黄色）、黑铁（深灰色）、白银（银色）、黄金（金色）、暗金（黑金色）、白金（亮金色）、墨玉（黑绿色）、碧玉（亮绿色）、红玉（红色）、宝器
QUALITY_DYELLOW = 1  	--青铜（暗黄色）
QUALITY_DGRAY = 2 		--黑铁（深灰色）
QUALITY_SILVER = 3 		--白银（银色）
QUALITY_GOLD = 4 		--黄金（金色）
QUALITY_BLMETAL = 5 	--暗金（黑金色）
QUALITY_BGOLD = 6  		--白金（亮金色）
QUALITY_BLGREEN = 7 	--墨玉（黑绿色）
QUALITY_LGREEN = 8 		--碧玉（亮绿色）
QUALITY_RED = 9 		--红玉（红色）
QUALITY_TREASURE = 10 	--宝器




--// 装备属性定义
EEA_MAXHP			= 	0		--// 生命上限
EEA_MAXMP			= 	1		--// 内力上限
EEA_GONGJI			= 	2		--// 攻击
EEA_FANGYU			= 	3		--// 防御
EEA_HIT             =   4       --//命中
EEA_SHANBI          =   5       --// 闪避
EEA_BAOJI			= 	6		--// 暴击
EEA_UNCRIT          =   7       -- //抗暴
EEA_WRECK           =   8       --//破击
EEA_UNWRECK         =   9       -- //抗破
EEA_PUNCTURE        =   10      --//穿刺
EEA_UNPUNCTURE      =   11      --//抗穿

-- EEA_SPEED			= 	7		--// 移动速度
-- EEA_ATKSPEED		= 	8		--// 攻击速度
-- EEA_REDUCEDAMAGE	= 	9		--// 伤害减免--// 新添加的属性
-- EEA_ABSDAMAGE		= 	10		--// 绝对伤害
-- EEA_NONFANGYU		= 	11		--// 无视防御
-- EEA_MULTIBAOJI		= 	12		--// 暴击倍数
-- EEA_ICE_DAMAGE		= 	13		--// 冰伤害
-- EEA_ICE_DEFENCE		= 	14		--// 冰抗性
-- EEA_FIRE_DAMAGE		= 	15		--// 火伤害
-- EEA_FIRE_DEFENCE	= 	16		--// 火抗性
-- EEA_XUAN_DAMAGE		= 	17		--// 玄伤害
-- EEA_XUAN_DEFENCE	= 	18		--// 玄抗性
-- EEA_POISON_DAMAGE	= 	19		--// 毒伤害
-- EEA_POISON_DEFENCE	= 	20		--// 毒抗性
EEA_MAX             = 	21     --

--关卡胜利条件
SPECIFIC_MONSTERDIE		=	1      --指定ID怪物死亡
All_MONSTERDIE			=	2 	   --所有怪物死亡
SPECIFIC_MONSTERDIENUM    =   3      --怪物死亡数量
SPECIFIC_OBJDESTPOINT	=	4   --对象到达知道区域，地点 
SPECIFIC_ITEMNUM    =   5      --得到指定数量道具

--关卡类型
SCENE_COMMON = 1     		--普通通关
SCENE_SD = 2 				--扫荡通关

--关卡怪物刷新类型
REFRSHTYPE_MONSTERDIR = 1   --怪物死亡后刷新
REFRSHTYPE_TIMEREACH = 2   --到达指定时间后刷新刷新
REFRSHTYPE_REGION = 3   --玩家到达指定范围内刷新
REFRSHTYPE_GROUP = 4   --分组多次刷新
REFRSHTYPE_REGIONRANDOM = 5   --随机刷新怪物
REFRSHTYPE_REGIONCOMMON = 6   --普通刷新怪物


--对象类型
OBJECT_PLAYER 		= 0  --玩家 
OBJECT_NPC 			= 1  --NPC 
OBJECT_MONSTER  	= 2  --怪物 
OBJECT_ITEM 		= 3  --道具 
OBJECT_PET 		 	= 4  --侠客战斗宠物 
OBJECT_SIGLEITEM    = 5  --掉落的道具

--进入关卡失败
SCENE_ENTER_SP 			= 2 --体力不足
SCENE_ENTER_TIME 		= 3 --次数不足
SCENE_ENTER_MONEY 		= 4 --金钱不足


--扫荡状态定义
SCENE_SD_ISSTART 	 = 1  --可以开始扫荡或者闯关
SCENE_SD_ISSDNOW 	 = 2  --玩家正在扫荡过程中
SCENE_SD_ISWAITAWARD = 3  --等待玩家领取扫荡奖励
SCENE_PB_SENDAWARD 	 = 4  --发送玩家普通闯关奖励
SCENE_PB_RECVAWARD 	 = 5  --玩家已经领取普通闯关奖励


--动作状态类型
EA_STAND = 0
EA_WALK= 1
EA_RUN= 2
EA_JUMP = 3
EA_ZAZEN = 4
EA_ATTACK = 5	
EA_WOUND = 6
EA_DEAD = 7
EA_SKILL_ATTACK = 8		-- 侠义世界：新逻辑使用的攻击状态
EA_USEITEM = 9				-- 新增加一个用来做物品处理
EA_COLLECT = 10				-- 采集
EA_DIZZY = 11						--眩晕
EA_MAX = 12	


--对象战斗属性 GetObjectFightData
FIGHTOBJ_LEVEL	 = 0 --等级
FIGHTOBJ_CURHP	 = 1 --当前生命
FIGHTOBJ_GONHJI	 = 2 --攻击力
FIGHTOBJ_FANGYU	 = 3 --防御值
FIGHTOBJ_HIT	 = 4 --命中
FIGHTOBJ_SHANBI	 = 5 --闪避
FIGHTOBJ_BAOJI	 = 6 --暴击
FIGHTOBJ_UNCRIT = 7  --抗暴
FIGHTOBJ_WRECK = 8	--破击
FIGHTOBJ_UNWRECK = 9 --抗破
FIGHTOBJ_PUNCTURE = 10 --穿刺
FIGHTOBJ_UNPUNCTURE = 11 --抗穿

--对象属性 GetObjectData
OBJDATA_GONHJI	 = 0 --攻击力
OBJDATA_FANGYU	 = 1 --防御
OBJDATA_BAOJI	 = 2 --暴击
OBJDATA_LEVEL	 = 10 --等级
OBJDATA_MAXHP	 = 4 --最大生命
OBJDATA_MAXMP    = 16 --最大内力值
OBJDATA_MAXTP    = 17 --最大体力值
OBJDATA_CURHP    = 18 --当前生命值
OBJDATA_CURMP    = 19 --当前内力值
OBJDATA_CURTP    = 20 --当前体力值
OBJDATA_ID	 = 23  --怪物ID
OBJDATA_SP   = 21  --玩家真气


-- 获取怪物状态枚举(GetMonsterData函数参数)
GMon_LEVEL          = 1     -- 怪物等级
GMon_ID             = 2     -- 怪物Monster模板ID
GMon_NAME           = 3     -- 怪物Name
GMon_EXP            = 4     -- 怪物经验
GMon_LevelType      = 5     -- 怪物类型（普通&精英&BOSS）
GMon_CURHP          = 6     -- 怪物当前血量
GMon_MaxHP          = 7     -- 怪物最大血量
GMon_AttType        = 8     -- 怪物攻击类型
GMon_LastEnemyID    = 9     -- 谁攻击了我
GMon_GroupID        = 10    -- 怪物的组别的ID
GMon_PartolRadius   = 11    -- 监控半径
GMon_TailLength     = 12    -- 追击半径
GMon_NodeCount      = 13    -- 路点总个数
GMon_CurNode        = 14    -- 当前路点个数
GMon_MoveType       = 15    -- 移动类型
GMon_Move2Att       = 16    -- 是否移动去攻击
GMon_CurrAction     = 17    -- 当前移动行为站立还是跑 还是其他
GMon_HPcent         = 18    -- 当前生命百分比
GMon_BackProtect    = 19    -- 处于返回保护
GMon_BornTime       = 20    -- 出生到现在的时间
GMon_POSTION        = 21    -- 坐标float XY
GMon_AIID           = 22    -- 怪物AI——id

--技能攻击时发送的攻击类型
Hit = 0				-- 命中
Not_Hit = 1			--未命中
BAOJI_HIT	=	2				--暴击
UNCRIT_HIT	=	3				--抗暴
WRECK_HIT	=	4			--破击
UNWRECK_HIT =	5			--抗破
PUNCTURE_HIT=	6		--穿刺
UNPUNCTURE_HIT= 7	 --抗穿


--新增任务
TASK_EINTENSIFY = 0  --装备强化
TASK_EJDING = 1 -- //装备鉴定
TASK_ERISE = 2 -- //装备升星
TASK_EKEYIN = 3  --//装备刻印
TASK_EQUALITY = 4 -- //装备升阶
TASK_XINYANG = 5 --//信仰任务
TASK_TRANSFORMERS = 6--//变身任务
TASK_SKILL = 7 --//技能任务 技能升级
TASK_SCENE = 8 --//关卡完成次数


--所处场景类型
REGION_COMMON = 1 --普通场景
REGION_DYREGION = 2 --动态场景
REGION_DYSCENE = 3 --关卡场景
REGION_DYARENA = 4 --竞技场场景


--战斗状态

FS_NONE         = 0              -- // 无    
FS_DIZZY        = 1      -- // 眩晕
FS_LIMIT_SKILL  = 2      -- // 封招
FS_HYPNOTISM    = 4     -- // 催眠
FS_DINGSHENG    = 8       --// 定身
FS_WUDI = 16     --// 无敌
FS_ADDBUFF = 32       -- // 无法附加任何BUFF
FS_JITUI = 64      --// 被击退
