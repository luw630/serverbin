--[[
file:	checkIn.lua
author:	wk
update:	2015-01-27
desc:签到功能,现在收发消息用c,逻辑在lua
]]--
local _ceil=math.ceil
local basemoney=20
local checkindata	 = msgh_s2c_def[1][1]
local baseturn30=120 --30日签到奖励轮回
local baseturn7=14 --7日签到奖励轮回
local DayTime = 24 * 60 * 60
--取玩家数据
local function checkin_getdata( sid )
	if dbMgr[sid]==nil or  dbMgr[sid].data==nil then 
		return
	end
	if dbMgr[sid].data['checkin']==nil then --初始化签到功能数据
		dbMgr[sid].data['checkin']={
			-- [1]=0,--第一次签到时间
			-- [2]=0,--上次签到时间
			-- [3]=0,--本轮签到次数
			-- [4]=0,--本轮补签次数
			-- [5]=1,--7日登陆奖励第几轮
			-- [6]=0,--7日登陆奖励领导第几天(中途中断时从头开始)
			
			[1]=0,--30轮回上次签到时间
			[2]=0,--30轮回签到第几天(中途中断时不从头开始)
			[3]=0,--7轮回上次签到时间
			[4]=0,--7轮回签到第几天(中途中断时从头开始)
		}
	end
	return dbMgr[sid].data['checkin']
end
--同步签到信息给前台 登录,签到补签调用
function checkin_senddata( sid )
	--look("checkin_senddata")
	local pdata=checkin_getdata( sid )
	if pdata==nil then 
		return 
	end
	CI_SendCheckinData(pdata[1],pdata[2],pdata[3],pdata[4])
end
--同步签到信息给前台
function checkin_firstlogin(sid,dataTb,index)
	local pdata=checkin_getdata( sid )	
	for i=1,4 do
		dataTb[index+i-1]=pdata[i]
	end
	return index+4 
end

--签到领奖 itype=1每日30签到,itype=2每日7签到
function checkin_quest(sid,itype)
	 -- look(tostring("签到领奖"))
	-- look(sid)	
	 -- look(itype)	
	local pdata=checkin_getdata( sid )
	
	if pdata==nil then 
		look('pdata==nil')
		return 
	end
	local CurTime = GetServerTime()
	if itype==1 then --每日30签到
		if 0==pdata[1] then 
			pdata[1]=CurTime-DayTime --初始化为昨日签到时间
		end
		--local  diffday= _ceil(CurTime / DayTime)-_ceil(pdata[1] / DayTime)
		local  diffday=  GetDiffDayFromTime(pdata[1])-GetDiffDayFromTime(CurTime)
		if diffday<=0 then --已签到
			look('已签到')
			return
		end	
		pdata[1]=CurTime
		pdata[2]=pdata[2]+1
		
		if pdata[2]>baseturn30 then 
			pdata[2]=1
		end
		-- --调用c++发奖励
		CI_GiveCheckinAwards(pdata[2],itype)--参数1为30日签到第几天奖励,参数2为7日签到第几轮,参数3为7日签到第几天的奖励
	elseif itype==2 then --7日签到
		if 0==pdata[3] then 
			pdata[3]=GetServerTime()-DayTime --初始化为昨日签到时间
		end
		--local  diffday= _ceil(CurTime / DayTime)-_ceil(pdata[3] / DayTime)
		local  diffday= GetDiffDayFromTime(pdata[3])-GetDiffDayFromTime(CurTime)
		if diffday<=0 then --已签到
			look('已签到')
			return
		elseif diffday==1 then --连续签到
			
		elseif diffday>1 then--跨天签到,7日签到从头开始
			
			if pdata[4]>7 then 
				pdata[4]=7
			else
				pdata[4]=0
			end
		end	
		pdata[3]=CurTime
		pdata[4]=pdata[4]+1
		if pdata[4]>baseturn7 then 
			pdata[4]=7
		end
		-- --调用c++发奖励
		CI_GiveCheckinAwards(pdata[4],itype)--参数1为30日签到第几天奖励,参数2为7日签到第几轮,参数3为7日签到第几天的奖励
		
	end
	
	checkin_senddata( sid )
	
	--SendLuaMsg(0,{ids=checkindata,pdata[1],pdata[2],pdata[3],pdata[4]})
	--CI_TipMsg("签到成功!!!")
