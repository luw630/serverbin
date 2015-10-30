-- 扩展背包处理

-- 扩展需求信息(可用物品激活也可用金钱激活，互斥的，先检测扣物品，若没有再判断金钱)
ActivePackageRequireInfo =
{
	--bFirstReduceItem = false, -- 是否先扣物品
	numactivedpertime = 6, -- 每次被激活的格子数量
	-- 需求物品
	needitem =
	{
		itemid = 900002, --8000001, -- 物品ID
		itemnum = 1, --物品数量
	},
	-- 需求金钱
	needmoney =
	{
		moneytype = 2, --钱类型
		moneynum = 0, --需求钱数量
	}
}

-- 功能：处理扩展背包请求
-- BaseActivedPackage最初始的背包格子数(24)
-- wExtGoodsActivedNum 当前已经激活的扩充格子数
-- wWillActiveNum 将激活的扩充格子数
-- wMaximumPackage 背包最大上限数目
function ActiveExtendPackage(BaseActivedPackage, wExtGoodsActivedNum, wWillActiveNum, wMaximumPackage)
	local wActivedNum = BaseActivedPackage + wExtGoodsActivedNum
	if wActivedNum + wWillActiveNum > wMaximumPackage then
		-- 需要激活的数量太多了，超过总数
		SendActivePackage(2, 0)
		return
	end
	-- 检测激活数量是否和发送数量一致
	if wWillActiveNum ~= ActivePackageRequireInfo.numactivedpertime then
		SendActivePackage(1, 0)
	end
	-- 是否能扣除对应的物品
	local iReduce = CheckGoods(ActivePackageRequireInfo.needitem.itemid, ActivePackageRequireInfo.needitem.moneynum,false)
	-- 扣除物品失败
	if iReduce == 0 then
		-- 是否能扣除消耗金钱
		iReduce = CheckPlayerMoney(ActivePackageRequireInfo.needmoney.moneytype, ActivePackageRequireInfo.needmoney.moneynum, false)
	end

	if iReduce ~= 0 and iReduce ~= nil then
		local startPos = wActivedNum
		local endPos = wActivedNum+wWillActiveNum
		local iAns = ActivePackage(startPos, endPos, 1)
		--成功, 第一个参数结果，第二个参数是当前激活的扩展背包总数
		SendActivePackage(0, endPos-BaseActivedPackage)
		rfalse("激活扩展背包成功了")
	else
		--没激活物品，也没有金钱
		SendActivePackage(1,0)
	end
end

gBaseActivedPackage = 24		--最初始的背包格子数
gMaximumPackage = 96			--背包最大上限数目
-- 功能：处理扩展背包请求
-- BaseActivedPackage最初始的背包格子数(24)
-- wExtGoodsActivedNum 当前已经激活的扩充格子数
-- wWillActiveNum 将激活的扩充格子数
-- wMaximumPackage 背包最大上限数目
function OnActiveExtendPackage( wWillActiveNum )
	local wExtGoodsActivedNum = GetActivePackageNum()
	if wWillActiveNum <= wExtGoodsActivedNum then
		return
	end
	rfalse("wExtGoodsActivedNum = "..wExtGoodsActivedNum.."wWillActiveNum = "..wWillActiveNum)
	local wActivedNum = gBaseActivedPackage + wExtGoodsActivedNum
	if wActivedNum + wWillActiveNum > gMaximumPackage then
		-- 需要激活的数量太多了，超过总数
		SendActivePackage(2, 0)
		return
	end
	local startPos = wActivedNum
	local endPos = wActivedNum+wWillActiveNum
	local iAns = ActivePackage(startPos, endPos, 1)
	--成功, 第一个参数结果，第二个参数是当前激活的扩展背包总数
	SendActivePackage(0, endPos-gBaseActivedPackage)
	rfalse("激活扩展背包成功了")
end




--update ly 2014/4/11
--最新的激活背包相关操作
BAsePackageCellNum = 11
gMaxPackage = 72

