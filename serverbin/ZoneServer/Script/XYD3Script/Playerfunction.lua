XWZTable 		 = {18,15,18,12,1,3,5,4,2,21,17,6}
PlayerAttriTable = {GPP_GONGJILI,GPP_FANGYULI,GPP_BAOJI,GPP_SHANBI,GPP_MAXHP,GPP_MAXMP,GPP_MAXTP,GPP_ATTSPEED,GPP_SPEED,GPP_SHANGHAIJIANMIAN,GPP_JUEDUISHANGHAI,GPP_WUSHIFANGYU}
LevelRewardList={} --�ȼ������б�
LastLoginRewardList={} --������½�����б�

LevelRewardList[1] =
{
	RewardItem = {8021001,2,4030001,1,8021002,4},	--��Ӧ�Ľ���
	RewardLevel = 1									--�����ĵȼ�
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
RewardTable[REWARD_TOTAL] = --�ۼƵ�¼
{
	RewardList =
	{
		[1] = {4003001,1,4004001,1},
		[3] = {4003001,1,4004001,1},
	}

}

RewardTable[REWARD_CONTIN] =  --������¼
{
 	RewardList =
	{
		[1] = {4003001,1,4004001,1},
		[3] = {4003001,1,4004001,1},
	},

	CallBackfunc = CallBack_Continu,
}

RewardTable[REWARD_CHENJIU] =  --�ɾͽ���
{
 	RewardList =
	{
		[1] = {4003001,1,4004001,1},
		[3] = {4003001,1,4004001,1},
	}
}

RewardTable[REWARD_OFFLINE] =  --���߽���
{
 	RewardList =
	{
		[1] = {4003001,1,4004001,1},
		[3] = {4003001,1,4004001,1},
	}
}

RewardTable[REWARD_BUCHANG] =  --��������
{
 	RewardList =
	{
		[1] = {4003001,1,4004001,1},
		[3] = {4003001,1,4004001,1},
	}
}

RewardTable[REWARD_CHONGZHI] =  --��ֵ����
{
 	RewardList =
	{
		[1] = {4003001,1,4004001,1},
		[3] = {4003001,1,4004001,1},
	}
}

ExendPackageTable = {} --ʱ�俪������
ExendPackageTable[1] = 1
ExendPackageTable[2] = 1
ExendPackageTable[3] = 1
ExendPackageTable[4] = 1
ExendPackageTable[5] = 1




function GetPlayerXwZ()--��Ϊֵ���㺯����ֱ�ӷ�����Ϊֵ��ֵ
	return 0
end

function OnPlayerLogin()--��ҵ�¼����õĺ���
	UpdateplayerLogin()
	SendReward()
	OnNewPlayerLogin()
	JudgePlayerInRandList()		--�ж�����Ƿ������а�������
	--���һ��ɨ��
	CheckPlayerSD(GetPlayerData(0,GPP_QUANJUSID))
	PrintplayerIP(0)
	CheckTaskAccept() --���߼���ܽ�ȡ������
	CheckEveryDayTask() --�ճ�������
	PrintDebugLog()
	-- local pos  = GetPlayerData(0,GPP_QUANPOS)
	-- rfalse("x "..pos[1].." y "..pos[2])
	--����ʧ��԰����ű�־
	SendDailyOpenFlag(ShiLeYuOpenTimeInf.OpenFlag, DAILY_SHILEYUAN)
	--������Ȫɽ����ű�־
	SendDailyOpenFlag(SQSOpenTimeInf.OpenFlag, DAILY_SHENQUANSHAN)
	--���ͲƸ�ɽ����ű�־
	SendDailyOpenFlag(FortuneHillOpenTimeInf.OpenFlag, DAILY_FORTUNEHILL)
	--���;���������ű�־
	SendDailyOpenFlag(GymOpenTimeInf.OpenFlag, GYMKHANA_SENZHILEYUAN)

	--���������ƻ����������Ϣ
	SendPlayerTarotData()

	--������ҵ���ÿ�ε�½ʱ��ʱ��
	SetCurDayOnlineLoginTime()

	--�������ÿ������ʱ����������
	SendPlayerCurDayOnlineData()

	--�����ۼƵ�½��ǰ��ϸ��Ϣ
	GetAddUpLoginDetailInf()

	--��ȡ��ҳ�ֵ������ϸ��Ϣ
	GetPlayerRFBInf()

	--��ȡ��ҵȼ�����������Ϣ
	GetPlayerLevelRaceInf()

	--��ȡ����Ħ���ֵ�������Ϣ(��ҵ�½ʱ��õ���Ϣ)
	GetFerrisWheelInf()

	--��½ͬ����ҳ�ֵ���ܵĽ������
	LoginSynRechargeTatot()

end

--����ɫ����������ʱ�ص�
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

function OnPlayerLevelUp()--�����������õĺ���
	CheckEveryDayTask()
end

function OnPlayerLogout()--�������ʱ���õĺ���
	PlayerLogoutUpdateRandData() 	--������ҵ���������
	UpdateplayerLogin()
	OnRecvSQSceneLeave(GetPlayerData(0,GPP_QUANJUGID))  --�����뿪�ؿ�
	RemoveFromSD(GetPlayerData(0,GPP_QUANJUSID))    --������������ɨ���б����б����Ƴ�

	OnRecvSQLeaveDailyScene(GetPlayerData(0,GPP_QUANJUGID), 1)	--�����뿪�˳���ؿ�

	--�����������ʱ��ҵ�ǰ�ܵ�����ʱ��
	SaveCurDayOnlineTime()
end

function OnPlayerRelive()--��Ҹ������õĺ���
	local id = 49
	while(id<56) do
	PlayerAddBuff(id)
	id = id +1
	end
end

function OnNewPlayerLogin() --������ҵ�¼��Ϸ
	if GetIsNewPlayer() == 1 then
		local gid = GetPlayerData(0,GPP_QUANJUGID)
		if GetPlayerData(0,GPP_SCHOOL) == XS_WUYUE then      -- ����
		local tempitem = {110101,110401,110501,110601,110701,110801}
			for k,v in pairs(tempitem) do
				local itempos = AddItem(v)
				if itempos >= 0 then
					RecvUseItem(itempos)	--װ��
				end
			end
		elseif GetPlayerData(0,GPP_SCHOOL) == XS_SHUSHAN then  --����
			local tempitem = {120101,120401,120501,120601,120701,120801}
			for k,v in pairs(tempitem) do
				local itempos = AddItem(v)
				if itempos >= 0 then
					RecvUseItem(itempos)	--װ��
				end
			end
		elseif GetPlayerData(0,GPP_SCHOOL) == XS_SHAOLIN then  --��Ѫ��
			local tempitem = {130101,130401,130501,130601,130701,130801}
			for k,v in pairs(tempitem) do
				local itempos = AddItem(v)
				if itempos >= 0 then
					RecvUseItem(itempos)	--װ��
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

	--��ʼ����ҳ�ֵ�����������
	InitPlayerRechargeGlodData()

	--��ʼ���������Ħ��������
	InitPlayerFWData()

	--��ʼ����ֵ����������Ϣ
	InitRFBData()

	--��ʼ����ҵȼ�����������Ϣ
	InitPlayerLevelRaceInf()
	
	--��ʼ������ۼƵ�½�������
	InitAddUpLoginData()

	FLInitCurDayOnlineData()--����ҵ�һ�ε�½��ʼ�����ÿ������ʱ���������
	--add by ly 2014/4/4 ��һ��ע��������ҫ���ݳ�ʼ��
	FirstLoginInitGloryData()
	InitActiveTotalTime()
	InitPlayerDailyData(nil, 0)		--��ʼ������ճ������
	InitEveryDaySignInData()	--��ʼ�����ÿ��ǩ���������ݣ�������ҵ�ǰû����ȡ��ǩ������ID��״̬
	InitPlayerSkill()	--��ʼ������
	InitPlayerVipData(nil, 0) 		--��ʼ�����VIP����
	local MaxTp = GetPlayerData(0, 17)	--��ȡ����������
	Setplayerproperty(20, MaxTp)	--������ҵ�һ��ע��������
	local max =  GetPlayerData(GetPlayerGID(0),GPP_MAXHP)
	ChangeObjectData(GetPlayerGID(0),GPP_CURHP,max)
	end
end

--add by ly 2014/4/30 ���������������Ӧ�ļ��ܸ���ң����ע��ʱ���ã�
function InitPlayerSkill()
	local PlayerSchool = GetPlayerSchool()	--3��ʾ��Ѫ��2��ʾ���ˡ�1��ʾ����
	if PlayerSchool == 3 then
		--��ͨ����3����
		ActiveSkill(1)
		ActiveSkill(2)
		ActiveSkill(3)
		--��ͨ����
		ActiveSkill(11101)
		ActiveSkill(11102)
		ActiveSkill(11103)
		ActiveSkill(11104)

		--����������̬�µĵ�һ�����ܵ����������
		FirstRegCallSetPlayerSkill(11101, 0, 0)	--�ú�����������Ϊ��ͨ���ܡ�����1���ܣ�����2����
	elseif PlayerSchool == 2 then
		--��ͨ����3����
		ActiveSkill(4)
		ActiveSkill(5)
		ActiveSkill(6)
		--��ͨ����
		ActiveSkill(12101)
		ActiveSkill(12102)
		ActiveSkill(12103)
		ActiveSkill(12104)
		--����������̬�µĵ�һ�����ܵ����������
		FirstRegCallSetPlayerSkill(12101, 0, 0) --�ú�����������Ϊ��ͨ���ܡ�����1���ܣ�����2����
	else 	--����Ҳ�Ϊ3��2ʱ����Ĭ�Ϸ�������ļ��ܸ����
		--��ͨ����3����
		ActiveSkill(7)
		ActiveSkill(8)
		ActiveSkill(9)
		--��ͨ����
		ActiveSkill(13101)
		ActiveSkill(13102)
		ActiveSkill(13103)
		ActiveSkill(13104)
		--����������̬�µĵ�һ�����ܵ����������
		FirstRegCallSetPlayerSkill(13101, 0, 0)	--�ú�����������Ϊ��ͨ���ܡ�����1���ܣ�����2����
	end
	--���弼��
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
	-- local LastLeavetime = GetPlayerTime(1) --�ϴ�����ʱ��
	-- local currenttime = GetPlayerTime(3) --��ǰʱ��
	-- local currentLogin = GetPlayerTime(2) --���ε�¼ʱ��

	-- currentLogin = currenttime - currentLogin

	-- local tatolactive = 0			--�����ۼƼ�������
	-- local endactive = 0				--��Ҫ�ļ����������

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

--����Ҹ���ʱ�Ľ�Ǯ���
function OnReliveCheckPlayerMoney(Playerpoint,nouse)
	return CheckPlayerMoney(2,10*Playerpoint,0)
end

--���͵ȼ�����
function SendLevelGiftList()
	local curretLevel = LoadFromPlayerData(2) --��ǰӦ����ȡ�ĵȼ�����
	local Level = GetPlayerData(0,GPP_LEVEL) --��ҵȼ�
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
		rfalse("���һ���ȼ������б�")
		SendLastLevelGiftList()
	end
end

function SendLastLevelGiftList() --�������һ���ȼ������б�
	local index = table.getn(LevelRewardList)
	local itemnum = table.getn(LevelRewardList[index].RewardItem)/2
	SendBufferToClinet(2,itemnum,LevelRewardList[index].RewardItem,0,LevelRewardList[index].RewardLevel,0)
	rfalse("�������һ���ȼ������б�")
end

--�ͻ��������ȡ�ȼ�����
function OnrecvLevelGiftList()
	local Level = GetPlayerData(0,GPP_LEVEL) --��ҵȼ�
	local curretLevel = LoadFromPlayerData(2) --��ǰӦ����ȡ�ĵȼ�����
	for k, v in pairs(LevelRewardList) do
		if (curretLevel < v.RewardLevel and Level >= v.RewardLevel) then
			local itemnum = table.getn(v.RewardItem)/2
			if (giveItemList(v.RewardItem) == 0) then
				TalkToPlayer(2, "�����ռ䲻�㣬�޷����ý������ߣ�")
				SendGiftSucceed(2,0,0)
				return 0
			end
				SendGiftSucceed(2,1,0)
				SaveToPlayerData(2,v.RewardLevel) --���浱ǰ�Ѿ���ȡ���ĵȼ�����
				SendLevelGiftList()
				break
		end
	end
end


function SavePlayerConLoginDay(logindate)--���浱ǰ��ҵ�ǰ������¼�Ĵ���,������ʱ����
	local currentloginindex = LoadFromPlayerData(3)
	if(logindate == 0) then
		currentloginindex = 1
	end

	local nowdate = tonumber(os.date("%Y%m%d",os.time()))
	local weekday = tonumber(os.date("%Y%m%d",logindate))



	local passtime = os.time() - logindate

	if(weekday ~= nowdate)then
		ResetOnlineGiftState() --������߽����������ȡ
		ResetJingMaiShareExpTimes() -- �������þ�����Ѩ�ɹ�����������
		local nexttime = logindate + 24 * 60 *60
		local nextday = tonumber(os.date("%Y%m%d",nexttime))
		if(nextday ~= nowdate) then
			currentloginindex = 1	--����ͬһ��������½���¼���
		else
			currentloginindex = currentloginindex +1
		end
	end

	SaveToPlayerData(3,currentloginindex) 	--���浱ǰ��ҵ�ǰ������¼�Ĵ���
	rfalse("��ҵ�ǰ������¼�Ĵ��� "..currentloginindex.."")
end

-- ����ÿ�վ�����Ѩ�ɹ�����������
function ResetJingMaiShareExpTimes()
	local shareExpTimes = 24
	SetJingMaiShareExpTimes(shareExpTimes);
end


function SaveMyDate()	--��������
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



--�ӵ�����
function GetPlayerBaseProperties(propertyid)
--0 ����������� 1 ����������� 2 ����������� 3�������� 4�������� 5�������� 6 ������� 7 �ƶ��ٶ� 8 �����ٶ�
	local JianshenData = GetPlayerData(0,GPP_JIANSHEN) --��ǰǿ������
	local FangyuData = GetPlayerData(0,GPP_FANGYU) -- ��ǰ��������
	local JinggongData = GetPlayerData(0,GPP_JIGONGPOINT) --��ǰ��������
	local QingshenData = GetPlayerData(0,GPP_QINGSHEN) --��ǰ�Ṧ����
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

--��Ԫ��
function calculateSpAndExpByTime(sec)
	local sp = 0;
	local exp = 0;
	--INT64 t = 0;
	local i = 3;		--3СʱΪһ�׶�
	local j = 90;		--��һ�׶�Ϊ90���һ�Σ�ÿ�׶μ�10��
	local k = 10;		--��һ�׶μ�10�㾭��,ÿ�׶ζ��10��
	local n = 3  		--������3��
	while(true) do
		if (i > 12)	then	--����12Сʱ�����ۻ�
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

function disposeplayerdead(playergid,reginid,mapID)--��������������
	if PlayerDeadList == nil then
		PlayerInit()
	end

	--add by ly 2014/4/22
	if GetPlayerInDailyArea() then		--���������ճ�������в�������ң����˳��ճ�������󸴻����
		return
	end

	--rfalse("disposeplayerdead reginid = "..reginid.."mapID = "..mapID)
	local ReliveCost = 0   --��������Ǯ
	local deadcount = 0  --��������
	local activityAttkCost = 10 --��������
	local activityDefenceCost = 20 --��������
	local wX = 17    --1�ŵ�ͼ����
	local wY = 45

	local bisinScene = false
	local playersceneindex = 0
	if GetPlayerInScene() then --���ڹؿ�������
		local playerscene = LoadPlayerTable(PlayerSceneData)		--�ؿ����½�,����,�Լ���������
		if playerscene == nil then
			rfalse("playerscene nil")
			return
		end
		if playerscene.deadcount ~= nil then
			playerscene.deadcount = playerscene.deadcount + 1
			deadcount = playerscene.deadcount
			for k,v in pairs(SceneManager) do
				if v.Playerlist == playergid then
					local sceneindex = v.sceneindex   --��ǰ����ͨ�صĹؿ�
					local scenemap = v.scenemap 		--��ǰ����ͨ�ص��½�
					local scmap = SceneMapTable[scenemap][sceneindex]	--�ؿ���ͼ����
					if scmap ~= nil then
						ReliveCost = scmap.relivemoney 		--ȡ�ùؿ�����������
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
	local wFreeReliveTime = relivetime * deadcount  --����������ȴʱ�� * ��������
	local sid = GetPlayerData(0,GPP_QUANJUSID)
	if PlayerDeadList[sid] == nil then
		PlayerDeadList[sid] = {}
	end
	local deadpos  = GetPlayerData(0,GPP_QUANPOS)
	PlayerDeadList[sid].wFreeReliveTime = wFreeReliveTime  --��Ѹ�����ȴʱ��
	PlayerDeadList[sid].ReliveCost = ReliveCost
	PlayerDeadList[sid].activityAttkCost = activityAttkCost
	PlayerDeadList[sid].activityDefenceCost = activityDefenceCost
	PlayerDeadList[sid].DeadTime = os.time()     --����ʱ��
	PlayerDeadList[sid].reginid = reginid
	PlayerDeadList[sid].mapID = mapID
	PlayerDeadList[sid].wreliveX = wX 		--���������
	PlayerDeadList[sid].wreliveY = wY
	PlayerDeadList[sid].wdeadX = deadpos[1]      --��������
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

	if playersceneindex == 1 then  --����ؿ�����
		--PlayerQuestRelive(0,playergid)
		CompleteScene(1,1,0)
		ServerCompleteScene(1,1)
		--OnRecvSQSceneLeave(playergid)
		return
	end
end


function PlayerQuestRelive(relivetype,playergid) --������󸴻� 1 �����ڸ��� 2 ��Ǯԭ�ظ���

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
						SendReliveResult(sid,1)    --0 ����ɹ� 1 ����ʧ�� ��ȴʱ�䲻�� 2����ʧ�� ��Ǯ����
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
					SendReliveResult(sid,2)    --0 ����ɹ� 1 ����ʧ�� ��ȴʱ�䲻�� 2����ʧ�� ��Ǯ����
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
	if PlayerDeadList == nil then  --����������б�
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

function OnRecvUpdateSkill(skillid ) --��Ҽ��������ɹ�ʱ�Ļص�
	OnTaskCallBack(TASK_SKILL,1,0)
end

function OnPlayerXinYangUpdate(SuccessNum) --�������֮�������ɹ�
	if SuccessNum > 0 then
		OnTaskCallBack(TASK_XINYANG,SuccessNum,0)
	end
end

 function Getfightpower(objtable) --ս����
 	local x = objtable.MaxHp*1 + objtable.GongJi*6 + objtable.FangYu*3 + objtable.Hit*2 + objtable.ShanBi*2 + objtable.BaoJi*8.22 + objtable.Uncrit*8.22 + objtable.Wreck*8.22 + objtable.Unwreck*8.22 + objtable.Puncture*8.22 + objtable.Unpuncture*8.22
    return x
 end

 function PrintDebugLog()
 	local currenttp = GetPlayerData(0,GPP_CURTP)				--ȡ�������۳�
 	local maxtp = GetPlayerData(0,GPP_MAXTP)				--ȡ�������۳�
 	local cname = GetPlayerData(0,GPP_MYName)
 	rfalse("Player:[ "..cname.." ] TP = "..currenttp.."  maxtp = "..maxtp.."")
end
PlayerInit()


function OnPlayerBuyTp()
	
	local viplevel = GetPlayerData(0,GPP_VIPLEVEL)
	local playertpdata = LoadPlayerTable("PLAYERTPDATA")
	if playertpdata == nil then
		playertpdata = {}
		playertpdata.buycount = 0   --������� 
		playertpdata.buytime = 0    --����ʱ��
	end
	viplevel = viplevel + 1
	if VIPBuyTp == nil then
		return
	end

	if playertpdata.buytime > 0 then  --���ݹ���ʱ�����ù�������Լ�ʱ��
		local nowdate = tonumber(os.date("%Y%m%d",os.time()))
		local buydate = tonumber(os.date("%Y%m%d",playertpdata.buytime))
		if nowdate - buydate > 0 then   --����1�죬��������
			playertpdata.buytime = 0
			playertpdata.buycount = 0 
		end
	end


	if VIPBuyTp[viplevel] ~= nil then
		local count = GetTableLenth(VIPBuyTp[viplevel])
		if playertpdata.buycount + 1 > count then    --��ǰ��������������������
			local str = MystringFormat("NOMATCH")
			TalkToPlayer(2,str)
		else
			if OnBuyTp(viplevel,playertpdata.buycount + 1) == true then  --����ɹ�
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