XWZTable 		 = {18,15,18,12,1,3,5,4,2,21,17,6}
PlayerAttriTable = {GPP_GONGJILI,GPP_FANGYULI,GPP_BAOJI,GPP_SHANBI,GPP_MAXHP,GPP_MAXMP,GPP_MAXTP,GPP_ATTSPEED,GPP_SPEED,GPP_SHANGHAIJIANMIAN,GPP_JUEDUISHANGHAI,GPP_WUSHIFANGYU}
LevelRewardList={} --等级奖励列表
LastLoginRewardList={} --连续登陆奖励列表

LevelRewardList[1] =
{
	RewardItem = {8021001,2,4030001,1,8021002,4},	--相应的奖励
	RewardLevel = 1									--奖励的等级
}
LevelRewardList[2] =
{
	RewardItem = {4030001,6,8021004,1,8021002,4},
	RewardLevel = 3
}
LevelRewardList[3] =
{
	RewardItem = {4030001,6,8021004,1,8021002,4},
	RewardLevel = 5
}
LevelRewardList[4] =
{
	RewardItem = {4030001,6,8021004,1,8021003,4},
	RewardLevel = 7
}

Gmaccountname = {"luwei","a13793591","lei020237"}


RewardTable ={}
RewardTable[REWARD_TOTAL] = --累计登录
{
	RewardList =
	{
		[1] = {4003001,1,4004001,1},
		[3] = {4003001,1,4004001,1},
	}

}

RewardTable[REWARD_CONTIN] =  --连续登录
{
 	RewardList =
	{
		[1] = {4003001,1,4004001,1},
		[3] = {4003001,1,4004001,1},
	},

	CallBackfunc = CallBack_Continu,
}

RewardTable[REWARD_CHENJIU] =  --成就奖励
{
 	RewardList =
	{
		[1] = {4003001,1,4004001,1},
		[3] = {4003001,1,4004001,1},
	}
}

RewardTable[REWARD_OFFLINE] =  --离线奖励
{
 	RewardList =
	{
		[1] = {4003001,1,4004001,1},
		[3] = {4003001,1,4004001,1},
	}
}

RewardTable[REWARD_BUCHANG] =  --补偿奖励
{
 	RewardList =
	{
		[1] = {4003001,1,4004001,1},
		[3] = {4003001,1,4004001,1},
	}
}

RewardTable[REWARD_CHONGZHI] =  --充值奖励
{
 	RewardList =
	{
		[1] = {4003001,1,4004001,1},
		[3] = {4003001,1,4004001,1},
	}
}

ExendPackageTable = {} --时间开启背包
ExendPackageTable[1] = 1
ExendPackageTable[2] = 1
ExendPackageTable[3] = 1
ExendPackageTable[4] = 1
ExendPackageTable[5] = 1




function GetPlayerXwZ()--修为值计算函数，直接返回修为值数值
	return 0
end

function OnPlayerLogin()--玩家登录后调用的函数
	UpdateplayerLogin()
	SendReward()
	OnNewPlayerLogin()
	JudgePlayerInRandList()		--判断玩家是否在排行榜数据中
	--检测一下扫荡
	CheckPlayerSD(GetPlayerData(0,GPP_QUANJUSID))
	PrintplayerIP(0)
	CheckTaskAccept() --上线检测能接取的任务
	CheckEveryDayTask() --日常任务检测
	PrintDebugLog()
	-- local pos  = GetPlayerData(0,GPP_QUANPOS)
	-- rfalse("x "..pos[1].." y "..pos[2])
	--发送失乐园活动开放标志
	SendDailyOpenFlag(ShiLeYuOpenTimeInf.OpenFlag, DAILY_SHILEYUAN)
	--发送神泉山活动开放标志
	SendDailyOpenFlag(SQSOpenTimeInf.OpenFlag, DAILY_SHENQUANSHAN)
	--发送财富山活动开放标志
	SendDailyOpenFlag(FortuneHillOpenTimeInf.OpenFlag, DAILY_FORTUNEHILL)
	--发送竞技场活动开放标志
	SendDailyOpenFlag(GymOpenTimeInf.OpenFlag, GYMKHANA_SENZHILEYUAN)

	--发送塔罗牌活动基本数据信息
	SendPlayerTarotData()

	--设置玩家当天每次登陆时的时间
	SetCurDayOnlineLoginTime()

	--发送玩家每日在线时长奖励数据
	SendPlayerCurDayOnlineData()

	--活动玩家累计登陆当前详细信息
	GetAddUpLoginDetailInf()

	--获取玩家充值回馈详细信息
	GetPlayerRFBInf()

	--获取玩家等级竞赛数据信息
	GetPlayerLevelRaceInf()

	--获取幸运摩天轮的数据信息(玩家登陆时获得的信息)
	GetFerrisWheelInf()

	--登陆同步玩家充值的总的金币数量
	LoginSynRechargeTatot()

