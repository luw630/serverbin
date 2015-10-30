    tongyongGoods1 = {1,2,3,4,24,25,26,91,27,28,29,8176,8177,8178,8179,8180,8181,8182,40217,6576,10012,10014,10016,10040,10112,10114,10116,10140,10725,40199}
    tongyongGoods3 = {10000,10001,10002,10003,10004,10005,10006,10007,10008,10009}
    slGoods2 = {1001,1011,1021,1101,1111,1121,1201,1211,1221,1301,1311,1321,1401,1411,1421,1501,1511,1521,6374,948,940}
    wdGoods2 = {2001,2011,2021,2101,2111,2121,2201,2211,2221,2301,2311,2321,2401,2411,2421,2501,2511,2521,6371,952,941}
    emGoods2 = {3001,3011,3021,3101,3111,3121,3201,3211,3221,3301,3311,3321,3401,3411,3421,3501,3511,3521,6372,956,942}
    tmGoods2 = {4001,4011,4021,4101,4111,4121,4201,4211,4221,4301,4311,4321,4401,4411,4421,4501,4511,4521,6375,960,943}
    mjGoods2 = {5001,5011,5021,5101,5111,5121,5201,5211,5221,5301,5311,5321,5401,5411,5421,5501,5511,5521,6373,964,944}
	slGoods22 = {}
    wdGoods22 = {}
    emGoods22 = {}
    tmGoods22 = {}
    mjGoods22 = {}
	

function NewXYDbuy()
    local pk = GetPlayerData(10)
    local name = GetPlayerData(3)
	local school = GetPlayerData(2)
	if(pk >= -3)then
		if(	school == 0 )then
		    SetMessage(70267,"奉武林盟主之命，在此向各位江湖朋友提供帮助，练功的必需品——药物、武器、装备、铜人应有尽有，敬请选购。#有些什么东西卖？#我没有什么要买的。#",0,0)
		    InitGoodsPackage(tongyongGoods1, tongyongGoods3, slGoods22)
		elseif( school == 1 )then
		    SetMessage(70267,"奉武林盟主之命，在此向各位江湖朋友提供帮助，练功的必需品——药物、武器、装备、铜人应有尽有，敬请选购。#有些什么东西卖？#我没有什么要买的。#",0,0)
		    InitGoodsPackage(tongyongGoods1, tongyongGoods3, wdGoods22)	
		elseif( school == 2 )then
		    SetMessage(70267,"奉武林盟主之命，在此向各位江湖朋友提供帮助，练功的必需品——药物、武器、装备、铜人应有尽有，敬请选购。#有些什么东西卖？#我没有什么要买的。#",0,0)
		    InitGoodsPackage(tongyongGoods1, tongyongGoods3, emGoods22)	
		elseif( school == 3 )then
		    SetMessage(70267,"奉武林盟主之命，在此向各位江湖朋友提供帮助，练功的必需品——药物、武器、装备、铜人应有尽有，敬请选购。#有些什么东西卖？#我没有什么要买的。#",0,0)
		    InitGoodsPackage(tongyongGoods1, tongyongGoods3, tmGoods22)
		elseif( school == 4 )then
		    SetMessage(70267,"奉武林盟主之命，在此向各位江湖朋友提供帮助，练功的必需品——药物、武器、装备、铜人应有尽有，敬请选购。#有些什么东西卖？#我没有什么要买的。#",0,0)
		    InitGoodsPackage(tongyongGoods1, tongyongGoods3, mjGoods22)		
	    end
	else
		SetMessage(0,"你不会就是那个嗜杀成性，双手沾满武林同道的鲜血的"..name.."吧……我可不想惹什么麻烦！请你走开吧！#离开#",0,0)	
	end
end

function ClickMenu70267(index)
       if(index == 1) then
       SetMessageB()
       end
end

function OnClick7089()--少林
	NewXYDbuy()
end	

function OnClick7090()--武当
	NewXYDbuy()
end


function OnClick7091()--娥眉
	NewXYDbuy()
end

function OnClick7092()--唐门
	NewXYDbuy()
end


function OnClick7093()--魔教
	NewXYDbuy()
