-- -- ��ȡ����״̬ö��(GetMonsterData��������)
-- GMon_LEVEL			= 1		-- ����ȼ�
-- GMon_ID				= 2		-- ����Monsterģ��ID
-- GMon_NAME			= 3		-- ����Name
-- GMon_EXP			= 4		-- ���ﾭ��
-- GMon_LevelType		= 5		-- �������ͣ���ͨ&��Ӣ&BOSS��
-- GMon_CURHP			= 6		-- ���ﵱǰѪ��
-- GMon_MaxHP			= 7		-- �������Ѫ��
-- GMon_AttType		= 8		-- ���﹥������
-- GMon_LastEnemyID	= 9		-- ˭��������
-- GMon_GroupID		= 10	-- ���������ID
-- GMon_PartolRadius	= 11	-- ��ذ뾶
-- GMon_TailLength		= 12	-- ׷���뾶
-- GMon_NodeCount		= 13	-- ·���ܸ���
-- GMon_CurNode		= 14	-- ��ǰ·�����
-- GMon_MoveType		= 15    -- �ƶ�����
-- GMon_Move2Att		= 16    -- �Ƿ��ƶ�ȥ����
-- GMon_CurrAction		= 17    -- ��ǰ�ƶ���Ϊվ�������� ��������
-- GMon_HPcent         = 18    -- ��ǰ�����ٷֱ�
-- GMon_BackProtect    = 19    -- ���ڷ��ر���
-- GMon_BornTime   	= 20    -- ���������ڵ�ʱ��
-- GMon_POSTION   		= 21    -- ����float XY
EventRegion = {}
EventRegionList = {}
PathList = {}

--GetAttackTargetMonster �������Լ�����ͬһ����Ĺ�����ͬһ�鲻����

-----------------------------------------------------------------------------------------
dofile("XYD3Script\\EventRegion\\EventRegion20000.lua")
--dofile("XYD3Script\\EventRegion\\EventRegion20003.lua")
--dofile("XYD3Script\\EventRegion\\EventRegion20004.lua")
-----------------------------------------------------------------------------------------

-- ����������ͼ�ĺ���
function LuaCreateEventRegion(regionID)--�Զ��庯��
	local dyconf = EventRegion[regionID]
	if (nil == dyconf) then
		return
	end
	--if (dyconf.LevelLimt ~= nil) then
		--local n1 = dyconf.LevelLimt[1]
		--local n2 = dyconf.LevelLimt[2]
		--local Levl = GetPlayerData(0,GPP_LEVEL)
		--if (Levl > n1 and Levl <= n2) then
	
		--else
			--TalkToPlayer(2,"�ȼ������������ȼ���["..n1.." , "..n2.."]")
			--return
		--end
	--end
	local mapx = CreateRegion(regionID, dyconf.MapID, 0, 0, 0, 0)
	if (nil == mapx) then
		return
	end

	-- ������ͨ�������ڳ���������û���趨��ͨ�֣���һ��û�õ�
	if type({}) == type (dyconf.Monster) then
		for k, mCreate in pairs(dyconf.Monster) do
			mCreate.regionId = mapx
			CreateObjectIndirect(mCreate)
		end
	end

	return mapx
end

-- ������̬��ͼ���ҽ���ҷ���
function PutPlayerToEventRegion(regionID, x, y,id)--�Զ��庯��
	if ( IsCanEnterPart(regionID) == 0 ) then
		rfalse("111")
		return
	end
	
	local dmGID = LuaCreateEventRegion(regionID)
	local n = GetPlayerTeam(1)
	if (dmGID == nil) then
		return
	end
	
	if(n == 0)then
		PutPlayerTo(0, x, y, dmGID,id)--���2������
		CreatePartNpc(regionID)		  --����ص��ж��ں������棬���û��ʲôҲ���ᷢ��
		
	else
		local a = GetPlayerTeam(2)
		if(a == 1)then
			local PlayerGID = {}
			PlayerGID[0],PlayerGID[1],PlayerGID[2],PlayerGID[3],PlayerGID[4] = GetPlayerGIDbyTeam()
			for i=0,4 do
				if (PlayerGID[i]~=0) then
					PutPlayerTo(0, x, y, dmGID, PlayerGID[i])
					
				else
					rfalse("����Ϊ��: "..i)
				end
			end
			CreatePartNpc(regionID)		  --����ص��ж��ں������棬���û��ʲôҲ���ᷢ��
		else
			SendMsgForPlayer(0,"�㲻�Ƕӳ����ܿ�������")
		end
	end
end

-----------------------------------------------------------------------------------------

function EventRegion_Init(regionID, regionGID)
  --ִ�� Init_20000(regionGID) �ȵ�
  local funcName = loadstring("Init_"..regionID.. "(" ..regionGID..","..regionID..")")
  --local funcName = loadstring("Init_" .. regionID .. "(" .. regionGID .. ")")
  funcName();

end

function EventRegion_Run(regionID, regionGID, regionExistTime)

  --ִ�� Run_20000(regionGID, RegionExistTime) �ȵ�
  local funcName = loadstring("Run_" .. regionID .. "(" .. regionGID .. "," .. regionExistTime ..","..regionID.. ")")
  funcName();
  
end

function EventRegion_End(regionID, regionGID, regionExistTime, regionEndTime,EventRegionEnd)

  --ִ�� End_20000(regionGID, RegionExistTime) �ȵ�
  local funcName = loadstring("End_" .. regionID .. "(" .. regionGID .. "," .. regionExistTime .."," .. regionEndTime ..","..regionID..","..EventRegionEnd..")")
  funcName();
  
end

