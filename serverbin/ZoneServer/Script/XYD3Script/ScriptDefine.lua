-- ���ɶ���
XS_WUYUE 		= 1		-- ����
XS_SHUSHAN		= 2		-- ����
XS_SHAOLIN		= 3		-- ��Ѫ��
XS_CIHANG		= 4		-- ��ʹ
XS_RIYUE		= 5		-- ����
XS_SCHOOL_ALL	= 10	-- ����

-- �Ա���
XS_FEMALE		= 0		-- Ů��
XS_MALE			= 1		-- ����
XS_SEX_ALL		= 2		-- ����


-- ����״̬����
TS_NOTACCEPT	= 1		-- δ��
TS_ACCEPTED		= 2		-- �ѽӣ�����У�
TS_FINISHED		= 3		-- ����ɣ�δ����
TS_COMPLETE		= 4		-- �ѽ�
TS_TALKIMME		= 5		-- �Ի����н飩
TS_GIVE			= 6     -- ��NPC���ߣ��н飩
TS_GET			= 7     -- ��NPC����õ��ߣ��н飩

-- ��ȡ���״̬ö��(GetPlayerData��������)
GPP_GONGJILI	= 0		--������
GPP_SCHOOL		= 23		-- ����
GPP_LEVEL		= 10		-- �ȼ�

GPP_MAXHP		= 4		-- ���HP
GPP_TongName	= 5		--��������
GPP_XYValue	= 6		--����ֵ
GPP_PKValue	= 7		--ɱ��ֵ
GPP_JINGLI	= 8		--����ֵ
GPP_CUREXP	= 9		--��ǰ����
--GPP_CURSP	= 10		--����
GPP_SPEED	= 11		--�ٶ�
GPP_ATTSPEED	= 12		--�����ٶ�
GPP_QINGSHEN	= 13		--�Ṧ����
GPP_JIANSHEN	= 14	--ǿ������
GPP_LOVEER	= 15		--��ż����
GPP_MAXMP	= 16		--���MP
GPP_MAXTP	= 17		--���TP
GPP_CURHP	= 18		--��ǰHP
GPP_CURMP	= 19		--��ǰMP
GPP_CURTP	= 20		--��ǰTP
GPP_CURSP   = 21        --����


GPP_FANGYULI	= 1		--������
GPP_BAOJI	= 2		--����
GPP_SHANBI	= 3		--����
GPP_FANGYU	= 25		--��������
GPP_JIGONGPOINT	= 26		--��������
GPP_REMAILPOINT	= 27		--ʣ�����
GPP_MYName	= 28		--����
GPP_MYACCOUNT	= 29		--�˺�
GPP_MYMONEY	= 30		--�ǰ�Ǯ
GPP_MYBINDMONEY	= 31		--��Ǯ
GPP_MYGOLD	= 32		--��ҵ�ǰԪ������
GPP_SHANGHAIJIANMIAN= 33		--����˺�����
GPP_JUEDUISHANGHAI	= 34		--��Ҿ����˺�
GPP_WUSHIFANGYU	= 35		--������ӷ���
GPP_QILINDENGJI	= 36		--�������۵ȼ�
GPP_QUANJUGID	= 37		--���ȫ��GID
GPP_QUANJUSID	= 38		--���ȫ��SID
GPP_QUANPOS		= 39		--���POS
GPP_ACTION		= 40		--��Ҷ���״̬
GPP_CURPOS     = 41        --��Ҹ�����POS
GPP_TRANSFORSTATE     = 42        --��ұ���״̬
GPP_BLess   = 99        --������Ƿ��Ǯ
GPP_SEX			= 100		-- �Ա�
GPP_VIPLEVEL			= 101		-- VIP�ȼ�
-----------------------------------------------------
-- Buff�����޸ĵ�����/״̬�б�
BAP_CHP			= 0			-- ��ǰ����
BAP_CMP			= 1			-- ��ǰ����
BAP_MHP			= 2			-- ��������
BAP_MMP			= 3			-- ��������
BAP_PHYATK		= 4			-- �⹦����
BAP_FPATK		= 5			-- �ڹ�����
BAP_PHYDEFENCE	= 6			-- �⹦����
BAP_FPDEFENCE	= 7			-- �ڹ�����
BAP_PHYHIT		= 8			-- �⹦����
BAP_FPHIT		= 9			-- �ڹ�����
BAP_PHYESCAPE	= 10		-- �⹦���
BAP_FPESCAPE	= 11		-- �ڹ����
BAP_OUTCRIATT	= 12		-- �⹦����
BAP_INCRIATT	= 13		-- �ڹ�����
BAP_SPEED		= 14		-- �ٶ�
BAP_SORBDAM		= 15		-- �˺�����ֵ
BAP_SORBDAM_PER	= 16		-- �˺����հٷֱ�

BAP_DIZZY		= 1000		-- ѣ��
BAP_LIMIT_SKILL	= 1001		-- ����
BAP_HYPNOTISM	= 1002		-- ����

BAP_NULL 		= 0xffff	-- ʲô�����޸�

-- Buff�¼��Ĵ�����
BATS_ADD 		= 0			-- ��Buff����ӵ��������ʱ����
BATS_REMOVE		= 1			-- ��Buff����������Ƴ�ʱ����
BATS_CANCEL		= 2			-- ��Buff�����ʱ����
BATS_INTERVAL	= 3			-- �������

-- Buffֵ�ı䷽ʽ
BAM_POT 		= 0			-- �ı�ֵ
BAM_PRECENT		= 1			-- �ı�ٷֱ�

-- ɾ����ʽ
BDT_NULL		= 0x00000000		-- ��ͨ�ĵ���ɾ��/������/����ɾ��
BDT_ATTACKED	= 0x00000001		-- ��������ʧ
BDT_DAMAGED		= 0x00000002		-- �ܵ��˺���ʧ
BDT_DEAD		= 0x00000004		-- ������ʧ

-- ���淽ʽ
BST_NULL			= 1				-- ������
BST_SAVE_WITH_TIME	= 2				-- ���棬����¼����ʱ��
BST_SAVE_NO_TIME	= 3				-- ���棬����¼����ʱ��


--��¼��������
REWARD_TOTAL = 1  --�ۼƵ�¼����
REWARD_CONTIN = 2  --������¼����
REWARD_CHENJIU = 3  --�ɾͽ���
REWARD_OFFLINE = 4  --���߽���
REWARD_BUCHANG = 5  --��������
REWARD_CHONGZHI = 6  --��ֵ����

--�������Ͷ���
ITEM_T_MEDICINE_HP		= 7		--// ����ҩ
ITEM_T_MEDICINE_MP		= 8		--// ����ҩ
ITEM_T_MEDICINE_TP		= 9		--// ����ҩ
ITEM_T_NORMAL			= 10	--// ��ͨ����
ITEM_T_JEWEL			= 11	--// ��ʯ����
ITEM_T_CHANGE			= 12	--// �ɱ����
ITEM_T_METRAIL			= 13	--// ���ϵ���
ITEM_T_TOOL				= 14	--// ���ߵ���
ITEM_T_BOOK				= 15	--// �鼮����
ITEM_T_TASK				= 16	---// �������
ITEM_T_RECYCLE			= 17	--// ��ʱ���յ���
ITEM_T_FIGHT_PET		= 18	--// ���͵���
ITEM_T_PRESENT          = 19	--// �������
ITEM_T_SUIT_SCROLL		= 20	--// ��װ����
ITEM_T_EQUIPMENT_BEGIN	= 101	--// װ������ߣ���EQUIP_TYPE��Ӧ��
ITEM_T_EQUIPMENT_END	= 114	 --


