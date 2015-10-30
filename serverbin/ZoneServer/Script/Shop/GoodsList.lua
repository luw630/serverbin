--商城刷新时间倒计时提示系统公告
ShopCountDownSysCall = {
--剩余时间   提示次数
    {
        {1 * 60, 5},
        {2 * 60, 4},
        {3 * 60, 3},
        {4 * 60, 2},
        {5 * 60, 1},
    },
    {
        {1 * 60, 2},
        {2 * 60, 2},
        {3 * 60, 2},
        {4 * 60, 2},
        {5 * 60, 2},
    },
    {
        {1 * 60, 2},
        {2 * 60, 2},
        {3 * 60, 2},
        {4 * 60, 2},
        {5 * 60, 2},
    },
    {
        {1 * 60, 2},
        {2 * 60, 2},
        {3 * 60, 2},
        {4 * 60, 2},
        {5 * 60, 2},
    },
    {
        {1 * 60, 2},
        {2 * 60, 2},
        {3 * 60, 2},
        {4 * 60, 2},
        {5 * 60, 2},
    },
}

--商城刷新时间
ShopRefreshList = 
{
    --IntervalDay：间隔天数（为0时表示按每天固定时间组刷新，大于0时表示按间隔天数的固定一个时间刷新）
    --后面的数据为刷新的时间组（当 IntervalDay = 1时，每天固定的时间点）
    [1] = {IntervalDay = 0; 10 * 60 * 60 +  16* 60, 15 * 60 * 60 + 43 * 60, 18 * 60 * 60 + 50 * 60, 
    21 * 60 * 60 + 16 * 60, 21 * 60 * 60 + 14 * 60, 22 * 60 * 60, 23 * 60 * 60},
    [2] = {},    --没有刷新
    [3] = {IntervalDay = 7; 0 * 60 * 60},   --表示间隔7天后的固定点刷新
    [4] = {},    --没有刷新
    [5] = {},    --没有刷新
}

--商城数据说明
ShopDataList = 
{
    --商城类型：包括热卖商城(1)、成长变强商城(2)、超级特价(3)、无双礼包(4)、帮助(5)；
    --刷新类型：有两种刷新(为0时，不考虑；为1时，表示每天重置时间；为2时，表示间隔重置时间, 脚本重配后重新加载时也会重置；)
    --商城类型  --刷新标志(0为不可刷新商城，1为可以刷新商城)  下次刷新所需总时间  刷新类型  商城更新标识(默认为1，商品已经更新)
    [1] = {1, 0, 1, 1},   --热卖
    [2] = {0, 0, 0, 1},   --成长变强
    [3] = {1, 0, 1, 1},   --超级特价
    [4] = {0, 0, 0, 1},   --无双礼包
    [5] = {0, 0, 0, 1},   --帮助
}

