DynamicRegion = {}

dofile("XYD3Script\\DynamicRegion\\DynamicRegionCfg.lua")

-- ������̬��ͼ�ĺ���
function LuaCreateDynamicRegion(regionID)
	local dyconf = DynamicRegion[regionID]
	if (nil == dyconf) then
		rfalse("DynamicRegion nil")
		return
	end

	local mapx = CreateRegion(regionID, dyconf.MapID, 0, 0, 0, 0)
	if (nil == mapx) then
		return
	end

	-- ��������
	if type({}) == type (dyconf.Monster) then
		for k, mCreate in pairs(dyconf.Monster) do
			mCreate.regionId = mapx
			CreateObjectIndirect(mCreate)
			--rfalse("create monster")
		end
	end

	return mapx
end

-- ������̬��ͼ���ҽ���ҷ���
function PutPlayerToDynamicRegion(regionID, x, y,id)
	local dmGID = LuaCreateDynamicRegion(regionID)
	if dmGID == nil then
		rfalse("LuaCreateDynamicRegion nil")
		return
	end
	PutPlayerTo(0, x, y, dmGID,id)
	return 1
end

function OnDRAllMonsterDead(regionGID, index)
	local dyconf = DynamicRegion[index]

	if (nil == dyconf.RtPoint) then
		PutPlayerFromDynamic(true, regionGID)
	else
		PutPlayerFromDynamic(false, regionGID, dyconf.RtPoint.RegionID, dyconf.RtPoint.X, dyconf.RtPoint.Y)
	end
end