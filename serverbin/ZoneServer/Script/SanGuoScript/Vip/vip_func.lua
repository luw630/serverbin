--[[
file:	vip_func.lua
author:	wk
update:	2015-02-09
desc:vip������ع���
]]--
local vip_conf=vip_conf

--ȡ�������
local function vip_getdata( sid )
	if dbMgr[sid]==nil or  dbMgr[sid].data==nil then 
		return
	end
	if dbMgr[sid].data['vip']==nil then --��ʼ��vip��������
		dbMgr[sid].data['vip']={
			[1]=0,--��ҳ�ֵ�ܶ�,Ŀǰ���͵ľ���ֵ��������,[2]û����
			[2]=0,--
			--[3]=0,--�����¿�����ʱ��,�����ٳ�ʼ��
		}
	end
	return dbMgr[sid].data['vip']
end
--�״ε�½ͬ��ǩ����Ϣ��ǰ̨
function vip_firstlogin(sid,dataTb,index)
	local pdata=vip_getdata( sid )	
	for i=1,3 do
		dataTb[index+i-1]=pdata[i] or 0
	end
	return index+3 --�¸�λ�ô�8��ʼ
end
--������Ҿ���ֵ(��c����,�ű����� CI_AddGoods_SG(GoodsType.vipExp, 0, num, GoodsWay.recharge) ����ͬ����ǰ̨  GoodsWay.giftVipexp����
function SI_vip_addexp(sid,value)
	local pdata=vip_getdata( sid )
	if pdata==nil then 
		return 
	end
	local oldlv=SI_vip_getlv(sid)
	
	pdata[1]=pdata[1]+value
	
	local nowlv=SI_vip_getlv(sid)
	
	if nowlv>oldlv then --������,vip������Ҫ������Ķ����Է�����
		CI_UpdateVIPLevel(sid, nowlv)
	end
	
	
 return pdata[1]
end
--ȡ���vip�ȼ�
function SI_vip_getlv(sid)
	local pdata=vip_getdata( sid )
	if pdata==nil then 
		return 0
	end
	local vipexp=pdata[1]+pdata[2]
	for i=1,vip_conf.maxlv do
		if vipexp<vip_conf[i].needexp then 
			return i-1
		end
	end
	if vipexp>=vip_conf[vip_conf.maxlv].needexp then 
		return vip_conf.maxlv
	end
end

function LoginGetExpRequest(sid ) --�����ݿ��з��ͻ�ȡ���VIP���顣��������崻��Ժ�
	GetVipExpFromDB(sid)
end

function ReceviVipExp( result )

	if result ~= nil then
		local maxexp = 0
		local sid = 0
		local pdata
		for k,v in pairs(result) do
			if type(v) == "table" then
				if type(v[1]) == "number" and type(v[2]) == "number" then
					sid = v[2]
					break
				end
			end
		end
		pdata=vip_getdata( sid )
		if pdata==nil then 
			look("pdata==nil")
			return 
		end
		look(pdata)
		
		for k,v in pairs(result) do
			if type(v) == "table" then
				if type(v[1]) == "number" and type(v[2]) == "number" then
					if pdata[1] < v[1] then
						pdata[1] = v[1]
					end
				end
			end
		end
		
		local levle = SI_vip_getlv(sid)
		CI_UpdateVIPLevel(sid, levle)
		look("CI_UpdateVIPLevel "..levle)
		return
	end
end

--ȡ����vip��������,itype����vip_conf���ñ�
function SI_vip_getDetail(sid,itype)
	local viplv=SI_vip_getlv(sid)
	if viplv==nil  then return end
	return vip_conf[viplv][itype]
end
--ȡ������幦����Ҫ����,itypeΪ�������� indexΪ�ڼ���,�μ� buy_need_conf ���ñ�
function SI_getNeedvalue(sid,itype,index)
	if buy_need_conf[itype]==nil then 
		return
	end
	if buy_need_conf[itype][index]==nil then 
		return buy_need_conf[itype][#buy_need_conf[itype]]
	end
	return buy_need_conf[itype][index]
end
if  _DEBUG then   --����
	function gm_setvip(lv)

		local sid=CI_GetPlayerDataSG(0,0)
		local pdata=vip_getdata( sid )
		local _exp=vip_conf[lv].needexp+1
		CI_AddGoods_SG(GoodsType.vipExp, 0, _exp, GoodsWay.recharge)
	end
end