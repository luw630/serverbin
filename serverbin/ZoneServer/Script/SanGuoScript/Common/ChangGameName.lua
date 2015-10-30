
function getNameCount(sid)

	if dbMgr[sid]==nil or dbMgr[sid].data==nil then
		look("playerDataInit111 fail ,sid="..sid)
		return
	end
	if dbMgr[sid].data['CCount']==nil then --初始化
		dbMgr[sid].data['CCount']=
		{
			[1]=0
		}
		return dbMgr[sid].data['CCount']
	end

	return	dbMgr[sid].data['CCount']
end

function GetChangeNameCount(sid)
	
	local tab = getNameCount(sid)
	if tab==nil then
		look("playerDataInit111 fail ,sid="..sid)
		return 9999999
	end
	return	tab[1]
end

function ChangeNameCountAdd(sid)

	local tab = getNameCount(sid)
	tab[1]=tab[1]+1
	return	tab[1]
end

function CALLBACK_Check_db_GameName(resoult,sid,name)
	CI_ChangeName(resoult,sid,name)
end

function GetCount(sid,dataTb,index)

	local tab = getNameCount(sid)
	if tab==nil then
		look("playerDataInit111 fail ,sid="..sid)
		return 9999999
	end
	dataTb[index]=tab[1] or 0
	
	return index+1
end