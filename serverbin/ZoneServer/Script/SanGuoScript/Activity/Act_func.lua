--[[
file:	Act_func.lua
author:	lpd
update:	2015-05-13
desc:活动功能
]]--
local _date=os.date
local _time=os.time
local _ceil = math.ceil
local _fmod = math.fmod
local _pow = math.pow
local _floor = math.floor
local openTime=0
local actConf = act_conf
local _get_digitnum = get_digitnum
local _set_digitnum = set_digitnum
local testDay = 1 --取距离某天的天数会固定+1才是需要的值


-- 获取玩家活动的数据
local function get_actdata(sid) 
	if dbMgr[sid]==nil or  dbMgr[sid].data==nil then 
		return
	end
	if dbMgr[sid].data['act']==nil then 
		dbMgr[sid].data['act']={ -- key 1-8:0代表领取奖励， 1表示登录都没有领取奖励,  2表示玩家在活动当天没有登录。
									--最高位记录为第八天活动领取状态，个位第一天,十位第二天，以此类推。。。
			ctime = 0, --账号创建时间
			loginday = 0, --登录日期
			[1]=22222222,--封测豪礼大放送,1-8
			[2]=22222222,--封测豪礼大放送,9-16
			[3]=22222222,--封测狂欢-幸运连连 1-8
			[4]=22222222,--封测狂欢-幸运连连 9-16
			[5]=22222222,--签到送武将 1-8
			[6]=22222222,--签到送武将 9-16
			[7]=11111111,--冲级好礼连连送 1-8
			[8]=11111111,--冲级好礼连连送 9-16
			[9]=1, -- 兑换码
			
			[10]=0,--天天领元宝,存的上次领取时间
			[11]=0,--天天领宝箱,存的上次领取时间
			[12]=0,--端午活动,存的上次领取时间  6月19日、20日、21日
		}
	end
	return dbMgr[sid].data['act']
end

--玩家获取活动奖励接口  
--[[
	actType=1 封测豪礼大放送, 2 封测狂欢, 3签到送武将 ,4 冲级好礼连连送,5 兑换码功能,6,--天天领元宝 	7,--天天领宝箱	8, --端午活动
	indexOri=对应奖励配置的下标
]]--
function act_get_reward(sid, actType, indexOri)
	
	--look("=========开启活动功能==========")
	look("玩家ID:"..sid.."  活动类型:"..actType.."  奖励索引:"..indexOri)
	
	if actType == act_type.chargeSum then --如果是累计充值奖励，则进入对应逻辑
		GetChargeSumReward(sid, indexOri) --调用获取累计充值奖励接口
		return
	end
	
	local actData = get_actdata(sid) -- 获取对应活动数据
	if actData == nil then --如果玩家无数据 则返回
		--look("玩家无数据")	
		return
	end
	
	local curActconf = actConf[actType] --获取对应活动配置
	local index = indexOri  --对应玩家数据第几位的表识
	local result = 1 -- 0为获取奖励失败，1为获取奖励成功
	local rewardIndex = actType *2 -1 -- 奖励对应玩家数据索引
	
	--得到 index,result,rewardIndex
	if actType == act_type.betaTestGift then --豪礼大放送
		-- local createTime = actData.ctime
		-- local actDay = GetDiffDayFromTime(createTime) + testDay--计算当前时间是开服的第几天
		-- if actDay > 8  and indexOri > 8 then--如果超过8天
		-- 	rewardIndex = rewardIndex + 1 
		-- 	index = index - 8
		-- end
	elseif actType == act_type.betaLucky or actType == act_type.chekinHeroGift  then --不是冲击练练活动
		local createTime = actData.ctime
		local actDay = GetDiffDayFromTime(createTime) + testDay--计算当前时间是开服的第几天
		if(index > actDay)then --判断请求奖励天数是否为当天
			result = 0
		end 
		if(actDay > 8) and (index > 8) then--如果超过8天
			rewardIndex = rewardIndex + 1 
			index = index - 8
		end
	elseif actType == act_type.lvUpGift then--冲击练练活动

		--if curActcon.con[index] <= CI_GetPlayerDataSG(sid, 3) then--满足等级 
		--end
		if(index > 8) then --如果奖励索引超过8
			rewardIndex = rewardIndex + 1
			index = index - 8
		end
		
	elseif actType == act_type.packGift then --兑换活动
		--look("兑换活动")
		rewardIndex = 9 --兑换码的奖励对应玩家数据下标是9
		
	elseif actType == act_type.diamondEveryday or  actType == act_type.boxEveryday then  --6,--天天领元宝 	7,--天天领宝箱
		local actDay = GetDiffDayFromTime(actData.ctime) + testDay--计算当前时间是开服的第几天
		if actDay<17 then
			--look(222)
			result=0
		end
		if (actDay-16)%8 ~=indexOri then--天数对应不上,8天一轮回
			--look(111)
			result = 0
		end
		rewardIndex=actType+4
	elseif  actType == act_type.duanwu then  --8, -- 端午活动 6月19日、20日、21日
		rewardIndex=actType+4
		local nowday = _date("*t", GetServerTime())
		local day=indexOri+18
		if nowday.month~=6 or nowday.day ~=day then 
			--look(333)
			result = 0
		end
	end

	--判断领取过没 
	if result==1 then
		if rewardIndex>0 and rewardIndex<=9 then --1-9对应key的活动
			
		--检测今天是否未领取活动奖励 
			if _get_digitnum(actData[rewardIndex] ,index) == 1 then 
				actData[rewardIndex] = _set_digitnum(actData[rewardIndex],index ,0 )
			else
				look("已经被领取过")
				result = 0
			end
		
		elseif rewardIndex>=10 and rewardIndex<=12 then 
			local now=GetServerTime()
			local actDay = GetDiffDayFromTime(now) + testDay--计算当前时间是开服的第几天
			local lastday= GetDiffDayFromTime(actData[rewardIndex]) + testDay--计算上次领奖是开服的第几天
			if lastday == actDay then
				look("已经被领取过")
				result = 0
			end
			actData[rewardIndex]=now --设置最新领奖时间
		
		end
	end

	
	--判断结束，则进入发送奖励流程 
	if result == 1 then  
		for key, value in pairs(curActconf[indexOri]) do      
			CI_AddGoods_SG(value[1], value[2], value[3], GoodsWay.active)
			--look("领取奖励了" ..value[1]..";" ..value[2]..";"..value[3]..";"..index)
		end  
	end
	
	--look("=========完成活动功能==========")
	CI_ActResult(actType,indexOri,result) --反馈客户端
