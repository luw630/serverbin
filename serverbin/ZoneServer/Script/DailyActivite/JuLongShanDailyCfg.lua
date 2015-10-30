
--玩家巨龙山重置时间
JuLongShanResetTime = 2 * 60 * 60

--一次冒险使用巨龙令信息
UseJuLongLingCfg = 
{
    --【探险次数】= 参数依次为巨龙令ID，一次需要的巨龙令数量
    [1] = {720202, 1},
    [2] = {720202, 1},
    [3] = {720202, 1},
}

--剧情对话配置
PlotDialogueCfg = 
{
    [1] = "你获得了武器，手套1阶升2阶主材料",
    [2] = "你获得了头饰，护肩，衣服，裤子1阶升2阶主材料",
    [3] = "你获得了武器，手套1阶升2阶辅助材料",
    [4] = "你获得了头饰，护肩，衣服，裤子1阶升2阶辅助材料",
	[5] = "你获得了武器，手套2阶升3阶主材料",
    [6] = "你获得了头饰，护肩，衣服，裤子2阶升3阶主材料",
    [7] = "你获得了武器，手套2阶升3阶辅助材料",
    [8] = "你获得了头饰，护肩，衣服，裤子2阶升3阶辅助材料",
	[9] = "你获得了武器，手套3阶升4阶主材料",
    [10] = "你获得了头饰，护肩，衣服，裤子3阶升4阶主材料",
    [11] = "你获得了武器，手套3阶升4阶辅助材料",
    [12] = "你获得了头饰，护肩，衣服，裤子3阶升4阶辅助材料",
	[13] = "你获得了武器，手套4阶升5阶主材料",
    [14] = "你获得了头饰，护肩，衣服，裤子4阶升5阶主材料",
    [15] = "你获得了武器，手套4阶升5阶辅助材料",
    [16] = "你获得了头饰，护肩，衣服，裤子4阶升5阶辅助材料",
	[17] = "你获得了武器，手套5阶升6阶主材料",
    [18] = "你获得了头饰，护肩，衣服，裤子5阶升6阶主材料",
    [19] = "你获得了武器，手套5阶升6阶辅助材料",
    [20] = "你获得了头饰，护肩，衣服，裤子5阶升6阶辅助材料",
	[21] = "你获得了武器，手套6阶升7阶主材料",
    [22] = "你获得了头饰，护肩，衣服，裤子6阶升7阶主材料",
    [23] = "你获得了武器，手套6阶升7阶辅助材料",
    [24] = "你获得了头饰，护肩，衣服，裤子6阶升7阶辅助材料",
	[25] = "你获得了武器，手套7阶升8阶主材料",
    [26] = "你获得了头饰，护肩，衣服，裤子7阶升8阶主材料",
    [27] = "你获得了武器，手套7阶升8阶辅助材料",
    [28] = "你获得了头饰，护肩，衣服，裤子7阶升8阶辅助材料",
	[29] = "你获得了武器，手套8阶升9阶主材料",
    [30] = "你获得了头饰，护肩，衣服，裤子8阶升9阶主材料",
    [31] = "你获得了武器，手套8阶升9阶辅助材料",
    [32] = "你获得了头饰，护肩，衣服，裤子8阶升9阶辅助材料",
    [33] = "这点经验还不够升级，多给点经验试试",
	[34] = "财源滚滚进",
    [35] = "信仰之神赐予无尽的信仰之力吧",
	[36] = "好运在下一次，加油",
	[37] = "你打开了经验宝库，获得大量经验",
}

