HighQualityType = 3     --高品质宠物的定义，即：宠物的品质为3时

--卡牌抽取方式配置
CardExtracteConfig = {}

CardExtracteConfig[1] = --免费抽取方式
{
    --抽取的范围
    --产出宠物ID、产出宠物权重
	{201, 5},
    {202, 5},
    {203, 5},
	{205, 5},
	{209, 5},
	{212, 5},
    {nil, 0};
    ExtracteTimes = 1,  --可抽取的次数
    ConsumeJinBi = 0,
    NeedHighQualityNum = 0,   --至少产出高品质宠物个数要求, 不能大于ExtracteTimes
}

CardExtracteConfig[2] = --付费抽取一次方式
{
    --抽取的范围
    --产出宠物ID、产出宠物权重
    {303, 5},
    {401, 5},
    {403, 5},
    {nil, 0};
    ExtracteTimes = 1,     --可抽取的次数
    ConsumeJinBi = 10,
    NeedHighQualityNum = 0,   --至少产出高品质宠物个数要求, 不能大于ExtracteTimes
}

CardExtracteConfig[3] = --付费抽取十次方式
{
    --抽取的范围
    --产出宠物ID、产出宠物权重
    {401, 5},
    {403, 5},
    {nil, 0};
    ExtracteTimes = 10,     --可抽取的次数
    ConsumeJinBi = 2000,
    NeedHighQualityNum = 1,   --至少产出高品质宠物个数要求, 不能大于ExtracteTimes
}

CardExtracteConfig[4] = --带赌博性质的产出高品质宠物
{
    --抽取的范围
    --产出宠物ID、产出宠物权重、如果第一个参数为nil时第三个参数表示奖励的经验
    {505, 1},
    {515, 1},
    {517, 1},
    {nil, 9999, 20};
    ExtracteTimes = 1,     --可抽取的次数
    ConsumeJinBi = 10,
    NeedHighQualityNum = 0,   --至少产出高品质宠物个数要求, 不能大于ExtracteTimes
}

--特殊高品质抽取范围，不同于前面四种
ProduceHighQuality = --产出高品质的宠物配置，不能配置带nil的字段
{
    --抽取的范围
    --产出宠物ID、产出宠物权重
    {505, 5},
	{515, 5},
	{517, 5},
}


--碎片方式合成配置
ChipComposeConfig = 
{
    --产生依次为：宠物ID、碎片1、碎片1需要数量、碎片2、碎片3需要数量、碎片3、碎片3需要数量...
    {505, 190500, 10, 190501, 20, 0, 0},
    {515, 190500, 10, 190501, 20, 190502, 30},
    {517, 190500, 10, 190501, 20, 190502, 30},
}

--使用道具方式配置
UseItemConfig = 
{
    --参数依次为：宠物ID、道具ID
    {213, 9100201},
    {214, 9100202},
    {505, 9100203},
	{515, 9100204},
    {517, 9100205},
}

--直接购买宠物
DirectBuyPetCfg = {
    --宠物ID、金币价格
	{505, 1},
    {515, 1},
    {517, 1},
}