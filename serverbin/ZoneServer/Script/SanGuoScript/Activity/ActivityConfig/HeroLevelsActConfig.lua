--[[
file:	HeroLevelsActConfig.lua
author:	Jonson
update:	2015-11-5
desc:	������Ӣ�������Ļ
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

--�佫�ĵȼ��Ľ����������
HeroLevelsActConfig = 
{
	[1] = {
			count = 15, --��ȡ��������Ҫʹĳһ���佫�ﵽ�ĵȼ�
			reward = {--�����б�
					[1]={GoodsType.item, 20013, 1 },
					[2]={GoodsType.item, 20001, 5 },
					},
		  },
	[2] = {
			count = 20, --��ȡ��������Ҫʹĳһ���佫�ﵽ�ĵȼ�
			reward = {--�����б�
					[1]={GoodsType.item, 20013, 2 },
					[2]={GoodsType.item, 20001, 10 },
					},
		  },
	[3] = {
			count = 30, --��ȡ��������Ҫʹĳһ���佫�ﵽ�ĵȼ�
			reward = {--�����б�
					[1]={GoodsType.item, 20013, 3 },
					[2]={GoodsType.item, 20001, 15 },
					},
		  },
}