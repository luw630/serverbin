--[[
file:	expenseConfig.lua
author:	wk
update:	2015-11-04
desc:�����콱�
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

expenseActConfig = { --�����콱���������
	[1]={
		need=300, --��Ҫ���ѽ��
		gain={
		{GoodsType.item, 20014, 1 },
		{GoodsType.item, 90101, 3 },
		},	--�һ���Ʒ
	},
	[2]={
		need=500, --��Ҫ���ѽ��
		gain={
		{GoodsType.item, 20014, 2 },
		{GoodsType.item, 90101, 5 },
		},	--�һ���Ʒ
	},

	
}

