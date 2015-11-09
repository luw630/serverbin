--[[
file:	playerModifyCallBack.lua
author:	lpd
update:	2015-07-9
desc:	player data modify call back function
]]--


function OnPlayerLevelUp(sid, level) --玩家升级的lua回调
	ActivityOnLevelup(sid, level)--玩家升级的活动回调
	rank_update(sid,4,level) --等级榜更新
end

function OnChagreSuccess(sid, chargeNum) --充值成功回调
	ActivityOnCharge(sid, chargeNum) --玩家充值成功后活动回调
	SetRechargeFlag(sid, 0) --重置充值标识
end

function OnPlayerChangeName(sid,oldName, newName) -- 玩家改名回调,(sid,现在name)
	PlayerChangeNameInFaction(sid,oldName,newName)
	OnPrayerChangeName(sid,oldName,newName)
end

function OnLoginRefresh(sid, refreshType) --登录时的刷新，refreshType = 5指的是 5点钟的数据刷新
	if refreshType == 5 then
		ResetFriendData(sid) --重置好友数据
	end
end

--玩家的某个武将升级后触发的回调
function OnHeroLevelUp(sid, heroID, level)
	--武将升级的相关的活动
	ActOnHeroLevelUp(sid, level)
end