--每天消耗小于10个巨龙令，随机产出的物品配置信息
JuLongShanLT10Cfg = {
    --参数依次为：奖励类型（为1表示奖励道具，为2表示奖励经验，为3奖励银币，为4奖励信仰之力，为5表示不给于任何奖励），剧情对话ID，权重，奖励材料（如果为道具则为道具ID，其它为0），奖励的数量，材料类型（0为普通，1为6级以上装备材料或特殊大经验奖励）
    {1, 1, 20, 190101, 1, 0},
	{1, 2, 20, 190102, 1, 0},
	{1, 3, 20, 190103, 1, 0},
	{1, 4, 20, 190104, 1, 0},
	{1, 5, 10, 190111, 1, 0},
	{1, 6, 10, 190112, 1, 0},
	{1, 7, 10, 190113, 1, 0},
	{1, 8, 10, 190114, 1, 0},
	{1, 9, 5, 190121, 1, 0},
	{1, 10, 5, 190122, 1, 0},
	{1, 11, 5, 190123, 1, 0},
	{1, 12, 5, 190124, 1, 0},
	{1, 13, 5, 190131, 1, 0},
	{1, 14, 5, 190132, 1, 0},
	{1, 15, 5, 190133, 1, 0},
	{1, 16, 5, 190134, 1, 0},
	{1, 17, 5, 190141, 1, 0},
	{1, 18, 5, 190142, 1, 0},
	{1, 19, 5, 190143, 1, 0},
	{1, 20, 5, 190144, 1, 0},
    {2, 33, 30, 0, 1000, 0},
    {3, 34, 30, 0, 5000, 0},
    {4, 35, 30, 0, 500, 0},
    {5, 36, 50, 0, 0, 0},
}

--每天消耗等于10个巨龙令，随机产出的物品配置信息
JuLongShanE10Cfg = {
    --参数依次为：奖励类型（为1表示奖励道具，为2表示奖励经验，为3奖励银币，为4奖励信仰之力，为5表示不给于任何奖励），剧情对话ID，权重，奖励材料（如果为道具则为道具ID，其它为0），奖励的数量，材料类型（0为普通，1为6级以上装备材料或特殊大经验奖励）
	{2, 37, 20, 0, 10000, 0},
	{2, 37, 20, 0, 12000, 0},
	{2, 37, 20, 0, 15000, 0},
}

--每天消耗大于等于11，小于15个巨龙令，随机产出的物品配置信息
JuLongShanLT15AndGE11Cfg = {
    --参数依次为：奖励类型（为1表示奖励道具，为2表示奖励经验，为3奖励银币，为4奖励信仰之力，为5表示不给于任何奖励），剧情对话ID，权重，奖励材料（如果为道具则为道具ID，其它为0），奖励的数量，材料类型（0为普通，1为6级以上装备材料或特殊大经验奖励）
    {1, 5, 20, 190111, 1, 0},
	{1, 6, 20, 190112, 1, 0},
	{1, 7, 20, 190113, 1, 0},
	{1, 8, 20, 190114, 1, 0},
	{1, 9, 10, 190121, 1, 0},
	{1, 10, 10, 190122, 1, 0},
	{1, 11, 10, 190123, 1, 0},
	{1, 12, 10, 190124, 1, 0},
	{1, 21, 5, 190151, 1, 0},
	{1, 22, 5, 190152, 1, 0},
	{1, 23, 5, 190153, 1, 0},
	{1, 24, 5, 190154, 1, 0},
	{1, 25, 5, 190161, 1, 0},
	{1, 26, 5, 190162, 1, 0},
	{1, 27, 5, 190163, 1, 0},
	{1, 28, 5, 190164, 1, 0},	
    {2, 33, 20, 0, 3000, 0},
    {3, 34, 20, 0, 10000, 0},
    {4, 35, 20, 0, 2000, 0},
	{5, 36, 40, 0, 0, 0},
}

--每天消耗等于15个巨龙令，随机产出的物品配置信息
JuLongShanE15Cfg = {
    --参数依次为：奖励类型（为1表示奖励道具，为2表示奖励经验，为3奖励银币，为4奖励信仰之力，为5表示不给于任何奖励），剧情对话ID，权重，奖励材料（如果为道具则为道具ID，其它为0），奖励的数量，材料类型（0为普通，1为6级以上装备材料或特殊大经验奖励）
    {1, 21, 5, 190151, 1, 0},
	{1, 22, 5, 190152, 1, 0},
	{1, 23, 5, 190153, 1, 0},
	{1, 24, 5, 190154, 1, 0},
}