end

--当角色掉线又上线时回调
function OnPlayerReLogin(  )
	OnPlayerLogin()
	if GetPlayerInScene() == 1 then
		local curhp = GetPlayerData(0,GPP_CURHP)
		local max =  GetPlayerData(GetPlayerGID(0),GPP_MAXHP)
		if curhp <= 1 then
			ChangeObjectData(GetPlayerGID(0),GPP_CURHP,max)
		end
		rfalse("OnPlayerReLogin"..GetPlayerData(0,GPP_MYName).."")
	end
end

function OnPlayerLevelUp()--玩家升级后调用的函数
	CheckEveryDayTask()
end

function OnPlayerLogout()--玩家离线时调用的函数
	PlayerLogoutUpdateRandData() 	--更新玩家的排行数据
	UpdateplayerLogin()
	OnRecvSQSceneLeave(GetPlayerData(0,GPP_QUANJUGID))  --离线离开关卡
	RemoveFromSD(GetPlayerData(0,GPP_QUANJUSID))    --玩家离线如果在扫荡列表，从列表中移除

	OnRecvSQLeaveDailyScene(GetPlayerData(0,GPP_QUANJUGID), 1)	--离线离开退出活动关卡

	--保存玩家下线时玩家当前总的在线时间
	SaveCurDayOnlineTime()
end

function OnPlayerRelive()--玩家复活后调用的函数
	local id = 49
	while(id<56) do
	PlayerAddBuff(id)
	id = id +1
	end
end

function OnNewPlayerLogin() --新手玩家登录游戏
	if GetIsNewPlayer() == 1 then
		local gid = GetPlayerData(0,GPP_QUANJUGID)
		if GetPlayerData(0,GPP_SCHOOL) == XS_WUYUE then      -- 人类
		local tempitem = {110101,110401,110501,110601,110701,110801}
			for k,v in pairs(tempitem) do
				local itempos = AddItem(v)
				if itempos >= 0 then
					RecvUseItem(itempos)	--装备
				end
			end
		elseif GetPlayerData(0,GPP_SCHOOL) == XS_SHUSHAN then  --狼人
			local tempitem = {120101,120401,120501,120601,120701,120801}
			for k,v in pairs(tempitem) do
				local itempos = AddItem(v)
				if itempos >= 0 then
					RecvUseItem(itempos)	--装备
				end
			end
		elseif GetPlayerData(0,GPP_SCHOOL) == XS_SHAOLIN then  --吸血鬼
			local tempitem = {130101,130401,130501,130601,130701,130801}
			for k,v in pairs(tempitem) do
				local itempos = AddItem(v)
				if itempos >= 0 then
					RecvUseItem(itempos)	--装备
				end
			end
		end
		--GiveGoods(110201,1)
		--GiveGoods(110301,1)
		--GiveGoods(9100003,1)
		--GiveGoods(9100201,1)
		--GiveGoods(9100202,1)
		--GiveGoods(9100006,1)
		--GiveGoods(9100203,1)
		--GiveGoods(120201,1)
		--GiveGoods(120301,1)
		--GiveGoods(130201,1)
		--GiveGoods(130301,1)
		--GiveGoods(9100007,1)
		--GiveGoods(190610,198)
		--GiveGoods(190600,30)
		--ChangeMoney(2,999998)
		--ChangeMoney(1,999998)
		--SetObjectData(gid,OBJDATA_SP,1999)
		--onRecvEnterSceneMap(1,1,0,1)
		CompleteScene(1,1,0)
		ServerCompleteScene(1,2)

	--初始化玩家充值金币总数数据
	InitPlayerRechargeGlodData()

	--初始化玩家幸运摩天轮数据
	InitPlayerFWData()

	--初始化充值回馈数据信息
	InitRFBData()

	--初始化玩家等级竞赛数据信息
	InitPlayerLevelRaceInf()
	
	--初始化玩家累计登陆相关数据
	InitAddUpLoginData()

	FLInitCurDayOnlineData()--新玩家第一次登陆初始化玩家每日在线时长相关数据
	--add by ly 2014/4/4 第一次注册的玩家荣耀数据初始化
	FirstLoginInitGloryData()
	InitActiveTotalTime()
	InitPlayerDailyData(nil, 0)		--初始化玩家日常活动数据
	InitEveryDaySignInData()	--初始化玩家每日签到所需数据，保存玩家当前没有领取的签到奖励ID和状态
	InitPlayerSkill()	--初始化技能
	InitPlayerVipData(nil, 0) 		--初始化玩家VIP数据
	local MaxTp = GetPlayerData(0, 17)	--获取玩家最多体力
	Setplayerproperty(20, MaxTp)	--设置玩家第一次注册后的体力
	local max =  GetPlayerData(GetPlayerGID(0),GPP_MAXHP)
	ChangeObjectData(GetPlayerGID(0),GPP_CURHP,max)
	end
