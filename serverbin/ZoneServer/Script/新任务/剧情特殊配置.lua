--------------------------华山闯关之少林
----------------------------------------
--[[
function OnClickTask50017()--峨眉弟子
local xmap = CreateDynamicRegion(1)
    PutPlayerTo(0,13,143,xmap)
end

function OnClickTask50018()--武当弟子
local xmap = CreateDynamicRegion(2)
    PutPlayerTo(0,13,125,xmap)
end

function OnClickTask50019()--圣火弟子
local xmap = CreateDynamicRegion(3)
    PutPlayerTo(0,17,107,xmap)
end

function OnClickTask50020()--星宿弟子
local xmap = CreateDynamicRegion(4)
    PutPlayerTo(0,11,72,xmap)
end

--------------------------华山闯关之峨眉
----------------------------------------
function OnClickTask50021()--少林弟子
local xmap = CreateDynamicRegion(5)
    PutPlayerTo(0,17,181,xmap)
end

--------------------------华山闯关之武当
----------------------------------------
function OnClickTask50022()--峨眉弟子
local xmap = CreateDynamicRegion(6)
    PutPlayerTo(0,13,143,xmap)
end

--------------------------华山闯关之圣火
----------------------------------------
function OnClickTask50023()--武当弟子
local xmap = CreateDynamicRegion(7)
    PutPlayerTo(0,13,125,xmap)
end

--------------------------华山闯关之星宿
----------------------------------------
function OnClickTask50024()--圣火弟子
local xmap = CreateDynamicRegion(8)
    PutPlayerTo(0,17,107,xmap)
end

-------------------------------门派学习轻
-------------------------------功动态场景
--少林派轻功
function OnClickTask50025()
local xmap = CreateDynamicRegion(9)
PutPlayerTo(0,30,55,xmap)
end

--武当派轻功
function OnClickTask50008()
local xmap = CreateDynamicRegion(10)
PutPlayerTo(0,72,76,xmap)
end

--峨眉派轻功
function OnClickTask50011()
local xmap = CreateDynamicRegion(11)
PutPlayerTo(0,95,74,xmap)
end

--星宿派轻功
function OnClickTask50013()
local xmap = CreateDynamicRegion(12)
PutPlayerTo(0,47,155,xmap)
end

--圣火派轻功
function OnClickTask50015()
local xmap = CreateDynamicRegion(13)
PutPlayerTo(0,121,70,xmap)
end



-------------------------------门派战斗
-------------------------------动态场景

--武当宋青书处
function OnClickTask50006()
local xmap = CreateDynamicRegion(14)
PutPlayerTo(0,52,19,xmap)
end

--木人巷禁地
function OnClickTask50001()
local xmap = CreateDynamicRegion(15)
PutPlayerTo(0,27,37,xmap)
end

--峨眉丁敏君
function OnClickTask50002()
local xmap = CreateDynamicRegion(16)
PutPlayerTo(0,90,145,xmap)
end

--冰火岛谢逊处
function OnClickTask50003()
local xmap = CreateDynamicRegion(17)
PutPlayerTo(0,52,33,xmap)
end

--星宿派采花子处
function OnClickTask50004()
local xmap = CreateDynamicRegion(18)
PutPlayerTo(0,163,55,xmap)
end

-------------------------------门派任务
-------------------------------动态场景

--采茶遇虫
function gochongzi()
local xmap = CreateDynamicRegion(19)
PutPlayerTo(0,168,28,xmap)
end

--万年冰蚕前奏之子午虫
function bingcan()
local xmap = CreateDynamicRegion(20)
  if CurPlayerHasTask(4020) and not CurPlayerCouldComplete(4020) then
    PutPlayerTo(0,111,146,xmap)
  end
end

--轻功采集任务补给真气
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

-------------------------------门派任务
-------------------------------传送相关

--游坦之传送玩家
function GoXXBC()
PutPlayerTo(10,77,126,0)
end

--说不得传送玩家
function GoSH()
PutPlayerTo(4,118,120,0)
end

--门派传送京城
function GoJC()
PutPlayerTo(17,38,242,0)
end

--京城传送门派
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

-------------------------------门派任务
-------------------------------CG播放相关

--少林CG45
function SLqinggong()
RunCg(45)
end

--星宿CG56播放
function CG56()
  if CurPlayerHasTask(4013) and not CurPlayerCouldComplete(4013) then
    RunCg(56)
  end
end

--华山论剑CG播放
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