function PushPlayerTemplate(RegID)--�����������,�������𱧱�
	if (EventRegion[RegID] == nil) then
		return
	end
	
	if (EventRegion[RegID].UsePlayerProperty == 1) then --���ʹ��ģ������������ӿ�ʹ����������
		OnPlayerClearBuff()
		for k,v in ipairs(EventRegion[RegID].TUPtable) do
			local Index = v[1]
			local value = v[2]
			SetPlayerData(1,Index,value)
		end
		LoadPlayerModifValue()
	end
	if (EventRegion[RegID].TemplateSkill == 1) then --���ʹ��ģ�弼��
		for k,v in pairs(EventRegion[RegID].TStable) do
			local SkillID = v[1]
			if (SkillID ~= nil) then
				local index = ActiveTempSkill(SkillID)
				if (index ~= -1) then
					v[2] = index
				end
			else
				rfalse("װ����ʧ��!!!")
			end
		end
		SendTemplateSkill()
	end
	if (EventRegion[RegID].CallOutPet == 1) then --�����������
		OnBackFightPet() --��������
	end
	
	local value = EventRegion[RegID].BaseSore
	if (value ~= nil) then
		SetPlayerData(2,1,value)
		local str = "������ "..value.." ��"
		TalkToPlayer(2,str)
	end
end

function PopPlayerTemplate(RegID)
	if (EventRegion[RegID] == nil) then
		return
	end
	if (EventRegion[RegID].UsePlayerProperty == 1) then --���ʹ��ģ������������ӿ�ʹ����������
		UnLoadPlayerModifValue()
	end
	if (EventRegion[RegID].TemplateSkill == 1) then --���ʹ��ģ�弼��
		CoolingTempSkill(0)				--�޳�����
	end
	if (EventRegion[RegID].CallOutPet == 1) then --�����������
		
	end
end

function IsCanUsePet(RegID)
	if (EventRegion[RegID] == nil) then
		return 1 --����ʹ������
	end
	if (EventRegion[RegID].CallOutPet == 1) then
		return 0 --����ʹ������
	end
	return 1
end

function IsCanUseSkill(RegID,index)
	if (EventRegion[RegID] == nil) then
		return 1 --����ʹ�ü���
	end
	if (EventRegion[RegID].TemplateSkill == 1) then
		for k,v in pairs(EventRegion[RegID].TStable) do
			local Index = v[2]
			if(Index == index) then
				return 1
			end
		end
		return 0
	end
	return 1	
end
function CreatePartNpc(RegID)
	if (EventRegion[RegID] == nil) then
		return
	end
	if (EventRegion[RegID].NpcTempCreate == 1)then
		for k,v in pairs(EventRegion[RegID].TNPtable) do
			rfalse("����NPC��"..v)
			if (NpcTable[v] ~= nil) then
				NpcTable[v].NpcCreate.controlId 	= v
				NpcTable[v].NpcCreate.clickScript   = v
				CreateObjectIndirect(NpcTable[v].NpcCreate)
			else
				rfalse("�Ҳ�������һ�")
			end
		end
	end
end

function OnTFPlayerValue(RegionID)
	if (EventRegion[RegionID] ~= nil) then
		if (EventRegion[RegionID].AddSore ~= nil) then
			SetPlayerData(2,1,value)
			local str = "������ "..value.." ��"
			TalkToPlayer(2,str)
		end
	end
end

function GivePlayerLiftData(regionGID,regionID,FlagResult)
	if (EventRegion[regionID]~= nil) then
		local GExp		= EventRegion[regionID].RewardsEXP
		local GMoney	= EventRegion[regionID].RewardsMoney
		local GItem		= EventRegion[regionID].RewardsItem
		if (GExp == nil)then
			GExp = 0
		end
		if (GMoney == nil)then
			GMoney = 0
		end
		--rfalse("Gexp "..GExp)
		OnGivePlayerLiftData(regionGID,regionID,GExp,GMoney,GItem)--��������ص�
	end
end
--��������ֱ�ӻؼ�
function PartKickerToReturn(wEventID,id)
	PutPlayerTo(0,0,0,wEventID,id)
	--local wEventID = GetEventID()
	--if ( id ~= 0 and id ~= nil) then
		--local id = GetPlayerData(0,GPP_QUANJUGID)
	--end
end

function IsCanEnterPart(regionID) --���ж��Ƿ��ܼ�������
	local dyconf = EventRegion[regionID]
	if (nil == dyconf) then
		return 0
	end
	local n = GetPlayerTeam(1)
	if(n == 0)then --���Խ�����һ���� �Ƿ������
		if (dyconf.LevelLimt ~= nil) then
			  local n1 = dyconf.LevelLimt[1]
			  local n2 = dyconf.LevelLimt[2]
			  local Levl = GetPlayerData(0,GPP_LEVEL)
			  if (Levl >= n1 and Levl <= n2) then
				  return 1	
			  else
				  TalkToPlayer(2,"�ȼ������������ȼ���["..n1.." , "..n2.."]")
				  return 0
		      end
		else
			return 1
		end
	else
		local n1 = dyconf.LevelLimt[1]
		local n2 = dyconf.LevelLimt[2]
		local a = GetPlayerTeam(2) --�Ƿ��Ƕӳ�
		if(a == 1)then
			local PlayerLv= {}
			PlayerLv[0],PlayerLv[1],PlayerLv[2],PlayerLv[3],PlayerLv[4] = GetPlayerLevelbyTeam()
			for i=0,4 do
				if (PlayerLv[i]~=0) then
					if (PlayerLv[i] > n1 and PlayerLv[i] <= n2) then
							
					else
						TalkToPlayer(2,"���������˵ȼ������������ȼ���["..n1.." , "..n2.."]")
						return 0
					end
				end
			end
			return 1
		else
			SendMsgForPlayer(0,"�㲻�Ƕӳ����ܿ�������")
			return 0
		end
	end
	return 0
	
end
