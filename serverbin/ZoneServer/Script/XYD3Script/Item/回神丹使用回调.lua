function OnUseItem8040001(ItemID)  --回神丹道具使用
	if ItemID == 8040001 then
		GiveSp(50)
	elseif ItemID == 8040002 then
		GiveSp(90)
	elseif ItemID == 8040003 then
		GiveSp(162)
	elseif ItemID == 8040004 then
		GiveSp(291)
	elseif ItemID == 8040005 then
		GiveSp(523)
	elseif ItemID == 8040006 then
		GiveSp(941)
	elseif ItemID == 8040007 then
		GiveSp(1693)
	elseif ItemID == 8040008 then
		GiveSp(3047)
	elseif ItemID == 8040009 then
		GiveSp(5484)
	elseif ItemID == 8040010 then
		GiveSp(9871)
	end
	return 1
end

function HuiShenDanLimitInfo(ItemID)
	local MaxUseTimeS = 1;			    -- 每天使用的回神丹次数
	local MaxUpdateTimes = 10;			-- 每颗回神丹最大升级次数
	
	LimitForHuiShenDan(MaxUseTimeS, MaxUpdateTimes);
end