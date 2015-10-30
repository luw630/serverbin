RegionTable =
{
	--{MapName = "神兽废墟1", 		Map = 1, Type = 0, Special = 0,},
	-- {MapName = "神兽废墟2", 	Map = 2,  Type = 0, Special = 0,},
	-- {MapName = "桃园密境", 	Map = 3,  Type = 0, Special = 0,},
	-- {MapName = "天福山", 	Map = 4,  Type = 0, Special = 0,},
	 {MapName = "主城三", 	Map = 5,  Type = 0, Special = 0,},
	-- {MapName = "九幽密境", 	Map = 100,  Type = 0, Special = 0,},
	-- {MapName = "鬼母殿", 	Map = 101, Type = 0, Special = 0,},
	-- {MapName = "戮人谷", 	Map = 103,  Type = 0, Special = 0,},
	-- {MapName = "宫殿", 	Map = 111,  Type = 0, Special = 0,},
	-- {MapName = "血色森林", 	Map = 113,  Type = 0, Special = 0,},
	-- {MapName = "熔岩裂缝", 	Map = 114,  Type = 0, Special = 0,},
	-- {MapName = "魔王餐厅", 	Map = 115,  Type = 0, Special = 0,},
	-- {MapName = "地牢", 	Map = 116,  Type = 0, Special = 0,},
	-- {MapName = "图书馆", 	Map = 117,  Type = 0, Special = 0,},
	-- {MapName = "藏宝室", 	Map = 118,  Type = 0, Special = 0,},
	-- {MapName = "钟塔", 	Map = 119,  Type = 0, Special = 0,},
	-- {MapName = "炼金室", 	Map = 120,  Type = 0, Special = 0,},
	-- {MapName = "月光森林", 	Map = 121,  Type = 0, Special = 0,},
	-- {MapName = "竞技场2", 	Map = 122,  Type = 0, Special = 0,},
	-- {MapName = "月光森林", 	Map = 123,  Type = 0, Special = 0,},
	-- {MapName = "魔王宫殿", 	Map = 124,  Type = 0, Special = 0,},
	-- {MapName = "PK测试", 	Map = 125,  Type = 0, Special = 0,},
	-- {MapName = "测试", 	Map = 1001,  Type = 0, Special = 0,},

}

MapSpecialTable = {}

function CreateMap()
	MapSpecialTable = {}
	for i = 1,#RegionTable do
		ck = CreateRegion( { staticId = RegionTable[i].Map,zoneId = RegionTable[i].Zoneid,type = RegionTable[i].Type} )
		MakeNewTrap(RegionTable[i].Map, 255)
		if ( RegionTable[i].Special == 1 ) then
			MapSpecialTable[ RegionTable[i].Map ] = 1
		end
		if( ck == nil )then
			rfalse("装载："..RegionTable[i].MapName.."\t\t失败")
		else
			rfalse("装载："..RegionTable[i].MapName.."\t\t成功")
		end
	end
end

CreateMap()

function CheckMapSpecial(m)
	return MapSpecialTable[m] or 0
end
