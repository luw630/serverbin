--[[
file:	serialize.lua
author:	wk
update:	2015-02-13
desc:lua序列化与反序列化
]]--

function serialize1(obj)
 local lua = ""
 local t = type(obj)
 if t == "number" then
  lua = lua .. obj
 elseif t == "boolean" then
  lua = lua .. tostring(obj)
 elseif t == "string" then
  lua = lua .. string.format("%q", obj)
 elseif t == "table" then
  lua = lua .. "{\n"
 for k, v in pairs(obj) do
  lua = lua .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"
 end
 local metatable = getmetatable(obj)
  if metatable ~= nil and type(metatable.__index) == "table" then
  for k, v in pairs(metatable.__index) do
   lua = lua .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"
  end
 end
  lua = lua .. "}"
 elseif t == "nil" then
  return nil
 else
  error("can not serialize a " .. t .. " type.")
 end
 return lua
end
function serialize(obj)
 local lua = ""
 local t = type(obj)
 if t == "number" then
  lua = lua .. obj
 elseif t == "boolean" then
  lua = lua .. tostring(obj)
 elseif t == "string" then
  lua = lua .. string.format("%q", obj)
 elseif t == "table" then
  lua = lua .. "{"
 for k, v in pairs(obj) do
  lua = lua .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ","
 end
 local metatable = getmetatable(obj)
  if metatable ~= nil and type(metatable.__index) == "table" then
  for k, v in pairs(metatable.__index) do
   lua = lua .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ","
  end
 end
  lua = lua .. "}"
 elseif t == "nil" then
  return nil
 else
  error("can not serialize a " .. t .. " type.")
 end
 return lua
end

function unserialize(lua)
 local t = type(lua)
 if t == "nil" or lua == "" then
   return nil
 elseif t == "number" or t == "string" or t == "boolean" then
   lua = tostring(lua)
 else
   error("can not unserialize a " .. t .. " type.")
 end
 lua = "return " .. lua
 local func = loadstring(lua)
 --look(lua)
 if func == nil then
  return nil
 end
 recvmsg=func()
 --  --loadstring(res)()
 --    look(type(res))
 --    look(res.ids)
 --return sendmsg
end

function sz_T2S(_t)
    local szRet = "{"
    function doT2S(_i, _v)
        if "number" == type(_i) then
            szRet = szRet .. "[" .. _i .. "] = "
            if "number" == type(_v) then
                szRet = szRet .. _v .. ","
            elseif "string" == type(_v) then
                szRet = szRet .. '"' .. _v .. '"' .. ","
            elseif "table" == type(_v) then
                szRet = szRet .. sz_T2S(_v) .. ","
            else
                szRet = szRet .. "nil,"
            end
        elseif "string" == type(_i) then
            szRet = szRet .. '["' .. _i .. '"] = '
            if "number" == type(_v) then
                szRet = szRet .. _v .. ","
            elseif "string" == type(_v) then
                szRet = szRet .. '"' .. _v .. '"' .. ","
            elseif "table" == type(_v) then
                szRet = szRet .. sz_T2S(_v) .. ","
            else
                szRet = szRet .. "nil,"
            end
        end
    end
    table.foreach(_t, doT2S)
    szRet = szRet .. "}"
    return szRet
end