end
--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  门派地图新手商店 %%%%%%%%%%%%%%%%%%%%%%%%%%%
    slGoods1 = {21,24,27,1002,1003,1011,1012,1013}
    --slGoods2 = {1102,1103,1112,1113,1202,1203,1212,1213,1302,1303,1312,1313}
    slGoods3 = {1402,1403,1412,1413,1502,1503,1512,1513,7001,7002,7003,7004,7005,7006,7007,7008,7009,7010,7011,7012,7013,7014,7015,7016,7017,7018}
    wdGoods1 = {21,24,27,2002,2003,2011,2012,2013}
    --wdGoods2 = {2102,2103,2112,2113,2202,2203,2212,2213,2302,2303,2312,2313}
    wdGoods3 = {2402,2403,2412,2413,2502,2503,2512,2513,7001,7002,7003,7004,7005,7006,7007,7008,7009,7010,7011,7012,7013,7014,7015,7016,7017,7018}
    emGoods1 = {21,24,27,3002,3003,3011,3012,3013}
    --emGoods2 = {3102,3103,3112,3113,3202,3203,3212,3213,3302,3303,3312,3313}
    emGoods3 = {3402,3403,3412,3413,3502,3503,3512,3513,7001,7002,7003,7004,7005,7006,7007,7008,7009,7010,7011,7012,7013,7014,7015,7016,7017,7018}
    tmGoods1 = {21,24,27,4002,4003,4011,4012,4013}
    --tmGoods2 = {4102,4103,4112,4113,4202,4203,4212,4213,4302,4303,4312,4313}
    tmGoods3 = {4402,4403,4412,4413,4502,4503,4512,4513,7001,7002,7003,7004,7005,7006,7007,7008,7009,7010,7011,7012,7013,7014,7015,7016,7017,7018}
    mjGoods1 = {21,24,27,5002,5003,5011,5012,5013}
    --mjGoods2 = {5102,5103,5112,5113,5202,5203,5212,5213,5302,5303,5312,5313}
    mjGoods3 = {5402,5403,5412,5413,5502,5503,5512,5513,7001,7002,7003,7004,7005,7006,7007,7008,7009,7010,7011,7012,7013,7014,7015,7016,7017,7018}

RemoveObjectIndirect(1,5020)   ---少林
CreateObjectIndirect( { regionId = 26,name="新手商店",title="少林",imageId = 26,  x = 62, y = 103,  clickScript = 7089, dir = 5,objectType = 1, controlId = 5020})	
RemoveObjectIndirect(1,5021)   ---峨眉
CreateObjectIndirect( { regionId = 5,name="新手商店",title="峨眉",imageId = 26,  x = 30, y = 49,  clickScript = 7091, dir = 4,objectType = 1, controlId = 5021})	
RemoveObjectIndirect(1,5022)   ---武当
CreateObjectIndirect( { regionId = 17,name="新手商店",title="武当",imageId = 26,  x = 65, y = 123,  clickScript = 7090, dir = 4,objectType = 1, controlId = 5022})
RemoveObjectIndirect(1,5023)   ---唐门
CreateObjectIndirect( { regionId = 6,name="新手商店",title="唐门",imageId = 26,  x = 49, y = 95,  clickScript = 7092, dir = 3,objectType = 1, controlId = 5023})
RemoveObjectIndirect(1,5024)   ---魔教
CreateObjectIndirect( { regionId = 18,name="新手商店",title="魔教",imageId = 26,  x = 64, y = 108,  clickScript = 7093, dir = 5,objectType = 1, controlId = 5024})
	
function OnClick7089()--少林
    local pk = GetPlayerData(10)
    local name = GetPlayerData(3)
	local school = GetPlayerData(2)
    if(pk >= -3)then
		if(	school == 0 )then
		    SetMessage(70267,"奉武林盟主之命，在此向初入江湖的新人提供帮助，新人练功的必需品——药物、武器、装备、铜人应有尽有，敬请选购。#有些什么东西卖？#我没有什么要买的。#",0,0)
		    InitGoodsPackage(tongyongGoods1, slGoods2, tongyongGoods3)
		else
			SetMessage(0,"请到自己门派的商人处购买物品#多谢指点#",0,0)
		end	
    else
    SetMessage(0,"你不会就是那个嗜杀成性，双手沾满武林同道的鲜血的"..name.."吧……我可不想惹什么麻烦！请你走开吧！#离开#",0,0)
    end
