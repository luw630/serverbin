-- this is a sample script file
-- define global functions and variables
----------------------------------------------------------------

-- global variables ---------------------------------------------
ScriptID = nil;  
EventID = 1;

function openfile( filename, option, chk )
	local handle = io.open( filename, option )
	if ( chk == nil and handle == nil ) then
		rfalse( '文件打开失败:' .. filename )
	end
	return handle
end

function closefile( file_handle )
	return file_handle:close()
end

function write( file_handle, str )
    if ( file_handle == nil ) then
		rfalse( str )
	end
	return file_handle:write( str )
end

function read( file_handle, option )
	if ( option == nil ) then
		return file_handle:read( "*l" )
	end

	return file_handle:read( option )
end

-- define the name of the call function -------------------
callFunc_name = "OnClick"
callMenu_name = "ClickMenu"
-- action ID ----------------------------------------------
	TI_NORMAL  = 0
	TI_OneTask   = 1
	TI_RUN    = 2 
	TI_JUMP   = 3
	TI_FORGE    = 4
	TI_FUSE = 5
	TI_WOUND1 = 6
	TI_WOUND2 = 7
	TI_WOUND3 = 8
	TI_KNOCKOUT = 9
	TI_DEAD     = 10
        TI_TEMP     = 666
-- bijou type ---------------------------------------------
        BT_YELLOW = 30
        BT_BLUE   = 31
        BT_GREEN  = 32
        BT_WHITE  = 33
        BT_RED    = 34
        BT_BLACK  = 35
-- global functions --------------------------------------------
function Lua_Debug(info)
       handle = openfile("Lua_Debug.txt", "a")
       write(handle, info.."\n")
       closefile(handle)
    
end

function InFile(filename, info, mode)
		handle = openfile(filename, mode)
		write(handle, info.."\n")
       		closefile(handle)
end

function InFile_T(filename,table, max, mode)
		handle = openfile(filename, mode)
      for n = 1, max do
         write(handle, table[n].."\n")
      end
       closefile(handle)
end

function OutFile_T(filename, table, max)
	handle = openfile(filename, "r")
	if(handle ~= nil)then
      for  n = 1, max do
         table[n] = read(handle)	
      end
		closefile(handle)
	end
end

function OutFile(filename)
	local info = nil
	handle = openfile(filename, "r")
	if(handle ~= nil)then
		info = read(handle)		
		closefile(handle)
	end
	return info
end

function InitTable(table, max, data)
   for n = 1, max do
      table[n] = data
   end
end

function Delay(seconds)     
       local start_time = clock()  
       local now_time = start_time
       local end_time = start_time + seconds
       while (now_time < end_time) do
           now_time = clock()
       end
end

function random(min,max)
   if ( max ~= nil ) then
      if ( max < min ) then
         return math.random(max,min)
      else
         return math.random(min,max)
      end
   end
   return math.random(1, min)
end

-- show dialog------------------------------------------------------------------------
function ShowDialog(id, SayString)
         return id, SayString 
end

function LostMoreItems(who, table, itemnum, life, range, moneynum)
	for n = 1, itemnum do
		LostItems(who, table[n], life, range, moneynum)
	end
end

function getreginnum(gid)
    GetDynamicScenePlayerNumber(gid)
end

function GetRegionCountNum(gid,objType)
    local count = GetRegionCount(gid,objType)
    rfalse("num = "..count.."")
end

function OnGetMoneyItemID() --金钱道具ID
    return 999888
end

function OnItemIsMoney(dmoneyid)
    if dmoneyid == 999888 then
        return 1
    end
    return 0
end