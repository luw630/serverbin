--定义枚举类型
function enum( tbl,index )
rfalse("enum")
    local ret = {}
    local evalue=index or 0
    for k,v in pairs(tbl) do    
    rfalse(k)
    rfalse(v)
    rfalse("-----")
    	if type(k)==type(0) then
    		ret[v] = evalue
    	elseif type(k)==type('') and type(v)==type(0) then
    		ret[k] = v
    		evuale = v  		
    	end
    	
			evalue = evalue + 1
    end
    -- 在这里开始修改 metatable
    setmetatable(ret, ret)    -- 自己就是自己的 metatable
    ret.safeindex = function(t, k)    -- 定义一个 assert 版的 __index
			t.__index = nil
			local tmp = t[k]
			t.__index = t.safeindex
			assert( tmp )
			return tmp
    end
    ret.__index = ret.safeindex    -- 将默认的 __index 替换成 assert 版的 __index
    -- 结束修改 metatable
    return ret
end