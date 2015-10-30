GiftTable = {}


--礼包的数值1-9为新手礼包
GiftTable[1] = {--8005001  5级新手礼包
				7000001,50,--50个1级生命药
				7010001,50,--50个1级内力药
				8021001,1,--暂时给银两用于学技能
				8005002,1,--10级新手礼包
				}

GiftTable[2] = {--8005002  10级新手礼包
				7000002,50,--50个10级生命药
				7020002,50,--50个10级体力药
				8011001,10,--10个回城传卷
				8020001,1,--5000银币
				8005003,1,--15级新手礼包
				}
GiftTable[3] = {--8005003  15级新手礼包
				8005010,1,--真气丹7000点
				4030001,1,--5个乌元丹
				8020001,1,--5000银币
				8021002,1,--暂时给银两用于学技能
				8005004,1,--20级新手礼包
				}
				--坐骑强化（有道具但是没功能）

GiftTable[4] = {--8005004  20级新手礼包
				3500002,1,--阴跷脉·照海
				3500003,1,--阴跷脉·交信
				--10020001,1,--侠客经验丸(暂时不要)
				4031001,1,--1个怒神丹
				8005005,1,--25级新手礼包
				}
				--GiveGoods(4060003,1) --1个麒麟丹

GiftTable[5] = {--8005005  25级新手礼包
				4003001,1,--3个天青石
				4020001,1,--5个星尖沙
				4060002,1,--1个破障丹
				8020002,1,--10000银币
				8021003,1,--暂时给银两用于学技能
				8005006,1,--30级新手礼包
				}

GiftTable[6] = {--8005006  30级新手礼包
				4001001,1,--5个尖晶石
				4000001,1,--3个金刚石
				8020002,1,--10000银币
				8005007,1,--35级新手礼包
				}
				--坐骑升级（有道具但是没功能）

GiftTable[7] = {--8005007  35级新手礼包
				4010003,1,--1个玄铁石
				4004001,1,--1个生命宝石
				4004301,1,--1个攻击宝石
				4004401,1,--1个防御宝石
				4002001,1,--2个黑玄石
				8021004,1,--暂时给银两用于学技能
				8005008,1,--40级新手礼包
				}
				--10个固定传送卷（暂时没功能）

GiftTable[8] = {--8005008  40级新手礼包
				4010007,1,--1个玉凿
				8020003,1,--20000银币
				8022005,1,--1000礼券
				}
				--1个洗星石（暂时没功能）


--礼包的数值9-15为在线奖励礼包
GiftTable[9] = {
				4010007,1,--1个玉凿
				8020003,1,--20000银币
				8022005,1,--1000礼券
				}
GiftTable[10] = {
				4010007,1,--1个玉凿
				8020003,1,--20000银币
				8022005,1,--1000礼券
				}
GiftTable[11] = {
				4010007,1,--1个玉凿
				8020003,1,--20000银币
				8022005,1,--1000礼券
				}
GiftTable[12] = {
				4010007,1,--1个玉凿
				8020003,1,--20000银币
				8022005,1,--1000礼券
				}
GiftTable[13] = {
				4010007,1,--1个玉凿
				8020003,1,--20000银币
				8022005,1,--1000礼券
				}
GiftTable[14] = {
				4010007,1,--1个玉凿
				8020003,1,--20000银币
				8022005,1,--1000礼券
				}
GiftTable[15] = {
				4010007,1,--1个玉凿
				8020003,1,--20000银币
				8022005,1,--1000礼券
				}




--产生礼包具体的物品列表
function OnGenerateNewItem8005001(ItemID)
	--道具编号8005001-8005008为新手礼包
	if ItemID == 8005001 then
		return creategift(ItemID,GiftTable[1])
	elseif ItemID == 8005002 then
		return creategift(ItemID,GiftTable[2])
	elseif ItemID == 8005003 then
		return creategift(ItemID,GiftTable[3])
	elseif ItemID == 8005004 then
		return creategift(ItemID,GiftTable[4])
	elseif ItemID == 8005005 then
		return creategift(ItemID,GiftTable[5])
	elseif ItemID == 8005006 then
		return creategift(ItemID,GiftTable[6])
	elseif ItemID == 8005007 then
		return creategift(ItemID,GiftTable[7])
	elseif ItemID == 8005008 then
		return creategift(ItemID,GiftTable[8])
	--道具编号8005021-8005027为新手礼包
	elseif ItemID == 8005021 then
		return creategift(ItemID,GiftTable[9])
	elseif ItemID == 8005022 then
		return creategift(ItemID,GiftTable[10])
	elseif ItemID == 8005023 then
		return creategift(ItemID,GiftTable[11])
	elseif ItemID == 8005024 then
		return creategift(ItemID,GiftTable[12])
	elseif ItemID == 8005025 then
		return creategift(ItemID,GiftTable[13])
	elseif ItemID == 8005026 then
		return creategift(ItemID,GiftTable[14])
	elseif ItemID == 8005027 then
		return creategift(ItemID,GiftTable[15])
	end
end

function OnUseItem8005001(ItemID)
	local TempUse = usegift(ItemID)
	return TempUse
end


