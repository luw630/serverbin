--[[
file:	Friend.lua
author:	Luwei,lpd
update:	2015-09-2
desc:好友系统
]]--
-- tRelationData = 
-- {
-- 	sFriendName = tostring(""),   --好友名
-- 	wHeadIcon = tostring(""),	--头像
-- 	wFriendLevel = 0,		--好友等级
-- 	bRelation = 0,			--关系  0 好友 1 推荐添加的好友 2 等待验证添加的 3 搜索好友 4请求成为好友  
-- }
--自己主动加其他人为好友，需要验证好友名字，玩家是否存在，直接添加在自己的好友列表，同时给好友发送消息  玩家必须在线，以后可以不再线
--这个消息需要包括自己的名字，等级，以及头像。用以离线保存
--当有人加我为好友时，这时应该包含头像，名字，等级这些信息，无论同意否，先保存到待添加中
--当有人加我为好友时，这时添加方可能不再线，就需要以上信息进行添加
--SQAddFriendMsg 0 加好友+带名字 1 请求推荐   2 无		3	搜索好友+名字  4   删除好友+名字 5 请求全部，进入游戏后 6 刷新某个好友状态, 7赠送
--SAAddFriendMsg 0	玩家好友列表   1 推荐给玩家的好友列表 	2 等待确认添加的好友列表  3 返回的搜索列表 


local FriendType =
{
	Friend = 0, --好友
	RecommendFriend = 1, --被推荐的好友
	ToBeAgreed = 2, --等待同意
	SearchFriend = 3 ,--搜索好友
	ApplyFriend = 4--申请成为好友
}
local FriendFailType = 
{
	MyNumIsLimit = 1, --自己好友达到上限  
	HisNumIsLimit = 2,--对方好友达到上限
	RequsetFail = 3,--请求过期
	MyApplyNumIsLimit = 4, --我的申请达到上限
	HisAgreedNumIsLimit = 5,--对方等待审核达到上限
	NORecommond = 6, --没有推荐好友
}


local DataKey = --好友数据枚举
{
	sFriendName = 1,
	wHeadIcon = 2,
	wFriendLevel = 3,
	bRelation = 4, 
	wFightPower = 5,
	bOnlinestate = 6,
	bySendFlag = 7,
	byRecieveFlag = 8,
	dwFriendSid = 9
}



local CheckPlayerOnline = IsOnline

local function Friend_getdata( sid )
	if dbMgr[sid]==nil or  dbMgr[sid].data==nil then 
		return
	end
	if dbMgr[sid].data['friend'] == nil then 
		dbMgr[sid].data['friend'] = 
				{
				}
	end
	return dbMgr[sid].data['friend']
end



 local function GetSendCount(sid) --获取赠送体力次数
	local friendData = Friend_getdata(sid)
	if friendData == nil then
		 return 0
	end

	return friendData[1]
 end
 
 local function GetReceiveCount(sid) --获取领取体力次数
	local friendData = Friend_getdata(sid)
	if friendData == nil then
		 return 0
	end

	return friendData[2]
 end
 


local function GetFriendList(sid) --获取好友列表，获取不到说明玩家不在线
	local friendData = Friend_getdata(sid)
	if friendData == nil then
		 friendData = {}
	end
    return friendData
end

local function FindRelation(mysid,friendsid) --查找好友关系 
	local friendList = GetFriendList(mysid)
	if friendList ~= nil then
		return friendList[friendsid]
	end
	look("can not find relation")
	look(mysid)
	look(friendsid)
	return nil
end


local function CheckFriendsNum(sid)--获取好友个数
	local fnum = 0
	local friendList = GetFriendList(sid)
	if friendList ~= nil then
		for k,v in pairs(friendList) do
		    if type(k) == type(0) and v[DataKey.bRelation] == FriendType.Friend then
				fnum = fnum + 1
			end
		end
	end
	if fnum >= FriendConfig.MaxFriendNum then 
		return false
	end
	return true
end

local function CheckTobeAgreedFriendsNum(sid)--获取等待同意好友个数
	local fnum = 0
	local friendList = GetFriendList(sid)
	if friendList ~= nil then
		for k,v in pairs(friendList) do
		    if type(k) == type(0) and v[DataKey.bRelation] == FriendType.ToBeAgreed then
				fnum = fnum + 1
			end
		end
	end
	if fnum >= FriendConfig.MaxToBeAgreedNum then 
		return false
	end
	return true
