---------------------------------------------------------------------------------------------------
--倒计时奖励,重置索引号约定为1
CountDownGiftTime = {1,2,2,2,2,2,2,2,2,2}--倒计时奖励时间设定，单位：分钟
CountDownGiftItemList={}	--奖励物品
CountDownGiftItemList[1] = {3530001,100,3530002,100}
CountDownGiftItemList[2] = {3530001,100,3530002,100}
CountDownGiftItemList[3] = {3530001,100,3530002,100}
CountDownGiftItemList[4] = {3530001,100,3530002,100}
CountDownGiftItemList[5] = {3530001,100,3530002,100}
CountDownGiftItemList[6] = {3530001,100,3530002,100}
CountDownGiftItemList[7] = {3530001,100,3530002,100}
CountDownGiftItemList[8] = {3530001,100,3530002,100}
CountDownGiftItemList[9] = {3530001,100,3530002,100}
CountDownGiftItemList[10] = {3530001,100,3530002,100}

function ResetCountDown()
	ResetCountDownGiftState()
	ResetCountDownGiftTime()
end

function SendCountDownGiftList()
	--先判断要不要重置日常时间
	local timeCheck = GetCountDownBeginTime()
	local nIndex = GetEveryDayPointByIndex(timeCheck, 1)  --倒计时奖励的索引号约定为1
	if(nIndex > 0) then
		ResetCountDown()
	end
	
	local giftIndex = GetCountDownGiftState();
	local giftCount = table.getn(CountDownGiftTime)
	
	if(giftIndex == 0)then
		rfalse("玩家获取在线礼包出错")
		return 0
	elseif (giftIndex > giftCount) then
		SendGiftSucceed(0,3,0)
		--SendLastCountDownGiftList(0) --发送最后一个在线奖励列表
		--rfalse("玩家在线礼包已经全部获取")
		return 0
	end
	
	local itemList = CountDownGiftItemList[giftIndex]
	if (itemList == nil) then
		rfalse("玩家获取在线礼包物品列表出错")
		return 0
	end
	
	local itemNum = table.getn(itemList)/2
	local giftTime = CountDownGiftTime[giftIndex] * 60
	local remainTime = GetRemainTime(giftIndex)	
	SendBufferToClinet(0,itemNum,itemList,1,giftTime,remainTime)	
	return 0	
end

function GetRemainTime(giftIndex)
	local giftTime = CountDownGiftTime[giftIndex] * 60
	local remainTime = giftTime - (os.time() - GetCountDownBeginTime()) 
	if(remainTime < 0) then
		remainTime = 0
	end
	
	return remainTime;
end

function onRecvGetCountDownGift()
	local giftIndex = GetCountDownGiftState();
	local giftCount = table.getn(CountDownGiftTime)
	if(giftIndex == 0)then
		--rfalse("玩家获取倒计时礼包出错")
		SendGiftSucceed(0,0,0)
		return 0
	elseif (giftIndex > giftCount) then
		--rfalse("玩家倒计时已经全部获取")
		SendGiftSucceed(0,3,0)
		return 0
	end
	
	local remainTime = GetRemainTime(giftIndex)	
	if(remainTime>0) then
		return 0	--时间没到，不能发奖励
	end
	
	local itemList = CountDownGiftItemList[giftIndex]
	if (giveItemList(itemList) == 0) then
		TalkToPlayer(2, "背包空间不足，无法放置奖励道具！") --或是没有找到该奖励物品
		SendGiftSucceed(0,0,0)
		return 0
	end
	
	SendGiftSucceed(0,1,0) 		--发送给客户端成功失败消息
	UpdateCountDownGiftState()	--更新状态
	ResetCountDownGiftTime()	--更新倒计时	
	
	SendCountDownGiftList() 	--发送下次奖励,并让客户端重新计时	
	return 0
end

---------------------------------------------------------------------------------------------------
