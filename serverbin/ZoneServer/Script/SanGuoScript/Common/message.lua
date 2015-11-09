
local checkin_quest=checkin_quest
-- Ç©µ½
 msgDispatcher[101][1] = function ( sid,msg )
	-- --look(msg)
	 checkin_quest(sid,msg.itype)
 end