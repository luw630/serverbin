--玩家上线和离线以后需要维护的一个玩家列表，用以定时保存数据到db 定时时间30
SAVEDATADBTIME =  60 * 30
SAVELUADATATIME = 60 * 5
local m_DbDataServiceStartTime = os.time()
function DbDataServiceInit(  )
	if g_DbDataService == nil then
		g_DbDataService = {}
	end

end

function DbDataService_PlayerLogin( sid )
	if g_DbDataService ~= nil then
		if g_DbDataService[sid] == nil then
			g_DbDataService[sid] = {}
		end
		g_DbDataService[sid].DbDataSaveTime = os.time()
		g_DbDataService[sid].LuaDataSaveTime = os.time()
		--g_DbDataService[sid] = os.time()
	end
end


function DbDataService_PlayerLogout( sid )
	if g_DbDataService ~= nil then
		if g_DbDataService[sid] ~= nil then
			g_DbDataService[sid] = {}
			g_DbDataService[sid] = nil
		end
	end
end


function DbDataService_OnRun(  )
	local ostime = os.time()
	if os.difftime(ostime - m_DbDataServiceStartTime) >= SAVELUADATATIME then
		m_DbDataServiceStartTime = ostime
		for k,v in pairs(g_DbDataService) do
			local difftime = os.difftime(ostime - v.DbDataSaveTime)
			if difftime >= SAVEDATADBTIME then
				SavePlayerToDB(k)
				v.DbDataSaveTime =ostime
			end
		end
		SaveFactionData()  --定时刷新军团保存
	end

end

function OnExitServer(  ) --服务器将关闭,一些没有保存的数据可以最后保存一次
	-- body
	look("OnExitServer")
	SaveFactionData()  --定时刷新军团保存
end

function LoadLuaData( sid,DataName)
	if dbMgr[sid]==nil or  dbMgr[sid].data == nil then 
		look("dbMgr["..sid.."]==nil sid = "..sid)
		return 0
	end

	local DataTable = {}
	DataTable.Sid = sid
	if dbMgr[sid].data[DataName] ~= nil then
		DataTable = {}
		for k,v in pairs(dbMgr[sid].data[DataName]) do	
			if k ~= "" then
				DataTable[k] = v
			end
		end
	end

	return DataTable
end


function SaveLuaData( sid,DataName,DataTable )
	if dbMgr[sid]==nil or  dbMgr[sid].data == nil then 
		look("dbMgr["..sid.."]==nil gid = "..sid)
		return 0
	end
	if dbMgr[sid].data[DataName]==nil then 
		dbMgr[sid].data[DataName]={}
	end

	if DataTable == nil then
		look("SaveLuaData Faile DataTable nil")
		return 0
	end

	if type(DataTable) ~= "table" then
		look("SaveLuaData Faile type DataTable")
		return 0
	end

	-- look("SaveLuaData")
	-- look(DataTable)
	for k,v in pairs(DataTable) do	
		dbMgr[sid].data[DataName][k] = v
	end
	-- dbMgr[sid].data[DataName] = {}
	-- dbMgr[sid].data[DataName] = DataTable

	return 1
end

function LuaRandomSeed()
	local seed = os.time() % 10000
	math.randomseed(os.clock() * seed )
end

DbDataServiceInit()