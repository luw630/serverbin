local ChargeTreasure =   --充值聚宝盆，数据local本地化，防止重命名是出错
{
	[1] = {Chargenum = 88,Range = {188,188}},
	[2] = {Chargenum = 288,Range = {488,488}},
	[3] = {Chargenum = 1088,Range = {1500,1588}},
	[4] = {Chargenum = 2588,Range = {3000,3088}},
	[5] = {Chargenum = 4588,Range = {5000,5088}},
	[6] = {Chargenum = 6666,Range = {7400,7468}},
	[7] = {Chargenum = 8888,Range = {10200,10228}},
}

ChargeActivity =  Activitymodule:new()
ChargeActivity:Init(1)
ActivityRegister(ChargeActivity)
PlayerChargeData = ChargeActivity:LoadData()	--玩家的聚宝盆数据

function ChargeActivity:OnTrigger(actParam) --当触发时做的事情,根据需要传递不同的参数，活动不同可以传递不同
	look("MyActivity OnTrigger "..self.ActivityID.."   Type "..self.ActivityType.."   name "..self.ActivityName)
	--self:ChargeGiveItem(100,1000)
end

function ChargeActivity:OnActivityOpened( actParam )----当活动开启时,清除数据
	PlayerChargeData = {}
	self:SaveData(PlayerChargeData)
end


function OnTriggerTreasure(bTreasureType,sid) --玩家点击聚宝盆
--	look("OnTriggerTreasure "..bTreasureType.."    "..sid)
	local actmodule = ActivityGetmodulebyIndex(1000)  --自己的活动ID，可以定义为枚举方便识别
	if actmodule ~= nil then
		if actmodule.ActivityEnable == false then   --活动关闭
			SendTreasureResult(sid,0,4,0)
			return
		end

		if bTreasureType == 0 then
			local bTreasureIndex = actmodule:GetTreasureIndex(sid)
			SendTreasureResult(sid,bTreasureIndex,0,0)
			--look("SendTreasureResult "..bTreasureIndex)
		else
			actmodule:ChargeGiveItem(sid)
		end
	end
end

function ChargeActivity:GetTreasureIndex(sid) --获取当前应该购买的聚宝盆索引
	local lastTreasureIndex = 0          --记录的聚宝盆抽取记录
	if PlayerChargeData ~= nil then
		if PlayerChargeData[sid] ~= nil then
			lastTreasureIndex = PlayerChargeData[sid]
		else
			PlayerChargeData[sid] = lastTreasureIndex
		end
	end
	return lastTreasureIndex
end


function ChargeActivity:ChargeGiveItem(sid) --玩家充值后领取奖励
	if ChargeTreasure == nil then
		return
	end

	look("ChargeActivity:ChargeGiveItem")

	local lastTreasureIndex = self:GetTreasureIndex(sid)          --记录的聚宝盆抽取记录

	local gold = CI_GetPlayerDataSG(sid,2) --元宝数量

	if lastTreasureIndex + 1 > #ChargeTreasure then   --抽完了
		look(" lastTreasureIndex + 1 >  "..#ChargeTreasure)
		SendTreasureResult(sid,lastTreasureIndex,3,0)
		return
	end

	lastTreasureIndex = lastTreasureIndex + 1
	local Chargetable = ChargeTreasure[lastTreasureIndex]
	if gold < Chargetable.Chargenum then
		look("gold < Chargenum "..gold.."    "..Chargetable.Chargenum)
		SendTreasureResult(sid,lastTreasureIndex,2,0)
		return
	end
	CI_DecGoods_SG(2,0,Chargetable.Chargenum)
	local randnum = math.random(Chargetable.Range[1],Chargetable.Range[2])
	CI_AddGoods_SG(2,0,randnum)
	PlayerChargeData[sid] = lastTreasureIndex
	self:SaveData(PlayerChargeData)
	SendTreasureResult(sid,lastTreasureIndex,1,randnum)
	look("ChargeGiveItem sucess "..randnum)
end

function ChargePlayer( sid,mtype,num )
	CI_AddGoods_SG(mtype,0,num,0,sid)
	ChargetGetMoney(sid,mtype)
end

function ChargetGetMoney( sid,mtype )
	local gold = CI_GetPlayerDataSG(sid,mtype) --元宝数量
	look("ChargetGetMoney "..gold)
end