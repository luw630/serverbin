LimitPlayerGMLevel = 0 		--���GM����ﵽһ���ȼ�����ִ�еĲ���
GM_Command_List = {
	--ExceteFunc,Ϊ������ִ�еĺ�����ParamLen, Ϊ�ú����в�����������Type����ʾ�Ƿ�Ϊֻ�з���˲���ʹ�ø����Ϊ1��ʾ������ֻ�ܷ���˲���ʹ��
	--[[--�����ӵ����������GM��������ͻ���GM����--]]

	--[[--����Ϊ�ͻ�����ӵ�е�GM����--]]
	help = {},

	changeglorydot = {ExceteFunc = ChangeGloryDot, ParamLen = 2},	--�ı������ҫ��

	changemoney = {ExceteFunc = ChangeMoney, ParamLen = 3}, --�ı���ҵĽ�Ǯ(��������Ϊ�����Ψһ����GID����Ǯ���ͣ��ı���ֵ)

	changeexp = {ExceteFunc = GiveExp, ParamLen = 2},	--������Ҿ���(��������Ϊ�����Ψһ����GID����������)

	changesp = {ExceteFunc = GiveSp, ParamLen = 2},  --�����������(��������Ϊ�����Ψһ����GID����������)

	addgoods = {ExceteFunc = GiveGoods, ParamLen = 3}, --������ұ����е���Ʒ(��������Ϊ�����Ψһ����GID����ƷID����������)

	delgoods = {ExceteFunc = DeleteItem, ParamLen = 3}, --����ָ��ID���ߵ�����(��������Ϊ�����Ψһ����GID������ID�����ĸõ��ߵ�����)

	activeskill = {ExceteFunc = ActiveSkill, ParamLen = 2},		--�����(��������Ϊ�����Ψһ����GID������ID)

	activepackage = {ExceteFunc = ActivePackage, ParamLen = 3}, -- �����������������(��������Ϊ�����Ψһ����GID���ı����״̬������������״̬(����1������0))

	setskilllevel = {ExceteFunc = SetSkillLevel, ParamLen = 3}, --���õ�ǰ����ID�ĵȼ�(��������Ϊ�����Ψһ����GID������ID�����ܵȼ�)

	setindexskilllevel = {ExceteFunc = SetCurrentSkillLevel, ParamLen = 3}, --��������λ�ü��ܵȼ�(��������Ϊ�����Ψһ����GID�������ڼ��ܱ��е��������ü��ܵȼ�)

	setplayerviplevel = {ExceteFunc = SetPlayerVipLevel, ParamLen = 2}, --�������Vip�ȼ�(��������Ϊ�����Ψһ����GID��Vip�ȼ�ֵ)

	--addmoney = {ExceteFunc = GiveMoney, ParamLen = 2},  --������ҽ�Ǯ(��������Ϊ��Ǯ���ͣ���������)

	--createcount = {ExceteFunc = GiveMount, ParamLen = 1},  --��������(��������Ϊ������ID)

	--createpet = {ExceteFunc = GivePet, ParamLen = 1},  --��������(��������Ϊ������ID)

	--createfightpet = {ExceteFunc = GiveFightPet, ParamLen = 1},		--��������(��������Ϊ������ID)

	--UCgetitemnum = {ExceteFunc = GetItemNum, ParamLen = 2},		--��ȡָ�����ߵ�����(��������Ϊ������ID�����Ψһ������Ϊ0ʱ��ʾ��ǰ���)

	UCgetplayersid = {ExceteFunc = GetPlayerSID, ParamLen = 1},	--��ȡ��ҶԷ�������ȺΨһ��̬��ID(SID)(��������Ϊ���������)

	UCgetplayergid = {ExceteFunc = GetPlayerGID, ParamLen = 1}, 	--��ȡ���ȫ��Ψһ��ʾ(��������Ϊ����ҶԷ�������ȺΨһ��̬��ID(SID)�������ݿ���������ɣ�)

	UCgetplayerdata = {ExceteFunc = GetPlayerData, ParamLen = 2}, --��ȡ�������(��������Ϊ�����Ψһ����GID�������������)

	setplayerdata = {ExceteFunc = NewSetPlayerProperty, ParamLen = 3}, --�����������(��������Ϊ�����Ψһ����GID����Ӧ���ݵ����������õ�ֵ)

	setkillallmonster = {ExceteFunc = SetKillAllMonster, ParamLen = 2},  --�ؿ������ɱ���Ѿ�ˢ�µ����й����Ϊ�����Ƿ���ˢ������(��������Ϊ�����Ψһ����GID���Ƿ��ڹؿ���ʹ�øò�����0��ʾ�ر����ã���0��ʾ����)

	sendsyscall = {ExceteFunc = SendSysCall, ParamLen = 2}, 	--GM����ϵͳ������Ϣ

	--getmonsterdata = {ExceteFunc = GetMonsterData, ParamLen = 1}, --��ȡ��������(��������Ϊ��������������)

	--setmonsterdata = {ExceteFunc = SetMonsterData, ParamLen = 2},  --���ù�������(��������Ϊ������������������Ӧ������ֵ)

	--activetelegry = {ExceteFunc = ActiveTelegry, ParamLen = 1}, --�����ķ�(��������Ϊ���ķ�ID)

	--getservertime = {ExceteFunc = GetServerTime, ParamLen = 0}, --��ȡ������ʱ��

	--settips = {ExceteFunc = SetTips, ParamLen = 1},  --����ϵͳ��Ϣ(��������Ϊ����Ϣ����)

	--lockplayer = {ExceteFunc = LockPlayer, ParamLen = 2}, --�������(��������Ϊ������ʱ�䣻�������ȫ��Ψһ��ʶ)

	--unlockplayer = {ExceteFunc = UnLockPlayer, ParamLen = 1}, --�����������(��������Ϊ���������ȫ��Ψһ��ʶ)

	--setplyaercopyscenestate = {ExceteFunc = SetPlyaerCopySceneState, ParamLen = 1}, --������Ҹ���״̬(��������Ϊ������״ֵ̬)

	--playeraddbuff = {ExceteFunc = PlayerAddBuff, ParamLen = 1}, --������ҵ�BUF(��������Ϊ��BUFID)

	--setplayerfightpoint = {ExceteFunc = setplayerpoint, ParamLen = 2}, --�������ս������(��������Ϊ��ս��������(����������������)����������)

	--setplayerdegree = {ExceteFunc = SetPlayerDegree, ParamLen = 2}, --������Һ��Ѷ�(��������Ϊ��Ŀ������������ú��Ѷ�ֵ)

	--clearplayerbuff = {ExceteFunc = PlayerClearBuff, ParamLen = 0}, --���������ϵ�Buff

	--setcrilial = {ExceteFunc = SetCrilial, ParamLen = 1}, --������Ҳ���������ֵ(��������Ϊ������������ֵ)

	--delequip = {ExceteFunc = DelEquipment, ParamLen = 1}, --ɾ��ָ��������װ��(��������Ϊ��װ������)

	--setisnewplayer = {ExceteFunc = SetIsNewPlayer, ParamLen = 1}, 	--�����Ƿ�Ϊ�´������(��������Ϊ����һ�δ�����ұ�ʶ��ֵ)

	--killallmonster = {ExceteFunc = KillAllMonster, ParamLen = 2}, --ɱ�����������еĹ���(��������Ϊ������ID�����ȫ��Ψһ��ʶ)

	--setobjectdata = {ExceteFunc = SetObjectData, ParamLen = 3}, --���ö����������(��������Ϊ������ȫ��Ψһ��ʶ�������������������õ�����ֵ)

	--settaskfinish = {ExceteFunc = SetTaskFinish, ParamLen = 2}, --�����������(��������Ϊ�����ȫ��Ψһ��ʶ������ID)

	--settransformerslevel = {ExceteFunc = SetTransformersLevel, ParamLen = 2}, --���ñ���ȼ�(��������Ϊ����������������ȼ�)

	--addskillproficiency = {ExceteFunc = AddSkillProficiency, ParamLen = 2}, --���Ӽ���������(��������Ϊ������ID��������ֵ)
}

