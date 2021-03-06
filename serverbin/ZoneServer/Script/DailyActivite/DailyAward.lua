--（1对应第奖励材料道具，2对应第奖励真气，3对应第奖励经验，4对应第奖励银币，5对应第奖励金币, 6对应第不区分奖励类型）
DailyAwardType = {1, 2, 3, 4, 5, 6}

--奖励列表信息
DailyAwardList = 
{
    [1] = --1日常活动的ID，圣魔炼狱20
    {
        --材料道具ID，奖励道具的数量， 奖励真气，奖励经验， 奖励银币，奖励金币
        {6, 0, 0 , 0, 100, 0, 0},   --活动失败初始奖励
        {6, 0, 0 , 0, 200, 0, 0},   --对应第1波奖励
        {6, 0, 0 , 0, 300, 0, 0},   --对应第2波奖励
        {6, 0, 0 , 0, 400, 0, 0},   --对应第3波奖励
        {6, 0, 0 , 0, 500, 0, 0},   --对应第4波奖励
    },
	[2] = --1日常活动的ID，丧尸围城20
    {
        --材料道具ID，奖励道具的数量， 奖励真气，奖励经验， 奖励银币，奖励金币
        {6, 0, 0 , 0, 100, 0, 0},   --活动失败初始奖励
        {6, 0, 0 , 0, 200, 0, 0},   --对应第1波奖励
        {6, 0, 0 , 0, 300, 0, 0},   --对应第2波奖励
        {6, 0, 0 , 0, 400, 0, 0},   --对应第3波奖励
        {6, 0, 0 , 0, 500, 0, 0},   --对应第4波奖励
		{6, 0, 0 , 0, 600, 0, 0},   --对应第5波奖励
    },
	[3] = --1日常活动的ID，世界之树20
    {
        --材料道具ID，奖励道具的数量， 奖励真气，奖励经验， 奖励银币，奖励金币
        {6, 0, 0 , 0, 0, 1000, 0},   --基础奖励
    },
    [4] = --活动的ID，失乐园30级
    {
        --材料道具ID，奖励道具的数量， 奖励真气，奖励经验， 奖励银币，奖励金币
        {6, 0, 0 , 1000, 0, 0, 0},   --基础奖励
    },
	[5] = --未知神殿奖40
	{
    --材料道具ID，奖励道具的数量， 奖励真气，奖励经验， 奖励银币，奖励金币
        {6, 0, 0, 50, 0, 50, 0},   --对应奖励
	},
	[6] =  --神泉山奖励(奖励按杀怪随机掉落道具，死亡和胜利最后结算)50
    {
        --材料道具ID，奖励道具的基本数量， 奖励真气，奖励经验， 奖励银币，奖励金币
        {6, 910023, 1, 0, 0, 0, 0},   --对应奖励
    },
    [7] =  --荣誉殿堂60
    {
        --材料道具ID，奖励道具的基本数量， 奖励真气，奖励经验， 奖励银币，奖励金币
        {6, 0, 0, 0, 0, 0, 0},   --对应奖励
    },
    [8] = --1日常活动的ID，财富山60
    {
        --材料道具ID，奖励道具的数量， 奖励真气，奖励经验， 奖励银币，奖励金币
        {6, 0, 0, 0, 0, 1000, 0},   --对应奖励
    },
	[9] = --挑战BOSS，60
    {
        --材料道具ID，奖励道具的数量， 奖励真气，奖励经验， 奖励银币，奖励金币
        {6, 0, 0 , 0, 10000, 0, 0},   --活动失败初始奖励
        {6, 0, 0 , 0, 20000, 0, 0},   --对应第1波奖励
        {6, 0, 0 , 0, 30000, 0, 0},   --对应第2波奖励
        {6, 0, 0 , 0, 40000, 0, 0},   --对应第3波奖励
        {6, 0, 0 , 0, 50000, 0, 0},   --对应第4波奖励
    },
	[10] = --炼狱之地，60
    {
        --材料道具ID，奖励道具的数量， 奖励真气，奖励经验， 奖励银币，奖励金币
        {6, 0, 0 , 0, 10000, 0, 0},   --活动失败初始奖励
        {6, 0, 0 , 0, 20000, 0, 0},   --对应第1波奖励
        {6, 0, 0 , 0, 30000, 0, 0},   --对应第2波奖励
        {6, 0, 0 , 0, 40000, 0, 0},   --对应第3波奖励
        {6, 0, 0 , 0, 50000, 0, 0},   --对应第4波奖励
    },
	[11] = --通天之路，60
    {
        --材料道具ID，奖励道具的数量， 奖励真气，奖励经验， 奖励银币，奖励金币
        {6, 0, 0 , 0, 80000, 0, 0},   --活动失败初始奖励
        {6, 0, 0 , 0, 20000, 0, 0},   --对应第1波奖励
        {6, 0, 0 , 0, 30000, 0, 0},   --对应第2波奖励
        {6, 0, 0 , 0, 40000, 0, 0},   --对应第3波奖励
        {6, 0, 0 , 0, 50000, 0, 0},   --对应第4波奖励
    },
	[12] = --神魔牢笼 40
    {
        --材料道具ID，奖励道具的数量， 奖励真气，奖励经验， 奖励银币，奖励金币
        {6, 0, 0 , 0, 100, 0, 0},   --活动失败初始奖励
    },
	[13] = --1日常活动的ID，测试
    {
        --材料道具ID，奖励道具的数量， 奖励真气，奖励经验， 奖励银币，奖励金币
        {6, 0, 0 , 0, 100, 0, 0},   --活动失败初始奖励
        {6, 0, 0 , 0, 200, 0, 0},   --对应第1波奖励
        {6, 0, 0 , 0, 300, 0, 0},   --对应第2波奖励
        {6, 0, 0 , 0, 400, 0, 0},   --对应第3波奖励
        {6, 0, 0 , 0, 500, 0, 0},   --对应第4波奖励
    },
}

