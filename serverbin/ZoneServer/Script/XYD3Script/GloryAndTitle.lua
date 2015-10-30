--PlayerGloryInfo = {PlayerGloryDot = 0}; 	--���������ҫ����

--��ǰ���Ϊ��һ��ע���¼,�ú���������playerfunction.lua�ļ��е�OnPlayerLogin������
function FirstLoginInitGloryData()
	--���������ҫ����
	local PlayerGloryInfo = LoadPlayerTable("PlayerGloryInfo", gid)
	if PlayerGloryInfo == nil then		--��ǰ���Ϊ��һ��ע���¼
		PlayerGloryInfo = {PlayerGloryDot = 0, GloryInfArr = {}}
		--��ʼ�������ҫ����
		PlayerGloryInfo.GloryInfArr = InitNewPlayerGloryInfo(PlayerGloryInfo.GloryInfArr);
		--������ҫ����
		WeekReturnChargeData("PlayerGloryInfo", PlayerGloryInfo, gid);
	end
end

--������ҫ��Ϣ��Ӧ����
function GetPlayerGloryInfo(gid)
	--���������ҫ����
	local PlayerGloryInfo = LoadPlayerTable("PlayerGloryInfo", gid)
	SendClientGloryInfo(PlayerGloryInfo)	--��ͻ��˷�����ҫ��Ϣ
end

--������ҫ����
function ChangeGloryDot(gid, ChangeValue)
	--���������ҫ����
	local PlayerGloryInfo = LoadPlayerTable("PlayerGloryInfo", gid)
	PlayerGloryInfo.PlayerGloryDot = PlayerGloryInfo.PlayerGloryDot + ChangeValue
	if PlayerGloryInfo.PlayerGloryDot < 0 then
		PlayerGloryInfo.PlayerGloryDot = 0
	end
	--������ҫ����
	WeekReturnChargeData("PlayerGloryInfo", PlayerGloryInfo, gid);
	return 1
end

--������ҫ�Ѿ���ɵ�����
function ReturnGloryCompleteNum()
	--���������ҫ����
	local PlayerGloryInfo = LoadPlayerTable("PlayerGloryInfo", gid)
	if PlayerGloryInfo == nil then		--��ǰ���Ϊ��һ��ע���¼
		return 0
	end
	return table.getn(PlayerGloryInfo.GloryInfArr);
end


--��ȡ��ҫ��������
function GetGloryAward(GloryID, gid)
	--���������ҫ����
	local LoadPlayerGloryInfo = LoadPlayerTable("PlayerGloryInfo", gid)
	--��ȡ��������
	LoadPlayerGloryInfo = QstGetGloryAward(GloryID, LoadPlayerGloryInfo)
	--������ҫ����
	WeekReturnChargeData("PlayerGloryInfo", LoadPlayerGloryInfo, gid);
end

--�ƺ���Ϣ����
function HandleTitleMsg(MsgType, TitleID, gid)
	--���������ҫ����
	local LoadPlayerGloryInfo = LoadPlayerTable("PlayerGloryInfo", gid)
	--����������ҫ������
	LoadPlayerGloryInfo = QstHandleTitleMsg(MsgType, TitleID, LoadPlayerGloryInfo);
	--������ҫ����
	WeekReturnChargeData("PlayerGloryInfo", LoadPlayerGloryInfo, gid);
end
