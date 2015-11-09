
local activeMsg=msgh_s2c_def[s2c_msg.act][5] 
SAVEDATADIFFTIME = 30 * 60    --保存的间隔时间

function ActInit()
	if g_ActivityManager == nil then
		g_ActivityManager = {}
	end

	if g_ActivityStartTime == nil then
		g_ActivityStartTime =os.time()	
	end

	for k,v in pairs(ActivityType) do  --根据触发器类型创建table
		g_ActivityManager[v] = {}     
	end
	
end

function ActivityRegister(activitymod)
	if activitymod ~= nil then
		local  actIndex = activitymod:GetActivityIndex()
		local  actType = activitymod:GetActivityType()
		if g_ActivityManager[actType] ~= nil then
			if g_ActivityManager[actType][actIndex] == nil then
				g_ActivityManager[actType][actIndex] = {}
			end
		end
		g_ActivityManager[actType][actIndex] = activitymod
	end
end

function ActivityGetmodulebyIndex(actIndex)
	if g_ActivityManager == nil then
		return nil
	end
	for k,v in pairs(g_ActivityManager) do
		for i,j in pairs(v) do
			if i == actIndex then
				return j
			end
		end
	end
	return nil
end

function ActOnRun() --循环的活动管理器调用,一些基于时间触发的活动,所有者lua中需要循环定时的全部在这里位置

	local activitymag = {}
	local nowdate = tonumber(os.date("%Y%m%d",os.time()))	
	if g_ActivityManager[ActivityType.LIMITTIME_TRIGGER] ~= nil  then 
		activitymag = g_ActivityManager[ActivityType.LIMITTIME_TRIGGER]
		for k,v in pairs(activitymag) do
			if v.ActivityTime ~= nil then
				if v.ActivityEnable == false then
					if v.ActivityTime.starttime <= nowdate and nowdate <= v.ActivityTime.endtime then
					 	v.ActivityEnable = true
					end
				else
					if v.ActivityTime.starttime > nowdate or nowdate > v.ActivityTime.endtime then
					 	v.ActivityEnable = false	
					end
				end
			end
		end
	end

	if g_ActivityManager[ActivityType.EVERYTIME_TRIGGER] ~= nil then
		activitymag = g_ActivityManager[ActivityType.EVERYTIME_TRIGGER]
	end

	-- for k,v in pairs(g_ActivityManager) do
	-- 	for i,j in pairs(v) do
	-- 		j:OnTrigger()
	-- 	end
	-- end

	ActivitySaveData()
	DbDataService_OnRun()
end

function ActivityEnableCheck( ) --活动开启判断,ActivityEnable == false 也需要判断，可能活动时候还没有到需要定时开启
	--look("ActivityEnableCheck")
	local nowdate = tonumber(os.date("%Y%m%d",os.time()))	
	for k,v in pairs(g_ActivityManager) do
		for i,j in pairs(v) do
			if j.ActivityEnable == true then
				if j.ActivityTime.starttime > nowdate or nowdate > j.ActivityTime.endtime then
					 j.ActivityEnable = false
					 j:OnActivityClosed(j.ActivityID)
					 look("ActivityEnable Closed "..j.ActivityID)
				end
			else
				if j.ActivityTime.starttime <= nowdate and nowdate <= j.ActivityTime.endtime then
					 j.ActivityEnable = true
					 j:OnActivityOpened(j.ActivityID)
					 look("ActivityEnable Opened "..j.ActivityID)
				end
			end

		end
	end
end

function ActivitySaveData( )
	local difftime = os.difftime(os.time() - g_ActivityStartTime)
	if difftime >= SAVEDATADIFFTIME then
		SaveLocalData()
		g_ActivityStartTime =os.time()	
	end
end

function ActivityOnPlayerLogin( sid ) --玩家登陆触发的活动
	-- body
	look(sid .."denglu")
	if g_ActivityManager[ActivityType.LOGIN_TRIGGER] == nil then
		return
	end
	for k,v in pairs(g_ActivityManager[ActivityType.LOGIN_TRIGGER]) do
		if v:GetActivityEnable() == true then
			v:OnTrigger(sid)
		end
	end
