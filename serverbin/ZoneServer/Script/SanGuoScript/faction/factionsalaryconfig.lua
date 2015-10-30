--军团俸禄配置
FactionSalaryGetCount = 1   --军团俸禄领取次数
FactionSalaryConfig = {}
FactionSalaryConfig[1] =  --免费领取
{
	itemlist = 
	{
		GoodsType.money,0,30000,
		GoodsType.item,20000,10,
		GoodsType.item,20007,5,
		GoodsType.token,0,30,
	},
	ActivityValue = 30,    --活跃度
	FactionExp = 50,      --经验
	CostGold = 0,			--免费的这里花费为0
}

FactionSalaryConfig[2] =  --收费领取
{
	itemlist = 
	{
		GoodsType.money,0,80000,
		GoodsType.item,20001,10,
		GoodsType.item,20008,5,
		GoodsType.token,0,150,
	},
	ActivityValue = 150,    --活跃度
	FactionExp = 150,      --经验
	CostGold = 50,			--收费的这里设置
}