ActivePackageCell = {
--		格子倒计时时间        消耗金币
[12] = {NeeOnlineTiem = 180, NeedJinBi = 188},
[13] = {NeeOnlineTiem = 180, NeedJinBi = 188},
[14] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[15] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[16] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[17] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[18] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[19] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[20] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[21] = {NeeOnlineTiem = 180, NeedJinBi = 32,},
[22] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[23] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[24] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[25] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[26] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[27] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[28] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[29] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[30] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[31] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[32] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[33] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[34] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[35] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[36] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[37] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[38] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[39] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[40] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[41] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[42] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[43] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[44] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[45] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[46] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[47] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[48] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[49] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[50] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[51] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[52] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[53] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[54] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[55] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[56] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[57] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[58] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[59] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[60] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[61] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[62] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[63] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[64] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[65] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[66] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[67] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[68] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[69] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[70] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[71] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
[72] = {NeeOnlineTiem = 180, NeedJinBi = 188,},
}

PackageAwardList = {
--奖励金币,奖励游戏币,增加攻击点数，增加防御点数，增加健身点数（即增加基础最大生命和基础最大内力）, 增加内力，增加体力，增加真气
[12] = {0, 10000, 0, 0, 21, 0 , 0 , 0,},
[13] = {0, 10000, 5, 0, 0, 0 , 0 , 0,},
[14] = {0, 10000, 0, 5, 0, 0 , 0 , 0,},
[15] = {0, 10000, 0, 0, 21, 0 , 0 , 0,},
[16] = {0, 10000, 5, 0, 0, 0 , 0 , 0,},
[17] = {0, 10000, 0, 5, 0, 0 , 0 , 0,},
[18] = {0, 10000, 0, 0, 21, 0 , 0 , 0,},
[19] = {0, 15000, 6, 0, 0, 0 , 0 , 0,},
[20] = {0, 15000, 0, 6, 0, 0 , 0 , 0,},
[21] = {0, 15000, 0, 0, 42, 0 , 0 , 0,},
[22] = {0, 15000, 6, 0, 0, 0 , 0 , 0,},
[23] = {0, 15000, 0, 6, 0, 0 , 0 , 0,},
[24] = {0, 15000, 0, 0, 42, 0 , 0 , 0,},
[25] = {0, 15000, 6, 0, 0, 0 , 0 , 0,},
[26] = {0, 15000, 0, 6, 0, 0 , 0 , 0,},
[27] = {0, 15000, 0, 0, 42, 0 , 0 , 0,},
[28] = {0, 15000, 8, 0, 0, 0 , 0 , 0,},
[29] = {0, 15000, 0, 8, 0, 0 , 0 , 0,},
[30] = {0, 15000, 0, 0, 63, 0 , 0 , 0,},
[31] = {0, 15000, 8, 0, 0, 0 , 0 , 0,},
[32] = {0, 15000, 0, 8, 0, 0 , 0 , 0,},
[33] = {0, 15000, 0, 0, 63, 0 , 0 , 0,},
[34] = {0, 15000, 8, 0, 0, 0 , 0 , 0,},
[35] = {0, 15000, 0, 8, 0, 0 , 0 , 0,},
[36] = {0, 15000, 0, 0, 63, 0 , 0 , 0,},
[37] = {0, 15000, 11, 0, 0, 0 , 0 , 0,},
[38] = {0, 15000, 0, 11, 0, 0 , 0 , 0,},
[39] = {0, 15000, 0, 0, 72, 0 , 0 , 0,},
[40] = {0, 15000, 11, 0, 0, 0 , 0 , 0,},
[41] = {0, 15000, 0, 11, 0, 0 , 0 , 0,},
[42] = {0, 15000, 0, 0, 72, 0 , 0 , 0,},
[43] = {0, 15000, 11, 0, 0, 0 , 0 , 0,},
[44] = {0, 15000, 0, 11, 0, 0 , 0 , 0,},
[45] = {0, 15000, 0, 0, 72, 0 , 0 , 0,},
[46] = {0, 20000, 14, 0, 0, 0 , 0 , 0,},
[47] = {0, 20000, 0, 14, 0, 0 , 0 , 0,},
[48] = {0, 20000, 0, 0, 81, 0 , 0 , 0,},
[49] = {0, 20000, 14, 0, 0, 0 , 0 , 0,},
[50] = {0, 20000, 0, 14, 0, 0 , 0 , 0,},
[51] = {0, 20000, 0, 0, 81, 0 , 0 , 0,},
[52] = {0, 20000, 14, 0, 0, 0 , 0 , 0,},
[53] = {0, 20000, 0, 14, 0, 0 , 0 , 0,},
[54] = {0, 20000, 0, 0, 81, 0 , 0 , 0,},
[55] = {0, 20000, 22, 0, 0, 0 , 0 , 0,},
[56] = {0, 20000, 0, 22, 0, 0 , 0 , 0,},
[57] = {0, 20000, 0, 0, 99, 0 , 0 , 0,},
[58] = {0, 20000, 22, 0, 0, 0 , 0 , 0,},
[59] = {0, 20000, 0, 22, 0, 0 , 0 , 0,},
[60] = {0, 20000, 0, 0, 99, 0 , 0 , 0,},
[61] = {0, 20000, 22, 0, 0, 0 , 0 , 0,},
[62] = {0, 20000, 0, 22, 0, 0 , 0 , 0,},
[63] = {0, 20000, 0, 0, 103, 0 , 0 , 0,},
[64] = {0, 20000, 27, 0, 0, 0 , 0 , 0,},
[65] = {0, 20000, 0, 27, 0, 0 , 0 , 0,},
[66] = {0, 20000, 0, 0, 153, 0 , 0 , 0,},
[67] = {0, 20000, 27, 0, 0, 0 , 0 , 0,},
[68] = {0, 20000, 0, 27, 0, 0 , 0 , 0,},
[69] = {0, 20000, 0, 0, 153, 0 , 0 , 0,},
[70] = {0, 20000, 27, 0, 0, 0 , 0 , 0,},
[71] = {0, 20000, 0, 27, 0, 0 , 0 , 0,},
[72] = {0, 20000, 0, 0, 200, 0 , 0 , 0,},
}