--// װ��λ�ö���
EQUIP_P_WEAPON 				= 	0					--// ����
EQUIP_P_SHOSE 				= 	1					--// Ь��
EQUIP_P_PAT 				= 	2						--// ����
EQUIP_P_WAIST 				= 	3					--// ����
EQUIP_P_WRIST 				= 	4					--	// ����
EQUIP_P_CLOTH 				= 	5					--	// �·�
EQUIP_P_HAT 				= 	6						--// ͷ��װ��
EQUIP_P_MANTLE 				= 	7					--	// ����
EQUIP_P_PENDANTS1 			= 	8				--	// ����1
EQUIP_P_PENDANTS2 			= 	9				--	// ����2
EQUIP_P_PROTECTION 			= 	10				--// ����
EQUIP_P_RING1 				= 	11					--	// ��ָ1
EQUIP_P_RING2 				= 	12					--	// ��ָ2
EQUIP_P_PRECIOUS 			= 	13				--	// ����2
EQUIP_P_SHIZHUANG_HAT1 	 	= 	14			--	//  ����3
EQUIP_P_SHIZHUANG_CLOTH1 	= 	15		--// ʱװ�·�1
EQUIP_P_MAX 			 	= 	16					--// Max


--// ���/����װ�����Ͷ���
EQUIP_T_WEAPON				= 		101			--// ����1
EQUIP_T_HAT					= 		102				--// ͷ��
EQUIP_T_WRIST				= 		103				--// ����
EQUIP_T_PAT					= 		104				--// ����
EQUIP_T_WAIST				= 		105				--// ����
EQUIP_T_SHOSE				= 		106				--// Ь��
EQUIP_T_CLOTH				= 		107				--// �·�
EQUIP_T_MANTLE				= 		108				--// ����1 ����
EQUIP_T_PENDANTS			= 		109			--//  ����2 ����
EQUIP_T_PROTECTION			= 		110			--// ����
EQUIP_T_RING				= 		111				--// ��ָ
EQUIP_T_PRECIOUS			= 		112			--// ����2
EQUIP_T_SHIZHUANG_HAT		= 		113		--// ����3
EQUIP_T_SHIZHUANG_CLOTH		= 		114	--// ʱװ���·��� t����

--����Ʒ�ʶ���
--��ͭ������ɫ�������������ɫ������������ɫ�����ƽ𣨽�ɫ�������𣨺ڽ�ɫ�����׽�����ɫ����ī�񣨺���ɫ������������ɫ�������񣨺�ɫ��������
QUALITY_DYELLOW = 1  	--��ͭ������ɫ��
QUALITY_DGRAY = 2 		--���������ɫ��
QUALITY_SILVER = 3 		--��������ɫ��
QUALITY_GOLD = 4 		--�ƽ𣨽�ɫ��
QUALITY_BLMETAL = 5 	--���𣨺ڽ�ɫ��
QUALITY_BGOLD = 6  		--�׽�����ɫ��
QUALITY_BLGREEN = 7 	--ī�񣨺���ɫ��
QUALITY_LGREEN = 8 		--��������ɫ��
QUALITY_RED = 9 		--���񣨺�ɫ��
QUALITY_TREASURE = 10 	--����




--// װ�����Զ���
EEA_MAXHP			= 	0		--// ��������
EEA_MAXMP			= 	1		--// ��������
EEA_GONGJI			= 	2		--// ����
EEA_FANGYU			= 	3		--// ����
EEA_HIT             =   4       --//����
EEA_SHANBI          =   5       --// ����
EEA_BAOJI			= 	6		--// ����
EEA_UNCRIT          =   7       -- //����
EEA_WRECK           =   8       --//�ƻ�
EEA_UNWRECK         =   9       -- //����
EEA_PUNCTURE        =   10      --//����
EEA_UNPUNCTURE      =   11      --//����

