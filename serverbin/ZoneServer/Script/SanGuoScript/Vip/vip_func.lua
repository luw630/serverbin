--[[
file:	vip_func.lua
author:	wk
update:	2015-02-09
desc:vip功能相关功能
]]--
local vip_conf=vip_conf

--取玩家数据
local function vip_getdata( sid )
	if dbMgr[sid]==nil or  dbMgr[sid].data==nil then 
		return
	end
	if dbMgr[sid].data['vip']==nil then --初始化vip功能数据
		dbMgr[sid].data['vip']={
			[1]=0,--玩家充值总额,目前赠送的经验值都放这里,[2]没用了
			[2]=0,--
			--[3]=0,--购买月卡到期时间,买了再初始化
		}
	end
	return dbMgr[sid].data['vip']
end
--首次登陆同步签到信息给前台
function vip_firstlogin(sid,dataTb,index)
	local pdata=vip_getdata( sid )	
	for i=1,3 do
		dataTb[index+i-1]=pdata[i] or 0
	end
	return index+3 --下个位置从8开始
end
--增加玩家经验值(给c调用,脚本调用 CI_AddGoods_SG(GoodsType.vipExp, 0, num, GoodsWay.recharge) 才能同步到前台  GoodsWay.giftVipexp赠送
function SI_vip_addexp(sid,value)
	local pdata=vip_getdata( sid )
	if pdata==nil then 
		return 
	end
	local oldlv=SI_vip_getlv(sid)
	
	pdata[1]=pdata[1]+value
	
	local nowlv=SI_vip_getlv(sid)
	
	if nowlv>oldlv then --升级了,vip升级需要做处理的都可以放这里
		CI_UpdateVIPLevel(sid, nowlv)
	end
	
	
 return pdata[1]
end
--取玩家vip等级
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

function LoginGetExpRequest(sid ) --从数据库中发送获取玩家VIP经验。当服务器宕机以后
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

--取各种vip功能数据,itype参照vip_conf配置表
function SI_vip_getDetail(sid,itype)
	local viplv=SI_vip_getlv(sid)
	if viplv==nil  then return end
	return vip_conf[viplv][itype]
end
--取购买具体功能需要数据,itype为功能类型 index为第几次,参见 buy_need_conf 配置表
function SI_getNeedvalue(sid,itype,index)
	if buy_need_conf[itype]==nil then 
		return
	end
	if buy_need_conf[itype][index]==nil then 
		return buy_need_conf[itype][#buy_need_conf[itype]]
	end
	return buy_need_conf[itype][index]
end
if  _DEBUG then   --测试
	function gm_setvip(lv)

		local sid=CI_GetPlayerDataSG(0,0)
		local pdata=vip_getdata( sid )
		local _exp=vip_conf[lv].needexp+1
		CI_AddGoods_SG(GoodsType.vipExp, 0, _exp, GoodsWay.recharge)
	end
end