--��ȡ�������ʱ������ID
GM_GetPlayerData_TypeList = {}
	GM_GetPlayerData_TypeList[0] = "�����ҵ�ǰ����ֵΪ��"
	GM_GetPlayerData_TypeList[1] = "�����ҵ�ǰ����ֵΪ��"
	GM_GetPlayerData_TypeList[2] = "�����ҵ�ǰ����Ϊ��"
	GM_GetPlayerData_TypeList[3] = "�����ҵ�ǰ����ֵΪ��"
	GM_GetPlayerData_TypeList[4] = "�������������ֵΪ��"
	GM_GetPlayerData_TypeList[5] = "�����Ұ�������Ϊ��"
	GM_GetPlayerData_TypeList[6] = "����������ֵΪ��"
	GM_GetPlayerData_TypeList[7] = "������ɱ��ֵΪ��"
	GM_GetPlayerData_TypeList[8] = "�����Ҿ���ֵΪ��"
	GM_GetPlayerData_TypeList[9] = "�����Ҿ���ֵΪ��"
	GM_GetPlayerData_TypeList[10] = "�����ҵȼ�Ϊ��"
	GM_GetPlayerData_TypeList[11] = "�����ҵ�ǰ�ƶ��ٶ�ֵΪ��"
	GM_GetPlayerData_TypeList[12] = "�����ҵ�ǰ�����ٶ�Ϊ��"
	GM_GetPlayerData_TypeList[13] = "�����ҵ�ǰ�Ṧ����Ϊ��"
	GM_GetPlayerData_TypeList[14] = "�����ҵ�ǰǿ������Ϊ��"
	GM_GetPlayerData_TypeList[15] = "��������ż����Ϊ��"
	GM_GetPlayerData_TypeList[16] = "�������������ֵΪ��"
	GM_GetPlayerData_TypeList[17] = "�������������ֵΪ��"
	GM_GetPlayerData_TypeList[18] = "�����ҵ�ǰ����ֵΪ��"
	GM_GetPlayerData_TypeList[19] = "�����ҵ�ǰ����ֵΪ��"
	GM_GetPlayerData_TypeList[20] = "�����ҵ�ǰ����ֵΪ��"
	GM_GetPlayerData_TypeList[21] = "����������ֵΪ��"
	GM_GetPlayerData_TypeList[23] = "����������Ϊ��"
	GM_GetPlayerData_TypeList[25] = "�����ҵ�ǰ��������Ϊ��"
	GM_GetPlayerData_TypeList[26] = "�����ҵ�ǰ��������Ϊ��"
	GM_GetPlayerData_TypeList[27] = "�����ҵ�ǰ���õ���ֵΪ��"
	GM_GetPlayerData_TypeList[28] = "�����ҵĽ�ɫ��Ϊ��"
	GM_GetPlayerData_TypeList[29] = "�����ҵ��˺�����Ϊ��"
	GM_GetPlayerData_TypeList[30] = "�����ҵ�ǰ���Ϊ��"
	GM_GetPlayerData_TypeList[31] = "�����ҵ�ǰ����Ϊ��"
	GM_GetPlayerData_TypeList[32] = "�����ҵ�ǰԪ������Ϊ��"
	GM_GetPlayerData_TypeList[33] = "�������˺�����Ϊ��"
	GM_GetPlayerData_TypeList[34] = "�����Ҿ����˺�Ϊ��"
	GM_GetPlayerData_TypeList[35] = "���������ӷ���Ϊ��"
	GM_GetPlayerData_TypeList[36] = "����������۵ȼ�Ϊ��"
	GM_GetPlayerData_TypeList[37] = "���ȫ�ֱ��Ϊ��"
	GM_GetPlayerData_TypeList[38] = "���sidΪ��"
	GM_GetPlayerData_TypeList[39] = "���XYposΪ��"
	GM_GetPlayerData_TypeList[40] = "���״̬����Ϊ��"
	GM_GetPlayerData_TypeList[41] = "���float XYposΪ��"
	GM_GetPlayerData_TypeList[42] = "�����ұ���״̬Ϊ��"
	GM_GetPlayerData_TypeList[60] = "������ɸ���GIDΪ��"
	GM_GetPlayerData_TypeList[61] = "��ô˸�����RIDΪ��"
	GM_GetPlayerData_TypeList[62] = "��ô˳�����IDΪ��"
	GM_GetPlayerData_TypeList[63] = "��ô˳�����GIDΪ��"
	GM_GetPlayerData_TypeList[99] = "�������ʶΪ��"
	GM_GetPlayerData_TypeList[100] = "����Ա�Ϊ��"
	GM_GetPlayerData_TypeList[101] = "���VIP�ȼ�Ϊ��"

