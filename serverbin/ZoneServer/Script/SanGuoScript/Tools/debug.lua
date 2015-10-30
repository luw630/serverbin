--include:
local tostring = tostring
local type = type
local pairs = pairs
local ioopen = io.open
local osdate = os.date
local ostime = os.time
local vksize = jex.vksize
local ttype=jex.ttype
--------------------------------------------------------------------------
-- module:


g_LogFile = g_LogFile or nil

-- 打开一个文件，准备记录日志
local function _Log_Begin(FilePath)
	g_LogFile = ioopen(FilePath, "a")
	if not g_LogFile then
		look("日志文件打开失败！")
	end
end

-- 保存日志到打开的文件中
local function _Log_Save(Obj,bLogTime)
	local function Save(Obj, Level)
		if not g_LogFile then
			return
		end
		if type(Obj) == "number" or type(Obj) == "string" then
			if bLogTime then
				local Date = osdate("*t", ostime())
				local Fmt = "[" .. Date.year .. "-" .. Date.month .. "-" .. Date.day .. "-" .. Date.hour .. "-" .. Date.min .. "-" .. Date.sec .. "]\n"
				g_LogFile:write(Obj..Fmt)
			else
				g_LogFile:write(Obj)
			end
		elseif type(Obj) == type({}) then
			local Blank = ""
			for i = 1, Level do
				Blank = Blank .. "   "
			end
			g_LogFile:write("{\n")
			for k,v in pairs(Obj) do
				if tostring(k) ~= "" and v ~= Obj then
					g_LogFile:write(Blank, "[", tostring(k), "] = ")
					Save(v, Level + 1)
					g_LogFile:write("\n")
				end
			end
			g_LogFile:write(Blank, "}\n")
		else	 
			g_LogFile:write(type(Obj))
		end
	end
	
	-- 调用 Save 方法进行日志的记录
	Save(Obj, 1)
end

-- 关闭文件句柄，写文件
local function _Log_End()
	if g_LogFile then
		g_LogFile:close()
		g_LogFile = nil
	end
end

function Log(filename,t)
	_Log_Begin(filename)
	_Log_Save(t,1)
	_Log_End()
end

function look(Obj)
	if type(Obj) ~= "table" then
		rfalse(tostring(Obj))
		return
	end
	local function Save(Obj, Level)
		local Blank = ""
			for i = 1, Level do
				Blank = Blank .. "   "
			end
			for k,v in pairs(Obj) do
				if tostring(k) ~= "" and v ~= Obj then
					if type(v) ~= "table" then
						rfalse(Blank.. " [".. tostring(k).. "] = "..tostring(v))
					else
						rfalse(Blank.. " [".. tostring(k).. "] = {")	
						Save(v, Level + 2)
						rfalse(Blank.."     },")	
					end
				end
			end
	end
	rfalse("   {")
	Save(Obj, 1)
	rfalse("   }")
end

--统计普通表序列化后大小
function gettablesize(t)
	if type(t)~=type({}) then 
		look('not table',1)
		return 
	end

	local s = 0
    for k,v in pairs( t ) do
        if ( ttype( v ) ~= 5 ) then--非表
            s = s + vksize( v, k )
        elseif ( k ~= '' ) then         -- 不是哑元变量
            local res=gettablesize( v ) -- 子表，继续统计
            s = s + res + vksize( nil, k ) + 1
        end
    end
	return s
end
