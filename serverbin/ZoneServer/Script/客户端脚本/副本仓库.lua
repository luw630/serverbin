--��ʼ�������ֿ�
msgDispatcher[4][100] = function ( playerid, msg )
	rfalse('Iint copy scene storagehome')
	local storydata = msg.data
	--��ղֿ�
	ClearCopyStorage( );	
	local x=0;
	local y=0;
	--��ʼ���ֿ�
	for k,v in pairs(storydata) do   
		--c�Ǵ�0��ʼ��,���Խ�k-1
		x = (k-1)%8;
		y = (k-1)/8;
		AddCopyStorageItem( v[1],x,y,v[2] );
		--x = x+1;
		--if x==8 then x=0 y=y+1 end
	end 
	--�򿪲ֿ����
	ShowCopyStorage( true );
end

--ɾ�������ֿ����
msgDispatcher[4][1001] = function ( playerid, msg )	
	local pos = msg.pos	
	DelCopyStorage( pos.x, pos.y );		
end

--��ɸ�������
msgDispatcher[4][51] = function ( playerid, msg )		
	
	local member = msg.team
	for k, v in pairs(member) do
		OnSuccess( v )		
	end
	SetCopySceneTime(0)
	
end

--��������ʱ������,��ʼ��ʱ
msgDispatcher[4][52] = function ( playerid, msg )			
	if msg.time == nil then
		SetCopySceneTime(0)
	else
		SetCopySceneTime(msg.time)
	end
end

--��������׷��

msgDispatcher[4][53] = function ( playerid, msg )	
	local specialTips = g_specialTips or {}
	specialTips[4053]=msg.tips
end