-- EEA_SPEED			= 	7		--// �ƶ��ٶ�
-- EEA_ATKSPEED		= 	8		--// �����ٶ�
-- EEA_REDUCEDAMAGE	= 	9		--// �˺�����--// ����ӵ�����
-- EEA_ABSDAMAGE		= 	10		--// �����˺�
-- EEA_NONFANGYU		= 	11		--// ���ӷ���
-- EEA_MULTIBAOJI		= 	12		--// ��������
-- EEA_ICE_DAMAGE		= 	13		--// ���˺�
-- EEA_ICE_DEFENCE		= 	14		--// ������
-- EEA_FIRE_DAMAGE		= 	15		--// ���˺�
-- EEA_FIRE_DEFENCE	= 	16		--// ����
-- EEA_XUAN_DAMAGE		= 	17		--// ���˺�
-- EEA_XUAN_DEFENCE	= 	18		--// ������
-- EEA_POISON_DAMAGE	= 	19		--// ���˺�
-- EEA_POISON_DEFENCE	= 	20		--// ������
EEA_MAX             = 	21     --

--�ؿ�ʤ������
SPECIFIC_MONSTERDIE		=	1      --ָ��ID��������
All_MONSTERDIE			=	2 	   --���й�������
SPECIFIC_MONSTERDIENUM    =   3      --������������
SPECIFIC_OBJDESTPOINT	=	4   --���󵽴�֪�����򣬵ص� 
SPECIFIC_ITEMNUM    =   5      --�õ�ָ����������

--�ؿ�����
SCENE_COMMON = 1     		--��ͨͨ��
SCENE_SD = 2 				--ɨ��ͨ��

--�ؿ�����ˢ������
REFRSHTYPE_MONSTERDIR = 1   --����������ˢ��
REFRSHTYPE_TIMEREACH = 2   --����ָ��ʱ���ˢ��ˢ��
REFRSHTYPE_REGION = 3   --��ҵ���ָ����Χ��ˢ��
REFRSHTYPE_GROUP = 4   --������ˢ��
REFRSHTYPE_REGIONRANDOM = 5   --���ˢ�¹���
REFRSHTYPE_REGIONCOMMON = 6   --��ͨˢ�¹���


--��������
OBJECT_PLAYER 		= 0  --��� 
OBJECT_NPC 			= 1  --NPC 
OBJECT_MONSTER  	= 2  --���� 
OBJECT_ITEM 		= 3  --���� 
OBJECT_PET 		 	= 4  --����ս������ 
OBJECT_SIGLEITEM    = 5  --����ĵ���

--����ؿ�ʧ��
SCENE_ENTER_SP 			= 2 --��������
SCENE_ENTER_TIME 		= 3 --��������
SCENE_ENTER_MONEY 		= 4 --��Ǯ����


--ɨ��״̬����
SCENE_SD_ISSTART 	 = 1  --���Կ�ʼɨ�����ߴ���
SCENE_SD_ISSDNOW 	 = 2  --�������ɨ��������
SCENE_SD_ISWAITAWARD = 3  --�ȴ������ȡɨ������
SCENE_PB_SENDAWARD 	 = 4  --���������ͨ���ؽ���
SCENE_PB_RECVAWARD 	 = 5  --����Ѿ���ȡ��ͨ���ؽ���


--����״̬����
EA_STAND = 0
EA_WALK= 1
EA_RUN= 2
EA_JUMP = 3
EA_ZAZEN = 4
EA_ATTACK = 5	
EA_WOUND = 6
EA_DEAD = 7
EA_SKILL_ATTACK = 8		-- �������磺���߼�ʹ�õĹ���״̬
EA_USEITEM = 9				-- ������һ����������Ʒ����
EA_COLLECT = 10				-- �ɼ�
EA_DIZZY = 11						--ѣ��
EA_MAX = 12	


--����ս������ GetObjectFightData
FIGHTOBJ_LEVEL	 = 0 --�ȼ�
FIGHTOBJ_CURHP	 = 1 --��ǰ����
FIGHTOBJ_GONHJI	 = 2 --������
FIGHTOBJ_FANGYU	 = 3 --����ֵ
FIGHTOBJ_HIT	 = 4 --����
FIGHTOBJ_SHANBI	 = 5 --����
FIGHTOBJ_BAOJI	 = 6 --����
FIGHTOBJ_UNCRIT = 7  --����
FIGHTOBJ_WRECK = 8	--�ƻ�
FIGHTOBJ_UNWRECK = 9 --����
FIGHTOBJ_PUNCTURE = 10 --����
FIGHTOBJ_UNPUNCTURE = 11 --����

--�������� GetObjectData
OBJDATA_GONHJI	 = 0 --������
OBJDATA_FANGYU	 = 1 --����
OBJDATA_BAOJI	 = 2 --����
OBJDATA_LEVEL	 = 10 --�ȼ�
OBJDATA_MAXHP	 = 4 --�������
OBJDATA_MAXMP    = 16 --�������ֵ
OBJDATA_MAXTP    = 17 --�������ֵ
OBJDATA_CURHP    = 18 --��ǰ����ֵ
OBJDATA_CURMP    = 19 --��ǰ����ֵ
OBJDATA_CURTP    = 20 --��ǰ����ֵ
OBJDATA_ID	 = 23  --����ID
OBJDATA_SP   = 21  --�������


-- ��ȡ����״̬ö��(GetMonsterData��������)
GMon_LEVEL          = 1     -- ����ȼ�
GMon_ID             = 2     -- ����Monsterģ��ID
GMon_NAME           = 3     -- ����Name
GMon_EXP            = 4     -- ���ﾭ��
GMon_LevelType      = 5     -- �������ͣ���ͨ&��Ӣ&BOSS��
GMon_CURHP          = 6     -- ���ﵱǰѪ��
GMon_MaxHP          = 7     -- �������Ѫ��
GMon_AttType        = 8     -- ���﹥������
GMon_LastEnemyID    = 9     -- ˭��������
GMon_GroupID        = 10    -- ���������ID
GMon_PartolRadius   = 11    -- ��ذ뾶
GMon_TailLength     = 12    -- ׷���뾶
GMon_NodeCount      = 13    -- ·���ܸ���
GMon_CurNode        = 14    -- ��ǰ·�����
GMon_MoveType       = 15    -- �ƶ�����
GMon_Move2Att       = 16    -- �Ƿ��ƶ�ȥ����
GMon_CurrAction     = 17    -- ��ǰ�ƶ���Ϊվ�������� ��������
GMon_HPcent         = 18    -- ��ǰ�����ٷֱ�
GMon_BackProtect    = 19    -- ���ڷ��ر���
GMon_BornTime       = 20    -- ���������ڵ�ʱ��
GMon_POSTION        = 21    -- ����float XY
GMon_AIID           = 22    -- ����AI����id

--���ܹ���ʱ���͵Ĺ�������
Hit = 0				-- ����
Not_Hit = 1			--δ����
BAOJI_HIT	=	2				--����
UNCRIT_HIT	=	3				--����
WRECK_HIT	=	4			--�ƻ�
UNWRECK_HIT =	5			--����
PUNCTURE_HIT=	6		--����
UNPUNCTURE_HIT= 7	 --����


--��������
TASK_EINTENSIFY = 0  --װ��ǿ��
TASK_EJDING = 1 -- //װ������
TASK_ERISE = 2 -- //װ������
TASK_EKEYIN = 3  --//װ����ӡ
TASK_EQUALITY = 4 -- //װ������
TASK_XINYANG = 5 --//��������
TASK_TRANSFORMERS = 6--//��������
TASK_SKILL = 7 --//�������� ��������
TASK_SCENE = 8 --//�ؿ���ɴ���


--������������
REGION_COMMON = 1 --��ͨ����
REGION_DYREGION = 2 --��̬����
REGION_DYSCENE = 3 --�ؿ�����
REGION_DYARENA = 4 --����������


--ս��״̬

FS_NONE         = 0              -- // ��    
FS_DIZZY        = 1      -- // ѣ��
FS_LIMIT_SKILL  = 2      -- // ����
FS_HYPNOTISM    = 4     -- // ����
FS_DINGSHENG    = 8       --// ����
FS_WUDI = 16     --// �޵�
FS_ADDBUFF = 32       -- // �޷������κ�BUFF
FS_JITUI = 64      --// ������
