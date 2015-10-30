EquipSuitIntensifyTable = {}  --套装强化
EquipSuitIntensifyTable = 
{
    limitlevel = {QUALITY_DYELLOW,QUALITY_DGRAY,QUALITY_SILVER},  --包含的品质等级
    [QUALITY_DYELLOW] =  --品质
    {
        suitproperty = {0,10,3,6,2,6},--增加属性
        neetequippos = {EQUIP_P_WEAPON,EQUIP_P_HAT,EQUIP_P_PAT,EQUIP_P_CLOTH,EQUIP_P_WRIST,EQUIP_P_SHOSE},  --需求部件位置
    },
    [QUALITY_DGRAY] =  --品质
    {
        suitproperty = {0,20,3,13,2,13},--增加属性
        neetequippos = {EQUIP_P_WEAPON,EQUIP_P_HAT,EQUIP_P_PAT,EQUIP_P_CLOTH,EQUIP_P_WRIST,EQUIP_P_SHOSE},  --需求部件位置
    },
	[QUALITY_SILVER] =  --品质
    {
        suitproperty = {0,30,3,20,2,20},--增加属性
        neetequippos = {EQUIP_P_WEAPON,EQUIP_P_HAT,EQUIP_P_PAT,EQUIP_P_CLOTH,EQUIP_P_WRIST,EQUIP_P_SHOSE},  --需求部件位置
    },
	[QUALITY_GOLD] =  --品质
    {
        suitproperty = {0,40,3,26,2,26},--增加属性
        neetequippos = {EQUIP_P_WEAPON,EQUIP_P_HAT,EQUIP_P_PAT,EQUIP_P_CLOTH,EQUIP_P_WRIST,EQUIP_P_SHOSE,EQUIP_P_PRECIOUS,EQUIP_P_SHIZHUANG_HAT1},  --需求部件位置
    },
	[QUALITY_BLMETAL] =  --品质
    {
        suitproperty = {0,50,3,33,2,33},--增加属性
        neetequippos = {EQUIP_P_WEAPON,EQUIP_P_HAT,EQUIP_P_PAT,EQUIP_P_CLOTH,EQUIP_P_WRIST,EQUIP_P_SHOSE,EQUIP_P_PRECIOUS,EQUIP_P_SHIZHUANG_HAT1},  --需求部件位置
    },
	[QUALITY_BGOLD] =  --品质
    {
        suitproperty = {0,60,3,40,2,40},--增加属性
        neetequippos = {EQUIP_P_WEAPON,EQUIP_P_HAT,EQUIP_P_PAT,EQUIP_P_CLOTH,EQUIP_P_WRIST,EQUIP_P_SHOSE,EQUIP_P_PRECIOUS,EQUIP_P_SHIZHUANG_HAT1},  --需求部件位置
    },
	[QUALITY_BLGREEN] =  --品质
    {
        suitproperty = {0,70,3,46,2,46},--增加属性
        neetequippos = {EQUIP_P_WEAPON,EQUIP_P_HAT,EQUIP_P_PAT,EQUIP_P_CLOTH,EQUIP_P_WRIST,EQUIP_P_SHOSE,EQUIP_P_PRECIOUS,EQUIP_P_SHIZHUANG_HAT1},  --需求部件位置
    },
	[QUALITY_LGREEN] =  --品质
    {
        suitproperty = {0,80,3,53,2,53},--增加属性
        neetequippos = {EQUIP_P_WEAPON,EQUIP_P_HAT,EQUIP_P_PAT,EQUIP_P_CLOTH,EQUIP_P_WRIST,EQUIP_P_SHOSE,EQUIP_P_PRECIOUS,EQUIP_P_SHIZHUANG_HAT1},  --需求部件位置
    },
	[QUALITY_RED] =  --品质
    {
        suitproperty = {0,90,3,60,2,60},--增加属性
        neetequippos = {EQUIP_P_WEAPON,EQUIP_P_HAT,EQUIP_P_PAT,EQUIP_P_CLOTH,EQUIP_P_WRIST,EQUIP_P_SHOSE,EQUIP_P_PRECIOUS,EQUIP_P_SHIZHUANG_HAT1},  --需求部件位置
    },
	[QUALITY_TREASURE] =  --品质
    {
        suitproperty = {0,100,3,66,2,66},--增加属性
        neetequippos = {EQUIP_P_WEAPON,EQUIP_P_HAT,EQUIP_P_PAT,EQUIP_P_CLOTH,EQUIP_P_WRIST,EQUIP_P_SHOSE,EQUIP_P_PRECIOUS,EQUIP_P_SHIZHUANG_HAT1},  --需求部件位置
    },
}

EquipSuitStarTable = {}  --套装星级
EquipSuitStarTable = 
{
    limitlevel = {20,40,70,90,120,140,160,190,210,240},       --包含的星级
    [20] =   -- 单个部件需求
    {
         suitproperty = {0,17,3,11,2,11},--增加属性
        neetequippos = {EQUIP_P_WEAPON,EQUIP_P_HAT,EQUIP_P_PAT,EQUIP_P_CLOTH,EQUIP_P_WRIST,EQUIP_P_SHOSE},  --需求部件位置
    } ,

    [40] =   -- 单个部件需求
    {
         suitproperty = {0,35,3,23,2,23},--增加属性
        neetequippos = {EQUIP_P_WEAPON,EQUIP_P_HAT,EQUIP_P_PAT,EQUIP_P_CLOTH,EQUIP_P_WRIST,EQUIP_P_SHOSE,EQUIP_P_PRECIOUS,EQUIP_P_SHIZHUANG_HAT1},  --需求部件位置
    } ,
	[70] =   -- 单个部件需求
    {
         suitproperty = {0,53,3,35,2,35},--增加属性
        neetequippos = {EQUIP_P_WEAPON,EQUIP_P_HAT,EQUIP_P_PAT,EQUIP_P_CLOTH,EQUIP_P_WRIST,EQUIP_P_SHOSE,EQUIP_P_PRECIOUS,EQUIP_P_SHIZHUANG_HAT1},  --需求部件位置
    } ,
	[90] =   -- 单个部件需求
    {
         suitproperty = {0,71,3,47,2,47},--增加属性
        neetequippos = {EQUIP_P_WEAPON,EQUIP_P_HAT,EQUIP_P_PAT,EQUIP_P_CLOTH,EQUIP_P_WRIST,EQUIP_P_SHOSE,EQUIP_P_PRECIOUS,EQUIP_P_SHIZHUANG_HAT1},  --需求部件位置
    } ,
	[120] =   -- 单个部件需求
    {
         suitproperty = {0,89,3,59,2,59},--增加属性
        neetequippos = {EQUIP_P_WEAPON,EQUIP_P_HAT,EQUIP_P_PAT,EQUIP_P_CLOTH,EQUIP_P_WRIST,EQUIP_P_SHOSE,EQUIP_P_PRECIOUS,EQUIP_P_SHIZHUANG_HAT1},  --需求部件位置
    } ,
	[140] =   -- 单个部件需求
    {
         suitproperty = {0,107,3,71,2,71},--增加属性
        neetequippos = {EQUIP_P_WEAPON,EQUIP_P_HAT,EQUIP_P_PAT,EQUIP_P_CLOTH,EQUIP_P_WRIST,EQUIP_P_SHOSE,EQUIP_P_PRECIOUS,EQUIP_P_SHIZHUANG_HAT1},  --需求部件位置
    } ,
	[160] =   -- 单个部件需求
    {
         suitproperty = {0,125,3,83,2,83},--增加属性
        neetequippos = {EQUIP_P_WEAPON,EQUIP_P_HAT,EQUIP_P_PAT,EQUIP_P_CLOTH,EQUIP_P_WRIST,EQUIP_P_SHOSE,EQUIP_P_PRECIOUS,EQUIP_P_SHIZHUANG_HAT1},  --需求部件位置
    } ,
	[190] =   -- 单个部件需求
    {
         suitproperty = {0,143,3,95,2,95},--增加属性
        neetequippos = {EQUIP_P_WEAPON,EQUIP_P_HAT,EQUIP_P_PAT,EQUIP_P_CLOTH,EQUIP_P_WRIST,EQUIP_P_SHOSE,EQUIP_P_PRECIOUS,EQUIP_P_SHIZHUANG_HAT1},  --需求部件位置
    } ,
	[210] =   -- 单个部件需求
    {
         suitproperty = {0,161,3,107,2,107},--增加属性
        neetequippos = {EQUIP_P_WEAPON,EQUIP_P_HAT,EQUIP_P_PAT,EQUIP_P_CLOTH,EQUIP_P_WRIST,EQUIP_P_SHOSE,EQUIP_P_PRECIOUS,EQUIP_P_SHIZHUANG_HAT1},  --需求部件位置
    } ,
	[240] =   -- 单个部件需求
    {
         suitproperty = {0,179,3,119,2,119},--增加属性
        neetequippos = {EQUIP_P_WEAPON,EQUIP_P_HAT,EQUIP_P_PAT,EQUIP_P_CLOTH,EQUIP_P_WRIST,EQUIP_P_SHOSE,EQUIP_P_PRECIOUS,EQUIP_P_SHIZHUANG_HAT1},  --需求部件位置
    } ,
}



