function OnUseItem4032001(ItemID)  --���ʳɳ�����ʹ��
	local tempvalue = math.random(1,10000)--���������
	if tempvalue <= 3000 then--��������С�ڻ��ߵ���3000ʱ��������Ԫ�������������ĵ�ҩ��
		if ItemID == 4032001 then
			GiveGoods(4030001,1)
		elseif ItemID == 4032002 then
			GiveGoods(4030002,1)
		elseif ItemID == 4032003 then
			GiveGoods(4030003,1)
		elseif ItemID == 4032004 then
			GiveGoods(4030004,1)
		elseif ItemID == 4032005 then
			GiveGoods(4030005,1)
		elseif ItemID == 4032006 then
			GiveGoods(4030006,1)
		elseif ItemID == 4032007 then
			GiveGoods(4030007,1)
		elseif ItemID == 4032008 then
			GiveGoods(4030008,1)
		elseif ItemID == 4032009 then
			GiveGoods(4030009,1)
		elseif ItemID == 4032010 then
			GiveGoods(4030010,1)
		end
	else
		GiveGoods(4033021,1)
	end
	return 1
end


