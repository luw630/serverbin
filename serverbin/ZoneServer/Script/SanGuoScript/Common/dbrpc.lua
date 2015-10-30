--[[
file:	dbrpc.lua
desc:	all db rpc call.
author:	wk
update:	2015-03-20
]]--
--[[
dbtype的定义：
0 	- DB库单线程不可并发RPC
1	- 中心库单线程不可并发RPC

回调 |100--单列  #100--2维数组 ?4--第4个数
]]--
--DBRPC( __call,__callback, 1 ),1为取消存储过程返回超过1024字节限制
--------------------------------------------------------------------------
--include:
local DBRPC = DBRPC
local look = look
local GetServerID = GetServerID
local GetGroupID = GetGroupID
local GetServerTime = GetServerTime

local __call 	 = { dbtype = 101, sp = 'p_default', args = 0 }
local __callback = { callback = 'CALLBACK_default',args = 0 }



-- gm取在线玩家数量
function db_StaySetOnLogin(account)

	__call.dbtype,__call.sp ,__call.args = 0,'N_StaySetOnLogin',1
	__call[1] = account
	DBRPC( __call )
end

--每日24点保存今日在线玩家,留存数据使用
function db_saveStayData()
	__call.dbtype,__call.sp ,__call.args = 0,'N_StaySetOnDay',0
	DBRPC( __call )
end
--每小时保存在线玩家数量
function db_saveOnlineNum(num)
	__call.dbtype,__call.sp ,__call.args = 0,'N_OnlineNum_Set',1
	__call[1] = num
	DBRPC( __call )
end
-- gm取注册人数
function db_gm_registerNum(beginTime,endTime)
	__call.dbtype,__call.sp ,__call.args = 0,'N_GetRegisterNum',2
	__call[1] = beginTime
	__call[2] = endTime
	__callback.callback,__callback.args = 'CALLBACK_registerNum',1
	__callback[1] = '?3'
	DBRPC( __call, __callback )
end

-- gm取30日留存
function db_gm_stayAll(beginTime)
	__call.dbtype,__call.sp ,__call.args = 0,'N_StayGet30Day',1
	__call[1] = beginTime
	__callback.callback,__callback.args = 'CALLBACK_gmgetStayAll',11
	__callback[1] = '?2'
	__callback[2] = '?3'
	__callback[3] = '?4'
	__callback[4] = '?5'
	__callback[5] = '?6'
	__callback[6] = '?7'
	__callback[7] = '?8'
	__callback[8] = '?9'
	__callback[9] = '?10'
	__callback[10] = '?11'
	__callback[11] = '?12'
	DBRPC( __call, __callback )
end
-- gm取单日留存
function db_gm_stayOne(beginTime,num)
	__call.dbtype,__call.sp ,__call.args = 0,'N_StayGetOneDay',2
	__call[1] = beginTime
	__call[2] = num
	__callback.callback,__callback.args = 'CALLBACK_gmgetStayOne',2
	__callback[1] = '?3'
	__callback[2] = '?4'
	DBRPC( __call, __callback )
end

-- gm取在线玩家数量
function db_gm_online(beginTime)

	__call.dbtype,__call.sp ,__call.args = 0,'N_OnlineNum_Get',1
	__call[1] = beginTime
	__callback.callback,__callback.args = 'CALLBACK_gmgetOnline',1
	__callback[1] ="#100"
	DBRPC( __call, __callback )
end
-- gm取充值数据
function db_gm_recharge(beginTime,endTime)

	__call.dbtype,__call.sp ,__call.args = 2,'N_GetRegisterNum',2
	__call[1] = beginTime
	__call[2] = endTime
	__callback.callback,__callback.args = 'CALLBACK_gmgetRecharge',1
	__callback[1] = '?3'
	DBRPC( __call, __callback )
end

-- 检查玩家名是否存在
function db_CheckName(name,sid)
	__call.dbtype,__call.sp ,__call.args = 0,'p_ChangeName',2
	__call[1] = sid
	__call[2] = name
	__callback.callback,__callback.args = 'CALLBACK_Check_db_GameName',3
	__callback[1] = '?3'
	__callback[2] = sid
	__callback[3] = name
	DBRPC( __call,__callback)
end

--取流失数据-beginTime 起始日;leaveday 几日的流失;itype=1按等级,2按关卡,3按vip等级,4按引导;num和iype对应,如等级=5
function db_gm_getleavedata(beginTime,leaveday,itype,num )
	__call.dbtype,__call.sp ,__call.args = 0,'N_Leave_Get',4
	__call[1] = beginTime
	__call[2] = leaveday
	__call[3] = itype
	__call[4] = num
	
	__callback.callback,__callback.args = 'CALLBACK_gmgetleavedata',3
	__callback[1] = itype
	__callback[2] = num
	__callback[3] = '?5'
	DBRPC( __call,__callback)
end