EquipSuitKeYingTable = {}  --套装刻印
EquipSuitKeYingTable = 
{
    limitlevel = {80,160,240,320,400,480},       --包含的刻印等级
    [80] =   -- 所有部件刻印等级总和
    {
        suitproperty =  {0,36,3,24,2,24},--增加属性
        neetequippos = {EQUIP_P_WEAPON,EQUIP_P_HAT,EQUIP_P_PAT,EQUIP_P_CLOTH,EQUIP_P_WRIST,EQUIP_P_SHOSE},  --需求部件位置
    } ,
    [160] =   -- 单个部件需求
    {
        suitproperty = {0,72,3,48,2,48},--增加属性
        neetequippos = {EQUIP_P_WEAPON,EQUIP_P_HAT,EQUIP_P_PAT,EQUIP_P_CLOTH,EQUIP_P_WRIST,EQUIP_P_SHOSE,EQUIP_P_PRECIOUS,EQUIP_P_SHIZHUANG_HAT1},  --需求部件位置
    } ,
	[240] =   -- 单个部件需求
    {
        suitproperty = {0,108,3,72,2,72},--增加属性
        neetequippos = {EQUIP_P_WEAPON,EQUIP_P_HAT,EQUIP_P_PAT,EQUIP_P_CLOTH,EQUIP_P_WRIST,EQUIP_P_SHOSE,EQUIP_P_PRECIOUS,EQUIP_P_SHIZHUANG_HAT1},  --需求部件位置
    } ,
	[320] =   -- 单个部件需求
    {
        suitproperty = {0,144,3,96,2,96},--增加属性
        neetequippos = {EQUIP_P_WEAPON,EQUIP_P_HAT,EQUIP_P_PAT,EQUIP_P_CLOTH,EQUIP_P_WRIST,EQUIP_P_SHOSE,EQUIP_P_PRECIOUS,EQUIP_P_SHIZHUANG_HAT1},  --需求部件位置
    } ,
	[400] =   -- 单个部件需求
    {
        suitproperty = {0,180,3,120,2,120},--增加属性
        neetequippos = {EQUIP_P_WEAPON,EQUIP_P_HAT,EQUIP_P_PAT,EQUIP_P_CLOTH,EQUIP_P_WRIST,EQUIP_P_SHOSE,EQUIP_P_PRECIOUS,EQUIP_P_SHIZHUANG_HAT1},  --需求部件位置
    } ,
	[480] =   -- 单个部件需求
    {
        suitproperty = {0,217,3,144,2,144},--增加属性
        neetequippos = {EQUIP_P_WEAPON,EQUIP_P_HAT,EQUIP_P_PAT,EQUIP_P_CLOTH,EQUIP_P_WRIST,EQUIP_P_SHOSE,EQUIP_P_PRECIOUS,EQUIP_P_SHIZHUANG_HAT1},  --需求部件位置
    } ,
}


