-- ##################################################################

function OnMonsterDead5000()--######�޶����.�ѷ���
PutPlayerTo(6,110,85,0)
end

function OnMonsterDead5001()--ľ�����ͷ��
RunCg(47)
PutPlayerTo(1,65,99,0)
end

function OnMonsterDead5002()--�����ɶ�����
RunCg(37)
PutPlayerTo(2,93,144,0)
end

function OnMonsterDead5003()--����лѷ
RunCg(66)
PutPlayerTo(9,52,33,0)
end

function OnMonsterDead5004()--���޺��ɻ���
PutPlayerTo(10,160,52,0)
end

function OnMonsterDead5005()--�䵱��������
PutPlayerTo(3,28,44,0)
end

function OnMonsterDead5006()--���޺��������
RunCg(510)
PutPlayerTo(5,109,16,0)
end

function OnMonsterDead5007()--######��Զ�ŵ���.�ѷ���
PutPlayerTo(3,52,111,0)
end

function OnMonsterDead5010()--������
GiveGoods(4033,1)
PutPlayerTo(7,160,70,0)
end

--[[
function OnMonsterDead5013()---------���޺������
local xmap = CreateDynamicRegion(21)
local n, ok = getKillCounter(4020, "�����")
  if ok  then
    PutPlayerTo(0,111,146,xmap)
  end
end--]]
--[[
----------
function OnMonsterDead5014()--------------ѩ�Ǵ���
	local n, ok = getKillCounter(3013, "ѩ��")
   local item = CheckItemCount(4005)
	if ok  and (item<=0) then
      local xmap = CreateDynamicRegion(22)
		PutPlayerTo(0,126,95,xmap)
	end
end--]]

function OnMonsterDead5015()-------------ѩ��������
GiveGoods(4005,1)
PutPlayerTo(9,126,95,0)
end

---------------------------------------------------��ɽ�۽�
function OnMonsterDead1000()--------�����ɵ��ӵ���
	local n1, ok1 = getKillCounter(2024, "�����ɵ���")
	local n2, ok2 = getKillCounter(3023, "�����ɵ���")
	local n3, ok3 = getKillCounter(4029, "�����ɵ���")
	local n4, ok4 = getKillCounter(5022, "�����ɵ���")
  if ok1 or ok2 or ok3 or ok4 then
    PutPlayerTo(73,17,181,0)
  end
end

function OnMonsterDead1001()--------��ü�ɵ��ӵ���
	local n1, ok1 = getKillCounter(1026, "��ü�ɵ���")
	local n2, ok2 = getKillCounter(3024, "��ü�ɵ���")
	local n3, ok3 = getKillCounter(4030, "��ü�ɵ���")
	local n4, ok4 = getKillCounter(5023, "��ü�ɵ���")
  if ok1 or ok2 or ok3 or ok4 then
    PutPlayerTo(73,13,143,0)
  end
end

function OnMonsterDead1002()--------�䵱�ɵ��ӵ���
	local n1, ok1 = getKillCounter(1027, "�䵱�ɵ���")
	local n2, ok2 = getKillCounter(2025, "�䵱�ɵ���")
	local n3, ok3 = getKillCounter(3025, "�䵱�ɵ���")
	local n4, ok4 = getKillCounter(4031, "�䵱�ɵ���")
  if ok1 or ok2 or ok3 or ok4 then
    PutPlayerTo(73,13,125,0)
  end
end

function OnMonsterDead1003()--------ʥ��̵��ӵ���
	local n1, ok1 = getKillCounter(1028, "ʥ��̵���")
	local n2, ok2 = getKillCounter(2026, "ʥ��̵���")
	local n3, ok3 = getKillCounter(4032, "ʥ��̵���")
	local n4, ok4 = getKillCounter(5024, "ʥ��̵���")
  if ok1 or ok2 or ok3 or ok4 then
    PutPlayerTo(73,17,107,0)
  end
end

function OnMonsterDead1004()--------�����ɵ��ӵ���
	local n1, ok1 = getKillCounter(1029, "�����ɵ���")
	local n2, ok2 = getKillCounter(2027, "�����ɵ���")
	local n3, ok3 = getKillCounter(3026, "�����ɵ���")
	local n4, ok4 = getKillCounter(5025, "�����ɵ���")
  if ok1 or ok2 or ok3 or ok4 then
    PutPlayerTo(73,11,72,0)
  end
end