--�����������ʱ������ID
GM_SetPlayerData_TypeList = {}
	GM_SetPlayerData_TypeList[1] = nil
	GM_SetPlayerData_TypeList[2] = nil
	GM_SetPlayerData_TypeList[3] = "������ҵ�ǰ����"
	GM_SetPlayerData_TypeList[4] = nil
	GM_SetPlayerData_TypeList[5] = "������ҵ�ǰ����"
	GM_SetPlayerData_TypeList[6] = "������ҽ���"
	GM_SetPlayerData_TypeList[7] = "������ҷ���"
	GM_SetPlayerData_TypeList[8] = "�����������"
	GM_SetPlayerData_TypeList[9] = "������ҽ���"
	GM_SetPlayerData_TypeList[10] = "������ҵ�ǰ����"
	GM_SetPlayerData_TypeList[11] = "�������ʣ�����"
	GM_SetPlayerData_TypeList[12] = "����������VIP�ȼ�"
	GM_SetPlayerData_TypeList[13] = "������ҵȼ�"
	GM_SetPlayerData_TypeList[14] = nil
	GM_SetPlayerData_TypeList[15] = nil
	GM_SetPlayerData_TypeList[16] = "�����������"
	GM_SetPlayerData_TypeList[17] = "�����������"
	GM_SetPlayerData_TypeList[18] = "�����������"
	GM_SetPlayerData_TypeList[19] = "�������Ԫ��"