end

--add by ly 2014/4/30 根据玩家类别分配相应的技能给玩家（玩家注册时调用）
function InitPlayerSkill()
	local PlayerSchool = GetPlayerSchool()	--3表示吸血鬼、2表示狼人、1表示人类
	if PlayerSchool == 3 then
		--普通攻击3连接
		ActiveSkill(1)
		ActiveSkill(2)
		ActiveSkill(3)
		--普通技能
		ActiveSkill(11101)
		ActiveSkill(11102)
		ActiveSkill(11103)
		ActiveSkill(11104)

		--配置三种心态下的第一个技能到技能面板中
		FirstRegCallSetPlayerSkill(11101, 0, 0)	--该函数参数依次为普通普能、变身1技能，变身2技能
	elseif PlayerSchool == 2 then
		--普通攻击3连接
		ActiveSkill(4)
		ActiveSkill(5)
		ActiveSkill(6)
		--普通技能
		ActiveSkill(12101)
		ActiveSkill(12102)
		ActiveSkill(12103)
		ActiveSkill(12104)
		--配置三种心态下的第一个技能到技能面板中
		FirstRegCallSetPlayerSkill(12101, 0, 0) --该函数参数依次为普通普能、变身1技能，变身2技能
	else 	--当玩家不为3和2时，则默认分配人类的技能给玩家
		--普通攻击3连接
		ActiveSkill(7)
		ActiveSkill(8)
		ActiveSkill(9)
		--普通技能
		ActiveSkill(13101)
		ActiveSkill(13102)
		ActiveSkill(13103)
		ActiveSkill(13104)
		--配置三种心态下的第一个技能到技能面板中
		FirstRegCallSetPlayerSkill(13101, 0, 0)	--该函数参数依次为普通普能、变身1技能，变身2技能
	end
	--奥义技能
	ActiveSkill(30001)
	ActiveSkill(30002)
	ActiveSkill(30003)
	ActiveSkill(30004)
	ActiveSkill(30005)
end

function OnPlayerSendInitMsg()
	--ProcessEveryDay()
end

function CheckOnRunTime(onlinetime)
	-- local LastLeavetime = GetPlayerTime(1) --上次离线时间
	-- local currenttime = GetPlayerTime(3) --当前时间
	-- local currentLogin = GetPlayerTime(2) --本次登录时间

	-- currentLogin = currenttime - currentLogin

	-- local tatolactive = 0			--背包累计激活数量
	-- local endactive = 0				--需要的激活格子数量

	-- for k,v in pairs(ExendPackageTable) do
	-- 	if currentLogin >= k * 60  then
	-- 		tatolactive = tatolactive + v
	-- 		endactive = v
	-- 	end
	-- end
	-- --rfalse("tatolactive"..tatolactive)
	-- if tatolactive > 0 then
	-- 	OnActiveExtendPackage(tatolactive)
	-- end
end

function CheckGift(onlinetime)
end


