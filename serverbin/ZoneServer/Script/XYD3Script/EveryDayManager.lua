---------------------------------------------------------------------------------------------------
--日常时间管理器
EveryDayTimePoint = {000000,235959} --7点0分0秒，写作070000|必须按时间顺序填写


function EveryDayManagerRun()
	local timeCheck = ReadEveryDayManagerTime()
	local nIndex = GetEveryDayPoint(timeCheck)
	if(nIndex > 0) then
		rfalse("EveryDay Reset Index : "..nIndex)
		WriteEveryDayManagerTime(os.time())		
	end	
	return nIndex;
end

function GetEveryDayPoint(timeCheck) --选出第一个符合条件的时间点（一次只能判断一个时间点）
	local now = os.time()
	local today = os.date("*t")
	local Count = table.getn(EveryDayTimePoint)
	for i=1,Count do
		local tab = {year=today.year, month=today.month, day=today.day,
			hour=	string.sub(EveryDayTimePoint[i],-6,-5),
			min=	string.sub(EveryDayTimePoint[i],-4,-3),
			sec=	string.sub(EveryDayTimePoint[i],-2,-1),
			isdst=false}
		local TimePoint = os.time(tab)
		
		if(now>TimePoint and TimePoint>timeCheck) then --重置时间判断
			return i
		end
	end
	
	return 0
end

function GetEveryDayPointByIndex(timeCheck, nIndex) --判断指定的时间点是否到点了
	local now = os.time()
	local today = os.date("*t")
	local Count = table.getn(EveryDayTimePoint)
	local tab = {year=today.year, month=today.month, day=today.day,
		hour=	string.sub(EveryDayTimePoint[nIndex],-6,-5),
		min=	string.sub(EveryDayTimePoint[nIndex],-4,-3),
		sec=	string.sub(EveryDayTimePoint[nIndex],-2,-1),
		isdst=false}
	local TimePoint = os.time(tab)
		
	if(now>TimePoint and TimePoint>timeCheck) then --重置时间判断
		return nIndex		--返回重置点的编号
	end
	
	return 0
end

function PlayerEveryDayRun(nIndex)
	if(nIndex==1) then
		ResetCountDown()
	end
	if(nIndex==2) then
	end

	ProcessEveryDay()
end

--玩家登录，日常时间管理器都会调用这个函数
function ProcessEveryDay()	
	SendCountDownGiftList() --发送倒计时奖励列表
	SendLoginGiftList()		--发送连续登录奖励
	--SendOnlineGiftList()	--发送在线奖励列表
	--SendLevelGiftList()		--发送等级奖励
end
---------------------------------------------------------------------------------------------------
