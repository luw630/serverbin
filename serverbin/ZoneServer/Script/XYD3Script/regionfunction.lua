--�ص�ʱ���ͼ���鱶�ʶ�Ӧ��
AddExpTable = {}
reginmonstertab = {}

AddExpTable[1]=
{
	reginid = 2,		--��ͼID
	Date = 20120206,		--������	
	starttime = 11,		--��ʼʱ��
	endtime = 13,		--����ʱ��
	increaseexp  = 2,	--���鱶��
}


reginmonstertab[1] = 
{	
	Date = 20120206,
	starttime = 13,
	Isrefresh = 0,
	
	monster = 
	{
		objectType = 0,
		monsterId = 51,
		refreshTime = -1,
		regionId = 1,
		x = 600,
		y = 400,
	}

} 


function reginrun(rid)
	local rdate = tonumber(os.date("%Y%m%d"))
	local ttime = tonumber(os.date("%H"))  
	for k, v in pairs(reginmonstertab) do
		if(v.monster.regionId == rid and v.Date == rdate and ttime >= v.starttime and v.Isrefresh == 0 )then
			CreateObjectIndirect(v.monster)
			v.Isrefresh = 1
			rfalse("��������Ѿ�ˢ��")
		end
	end

end

function reginaddexp(rid)
	local tdate = tonumber(os.date("%Y%m%d"))
	local ttime = tonumber(os.date("%H"))  
	for k, v in pairs(AddExpTable) do
		if( v.reginid == rid and v.Date == tdate) then
			if( ttime >= v.starttime and ttime < v.endtime) then
				rfalse("˫������")
				return v.increaseexp
			end
		end
	end
	return 1
end