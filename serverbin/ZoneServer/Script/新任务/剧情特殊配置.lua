--------------------------��ɽ����֮����
----------------------------------------
--[[
function OnClickTask50017()--��ü����
local xmap = CreateDynamicRegion(1)
    PutPlayerTo(0,13,143,xmap)
end

function OnClickTask50018()--�䵱����
local xmap = CreateDynamicRegion(2)
    PutPlayerTo(0,13,125,xmap)
end

function OnClickTask50019()--ʥ�����
local xmap = CreateDynamicRegion(3)
    PutPlayerTo(0,17,107,xmap)
end

function OnClickTask50020()--���޵���
local xmap = CreateDynamicRegion(4)
    PutPlayerTo(0,11,72,xmap)
end

--------------------------��ɽ����֮��ü
----------------------------------------
function OnClickTask50021()--���ֵ���
local xmap = CreateDynamicRegion(5)
    PutPlayerTo(0,17,181,xmap)
end

--------------------------��ɽ����֮�䵱
----------------------------------------
function OnClickTask50022()--��ü����
local xmap = CreateDynamicRegion(6)
    PutPlayerTo(0,13,143,xmap)
end

--------------------------��ɽ����֮ʥ��
----------------------------------------
function OnClickTask50023()--�䵱����
local xmap = CreateDynamicRegion(7)
    PutPlayerTo(0,13,125,xmap)
end

--------------------------��ɽ����֮����
----------------------------------------
function OnClickTask50024()--ʥ�����
local xmap = CreateDynamicRegion(8)
    PutPlayerTo(0,17,107,xmap)
end

-------------------------------����ѧϰ��
-------------------------------����̬����
--�������Ṧ
function OnClickTask50025()
local xmap = CreateDynamicRegion(9)
PutPlayerTo(0,30,55,xmap)
end

--�䵱���Ṧ
function OnClickTask50008()
local xmap = CreateDynamicRegion(10)
PutPlayerTo(0,72,76,xmap)
end

--��ü���Ṧ
function OnClickTask50011()
local xmap = CreateDynamicRegion(11)
PutPlayerTo(0,95,74,xmap)
end

--�������Ṧ
function OnClickTask50013()
local xmap = CreateDynamicRegion(12)
PutPlayerTo(0,47,155,xmap)
end

--ʥ�����Ṧ
function OnClickTask50015()
local xmap = CreateDynamicRegion(13)
PutPlayerTo(0,121,70,xmap)
end



-------------------------------����ս��
-------------------------------��̬����

--�䵱�����鴦
function OnClickTask50006()
local xmap = CreateDynamicRegion(14)
PutPlayerTo(0,52,19,xmap)
end

--ľ�������
function OnClickTask50001()
local xmap = CreateDynamicRegion(15)
PutPlayerTo(0,27,37,xmap)
end

--��ü������
function OnClickTask50002()
local xmap = CreateDynamicRegion(16)
PutPlayerTo(0,90,145,xmap)
end

--����лѷ��
function OnClickTask50003()
local xmap = CreateDynamicRegion(17)
PutPlayerTo(0,52,33,xmap)
end

--�����ɲɻ��Ӵ�
function OnClickTask50004()
local xmap = CreateDynamicRegion(18)
PutPlayerTo(0,163,55,xmap)
end

-------------------------------��������
-------------------------------��̬����

--�ɲ�����
function gochongzi()
local xmap = CreateDynamicRegion(19)
PutPlayerTo(0,168,28,xmap)
end

--�������ǰ��֮�����
function bingcan()
local xmap = CreateDynamicRegion(20)
  if CurPlayerHasTask(4020) and not CurPlayerCouldComplete(4020) then
    PutPlayerTo(0,111,146,xmap)
  end
end

--�Ṧ�ɼ����񲹸�����
function GiveSP()
local school = GetPlayerData(2)
  if school ==0 then
    PutPlayerTo(104,30,55,0)
    AddPlayerCurSp(100)
  elseif school == 1 then
    PutPlayerTo(2,95,74,0)
    AddPlayerCurSp(100)
  elseif school == 2 then
    PutPlayerTo(3,70,76,0)
    AddPlayerCurSp(100)
  elseif school == 3 then
    PutPlayerTo(4,121,70,0)
    AddPlayerCurSp(100)
  elseif school == 4 then
    PutPlayerTo(10,47,155,0)
    AddPlayerCurSp(100)
  end
end

-------------------------------��������
-------------------------------�������

--��̹֮�������
function GoXXBC()
PutPlayerTo(10,77,126,0)
end

--˵���ô������
function GoSH()
PutPlayerTo(4,118,120,0)
end

--���ɴ��;���
function GoJC()
PutPlayerTo(17,38,242,0)
end

--���Ǵ�������
function GoMP()
local school = GetPlayerData(2)
  if school ==0 then
    PutPlayerTo(1,12,171,0)
  elseif school == 1 then
    PutPlayerTo(2,10,150,0)
  elseif school == 2 then
    PutPlayerTo(3,7,107,0)
  elseif school == 3 then
    PutPlayerTo(4,15,134,0)
  elseif school == 4 then
    PutPlayerTo(5,7,156,0)
  end
end

-------------------------------��������
-------------------------------CG�������

--����CG45
function SLqinggong()
RunCg(45)
end

--����CG56����
function CG56()
  if CurPlayerHasTask(4013) and not CurPlayerCouldComplete(4013) then
    RunCg(56)
  end
end

--��ɽ�۽�CG����
function HSLJ()
  if CurPlayerHasTask(1024)  then
    StartCGForTask(1002,1024)
  elseif CurPlayerHasTask(2022)  then
    StartCGForTask(1002,2022)
  elseif CurPlayerHasTask(3021)  then
    StartCGForTask(1002,3021)
  elseif CurPlayerHasTask(4027)  then
    StartCGForTask(1002,4027)
  elseif CurPlayerHasTask(5020)  then
    StartCGForTask(1002,5020)
  end
end
--]]