GM_Help_List = {		--GM����˵��
	help = "help�鿴����GM������changemoney��changeexp��changesp��addgoods��delgoods��activeskill��activepackage��setskilllevel��setindexskilllevel��setplayerviplevel��UCgetplayersid��UCgetplayergid��UCgetplayerdata��setplayerdata��setmovekillmonster��sendsyscall��changeglorydot;",

	changemoney = "changemoney����ı���ҵĽ�Ǯ(��������Ϊ�����Ψһ����GID����Ǯ���ͣ��ı���ֵ)",

	changeexp = "changeexp���������Ҿ���(��������Ϊ�����Ψһ����GID����������)",

	changesp = "changesp��������������(��������Ϊ�����Ψһ����GID����������)",

	addgoods = "addgoods���������ұ����е���Ʒ(��������Ϊ�����Ψһ����GID����ƷID����������)",

	delgoods = "delgoods�������ָ��ID���ߵ�����(��������Ϊ�����Ψһ����GID������ID�����ĸõ��ߵ�����)",

	activeskill = "activeskill��������(��������Ϊ�����Ψһ����GID������ID)",

	activepackage = "activepackage��������������������(��������Ϊ�����Ψһ����GID���ı����״̬������������״̬(����1������0))",

	setskilllevel = "setskilllevel������õ�ǰ����ID�ĵȼ�(��������Ϊ�����Ψһ����GID������ID�����ܵȼ�)",

	setindexskilllevel = "setindexskilllevel�����������λ�ü��ܵȼ�(��������Ϊ�����Ψһ����GID�������ڼ��ܱ��е��������ü��ܵȼ�)",

	setplayerviplevel = "setplayerviplevel����������Vip�ȼ�(��������Ϊ�����Ψһ����GID��Vip�ȼ�ֵ)",

	UCgetplayersid = "UCgetplayersid�����ȡ��ҶԷ�������ȺΨһ��̬��ID(SID)�������Ҫ���ȫ��Ψһ����GID������Ҫ�Ȼ�ø�ֵ(��������Ϊ���������)",

	UCgetplayergid = "UCgetplayergid�����ȡ���ȫ��Ψһ��ʶ���������û��ȡ������ҵ�����ʱ������Ҫ�Ȼ�ȡ��ֵ(��������Ϊ����ҶԷ�������ȺΨһ��̬��ID(SID)�������ݿ���������ɣ�)",

	UCgetplayerdata = "UCgetplayerdata�����ȡ�������(��������Ϊ�����Ψһ����GID�������������)",

	setplayerdata = "setplayerdata��������������(��������Ϊ�����Ψһ����GID����Ӧ���ݵ����������õ�ֵ)",

	setkillallmonster = "setkillallmonster����ؿ������ɱ���Ѿ�ˢ�µ����й����Ϊ�����Ƿ���ˢ������(��������Ϊ�����Ψһ����GID���Ƿ��ڹؿ���ʹ�øò�����0��ʾ�ر����ã���0��ʾ����)",
	sendsyscall = "sendsyscall���GM����Ա����ϵͳ������Ϣ(��������Ϊ����ʾ�Ĵ��������͵Ĺ�����Ϣ)",
	changeglorydot = "changeglorydot������������ҫ����(��������Ϊ�����Ψһ����GID���ı�ֵ)",
}

