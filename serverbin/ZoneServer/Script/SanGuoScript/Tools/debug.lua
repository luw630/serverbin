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

-- ��һ���ļ���׼����¼��־
local function _Log_Begin(FilePath)
	g_LogFile = ioopen(FilePath, "a")
	if not g_LogFile then
		look("��־�ļ���ʧ�ܣ�")
	end
end

-- ������־���򿪵��ļ���
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
	
	-- ���� Save ����������־�ļ�¼
	Save(Obj, 1)
end

-- �ر��ļ������д�ļ�
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

--ͳ����ͨ�����л����С
function gettablesize(t)
	if type(t)~=type({}) then 
		look('not table',1)
		return 
	end

	local s = 0
    for k,v in pairs( t ) do
        if ( ttype( v ) ~= 5 ) then--�Ǳ�
            s = s + vksize( v, k )
        elseif ( k ~= '' ) then         -- ������Ԫ����
            local res=gettablesize( v ) -- �ӱ�����ͳ��
            s = s + res + vksize( nil, k ) + 1
        end
    end
	return s
end
