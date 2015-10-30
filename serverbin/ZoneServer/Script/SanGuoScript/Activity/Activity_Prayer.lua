 --限时祈福,这里为了控制活动的开启时间已经玩家排行榜的数据保存


local RANKMAX = 100   --排行榜最大记录数
PrayerActivity =  Activitymodule:new()
PrayerActivity:Init(5)
ActivityRegister(PrayerActivity)
local PlayerPrayerList = PrayerActivity:LoadData()	--玩家的积分排行榜



function PrayerActivity:OnTrigger(actParam) --当触发时做的事情,根据需要传递不同的参数，活动不同可以传递不同
	look("MyActivity OnTrigger "..self.ActivityID.."   Type "..self.ActivityType.."   name "..self.ActivityName)
	--self:ChargeGiveItem(100,1000)
end

function PrayerActivity:OnActivityClosed( actParam )--当活动关闭时
	--look("PrayerActivity:OnActivityClosed  "..actParam)
	SendPrayerReward()
end

function PrayerActivity:OnActivityOpened( actParam )----当活动开启时
	--look("PrayerActivity:OnActivityOpened  "..actParam)
	PlayerPrayerList = {}
	self:SaveData(PlayerPrayerList)
end

function GetPrayerActivityName(  ) --活动名称
	local actmodule = ActivityGetmodulebyIndex(1005)  --自己的活动ID，可以定义为枚举方便识别
	if actmodule ~= nil then
		return self.ActivityName
	end
	return nil
end

function OnGetPrayerDayRemain(  ) --获取开启时间
	--local nowdate = tonumber(os.date("%Y%m%d",os.time()))	
	local actmodule = ActivityGetmodulebyIndex(1005)  --自己的活动ID，可以定义为枚举方便识别
	if actmodule ~= nil then
		--local Activitydate = os.time(actmodule.ActivityTime.endtime)
		--look("OnGetPrayerDayRemain  "..Activitydate)
		if actmodule.ActivityEnable == false then
			--look("Prayer Enable false")
			return 0
		else
			local enddate = GetFormatDate(actmodule.ActivityTime.endtime)
			enddate = os.time(enddate)
			local difftime = os.difftime(enddate - os.time())
			difftime = math.ceil(difftime / (60 * 60 * 24)) + 1
			--look(difftime)
			return difftime
		end
	end
end

function GetActivityStartTime( ) --获取活动开启时间
	local actmodule = ActivityGetmodulebyIndex(1005)  --自己的活动ID，可以定义为枚举方便识别
	if actmodule ~= nil then
		local startdate = GetFormatDate(actmodule.ActivityTime.starttime)
		return startdate
	end
	return nil
end



function GetShopCloseTime(  ) --获取商城的关闭剩余时间
	local actmodule = ActivityGetmodulebyIndex(1005)  --自己的活动ID，可以定义为枚举方便识别
	if actmodule ~= nil then
		local enddate = GetFormatDate(actmodule.ActivityTime.endtime)
		enddate = os.time(enddate) + 60 * 60 * 12 			-- 到结束时间的24点活动结束，lua默认时间中午12点，所以增加12个小时
		
		local difftime = os.difftime(enddate - os.time())
		--look(difftime)
		if difftime <= 0 then   --活动已经结束
			difftime = math.abs(difftime)
			local lasttime = PRAYERSHOPCOLSETIME - difftime
			if lasttime >= 0 then
				--look("lasttime  "..lasttime)
				return lasttime
			end
		end
	end
	return 0
end

function InitRankPrayerList( ) --初始化读取以后需要排序依次
	if #PlayerPrayerList > 0 then
		table.sort( PlayerPrayerList,function(t1,t2)return t1.point > t2.point end )
	end
end

function GetPrayerEnable( )
	local actmodule = ActivityGetmodulebyIndex(1005)  --自己的活动ID，可以定义为枚举方便识别
	if actmodule ~= nil then
		return  actmodule.ActivityEnable
	end
	return false
end

function OnPrayerChangeName(sid, oldname,newname ) --玩家改名
	if PlayerPrayerList == nil then
		look("PlayerPrayerList nil")
	end
	local bisupdate = 0

	for k,v in pairs(PlayerPrayerList) do
		if oldname == v.PlayerName then
			v.PlayerName = newname
			bisupdate = 1
			--look("OnPrayerChangeName     "..oldname.."  Change  "..newname)
			break
		end
	end

	if bisupdate == 1 then	
		local actmodule = ActivityGetmodulebyIndex(1005)  --自己的活动ID，可以定义为枚举方便识别
		if actmodule ~= nil then
			actmodule:SaveData(PlayerPrayerList)
		end
	end
end


function OnUpdataPrayerPointLogin(sid) --玩家登陆恢复积分排名
	local PlayerName = CI_GetPlayerDataSG(sid,4)
	local PlayerPoint = GetPrayerPoint(sid,0)
	if PlayerPoint > 0 then
		OnUpdataPrayerPoint(PlayerName,PlayerPoint,0)
	end
end

function OnUpdataPrayerPoint(playername,point,currentrank) --更新玩家祈福积分,在insert 时候直接排序
	if PlayerPrayerList == nil then
		look("PlayerPrayerList nil")
	end

	local Temp = {}
	local ipos = #PlayerPrayerList
	Temp.PlayerName = playername
	Temp.point = point
	--look(Temp)

	local bisupdate = 0

	if GetTableNLenth(PlayerPrayerList) == 0 then
		table.insert(PlayerPrayerList,Temp)
		return #PlayerPrayerList
	else
		for i,v in ipairs(PlayerPrayerList) do
			if playername == v.PlayerName then
				v.point = point
				bisupdate = 1
				break
			end
		end
	end

	if bisupdate == 0 then
		table.insert(PlayerPrayerList,Temp)
	end

	InitRankPrayerList()

	local actmodule = ActivityGetmodulebyIndex(1005)  --自己的活动ID，可以定义为枚举方便识别
	if actmodule ~= nil then
		actmodule:SaveData(PlayerPrayerList)
	end
	look("Ranlist num  "..#PlayerPrayerList)

	return ipos
	
end

function GetPrayerPointRank(  )
	return PlayerPrayerList
end

function GetPrayerPlayerName(rank) --获取对应排名的玩家名字
	if rank > #PlayerPrayerList then
		return nil
	end
	return PlayerPrayerList[rank].PlayerName
end

function GetFormatDate(ftimedate)
	local fTime = {}
	fTime.year = string.sub(ftimedate,1,4)
	fTime.month = string.sub(ftimedate,5,6)
	fTime.day = string.sub(ftimedate,7,8)
	return fTime
end

function StringDate( ftimedate )
	local timedata = tostring(ftimedate.year)..tostring(ftimedate.month)..tostring(ftimedate.day)
	return timedata
end

function  TestRank(  )
	look(PlayerPrayerList)
	-- look(os.clock())
	-- look(os.date())
	-- look(os.time())
	-- local xTime = {}
	-- xTime.year = 2015
	-- xTime.month = 9
	-- xTime.day = 20
	-- local fxTime = os.time(xTime)
	-- local nxTime = tonumber(os.date("%Y%m%d",os.time()))
	-- local fxdata = tonumber(os.date("%Y%m%d",fxTime))
	-- --dfff = dfff / (60 * 60 * 24)
	-- --look(fxTime.."    dfff  "..dfff.."  dfff  "..math.ceil(dfff).."       "..math.floor(dfff))
	-- look("TestRank "..fxdata -nxTime )
end


InitRankPrayerList()


