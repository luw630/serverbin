--[[
file:	ChargeSsumConfig.lua
author:	lpd
update:	2015-11-04
desc:�ۼƳ�ֵ�����
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

ChargeSumConfig =   --��ֵ�ۼƽ���
{
	isResetEveryDay=1, ---=1ÿ����������,=2������
	[1] = {
			miniCharge=6, --��ֵ�ܶ����
			reward={--�����б�
					[1]={GoodsType.item, 20020, 5 },
					[2]={GoodsType.item, 20001, 5 },
					[3]={GoodsType.item, 20007, 5 },
					[4]={GoodsType.item, 20018, 1 },
					},
		  },
	[2] = {
			miniCharge=30, --��ֵ�ܶ����
			reward={--�����б�
					[1]={GoodsType.item, 20020, 20 },
					[2]={GoodsType.item, 20001, 10 },
					[3]={GoodsType.item, 20007, 10 },
					[4]={GoodsType.item, 20018, 2 },
					},
		  },
	[3] = {
			miniCharge=98, --����
			reward={--�����б�
					[1]={GoodsType.item, 20020, 50 },
					[2]={GoodsType.item, 20001, 20 },
					[3]={GoodsType.item, 20007, 20 },
					[4]={GoodsType.item, 20018, 4 },
					},
		  },		

}