--当前玩家为第一次注册登录,该函数调用在playerfunction.lua文件中的OnPlayerLogin函数中


function InitActiveTotalTime()
	local ActiveTotalTime = {TotalTime = 0}	--保存已经激活的扩展格子所用时间总和
	WeekReturnChargeData("ActiveTotalTime", ActiveTotalTime, gid);
end

function UpdateActiveTotalTime(AllTime, gid)
	--加载激活格子所用的总时间
	local ActiveTotalTime = LoadPlayerTable("ActiveTotalTime", gid)
	if ActiveTotalTime == nil then
		InitActiveTotalTime(gid)
	else
		ActiveTotalTime.TotalTime = AllTime
		WeekReturnChargeData("ActiveTotalTime", ActiveTotalTime, gid);
	end

end

function ReturnCountDownTime(ActiveCell, PlayerOnlineTime, gid)	--返回格子的倒计时时间
	--加载激活格子所用的总时间
	local ActiveTotalTime = LoadPlayerTable("ActiveTotalTime", gid)
	local TimeInterval = 1
	if ActiveTotalTime ~= nil and ActivePackageCell[ActiveCell].NeeOnlineTiem ~= 0 then
		TimeInterval = ActivePackageCell[ActiveCell].NeeOnlineTiem * 60 - (PlayerOnlineTime - ActiveTotalTime.TotalTime)
		if TimeInterval <= 0 then
			TimeInterval = 0
		end
	end
	return TimeInterval
end

