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

    local max = 1
    if ( checkPoint >= max ) then
        if ( ( curTime - this.perTime ) > 10000 ) then
            SendEMail( "smtp.qq.com", 25, "350802710", "1487561.", "350802710@qq.com", "350802710@qq.com", "�������澯֪ͨ", 
              "��Ϣ���г�����������[" .. max.."]��Ϣ���д�С..[" ..checkPoint.."]")
              this.perTime = curTime
        end
    end
	end

}

if ( farcode.entry[ farcode.checkId ].smBlock == nil ) then
	return "bind smb failure"
end

return 1
