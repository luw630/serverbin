-- ##################################################################

function OnMonsterDead5000()--######晦恶掉落.已废弃
PutPlayerTo(6,110,85,0)
end

function OnMonsterDead5001()--木人巷火工头陀
RunCg(47)
PutPlayerTo(1,65,99,0)
end

function OnMonsterDead5002()--峨嵋派丁敏君
RunCg(37)
PutPlayerTo(2,93,144,0)
end

function OnMonsterDead5003()--冰火岛谢逊
RunCg(66)
PutPlayerTo(9,52,33,0)
end

function OnMonsterDead5004()--星宿海采花子
PutPlayerTo(10,160,52,0)
end

function OnMonsterDead5005()--武当派宋青书
PutPlayerTo(3,28,44,0)
end

function OnMonsterDead5006()--星宿海万年冰蚕
RunCg(510)
PutPlayerTo(5,109,16,0)
end

function OnMonsterDead5007()--######宋远桥掉落.已废弃
PutPlayerTo(3,52,111,0)
end

function OnMonsterDead5010()--金顶蛀虫
GiveGoods(4033,1)
PutPlayerTo(7,160,70,0)
end

--[[
function OnMonsterDead5013()---------星宿海子午虫
local xmap = CreateDynamicRegion(21)
local n, ok = getKillCounter(4020, "子午虫")
  if ok  then
    PutPlayerTo(0,111,146,xmap)
  end
end--]]
--[[
----------
function OnMonsterDead5014()--------------雪狼触发
	local n, ok = getKillCounter(3013, "雪狼")
   local item = CheckItemCount(4005)
	if ok  and (item<=0) then
      local xmap = CreateDynamicRegion(22)
		PutPlayerTo(0,126,95,xmap)
	end
end--]]

function OnMonsterDead5015()-------------雪狼王触发
GiveGoods(4005,1)
PutPlayerTo(9,126,95,0)
end

---------------------------------------------------华山论剑
function OnMonsterDead1000()--------少林派弟子掉落
	local n1, ok1 = getKillCounter(2024, "少林派弟子")
	local n2, ok2 = getKillCounter(3023, "少林派弟子")
	local n3, ok3 = getKillCounter(4029, "少林派弟子")
	local n4, ok4 = getKillCounter(5022, "少林派弟子")
  if ok1 or ok2 or ok3 or ok4 then
    PutPlayerTo(73,17,181,0)
  end
end

function OnMonsterDead1001()--------峨眉派弟子掉落
	local n1, ok1 = getKillCounter(1026, "峨眉派弟子")
	local n2, ok2 = getKillCounter(3024, "峨眉派弟子")
	local n3, ok3 = getKillCounter(4030, "峨眉派弟子")
	local n4, ok4 = getKillCounter(5023, "峨眉派弟子")
  if ok1 or ok2 or ok3 or ok4 then
    PutPlayerTo(73,13,143,0)
  end
end

function OnMonsterDead1002()--------武当派弟子掉落
	local n1, ok1 = getKillCounter(1027, "武当派弟子")
	local n2, ok2 = getKillCounter(2025, "武当派弟子")
	local n3, ok3 = getKillCounter(3025, "武当派弟子")
	local n4, ok4 = getKillCounter(4031, "武当派弟子")
  if ok1 or ok2 or ok3 or ok4 then
    PutPlayerTo(73,13,125,0)
  end
end

function OnMonsterDead1003()--------圣火教弟子掉落
	local n1, ok1 = getKillCounter(1028, "圣火教弟子")
	local n2, ok2 = getKillCounter(2026, "圣火教弟子")
	local n3, ok3 = getKillCounter(4032, "圣火教弟子")
	local n4, ok4 = getKillCounter(5024, "圣火教弟子")
  if ok1 or ok2 or ok3 or ok4 then
    PutPlayerTo(73,17,107,0)
  end
end

function OnMonsterDead1004()--------星宿派弟子掉落
	local n1, ok1 = getKillCounter(1029, "星宿派弟子")
	local n2, ok2 = getKillCounter(2027, "星宿派弟子")
	local n3, ok3 = getKillCounter(3026, "星宿派弟子")
	local n4, ok4 = getKillCounter(5025, "星宿派弟子")
  if ok1 or ok2 or ok3 or ok4 then
    PutPlayerTo(73,11,72,0)
  end
end
