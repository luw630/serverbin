-- ��չ��������

-- ��չ������Ϣ(������Ʒ����Ҳ���ý�Ǯ�������ģ��ȼ�����Ʒ����û�����жϽ�Ǯ)
ActivePackageRequireInfo =
{
	--bFirstReduceItem = false, -- �Ƿ��ȿ���Ʒ
	numactivedpertime = 6, -- ÿ�α�����ĸ�������
	-- ������Ʒ
	needitem =
	{
		itemid = 900002, --8000001, -- ��ƷID
		itemnum = 1, --��Ʒ����
	},
	-- �����Ǯ
	needmoney =
	{
		moneytype = 2, --Ǯ����
		moneynum = 0, --����Ǯ����
	}
}

-- ���ܣ�������չ��������
-- BaseActivedPackage���ʼ�ı���������(24)
-- wExtGoodsActivedNum ��ǰ�Ѿ���������������
-- wWillActiveNum ����������������
-- wMaximumPackage �������������Ŀ
function ActiveExtendPackage(BaseActivedPackage, wExtGoodsActivedNum, wWillActiveNum, wMaximumPackage)
	local wActivedNum = BaseActivedPackage + wExtGoodsActivedNum
	if wActivedNum + wWillActiveNum > wMaximumPackage then
		-- ��Ҫ���������̫���ˣ���������
		SendActivePackage(2, 0)
		return
	end
	-- ��⼤�������Ƿ�ͷ�������һ��
	if wWillActiveNum ~= ActivePackageRequireInfo.numactivedpertime then
		SendActivePackage(1, 0)
	end
	-- �Ƿ��ܿ۳���Ӧ����Ʒ
	local iReduce = CheckGoods(ActivePackageRequireInfo.needitem.itemid, ActivePackageRequireInfo.needitem.moneynum,false)
	-- �۳���Ʒʧ��
	if iReduce == 0 then
		-- �Ƿ��ܿ۳����Ľ�Ǯ
		iReduce = CheckPlayerMoney(ActivePackageRequireInfo.needmoney.moneytype, ActivePackageRequireInfo.needmoney.moneynum, false)
	end

	if iReduce ~= 0 and iReduce ~= nil then
		local startPos = wActivedNum
		local endPos = wActivedNum+wWillActiveNum
		local iAns = ActivePackage(startPos, endPos, 1)
		--�ɹ�, ��һ������������ڶ��������ǵ�ǰ�������չ��������
		SendActivePackage(0, endPos-BaseActivedPackage)
		rfalse("������չ�����ɹ���")
	else
		--û������Ʒ��Ҳû�н�Ǯ
		SendActivePackage(1,0)
	end
end

gBaseActivedPackage = 24		--���ʼ�ı���������
gMaximumPackage = 96			--�������������Ŀ
-- ���ܣ�������չ��������
-- BaseActivedPackage���ʼ�ı���������(24)
-- wExtGoodsActivedNum ��ǰ�Ѿ���������������
-- wWillActiveNum ����������������
-- wMaximumPackage �������������Ŀ
function OnActiveExtendPackage( wWillActiveNum )
	local wExtGoodsActivedNum = GetActivePackageNum()
	if wWillActiveNum <= wExtGoodsActivedNum then
		return
	end
	rfalse("wExtGoodsActivedNum = "..wExtGoodsActivedNum.."wWillActiveNum = "..wWillActiveNum)
	local wActivedNum = gBaseActivedPackage + wExtGoodsActivedNum
	if wActivedNum + wWillActiveNum > gMaximumPackage then
		-- ��Ҫ���������̫���ˣ���������
		SendActivePackage(2, 0)
		return
	end
	local startPos = wActivedNum
	local endPos = wActivedNum+wWillActiveNum
	local iAns = ActivePackage(startPos, endPos, 1)
	--�ɹ�, ��һ������������ڶ��������ǵ�ǰ�������չ��������
	SendActivePackage(0, endPos-gBaseActivedPackage)
	rfalse("������չ�����ɹ���")
end




--update ly 2014/4/11
--���µļ������ز���
BAsePackageCellNum = 11
gMaxPackage = 72

