
local OFFINECLEANDAY = 3
local m_offinePlayer = nil
local offinePath = tostring("dbTables\\Global\\OFFINEDATA.ldb")
local m_CleanUpStartTime = os.time()
function InitoffinePlayer(  )
	if m_offinePlayer == nil then
		m_offinePlayer = {}
	end
	LoadoffinePlayer()
end


function OnoffinePlayerOnline( PlayerSid ) 
	if m_offinePlayer ~= nil then
		if m_offinePlayer[PlayerSid] ~= nil then
			m_offinePlayer[PlayerSid]:Online()
			m_offinePlayer[PlayerSid] = nil
		end
	end
end


function SaveoffinePlayer(  )
	if m_offinePlayer ~= nil then
		SaveTable(offinePath,m_offinePlayer)
	end
end

function LoadoffinePlayer(  )
	if m_offinePlayer ~= nil then
		local offineData = LoadTable(offinePath)
		if offineData ~= nil then
			for k,v in pairs(offineData) do
				mOfPlayer = OffinePlayer:new()
				mOfPlayer:LoadData(v)
				AddoffinePlayer(mOfPlayer)
			end
		end
	end
end

function UpdateQuestResult( PlayerQuest,offineresult )
	assert(#offineresult <= #PlayerQuest)
	for i=1,#offineresult do
		if offineresult[i][1] == PlayerQuest[i][1] and offineresult[i][1] > 0 then
			PlayerQuest[i][2] = offineresult[i][2] 
		end
	end
end


function AddoffinePlayer( offinePlayer )
	if offinePlayer ~= nil then
		m_offinePlayer[offinePlayer.sid] = offinePlayer
		SaveoffinePlayer()
	end
end

function GetoffinePlayerBysid(sid)
	if m_offinePlayer ~= nil then
		if m_offinePlayer[sid] ~= nil then
			return m_offinePlayer[sid]
		end
	end
	return nil
end

function GetoffinePlayerByname(playername)
	if m_offinePlayer ~= nil then
		for k,v in pairs(m_offinePlayer) do
			if v.PlayerName == playername then
				return v
			end
		end
	end
	return nil
end

function CheckClearup(  )
	local ntime = os.time()
	local nowday =  tonumber(os.date("%Y%m%d",ntime))	
	local Startday = tonumber(os.date("%Y%m%d",m_CleanUpStartTime))
	local StartTime = tonumber(os.date("*t",ntime))
	if nowday - Startday >= OFFINECLEANDAY then
		if StartTime.hour >= FactionSceneResetTime then
			ClearupOfflinePlayerData()
			ClearupQuestList()
			m_CleanUpStartTime = os.time()
			look("ClearupOfflinePlayerData ")
		end
	end
	CleanActiveValue()
end

function ClearupOfflinePlayerData( )
	for k,v in pairs(m_offinePlayer) do
		v = nil
	end
	m_offinePlayer = nil
	local offinefile = io.open(offinePath,"w+")
	if offinefile ~= nil then
		io.close(offinefile)
	end
	m_offinePlayer = {}
end



InitoffinePlayer()
