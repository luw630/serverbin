
RemoneyActivity =  Activitymodule:new()
RemoneyActivity:Init(6)
ActivityRegister(RemoneyActivity)
WeekReturnChargeData = RemoneyActivity:LoadData()	--玩家的元宝基金数据
--回调发送函数
function Callback_WeekReMoney(sid)
	local tab = WeekReturnChargeData[sid]
			-- tab.State= 1
			-- tab.ReNum= 0
			-- tab.STime= os.time()
			-- tab.ShouldNum= 0		
			-- tab.ReTime =0
			-- tab.one =0 
			-- tab.two = 0 
			-- tab.three = 0
			-- tab.four = 0
			-- tab.five =0
			-- tab.six = 0
			-- tab.seven = 0

	look(tab.ShouldNum)
	CI_WeekReMoney(tab.State,tab.one,tab.two,tab.three,tab.four,tab.five,tab.six,tab.seven,tab.ShouldNum)
end
--购买基金活动
function BuyReMoneyAct(sid)
--look(SI_vip_getlv(sid))
		local tab = {}
--look("wmc"..WeeksReturnMoneyCon[9])
--look("wmc2"..sid)
	if	WeeksReturnMoneyCon[9] <= SI_vip_getlv(sid) then
			local gold = CI_GetPlayerDataSG(sid,2) --元宝数量
			
			if gold < WeeksReturnMoneyCon[8] then    --金额不足
				look("gold < Chargenum "..gold.."    "..WeekReturnChargeData[1])
				return
			end
			look("but strat")
			tab.State= 1
			tab.ReNum= 0
			tab.STime= os.time()
			tab.ShouldNum= 0		
			tab.ReTime =0
			tab.one =0 
			tab.two = 0 
			tab.three = 0
			tab.four = 0
			tab.five =0
			tab.six = 0
			tab.seven = 0
			WeekReturnChargeData[sid] = tab		
			CI_DecGoods_SG(2,0,WeeksReturnMoneyCon[8])
			--self:SaveData(WeekReturnChargeData)
			look(tab.ShouldNum)
			RemoneyActivity:save(WeekReturnChargeData)

			--self:SaveData(WeekReturnChargeData)
			CI_WeekReMoney(tab.State,tab.one,tab.two,tab.three,tab.four,tab.five,tab.six,tab.seven,tab.ShouldNum)
			return
	end
	--RemoneyActivity:save(WeekReturnChargeData)
	--look("vip level buzhu")
	CI_WeekReMoney(0,0,0,0,0,0,0,0,0)
end
function RemoneyActivity:save(WeekReturnChargeData)
	--look(WeekReturnChargeData)
	self:SaveData(WeekReturnChargeData)
end
-- function test1(actParam)
-- local tab = WeekReturnChargeData[actParam]
	-- if tab ==nil then 
		-- look("登录时 不存在数据21")
		-- return
	-- end
	-- local snum
	-- local ti = tonumber(os.date("%Y%m%d",tab.ReTime))
	-- local cti = tonumber(os.date("%Y%m%d",os.time()))
	-- local sti = tonumber(os.date("%Y%m%d",tab.STime))

	-- if  cti > ti then
		-- local snum 
		-- if tab.ReTime ==0 then
		-- look("ostime"..cti)
		-- look("Sttime"..sti)
			-- snum = cti - sti 
		-- else
			-- snum = cti - ti 
		-- end	
		
		-- if (snum + tab.ShouldNum) >= 7 then
			-- tab.ShouldNum = 7
		-- end
		-- if (snum + tab.ShouldNum) < 7 then
			-- tab.ShouldNum = snum
		-- end
		-- WeekReturnChargeData[actParam] = tab
		-- look("snum"..WeekReturnChargeData[actParam].ShouldNum)
	-- end
-- end

-- 确认玩家的领取天数
function RemoneyActivity:OnTrigger(actParam) --当触发时做的事情,根据需要传递不同的参数，活动不同可以传递不同
	--look("登录时 不存在数据3")
	local tab = WeekReturnChargeData[actParam]
	
	if tab == nil then
	--look("callback_nil") 
	CI_WeekReMoney(0,0,0,0,0,0,0,0,0)
	--printtable(tab)
	return
	end
	
	if tab ==nil then 
		--look("登录时 不存在数据4")
		return
	end
				

	--look(tab)
	local snum
	local ti = tonumber(os.date("%Y%m%d",tab.ReTime))
	local cti = tonumber(os.date("%Y%m%d",os.time()))
	local sti = tonumber(os.date("%Y%m%d",tab.STime))

	if  cti > ti then
		local snum 
		if tab.ReTime ==0 then
		look("ostime"..cti)
		look("Sttime"..sti)
			snum = cti - sti 
		else
			snum = cti - ti 
		end	
		
		if (tab.ReNum) >= 7 then
			tab.ShouldNum = 7
		end
		if (tab.ReNum) < 7 then
			tab.ShouldNum = snum
		end
		
	end
	
	WeekReturnChargeData[actParam] = tab 
	self:SaveData(WeekReturnChargeData) 
	--look("nums"..tab.ShouldNum)
	Callback_WeekReMoney(actParam)
	--CI_WeekReMoney(tab.State,tab.one,tab.two,tab.three,tab.four,tab.five,tab.six,tab.seven,tab.ShouldNum)
	-- look("MyActivity OnTrigger "..self.ActivityID.."   Type "..self.ActivityType.."   name "..self.ActivityName)
	-- self:ChargeGiveItem(100,1006)
end


function OnTriggerWeekTreasure(sid,nbr) --玩家点击元宝基金
	--look("OnTriggerWeekTreasure")
	local actmodule = ActivityGetmodulebyIndex(1006)  --自己的活动ID，可以定义为枚举方便识别
	look(actmodule)
	if actmodule ~= nil then
		actmodule:ChargeGiveItem(sid,nbr)
	end
end


function RemoneyActivity:ChargeGiveItem(sid,nbr) --后领取奖励
	local tab ={}
	tab = WeekReturnChargeData[sid]
	look("nbr"..nbr)
	look("tab.ShouldNum"..tab.ShouldNum)
	if tab == nil then
		return
	end
	--look("get num")
	-- if tab.ReNum >= tab.ShouldNum  then
		-- look("renum >= shouldNum")
		-- return
	-- end

	
	if nbr==1 then
		if tab.one ==0 then
		tab.one =1
		else
		return
		end
	end
   if nbr==2 then
		if tab.two ==0 then
		tab.two =1
		else
		return
		end
   end

   if nbr==3 then
		if tab.three ==0 then
		tab.three =1
		else
		return
		end
   end
	
	if nbr==4 then
		if tab.four ==0 then
		tab.four =1
		else
		return
		end
   end
   
   if nbr==5 then
		if tab.five ==0 then
		tab.five =1
		else
		return
		end
   end
   
   if nbr==6 then
		if tab.six ==0 then
		tab.six =1
		else
		return
		end
   end
   
   if nbr==7 then
		if tab.seven ==0 then
		tab.seven =1
		else
		return
		end
		
   end
   
	--look("tab.ShouldNumed "..tab.ShouldNum)
	--tab.ReNum = tab.ReNum+1
	--look("renum"..WeeksReturnMoneyCon[nbr])
	local num = WeeksReturnMoneyCon[nbr]
	if num == nil then
	--look("renum2"..num)
		return
	end
	
	CI_AddGoods_SG(2,0,num)
	
	WeekReturnChargeData[sid] = tab
	self:SaveData(WeekReturnChargeData)
	look("ChargeGiveItem sucess ")
	
	Callback_WeekReMoney(sid)
end