end

function ListActivity()
	for k,v in pairs(g_ActivityManager) do
		for i,j in pairs(v) do
			if j.ActivityEnable == true then
				look("OnActivityOpened "..j.ActivityID)
			end
		end
	end
end


function ActivityOnLevelup( sid,level ) --玩家升级后触发
	if g_ActivityManager[ActivityType.LEVEL_TRIGGER] == nil then
		return
	end
	for k,v in pairs(g_ActivityManager[ActivityType.LEVEL_TRIGGER]) do  --多个参数传递table
		if v:GetActivityEnable() == true then
			local plevel = {}
			plevel[sid] = level
			v:OnTrigger(plevel[sid])
		end
	end
end

function ActivityOnCharge(sid, chargeNum) --当玩家充值以后
	if g_ActivityManager[ActivityType.CHARGE_TRIGGER] == nil then
		return
	end
	look("ActivityOnCharge"..sid)
	for k,v in pairs(g_ActivityManager[ActivityType.CHARGE_TRIGGER]) do  --多个参数传递table
		if v:GetActivityEnable() == true then
		look("ActivityOnCharge call ==  true")
			local chargetable={}
			chargetable[sid] = chargeNum
			v:OnTrigger(chargetable)
		end
	end
end

function OnGetActivityStatus(sid,index )
	local activitydata = {}
	for k,v in pairs(g_ActivityManager) do
		for i,j in pairs(v) do
			local temp = {}
			temp.ActivityID = j.ActivityID
			temp.Astarttime = j.ActivityTime.starttime
			temp.Aendtime = j.ActivityTime.endtime
			temp.AEnable = j.ActivityEnable
			table.insert(activitydata,temp)
		end
	end
	-- look("OnGetActivityStatus ")
	-- look(activeMsg)
	-- look(activitydata)
	SendLuaMsg(0,{ids=activeMsg,pdata=activitydata})
	
	--look(activitydata)
end

--当玩家通关某一个普通关卡的时候才会触发的活动
function ActOnPassingLevel(sid, amount)
	if g_ActivityManager[ActivityType.PASSINGLEVEL_TRIGGER] == nil then
		return
	end
	--look("ActOnPassingLevel"..sid)
	for k,v in pairs(g_ActivityManager[ActivityType.PASSINGLEVEL_TRIGGER]) do  --多个参数传递table
		if v:GetActivityEnable() == true then
		--look("ActOnPassingLevel call ==  true")
			local paramtable = {}
			paramtable[sid] = amount
			v:OnTrigger(paramtable)
		end
	end
end

--当玩家的武将等级提升后的才会触发的活动
function ActOnHeroLevelUp(sid, level)
	if g_ActivityManager[ActivityType.HEROLEVEL_INC_TRIGGER] == nil then
		return
	end
	--look("ActOnHeroLevelUp"..sid)
	for k,v in pairs(g_ActivityManager[ActivityType.HEROLEVEL_INC_TRIGGER]) do  --多个参数传递table
		if v:GetActivityEnable() == true then
		--look("ActOnHeroLevelUp call ==  true")
			local paramtable = {}
			paramtable[sid] = level
			v:OnTrigger(paramtable)
		end
	end
end

--当玩家的武将数量发生变化的时候才会触发的活动
function ActOnHeroNumInc(sid, amount)
	if g_ActivityManager[ActivityType.HERONUM_INC_TRIGGER] == nil then
		return
	end
	--look("ActOnHeroNumInc"..sid)
	for k,v in pairs(g_ActivityManager[ActivityType.HERONUM_INC_TRIGGER]) do  --多个参数传递table
		if v:GetActivityEnable() == true then
		--look("ActOnHeroNumInc call ==  true")
			local paramtable = {}
			paramtable[sid] = amount
			v:OnTrigger(paramtable)
		end
	end
end

ActInit()

