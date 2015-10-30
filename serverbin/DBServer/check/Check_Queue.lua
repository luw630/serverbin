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

	_tLuaMain = function ( this )
		local curTime = ExecuteWinAPI( "timeGetTime" );
		local checkPoint = ReadSMB( this.smBlock, 0, "i" );

    local max = 1
    if ( checkPoint >= max ) then
        if ( ( curTime - this.perTime ) > 10000 ) then
            SendEMail( "smtp.qq.com", 25, "350802710", "1487561.", "350802710@qq.com", "350802710@qq.com", "服务器告警通知", 
              "消息队列超过警告上限[" .. max.."]消息队列大小..[" ..checkPoint.."]")
              this.perTime = curTime
        end
    end
	end

}

if ( farcode.entry[ farcode.checkId ].smBlock == nil ) then
	return "bind smb failure"
end

return 1
