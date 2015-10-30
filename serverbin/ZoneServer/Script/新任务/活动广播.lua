
nHour = GetCurTime(4);
nMinute = GetCurTime(5);
nSecond = GetCurTime(6);

for k,v in pairs(ActiveConfig) do
	vHour = rint(v[2] / 10000)
	vMinute = rint(( v[2] - vHour * 10000)/ 100)
	vSecond = rint(v[2] - vHour * 10000 - vMinute * 100)

	if ( vSecond - nSecond < 0) then
		vMinute = vMinute - 1
	end
	if ( vMinute - nMinute < 0) then
		vHour = vHour - 1
	end

	duration = ( vHour - nHour) % 24 * 24 * 60 +  ( vMinute - nMinute) % 60 * 60 + ( vSecond - nSecond) % 60

	SetEvent( duration, k, "BoardCastMsg", v[1])
end

function BoardCastMsg ( bMsg)
	SendBoardCastMsg( bMsg)
end
	

