--[[
file:	exchangeConfig.lua
author:	wk
update:	2015-11-04
desc:�һ��
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



--�һ������  ÿ����need=��Ҫ��Ʒ,gain=�һ���Ʒ vipTime=�ɶһ�����
exchangeACT_cfg={
	[1]={
		need={{GoodsType.diamond, 0, 100 }}, --��Ҫ��Ʒ
		gain={{GoodsType.item, 90106, 5 },{GoodsType.item, 20001, 2 },{GoodsType.item, 20009, 1 },},	--�һ���Ʒ
		vipTime={1,1,1,2,2,2,3,3,3,4,4,4,5,5,5},--�ɶһ�����,vip 0-15
	},
	[2]={
		need={{GoodsType.money, 0, 50000 }},
		gain={{GoodsType.item, 20002, 1 },{GoodsType.item, 20004, 1 },{GoodsType.item, 20007, 1 },},	
		vipTime={2,2,2,3,3,3,4,4,4,5,5,5,6,6,6},--�ɶһ�����,vip 0-15
	},
	[3]={
		need={{GoodsType.item, 20000, 5 }},
		gain={{GoodsType.item, 20001, 5 },{GoodsType.item, 20002, 5 },},	
		vipTime={3,3,3,4,4,4,5,5,5,6,6,6,7,7,7},--�ɶһ�����,vip 0-15
	},
	[4]={
		need={{GoodsType.item, 20005, 3 },{GoodsType.item, 20006, 3 },},
		gain={{GoodsType.item, 20004, 5 }},	
		vipTime={1,1,1,2,2,2,3,3,3,4,4,4,5,5,5},--�ɶһ�����,vip 0-15
	},
	
	
}