end


function set_Ctime(sid) --设置开服时间
	look("set_Ctime")
	local actData =	get_actdata(sid)
	if actData ~= nil then
		if actData.ctime == 0 then
			actData.ctime = GetServerTime()
		end
	end
end

--创建账号 设置开服时间
function set_createTime(sig , retTime) 
	local actData =	get_actdata(sig)
	if(actData == nil) then
		return 
	end
	if retTime ~= nil then
		actData.ctime = retTime
	else
		actData.ctime = GetServerTime()--设置开服时间
	end
	--look("设置开服时间:"..actData.ctime)
end

--登陆同步数据
function act_firstLogin(sid,dataTb,index)
	local pdata = get_actdata(sid)
	dataTb[index] = pdata.ctime
	index = index+1
	for i=1,12 do
		dataTb[index+i-1]=pdata[i]
	end
	return index+12 
end

--活动登陆，自动设置数据值
function act_login(sid) 

	local actData =get_actdata(sid)
	local actDay = GetDiffDayFromTime(actData.ctime) + testDay--计算当前时间是开服的第几天
	look("登录活动数据设置，当前是第"..actDay.."天")

	for i=1,8 do--累计登录，修改今天登录状态
	    if actDay > actData.loginday and _get_digitnum(actData[1], i) == 2 then
			actData[1] = _set_digitnum(actData[1], i, 1)
			break
		end
	end
	if(actDay > 16)  then
		return
	elseif(actDay > 8)  then --修改8天以上的数据
		if _get_digitnum(actData[4], actDay-8) == 2 then --登录时改天数据未登录状态2，则修改为登录可领取状态 1
			actData[4]=_set_digitnum(actData[4], actDay-8,1) 
		end
		if _get_digitnum(actData[6], actDay-8) == 2 then --登录时改天数据未登录状态2，则修改为登录可领取状态 1
			actData[6]=_set_digitnum(actData[6], actDay-8,1) 
		end
		for i=1,8 do --累计登录，修改今天登录状态
			if actDay > actData.loginday and _get_digitnum(actData[2], i) == 2 then
				actData[2] = _set_digitnum(actData[2], i, 1)
				break
			end
		end
	else --8天以内
		if (_get_digitnum(actData[3],  actDay) ==2) then--登录时改天数据未登录状态2，则修改为登录可领取状态 1
			actData[3]=_set_digitnum(actData[3], actDay,1) 
		end
		if (_get_digitnum(actData[5],  actDay) ==2) then --登录时改天数据未登录状态2，则修改为登录可领取状态 1
			actData[5]=_set_digitnum(actData[5], actDay,1) 
		end

	end

	actData.loginday = actDay --登录时间赋值

end

--单元测试用例
--function act_testCase()
	--local result = set_digitnum(111111111, 2, 0) 
	--look (result)
	-- set_digitnum(19998854, 2, 7) 
	-- set_digitnum(19998854, 3, 7) 
	-- set_digitnum(19998854, 4, 7) 
	-- set_digitnum(19998854, 5, 7) 
	-- set_digitnum(19998854, 6, 7) 
	-- set_digitnum(19998854, 7, 7) 
	-- set_digitnum(19998854, 8, 7) 
	-- set_digitnum(19998854, 9, 7) 
	--[[get_digitnum(19998854, 1)
	get_digitnum(19998854, 2)
	get_digitnum(19998854, 3)
	get_digitnum(19998854, 4)
	get_digitnum(19998854, 5)
	get_digitnum(19998854, 6)
	get_digitnum(19998854, 7)
	get_digitnum(19998854, 8)
	get_digitnum(19998854, 9)
	]]--
	--local rwardIndex = CI_GetStartTime()
	--look (rwardIndex)
	--look(CI_GetPlayLevel())
	--get_reward(1000100003, 1) --测试获取奖励
	
	-- tempStr = mutstring("sssssssssss")
	-- look(tempStr[2])
	-- tempStr[2] = "f"
	-- a = "string:"
	-- look(a..tostring(s))
	--act_get_reward(1000100004,1,15)
--end
--act_testCase()