end
function ClickMenu70267(index)
		rfalse('ClickMenu70267:'..tostring(index))
       if(index == 1) then
       SetMessageB()
       end
end

function OnClick7090()--武当
    local pk = GetPlayerData(10)
    local name = GetPlayerData(3)
	local school = GetPlayerData(2)
    if(pk >= -3)then
		if(	school == 1 )then
		    SetMessage(70268,"奉武林盟主之命，在此向初入江湖的新人提供帮助，新人练功的必须品——药物、武器、装备、铜人应有尽有，敬请选购。#有些什么东西卖？#我没有什么要买的。#",0,0)
		    InitGoodsPackage(tongyongGoods1, wdGoods2, tongyongGoods3)
		else	
			SetMessage(0,"请到自己门派的商人处购买物品#多谢指点#",0,0)
		end	
    else
    SetMessage(0,"你不会就是那个嗜杀成性，双手沾满武林同道的鲜血的"..name.."吧……我可不想惹什么麻烦！请你走开吧！#离开#",0,0)
    end
end
function ClickMenu70268(index)
       if(index == 1) then
       SetMessageB()
       end
end

function OnClick7091()--娥眉
    local pk = GetPlayerData(10)
    local name = GetPlayerData(3)
	local school = GetPlayerData(2)
    if(pk >= -3)then
		if(	school == 2 )then
		    SetMessage(70269,"奉武林盟主之命，在此向初入江湖的新人提供帮助，新人练功的必须品——药物、武器、装备、铜人应有尽有，敬请选购。#有些什么东西卖？#我没有什么要买的。#",0,0)
		    InitGoodsPackage(tongyongGoods1, emGoods2, tongyongGoods3)
		else	
			SetMessage(0,"请到自己门派的商人处购买物品#多谢指点#",0,0)
		end	
    else
    SetMessage(0,"你不会就是那个嗜杀成性，双手沾满武林同道的鲜血的"..name.."吧……我可不想惹什么麻烦！请你走开吧！#离开#",0,0)
    end
end
function ClickMenu70269(index)
       if(index == 1) then
       SetMessageB()
       end
end

function OnClick7092()--唐门
    local pk = GetPlayerData(10)
    local name = GetPlayerData(3)
	local school = GetPlayerData(2)
    if(pk >= -3)then
		if(	school == 3 )then
		    SetMessage(70270,"奉武林盟主之命，在此向初入江湖的新人提供帮助，新人练功的必须品——药物、武器、装备、铜人应有尽有，敬请选购。#有些什么东西卖？#我没有什么要买的。#",0,0)
		    InitGoodsPackage(tongyongGoods1, tmGoods2, tongyongGoods3)
		else	
			SetMessage(0,"请到自己门派的商人处购买物品#多谢指点#",0,0)
		end		
    else
    SetMessage(0,"你不会就是那个嗜杀成性，双手沾满武林同道的鲜血的"..name.."吧……我可不想惹什么麻烦！请你走开吧！#离开#",0,0)
    end
end
function ClickMenu70270(index)
       if(index == 1) then
       SetMessageB(1, 1)
       end
end

function OnClick7093()--魔教
    local pk = GetPlayerData(10)
    local name = GetPlayerData(3)
	local school = GetPlayerData(2)
    if(pk >= -3)then
		if(	school == 4 )then
		    SetMessage(70271,"奉武林盟主之命，在此向初入江湖的新人提供帮助，新人练功的必须品——药物、武器、装备、铜人应有尽有，敬请选购。#有些什么东西卖？#我没有什么要买的。#",0,0)
		    InitGoodsPackage(tongyongGoods1, mjGoods2, tongyongGoods3)
		else	
			SetMessage(0,"请到自己门派的商人处购买物品#多谢指点#",0,0)
		end	
    else
    SetMessage(0,"你不会就是那个嗜杀成性，双手沾满武林同道的鲜血的"..name.."吧……我可不想惹什么麻烦！请你走开吧！#离开#",0,0)
    end
end
function ClickMenu70271(index)
       if(index == 1) then
       SetMessageB()
       end
end
