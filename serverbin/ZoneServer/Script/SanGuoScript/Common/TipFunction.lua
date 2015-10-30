
local _gsub= string.gsub
local  TipConfig=TipConfig
function SI_GetStr(tid,arg1,arg2,arg3,arg4,arg5)
	if tid==nil then 
		return  ""
	end
	if TipConfig[tid] ==nil then
		return  ""
	end
	
	local value = TipConfig[tid]
	if arg1	then
		value = _gsub(value,"#1", tostring(arg1))
		if arg2	then
			value =_gsub(value,"#2", tostring(arg2))
			if arg3	then
				value = _gsub(value, "#3", tostring(arg3))
				if arg4	then
					value = _gsub(value, "#4", tostring(arg4))
					if arg5	then
						value = _gsub(value, "#5", tostring(arg5))
					end
				end
			end
		end
	end
	return value
end