end

local function CheckApplayFriendsNum(sid)--获取申请好友个数
	local fnum = 0
	local friendList = GetFriendList(sid)
	if friendList ~= nil then
		for k,v in pairs(friendList) do
		    if type(k) == type(0) and v[DataKey.bRelation] == FriendType.ApplyFriend then
				fnum = fnum + 1
			end
		end
	end
	
	if fnum >= FriendConfig.MaxApplyFriendNum then 
		return false
	end
	
	return true
end



local function CreateRelationData(sid,friendsid,bRelation)--创建好友关系，并加入好友列表
	if CheckPlayerOnline(friendsid) == false then
		return nil
	end
	local friendlist = GetFriendList(sid)	
	if  type(friendlist) ~= "table" then
		return 
	end
	
	local RelationData = {}
	RelationData[DataKey.sFriendName] = CI_GetPlayerDataSG(friendsid,4)
	RelationData[DataKey.wHeadIcon] = CI_GetPlayerDataSG(friendsid,9)
	RelationData[DataKey.wFriendLevel] = CI_GetPlayerDataSG(friendsid,3)
	RelationData[DataKey.bRelation] = bRelation
	RelationData[DataKey.wFightPower] = CI_GetPlayerDataSG(friendsid,8)
	RelationData[DataKey.bOnlinestate] = 1
	RelationData[DataKey.bySendFlag] = 0
	RelationData[DataKey.byRecieveFlag] = 0
	RelationData[DataKey.dwFriendSid] = friendsid
	if bRelation ~= 3 then
		friendlist[friendsid] = RelationData
	end
	return RelationData
end


local function DeleteRelationData( requestid,friendsid ) --删除好友
	
	local friendList = GetFriendList(requestid)
	look("DeleteRelationData")
	local newList = {}
	if friendList ~= nil then
		for k,v in pairs(friendList) do 
			if type(v) == "table" and k ~= friendsid then
				newList[k] = {v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8],v[9]}
			end
		end
		-- look(newList)
		-- look("DeleteRelationData1111111111111")
		dbMgr[requestid].data['friend'] = {}
		dbMgr[requestid].data['friend'] = newList
		-- look("DeleteRelationData222222222222222")
		return true
		
	end
	return 
end


 local function DeleteFriend(mysid, friendSid)
	look("DeleteFriend")
	look(mysid)
	look(friendSid)
	--look(GetFriendList(mysid))
	--look(FindRelation(mysid,friendSid))
	local tRelationData = FindRelation(mysid,friendSid)
	if tRelationData == nil then  --没有找到这个好友，删除失败
		look("Can't Find friends")
		return
	end
	
	if DeleteRelationData(mysid, friendSid) == true then --删除好友
		if CheckPlayerOnline(friendSid) == true then --如果好友在线，好友也删除对应关系
			DeleteRelationData(friendSid, mysid)
			LoadFriendData(friendSid)
		end
	end
	LoadFriendData(mysid)
 end


local function CheckFriendFunc( checkFunc , sid, failType) --检测函数，成功返回ture，失败发送失败消息
	if checkFunc(sid) == false then 
		look("SendFriendFailMsg")
		look(sid)
		look(failType)
		SendFriendFailMsg(sid, failType)
		return false
	end
	return true
end


local function DeleteOneApply( sid ) --删除任意申请

	local friendlist = GetFriendList(sid)
	for k,v in pairs(friendlist) do
		if type(k) == type(0) and v[DataKey.bRelation] == FriendType.ApplyFriend then
			DeleteRelationData(sid, k) 
			break
		end
	end
end

local function SetRelation( sid, friendsid, relationType ) --设置关系，并通知客户端
	local RelationData = FindRelation(sid,friendsid)
	if RelationData == nil then
		RelationData= CreateRelationData(sid, friendsid, relationType)
	else
		RelationData[DataKey.bRelation] = relationType
	end
	look("SetRelation")
	look(sid)
	SendAddFriendToList(sid, RelationData)
end 


