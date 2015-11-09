--[[
file:	PassingLevelActConfig.lua
author:	Jonson
update:	2015-11-5
desc:	������ͨ�ظ����ؿ����������ӵĻ
]]--

--[[
------------------------------------------------------------------------
	GoodsType.money--ͭǮ
	GoodsType.diamond--��ʯ
	GoodsType.honor--����
	GoodsType.exploit--����
	GoodsType.endurance--����
	GoodsType.item --���߻���װ��
	GoodsType.hero --Ӣ��
}
------------------------------------------------------------------------
]]--

--����ͨ�ش��������������
PassingLevelActConfig = 
{
	[1] = {
			count = 20, --��ȡ��������Ҫͨ�صĴ���
			reward = {--�����б�
					[1]={GoodsType.diamond, 0, 2 },
					[2]={GoodsType.money, 0, 5000 },
					[3]={GoodsType.item, 20013, 5 },
					},
		  },
	[2] = {
			count = 50, --��ȡ��������Ҫͨ�صĴ���
			reward = {--�����б�
					[1]={GoodsType.diamond, 0, 5 },
					[2]={GoodsType.money, 0, 10000 },
					[3]={GoodsType.item, 20014, 1 },
					},
		  },
	[3] = {
			count = 100, --��ȡ��������Ҫͨ�صĴ���
			reward = {--�����б�
					[1]={GoodsType.diamond, 0, 10 },
					[2]={GoodsType.money, 0, 20000 },
					[3]={GoodsType.item, 20015, 1 },
					},
		  },

		  	  
}