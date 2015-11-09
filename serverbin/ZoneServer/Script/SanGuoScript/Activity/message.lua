
local c2s_msg=c2s_msg
local _msgDispatcher = msgDispatcher
local expenseACT_getAwards=expenseACT_getAwards
local _GetPassingLevelActRewards = GetPassingLevelActRewards
local _GetHeroNumsActRewards = GetHeroNumsActRewards
local _GetHeroLevelActRewards = GetHeroLevelActRewards

-- 消费领奖
_msgDispatcher[c2s_msg.act][1] = function ( sid,msg )
	expenseACT_getAwards(sid, msg.index)
end

--通关关卡领奖
_msgDispatcher[c2s_msg.act][6] = function ( sid,msg )
	look("msgDispatcher " .. 6)
	_GetPassingLevelActRewards(sid, msg.index)
end

--武将收集领奖
_msgDispatcher[c2s_msg.act][7] = function ( sid,msg )
	look("msgDispatcher " .. 7)
	_GetHeroNumsActRewards(sid, msg.index)
end

--武将等级提升领奖
_msgDispatcher[c2s_msg.act][8] = function ( sid,msg )
	look("msgDispatcher " .. 8)
	_GetHeroLevelActRewards(sid, msg.index)
end

--全部活动状态刷新
_msgDispatcher[c2s_msg.act][5] = function ( sid,msg )
	OnGetActivityStatus(sid)
end--SI_OnLuaMessage(  playerid, msg )

-- 祈福活动奖励
msgDispatcher[c2s_msg.act][4] = function ( sid,msg )
	GetBlessActReward(sid, msg.index)
end