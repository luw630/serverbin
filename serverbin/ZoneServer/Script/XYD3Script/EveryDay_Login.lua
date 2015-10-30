---------------------------------------------------------------------------------------------------
--连续登录奖励,重置索引号约定为1
LastLoginRewardList[1] = {3530001,2,3530001,1,3530002,4}	--连续登陆奖励列表
LastLoginRewardList[2] = {3530001,2,3530001,1,3530002,4}	
LastLoginRewardList[3] = {3530001,2,3530001,1,3530002,4}	
LastLoginRewardList[4] = {3530001,2,3530001,1,3530002,4}	
LastLoginRewardList[5] = {3530001,2,3530001,1,3530002,4}	
LastLoginRewardList[6] = {3530001,2,3530001,1,3530002,4}	
LastLoginRewardList[7] = {3530001,2,3530001,1,3530002,4}	

--发送连续登录奖励
function SendLoginGiftList()
	local PreTimeCheck = LoadFromPlayerData(3) --玩家上次领礼包的时间
	local PreGiftIndex = LoadFromPlayerData(4) --玩家上次领的是第几个礼包
	local CurGiftIndex = LoadFromPlayerData(5) --玩家本次应该领第几个礼包
	
	--查看到了重置点没有
	local nRet = GetEveryDayPointByIndex(PreTimeCheck, 1)  --连续登录奖励索引号约定为1
	if(nRet == 1) then --重置点到了
		CurGiftIndex = CurGiftIndex+1
	end
	if(CurGiftIndex>7) then
		CurGiftIndex = 1
	end

	local itemList = LastLoginRewardList[CurGiftIndex]
	local itemNum = table.getn(itemList)/2
	SendBufferToClinet(4,itemNum,itemList,CurGiftIndex,PreGiftIndex,PreTimeCheck)
	--rfalse(CurGiftIndex .. "-".. PreGiftIndex.."-"..PreTimeCheck)	
end

--客户端请求连续登录奖励
function OnrecvLoginGiftList()
	local PreTimeCheck = LoadFromPlayerData(3) --玩家上次领礼包的时间
	local PreGiftIndex = LoadFromPlayerData(4) --玩家上次领的是第几个礼包
	local CurGiftIndex = LoadFromPlayerData(5) --玩家本次应该领第几个礼包

	--查看到了重置点没有
	local nRet = GetEveryDayPointByIndex(PreTimeCheck, 1)  --连续登录奖励索引号约定为1
	if(nRet == 1) then --重置点到了
		CurGiftIndex = CurGiftIndex+1
	end
	if(CurGiftIndex>7) then
		CurGiftIndex = 1
	end

	local itemList = LastLoginRewardList[CurGiftIndex]
	local itemNum = table.getn(itemList)/2
	
	if(CurGiftIndex == PreGiftIndex) then
		TalkToPlayer(2, "你已经领取了今天的登录奖励")
		SendGiftSucceed(4,3,CurGiftIndex)
		SendBufferToClinet(4,itemNum,itemList,CurGiftIndex,PreGiftIndex,PreTimeCheck)
		return 0
	end
	
	if (giveItemList(itemList) == 0) then
		TalkToPlayer(2, "背包空间不足，无法放置奖励道具！") --或者物品表配置有误
		SendGiftSucceed(4,0,CurGiftIndex)
		return 0
	end

	PreGiftIndex = CurGiftIndex
	
	SaveToPlayerData(3,os.time()) 		--保存当前已经领取过的奖励
	SaveToPlayerData(4,CurGiftIndex) 	--更新PreGiftIndex的值
	SaveToPlayerData(5,CurGiftIndex) 	

	SendGiftSucceed(4,1,CurGiftIndex)
	SendBufferToClinet(4,itemNum,itemList,CurGiftIndex,PreGiftIndex,PreTimeCheck)
end

--发送最后一个登陆奖励列表，（暂时没用到）
function SendLastLoginGiftList() 
	local currentloginindex = LoadFromPlayerData(3) 
	if (currentloginindex > 7) then
		currentloginindex = 1
	end
	local itemlist = LastLoginRewardList[currentloginindex]
	if (itemlist == nil) then
		TalkToPlayer(2, "获取登录奖励列表时意外出错")
		return 0
	end
	local itemnum = table.getn(itemlist)/2
	SendBufferToClinet(3,itemnum,itemlist,0,currentloginindex,0)
	rfalse("最后一个连续登陆奖励列表已经发送")	
end
---------------------------------------------------------------------------------------------------
