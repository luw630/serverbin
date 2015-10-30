--[[
file:	player.lua
author:	wk
update:	2015-01-26
desc:	player data init interface
首次登陆(游戏服只会调用一次,之前没有缓存数据,有缓存后不会调) OnPlayerFristLogin 做玩家lua数据初始化以及其他功能处理,playerDataInit之后才能操作玩家数据
上线(玩家每次上线都会调用,有无缓存都调)OnPlayerOnline 玩家上线需要做的处理,例如同步数据给前台
下线 OnPlayerLogout 做lua数据保存处理,并清除dbMgr[sid]数据,可通过dbMgr[sid]==nil判断玩家在不在线
初步预计每5分钟全部玩家data数据保存一次;1小时 保存一次世界公用数据

]]--

local tableName=tostring("data")

--玩家首次登陆调用入口
function OnPlayerFristLogin(sid)
	look('OnPlayerOnline玩家登陆lua调用入口,sid=='..tostring(sid))
	--初始化玩家lua数据,必须放在此函数开头
	playerDataInit( sid )  
	
	if dbMgr[sid]==nil or dbMgr[sid].data==nil then 
		look("playerDataInit fail ,sid="..sid)
		return
	end
	local account=GetPlayerData(0,29)
	db_StaySetOnLogin(account) --登陆时写入数据库,留存用
	PlayerOnlineFriend(sid)
	--CheckAllFirends(sid)
	ActivityOnPlayerLogin(sid)  --玩家登陆触发的活动
	DbDataService_PlayerLogin(sid)  --备份数据中心

	--以下是修复玩家LUA数据所做的临时接口
	db_GetVIPExp(sid) --修复VIP经验
	--db_GetRegTime(sid)
	OnChangeNameCount(sid) --修复改名次数
	set_Ctime(sid) --修复活动账号创建时间
	UpdatePlayerLogin(sid)
	OnUpdataPrayerPointLogin(sid)
	--look(gid)
	--look(GetPlayerData(0,GPP_MYACCOUNT))
	
end
--玩家上线调用入口
function OnPlayerOnline(sid)
	if dbMgr[sid]==nil or dbMgr[sid].data==nil then
		look("OnPlayerOnline fail ,sid="..sid)
		return
	end
	act_login(sid)--玩家登录活动数据修改
	SynInfoFirst(sid)-- 同步玩家一些功能数据给前台
	FillNotificationData()--系统通知的推送
	SynMissionDataToClient(sid)--同步任务的数据到客户端
	SynMissionActivenessDataToClient(sid)--同步任务活跃度数据到客户端
	SynHeroExDataToClient(sid)--同步玩家武将的相关数据到客户端
	SendRewardState(sid)
	SynMembershipDate(sid) --上线同步月卡会员数据
	--Callback_WeekReMoney(sid)--通知客户端玩家的基金信息
	RemoneyActivity:OnTrigger(sid)
	UpdatePlayerLogin(sid)
	OnUpdataPrayerPointLogin(sid)

end

--玩家下线调用入口
function OnPlayerLogout()
	local sid=CI_GetPlayerDataSG(0,0)
	--look('OnPlayerLogout玩家下线lua调用入口,sid=='..tostring(sid))
	if dbMgr[sid]==nil then 
		look('OnPlayerLogout,no player now____sid='..tostring(sid))
		return 
	end
	FriendLogout(sid)--退出通知好友离线

	UpdatePlayerLogOut(sid)

	--保存lua数据,必须放到此函数最后
	SI_savePlayerData(sid,1)

	DbDataService_PlayerLogout(sid)  --备份数据中心


	--look(dbMgr)
end


--玩家定时更新
function OnPlayerDataRefresh(sid)
	if dbMgr[sid]==nil or dbMgr[sid].data==nil then
		look("OnPlayerOnline fail ,sid="..sid)
		return
	end
	act_login(sid)--玩家登录活动数据修改
	SynInfoFirst(sid)-- 同步玩家一些功能数据给前台
	FillNotificationData()--系统通知的推送
	SynMissionDataToClient(sid)--同步任务的数据到客户端
	SynMissionActivenessDataToClient(sid)--同步任务活跃度数据到客户端
	SynHeroExDataToClient(sid)--同步玩家武将的相关数据到客户端
end


--第一次时初始化lua数据
function playerDataInit( sid )
	if dbMgr[sid]==nil then --元方法已初始化为{},若不是,那说明这个玩家c++端没在线
		return false
	end
	if  dbMgr[sid].data==nil  then
		local Pdata = LoadPlayerTable(tableName, sid)
		if Pdata==nil then
			local pdata_temp={[1]=1} --这个版本c++建立新表函数必须至少初始化一个值,即要有长度,后面有机会再优化
			SavePlayerTable(tableName,pdata_temp, sid)
			Pdata = LoadPlayerTable(tableName, sid)
		end
		if Pdata~=nil then --c++玩家数据初始化完成
			dbMgr[sid].data=Pdata
			dbMgr[sid].temp={}
		end
	end
	--look("玩家lua数据初始化成功,sid="..sid)
end
--服务器定时调用,保存玩家数据 ,itype=1代表下线保存数据,且将dbMgr[sid]清空;dbMgr元方法为安全不能直接在lua层置空,0只保存,不清空
function SI_savePlayerData(sid,itype)
	if dbMgr[sid]==nil then 
		look('savePlayerData,no player now____sid='..sid)
		return 
	end
	--保存lua数据
	-- look('保存玩家lua数据')
	if dbMgr[sid].data==nil then 
		look('SI_savePlayerData fail,possible erro:server down and townOn,no player now____sid='..sid)
		return
	end
	--look("SI_savePlayerData  "..sid)
	SavePlayerTable(tableName,dbMgr[sid].data, sid,itype)--c++函数,20150126会增加第4个参数
end


--因前台目前不能支持lua,登陆的时候同步脚本信息给前台 
--[[
	将要发送数据放入dataTb中传给c++;index的增加由功能决定
]]
local dataTb={}
function SynInfoFirst(sid)
	local index = 1
	index = checkin_firstlogin(sid,dataTb,index)--1-4 签到
	index = vip_firstlogin(sid,dataTb,index)--5-7	vip
	index = LOLActivation_firstlogin(sid, dataTb, index)--8-10 一些副本
	index = GetCount(sid,dataTb,index)	-- 11  玩家改名次数
	index = act_firstLogin(sid,dataTb,index) -- 12 - 24 临时活动数据
	index = exdata_firstlogin(sid,dataTb,index)  --25-29 首冲数据，首次武将训练免费的相关数据，新手引导金币是否已经掉落的数据，玩家在服务器的全局ID（供客户端存一些本地数据），玩家打过的过关斩将关卡总数的数据
	
	--数据收集完成后发往c++,必须在最后
	CI_SynPlayerDataSG(dataTb)
end

--判断玩家是否在线
function IsOnline(sid)
	if dbMgr[sid]==nil then 
		return 
	end
	if  dbMgr[sid].data==nil then 
		return
	end
	return true
end

function OnPlayerDecGoods_SG( sid,itype,id,inum ) --玩家扣钱，道具，体力
 	if itype == GoodsType.endurance then   --体力扣除
 		OnFactionDecGoods(sid,itype,id,inum)
 	end
end


