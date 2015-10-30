--初始化副本仓库
msgDispatcher[4][100] = function ( playerid, msg )
	rfalse('Iint copy scene storagehome')
	local storydata = msg.data
	--清空仓库
	ClearCopyStorage( );	
	local x=0;
	local y=0;
	--初始化仓库
	for k,v in pairs(storydata) do   
		--c是从0开始的,所以将k-1
		x = (k-1)%8;
		y = (k-1)/8;
		AddCopyStorageItem( v[1],x,y,v[2] );
		--x = x+1;
		--if x==8 then x=0 y=y+1 end
	end 
	--打开仓库面板
	ShowCopyStorage( true );
end

--删除副本仓库道具
msgDispatcher[4][1001] = function ( playerid, msg )	
	local pos = msg.pos	
	DelCopyStorage( pos.x, pos.y );		
end

--完成副本任务
msgDispatcher[4][51] = function ( playerid, msg )		
	
	local member = msg.team
	for k, v in pairs(member) do
		OnSuccess( v )		
	end
	SetCopySceneTime(0)
	
end

--如果有完成时间限制,开始计时
msgDispatcher[4][52] = function ( playerid, msg )			
	if msg.time == nil then
		SetCopySceneTime(0)
	else
		SetCopySceneTime(msg.time)
	end
end

--副本任务追踪

msgDispatcher[4][53] = function ( playerid, msg )	
	local specialTips = g_specialTips or {}
	specialTips[4053]=msg.tips
end