end
-- --签到领奖 itype=1每日签到,itype=2补签---之前补签版本,暂时留一下,以防策划反悔!
-- function checkin_quest(sid,itype)
	-- -- look(tostring("签到领奖"))
	-- --look(sid)	
	-- -- look(itype)	
	-- local pdata=checkin_getdata( sid )
	
	-- if pdata==nil then 
		-- look('pdata==nil')
		-- return 
	-- end
	-- local CurTime = GetServerTime()
	-- local DayTime = 24 * 60 * 60
	-- local PreTime = pdata[2]
	-- if pdata[1]==0 then --第一次签到时间初始化为本日00:00:01
		-- local dt = os.date("*t", CurTime)
		-- dt.hour = 0
		-- dt.min = 0
		-- dt.sec =1
		-- pdata[1]=os.time(dt)
	-- end
	-- -- look(pdata[1])
	-- local maxcount=_ceil((CurTime-pdata[1])/DayTime) --得到今日距第一次总天数
	-- local nowturn=_ceil(maxcount/30) --今日第几轮
	-- local over_count=_ceil((pdata[2]-pdata[1])/DayTime) --得到上次签到到第一次签到总天数
	-- local player_turn=_ceil(over_count/30) --玩家上次签到是第几轮
	
	-- if player_turn~=nowturn then --轮数不一样,置空从新一轮开始
		-- pdata[3]=0
		-- pdata[4]=0
	-- end
		
	
	-- if itype==1 then --每日签到
		-- local  diffday= _ceil(CurTime / DayTime)-_ceil(PreTime / DayTime)
		-- if diffday<=0 then --已签到
			-- --look('已签到')
			-- return
		-- elseif diffday==1 then --连续签到
			
			-- pdata[6]=pdata[6]+1
			-- if pdata[6]>7 then--7天后从1开始
				-- pdata[6]=1
				-- pdata[5]=pdata[5]+1 --轮数+1
			-- end
			
		-- elseif diffday>1 then--跨天签到,7日签到从头开始
			-- pdata[6]=1
		-- end	
		-- pdata[2]=CurTime
		-- pdata[3]=pdata[3]+1
		-- -- --调用c++发奖励
		-- CI_GiveCheckinAwards(pdata[3],pdata[5],pdata[6])--参数1为30日签到第几天奖励,参数2为7日签到第几轮,参数3为7日签到第几天的奖励
	-- elseif itype==2 then --补签
		-- local nowday=maxcount%30 --第几天
		-- if nowday==0 then
			-- nowday=30 --是这一轮的第30天
		-- end
		-- if pdata[3]<nowday then --可以补签
			
			-- --扣钱
			-- local needmoney=(pdata[4]+1)*basemoney
			 -- if CI_CheckGoods_SG(2,0,needmoney)~=1 then
				-- --look('money less')
				-- CI_TipMsg("money less!!!")
				-- return 
			 -- end
			 -- CI_DecGoods_SG(2,0,needmoney)
			-- pdata[3]=pdata[3]+1
			-- pdata[4]=pdata[4]+1
			-- -- --发奖励
				-- CI_GiveCheckinAwards(pdata[3],0,0)--参数1为30日签到第几天奖励,参数2为7日签到第几轮,参数3为7日签到第几天的奖励
		-- else
			-- return
		-- end
		
	-- end
	
	-- checkin_senddata( sid )
	
	-- --SendLuaMsg(0,{ids=checkindata,pdata[1],pdata[2],pdata[3],pdata[4]})
	-- --CI_TipMsg("签到成功!!!")
-- end

