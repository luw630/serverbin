function DropPublicFun(monstid)
	--SendBoardCastMsg("怪物ID："..monstid)
	local DropRandom = math.random(1,10000) --怪物死亡后随机掉落1-4个物品。
	--SendBoardCastMsg("随机数："..DropRandom)
	if (DropRandom > 300  and DropRandom <= 1000) then
		monsterdropitem(DropGeneralItem(monstid),1)
	elseif (DropRandom > 1 and DropRandom <= 300) then
		monsterdropitem(DropGeneralItem(monstid),1)
		monsterdropitem(DropGeneralItem(monstid),1)
	end
end

--LevelItemEquipment_White_10
--LevelItemEquipment_Green_10
--LevelItemEquipment_Blue_10
--LevelItemEquipment_Violet_10
--LevelItemEquipment_XK_White_10
--LevelItemEquipment_XK_Green_10
--LevelItemEquipment_XK_Blue_10
--LevelItemEquipment_XK_Violet_10
CommonUp   = 8000
CommonDown = 10000
GeneralUp  = 6000
GeneralDown= 8000
EquipUp    = 0
EquipDown  = 6000


function DropGeneralItem(monstid)
	local MonsterLevel = GetMonsterData(1)
	if (MonsterLevel >0 and MonsterLevel<= 10) then   --掉落10级装备
		local ItemRandom = math.random(1,10000)
		if(ItemRandom > CommonUp and ItemRandom <= CommonDown) then
			ItemID = Common[math.random(1,table.getn(Common))]
			--SendBoardCastMsg("道具ID号："..ItemID);
		elseif(ItemRandom > GeneralUp and ItemRandom <= GeneralDown) then
			ItemID = LevelItemPotion_10[math.random(1,table.getn(LevelItemPotion_10))]
			--SendBoardCastMsg("道具ID号："..ItemID);
		elseif(ItemRandom > EquipUp and ItemRandom <= EquipDown ) then
			local EquipRandom = math.random(1,10000)
			if(EquipRandom > 7000 and EquipRandom <= 10000) then
				ItemID = LevelItemEquipment_White_10[math.random(1,table.getn(LevelItemEquipment_White_10))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 4000 and EquipRandom <= 7000) then
				--ItemID = LevelItemEquipment_XK_White_10[math.random(1,table.getn(LevelItemEquipment_XK_White_10))]
				ItemID = LevelItemEquipment_White_10[math.random(1,table.getn(LevelItemEquipment_White_10))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 2500 and EquipRandom <= 4000) then
				ItemID = LevelItemEquipment_Green_10[math.random(1,table.getn(LevelItemEquipment_Green_10))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 1000 and EquipRandom <= 2500) then
				--ItemID = LevelItemEquipment_XK_Green_10[math.random(1,table.getn(LevelItemEquipment_XK_Green_10))]
				ItemID = LevelItemEquipment_Green_10[math.random(1,table.getn(LevelItemEquipment_Green_10))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 500 and EquipRandom <= 1000) then
				ItemID = LevelItemEquipment_Blue_10[math.random(1,table.getn(LevelItemEquipment_Blue_10))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 20 and EquipRandom <= 500) then
				--ItemID = LevelItemEquipment_XK_Blue_10[math.random(1,table.getn(LevelItemEquipment_XK_Blue_10))]
				ItemID = LevelItemEquipment_Blue_10[math.random(1,table.getn(LevelItemEquipment_Blue_10))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 10 and EquipRandom <= 20) then
				ItemID = LevelItemEquipment_Violet_10[math.random(1,table.getn(LevelItemEquipment_Violet_10))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 1 and EquipRandom <= 10) then
				--ItemID = LevelItemEquipment_XK_Violet_10[math.random(1,table.getn(LevelItemEquipment_XK_Violet_10))]
				ItemID = LevelItemEquipment_Violet_10[math.random(1,table.getn(LevelItemEquipment_Violet_10))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			end
		end
	elseif (MonsterLevel >10 and MonsterLevel<= 20) then  --掉落20级装备
		local ItemRandom = math.random(1,10000)
		if(ItemRandom > CommonUp and ItemRandom <= CommonDown) then
			ItemID = Common[math.random(1,table.getn(Common))]
		--	SendBoardCastMsg("道具ID号："..ItemID);
		elseif(ItemRandom > GeneralUp and ItemRandom <= GeneralDown) then
			ItemID = LevelItemPotion_20[math.random(1,table.getn(LevelItemPotion_20))]
		--	SendBoardCastMsg("道具ID号："..ItemID);
		elseif(ItemRandom > EquipUp and ItemRandom <= EquipDown ) then
			local EquipRandom = math.random(1,10000)
			if(EquipRandom > 7000 and EquipRandom <= 10000) then
				ItemID = LevelItemEquipment_White_20[math.random(1,table.getn(LevelItemEquipment_White_20))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 4000 and EquipRandom <= 7000) then
				--ItemID = LevelItemEquipment_XK_White_20[math.random(1,table.getn(LevelItemEquipment_XK_White_20))]
				ItemID = LevelItemEquipment_White_20[math.random(1,table.getn(LevelItemEquipment_White_20))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 2500 and EquipRandom <= 4000) then
				ItemID = LevelItemEquipment_Green_20[math.random(1,table.getn(LevelItemEquipment_Green_20))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 1000 and EquipRandom <= 2500) then
				--ItemID = LevelItemEquipment_XK_Green_20[math.random(1,table.getn(LevelItemEquipment_XK_Green_20))]
				ItemID = LevelItemEquipment_Green_20[math.random(1,table.getn(LevelItemEquipment_Green_20))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 500 and EquipRandom <= 1000) then
				ItemID = LevelItemEquipment_Blue_20[math.random(1,table.getn(LevelItemEquipment_Blue_20))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 20 and EquipRandom <= 500) then
				--ItemID = LevelItemEquipment_XK_Blue_20[math.random(1,table.getn(LevelItemEquipment_XK_Blue_20))]
				ItemID = LevelItemEquipment_Blue_20[math.random(1,table.getn(LevelItemEquipment_Blue_20))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 10 and EquipRandom <= 20) then
				ItemID = LevelItemEquipment_Violet_20[math.random(1,table.getn(LevelItemEquipment_Violet_20))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 1 and EquipRandom <= 10) then
				--ItemID = LevelItemEquipment_XK_Violet_20[math.random(1,table.getn(LevelItemEquipment_XK_Violet_20))]
				ItemID = LevelItemEquipment_Violet_20[math.random(1,table.getn(LevelItemEquipment_Violet_20))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			end
		end
	elseif (MonsterLevel >20 and MonsterLevel<= 30) then  --掉落30级装备
		local ItemRandom = math.random(1,10000)
		if(ItemRandom > CommonUp and ItemRandom <= CommonDown) then
			ItemID = Common[math.random(1,table.getn(Common))]
		--	SendBoardCastMsg("道具ID号："..ItemID);
		elseif(ItemRandom > GeneralUp and ItemRandom <= GeneralDown) then
			ItemID = LevelItemPotion_30[math.random(1,table.getn(LevelItemPotion_30))]
		--	SendBoardCastMsg("道具ID号："..ItemID);
		elseif(ItemRandom > EquipUp and ItemRandom <= EquipDown ) then
			local EquipRandom = math.random(1,10000)
			if(EquipRandom > 7000 and EquipRandom <= 10000) then
				ItemID = LevelItemEquipment_White_30[math.random(1,table.getn(LevelItemEquipment_White_30))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 4000 and EquipRandom <= 7000) then
				--ItemID = LevelItemEquipment_XK_White_30[math.random(1,table.getn(LevelItemEquipment_XK_White_30))]
				ItemID = LevelItemEquipment_White_30[math.random(1,table.getn(LevelItemEquipment_White_30))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 2500 and EquipRandom <= 4000) then
				ItemID = LevelItemEquipment_Green_30[math.random(1,table.getn(LevelItemEquipment_Green_30))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 1000 and EquipRandom <= 2500) then
				--ItemID = LevelItemEquipment_XK_Green_30[math.random(1,table.getn(LevelItemEquipment_XK_Green_30))]
				ItemID = LevelItemEquipment_Green_30[math.random(1,table.getn(LevelItemEquipment_Green_30))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 500 and EquipRandom <= 1000) then
				ItemID = LevelItemEquipment_Blue_30[math.random(1,table.getn(LevelItemEquipment_Blue_30))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 20 and EquipRandom <= 500) then
				--ItemID = LevelItemEquipment_XK_Blue_30[math.random(1,table.getn(LevelItemEquipment_XK_Blue_30))]
				ItemID = LevelItemEquipment_Blue_30[math.random(1,table.getn(LevelItemEquipment_Blue_30))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 10 and EquipRandom <= 20) then
				ItemID = LevelItemEquipment_Violet_30[math.random(1,table.getn(LevelItemEquipment_Violet_30))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 1 and EquipRandom <= 10) then
				--ItemID = LevelItemEquipment_XK_Violet_30[math.random(1,table.getn(LevelItemEquipment_XK_Violet_30))]
				ItemID = LevelItemEquipment_Violet_30[math.random(1,table.getn(LevelItemEquipment_Violet_30))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			end
		end
	elseif (MonsterLevel >30 and MonsterLevel<= 40) then  --掉落40级装备
		local ItemRandom = math.random(1,10000)
		if(ItemRandom > CommonUp and ItemRandom <= CommonDown) then
			ItemID = Common[math.random(1,table.getn(Common))]
		--	SendBoardCastMsg("道具ID号："..ItemID);
		elseif(ItemRandom > GeneralUp and ItemRandom <= GeneralDown) then
			ItemID = LevelItemPotion_40[math.random(1,table.getn(LevelItemPotion_40))]
		--	SendBoardCastMsg("道具ID号："..ItemID);
		elseif(ItemRandom > EquipUp and ItemRandom <= EquipDown ) then
			local EquipRandom = math.random(1,10000)
			if(EquipRandom > 7000 and EquipRandom <= 10000) then
				ItemID = LevelItemEquipment_White_40[math.random(1,table.getn(LevelItemEquipment_White_40))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 4000 and EquipRandom <= 7000) then
				--ItemID = LevelItemEquipment_XK_White_40[math.random(1,table.getn(LevelItemEquipment_XK_White_40))]
				ItemID = LevelItemEquipment_White_40[math.random(1,table.getn(LevelItemEquipment_White_40))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 2500 and EquipRandom <= 4000) then
				ItemID = LevelItemEquipment_Green_40[math.random(1,table.getn(LevelItemEquipment_Green_40))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 1000 and EquipRandom <= 2500) then
				--ItemID = LevelItemEquipment_XK_Green_40[math.random(1,table.getn(LevelItemEquipment_XK_Green_40))]
				ItemID = LevelItemEquipment_Green_40[math.random(1,table.getn(LevelItemEquipment_Green_40))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 500 and EquipRandom <= 1000) then
				ItemID = LevelItemEquipment_Blue_40[math.random(1,table.getn(LevelItemEquipment_Blue_40))]
				SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 20 and EquipRandom <= 500) then
				--ItemID = LevelItemEquipment_XK_Blue_40[math.random(1,table.getn(LevelItemEquipment_XK_Blue_40))]
				ItemID = LevelItemEquipment_Blue_40[math.random(1,table.getn(LevelItemEquipment_Blue_40))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 10 and EquipRandom <= 20) then
				ItemID = LevelItemEquipment_Violet_40[math.random(1,table.getn(LevelItemEquipment_Violet_40))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 1 and EquipRandom <= 10) then
				--ItemID = LevelItemEquipment_XK_Violet_40[math.random(1,table.getn(LevelItemEquipment_XK_Violet_40))]
				ItemID = LevelItemEquipment_Violet_40[math.random(1,table.getn(LevelItemEquipment_Violet_40))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			end
		end
	elseif (MonsterLevel >40 and MonsterLevel<= 50) then  --掉落50级装备
		local ItemRandom = math.random(1,10000)
		if(ItemRandom > CommonUp and ItemRandom <= CommonDown) then
			ItemID = Common[math.random(1,table.getn(Common))]
		--	SendBoardCastMsg("道具ID号："..ItemID);
		elseif(ItemRandom > GeneralUp and ItemRandom <= GeneralDown) then
			ItemID = LevelItemPotion_50[math.random(1,table.getn(LevelItemPotion_50))]
		--	SendBoardCastMsg("道具ID号："..ItemID);
		elseif(ItemRandom > EquipUp and ItemRandom <= EquipDown ) then
			local EquipRandom = math.random(1,10000)
			if(EquipRandom > 7000 and EquipRandom <= 10000) then
				ItemID = LevelItemEquipment_White_50[math.random(1,table.getn(LevelItemEquipment_White_50))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 4000 and EquipRandom <= 7000) then
				--ItemID = LevelItemEquipment_XK_White_50[math.random(1,table.getn(LevelItemEquipment_XK_White_50))]
				ItemID = LevelItemEquipment_White_50[math.random(1,table.getn(LevelItemEquipment_White_50))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 2500 and EquipRandom <= 4000) then
				ItemID = LevelItemEquipment_Green_50[math.random(1,table.getn(LevelItemEquipment_Green_50))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 1000 and EquipRandom <= 2500) then
				--ItemID = LevelItemEquipment_XK_Green_50[math.random(1,table.getn(LevelItemEquipment_XK_Green_50))]
				ItemID = LevelItemEquipment_Green_50[math.random(1,table.getn(LevelItemEquipment_Green_50))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 500 and EquipRandom <= 1000) then
				ItemID = LevelItemEquipment_Blue_50[math.random(1,table.getn(LevelItemEquipment_Blue_50))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 20 and EquipRandom <= 500) then
				--ItemID = LevelItemEquipment_XK_Blue_50[math.random(1,table.getn(LevelItemEquipment_XK_Blue_50))]
				ItemID = LevelItemEquipment_Blue_50[math.random(1,table.getn(LevelItemEquipment_Blue_50))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 10 and EquipRandom <= 20) then
				ItemID = LevelItemEquipment_Violet_50[math.random(1,table.getn(LevelItemEquipment_Violet_50))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 1 and EquipRandom <= 10) then
				--ItemID = LevelItemEquipment_XK_Violet_50[math.random(1,table.getn(LevelItemEquipment_XK_Violet_50))]
				ItemID = LevelItemEquipment_Violet_50[math.random(1,table.getn(LevelItemEquipment_Violet_50))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			end
		end
	elseif (MonsterLevel >50 and MonsterLevel<= 60) then  --掉落60级装备
		local ItemRandom = math.random(1,10000)
		if(ItemRandom > CommonUp and ItemRandom <= CommonDown) then
			ItemID = Common[math.random(1,table.getn(Common))]
		--	SendBoardCastMsg("道具ID号："..ItemID);
		elseif(ItemRandom > GeneralUp and ItemRandom <= GeneralDown) then
			ItemID = LevelItemPotion_60[math.random(1,table.getn(LevelItemPotion_60))]
		--	SendBoardCastMsg("道具ID号："..ItemID);
		elseif(ItemRandom > EquipUp and ItemRandom <= EquipDown ) then
			local EquipRandom = math.random(1,10000)
			if(EquipRandom > 7000 and EquipRandom <= 10000) then
				ItemID = LevelItemEquipment_White_60[math.random(1,table.getn(LevelItemEquipment_White_60))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 4000 and EquipRandom <= 7000) then
				--ItemID = LevelItemEquipment_XK_White_60[math.random(1,table.getn(LevelItemEquipment_XK_White_60))]
				ItemID = LevelItemEquipment_White_60[math.random(1,table.getn(LevelItemEquipment_White_60))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 2500 and EquipRandom <= 4000) then
				ItemID = LevelItemEquipment_Green_60[math.random(1,table.getn(LevelItemEquipment_Green_60))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 1000 and EquipRandom <= 2500) then
				--ItemID = LevelItemEquipment_XK_Green_60[math.random(1,table.getn(LevelItemEquipment_XK_Green_60))]
				ItemID = LevelItemEquipment_Green_60[math.random(1,table.getn(LevelItemEquipment_Green_60))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 500 and EquipRandom <= 1000) then
				ItemID = LevelItemEquipment_Blue_60[math.random(1,table.getn(LevelItemEquipment_Blue_60))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 20 and EquipRandom <= 500) then
				--ItemID = LevelItemEquipment_XK_Blue_60[math.random(1,table.getn(LevelItemEquipment_XK_Blue_60))]
				ItemID = LevelItemEquipment_Blue_60[math.random(1,table.getn(LevelItemEquipment_Blue_60))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 10 and EquipRandom <= 20) then
				ItemID = LevelItemEquipment_Violet_60[math.random(1,table.getn(LevelItemEquipment_Violet_60))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 1 and EquipRandom <= 10) then
				--ItemID = LevelItemEquipment_XK_Violet_60[math.random(1,table.getn(LevelItemEquipment_XK_Violet_60))]
				ItemID = LevelItemEquipment_Violet_60[math.random(1,table.getn(LevelItemEquipment_Violet_60))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			end
		end
	elseif (MonsterLevel >60 and MonsterLevel<= 65) then  --掉落65级装备
		local ItemRandom = math.random(1,10000)
		if(ItemRandom > CommonUp and ItemRandom <= CommonDown) then
			ItemID = Common[math.random(1,table.getn(Common))]
		--	SendBoardCastMsg("道具ID号："..ItemID);
		elseif(ItemRandom > GeneralUp and ItemRandom <= GeneralDown) then
			ItemID = LevelItemPotion_65[math.random(1,table.getn(LevelItemPotion_65))]
		--	SendBoardCastMsg("道具ID号："..ItemID);
		elseif(ItemRandom > EquipUp and ItemRandom <= EquipDown ) then
			local EquipRandom = math.random(1,10000)
			if(EquipRandom > 7000 and EquipRandom <= 10000) then
				ItemID = LevelItemEquipment_White_65[math.random(1,table.getn(LevelItemEquipment_White_65))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 4000 and EquipRandom <= 7000) then
				--ItemID = LevelItemEquipment_XK_White_65[math.random(1,table.getn(LevelItemEquipment_XK_White_65))]
				ItemID = LevelItemEquipment_White_65[math.random(1,table.getn(LevelItemEquipment_White_65))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 2500 and EquipRandom <= 4000) then
				ItemID = LevelItemEquipment_Green_65[math.random(1,table.getn(LevelItemEquipment_Green_65))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 1000 and EquipRandom <= 2500) then
				--ItemID = LevelItemEquipment_XK_Green_65[math.random(1,table.getn(LevelItemEquipment_XK_Green_65))]
				ItemID = LevelItemEquipment_Green_65[math.random(1,table.getn(LevelItemEquipment_Green_65))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 500 and EquipRandom <= 1000) then
				ItemID = LevelItemEquipment_Blue_65[math.random(1,table.getn(LevelItemEquipment_Blue_65))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 20 and EquipRandom <= 500) then
				--ItemID = LevelItemEquipment_XK_Blue_65[math.random(1,table.getn(LevelItemEquipment_XK_Blue_65))]
				ItemID = LevelItemEquipment_Blue_65[math.random(1,table.getn(LevelItemEquipment_Blue_65))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 10 and EquipRandom <= 20) then
				ItemID = LevelItemEquipment_Violet_65[math.random(1,table.getn(LevelItemEquipment_Violet_65))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 1 and EquipRandom <= 10) then
				--ItemID = LevelItemEquipment_XK_Violet65[math.random(1,table.getn(LevelItemEquipment_XK_Violet65))]
				ItemID = LevelItemEquipment_Violet_65[math.random(1,table.getn(LevelItemEquipment_Violet_65))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			end
		end
	elseif (MonsterLevel >65 and MonsterLevel<= 70) then  --掉落70级装备
		local ItemRandom = math.random(1,10000)
		if(ItemRandom > CommonUp and ItemRandom <= CommonDown) then
			ItemID = Common[math.random(1,table.getn(Common))]
		--	SendBoardCastMsg("道具ID号："..ItemID);
		elseif(ItemRandom > GeneralUp and ItemRandom <= GeneralDown) then
			ItemID = LevelItemPotion_70[math.random(1,table.getn(LevelItemPotion_70))]
		--	SendBoardCastMsg("道具ID号："..ItemID);
		elseif(ItemRandom > EquipUp and ItemRandom <= EquipDown ) then
			local EquipRandom = math.random(1,10000)
			if(EquipRandom > 7000 and EquipRandom <= 10000) then
				ItemID = LevelItemEquipment_White_65[math.random(1,table.getn(LevelItemEquipment_White_65))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 4000 and EquipRandom <= 7000) then
				--ItemID = LevelItemEquipment_XK_White_65[math.random(1,table.getn(LevelItemEquipment_XK_White_65))]
				ItemID = LevelItemEquipment_White_65[math.random(1,table.getn(LevelItemEquipment_White_65))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 2500 and EquipRandom <= 4000) then
				ItemID = LevelItemEquipment_Green_65[math.random(1,table.getn(LevelItemEquipment_Green_65))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 1000 and EquipRandom <= 2500) then
				--ItemID = LevelItemEquipment_XK_Green_65[math.random(1,table.getn(LevelItemEquipment_XK_Green_65))]
				ItemID = LevelItemEquipment_Green_65[math.random(1,table.getn(LevelItemEquipment_Green_65))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 500 and EquipRandom <= 1000) then
				ItemID = LevelItemEquipment_Blue_65[math.random(1,table.getn(LevelItemEquipment_Blue_65))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 20 and EquipRandom <= 500) then
				--ItemID = LevelItemEquipment_XK_Blue_65[math.random(1,table.getn(LevelItemEquipment_XK_Blue_65))]
				ItemID = LevelItemEquipment_Blue_65[math.random(1,table.getn(LevelItemEquipment_Blue_65))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 10 and EquipRandom <= 20) then
				ItemID = LevelItemEquipment_Violet_65[math.random(1,table.getn(LevelItemEquipment_Violet_65))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 1 and EquipRandom <= 10) then
				--ItemID = LevelItemEquipment_XK_Violet_65[math.random(1,table.getn(LevelItemEquipment_XK_Violet_65))]
				ItemID = LevelItemEquipment_Violet_65[math.random(1,table.getn(LevelItemEquipment_Violet_65))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			end
		end
	elseif (MonsterLevel >70 and MonsterLevel<= 75) then  --掉落75级装备
		local ItemRandom = math.random(1,10000)
		if(ItemRandom > CommonUp and ItemRandom <= CommonDown) then
			ItemID = Common[math.random(1,table.getn(Common))]
		--	SendBoardCastMsg("道具ID号："..ItemID);
		elseif(ItemRandom > GeneralUp and ItemRandom <= GeneralDown) then
			ItemID = LevelItemPotion_75[math.random(1,table.getn(LevelItemPotion_75))]
		--	SendBoardCastMsg("道具ID号："..ItemID);
		elseif(ItemRandom > EquipUp and ItemRandom <= EquipDown ) then
			local EquipRandom = math.random(1,10000)
			if(EquipRandom > 7000 and EquipRandom <= 10000) then
				ItemID = LevelItemEquipment_White_65[math.random(1,table.getn(LevelItemEquipment_White_65))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 4000 and EquipRandom <= 7000) then
				--ItemID = LevelItemEquipment_XK_White_65[math.random(1,table.getn(LevelItemEquipment_XK_White_65))]
				ItemID = LevelItemEquipment_White_65[math.random(1,table.getn(LevelItemEquipment_White_65))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 2500 and EquipRandom <= 4000) then
				ItemID = LevelItemEquipment_Green_65[math.random(1,table.getn(LevelItemEquipment_Green_65))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 1000 and EquipRandom <= 2500) then
				--ItemID = LevelItemEquipment_XK_Green_65[math.random(1,table.getn(LevelItemEquipment_XK_Green_65))]
				ItemID = LevelItemEquipment_Green_65[math.random(1,table.getn(LevelItemEquipment_Green_65))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 500 and EquipRandom <= 1000) then
				ItemID = LevelItemEquipment_Blue_65[math.random(1,table.getn(LevelItemEquipment_Blue_65))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 20 and EquipRandom <= 500) then
				--ItemID = LevelItemEquipment_XK_Blue_65[math.random(1,table.getn(LevelItemEquipment_XK_Blue_65))]
				ItemID = LevelItemEquipment_Blue_65[math.random(1,table.getn(LevelItemEquipment_Blue_65))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 10 and EquipRandom <= 20) then
				ItemID = LevelItemEquipment_Violet_65[math.random(1,table.getn(LevelItemEquipment_Violet_65))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			elseif(EquipRandom > 1 and EquipRandom <= 10) then
				--ItemID = LevelItemEquipment_XK_Violet_65[math.random(1,table.getn(LevelItemEquipment_XK_Violet_65))]
				ItemID = LevelItemEquipment_Violet_65[math.random(1,table.getn(LevelItemEquipment_Violet_65))]
			--	SendBoardCastMsg("道具ID号："..ItemID);
			end
		end
	end

	return ItemID
end