function GetPlayerLimit()
	local accountname = GetPlayerData(0,GPP_MYACCOUNT)
	local accountnum = table.getn(Gmaccountname)
	local index = 1
	while(index <= accountnum) do
		if(accountname == Gmaccountname[index]) then
			return 5
		end
		index = index + 1
	end
	return 1
end

function QuestTaskNpcMove(npcid)
	for k, v in pairs(npc) do
		if(v[1] == npcid) then
			PutPlayerTo(v[2],v[3]/32,v[4]/32,0,0)
			break
		end
	end
end

--在玩家复活时的金钱检查
function OnReliveCheckPlayerMoney(Playerpoint,nouse)
	return CheckPlayerMoney(2,10*Playerpoint,0)
end

--发送等级奖励
function SendLevelGiftList()
	local curretLevel = LoadFromPlayerData(2) --当前应当领取的等级奖励
	local Level = GetPlayerData(0,GPP_LEVEL) --玩家等级
	for k, v in pairs(LevelRewardList) do
		if (curretLevel < v.RewardLevel ) then
			local itemnum = table.getn(v.RewardItem)/2
			SendBufferToClinet(2,itemnum,v.RewardItem,1,v.RewardLevel,curretLevel)
			break
		end
	end
	local tablenum = table.getn(LevelRewardList)
	if(curretLevel >= LevelRewardList[tablenum].RewardLevel) then
		SendGiftSucceed(2,3,0)
		rfalse("最后一个等级奖励列表")
		SendLastLevelGiftList()
	end
end

function SendLastLevelGiftList() --发送最后一个等级奖励列表
	local index = table.getn(LevelRewardList)
	local itemnum = table.getn(LevelRewardList[index].RewardItem)/2
	SendBufferToClinet(2,itemnum,LevelRewardList[index].RewardItem,0,LevelRewardList[index].RewardLevel,0)
	rfalse("发送最后一个等级奖励列表")
end

--客户端请求获取等级奖励
function OnrecvLevelGiftList()
	local Level = GetPlayerData(0,GPP_LEVEL) --玩家等级
	local curretLevel = LoadFromPlayerData(2) --当前应当领取的等级奖励
	for k, v in pairs(LevelRewardList) do
		if (curretLevel < v.RewardLevel and Level >= v.RewardLevel) then
			local itemnum = table.getn(v.RewardItem)/2
			if (giveItemList(v.RewardItem) == 0) then
				TalkToPlayer(2, "背包空间不足，无法放置奖励道具！")
				SendGiftSucceed(2,0,0)
				return 0
			end
				SendGiftSucceed(2,1,0)
				SaveToPlayerData(2,v.RewardLevel) --保存当前已经领取过的等级奖励
				SendLevelGiftList()
				break
		end
	end
end


function SavePlayerConLoginDay(logindate)--保存当前玩家当前连续登录的次数,在离线时调用
	local currentloginindex = LoadFromPlayerData(3)
	if(logindate == 0) then
		currentloginindex = 1
	end

	local nowdate = tonumber(os.date("%Y%m%d",os.time()))
	local weekday = tonumber(os.date("%Y%m%d",logindate))



	local passtime = os.time() - logindate

	if(weekday ~= nowdate)then
		ResetOnlineGiftState() --清除在线奖励礼包的领取
		ResetJingMaiShareExpTimes() -- 重新设置经脉充穴成功经验分享次数
		local nexttime = logindate + 24 * 60 *60
		local nextday = tonumber(os.date("%Y%m%d",nexttime))
		if(nextday ~= nowdate) then
			currentloginindex = 1	--不是同一天连续登陆从新计算
		else
			currentloginindex = currentloginindex +1
		end
	end

	SaveToPlayerData(3,currentloginindex) 	--保存当前玩家当前连续登录的次数
	rfalse("玩家当前连续登录的次数 "..currentloginindex.."")
end

-- 重设每日经脉充穴成功经验分享次数
function ResetJingMaiShareExpTimes()
	local shareExpTimes = 24
	SetJingMaiShareExpTimes(shareExpTimes);
end


function SaveMyDate()	--保存数据
	local nddsds = {11,889,31,3435,21001,88}
	local xnddsds = {}
	SavePlayerData("10021","xnddsds",xnddsds)
end

function LoadMyData( )
    local ntdata = LoadPlayerData("10021","xnddsds")
	--local ntdata = LoadPlayerData("10012","ndatatw")
	for k,v in pairs(ntdata) do
		rfalse("key = "..k.."  value ="..v)
	end
