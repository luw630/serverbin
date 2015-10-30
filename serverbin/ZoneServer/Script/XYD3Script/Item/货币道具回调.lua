function OnUseItem8020001(ItemID)  --银币票道具使用
	if ItemID == 8020001 then
		GiveMoney(1,5000)
	elseif ItemID == 8020002 then
		GiveMoney(1,10000)
	elseif ItemID == 8020003 then
		GiveMoney(1,20000)
	end
	return 1
end

function OnUseItem8021001(ItemID)  --银两票道具使用
	if ItemID == 8021001 then
		GiveMoney(2,1000)
	elseif ItemID == 8021002 then
		GiveMoney(2,2000)
	elseif ItemID == 8021003 then
		GiveMoney(2,5000)
	elseif ItemID == 8021004 then
		GiveMoney(2,10000)
	end
	return 1
end

function OnUseItem8022001(ItemID)  --礼券道具使用
	if ItemID == 8022001 then
		GiveMoney(3,10)
	elseif ItemID == 8022002 then
		GiveMoney(3,20)
	elseif ItemID == 8022003 then
		GiveMoney(3,50)
	elseif ItemID == 8022004 then
		GiveMoney(3,100)
	elseif ItemID == 8022005 then
		GiveMoney(3,1000)
	end
	return 1
end

function  OnUseItem8022006(ItemID)  --礼券卡使用
local suiji = math.random(1,100) --随机
	 if(suiji <= 19)then
		GiveMoney(3,1)
		TalkToPlayer(2,"恭喜获得1点礼券！")
	 elseif	(suiji >= 20 and suiji <= 36)then
		GiveMoney(3,2)
		TalkToPlayer(2,"恭喜获得2点礼券！")
	 elseif	(suiji >= 37 and suiji <= 51)then
		GiveMoney(3,3)
		TalkToPlayer(2,"恭喜获得3点礼券！")
	 elseif	(suiji >= 52 and suiji <= 64)then
		GiveMoney(3,4)
		TalkToPlayer(2,"恭喜获得4点礼券！")
	 elseif	(suiji >= 65 and suiji <= 75)then
		GiveMoney(3,5)
		TalkToPlayer(2,"恭喜获得5点礼券！")
	 elseif	(suiji >= 76 and suiji <= 84)then
		GiveMoney(3,6)
		TalkToPlayer(2,"恭喜获得6点礼券！")
	 elseif	(suiji >= 85 and suiji <= 91)then
		GiveMoney(3,7)
		TalkToPlayer(2,"恭喜获得7点礼券！")
	 elseif	(suiji >= 92 and suiji <= 96)then
		GiveMoney(3,8)
		TalkToPlayer(2,"恭喜获得8点礼券！")
	 elseif	(suiji >= 97 and suiji <= 99)then
		GiveMoney(3,9)
		TalkToPlayer(2,"恭喜获得9点礼券！")
	 elseif	(suiji == 100)then
		GiveMoney(3,10)
		TalkToPlayer(2,"恭喜获得10点礼券！")
	 end
	return 1
end
