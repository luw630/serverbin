-- �ű��¼��ӿ� --

--�˳�����ӿ�
function OnQuitTeam( )
	rfalse('--�˳�����ӿ�')
	local sid = GetPlayerData(17)
	
	--����ɫ�Ƿ��ڸ���״̬
	local playerTemp = CS_GetPlayerTemp(sid)
	if playerTemp ~= nil then
		CS_OnQuitTeam(  )
		return
	end
end