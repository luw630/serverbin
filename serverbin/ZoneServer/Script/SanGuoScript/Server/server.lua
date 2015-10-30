--[[
file:	server.lua
author:	wk
update:	2015-08-20
desc:服务器层操作相关,如开服,关服,世界数据存取
		需要开服,操作的函数往OnServerStart里面放,关服类似
]]--


G_WorldData=G_WorldData or {}
local WorldDataPath = tostring("dbTables\\WorldData.ldb")

--------------------------------------世界数据相关---------------------------------------------------------------
--------------------------------------世界数据相关---------------------------------------------------------------
--取世界数据,数据会自动保存
function GetWorldData()
	return G_WorldData
end

--开服加载世界数据
function LoadWorldData()
	G_WorldData = LoadTable(WorldDataPath) or {}
end

--关服保存世界数据,每小时也保存一次
function SaveWorldData()
	SaveTable(WorldDataPath,G_WorldData)
end



--------------------------------------服务器定时器回调---------------------------------------------------------------
--------------------------------------服务器定时器回调---------------------------------------------------------------
--每10分钟回调
function SI_EachTenMinutes()

end
--每1分钟回调
function SI_EachOneMinute()
	ActivityEnableCheck()
end
--每小时回调
function SI_EveryHouer()
	SaveWorldData() --每小时保存世界数据
	CheckClearup()  --凌晨5点清除军团部分数据
end

--每日20点回调
function SI_EveryDay_20()
	war_fight_start() --国战开启
end

--每日24点回调
function SI_EveryDay_24()
	db_saveStayData()	--保存今日在线玩家,留存数据使用
	db_lvlog()	--保存玩家等级数据个数
	ResetChargeSumData() --重置累计充值数据 
end


-----------------------------------服务器开服,关服回调------------------------------------------------------------------
-----------------------------------服务器开服,关服回调------------------------------------------------------------------
--服务器开启调用函数
function  OnServerStart()
	LoadWorldData() --开服加载世界数据
end

--服务器关闭调用函数
function OnServerDown()
	SaveWorldData()--关服保存世界数据
	BackUpLuaData()--备份一次本地数据
end

