--����ö������
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
    -- �����￪ʼ�޸� metatable
    setmetatable(ret, ret)    -- �Լ������Լ��� metatable
    ret.safeindex = function(t, k)    -- ����һ�� assert ��� __index
			t.__index = nil
			local tmp = t[k]
			t.__index = t.safeindex
			assert( tmp )
			return tmp
    end
    ret.__index = ret.safeindex    -- ��Ĭ�ϵ� __index �滻�� assert ��� __index
    -- �����޸� metatable
    return ret
end