GoodsDataList = 
{
--[[
商品类型，商品ID（道具ID），金币原价，金币现价，游戏币原价，游戏币现价，商品数量
商品类型：用于区分商品的功能作用。默认为0，不区分商品类型；
商品数量：为-1表示不限数量；
--]]
--商品类型，商品ID（道具ID），金币原价，金币现价，游戏币原价，游戏币现价，商品数量
    [1] =   --热卖
    {
        [1] = 
        {
            {0, 190500, 20, 8, 1000, 800, -1},
            {0, 190501, 15, 6, 1000, 800, -1},
            {0, 190502, 15, 6, 1000, 800, -1},
            {0, 190503, 25, 12, 1000, 800, -1},
            {0, 190504, 22, 10, 1000, 800, -1},
        },
        [2] = 
        {
            {0, 190500, 20, 8, 1000, 800, -1},
            {0, 190501, 15, 6, 1000, 800, -1},
            {0, 190502, 15, 6, 1000, 800, -1},
            {0, 190503, 25, 12, 1000, 800, -1},
            {0, 190504, 22, 10, 1000, 800, -1},
        },
        [3] = 
        {
            {0, 190500, 20, 8, 1000, 800, -1},
            {0, 190501, 15, 6, 1000, 800, -1},
            {0, 190502, 15, 6, 1000, 800, -1},
            {0, 190503, 25, 12, 1000, 800, -1},
            {0, 190504, 22, 10, 1000, 800, -1},
        }, 
        [4] = 
        {
            {0, 190500, 20, 8, 1000, 800, -1},
            {0, 190501, 15, 6, 1000, 800, -1},
            {0, 190502, 15, 6, 1000, 800, -1},
            {0, 190503, 25, 12, 1000, 800, -1},
            {0, 190504, 22, 10, 1000, 800, -1},
        },
    },
    
    [2] = --成长变强  --商品类型，商品ID（道具ID），金币原价，金币现价，游戏币原价，游戏币现价，商品数量
    {
        [1] = 
        {
            {0, 190101, 20, 18, 1000, 800, -1},
            {0, 190102, 20, 18, 1000, 800, -1},
            {0, 190103, 20, 13, 1000, 800, -1},
            {0, 190104, 20, 13, 1000, 800, -1},
            {0, 190111, 20, 33, 1000, 800, -1},
            {0, 190112, 20, 33, 1000, 800, -1},
            {0, 190113, 20, 16, 1000, 800, -1},
            {0, 190114, 20, 16, 1000, 800, -1},
            {0, 190121, 20, 53, 1000, 800, -1},
            {0, 190122, 20, 53, 1000, 800, -1},
            {0, 190123, 20, 23, 1000, 800, -1},
            {0, 190124, 20, 23, 1000, 800, -1},
            {0, 190131, 20, 73, 1000, 800, -1},
            {0, 190132, 20, 73, 1000, 800, -1},
            {0, 190133, 20, 43, 1000, 800, -1},
            {0, 190134, 20, 43, 1000, 800, -1},
            {0, 190141, 20, 104, 1000, 800, -1},
            {0, 190142, 20, 104, 1000, 800, -1},
            {0, 190143, 20, 77, 1000, 800, -1},
            {0, 190144, 20, 77, 1000, 800, -1},
            {0, 190151, 20, 155, 1000, 800, -1},
            {0, 190152, 20, 155, 1000, 800, -1},
            {0, 190153, 20, 102, 1000, 800, -1},
            {0, 190154, 20, 102, 1000, 800, -1},
            {0, 190161, 20, 206, 1000, 800, -1},
            {0, 190162, 20, 206, 1000, 800, -1},
            {0, 190163, 20, 177, 1000, 800, -1},
            {0, 190164, 20, 177, 1000, 800, -1},
            {0, 190171, 20, 288, 1000, 800, -1},
            {0, 190172, 20, 288, 1000, 800, -1},
            {0, 190173, 20, 208, 1000, 800, -1},
            {0, 190174, 20, 208, 1000, 800, -1},
            {0, 190181, 20, 308, 1000, 800, -1},
            {0, 190182, 20, 308, 1000, 800, -1},
            {0, 190183, 20, 288, 1000, 800, -1},
            {0, 190184, 20, 288, 1000, 800, -1},
            {0, 190201, 20, 50, 1000, 800, -1},
            {0, 190202, 20, 100, 1000, 800, -1},
            {0, 190203, 20, 200, 1000, 800, -1},
            {0, 190204, 20, 400, 1000, 800, -1},
            {0, 190301, 20, 200, 1000, 800, -1},
            {0, 190302, 20, 400, 1000, 800, -1},
            {0, 190303, 20, 600, 1000, 800, -1},
            {0, 190304, 20, 800, 1000, 800, -1},
            {0, 190311, 20, 500, 1000, 800, -1},
            {0, 190401, 20, 1000, 1000, 800, -1},			
            {0, 190411, 20, 888, 1000, 800, -1},					
        },
        [2] = 
        {
            {0, 190101, 20, 18, 1000, 800, -1},
            {0, 190102, 20, 18, 1000, 800, -1},
            {0, 190103, 20, 13, 1000, 800, -1},
            {0, 190104, 20, 13, 1000, 800, -1},
            {0, 190111, 20, 33, 1000, 800, -1},
            {0, 190112, 20, 33, 1000, 800, -1},
            {0, 190113, 20, 16, 1000, 800, -1},
            {0, 190114, 20, 16, 1000, 800, -1},
            {0, 190121, 20, 53, 1000, 800, -1},
            {0, 190122, 20, 53, 1000, 800, -1},
            {0, 190123, 20, 23, 1000, 800, -1},
            {0, 190124, 20, 23, 1000, 800, -1},
            {0, 190131, 20, 73, 1000, 800, -1},
            {0, 190132, 20, 73, 1000, 800, -1},
            {0, 190133, 20, 43, 1000, 800, -1},
            {0, 190134, 20, 43, 1000, 800, -1},
            {0, 190141, 20, 104, 1000, 800, -1},
            {0, 190142, 20, 104, 1000, 800, -1},
            {0, 190143, 20, 77, 1000, 800, -1},
            {0, 190144, 20, 77, 1000, 800, -1},
            {0, 190151, 20, 155, 1000, 800, -1},
            {0, 190152, 20, 155, 1000, 800, -1},
            {0, 190153, 20, 102, 1000, 800, -1},
            {0, 190154, 20, 102, 1000, 800, -1},
            {0, 190161, 20, 206, 1000, 800, -1},
            {0, 190162, 20, 206, 1000, 800, -1},
            {0, 190163, 20, 177, 1000, 800, -1},
            {0, 190164, 20, 177, 1000, 800, -1},
            {0, 190171, 20, 288, 1000, 800, -1},
            {0, 190172, 20, 288, 1000, 800, -1},
            {0, 190173, 20, 208, 1000, 800, -1},
            {0, 190174, 20, 208, 1000, 800, -1},
            {0, 190181, 20, 308, 1000, 800, -1},
            {0, 190182, 20, 308, 1000, 800, -1},
            {0, 190183, 20, 288, 1000, 800, -1},
            {0, 190184, 20, 288, 1000, 800, -1},
            {0, 190201, 20, 50, 1000, 800, -1},
            {0, 190202, 20, 100, 1000, 800, -1},
            {0, 190203, 20, 200, 1000, 800, -1},
            {0, 190204, 20, 400, 1000, 800, -1},
            {0, 190301, 20, 200, 1000, 800, -1},
            {0, 190302, 20, 400, 1000, 800, -1},
            {0, 190303, 20, 600, 1000, 800, -1},
            {0, 190304, 20, 800, 1000, 800, -1},
            {0, 190311, 20, 500, 1000, 800, -1},
            {0, 190401, 20, 1000, 1000, 800, -1},			
            {0, 190411, 20, 888, 1000, 800, -1},
        },
    },

    [3] =   --特价商城   --商品类型，商品ID（道具ID），金币原价，金币现价，游戏币原价，游戏币现价，商品数量
    {
        [1] = 
        {
            {0, 190655, 200, 120, 1000, 800, -1},
			{0, 190656, 100, 80, 1000, 800, -1},
            {0, 190657, 200, 100, 1000, 800, -1},
            {0, 190658, 150, 120, 1000, 800, -1},
            {0, 190659, 50, 30, 1000, 800, -1},
            {0, 190660, 30, 15, 1000, 800, -1},
            {0, 190661, 20, 10, 1000, 800, -1},
            {0, 190662, 150, 120, 1000, 800, -1},
            {0, 190663, 200, 188, 1000, 800, -1},
            {0, 190664, 20, 18, 1000, 800, -1},
            {0, 190665, 30, 28, 1000, 800, -1},
            {0, 190666, 350, 220, 1000, 800, -1},
			{0, 190667, 200, 178, 1000, 800, -1},
            {0, 190668, 300, 288, 1000, 800, -1},
            {0, 190669, 100, 88, 1000, 800, -1},
            {0, 190670, 100, 88, 1000, 800, -1},
            {0, 190671, 2000, 1888, 1000, 800, -1},
        },
        [2] = 
        {
            {0, 190650, 20, 4, 1000, 800, -1},
            {0, 190651, 20, 8, 1000, 800, -1},
            {0, 190652, 20, 10, 1000, 800, -1},
            {0, 190653, 20, 15, 1000, 800, -1},
            {0, 190654, 20, 20, 1000, 800, -1},
            {0, 190655, 20, 120, 1000, 800, -1},
			{0, 190656, 20, 80, 1000, 800, -1},
            {0, 190657, 20, 100, 1000, 800, -1},
            {0, 190658, 20, 120, 1000, 800, -1},
            {0, 190659, 20, 30, 1000, 800, -1},
            {0, 190660, 20, 15, 1000, 800, -1},
            {0, 190661, 20, 10, 1000, 800, -1},
            {0, 190662, 20, 120, 1000, 800, -1},
            {0, 190663, 20, 188, 1000, 800, -1},
            {0, 190664, 20, 18, 1000, 800, -1},
            {0, 190665, 20, 28, 1000, 800, -1},
            {0, 190666, 20, 220, 1000, 800, -1},
			{0, 190667, 20, 178, 1000, 800, -1},
            {0, 190668, 20, 288, 1000, 800, -1},
            {0, 190669, 20, 88, 1000, 800, -1},
            {0, 190670, 20, 88, 1000, 800, -1},
            {0, 190671, 20, 1888, 1000, 800, -1},
        },
        [3] = 
        {
            {0, 190650, 20, 4, 1000, 800, -1},
            {0, 190651, 20, 8, 1000, 800, -1},
            {0, 190652, 20, 10, 1000, 800, -1},
            {0, 190653, 20, 15, 1000, 800, -1},
            {0, 190654, 20, 20, 1000, 800, -1},
            {0, 190655, 20, 120, 1000, 800, -1},
			{0, 190656, 20, 80, 1000, 800, -1},
            {0, 190657, 20, 100, 1000, 800, -1},
            {0, 190658, 20, 120, 1000, 800, -1},
            {0, 190659, 20, 30, 1000, 800, -1},
            {0, 190660, 20, 15, 1000, 800, -1},
            {0, 190661, 20, 10, 1000, 800, -1},
            {0, 190662, 20, 120, 1000, 800, -1},
            {0, 190663, 20, 188, 1000, 800, -1},
            {0, 190664, 20, 18, 1000, 800, -1},
            {0, 190665, 20, 28, 1000, 800, -1},
            {0, 190666, 20, 220, 1000, 800, -1},
			{0, 190667, 20, 178, 1000, 800, -1},
            {0, 190668, 20, 288, 1000, 800, -1},
            {0, 190669, 20, 88, 1000, 800, -1},
            {0, 190670, 20, 88, 1000, 800, -1},
            {0, 190671, 20, 1888, 1000, 800, -1},
        }, 
    },

    [4] = --无双礼包
    {
        [1] = 
        {
            {0, 810101, 20, 1, 1000, 800, -1},
            {0, 810102, 20, 5, 1000, 800, -1},
            {0, 810103, 20, 10, 1000, 800, -1},
            {0, 810104, 20, 15, 1000, 800, -1},
            {0, 810105, 20, 20, 1000, 800, -1},
            {0, 810106, 20, 25, 1000, 800, -1},
            {0, 810107, 20, 30, 1000, 800, -1},
            {0, 810108, 20, 35, 1000, 800, -1},
            {0, 810109, 20, 40, 1000, 800, -1},
            {0, 810110, 20, 45, 1000, 800, -1},
            {0, 810111, 20, 50, 1000, 800, -1},
            {0, 810112, 20, 55, 1000, 800, -1},
            {0, 810113, 20, 1, 1000, 800, -1},
            {0, 810116, 20, 2, 1000, 800, -1},
            {0, 810121, 20, 4, 1000, 800, -1},
        },
        [2] = 
        {
            {0, 810101, 20, 1, 1000, 800, -1},
            {0, 810102, 20, 5, 1000, 800, -1},
            {0, 810103, 20, 10, 1000, 800, -1},
            {0, 810104, 20, 15, 1000, 800, -1},
            {0, 810105, 20, 20, 1000, 800, -1},
            {0, 810106, 20, 25, 1000, 800, -1},
            {0, 810107, 20, 30, 1000, 800, -1},
            {0, 810108, 20, 35, 1000, 800, -1},
            {0, 810109, 20, 40, 1000, 800, -1},
            {0, 810110, 20, 45, 1000, 800, -1},
            {0, 810111, 20, 50, 1000, 800, -1},
            {0, 810112, 20, 55, 1000, 800, -1},
            {0, 810113, 20, 1, 1000, 800, -1},
            {0, 810116, 20, 2, 1000, 800, -1},
            {0, 810121, 20, 4, 1000, 800, -1},
        },
        [3] = 
        {
            {0, 810101, 20, 1, 1000, 800, -1},
            {0, 810102, 20, 5, 1000, 800, -1},
            {0, 810103, 20, 10, 1000, 800, -1},
            {0, 810104, 20, 15, 1000, 800, -1},
            {0, 810105, 20, 20, 1000, 800, -1},
            {0, 810106, 20, 25, 1000, 800, -1},
            {0, 810107, 20, 30, 1000, 800, -1},
            {0, 810108, 20, 35, 1000, 800, -1},
            {0, 810109, 20, 40, 1000, 800, -1},
            {0, 810110, 20, 45, 1000, 800, -1},
            {0, 810111, 20, 50, 1000, 800, -1},
            {0, 810112, 20, 55, 1000, 800, -1},
            {0, 810113, 20, 1, 1000, 800, -1},
            {0, 810116, 20, 2, 1000, 800, -1},
            {0, 810121, 20, 4, 1000, 800, -1},
        }, 
        [4] = 
        {
            {0, 810101, 20, 1, 1000, 800, -1},
            {0, 810102, 20, 5, 1000, 800, -1},
            {0, 810103, 20, 10, 1000, 800, -1},
            {0, 810104, 20, 15, 1000, 800, -1},
            {0, 810105, 20, 20, 1000, 800, -1},
            {0, 810106, 20, 25, 1000, 800, -1},
            {0, 810107, 20, 30, 1000, 800, -1},
            {0, 810108, 20, 35, 1000, 800, -1},
            {0, 810109, 20, 40, 1000, 800, -1},
            {0, 810110, 20, 45, 1000, 800, -1},
            {0, 810111, 20, 50, 1000, 800, -1},
            {0, 810112, 20, 55, 1000, 800, -1},
            {0, 810113, 20, 1, 1000, 800, -1},
            {0, 810116, 20, 2, 1000, 800, -1},
            {0, 810121, 20, 4, 1000, 800, -1},
        },
    },
}