--NPC对应商品道具购买信息表
NpcToGoodsTable = 
{
    --参数依次为：NpcID(20051-20070), 商品道具ID，默认一次购买商品的次数
    {20051, 720208, 1},
    {20052, 720208, 1},
    {20053, 720208, 1},
    {20054, 720208, 1},
    {20055, 720208, 1},
}


--世界之树奖励计算
function WorldTreeAwardMethod(AwardTable, Time)  --Time为分钟
    if AwardTable == nil then
        return
    end
    for n, v in pairs(AwardTable) do
        if n ~= 1 then
            AwardTable[n] = AwardTable[n] * (30 - Time)
        end
    end
end

--失乐园奖励计算
function ShiLeYuanAwardMethod(AwardTable, Time)     --Time为秒
    if AwardTable == nil then
        return
    end
    for n, v in pairs(AwardTable) do
        if n ~= 1 then
            AwardTable[n] = AwardTable[n] * Time / 5
        end
    end
end

--普通怪物产出奖励随机类型的道具
GeneralMonsterProductAward = 
{
    [1] = --圣魔炼狱20
    {
        --材料道具ID，奖励道具的数量, 权重
        {720241, 1, 10},
		{720242, 1, 2},
		{nil, 1, 10},
    },
	[2] = --丧尸围城20
    {
        --材料道具ID，奖励道具的数量, 权重
        {720211, 1, 10},
		{720212, 1, 2},
        {nil, 1, 20},
    },
	[3] = --世界之树20
    {
        --材料道具ID，奖励道具的数量, 权重
        {nil, 1, 20},
    },
	[4] = --失乐园30
    {
        --材料道具ID，奖励道具的数量, 权重
        {nil, 1, 20},
    },
	[6] = --神泉山50
    {
        --材料道具ID，奖励道具的数量, 权重
        {910021, 1, 10},
		{910021, 1, 10},
		{910022, 1, 2},
		{nil, 1, 20},
    },
	[12] = --神魔牢笼
    {
        --材料道具ID，奖励道具的数量, 权重
        {nil, 1, 20},
    },
	[13] = --技能测试
    {
        --材料道具ID，奖励道具的数量, 权重
        {nil, 1, 20},
    },
}
BossMonsterProductAward = 
{
    [1] = --圣魔炼狱BOSS20
    {
        --材料道具ID，奖励道具的数量, 权重
        {720231, 1, 5},
    },
	[2] = --丧尸围城BOSS20
    {
        --材料道具ID，奖励道具的数量, 权重
        {910013, 1, 5},
        {nil, 1, 20},
    },
	[3] = --世界之树BOSS20
    {
        --材料道具ID，奖励道具的数量, 权重
        {nil, 1, 20},
    },
	[4] = --失乐园BOSS30
    {
        --材料道具ID，奖励道具的数量, 权重
        {nil, 1, 20},
    },
	[12] = --神魔牢笼
    {
        --材料道具ID，奖励道具的数量, 权重
        {nil, 1, 20},
    },
	[13] = --测试BOSS
    {
        --材料道具ID，奖励道具的数量, 权重
        {nil, 1, 20},
    },
}

--未知神殿奖励配置
UDHRandomAwardCfg = 
{
    --参数依次为：怪物ID，{奖励道具ID，奖励道具的数量，奖励权重}
    [5] = 
    {
        {35401, {{190301, 1, 5},{nil, 1, 25},}},
        {35402, {{190301, 1, 5},{nil, 1, 25},}},
        {35403, {{190301, 1, 5},{nil, 1, 25},}},
        {35404, {{190301, 1, 5},{nil, 1, 25},}},
		{35405, {{190301, 1, 5},{nil, 1, 25},}},
        {35406, {{190301, 1, 5},{nil, 1, 25},}},
        {35407, {{190301, 1, 5},}},
    },

}

--荣誉殿堂道具奖励
HHAwardCfg = 
{
	--{奖励道具ID，奖励道具的数量，奖励权重}
	[7] = {{190656, 1, 5},{190657, 1, 5},{nil, 1, 5},},
}

--财富山指定怪物死亡，产出一定数量（随机大小）的银币
FortuneHillMonsterDieAwardCfg = 
{
    --[活动索引] = {最小数量，最大数量}
    [8] = {1, 100},
}

--挑战信仰主神1-12成功后激活相应主神的技能
XinYangAciiveSkillList = {20001, 20002, 20003, 20004, 20005, 20006, 20007, 20008, 20009, 20010, 20011, 20012}