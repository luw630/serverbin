-- ########################################################CG播放

function StartCGForTask(cgid,taskid)
	local taskData = GetCurDBTaskData()
	if taskData == nil or taskData.current == nil or taskData.current[taskid] == nil then
		return
	end
	local cgdata = taskData.current[taskid].cg 
	if cgdata == nil then
		taskData.current[taskid].cg = {}
	end
	
	if( taskData.current[taskid].cg[cgid]==nil) then
		taskData.current[taskid].cg[cgid]=1
		SendLuaMsg( 0, { ids = {2,1}, cg=cgid }, 9 )
		GetCurTaskTemp().cgid = cgid
		return 1
	else
		return 0
	end
end

----少林cg1
SetMapEvent(1,12,155,41,4)

function OnMapEvent41()
  if CurPlayerHasTask(1001)  then
    StartCGForTask(41,1001)
  end
end

----少林cg1另外一个点
SetMapEvent(1,23,166,48,4)

function OnMapEvent48()
  if CurPlayerHasTask(1001)  then
    StartCGForTask(41,1001)
  end
end

----少林cg2
SetMapEvent(1,19,33,42,4)

function OnMapEvent42()
  if CurPlayerHasTask(1004)  then
    StartCGForTask(42,1004)
  end
end

----少林cg3
SetMapEvent(1,8,12,43,4)

function OnMapEvent43()
  if CurPlayerHasTask(1006)  then
    StartCGForTask(43,1006)
  end
end

----少林cg6
SetMapEvent(110,31,31,46,4)

function OnMapEvent46()
  if CurPlayerHasTask(1018) and not CurPlayerCouldComplete(1018) then
    RunCg(46)
  end
end
------------------------------------------
----武当cg21
SetMapEvent(3,21,33,21,4)

function OnMapEvent21()
  if CurPlayerHasTask(5004)  then
    StartCGForTask(21,5004)
  end
end

----武当cg25
SetMapEvent(3,72,77,25,6)

function OnMapEvent25()
  if CurPlayerHasTask(5006)  then
    StartCGForTask(25,5006)
  end
end

----武当cg23
SetMapEvent(3,20,102,23,4)

function OnMapEvent23()
  if CurPlayerHasTask(5001)  then
    StartCGForTask(23,5001)
  end
end

------------------------------------临时
----木人巷通行事件点之基本功房
SetMapEvent(102,70,46,100,2)

function OnMapEvent100()
  if CurPlayerCouldComplete(1010) or CurPlayerCompletedTask(1010) then
    PutPlayerTo(103,5,86,0)
  else
    SendStoryData(50000)
  end
end

----木人巷通行事件点之轻功房
SetMapEvent(104,70,55,101,2)

function OnMapEvent101()
  if CurPlayerCouldComplete(1012) or CurPlayerCompletedTask(1012) then
    PutPlayerTo(105,5,87,0)
  else
    SendStoryData(50001)
  end
end

----木人巷通行事件点之招式房
SetMapEvent(106,71,40,102,2)

function OnMapEvent102()
  if CurPlayerCouldComplete(1015) or CurPlayerCompletedTask(1015) then
    PutPlayerTo(107,5,87,0)
  else
    SendStoryData(50002)
  end
end

----木人巷通行事件点之硬气功房
SetMapEvent(108,71,40,103,2)

function OnMapEvent103()
  if CurPlayerCouldComplete(1016) or CurPlayerCompletedTask(1016) then
    PutPlayerTo(109,5,87,0)
  else
    SendStoryData(50003)
  end
end

-------------------------
----峨眉魔教弟子传话
SetMapEvent(2,23,126,31)

function OnMapEvent31()
  if CurPlayerHasTask(2001)  then
    StartCGForTask(31,2001)
  end
end

----峨眉cg4
SetMapEvent(2,57,61,33)

function OnMapEvent33()
  if CurPlayerHasTask(2001)  then
    StartCGForTask(33,2001)
  end
end

----峨眉cg6
SetMapEvent(2,55,65,36,4)

function OnMapEvent36()
  if CurPlayerHasTask(2014)  then
    StartCGForTask(36,2014)
  end
end


------------------------------------临时
----星宿cg51
SetMapEvent(5,17,141,51,10)

function OnMapEvent51()
  if CurPlayerHasTask(4001) then
    StartCGForTask(51,4001)
  end
end

----星宿cg53
SetMapEvent(5,110,15,53,10)

function OnMapEvent53()
  if CurPlayerHasTask(4004) then
    StartCGForTask(53,4004)
  end
end

----星宿cg55
SetMapEvent(5,20,29,55,4)

function OnMapEvent55()
  if CurPlayerHasTask(4007) then
    StartCGForTask(55,4007)
  end
end

----星宿cg56
function CG56()
  if CurPlayerHasTask(4013) then
    StartCGForTask(56,4013)
  end
end

----星宿cg57
SetMapEvent(10,156,192,57,6)

function OnMapEvent57()
  if CurPlayerHasTask(4023) then
    StartCGForTask(57,4023)
  end
end

----星宿cg59
SetMapEvent(10,155,194,59,6)

function OnMapEvent59()
  if CurPlayerHasTask(4018) then
    StartCGForTask(59,4018)
  end
end

----星宿cg511
SetMapEvent(5,37,110,511,6)

function OnMapEvent511()
  if CurPlayerHasTask(4020) then 
    StartCGForTask(511,4020)
  end
end

----------------------------------圣火

--------圣火CG61
SetMapEvent(4,38,103,61,6)

function OnMapEvent61()
  if CurPlayerHasTask(3001) then
    StartCGForTask(61,3001)
  end
end

--------圣火CG62
SetMapEvent(4,59,72,62,6)

function OnMapEvent62()
  if CurPlayerHasTask(3001) then
    StartCGForTask(62,3001)
  end
end

--------圣火CG63
SetMapEvent(4,69,57,63,6)

function OnMapEvent63()
  if CurPlayerHasTask(3001) then
    StartCGForTask(63,3001)
  end
end

--------圣火CG67
SetMapEvent(4,75,51,67,4)

function OnMapEvent67()
  if CurPlayerHasTask(3016) then
    StartCGForTask(67,3016)
  end
end
