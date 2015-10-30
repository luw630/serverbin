
local checkin_quest=checkin_quest
-- Ç©µ½
msgDispatcher[100][1] = function ( sid,msg )
	--look(msg)
	checkin_quest(sid,msg.itype)
end