end



--加点配置
function GetPlayerBaseProperties(propertyid)
--0 基础最大生命 1 基础最大内力 2 基础最大体力 3基础攻击 4基础防御 5基础暴击 6 基础躲避 7 移动速度 8 攻击速度
	local JianshenData = GetPlayerData(0,GPP_JIANSHEN) --当前强健点数
	local FangyuData = GetPlayerData(0,GPP_FANGYU) -- 当前防御点数
	local JinggongData = GetPlayerData(0,GPP_JIGONGPOINT) --当前进攻点数
	local QingshenData = GetPlayerData(0,GPP_QINGSHEN) --当前轻功点数
	if(propertyid == 0) then
		return JianshenData * 1
	elseif(propertyid == 1) then
		return JianshenData * 1
	elseif(propertyid == 2) then
		return 0
	elseif(propertyid == 3) then
		return JinggongData * 1
	elseif(propertyid == 4) then
		return FangyuData * 1
	elseif(propertyid == 5) then
		return QingshenData * 1
	elseif(propertyid == 6) then
		return QingshenData * 1
	elseif(propertyid == 7) then
		return QingshenData * 1
	elseif(propertyid == 8) then
		return QingshenData * 1
	else
		return 0
	end
end

--归元气
function calculateSpAndExpByTime(sec)
	local sp = 0;
	local exp = 0;
	--INT64 t = 0;
	local i = 3;		--3小时为一阶段
	local j = 90;		--第一阶段为90秒加一次，每阶段减10秒
	local k = 10;		--第一阶段加10点经验,每阶段多加10点
	local n = 3  		--真气加3点
	while(true) do
		if (i > 12)	then	--大于12小时不再累积
			break;
		end
		local temp = i * 3600;
		local temp1 = (i-3) * 3600;
		if (sec > temp) then
			local temp2 = (temp - temp1)/j;
			sp =sp + temp2 * n;
			exp =exp + temp2*k;
		else
			local temp2 = (sec - temp1)/j;
			sp =sp + temp2 * n;
			exp =exp + temp2*k;
			break;
		end
		i =i + 3
		j = j - 10
		k =k + 10
	end
	return sp,exp
end

function disposeplayerdead(playergid,reginid,mapID)--处理玩家死亡相关
	if PlayerDeadList == nil then
		PlayerInit()
	end

	--add by ly 2014/4/22
	if GetPlayerInDailyArea() then		--如果玩家在日常活动场景中不复活玩家，当退出日常活动场景后复活玩家
		return
	end

	--rfalse("disposeplayerdead reginid = "..reginid.."mapID = "..mapID)
	local ReliveCost = 0   --死亡花费钱
	local deadcount = 0  --死亡次数
	local activityAttkCost = 10 --激发攻击
	local activityDefenceCost = 20 --激发防御
	local wX = 17    --1号地图坐标
	local wY = 45

	local bisinScene = false
	local playersceneindex = 0
	if GetPlayerInScene() then --正在关卡场景中
		local playerscene = LoadPlayerTable(PlayerSceneData)		--关卡，章节,评分,以及次数限制
		if playerscene == nil then
			rfalse("playerscene nil")
			return
		end
		if playerscene.deadcount ~= nil then
			playerscene.deadcount = playerscene.deadcount + 1
			deadcount = playerscene.deadcount
			for k,v in pairs(SceneManager) do
				if v.Playerlist == playergid then
					local sceneindex = v.sceneindex   --当前正在通关的关卡
					local scenemap = v.scenemap 		--当前正在通关的章节
					local scmap = SceneMapTable[scenemap][sceneindex]	--关卡地图数据
					if scmap ~= nil then
						ReliveCost = scmap.relivemoney 		--取得关卡的死亡花费
						wX = scmap.relivePostion[1]
						wY = scmap.relivePostion[2]
					end
					playersceneindex = sceneindex
				end
			end
		end
		WeekReturnChargeData(PlayerSceneData,playerscene)
		bisinScene = true
	end
	local wFreeReliveTime = relivetime * deadcount  --死亡复活冷却时间 * 死亡次数
	local sid = GetPlayerData(0,GPP_QUANJUSID)
	if PlayerDeadList[sid] == nil then
		PlayerDeadList[sid] = {}
	end
	local deadpos  = GetPlayerData(0,GPP_QUANPOS)
	PlayerDeadList[sid].wFreeReliveTime = wFreeReliveTime  --免费复活冷却时间
	PlayerDeadList[sid].ReliveCost = ReliveCost
	PlayerDeadList[sid].activityAttkCost = activityAttkCost
	PlayerDeadList[sid].activityDefenceCost = activityDefenceCost
	PlayerDeadList[sid].DeadTime = os.time()     --死亡时间
	PlayerDeadList[sid].reginid = reginid
	PlayerDeadList[sid].mapID = mapID
	PlayerDeadList[sid].wreliveX = wX 		--复活的坐标
	PlayerDeadList[sid].wreliveY = wY
	PlayerDeadList[sid].wdeadX = deadpos[1]      --死亡坐标
	PlayerDeadList[sid].wdeadY = deadpos[2]
	if bisinScene == true then
		if wFreeReliveTime ~= nil and ReliveCost ~= nil and activityAttkCost ~= nil and activityDefenceCost ~= nil then
			SendPlayerDeadAddMsg(wFreeReliveTime,ReliveCost,activityAttkCost,activityDefenceCost)
		else
			rfalse("SendPlayerDeadAddMsg nil ")
		end
	else
		PlayerQuestRelive(0,playergid)
	end

	if playersceneindex == 1 then  --特殊关卡处理
		--PlayerQuestRelive(0,playergid)
		CompleteScene(1,1,0)
		ServerCompleteScene(1,1)
		--OnRecvSQSceneLeave(playergid)
		return
	end