--�ͻ��������һ��ֻ���ַ���������
function JuageAndReturnValue(StringValue)
	if type(StringValue) == "string" then
		return StringValue
	elseif type(StringValue) == "number" then
		NumberValue = tonumber(StringValue)
		return NumberValue
	end
	return StringValue
end

--��������Ͳ�����ִ��
function AnalyzeAndExceteGMCommand(CmdString, GMLevel, MsgType, MsgTalker, Caller)	--Caller���÷�ʽ��1Ϊ����˵��ã� 0Ϊ�ͻ��˵���
	local CmdAndParamDetail = {}
	local ParamIndex = 0

	local i = 1
	local ParamIndex = 0
	while true do
		m, n = string.find(CmdString, "%s+", i)
		if m == nil then
			Value = string.sub(CmdString, i)
		else
			Value = string.sub(CmdString, i, m - 1)
		end

		if CmdAndParamDetail.FuncName == nil then
			CmdAndParamDetail.FuncName = Value
		else
			ParamIndex = ParamIndex + 1
			--�жϲ�������
			Value = JuageAndReturnValue(Value)
			ParamName = "Param" .. ParamIndex
			CmdAndParamDetail[ParamName] = Value
		end
		if m == nil then
			break
		end
		i = n + 1
	end

	return ExceteGMCommand(CmdString, GMLevel, CmdAndParamDetail, ParamIndex, Caller, MsgType, MsgTalker)
end

