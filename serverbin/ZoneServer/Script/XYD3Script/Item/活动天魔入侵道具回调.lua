monstertab = {}
monstertab[1] = {objectType = 0,monsterId = 329,refreshTime = 0} --����
monstertab[1].regionId = 2
monstertab[1].x = 287
monstertab[1].y = 1127

monstertab[2] = {objectType = 0,monsterId = 330,refreshTime = 0} --��Ծ��
monstertab[2].regionId = 4
monstertab[2].x = 923
monstertab[2].y = 718

monstertab[3] = {objectType = 0,monsterId = 331,refreshTime = 0} --��Ȫ1
monstertab[3].regionId = 4
monstertab[3].x = 1384
monstertab[3].y = 1120

monstertab[4] = {objectType = 0,monsterId = 328,refreshTime = 0} --��С��1
monstertab[4].regionId = 2
monstertab[4].x = 1025
monstertab[4].y = 1093

monstertab[5] = {objectType = 0,monsterId = 333,refreshTime = 0} --���1
monstertab[5].regionId = 5
monstertab[5].x = 899
monstertab[5].y = 572

monstertab[6] = {objectType = 0,monsterId = 331,refreshTime = 0} --��Ȫ2
monstertab[6].regionId = 4
monstertab[6].x = 1334
monstertab[6].y = 1110

monstertab[7] = {objectType = 0,monsterId = 328,refreshTime = 0} --��С��2
monstertab[7].regionId = 2
monstertab[7].x = 1068
monstertab[7].y = 1107

monstertab[8] = {objectType = 0,monsterId = 333,refreshTime = 0} --���2
monstertab[8].regionId = 5
monstertab[8].x = 847
monstertab[8].y = 511


monstertab[9] = {objectType = 0,monsterId = 331,refreshTime = 0} --��Ȫ3
monstertab[9].regionId = 4
monstertab[9].x = 1427
monstertab[9].y = 1110

monstertab[10] = {objectType = 0,monsterId = 328,refreshTime = 0} --��С��3
monstertab[10].regionId = 2
monstertab[10].x = 973
monstertab[10].y = 1087

monstertab[11] = {objectType = 0,monsterId = 333,refreshTime = 0} --���3
monstertab[11].regionId = 5
monstertab[11].x = 972
monstertab[11].y = 544

--[[
function OnUseItem8011001(ItemID)
	--rfalse("�سǵ��߽����˺���")
	local pRegionID, pX, pY = GetPlayerMapInfo()
	monstertab[1].regionId = pRegionID
	monstertab[1].x = pX
	monstertab[1].y = pY
	CreateObjectIndirect(monstertab[1])
	--PutPlayerTo(1,400,400,0,0)

	--SendBoardCastMsg("�Ѿ�ִ���˺���")
	return 1
end
--]]

function OnUseItem8002026(ItemID)  --�ˢ��������ʹ��
	if ItemID == 8002026 then
		CreateObjectIndirect(monstertab[1])
	elseif	ItemID == 8002027 then
		CreateObjectIndirect(monstertab[2])
	elseif	ItemID == 8002028 then
		CreateObjectIndirect(monstertab[3])
	elseif	ItemID == 8002029 then
		CreateObjectIndirect(monstertab[4])
	elseif	ItemID == 8002030 then
		CreateObjectIndirect(monstertab[5])
	elseif	ItemID == 8002031 then
		CreateObjectIndirect(monstertab[6])
	elseif	ItemID == 8002032 then
		CreateObjectIndirect(monstertab[7])
	elseif	ItemID == 8002033 then
		CreateObjectIndirect(monstertab[8])
	elseif	ItemID == 8002034 then
		CreateObjectIndirect(monstertab[9])
	elseif	ItemID == 8002035 then
		CreateObjectIndirect(monstertab[10])
	elseif	ItemID == 8002036 then
		CreateObjectIndirect(monstertab[11])
	end

	return 1
end

