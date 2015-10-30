OffinePlayer = 
{
}

function OffinePlayer:new (o) 
	 o = o or {} 
	 setmetatable(o, self) 
	 self.__index = self 
	 return o 
end 

function OffinePlayer:Init(sid,dataname)
	look("OffinePlayer Init"..sid)
	self.sid = sid
	self.PlayerName = GetPlayerDataSG(sid,4)
	self.Level = GetPlayerDataSG(sid,3) 
	self.wFightPower = GetPlayerDataSG(sid,8)	
	self.wHeadIcon = GetPlayerDataSG(sid,9)
	self.dataname = dataname
	self.data = {}	
	self.dataInit = 0
	self.Inittime = os.time()
	self:GetDataFromdbMgr()
end

function OffinePlayer:GetDataFromdbMgr()
	local sid = self.sid
	local dataname = self.dataname
	if dbMgr[sid]==nil or dbMgr[sid].data == nil  then 
		look("GetDataFromdbMgr : dbMgr["..sid.."]==nil sid = "..sid)
		return 0
	end

	if dbMgr[sid].data[dataname] ~= nil then
		for k,v in pairs(dbMgr[sid].data[dataname]) do
			if k ~= "" then
				self.data[k] = v
			end
		end
		self.dataInit = 1
		--printtable(self.data)
		look("GetDataFromdbMgr Over")
	end
end

function OffinePlayer:Online()
	local sid = self.sid
	local dataname = self.dataname
	if dbMgr[sid]==nil or dbMgr[sid].data[dataname] == nil  then 
		look("GetDataFromdbMgr : dbMgr["..sid.."]==nil sid = "..sid)
		return 0
	end

	for k,v in pairs(self.data) do
		dbMgr[sid].data[dataname][k] = v
	end
end

function OffinePlayer:LoadData(data)
	--look("LoadData Init"..data.sid)
	self.sid = data.sid
	self.PlayerName = data.PlayerName
	self.Level = data.Level
	self.wFightPower = 	data.wFightPower
	self.wHeadIcon = data.wHeadIcon
	self.dataname = data.dataname
	self.data = data.data 	
	self.dataInit = data.dataInit 
	self.Inittime = data.Inittime
	--look(self.data)
end


function OffinePlayer:UpdataFactionQuset(FactionID,JoinID,bAgree)
	local bupdata = 0
	if self.dataInit > 0 and self.data ~= nil then
		for i,v in ipairs(self.data) do
			if v[1] == FactionID then
				v[2] = bAgree
				bupdata = 1
				break
			end
		end

		if bupdata == 0 then
			for i,v in ipairs(self.data) do
				if v[1] == 0 then
					v[1] = FactionID
					v[2] = bAgree
					break
				end
			end
		end
	end
end



function OffinePlayer:GetData()
	if self.dataInit > 0 and self.data ~= nil  then
		return self.data
	end
	return nil
end