ActivePackageCell = {
--		���ӵ���ʱʱ��        ���Ľ��
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
--�������,������Ϸ��,���ӹ������������ӷ������������ӽ�������������ӻ�����������ͻ������������, ����������������������������
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

--��ǰ���Ϊ��һ��ע���¼,�ú���������playerfunction.lua�ļ��е�OnPlayerLogin������


function InitActiveTotalTime()
	local ActiveTotalTime = {TotalTime = 0}	--�����Ѿ��������չ��������ʱ���ܺ�
	WeekReturnChargeData("ActiveTotalTime", ActiveTotalTime, gid);
end

function UpdateActiveTotalTime(AllTime, gid)
	--���ؼ���������õ���ʱ��
	local ActiveTotalTime = LoadPlayerTable("ActiveTotalTime", gid)
	if ActiveTotalTime == nil then
		InitActiveTotalTime(gid)
	else
		ActiveTotalTime.TotalTime = AllTime
		WeekReturnChargeData("ActiveTotalTime", ActiveTotalTime, gid);
	end

end

function ReturnCountDownTime(ActiveCell, PlayerOnlineTime, gid)	--���ظ��ӵĵ���ʱʱ��
	--���ؼ���������õ���ʱ��
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

function JudgeActivePackageCon(ActiveCell, PlayerOnlineTime, ActiveType, WillActiveNum)	--ActiveCell����ĸ�����ʼ������PlayerOnlineTime��ҵ�ǰ�ܵ�����ʱ��, ActiveTypeΪ0��ʾ�ۼ�ʱ�䵽�˼���, WillActiveNum��Ҫ������ӵ�����
	if ActiveType == 0 then
		local TimeInterval = ReturnCountDownTime(ActiveCell, PlayerOnlineTime, 0)
		if ActivePackageCell[ActiveCell].NeeOnlineTiem ~= 0 and TimeInterval == 0 then	--�ж�����ʱ���Ƿ�����, Ϊ����ʱ�伤��;
			UpdateActiveTotalTime(PlayerOnlineTime, 0)
			return 1
		else
			return 0
		end
	else	--��ҹ��򼤻ʽ
		local AllConsumeMoney = 0
		for i = ActiveCell, ActiveCell + WillActiveNum - 1 do
			AllConsumeMoney = AllConsumeMoney + ActivePackageCell[i].NeedJinBi
		end
		local bMoneyEnough = CheckPlayerMoney(1, AllConsumeMoney, 1)
		if bMoneyEnough == 0 or bMoneyEnough == nil  then	--�˶Խ���Ƿ��㹻
			return 0
		else
			ChangeMoney(1, -AllConsumeMoney)	--���Ľ��
			UpdateActiveTotalTime(PlayerOnlineTime, 0)
			return 1
		end
	end
end

function CalActivePackageAward(ActiveCell, WillActiveNum)
	local AwardAllJinBi = 0 	--�������
	local AwardAllYinBi = 0 	--������Ϸ��
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
		ChangeMoney(1, AwardAllJinBi)	--�������
	end
	if AwardAllYinBi ~= 0 then
		ChangeMoney(2, AwardAllYinBi)	--������Ϸ��
	end
	if AddAllGongJi ~= 0 then
		NewSetPlayerProperty(0, 6, AddAllGongJi)	--���ӻ�������
	end
	if AddAllFangYu ~= 0 then
		NewSetPlayerProperty(0, 7, AddAllFangYu)	--���ӻ�������
	end
	if AddAllHp ~= 0 then
		NewSetPlayerProperty(0, 9, AddAllHp)	--���ӻ�����������ͻ����������
	end
	--[[if AddAllMp ~= 0 then
		NewSetPlayerProperty(0, 9, AddAllMp)	--���ӻ����������
	end
	if AddAllTp ~= 0 then
		NewSetPlayerProperty(0, 7, AddAllTp)	--���ӻ����������
	end
	if AddAllSp ~= 0 then
		NewSetPlayerProperty(0, 3, AddAllSp)	--��������
	end--]]
end

function ActivePackageOpt(ActiveCell, PlayerOnlineTime, ActiveType, WillActiveNum)
	if gMaxPackage < ActiveCell + WillActiveNum - 1 then
		return
	end
	local Con = JudgeActivePackageCon(ActiveCell, PlayerOnlineTime, ActiveType, WillActiveNum)
	if Con == 1 then

		CalActivePackageAward(ActiveCell, WillActiveNum)
		local iAns = ActivePackage(ActiveCell - 1, ActiveCell + WillActiveNum - 1, 1)	--��C++�е�������0��ʼ����lua��Ϊ1��ʼ�����������1
		--�ɹ�, ��һ������������ڶ��������ǵ�ǰ�������չ��������
		SendActivePackage(0, ActiveCell - BAsePackageCellNum + WillActiveNum - 1)
	else
		--����������, ��һ������������ڶ��������ǵ�ǰ�������չ��������
		if ActiveType == 1 then
			SendActivePackage(1, ActiveCell - BAsePackageCellNum + WillActiveNum - 1)
		end
	end
end