local function ApplyFriend(sid, friendsid) --申请添加好友 即关系从1变为4 或者从搜索名字 直接设置好友关系为4 TODO: 返回失败
	look("ApplyFriend")
	if CheckFriendFunc(CheckFriendsNum, sid , FriendFailType.MyNumIsLimit) == true then --检测自己好友数量
		if CheckPlayerOnline(friendsid)  == true  then --检测对方是否在线
			if CheckFriendsNum(friendsid) == true then --检测对方好友数量
				if CheckTobeAgreedFriendsNum(friendsid) == true then --检测对方审核列表是否已满 
					if CheckApplayFriendsNum(sid) == false then --如果申请表已满，则随机删除
						DeleteOneApply(sid)
					end
					SetRelation(sid, friendsid, FriendType.ApplyFriend)
					SetRelation(friendsid, sid, FriendType.ToBeAgreed)
				else
					SendFriendFailMsg(sid, FriendFailType.HisAgreedNumIsLimit)
				end
			else
				SendFriendFailMsg(sid, FriendFailType.HisNumIsLimit)
			end
		else	
			SendFriendFailMsg(sid, FriendFailType.RequsetFail)
		end
	end
end

local function AgreeToBeFriend(sid, friendsid) --同意成为朋友	即好友关系从2变为0
	look("AgreeToBeFriend")
	if FindRelation(friendsid, sid) ~= nil then --检测请求是否过期
		if CheckPlayerOnline(friendsid) == true then --检测对方是否在线
			if CheckFriendFunc(CheckFriendsNum, sid , FriendFailType.MyNumIsLimit) == true then --检测自己好友数量
				if CheckFriendsNum(friendsid) == true then --检测自己好友数量
					SetRelation(sid, friendsid, FriendType.Friend)
					SetRelation(friendsid, sid, FriendType.Friend)
					return
				end
			else
				SendFriendFailMsg(sid,  FriendFailType.HisNumIsLimit)
				DeleteFriend(sid, friendsid)
				return
			end
		end
	end
	SendFriendFailMsg(sid, FriendFailType.RequsetFail)
	DeleteFriend(sid, friendsid)	
end



local function ClearRecommand( playersid ) --清理推荐的好友
	
	local friendList = GetFriendList(playersid)
	local recommendlist = {}
	local num = 0
	local _insert = table.insert
	-- look("dddddddddddddddddd")
	-- look(friendList)
	for k,v in pairs(friendList) do
		-- look(v[DataKey.bRelation])
		-- look( DataKey.RecommendFriend )
		if v[DataKey.bRelation] == FriendType.RecommendFriend and type(k) == "number" then      --推荐的数据
			_insert(recommendlist,k)
			num = num + 1
		end
	end

	if num > 0 then
		-- look("recommendlist")
		-- look(recommendlist)
		for i,j in pairs(recommendlist) do
			DeleteRelationData(playersid,j)
		end
		--look("ClearRecommand  "..num)
	end
end



local function RecommendFriends(playersid) --推荐好友
	local onlineplayer = GetAllPlayerSid()--获取在线玩家
	--look(onlineplayer)
	if onlineplayer == 0 then
		look("Can't Found Players")
		SendFriendFailMsg(sid, FriendFailType.NORecommond)
		return
	end
    
    local recommendlist = {}
    local num = 0
	for k,v in pairs(onlineplayer) do
		--look("CI_GetPlayerDataSG(v,3) ")
		--look(CI_GetPlayerDataSG(v,3) )
		if CI_GetPlayerDataSG(v,3) > FriendConfig.RecommendLevel then
			if v ~= playersid then
				if FindRelation(playersid,v) == nil then  --没有关系
					table.insert(recommendlist,v)
					num = num + 1
				end
			end	
		end
		if num >= FriendConfig.MaxRecommendNum then    --最大数量
			break
		end
	end

	ClearRecommand(playersid)
	if num > 0 then
		for i,j in pairs(recommendlist) do
			CreateRelationData(playersid, j, FriendType.RecommendFriend) --创建推荐好友
		end
		--look(GetFriendList(playersid))
		LoadFriendData(playersid)
		return
	end
	SendFriendFailMsg(playersid, FriendFailType.NORecommond)
	