--ִ����ز���
function ExceteGMCommand(CmdAndParams,PlayerGMLevel, GetCmdAndParamDetail, paramLen, Caller, MsgType, MsgTalker)

	if type(GetCmdAndParamDetail) ~= "table" then
		return CmdAndParams .. "��ִ��ʧ��"
	end
	local ParamIndex = paramLen

	if GM_Command_List[GetCmdAndParamDetail.FuncName] == nil then
		SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. "��û��" .. GetCmdAndParamDetail.FuncName .."���")
		return
	end

	--�ж�������������ĸ����Ƿ���ͬ
	if GM_Command_List[GetCmdAndParamDetail.FuncName].ParamLen ~= ParamIndex then
		if ParamIndex == 1 and GetCmdAndParamDetail.Param1 == "?" then
		else
			SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. "��" .. GetCmdAndParamDetail.FuncName .."��������ȷ��")
			return
		end
	end


	local ReturnValue = nil
	if ParamIndex == 1 and GetCmdAndParamDetail.Param1 == "?" then		--�鿴����˵��
		SendGmExceResult(MsgType, MsgTalker, GM_Help_List[GetCmdAndParamDetail.FuncName])
		return
	else	--ִ�ж�Ӧ������

		--ִ�к���Ϊnilʱ����ִ����ز���
		if	GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc == nil then
			SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. "��" .. GetCmdAndParamDetail.FuncName .. "û��������")
			return
		end

		if GetCmdAndParamDetail.FuncName == "UCgetplayersid" then
			ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param1)
			if	ReturnValue == nil then
				ReturnValue = "����ʧ��"
			end
			SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. "��" .. GetCmdAndParamDetail.Param1 .. "��ҵ�SIDΪ��" ..ReturnValue)
			return
		elseif GetCmdAndParamDetail.FuncName == "UCgetplayergid" then
			ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param1)
			SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. "��SIDΪ" .. GetCmdAndParamDetail.Param1 .. "��ҵ�GIDΪ��" .. ReturnValue)
			return
		elseif GetCmdAndParamDetail.FuncName == "UCgetplayerdata" then	--ִ�в��޸Ĳ���

			local GetType = tonumber(GetCmdAndParamDetail.Param2)
			if GM_GetPlayerData_TypeList[GetType] == nil then	--��ȡ����û��
				SendGmExceResult(MsgType, MsgTalker, GetCmdAndParamDetail.FuncName .. " û�и�������ֵ")
				return
			end

			ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param1, GetCmdAndParamDetail.Param2)

			--����������ֵ
			if type(ReturnValue) == "table" then  --���ص�����ҵ�λ�ã���ȡλ��
					ReturnValue ="XPos = " .. ReturnValue[1] .. "\tYPos = " .. ReturnValue[2]
			end
			if	ReturnValue == nil then
				ReturnValue = CmdAndParams .. "������ʧ��"
			end
			SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. " " .. GM_GetPlayerData_TypeList[GetType] .. ReturnValue)
			return
		--���ò����������GM�ȼ��ﵽһ���ļ���
		elseif	GetCmdAndParamDetail.FuncName == "setplayerdata" then

			if PlayerGMLevel < LimitPlayerGMLevel then
				SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. "����ҵ�GM�ȼ�����")
				return
			end

			local SetType = tonumber(GetCmdAndParamDetail.Param2)
			if GM_SetPlayerData_TypeList[SetType] == nil then	--��ȡ����û��
				SendGmExceResult(MsgType, MsgTalker, GetCmdAndParamDetail.FuncName .. " û�и�����")
				return
			end

			ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param1, GetCmdAndParamDetail.Param2, GetCmdAndParamDetail.Param3)

		elseif	GetCmdAndParamDetail.FuncName == "setkillallmonster" then
			if PlayerGMLevel < LimitPlayerGMLevel then
				SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. "����ҵ�GM�ȼ�����")
				return
			end
			ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param1, GetCmdAndParamDetail.Param2)

		elseif GetCmdAndParamDetail.FuncName == "sendsyscall" then
			if PlayerGMLevel < LimitPlayerGMLevel then
				SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. "����ҵ�GM�ȼ�����")
				return
			end
			ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param1, GetCmdAndParamDetail.Param2)

		elseif GetCmdAndParamDetail.FuncName == "changeglorydot" then
			if PlayerGMLevel < LimitPlayerGMLevel then
				SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. "����ҵ�GM�ȼ�����")
				return
			end
			ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param1, GetCmdAndParamDetail.Param2)
		else	--ǰ���⼸��������ִ�к����Ĳ���������ҵ�GID���������������ִ�к����еĲ�����û��GID����������һ��

			if PlayerGMLevel < LimitPlayerGMLevel then
				SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. "����ҵ�GM�ȼ�����")
				return
			end


			SetPlayerObject(GetCmdAndParamDetail.Param1)  --ͨ��GID����ִ�нű������

			if GetCmdAndParamDetail.FuncName == "activepackage" then	--���͸��µĸ���
				ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(0, GetCmdAndParamDetail.Param2, GetCmdAndParamDetail.Param3)	--ͨ����һ�������͵ڶ�������������ĸ���״̬�Ĵ�С
				local ActiveCellNum = GetCmdAndParamDetail.Param2
				--�ɹ�, ��һ������������ڶ��������ǵ�ǰ�������չ��������
				SendActivePackage(0, ActiveCellNum)
			else

				--���������Ĳ���һ�㲻����4������������У�����������
				if ParamIndex == 1 then
					ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc()
				elseif ParamIndex == 2 then
					ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param2)
				elseif ParamIndex == 3 then
					ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param2, GetCmdAndParamDetail.Param3)
				elseif ParamIndex == 4 then
					ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param2, GetCmdAndParamDetail.Param3, GetCmdAndParamDetail.Param4)
				elseif ParamIndex == 5 then
					ReturnValue = GM_Command_List[GetCmdAndParamDetail.FuncName].ExceteFunc(GetCmdAndParamDetail.Param2, GetCmdAndParamDetail.Param3, GetCmdAndParamDetail.Param4, GetCmdAndParamDetail.Param5)
				end
			end

		end

		if ReturnValue == nil or not ReturnValue then
			SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. "������ʧ��")	--����ʧ��
			return
		else
			SendGmExceResult(MsgType, MsgTalker, CmdAndParams .. "�������ɹ�")
			return
		end
	end
end
