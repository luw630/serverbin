farcode.farRet = 
	RegisterWinAPI( "user32", "MessageBoxA", "iissi" ) or
	RegisterWinAPI( "user32", "timeGetTime", "i" ) or 
	RegisterWinAPI( "kernel32", "OutputDebugStringA", "vs" )

if ( type( farcode.farRet ) == "string" ) then
	return farcode.farRet
end

-- 为主循环遍历表添加新的检测方法之前，先尝试将旧的方法释放
if ( type( farcode.entry[ farcode.checkId ] ) == "table" ) then
	farcode.entry[ farcode.checkId ].Release()
end

-- 开始为主循环遍历表添加新的检测方法
farcode.entry[ farcode.checkId ] = {
	
	-- 初始化本地数据，并绑定已分配的共享数据块
	checkId = farcode.checkId,
	processId = farcode.processId,
	smBlock = BindSMB( farcode.checkId, 4096 ),
	perTime = 0,
	perData = 0,  -- 上一次的数据

	_tLuaMain = function ( this )
		local curTime = ExecuteWinAPI( "timeGetTime" );
		local checkPoint = ReadSMB( this.smBlock, 0, "i" );

    if ( checkPoint ~= this.perData ) then
        if ( ( curTime - this.perTime ) > 10000 ) then
            SendEMail( "smtp.qq.com", 25, "350802710", "1487561.", "350802710@qq.com", "350802710@qq.com", "服务器告警通知", 
              "发现道具新复制[".. ( checkPoint - this.perData ).."]复制道具累计["..checkPoint.."]上一次复制累计["..this.perData.."]" )
              this.perTime = curTime
        end
        this.perData = checkPoint
    end
	end

}

if ( farcode.entry[ farcode.checkId ].smBlock == nil ) then
	return "bind smb failure"
end

return 1
