--[[
file:	GameSysSwitch.lua
author:	Luwei,lpd
update:	2015-09-2
desc:游戏系统功能开关
]]--

--[[
moudel_type = --模块类型
{
	act_moudel = 1,
	skill_moudel = 2,
	mall_moudel = 3,
}
]]--

system_switch =
{
	--[moudel_type.act_moudel] = { --活动模块
	act_moudel = { --活动模块
		bless_act = true --祈福活动开启标记
	},
	--[moudel_type.skill_moudel] = { --技能模块
	skill_moudel = { --技能模块
		BuyPointLimit = 0 --购买技能点次数限制标记 0:不限制 1:限制
	},
	--[moudel_type.mall_moudel] = { --商店模块
	mall_moudel = { --商店模块
		Miracle_OpenLimit = 1, --花费元宝开启奇缘商人标记 0:不限制 1:限制
		Gem_OpenLimit = 1, --花费元宝开启珍宝商人标记 0:不限制 1:限制
	}
	--其他模块可自行设计开关table结构
}

--获取模块限制细节
function Get_MoudelLimitDetail(moudel, part)
	look(moudel.." "..part)
	if system_switch[moudel] == nil then
		return 0
	end
	return system_switch[moudel][part]
end