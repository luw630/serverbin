farcode.farRet = 
	RegisterWinAPI( "user32", "MessageBoxA", "iissi" ) or
	RegisterWinAPI( "user32", "timeGetTime", "i" ) or 
	RegisterWinAPI( "kernel32", "OutputDebugStringA", "vs" )

if ( type( farcode.farRet ) == "string" ) then
	return farcode.farRet
end

-- Ϊ��ѭ������������µļ�ⷽ��֮ǰ���ȳ��Խ��ɵķ����ͷ�
if ( type( farcode.entry[ farcode.checkId ] ) == "table" ) then
	farcode.entry[ farcode.checkId ].Release()
end

-- ��ʼΪ��ѭ������������µļ�ⷽ��
farcode.entry[ farcode.checkId ] = {
	
	-- ��ʼ���������ݣ������ѷ���Ĺ������ݿ�
	checkId = farcode.checkId,
	processId = farcode.processId,
	smBlock = BindSMB( farcode.checkId, 4096 ),
  perTime = 0,
	_tLuaMain = function ( this )
		local curTime = ExecuteWinAPI( "timeGetTime" );
		local checkPoint = ReadSMB( this.smBlock, 0, "i" );		
		local flag = ReadSMB( this.smBlock, 4, "b" );	
		local lasttime = math.abs( curTime - checkPoint )	

    ExecuteWinAPI( "OutputDebugStringA", "!"..flag )
    -- ExecuteWinAPI( "MessageBoxA", 0, "cehck1", "chck...", 0 )
		if ( ( checkPoint ~= 0 and lasttime >= 10000 ) and ( flag == 0 ) ) then
        if ( ( curTime - this.perTime ) > 10000 ) then
          
            SendEMail( "smtp.qq.com", 25, "350802710", "1487561.", "350802710@qq.com", "350802710@qq.com", "�������澯֪ͨ", 
              "DB Server persistentThread�߳�δ��Ӧ"..lasttime.."��" )
            this.perTime = curTime
            
            SendMobilephone( "192.168.0.254", 5008, "13982234502", "�������澯֪ͨ".. "DB Server persistentThread�߳�δ��Ӧ"..lasttime.."��" )
        end
		end
	end

}

if ( farcode.entry[ farcode.checkId ].smBlock == nil ) then
	return "bind smb failure"
end

return 1
