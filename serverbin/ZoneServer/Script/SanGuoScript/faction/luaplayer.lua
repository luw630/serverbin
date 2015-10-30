--用于记录玩家在线时的一些数据，目前有些数据会频繁的多次取，这里可以保存取出的数据，不用每次都在c++
--取出来， 减少lua和C++ 的多次交互 还有一些临时的数据而不需要保存，也可以使用这里。比如一些玩家上线的才有，下线就销毁的数据
LuaPlayer = 
{
}


function LuaPlayer:new (o) 
	 o = o or {} 
	 setmetatable(o, self) 
	 self.__index = self 
	 return o 
end 

function LuaPlayer:Init(sid)
	look("LuaPlayer Init"..sid)
	self.sid = sid
	self.PlayerName = CI_GetPlayerDataSG(sid,4)
end


return LuaPlayer
