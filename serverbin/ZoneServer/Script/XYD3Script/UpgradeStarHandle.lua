--计算玩家升星消耗和增加玩家的相关属性
function ConsumeAndAddPlayerProperty(XingXiuID, UpgradeStarNum, MoneyType, PlayerVipLevel)
	if PlayerVipLevel > 0 then
		AddPlayerXinYangProperty(XingXiuID, UpgradeStarNum, MoneyType, 0)	--增加玩家的该星宿的属性, -1表示增加属性失败（升星有一定的概率性。Vip玩家没有概率性，100%成功），1表示成功。第二个参数表示是否有概率
	else
		AddPlayerXinYangProperty(XingXiuID, UpgradeStarNum, MoneyType, 1)	--没有概率
	end
end
