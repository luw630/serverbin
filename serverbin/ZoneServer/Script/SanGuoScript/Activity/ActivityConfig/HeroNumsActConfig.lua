--[[
file:	HeroNumsActConfig.lua
author:	Jonson
update:	2015-11-5
desc:	������Ӣ���������ӵĻ
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

--�佫��ɫ�����Ľ����������
HeroNumsActConfig =   
{
	[1] = {
			count = 3, --��ȡ��������Ҫ������佫������
			reward = {--�����б�
					[1]={GoodsType.item, 20000, 5 },
					[2]={GoodsType.diamond, 0, 5 },

					},
		  },
	[2] = {
			count = 5, --��ȡ��������Ҫ������佫������
			reward = {--�����б�
					[1]={GoodsType.item, 20000, 10 },
					[2]={GoodsType.diamond, 0, 10 },
					},
		  },

}