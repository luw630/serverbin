--[[
file:	BlessActivity.lua
author:	lpd
update:	2015-11-03
desc:��������
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

BlessActConfig = { --�����������
	[1] = { 
			blessCount = 20 , --blessCount��������������
			reward = {
			[1] = {GoodsType.item, 90144, 1}, 
			[2] = {GoodsType.money, 0, 20000}, },--�佫���� GoodsType.hero�� �佫ID108  �� �佫����Ϊ1
		  },

	[2] = { 
			blessCount = 30 , --blessCount��������������
			reward = {
			[1] = {GoodsType.item, 90144, 2}, 
			[2] = {GoodsType.money, 0, 40000}, },--�佫���� GoodsType.hero�� �佫ID108  �� �佫����Ϊ1
		  },

	[3] = {
			blessCount = 50 , --blessCount��������������
			reward = {
		    [1] = {GoodsType.item, 90144, 3}, 
			[2] = {GoodsType.money, 0, 80000}, },--�佫���� GoodsType.hero�� �佫ID108  �� �佫����Ϊ1
		  },
}

