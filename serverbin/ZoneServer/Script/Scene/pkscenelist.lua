PkSceneMapTable = {}
PkSceneMapTable[1]= 				--�½�ID���ؿ�ID
{
	SceneMapID = 1,				--�����½�ID
	MapID 	= 103,				--��̬��ͼ��Դ
	bornPostion = {43.92,32.17},		--��ҳ�����
	relivePostion = {43.92,32.17},	--��Ҹ��������
	relivemoney = 100, 			--��������󻨷ѽ�Ҹ���
	specialrate  = 1,			--���������ؿ����ʣ�rand > specialrate Ϊ����2
	ScenePkType = 1,			--�ؿ�PK���� 0 ����PK 1����PK

	BatchMonster =  			--��������ˢ�µĹ���
	{
		refreshtype = REFRSHTYPE_MONSTERDIR, --��������ˢ��
		[1] = 
		{
			monsterlist = 
			{
				{monsterId = 4, x = 43.92, y = 37.15, refreshTime = 36000000, objectType = 0},	
				{monsterId = 4, x = 43.92, y = 37.15, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--ˢ���ӳ� ��
		},
		[2] = 
		{
			monsterlist = 
			{
				{monsterId = 5, x = 43.92, y = 37.15, refreshTime = 36000000, objectType = 0},	
				{monsterId = 5, x = 43.92, y = 37.15, refreshTime = 36000000, objectType = 0},
			},
			refreshdelaytime = 2, 			--ˢ���ӳ� ��
		},
		[3] = 
		{
			monsterlist = 
			{
				{monsterId = 8, x = 43.92, y = 37.15, refreshTime = 36000000, objectType = 0},	
			},
			refreshdelaytime = 1, 			--ˢ���ӳ� ��
		},
	},
	
	LimitContorl = 
	{
		LimitSP = 1,			--��������
		LimitTimes = 99,			--��������
		SDLimitTimes = 99,		--ɨ����������
		OpenTime = 15,			--����ʱ�����
		SDTime = 1,			--ɨ������ʱ��
		SDItem = 0,		--ɨ���������
		SDcoldMoney = 100,	--��ȴɨ��ʱ�������Ǯ
	},
}