
--神泉山活动相关配置
SQSOpenTimeInf = 
{--当前开放时间，默认为0;--开发标志，0为未开放，1为已经开放； --是否已经系统提示过0为没有，1为提示过
        CurOpenTime = 0,        OpenFlag = 0, IsSysCallFlag = 0
}

--神泉山开发时间列表
SQSOpenTimeList = 
{
    --参数依次为：开发起始时间，开发结束时间
    {9 * 60 * 60, 12 * 60 * 60,},
    {16 * 60 * 60 + 4 * 60, 21 * 60 * 60 + 30 * 60,},
}

--神泉山开发时间系统提示时间
SQSOpenTimeSysCall = 
{
    --参数依次为：刷新时间间隔s,提示次数
    {30 * 60, 4},
    {10 * 60, 3},
    {5 * 60, 2},
    {1 * 60, 1},
}