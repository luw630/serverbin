
--ȫ��debug����
_DEBUG=true
function get_version()
    return "1.0.1"
end
--------------------------------------------------------------------------

--------------------------------------------------------------------------
function dofile(filename)
	local newstring = filename;
	print("dofile("..newstring..")");

	local ret,errstring = DoFile(newstring)
	if (ret == nil) then
		print("error in _old_dofile()!");
	end

	if(ret == 0) then
			--rfalse("load "..newstring.." OK!")
	elseif(ret == 1) then
			rfalse("load "..newstring..", Error run!")
	elseif(ret == 2) then
			rfalse("load "..newstring..", Error lua file!")
	elseif(ret == 3) then
			rfalse( "load "..newstring..", Error syntax!" )
	elseif(ret == 4) then
			rfalse("load "..newstring..", Error lua memory!")
	elseif(ret == 5) then
			rfalse("load "..newstring..", Error user error error!")
	else
			rfalse("load "..newstring.." don't known!!")
	end
end

-----------------------------------------------------------------------
function  SetTrapEx(regionID, listID, type, x, y, scriptID)
   local ret = 0
   if(type == 0)then
      ret = SetTrap(regionID, listID, 0)
   else
      SetTrap(regionID, listID, 0)
      ret = SetTrap(regionID, listID, type, x, y, scriptID)
   end
   return ret
end

-------------------------------------------------
function OpenScorewnd()
	local titleTable = { "�ȼ����а�", "�Ƹ����а�", "�������а�","ħͷ���а�" }
	OpenScoreList( titleTable )
end

-------------------------------------------------------------------------
SetObjectListSize(4000, 4000)
--dofile("enum.lua");
--dofile("enumdefine.lua");
--dofile("�����¼����ñ�.lua")
--dofile("�����¼�.lua")
dofile("CreatMap.lua");
dofile("Global.lua");
dofile("Core\\init.lua");
dofile("XYD3Script\\ScriptDefine.lua")
dofile("XYD3Script\\PlayerRewardfunction.lua")

--dofile("����ϵͳ\\��������\\��������.lua");
--dofile("������\\init.lua");
--dofile("�ű�������湦�ܣ������ߣ�.lua");
--dofile("����ϵͳ\\init.lua");
--dofile("EventInterface.lua");

-- 
--20150121 wk ע�͵� begin
 -- dofile("XYD3Script\\Init.lua");
-- dofile("Scene\\init.lua")
-- dofile("Equipt\\init.lua")
-- dofile("Transformers\\init.lua")
-- dofile("Arena\\init.lua")
-- dofile("DailyActivite\\DailyInit.lua")
-- dofile("Shop\\ShopInit.lua")
-- dofile("PetSys\\PetInit.lua")
 -- dofile("Recharge\\Init.lua")
dofile("RankList\\RankInit.lua")
-- dofile("ActivenessDegree\\ActivenessInit.lua")
 -- dofile("OperateActivite\\Init.lua")
--20150121 wk ע�͵� end

---20150121 wk �¼��������
dofile("SanGuoScript\\init.lua")
-------------------------------------------------------------------------
function dofile_p(path, filename)
     local newstring = path.. filename;
	print("dofile("..newstring..")");

	if (_old_dofile(newstring) == nil) then
		print("error in _old_dofile()!");
	end
end

-- out message -----------------------------------------------------------
rfalse("load init.lua OK!")
