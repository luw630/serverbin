ActivityNotice = {}
ActivityNewS = {}

ActivityNotice[1] =
{
	ActivityReward = {8020001},						--�����
	Activity =
	{
		ActivityName = "�Ͳ���",					--�����(10)
		Activitydescribe = "�û��۶һ�����",				--�����(50)
		ActivityNpcName = "С�����в��񣬴����",						--�NPC����(10)
		ActivityDate = 0,			--�����
		ActivityType = 0,					--�����
		ActivityStartTime = 0,				--���ʼʱ��
		ActivityEntryRegin = 150,				--���ڳ���id
		ActivityEntryCoordX = 797,			--��������
		ActivityEntryCoordY = 1024,
	}
}

ActivityNotice[2] =
{
	ActivityReward = {8024001},						--�����
	Activity =
	{
		ActivityName = "����Ȱ��",					--�����(10)
		Activitydescribe = "�þƶһ�����",				--�����(50)
		ActivityNpcName = "�ƹ����ɣ�����",						--�NPC����(10)
		ActivityDate = 0,			--�����
		ActivityType = 0,					--�����
		ActivityStartTime = 0,				--���ʼʱ��
		ActivityEntryRegin = 2,				--���ڳ���id
		ActivityEntryCoordX = 790,			--��������
		ActivityEntryCoordY = 974,
	}
}

ActivityNotice[3] =
{
	ActivityReward = {},						--�����
	Activity =
	{
		ActivityName = "��»��",					--�����(10)
		Activitydescribe = "ÿ����븣Ե���м��ʻ�ü�Ʒ����",				--�����(50)
		ActivityNpcName = "��»��",						--�NPC����(10)
		ActivityDate = 0,			--�����
		ActivityType = 0,					--�����
		ActivityStartTime = 0,				--���ʼʱ��
		ActivityEntryRegin = 2,				--���ڳ���id
		ActivityEntryCoordX = 895,			--��������
		ActivityEntryCoordY = 785,
	}
}

ActivityNotice[4] =
{
	ActivityReward = {},						--�����
	Activity =
	{
		ActivityName = "��������",					--�����(10)
		Activitydescribe = "ÿ�����������ɱ�ֻ�ȡ��������",				--�����(50)
		ActivityNpcName = "����",						--�NPC����(10)
		ActivityDate = 0,			--�����
		ActivityType = 0,					--�����
		ActivityStartTime = 0,				--���ʼʱ��
		ActivityEntryRegin = 2,				--���ڳ���id
		ActivityEntryCoordX = 895,			--��������
		ActivityEntryCoordY = 785,
	}
}


ActivityNotice[5] =
{
	ActivityReward = {},						--�����
	Activity =
	{
		ActivityName = "�����ͽ",					--�����(10)
		Activitydescribe = "ÿ������8���Ժ��޼���ɱ�ֿɻ��˫������",				--�����(50)
		ActivityNpcName = "",						--�NPC����(10)
		ActivityDate = 0,			--�����
		ActivityType = 0,					--�����
		ActivityStartTime = 0,				--���ʼʱ��
		ActivityEntryRegin = 3,				--���ڳ���id
		ActivityEntryCoordX = 271,			--��������
		ActivityEntryCoordY = 1400,
	}
}


ActivityNewS[1] =
{
	NewSIndex = 1,
	NewSDescribe = "��������",	--��������(50)
}


function LoadActivityNotice()
	for k, v in pairs(ActivityNotice) do
	--rfalse(v.ActivityName)
	setactivityNotice(v.Activity,v.ActivityReward[1],v.ActivityReward[2])
	end
end

--sreset







