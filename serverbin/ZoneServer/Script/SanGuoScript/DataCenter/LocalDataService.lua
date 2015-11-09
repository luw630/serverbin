--本地数据中心 考虑磁盘IO的开销。所以会在保存数量大于一定数量后全部统一保存
--本地数据.考虑保存所有的全局数据，以及玩家的数据
--某些玩家数据或者全局数据仅仅需要在特定的时间使用。可能在使用完以后不再需要
--同时为了避免类似的数据保存中可能出现的数据冗余问题，保存在这里
local g_DataSaveNum = 10
local LocalDataPath = tostring("dbTables\\Global")
local BackUpDatePath = tostring("dbTables\\BackUpDate")
function DataServiceSaveData(activityName,datatable) --保存全局活动数据
	if type(datatable) ~= "table" then
		look("Savedata no table")
		return
	end
	if g_DataService[activityName] == nil then
		g_DataService[activityName] = {}
		g_DataService.DataNum  = g_DataService.DataNum  + 1
	end

	g_DataService[activityName] = datatable
	--g_DataService[activityName] = deepcopy(datatable)
	--look("DataServiceSaveData  Save"..activityName)
end

--20151103 wk 改为引用，活动数据就不用  Activitymodule:SaveData了，会自动定时存数据
function DataServiceGetData(activityName)
	-- local datatable = {}
	-- for k,v in pairs(g_DataService) do
		-- if type(k) == "string" and type(v) == "table" then
			-- if k == activityName then
				-- datatable = deepcopy(v)
				-- return datatable
			-- end
		-- end
	-- end
	-- return nil
	if g_DataService[activityName] == nil then
		g_DataService[activityName] = {}
	end
	return  g_DataService[activityName]
end

 function ResetData( activityName ) --清除保存的数据
 	BackUpLuaData()
 	for k,v in pairs(g_DataService) do
		if type(k) == "string" and type(v) == "table" then
			if k == activityName then
				v = {}
				SaveLocalData()
				break
			end
		end
	end
 end


local function InitDataService()
	if g_DataService == nil then
		g_DataService = {}
		g_DataService.DataNum = 0
	end
	local cmdstr = "md "..LocalDataPath
	os.execute(cmdstr)
end

function SaveLocalData(  ) --保存并清空数据
	if g_DataService == nil then
		look("SaveLocalData  == nil")
	end
	for k,v in pairs(g_DataService) do
		if type(k) == "string" and type(v) == "table" then
			local savepath = LocalDataPath.."\\"..k..".ldb"
			SaveTable(savepath,v)
			--look("SaveLocalData  "..k)
			--g_DataService[k] = {}
		end
	end
	--look("SaveLocalData on local  "..g_DataService.DataNum)
	--g_DataService = nil
	--InitDataService()
end

function getFileList(  )
	local datapath = "dir/b "..LocalDataPath
	local sfile = io.popen(datapath)
	local fileLists = sfile:read("*all")
	local filenamelist = {}
	local filestart = 1
	while true do
		local xPos = string.find(fileLists,"%.ldb",filestart)
		local len = string.len(".ldb")
		if xPos ~= nil then
			local fileName = string.sub(fileLists, filestart,xPos + len -1 )
			--look("xPos "..xPos.." filestart "..filestart)
			fileName = string.gsub(fileName, "\n", "")
			--look(fileName)
			table.insert(filenamelist,fileName)
			filestart =  xPos + len
		else
			break
		end
	end
	return filenamelist
 end

  function BackUpLuaData(  )
 	local cmdstr = "md "..BackUpDatePath
	os.execute(cmdstr)
	cmdstr = "xcopy /y /s "..LocalDataPath.." "..BackUpDatePath
	--look(cmdstr)
	os.execute(cmdstr)
 end 


local function LoadLocalData(  )
	if g_DataService == nil then
		InitDataService()
	else 						--可能已经有数据在重读时先保存一次
		SaveLocalData()
	end

	if g_filenamelist == nil then
		g_filenamelist = {}
	end
	g_filenamelist = getFileList()
	for k,v in pairs(g_filenamelist) do
		local pathfile = LocalDataPath.."\\"..v
		local tabledata = LoadTable(pathfile)
		local activitylen = string.len(v) - string.len(".ldb") 
		local activityName = string.sub(v,1,activitylen)
		--look(" pathfile "..pathfile.."   "..activityName)
		if tabledata ~= nil then
			DataServiceSaveData(activityName,tabledata)
		end
	end
end

local function LoadLocalDataInConfig(  )
	if g_DataService == nil then
		InitDataService()
	else 						--可能已经有数据在重读时先保存一次
		SaveLocalData()
	end

	if g_ActivifyConfig == nil then
		return
	end

	local filenamelist = g_ActivifyConfig
	for k,v in pairs(filenamelist) do
		local pathfile = LocalDataPath.."\\"..v.ActivityName..".ldb"
		
		local tabledata = LoadTable(pathfile)
		local activityName = v.ActivityName
		--look(" pathfile "..pathfile.."   "..activityName)
		if tabledata ~= nil then
			DataServiceSaveData(activityName,tabledata)
		end
	end
end


LoadLocalData()
--LoadLocalDataInConfig()
--InitDataService()