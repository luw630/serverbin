--PlayerGloryInfo = {PlayerGloryDot = 0}; 	--保存玩家荣耀数据

--当前玩家为第一次注册登录,该函数调用在playerfunction.lua文件中的OnPlayerLogin函数中
function FirstLoginInitGloryData()
	--加载玩家荣耀数据
	local PlayerGloryInfo = LoadPlayerTable("PlayerGloryInfo", gid)
	if PlayerGloryInfo == nil then		--当前玩家为第一次注册登录
		PlayerGloryInfo = {PlayerGloryDot = 0, GloryInfArr = {}}
		--初始化玩家荣耀数据
		PlayerGloryInfo.GloryInfArr = InitNewPlayerGloryInfo(PlayerGloryInfo.GloryInfArr);
		--保存荣耀数据
		WeekReturnChargeData("PlayerGloryInfo", PlayerGloryInfo, gid);
	end
end

--请求荣耀信息的应答处理
function GetPlayerGloryInfo(gid)
	--加载玩家荣耀数据
	local PlayerGloryInfo = LoadPlayerTable("PlayerGloryInfo", gid)
	SendClientGloryInfo(PlayerGloryInfo)	--向客户端返回荣耀信息
end

--更改荣耀点数
function ChangeGloryDot(gid, ChangeValue)
	--加载玩家荣耀数据
	local PlayerGloryInfo = LoadPlayerTable("PlayerGloryInfo", gid)
	PlayerGloryInfo.PlayerGloryDot = PlayerGloryInfo.PlayerGloryDot + ChangeValue
	if PlayerGloryInfo.PlayerGloryDot < 0 then
		PlayerGloryInfo.PlayerGloryDot = 0
	end
	--保存荣耀数据
	WeekReturnChargeData("PlayerGloryInfo", PlayerGloryInfo, gid);
	return 1
end

--返回荣耀已经完成的数量
function ReturnGloryCompleteNum()
	--加载玩家荣耀数据
	local PlayerGloryInfo = LoadPlayerTable("PlayerGloryInfo", gid)
	if PlayerGloryInfo == nil then		--当前玩家为第一次注册登录
		return 0
	end
	return table.getn(PlayerGloryInfo.GloryInfArr);
end


--获取荣耀奖励处理
function GetGloryAward(GloryID, gid)
	--加载玩家荣耀数据
	local LoadPlayerGloryInfo = LoadPlayerTable("PlayerGloryInfo", gid)
	--获取奖励处理
	LoadPlayerGloryInfo = QstGetGloryAward(GloryID, LoadPlayerGloryInfo)
	--更新荣耀数据
	WeekReturnChargeData("PlayerGloryInfo", LoadPlayerGloryInfo, gid);
end

--称号消息处理
function HandleTitleMsg(MsgType, TitleID, gid)
	--加载玩家荣耀数据
	local LoadPlayerGloryInfo = LoadPlayerTable("PlayerGloryInfo", gid)
	--处理并更新荣耀点数据
	LoadPlayerGloryInfo = QstHandleTitleMsg(MsgType, TitleID, LoadPlayerGloryInfo);
	--更新荣耀数据
	WeekReturnChargeData("PlayerGloryInfo", LoadPlayerGloryInfo, gid);
end