end





local function SearchFriends(requestid, sFriendName) --搜索好友
	look(requestid.." search firend "..sFriendName )
	local playersid = GetPlayerSidByName(sFriendName)
	if playersid == 0 or playersid == nil then
		look("Player Not Found")
		local tRelationData = {}   --这里创建一个空的玩家好友,表示没有搜索到好友
		tRelationData[DataKey.sFriendName] = ""
		tRelationData[DataKey.wHeadIcon] = 0
		tRelationData[DataKey.wFriendLevel] = 0
		tRelationData[DataKey.bRelation] = 3
		tRelationData[DataKey.wFightPower] = 0
		tRelationData[DataKey.bOnlinestate] = 0
		tRelationData[DataKey.bySendFlag] = 0
		tRelationData[DataKey.byRecieveFlag] = 0
		tRelationData[DataKey.dwFriendSid] = 0
		SendAddFriendToList(requestid,tRelationData)
		
		return
	end
	
	local tRelationData = CreateRelationData(requestid,playersid,FriendType.SearchFriend)
	if tRelationData ~= nil then
		SendAddFriendToList(requestid,tRelationData)
	end	
end
 
 function LoadFriendData(sid) -- 玩家上限，加载好友数据
	local friendList = GetFriendList(sid)
	--local sendcount = get_Exdata(sid,SG_ExDataType.SendStaminaCount)
	local getcount = get_Exdata(sid,SG_ExDataType.GetStaminaCount)
	if friendList ~= nil then
		SendFriendList(sid, 
			0,getcount,FriendConfig.SendStaminaChance,FriendConfig.ReceiveStaminaChance, FriendConfig.StaminaGift , friendList)
	end
 end
 
 

 function UpdateMyOnlineState( mysid, friendsid,bOnlinestate ) --向在线好友更新自己的在线状态
	look("UpdateMyOnlineState")
	if friendsid == 0 or friendsid == nil then
		look("Player Not Found")
		return
	end

	local tRelationData = FindRelation(friendsid,mysid)  --在好友的列表中找到自己，更新在线状态
	if tRelationData ~= nil then
		tRelationData[DataKey.bOnlinestate] = bOnlinestate
		--look("bOnlinestate")
		--look(bOnlinestate)
		SendAddFriendToList(friendsid,tRelationData)
	end
 end
 
 
 local function SendStamina(mysid, friendsid)
	if CheckPlayerOnline(friendsid) == false then
		return
	end
	--local count = get_Exdata(mysid,SG_ExDataType.SendStaminaCount)
	look("SendStamina")
		--判断赠送体力次数是否为0
	-- if count == nil or count  <= 0 then	
	-- 	look("Send Stamina Count is 0")
	-- 	return;
	-- end
	
	local tRelationData = FindRelation(mysid,friendsid)
	if tRelationData == nil then
		look("SendStamina can not find friend")
		return
	end
	if tRelationData[DataKey.bRelation] ~= 0 then --不满足好友关系
		look("SendStamina not real friend ")
		look(mysid)
		look(friendsid)
		return
	end
	if tRelationData[DataKey.bySendFlag] == 1 then --已经送过了
		look("already send stamina")
		look(mysid)
		look(friendsid)
		return
	end
	tRelationData[DataKey.bySendFlag] = 1 --改为不可赠送
	--set_Exdata(mysid, SG_ExDataType.SendStaminaCount, count - 1)--自己赠送次数递减
	SendAddFriendToList(mysid, tRelationData)	--通知客户端更新
	--look(get_Exdata(mysid,SG_ExDataType.SendStaminaCount))
	--通知好友已经赠送给他体力
	local friendRelation = FindRelation(friendsid,mysid)  --在好友的列表中找到自己
	if friendRelation == nil then
		look("SendStamina can not find friend")
		return
	end
	
	friendRelation[DataKey.byRecieveFlag] = 1 --把好友改为可领取我赠送的体力
	SendAddFriendToList(friendsid, friendRelation) --通知好友客户端更新
	
 end
 
 
 local function ReceiveStamina(mysid, friendsid)
	--look("ReceiveStamina")
	local count = get_Exdata(mysid,SG_ExDataType.GetStaminaCount)
	if count == nil or count  <= 0 then	
		look("Get Stamina Count is 0")
		look(mysid)
		return;
	end	
	
	local tRelationData = FindRelation(mysid,friendsid) 
	if tRelationData == nil then
		look("ReceiveStamina can not find friend")
		look(mysid)
		look(friendsid)
		return 
	end
	
	if tRelationData[DataKey.byRecieveFlag] == 0 then
		look(" ReceiveStamina already recieve stamina")
		look(mysid)
		look(friendsid)
		return
	end
	
	tRelationData[DataKey.byRecieveFlag] = 0
	--领取体力以及领取次数递减
	set_Exdata(mysid, SG_ExDataType.GetStaminaCount , count - 1)--自己赠送次数递减
	CI_AddGoods_SG(8,0,FriendConfig.StaminaGift,GoodsWay.StaminaGift, mysid)--体力增加 
	SendAddFriendToList(mysid, tRelationData)	--通知客户端更新
 end
 
 function UpdateFriendData(sid) --刷新好友数据
 	local friendList = GetFriendList(sid)
 	local friendsid 
	for k,v in pairs(friendList) do
		if type(k) == type(0) and CheckPlayerOnline(k) == true then
			friendsid = k 
			if v[DataKey.bRelation] == FriendType.Friend then --如果是好友关系 则更新
				v[DataKey.sFriendName] = CI_GetPlayerDataSG(friendsid,4)
				v[DataKey.wHeadIcon] = CI_GetPlayerDataSG(friendsid,9)
				v[DataKey.wFriendLevel] = CI_GetPlayerDataSG(friendsid,3)
				v[DataKey.wFightPower] = CI_GetPlayerDataSG(friendsid,8)
			end
		end
	end
	local getcount = get_Exdata(sid,SG_ExDataType.GetStaminaCount)
	SendFriendList(sid,0,getcount,0,0,0, friendList)
 end

 function ProcessFriend(mysid,friendsid, sFriendName, bRelation) --处理好友功能请求
	look("sid: "..mysid.."  friendsid:"..friendsid.."   sFriendName:"..sFriendName.."  bRelation:"..bRelation)
	if bRelation == 0 then  -- 申请添加新好友
		ApplyFriend(mysid, friendsid)
	elseif bRelation == 1 then --推荐好友
		RecommendFriends(mysid)
	elseif bRelation == 2 then --同意添加好友
		AgreeToBeFriend(mysid, friendsid)
	elseif bRelation == 3 then -- 搜索好友 
		SearchFriends(mysid, sFriendName)
	elseif bRelation == 4 then -- 删除好友
		DeleteFriend(mysid, friendsid)
	elseif bRelation == 5 then --刷新好友
		--look("Refresh all friend data"..mysid)
		UpdateFriendData(mysid)
		--look(GetFriendList(mysid))
	elseif bRelation == 7 then -- 赠送给好友体力
		SendStamina(mysid, friendsid)
	elseif bRelation == 8 then --领取好友赠送体力
		ReceiveStamina(mysid, friendsid )
	end
