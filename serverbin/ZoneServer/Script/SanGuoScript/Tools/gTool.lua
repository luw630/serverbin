--[[
file:	gmOrder.lua
author:	wk
update:	2015-05-29
desc:gm命令模块
]]--

--[[
传入字符串，返回一个usedata可当成lua表修改其中值，例子如下 
	tempStr = mutstring("sssssssssss")
	look(tempStr[2])
	tempStr[2] = "f"
	a = "string:"
	look(a..tostring(s))
]]--
local _ceil = math.ceil
local _fmod = math.fmod
local _pow = math.pow
local _floor = math.floor
function mutstring (s)
  assert(type(s) == "string", "string expected")
  local ms = s or ""
  local u = newproxy(true)
  local mt = getmetatable(u)
  local relatpos = function(p)
    local l = #ms
    if p < 0 then p = l + p + 1 end
    if p < 1 then p = 1 end
    return p, l
  end
  mt.__index = function(_, k)
    assert(type(k) == "number", "number expected as key")
    local k, l = relatpos(k)
    if k <= l then
      return ms:sub(k, k)
    end
  end
  mt.__newindex = function(_, k, v)
    assert(type(k) == "number", "number expected as key")
    assert(type(v) == "string" and #v == 1, "character expected as value")
    local k, l = relatpos(k)
    if k <= l + 1 then
      ms = ms:sub(1, k - 1) .. v .. ms:sub(k + 1, l)
    end
  end
  mt.__len = function(_) return #ms end
  mt.__tostring = function(_) return ms end
  return u
  
end


function replace_string(src, targetchar, index) --传入字符串src，把第index个字符修改成targetchar字符
	change = mutstring(src)
	if(change == nil) then
		return nil
	end
	change[index] = targetchar
	return tostring(change)
end



function get_digitnum(srcNum, digitNum) --获取srcNum的digitNum位上的数
	if type(srcNum) ~= type(0) --如果参数不是整形，则返回nil
	or type(digitNum) ~= type(0) 
	or digitNum <=0  then 
		return nil 
	end
	return _floor(srcNum/_pow(10,digitNum-1))%10
	--look(srcNum)
	--look(result)
	--return result
end


function set_digitnum(srcNum, digitNum, destNum) --设置srcNum的digitNum位上的数为destNum
	if type(srcNum)~= type(0)--如果参数不是整形，则返回nil
	or type(digitNum)~= type(0) 
	or type(destNum) ~= type(0) 
	or digitNum <= 0  
	or destNum > 10 
	or destNum < 0 then 
		return nil
	end 
	
	local hight_digit = _floor(srcNum / _pow(10,digitNum  )) * _pow(10,digitNum )--高位数的保留
	local low_digit = srcNum % _pow(10, digitNum-1) --低位数的保留
	--目标位的设置,并返回最终结果
	local result = hight_digit + _pow(10,digitNum - 1)*destNum  + low_digit 
	--look("srouce number is:"..srcNum..", hight_digit is:"..hight_digit)
	--look(result)
	return result
end


local tableremove = table.remove
local mathrandom = math.random
local tableinsert = table.insert
local setmetatable = setmetatable
local look = look
--------------------------------------------------------------------------

local random_norepeat  =
{
	--intable 列表
	new = function( self, intable, num )
		local o = { intable=intable, index = {} }

		setmetatable(o, self )
		self.__index = self

		for i=1, #intable do
			o.index[i] = i
		end

		--随机删除多余项目
		if num then
			for i=1, #intable-num do
				tableremove( o.index, mathrandom(#o.index) )
			end
		end

		return o
	end,

	--获取但不删除
	get = function( self )
		if #self.index>0 then
			local i = self.index[ mathrandom(1, #self.index ) ]
			return self.intable[ i ], i
		end
	end,

	--获取一个并删除
	pop = function( self)
		if #self.index>0 then
			local ii = mathrandom(1, #self.index )
			local i = self.index[ ii ]
			tableremove( self.index, ii )
			return self.intable[ i ],i
		end
	end,
}
--得到不重复随机数===传入表，得到个数，区间表【如1到10--{1，10}】
--has：传入/结果表 maxn：确保得到的has表的元素个数 pool：范围
function Get_num( has , maxn , pool )
	if has==nil then has={} end
	local _min 	= pool[1]
	local _max 	= pool[2]
	local m		= 1
	for q = _min , _max do
		pool[m]=q
		m=m+1
	end
	
	local num = maxn
	if num>#pool then
		num=#pool
	end
	
	local a = random_norepeat:new(pool)
	local startpos = #has
	for i = 1,num do
		local mark=0
		local get = a:pop()
		if startpos > 0 then
			for i = 1 , startpos do
				if has[i] == get then
					mark=1
					break
				end
			end
		end
		if mark==0 then
			tableinsert(has,get)
		end
		if #has == maxn then return has end
	end
	look('random_num_error')
end


-- local b={}
-- local a=Get_num(b,2,{1,100})
-- look(a)
-- look(b)