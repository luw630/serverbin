GiftTable = {}


--�������ֵ1-9Ϊ�������
GiftTable[1] = {--8005001  5���������
				7000001,50,--50��1������ҩ
				7010001,50,--50��1������ҩ
				8021001,1,--��ʱ����������ѧ����
				8005002,1,--10���������
				}

GiftTable[2] = {--8005002  10���������
				7000002,50,--50��10������ҩ
				7020002,50,--50��10������ҩ
				8011001,10,--10���سǴ���
				8020001,1,--5000����
				8005003,1,--15���������
				}
GiftTable[3] = {--8005003  15���������
				8005010,1,--������7000��
				4030001,1,--5����Ԫ��
				8020001,1,--5000����
				8021002,1,--��ʱ����������ѧ����
				8005004,1,--20���������
				}
				--����ǿ�����е��ߵ���û���ܣ�

GiftTable[4] = {--8005004  20���������
				3500002,1,--���������պ�
				3500003,1,--������������
				--10020001,1,--���;�����(��ʱ��Ҫ)
				4031001,1,--1��ŭ��
				8005005,1,--25���������
				}
				--GiveGoods(4060003,1) --1�����뵤

GiftTable[5] = {--8005005  25���������
				4003001,1,--3������ʯ
				4020001,1,--5���Ǽ�ɳ
				4060002,1,--1�����ϵ�
				8020002,1,--10000����
				8021003,1,--��ʱ����������ѧ����
				8005006,1,--30���������
				}

GiftTable[6] = {--8005006  30���������
				4001001,1,--5���⾧ʯ
				4000001,1,--3�����ʯ
				8020002,1,--10000����
				8005007,1,--35���������
				}
				--�����������е��ߵ���û���ܣ�

GiftTable[7] = {--8005007  35���������
				4010003,1,--1������ʯ
				4004001,1,--1��������ʯ
				4004301,1,--1��������ʯ
				4004401,1,--1��������ʯ
				4002001,1,--2������ʯ
				8021004,1,--��ʱ����������ѧ����
				8005008,1,--40���������
				}
				--10���̶����;���ʱû���ܣ�

GiftTable[8] = {--8005008  40���������
				4010007,1,--1������
				8020003,1,--20000����
				8022005,1,--1000��ȯ
				}
				--1��ϴ��ʯ����ʱû���ܣ�


--�������ֵ9-15Ϊ���߽������
GiftTable[9] = {
				4010007,1,--1������
				8020003,1,--20000����
				8022005,1,--1000��ȯ
				}
GiftTable[10] = {
				4010007,1,--1������
				8020003,1,--20000����
				8022005,1,--1000��ȯ
				}
GiftTable[11] = {
				4010007,1,--1������
				8020003,1,--20000����
				8022005,1,--1000��ȯ
				}
GiftTable[12] = {
				4010007,1,--1������
				8020003,1,--20000����
				8022005,1,--1000��ȯ
				}
GiftTable[13] = {
				4010007,1,--1������
				8020003,1,--20000����
				8022005,1,--1000��ȯ
				}
GiftTable[14] = {
				4010007,1,--1������
				8020003,1,--20000����
				8022005,1,--1000��ȯ
				}
GiftTable[15] = {
				4010007,1,--1������
				8020003,1,--20000����
				8022005,1,--1000��ȯ
				}




--��������������Ʒ�б�
function OnGenerateNewItem8005001(ItemID)
	--���߱��8005001-8005008Ϊ�������
	if ItemID == 8005001 then
		return creategift(ItemID,GiftTable[1])
	elseif ItemID == 8005002 then
		return creategift(ItemID,GiftTable[2])
	elseif ItemID == 8005003 then
		return creategift(ItemID,GiftTable[3])
	elseif ItemID == 8005004 then
		return creategift(ItemID,GiftTable[4])
	elseif ItemID == 8005005 then
		return creategift(ItemID,GiftTable[5])
	elseif ItemID == 8005006 then
		return creategift(ItemID,GiftTable[6])
	elseif ItemID == 8005007 then
		return creategift(ItemID,GiftTable[7])
	elseif ItemID == 8005008 then
		return creategift(ItemID,GiftTable[8])
	--���߱��8005021-8005027Ϊ�������
	elseif ItemID == 8005021 then
		return creategift(ItemID,GiftTable[9])
	elseif ItemID == 8005022 then
		return creategift(ItemID,GiftTable[10])
	elseif ItemID == 8005023 then
		return creategift(ItemID,GiftTable[11])
	elseif ItemID == 8005024 then
		return creategift(ItemID,GiftTable[12])
	elseif ItemID == 8005025 then
		return creategift(ItemID,GiftTable[13])
	elseif ItemID == 8005026 then
		return creategift(ItemID,GiftTable[14])
	elseif ItemID == 8005027 then
		return creategift(ItemID,GiftTable[15])
	end
end

function OnUseItem8005001(ItemID)
	local TempUse = usegift(ItemID)
	return TempUse
end