end

 function PlayerOnlineFriend(sid) --玩家上线
	look("PlayerOnlineFriend")
	
	local friendList = GetFriendList(sid)
	--look(friendList)
	local friendRelation 
	local deleteList = {}
	local _insert = table.insert
	for k,v in pairs(friendList) do
		if type(k) == type(0) then
			if CheckPlayerOnline(k) == true then--遍历在线好友
				UpdateMyOnlineState( sid, v[DataKey.dwFriendSid],1)  --通知好友更新在线状态
				v[DataKey.bOnlinestate] = 1
				if  v[DataKey.bRelation] == FriendType.Friend or v[DataKey.bRelation] == FriendType.ApplyFriend then --如果是好友，或者请求好友
				 	friendRelation = FindRelation(v[DataKey.dwFriendSid], sid)
				 	if friendRelation == nil then--如果被这个好友删除，则插入删除列表
						_insert( deleteList, k ) 
				 	elseif friendRelation[DataKey.bRelation] == FriendType.Friend  then--如果成为好友
						if CheckFriendsNum(sid) then --好友数量添加
							v[DataKey.bRelation] = FriendType.Friend
						else
							_insert( deleteList, k ) 
						end
				 	end
				end
			else
				v[DataKey.bOnlinestate] = 0
			end
		end
	end
	look('deleteList')
	--look(deleteList)
	for i,j in pairs(deleteList) do 
		DeleteFriend(sid, j)
	end
	
	LoadFriendData(sid)--发送好友数据
 end

 
 function FriendLogout(sid)