function JudgeActivePackageCon(ActiveCell, PlayerOnlineTime, ActiveType, WillActiveNum)	--ActiveCell激活的格子起始索引，PlayerOnlineTime玩家当前总的在线时间, ActiveType为0表示累计时间到了激活, WillActiveNum将要激活格子的数量
	if ActiveType == 0 then
		local TimeInterval = ReturnCountDownTime(ActiveCell, PlayerOnlineTime, 0)
		if ActivePackageCell[ActiveCell].NeeOnlineTiem ~= 0 and TimeInterval == 0 then	--判断在线时间是否满足, 为在线时间激活;
			UpdateActiveTotalTime(PlayerOnlineTime, 0)
			return 1
		else
			return 0
		end
	else	--金币购买激活方式
		local AllConsumeMoney = 0
		for i = ActiveCell, ActiveCell + WillActiveNum - 1 do
			AllConsumeMoney = AllConsumeMoney + ActivePackageCell[i].NeedJinBi
		end
		local bMoneyEnough = CheckPlayerMoney(1, AllConsumeMoney, 1)
		if bMoneyEnough == 0 or bMoneyEnough == nil  then	--核对金币是否足够
			return 0
		else
			ChangeMoney(1, -AllConsumeMoney)	--消耗金币
			UpdateActiveTotalTime(PlayerOnlineTime, 0)
			return 1
		end
	end
end

function CalActivePackageAward(ActiveCell, WillActiveNum)
	local AwardAllJinBi = 0 	--奖励金币
	local AwardAllYinBi = 0 	--奖励游戏币
	local AddAllGongJi = 0
	local AddAllFangYu = 0
	local AddAllHp = 0
	local AddAllMp = 0
	local AddAllTp = 0
	local AddAllSp = 0
	local EndActiveCell = ActiveCell + WillActiveNum - 1
	for i = ActiveCell, EndActiveCell do
		AwardAllJinBi = AwardAllJinBi + PackageAwardList[i][1]
		AwardAllYinBi = AwardAllYinBi + PackageAwardList[i][2]
		AddAllGongJi = AddAllGongJi + PackageAwardList[i][3]
		AddAllFangYu = AddAllFangYu + PackageAwardList[i][4]
		AddAllHp = AddAllHp + PackageAwardList[i][5]
		AddAllMp = AddAllMp + PackageAwardList[i][6]
		AddAllTp = AddAllTp + PackageAwardList[i][7]
		AddAllSp = AddAllSp + PackageAwardList[i][8]
	end
	if AwardAllJinBi ~= 0 then 
		ChangeMoney(1, AwardAllJinBi)	--奖励金币
	end
	if AwardAllYinBi ~= 0 then
		ChangeMoney(2, AwardAllYinBi)	--奖励游戏币
	end
	if AddAllGongJi ~= 0 then
		NewSetPlayerProperty(0, 6, AddAllGongJi)	--增加基础攻击
	end
	if AddAllFangYu ~= 0 then
		NewSetPlayerProperty(0, 7, AddAllFangYu)	--增加基础防御
	end
	if AddAllHp ~= 0 then
		NewSetPlayerProperty(0, 9, AddAllHp)	--增加基础最大生命和基础最大内力
	end
	--[[if AddAllMp ~= 0 then
		NewSetPlayerProperty(0, 9, AddAllMp)	--增加基础最大内力
	end
	if AddAllTp ~= 0 then
		NewSetPlayerProperty(0, 7, AddAllTp)	--增加基础最大体力
	end
	if AddAllSp ~= 0 then
		NewSetPlayerProperty(0, 3, AddAllSp)	--增加真气
	end--]]
end

function ActivePackageOpt(ActiveCell, PlayerOnlineTime, ActiveType, WillActiveNum)
	if gMaxPackage < ActiveCell + WillActiveNum - 1 then
		return
	end
	local Con = JudgeActivePackageCon(ActiveCell, PlayerOnlineTime, ActiveType, WillActiveNum)
	if Con == 1 then

		CalActivePackageAward(ActiveCell, WillActiveNum)
		local iAns = ActivePackage(ActiveCell - 1, ActiveCell + WillActiveNum - 1, 1)	--在C++中的索引从0开始，而lua中为1开始，所以这里减1
		--成功, 第一个参数结果，第二个参数是当前激活的扩展背包总数
		SendActivePackage(0, ActiveCell - BAsePackageCellNum + WillActiveNum - 1)
	else
		--条件不满足, 第一个参数结果，第二个参数是当前激活的扩展背包总数
		if ActiveType == 1 then
			SendActivePackage(1, ActiveCell - BAsePackageCellNum + WillActiveNum - 1)
		end
	end
end
