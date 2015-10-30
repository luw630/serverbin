function SendReward() --同步相关的奖励
	for k,v in pairs(RewardTable) do
		if v.RewardList ~= nil then
			if v.CallBackfunc ~= nil then
				if type(v.CallBackfunc) == "function" then
					v.CallBackfunc(v.RewardList)
				end
			end
		end
	end
end



function CallBack_Continu(RewardList) --连续登录back函数
	local PlayerDayInfo = LoadPlayerTable("PlayerDay")
	if PlayerDayInfo == nil then
		rfalse("PlayerDayInfo nil")
		return
	end
	local PlayerReward = LoadPlayerTable("PyContdayReward") --连续登录领取数据 1可以领取未领取 2已经领取 3无法领取
	local RewardLen = table.getn(RewardList)

	local RewardIndex = 1
	if PlayerReward == nil then
		PlayerReward = {}
	end
	for k,v in pairs(RewardList) do
		if k <= PlayerDayInfo.contLogin then			--更新可以领取的礼包
			if PlayerReward[RewardIndex] ~= nil then
				if PlayerReward[RewardIndex] == 3 then
					PlayerReward[RewardIndex] = 1
				end
			else
				PlayerReward[RewardIndex] = 1
			end
		else
			PlayerReward[RewardIndex] = 3
		end

		RewardIndex = RewardIndex + 1
	end	
	SendPlayerReward(1,PlayerReward)
	WeekReturnChargeData("PyContReward",PlayerReward)
end

function UpdateplayerLogin() --?üD?í??òμ???D??￠
	local PlayerDayInfo = LoadPlayerTable("PlayerDay")
	--local PlayerDayInfo = LoadPlayerTable("PlayerDayIn")
	local PlayerChallengData = OnGetPlayerChallengData()   --竞技场数据
  
	if PlayerDayInfo == nil then
		PlayerDayInfo = {}
		PlayerDayInfo.contLogin = 1  --连续登陆
		PlayerDayInfo.totalLogin = 1  --累计登录
	end

	local LastLeavetime = GetPlayerTime(1) --上次离线时间
	local currenttime = GetPlayerTime(3) --当前时间
	local currentLogin = GetPlayerTime(2) --本次登录时间

	local nowdate = tonumber(os.date("%Y%m%d",currenttime))		--现在年月日
	local weekday = tonumber(os.date("%Y%m%d",LastLeavetime))	--离线年月日
	local currentLoginday = tonumber(os.date("%Y%m%d",currentLogin)) --登录时间

	if LastLeavetime > 0 then
		local passday = nowdate - weekday
		if passday > 0 then  --超过1天
			PlayerDayInfo.totalLogin = PlayerDayInfo.totalLogin + 1  --累计登陆+1
			if passday == 1 then
				PlayerDayInfo.contLogin = PlayerDayInfo.contLogin +1  --连续登录+1 ，否则重新计算
			else
				PlayerDayInfo.contLogin = 1
			end

			if PlayerChallengData ~= nil then
				PlayerChallengData.SendConWin = 0   --连胜状态清空
				PlayerChallengData.wConWin = 0 
				PlayerChallengData.bchallengecount = PlayerArenaChallengCount  --挑战次数回复
				WeekReturnChargeData(PlayerArenaData,PlayerChallengData)
				rfalse("ChallengData Init In Login")
			end

		end
	end

	local passtime = nowdate - currentLoginday			--玩家下线取出登录的时间
	if passtime > 0 then		--玩家游戏天数
		PlayerDayInfo.totalLogin = PlayerDayInfo.totalLogin + passtime  --累计登陆++
		if passtime == 1 then
			PlayerDayInfo.contLogin = PlayerDayInfo.contLogin +1    --连续增加
		end
	end
	
	local strtotalLogin = MystringFormat("CURRENTLOGIN",PlayerDayInfo.totalLogin,PlayerDayInfo.contLogin)
	--local strtotalLogin = string.format("累计登陆 %d,连续登陆 %d",PlayerDayInfo.totalLogin,PlayerDayInfo.contLogin)
	if strtotalLogin == 0 or strtotalLogin == nil then
		rfalse("strtotalLogin nil")
	else
		rfalse(strtotalLogin)
		TalkToPlayer(2,strtotalLogin)
	end
	WeekReturnChargeData("PlayerDay",PlayerDayInfo)
	
end

function printtable(table)

	if table == nil or table =={} then
		rfalse("PrintTable table == nil")
		return
	end
	if type(table) == "number" or type(table) == "string" then
		rfalse(""..table.." \r")
		return
	elseif type(table) == "boolean" then
		if table == true then
			rfalse(" true \r")
		else
			rfalse(" false \r")
		end
		return
	end

	--rfalse("tablename:"..tostring(table))
	
	for k,v in pairs(table) do
		if type(v) == "number" or type(v) == "string" then
			rfalse("    ["..k.."]".." = "..v.." ,\r")
		elseif type(v) == "table" then
			rfalse("  ["..k.."]".." = ")
			rfalse("   { \r")
			printtable(v)
			rfalse("   }, \r")
		elseif type(v) == "boolean" then
			if v == true then
				rfalse("    ["..k.."]".." = true ,\r")
			else
				rfalse("    ["..k.."]".." = false ,\r")
			end
		end
	end
	
end


sctest = {}
function ptest( )
	local x = {1,2,3,4,5,6}
	for i=1,5 do
		table.insert(sctest,x)
	end
	printtable(sctest)
	rfalse("\r\n")
	table.remove(sctest,5)
	printtable(sctest)
end


function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function RemoveFromTable(ptable,tablekey)
	if ptable == nil or ptable == {} then
		return
	end
	local keypos = 1
	local isfind = false
	for k,v in pairs(ptable) do
		if k == tablekey then
			isfind = true
			break
		end
		keypos = keypos + 1
	end

	if isfind == true then
		ptable[tablekey] = nil
		table.remove(ptable,keypos)
		--rfalse("RemoveFromTable tablekey = "..tablekey)
	end
end

