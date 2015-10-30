--[[
file:	DessertLogic.lua
author:	Jonson
update:	2015-04-23
desc:������С�ͽ����ķ����߼�����
]]--

local configInfor = DessertConfig

--ȡ��С�ͽ���������������
local function Dessert_getdata( sid )
	if dbMgr[sid]==nil or  dbMgr[sid].data==nil then 
		return
	end
	if dbMgr[sid].data['dessert_count'] == nil then --��ʼ��С�ͽ�����lua������
		dbMgr[sid].data['dessert_count'] = {
			[1] = 0,--Ĭ��ÿ���Ѿ���ȡС�ͽ����Ĵ���Ϊ0
			[2] = false,--�Ƿ��н���������ȡ
			[3] = 0,--����ȡ�Ľ��������ͣ�1�����Ǯ��2����ʯ
			[4] = 0,--�����Ķ����ĸ���
		}
	end
	return dbMgr[sid].data['dessert_count']
end

--�ж��Ƿ���Է��Ž�����ֻ���жϿ��Է��Ž����ˣ��Ÿ�C++����
function SI_DispachDessert(sid)
	--��ȡ��ҵ�С����Ѿ���ȡ�Ĵ���
	local pdata = Dessert_getdata( sid )
	if pdata == nil or pdata[1] >= configInfor.CountLimitted then
		CI_DessertDispachInfor(false, 0, 0) --�����Ѿ���ȡ���ˣ������ٴ���ȡ������
		return
	end
	
	--�״ν����Ǳص����ҵĴ���
	local newbieGoldGained = get_Exdata(sid, SG_ExDataType.NewbieGoldFlag)
	if newbieGoldGained == nil or newbieGoldGained == 0 then
		pdata[2] = true
		pdata[3] = 1--�˴�������ֵ�Ǹ�DessertConfig�ϸ���ϵ�
		pdata[4] = 10000--�������
		set_Exdata(sid, SG_ExDataType.NewbieGoldFlag, 1)
		--֪ͨ�ͻ��ˣ�������ȡ����
		CI_DessertDispachInfor(true, pdata[3], pdata[4])
		return
	end

	pdata[2] = false
	pdata[3] = 0
	pdata[4] = 0
	--�������õļ�����������������ͣ������ĸ���
	local randomValue = math.random(100)
	local weightAll = 0
	local probabilityInfor = configInfor.probability
	for i, v in ipairs(probabilityInfor) do
		weightAll = weightAll + v
		if randomValue <= weightAll then
			--�������Ҫ����������
			--���������Ҫ�����ĸ���
			local specifyConfigInfor = configInfor[i]
			local dessertUnitWeight = specifyConfigInfor.unitWeight
			local numRandomValue = math.random(100)--��������ٸ������������
			local numWeightAll = 0
			
			for subIndex, subValue in ipairs(dessertUnitWeight) do
				numWeightAll = numWeightAll + subValue
				if numRandomValue <= numWeightAll then
					pdata[2] = true
					pdata[3] = i--�˴�������ֵ�Ǹ�DessertConfig�ϸ���ϵ�
					pdata[4] = specifyConfigInfor.nums[subIndex]--��ȡҪ�������ĸ���
					--֪ͨ�ͻ��ˣ�������ȡ����
					CI_DessertDispachInfor(pdata[2], pdata[3], pdata[4])
					return
				end
			end
			return
		end
	end
end

--��ȡС���
function SI_ClaimDessert(sid)
	--��ȡ��ҵ�С����Ѿ���ȡ�Ĵ���
	local pdata = Dessert_getdata( sid )
	if pdata == nil then
		return
	end
	
	--�鿴�Ƿ��н���������ȡ�����жϽ��յ���ȡ�����Ƿ��Ѿ��ﵽ���ֵ
	if pdata[2] == false and pdata[1] >= configInfor.CountLimitted then
		return
	end
	
	--���÷������ṩ�Ľӿ�����Ǯ��dessertType��CI_AddGoods_SG�����Ľӿ��У�GoodsType��ǰһ�����Ƕ�Ӧ��
	CI_AddGoods_SG(pdata[3], 0, pdata[4], GoodsWay.mainCityActive)
	pdata[1] = pdata[1] + 1
end

--����С����Ѿ���ȡ�Ĵ���
function SI_ResetDesserBakedCount( sid )
	--��ȡ��ҵ�С����Ѿ���ȡ�Ĵ���
	local pdata = Dessert_getdata( sid )
	if pdata == nil then
		return
	end
	
	pdata[1] = 0--��ÿ���Ѿ���ȡС�ͽ����Ĵ�����Ϊ0
end