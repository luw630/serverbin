--[[
file:	rank_func.lua
author:	wk
update:	2015-08-21
desc:排行榜
]]--


local maxRankNum=30 --排行榜最大条数
local tablepush,tablelocate,tablesort = table.push,table.locate,table.sort
local rankLvLimt=14 --上榜最低等级
--取排行榜数据 1 名将榜,2 阵容榜, 3 总星榜,4 等级榜, 5 过关斩将榜, 6 武将总数, 7 金币富豪榜
local  function rank_getdata()
	local worldData=GetWorldData()
	if worldData["rank"]==nil then 
		worldData["rank"]={
			--[[
				[1]={{排行数值,sid,等级,头像,名字,帮会名,heroID,heroStar,heroStep,heroLv},{},} --50个,1为名将榜,多5个参数,武将id 武将星级 武将品阶 武将等级,其他的没有
				[2]={{排行数值,sid,等级,头像,名字,帮会名},{},} --50个   
			]]
		
		}
	end
	--look(worldData["rank"])
	return worldData["rank"]
	
end

--inner function:

local function _cmp_score(a, b)
	if type(a) ~= type({}) or a[1] == nil then return false end
	if type(b) ~= type({}) or b[1] == nil then return true end
	return a[1] > b[1]
end
-- 通用插入操作函数,传入列表t
-- 注意：必须满足 [val] 是用来排序的 [sid] 是用来匹配的
local function insert_list(t,num,val,sid,heroID,heroStar,heroStep,heroLv)
	if type(t) ~= type({}) or type(num) ~= type(0) then 
		return
	end
	if num > 200 then  				-- 排行榜不能超过200条数据
		return 
	end
	
	--如果不上榜直接退出,节约性能

	if  t[num]~=nil and val < t[num][1] then
		return
	end

	local lv=CI_GetPlayerDataSG(0,AttType.lv)
	local icon=CI_GetPlayerDataSG(0,AttType.iconId)
	--local vipLv=SI_vip_getlv(sid)
	local name=CI_GetPlayerDataSG(0,AttType.name)
	local factionName=GetPlayerFactionName(CI_GetPlayerDataSG(0,AttType.factionId))

	
	local inst = true
	for k, v in ipairs(t) do
		if type(v) == type({}) then
			if v[2] == sid then	
				if  val>v[1]  then --值变大才处理
					v[1] = val
					v[2] = sid
					v[3] = lv
					v[4] = icon
					v[5] = name
					v[6] = factionName
					v[7] = heroID
					v[8] = heroStar
					v[9] = heroStep
					v[10] = heroLv
				end
				inst = false
			end
		end
	end
	if inst then
		local pos = num
		if #t < num  then
			pos = #t + 1
		end	
		-- 如果每次传入的值都正确、那么这样覆盖肯定不会有问题(可以防止不断生成临时表)
		if t[pos] == nil then
			t[pos] = {val,sid,lv,icon,name,factionName,heroID,heroStar,heroStep,heroLv}
		else
			if val > t[pos][1] then
				t[pos][1] = val
				t[pos][2] = sid
				t[pos][3] = lv
				t[pos][4] = icon
				t[pos][5] =name
				t[pos][6] =factionName
				t[pos][7] = heroID
				t[pos][8] = heroStar
				t[pos][9] = heroStep
				t[pos][10] = heroLv
			end
		end
	end
	tablesort(t,_cmp_score)
end

--更新排行榜,val为现在的值;itype=1 名将榜,2 阵容榜, 3 总星榜,4 等级榜, 5 过关斩将榜, 6 武将总数, 7 金币富豪榜.   名将榜有后4个参数,其他没有
function rank_update(sid,itype,val,heroID,heroStar,heroStep,heroLv)
	 look("rank_update")
	-- look(sid)
	-- look(itype)
	-- look(val)
	-- look(heroID)
	-- look(heroStar)
	-- look(heroStep)
	-- look(heroLv)
	-- look("rank_update--------end")
	if CI_GetPlayerDataSG(0,AttType.lv)<rankLvLimt then
		return
	end
	
	local rdata=rank_getdata()
	rdata[itype] = rdata[itype] or {}
	if itype ~=1 then
		insert_list(rdata[itype],maxRankNum,val,sid)
	else
		insert_list(rdata[itype],maxRankNum,val,sid,heroID,heroStar,heroStep,heroLv)
	end
end

--获取排行榜信息
function rank_getList(itype)
	look("rank_getList")
	--look(itype)
	local rdata=rank_getdata()
	-- rdata[1]=nil
	-- rdata[2]=nil
	-- rdata[3]=nil
	-- rdata[4]=nil
	-- rdata[5]=nil
	-- rdata[6]=nil
	
	--rdata[itype]=rdata[itype] or {}
	--look(rdata[4])
	
	CI_RankMsg(itype,rdata[itype])
end
	--rank_update()
  -- rank_getList(1)