--取 -消费数据-optype=1按等级,按vip等级;itype=货币类型,detailType功能类型,otherinfo道具id等,lv_mini 等级段
function db_gm_getpointuse(optype , begintime , itype , detailType , otherinfo , lv_mini , lv_max )
	__call.dbtype,__call.sp ,__call.args = 0,'N_PointUse_Get',7
	__call[1] = optype
	__call[2] = begintime
	__call[3] = itype
	__call[4] = detailType
	__call[5] = otherinfo
	__call[6] = lv_mini
	__call[7] = lv_max

	__callback.callback,__callback.args = 'CALLBACK_gmgetpointuse',1
	__callback[1] = '?8'
	DBRPC( __call,__callback)
end
--写后台功能数据 	#_itype =功能类型 1秘境寻宝,2将神传说,3过关斩将,4练武场;_optype =1参加次数,2重置次数;_otherInfo 关卡数据等
function  db_gm_setoperation(sid,itype,optype,joinNum,resetNum,otherInfo)
	__call.dbtype,__call.sp,__call.args=0,"N_operationSet",5
	__call[1]=sid
	__call[2]=itype
	__call[3]=optype
	__call[4]=joinNum
	__call[5]=resetNum
	__call[6]=otherInfo
	
	DBRPC(__call)
end


--取后台功能数据
function db_gm_getoperation(itype,begintime,endtime)
	__call.dbtype,__call.sp,__call.args=0,"N_operationGet",3
	__call[1]=itype
	__call[2]=begintime
	__call[3]=endtime
	
	__callback.callback,__callback.args = 'CALLBACK_gmoperation',7
	__callback[1] = itype
	__callback[2] = '?4'
	__callback[3] = '?5'
	__callback[4] = '?6'
	__callback[5] = '?7'
	__callback[6] = '?8'
	__callback[7] = '?9'
	
	DBRPC( __call,__callback)
	
end

--写玩家等级日志
function db_lvlog()
	__call.dbtype,__call.sp,__call.args=0,"N_lvlog_Set",0
	DBRPC(__call)
end
--取玩家时间段内充值 itype用于回调区分,例如单日充值活动=1,3日=2,历史=3等
function db_getRecharge(itype,sid,begintime,endtime)
	__call.dbtype,__call.sp,__call.args=0,"p_Recharge_Get",3
	__call[1]=sid
	__call[2]=begintime
	__call[3]=endtime
	
	__callback.callback,__callback.args = 'CALLBACK_getRecharge',3
	__callback[1] = sid
	__callback[2] = itype
	__callback[3] = '?4'
	
	DBRPC( __call,__callback)
end
--取玩家时间段内消费  itype用于回调区分,例如单日充值活动=1,3日=2,历史=3等
function db_geExpense(itype,sid,begintime,endtime)
	__call.dbtype,__call.sp,__call.args=0,"p_expense_Get",3
	__call[1]=sid
	__call[2]=begintime
	__call[3]=endtime
	
	__callback.callback,__callback.args = 'CALLBACK_geExpense',3
	__callback[1] = sid
	__callback[2] = itype
	__callback[3] = '?4'
	
	DBRPC( __call,__callback)
end

function db_GetVIPExp(sid)
	look("db_GetVIPExp ".."      "..sid)
	__call.dbtype,__call.sp ,__call.args = 0,'GetFinaleValue',1
	__call[1] = sid

	__callback.callback,__callback.args = 'ReceviVipExp',2
	__callback[1] = "#100"
	DBRPC( __call,__callback)
end

function db_GetRegTime(sid)
	look("db_GetRegTime ".."      "..sid)
	local account = GetPlayerData(0,GPP_MYACCOUNT)
	__call.dbtype,__call.sp ,__call.args = 0,'GetRegTime',1
	__call[1] = account

	__callback.callback,__callback.args = 'db_RecviRegTime',1
	__callback[1] = "#100"
	DBRPC( __call,__callback)
end


function db_RecviRegTime( result )
	look("db_RecviRegTime ")
	if result ~= nil then
		look(result)
		if type(result[1]) == "table" then
			if type(result[1][1]) ~= "string" then
				return
			end
			
			local regTime = "2015-07-23 15:33:59"
			local y = string.sub(regTime,1,4)
			local m = string.sub(regTime,6,7)
			local d = string.sub(regTime,9,10)
			local h = string.sub(regTime,12,13)
			local mins = string.sub(regTime,15,16)
			local s = string.sub(regTime,18,19)
			local dt = {year=y, month=m, day=d, hour=h, min=mins, sec=s}
		look(os.time(dt))
		end


		
	end
end

function OnChangeNameCount( sid )
	local count = GetChangeNameCount(sid)
	look("OnChangeNameCount ".."      "..sid.."    "..count)
	if count > 0 then
		return
	end

	local account = GetPlayerData(0,GPP_MYACCOUNT)
	account = string.sub(account,1,30)
	local name = CI_GetPlayerDataSG(sid,4)
	name = string.sub(name,1,30)
	look("OnChangeNameCount ".."      "..account.."    "..name)
	if account ~= name then
		ChangeNameCountAdd(sid)
	end
end