end


function PlayerQuestRelive(relivetype,playergid) --玩家请求复活 1 免费入口复活 2 花钱原地复活

	if PlayerDeadList ~= nil then
		local sid = GetPlayerData(playergid,GPP_QUANJUSID)
		local gid = GetPlayerData(playergid,GPP_QUANJUGID)
		if PlayerDeadList[sid] ~= nil then
			local relivetable = {}
			relivetable.regionID = PlayerDeadList[sid].mapID
			relivetable.type = relivetype
			if relivetype == 1 then
				relivetable.wX = PlayerDeadList[sid].wreliveX
				relivetable.wY = PlayerDeadList[sid].wreliveY
				if PlayerDeadList[sid].wFreeReliveTime > 0 then
					local DeadTime = PlayerDeadList[sid].DeadTime
					local difftime = os.difftime(os.time(),DeadTime)
					if difftime < PlayerDeadList[sid].wFreeReliveTime then
						rfalse("wait FreeReliveTime "..PlayerDeadList[sid].wFreeReliveTime)
						TalkToPlayer(2,"wait FreeReliveTime")
						SendReliveResult(sid,1)    --0 复活成功 1 复活失败 冷却时间不足 2复活失败 金钱不足
						return
					end
				end
				PlayerRelive(sid,relivetable)
				rfalse("PlayerQuestRelive  type = "..relivetype.." gid = "..playergid.."")
			elseif relivetype == 2 then
				relivetable.wX = PlayerDeadList[sid].wdeadX
				relivetable.wY = PlayerDeadList[sid].wdeadY
				if GetPlayerData(playergid,GPP_MYMONEY) < PlayerDeadList[sid].ReliveCost then
					rfalse("money not enough")
					TalkToPlayer(2,MystringFormat("NOGOLD"))
					SendReliveResult(sid,2)    --0 复活成功 1 复活失败 冷却时间不足 2复活失败 金钱不足
					return
				end
				rfalse("money cost "..PlayerDeadList[sid].ReliveCost)
				PlayerRelive(sid,relivetable)
				AddBuff(gid,5012)
			else
				relivetable.wX = PlayerDeadList[sid].wreliveX
				relivetable.wY = PlayerDeadList[sid].wreliveY
				--printtable(relivetable)
				PlayerRelive(sid,relivetable)
				rfalse("PlayerQuestRelive  type = "..relivetype.." gid = "..playergid.."")
			end
		end
	end
end

function PlayerInit()
	if PlayerDeadList == nil then  --死亡的玩家列表
		PlayerDeadList = {}
	end


end

