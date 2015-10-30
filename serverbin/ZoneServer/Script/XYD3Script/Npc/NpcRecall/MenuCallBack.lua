function ClickMenu9(index)       	----测试NPC
	--rfalse("ClickMenu9 index = "..index)
	if index == 1 then
	   GiveExp(10000000)
	elseif index == 2 then
	  GiveGoods(3450001,99)
	  GiveGoods(3450002,99)
	   GiveGoods(2110001,99)
	   GiveGoods(2110002,99)
	   GiveGoods(2110003,99)
	   GiveGoods(130108,1)
	elseif index == 3 then
		--OnRecvBeginRefineStar(0,0,15)
		-- local gid = GetPlayerData(0,GPP_QUANJUGID)
		-- ChangeObjectData(gid,GPP_CURTP,-5)
		-- local currenttp = GetPlayerData(0,GPP_CURTP)
		-- rfalse("currenttp = "..currenttp)
	end
end
function ClickMenu1(index)       	----测试商店
end

function ClickMenu8(index)
	if index == 1 then
		PutPlayerTo(4,218.43,59.06)
	end
end

function ClickMenu9(index)
	if index == 1 then
		PutPlayerTo(1001,82.22,166.28)
	end
end

function ClickMenu16(index)
	if index == 1 then
		PutPlayerTo(5,445.78,138)
	end
end
function ClickMenu298(index)
	if(index == 1) then
	   PutPlayerToDynamicRegion(10000,100,80,103)
	end
	if(index == 2) then
	   PutPlayerToDynamicRegion(10001,100,80,103)
	end
end