--每天消耗大于等16, 小于20个巨龙令，随机产出的物品配置信息
JuLongShanLT20AndGE16Cfg = {
    --参数依次为：奖励类型（为1表示奖励道具，为2表示奖励经验，为3奖励银币，为4奖励信仰之力，为5表示不给于任何奖励），剧情对话ID，权重，奖励材料（如果为道具则为道具ID，其它为0），奖励的数量，材料类型（0为普通，1为6级以上装备材料或特殊大经验奖励）
    {1, 13, 10, 190131, 1, 0},
	{1, 14, 10, 190132, 1, 0},
	{1, 15, 10, 190133, 1, 0},
	{1, 16, 10, 190134, 1, 0},
	{1, 17, 10, 190141, 1, 0},
	{1, 18, 10, 190142, 1, 0},
	{1, 19, 10, 190143, 1, 0},
	{1, 20, 10, 190144, 1, 0},
	{1, 29, 5, 190171, 1, 0},
	{1, 30, 5, 190172, 1, 0},
	{1, 31, 5, 190173, 1, 0},
	{1, 32, 5, 190174, 1, 0},
    {2, 33, 20, 0, 5000, 0},
    {3, 34, 20, 0, 20000, 0},
    {4, 35, 20, 0, 4000, 0},
	{5, 36, 30, 0, 0, 0},
}

--每天消耗大于等于20个巨龙令，随机产出的物品配置信息
JuLongE20Cfg = {
    --参数依次为：奖励类型（为1表示奖励道具，为2表示奖励经验，为3奖励银币，为4奖励信仰之力，为5表示不给于任何奖励），剧情对话ID，权重，奖励材料（如果为道具则为道具ID，其它为0），奖励的数量，材料类型（0为普通，1为6级以上装备材料或特殊大经验奖励）
    {1, 29, 5, 190171, 1, 0},
	{1, 30, 5, 190172, 1, 0},
	{1, 31, 5, 190173, 1, 0},
	{1, 32, 5, 190174, 1, 0},
}

--每天消耗大于20个巨龙令，随机产出的物品配置信息
JuLongShanGT20Cfg = {
    --参数依次为：奖励类型（为1表示奖励道具，为2表示奖励经验，为3奖励银币，为4奖励信仰之力，为5表示不给于任何奖励），剧情对话ID，权重，奖励材料（如果为道具则为道具ID，其它为0），奖励的数量，材料类型（0为普通，1为6级以上装备材料或特殊大经验奖励）
    {1, 13, 10, 190131, 1, 0},
	{1, 14, 10, 190132, 1, 0},
	{1, 15, 10, 190133, 1, 0},
	{1, 16, 10, 190134, 1, 0},
	{1, 17, 10, 190141, 1, 0},
	{1, 18, 10, 190142, 1, 0},
	{1, 19, 10, 190143, 1, 0},
	{1, 20, 10, 190144, 1, 0},
	{1, 29, 5, 190171, 1, 0},
	{1, 30, 5, 190172, 1, 0},
	{1, 31, 5, 190173, 1, 0},
	{1, 32, 5, 190174, 1, 0},
    {2, 33, 20, 0, 5000, 0},
    {3, 34, 20, 0, 20000, 0},
    {4, 35, 20, 0, 4000, 0},
	{5, 36, 20, 0, 0, 0},
}

--巨龙山活动奖励概率范围
JuLongShanAwardRange = {50, 120}


--巨龙山活动经验奖励公式
function JuLongShanExpCal(BaseExp)
    local RandomWeight = math.random(JuLongShanAwardRange[1], JuLongShanAwardRange[2])
    local PlayerLevel = GetPlayerData(0, 10)
    return PlayerLevel ^ 2 * (RandomWeight / 100)+BaseExp
end

--巨龙山活动银币奖励公式
function JuLongShanYinBiCal(BaseYinBi)
    local RandomWeight = math.random(JuLongShanAwardRange[1], JuLongShanAwardRange[2])
    local PlayerLevel = GetPlayerData(0, 10)
    return PlayerLevel ^ 2 * (RandomWeight / 100)+BaseYinBi
end

--巨龙山活动信仰之力奖励公式
function JuLongShanSpCal(BaseSp)
    local RandomWeight = math.random(JuLongShanAwardRange[1], JuLongShanAwardRange[2])
    local PlayerLevel = GetPlayerData(0, 10)
    return PlayerLevel ^ 2 * (RandomWeight / 100)+BaseSp
end