function PrintplayerIP(account)
	local ip = GetPlayerIP(account)
	if account == 0 then
		if ip ~= nil then
			rfalse("Name:["..GetPlayerData(0,GPP_MYName).."] Is Login  IP:"..ip.."")

		end
	else
		if ip ~= nil then
			rfalse("Account: ["..account.."]  Is Login IP:"..ip.."")
		end
	end
	local pos  = GetPlayerData(0,GPP_CURPOS)
	rfalse("LoginPos:   "..pos[1].."  "..pos[2])

end

function OnRecvUpdateSkill(skillid ) --玩家技能升级成功时的回调
	OnTaskCallBack(TASK_SKILL,1,0)
end

function OnPlayerXinYangUpdate(SuccessNum) --玩家信仰之力升级成功
	if SuccessNum > 0 then
		OnTaskCallBack(TASK_XINYANG,SuccessNum,0)
	end
end

 function Getfightpower(objtable) --战斗力
 	local x = objtable.MaxHp*1 + objtable.GongJi*6 + objtable.FangYu*3 + objtable.Hit*2 + objtable.ShanBi*2 + objtable.BaoJi*8.22 + objtable.Uncrit*8.22 + objtable.Wreck*8.22 + objtable.Unwreck*8.22 + objtable.Puncture*8.22 + objtable.Unpuncture*8.22
    return x
 end

 function PrintDebugLog()
 	local currenttp = GetPlayerData(0,GPP_CURTP)				--取得体力扣除
 	local maxtp = GetPlayerData(0,GPP_MAXTP)				--取得体力扣除
 	local cname = GetPlayerData(0,GPP_MYName)
 	rfalse("Player:[ "..cname.." ] TP = "..currenttp.."  maxtp = "..maxtp.."")
end
PlayerInit()


function OnPlayerBuyTp()
	
	local viplevel = GetPlayerData(0,GPP_VIPLEVEL)
	local playertpdata = LoadPlayerTable("PLAYERTPDATA")
	if playertpdata == nil then
		playertpdata = {}
		playertpdata.buycount = 0   --购买次数 
		playertpdata.buytime = 0    --购买时间
	end
	viplevel = viplevel + 1
	if VIPBuyTp == nil then
		return
	end

	if playertpdata.buytime > 0 then  --根据购买时间重置购买次数以及时间
		local nowdate = tonumber(os.date("%Y%m%d",os.time()))
		local buydate = tonumber(os.date("%Y%m%d",playertpdata.buytime))
		if nowdate - buydate > 0 then   --超过1天，次数重置
			playertpdata.buytime = 0
			playertpdata.buycount = 0 
		end
	end


	if VIPBuyTp[viplevel] ~= nil then
		local count = GetTableLenth(VIPBuyTp[viplevel])
		if playertpdata.buycount + 1 > count then    --当前购买次数大于允许购买次数
			local str = MystringFormat("NOMATCH")
			TalkToPlayer(2,str)
		else
			if OnBuyTp(viplevel,playertpdata.buycount + 1) == true then  --购买成功
				playertpdata.buytime = os.time()
				playertpdata.buycount = playertpdata.buycount + 1
			end
		end
	end
	WeekReturnChargeData("PLAYERTPDATA",playertpdata)
end

function OnBuyTp(viplevel,buycount)
	local gid = GetPlayerData(0,GPP_QUANJUGID)
	local goldmoney = GetPlayerData(0,GPP_MYMONEY)
	local playercurenttp = GetPlayerData(0,GPP_CURTP)
	local playermaxtp = GetPlayerData(0,GPP_MAXTP)
	rfalse("playercurenttp = "..playercurenttp.."  playermaxtp = "..playermaxtp.."")

	if VIPBuyTp[viplevel] ~= nil then
		local buycountdata = VIPBuyTp[viplevel][buycount]
		if buycountdata ~= nil then
			if goldmoney < buycountdata[2] then
				local str = MystringFormat("NOGOLD")
				TalkToPlayer(2,str)
				return false
			end

			if playercurenttp + buycountdata[1] > playermaxtp then
				local str = MystringFormat("TILISHANGXIAN")
				TalkToPlayer(2,str)
				return false
			end
			ChangeMoney(1,-buycountdata[2])
			ChangeObjectData(gid,GPP_CURTP,buycountdata[1])
			return true
		end
	end
	return false
end