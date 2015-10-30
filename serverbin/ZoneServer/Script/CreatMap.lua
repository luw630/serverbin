RegionTable =
{
	--{MapName = "���޷���1", 		Map = 1, Type = 0, Special = 0,},
	-- {MapName = "���޷���2", 	Map = 2,  Type = 0, Special = 0,},
	-- {MapName = "��԰�ܾ�", 	Map = 3,  Type = 0, Special = 0,},
	-- {MapName = "�츣ɽ", 	Map = 4,  Type = 0, Special = 0,},
	 {MapName = "������", 	Map = 5,  Type = 0, Special = 0,},
	-- {MapName = "�����ܾ�", 	Map = 100,  Type = 0, Special = 0,},
	-- {MapName = "��ĸ��", 	Map = 101, Type = 0, Special = 0,},
	-- {MapName = "¾�˹�", 	Map = 103,  Type = 0, Special = 0,},
	-- {MapName = "����", 	Map = 111,  Type = 0, Special = 0,},
	-- {MapName = "Ѫɫɭ��", 	Map = 113,  Type = 0, Special = 0,},
	-- {MapName = "�����ѷ�", 	Map = 114,  Type = 0, Special = 0,},
	-- {MapName = "ħ������", 	Map = 115,  Type = 0, Special = 0,},
	-- {MapName = "����", 	Map = 116,  Type = 0, Special = 0,},
	-- {MapName = "ͼ���", 	Map = 117,  Type = 0, Special = 0,},
	-- {MapName = "�ر���", 	Map = 118,  Type = 0, Special = 0,},
	-- {MapName = "����", 	Map = 119,  Type = 0, Special = 0,},
	-- {MapName = "������", 	Map = 120,  Type = 0, Special = 0,},
	-- {MapName = "�¹�ɭ��", 	Map = 121,  Type = 0, Special = 0,},
	-- {MapName = "������2", 	Map = 122,  Type = 0, Special = 0,},
	-- {MapName = "�¹�ɭ��", 	Map = 123,  Type = 0, Special = 0,},
	-- {MapName = "ħ������", 	Map = 124,  Type = 0, Special = 0,},
	-- {MapName = "PK����", 	Map = 125,  Type = 0, Special = 0,},
	-- {MapName = "����", 	Map = 1001,  Type = 0, Special = 0,},

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
			rfalse("װ�أ�"..RegionTable[i].MapName.."\t\tʧ��")
		else
			rfalse("װ�أ�"..RegionTable[i].MapName.."\t\t�ɹ�")
		end
	end
end

CreateMap()

function CheckMapSpecial(m)
	return MapSpecialTable[m] or 0
end
