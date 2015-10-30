-- ========================
-- 怪物喊话说明
-- 1 当怪物出生将调用一次函数
		-- OnMonsterBirth+怪物ID
	-- SendBoardCastMsg可以发送全服通告
	-- GetMonsterData(3)获取怪物名称
	-- getattackername()获取杀死怪物的玩家名称
	-- 字符串连接可以用..来连接，可以参照下面的例子
-- 2  当怪物死亡将调用一次函数
		-- OnMonsterDie+怪物ID
	-- 用法同上
	-- 根据需要的怪物自行配置,需要更多脚本函数可以参考服务器Script/functionlist.ini
-- ========================
--[[
function OnMonsterBirth329(monsterid)
	local i = 0
	while i < 3 do
		local myname=GetMonsterData(3);
		SendBoardCastMsg("我是江湖百恶榜上排名第一百位的屠夫"..myname.."，有谁想来尝尝我的剥皮剔骨三刀！！")
		--rfalse("我是"..myname.."来弄我嘛")
		i = i + 1
	end
end

function OnMonsterDie329(monsterid)
	local i = 0
	while i < 3 do
		local monstername=GetMonsterData(3);
		local attatkername=getattackername();
		SendBoardCastMsg("江湖百恶榜上排名第一百位的屠夫"..monstername.."被武功卓绝的"..attatkername.."打得落荒而逃，所携带的宝物落一地！");
		i = i + 1
	end
end

---------------------------------

function OnMonsterBirth330(monsterid)
	local i = 0
	while i < 3 do
		local myname=GetMonsterData(3);
		SendBoardCastMsg("我是江湖百恶榜上排名第九十九位的明玉一点香"..myname.."，你们这些江湖晚辈敢来见识下我的落地十八摸不！！")
		--rfalse("我是"..myname.."来弄我嘛")
		i = i + 1
	end
end

function OnMonsterDie330(monsterid)
	local i = 0
	while i < 3 do
		local monstername=GetMonsterData(3);
		local attatkername=getattackername();
		SendBoardCastMsg("江湖百恶榜上排名第九十九位的明玉一点香"..monstername.."被武功卓绝的"..attatkername.."打得落荒而逃，所携带的宝物落一地！");
		i = i + 1
	end
end



---------------------
function OnMonsterBirth331(monsterid)
	local i = 0
	while i < 3 do
		local myname=GetMonsterData(3);
		SendBoardCastMsg("老夫是江湖百恶榜上排名第九十八位的百邪先生"..myname.."，老夫的清风九式天下无敌！！")
		--rfalse("我是"..myname.."来弄我嘛")
		i = i + 1
	end
end

function OnMonsterDie331(monsterid)
	local i = 0
	while i < 3 do
		local monstername=GetMonsterData(3);
		local attatkername=getattackername();
		SendBoardCastMsg("江湖百恶榜上排名第九十八位的百邪先生"..monstername.."被武功卓绝的"..attatkername.."打得落荒而逃，所携带的宝物落一地！");
		i = i + 1
	end
end

-------------------------------

function OnMonsterBirth328(monsterid)
	local i = 0
	while i < 3 do
		local myname=GetMonsterData(3);
		SendBoardCastMsg("老夫是江湖百恶榜上排名第九十七位的黑面郎君"..myname.."，当年老夫的百裂笔横扫整个江湖，如今有谁敢来挑战！！")
		--rfalse("我是"..myname.."来弄我嘛")
		i = i + 1
	end
end

function OnMonsterDie328(monsterid)
	local i = 0
	while i < 3 do
		local monstername=GetMonsterData(3);
		local attatkername=getattackername();
		SendBoardCastMsg("江湖百恶榜上排名第九十七位的黑面郎君"..monstername.."被武功卓绝的"..attatkername.."打得落荒而逃，所携带的宝物落一地！");
		i = i + 1
	end
end


-----------------------------

function OnMonsterBirth333(monsterid)
	local i = 0
	while i < 3 do
		local myname=GetMonsterData(3);
		SendBoardCastMsg("老夫是江湖百恶榜上排名第九十六位的碧月莲"..myname.."，让你们这些江湖晚辈们看看我的碧莲穿心手！！")
		--rfalse("我是"..myname.."来弄我嘛")
		i = i + 1
	end
end

function OnMonsterDie333(monsterid)
	local i = 0
	while i < 3 do
		local monstername=GetMonsterData(3);
		local attatkername=getattackername();
		SendBoardCastMsg("江湖百恶榜上排名第九十六位的碧月莲"..monstername.."被武功卓绝的"..attatkername.."打得落荒而逃，所携带的宝物落一地！");
		i = i + 1
	end
end
--]]