--	look("FriendLogout")
	local friendList = GetFriendList(sid)
	if friendList == nil then
		look("if friendList == nil then")
		return
	end
	-- look("FriendLogout")
	-- look(friendList)
	for k,v in pairs(friendList) do
		if type(k) == type(0) then
			if CheckPlayerOnline(k) == true then
			look("UpdateMyOnlineState(sid,k,0)")	
				UpdateMyOnlineState(sid,k,0) 			--同时向在线的好友更新自己的在线状态,退出游戏更新为离线
			end
		end
	end
 end

 
 function ResetFriendData(sid)--重置好友数据
 	look("ResetFriendData")
	local friendList = GetFriendList(sid)
	local newList = {}
	for k,v in pairs(friendList) do --重置好友可赠送状态
		if type(k) == type(0) then
		   if v[DataKey.bRelation] == FriendType.Friend then --重置数据只保留好友数据
              v[DataKey.bySendFlag] = 0
			  v[DataKey.byRecieveFlag] = 0
			  newList[k] = {v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8],v[9]}
		   end
		end
	end
	look(sid)
	look(dbMgr[sid].data['friend'])
	dbMgr[sid].data['friend'] = {}
	dbMgr[sid].data['friend'] = newList
	
	set_Exdata(sid,SG_ExDataType.GetStaminaCount,FriendConfig.ReceiveStaminaChance)
	--set_Exdata(sid, SG_ExDataType.SendStaminaCount,FriendConfig.SendStaminaChance)

 end
 

function MockCreateRelation( sid ,friendsid, reType)
	-- body
	local RelationData = {}
	RelationData[DataKey.sFriendName] = '测试'..sid
	RelationData[DataKey.wHeadIcon] = 108
	RelationData[DataKey.wFriendLevel] = 1
	RelationData[DataKey.bRelation] = reType
	RelationData[DataKey.wFightPower] = 0
	RelationData[DataKey.bOnlinestate] = 0
	RelationData[DataKey.bySendFlag] = 0
	RelationData[DataKey.byRecieveFlag] = 0
	RelationData[DataKey.dwFriendSid] = friendsid
	local  friendlist = GetFriendList(sid)
	friendlist[friendsid] = RelationData
	return RelationData
end
--look(Friend_getdata(1000100020))
 function fff()
	--ProcessFriend(1000100001, 1000100002, "2222", 4)
	-- MockCreateRelation(1000100001, 1, 0)
	-- MockCreateRelation(1000100001, 2, 0)
	-- MockCreateRelation(1000100001, 3, 0)
	-- MockCreateRelation(1000100001, 4, 0)
	-- MockCreateRelation(1000100001, 5, 0)

	-- MockCreateRelation(1000100002, 6, 2)
	-- MockCreateRelation(1000100002, 7, 2)
	-- MockCreateRelation(1000100002, 8, 2)
	-- MockCreateRelation(1000100002, 9, 2)
	-- MockCreateRelation(1000100002, 10, 2)
	
	--look(GetFriendList(1000100011))
	--ProcessFriend(1000100001, 1000100002, "测试", 2)
	-- ProcessFriend(1000100001, 2, "测试", 4)
	-- ProcessFriend(1000100001, 3, "测试", 4)
	-- ProcessFriend(1000100001, 4, "测试", 4)
	-- ProcessFriend(1000100001, 5, "测试", 4)

	--look(GetFriendList(1000100001))
	--ProcessFriend(1000100001, 1000100003, "444", 1)
	--ProcessFriend(1000100001, 1000100003, "444", 2)
	--ProcessFriend(1000100001, 1000100003, "444", 3)
	--ProcessFriend(1000100001, 1000100003, "444", 4)
	--look(GetFriendList(1000100001))
	--dbMgr[sid].data['exdata'][1000100002]
	--ResetFriendData(1000100006)
 end



 