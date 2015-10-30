--升级心法计算公式
--混元气功 一阳正气  洗髓经

--[[
ConsumeTelergy(SP, money, 1) 函数说明

第一个参数：消耗的真气
第二个参数： 消耗的金钱
第三个参数： 表示跟新的类型，1 表示心法，2 表示技能
--]]
function UpdateTelergy6000(TLevel)
	local SP	= TLevel * 100
	local money	= 120 * TLevel
	ConsumeTelergy(SP, money, 1)
end

function UpdateTelergy6001(TLevel)
	local SP	= TLevel * 100
	local money	= 120 * TLevel
	ConsumeTelergy(SP, money, 1)
end

function UpdateTelergy6002(TLevel)
	local SP	= TLevel * 100
	local money	= 120 * TLevel
	ConsumeTelergy(SP, money, 1)
end

--玄元功、太玄神功
function UpdateTelergy6003(TLevel)
	local SP	= 123 * 1.045^(TLevel - 1)
	local money	= 110 * TLevel
	ConsumeTelergy(SP, money, 1)
end

function UpdateTelergy6004(TLevel)
	local SP	= 123 * 1.045^(TLevel - 1)
	local money	= 110 * TLevel
	ConsumeTelergy(SP, money, 1)
end

--八步、须弥
function UpdateTelergy6005(TLevel)
	local SP	= TLevel * 100
	local money	= 120 * TLevel
	ConsumeTelergy(SP, money, 1)
end

function UpdateTelergy6006(TLevel)
	local SP	= TLevel * 100
	local money	= 120 * TLevel
	ConsumeTelergy(SP, money, 1)
end

--集月神功
function UpdateTelergy6007(TLevel)
	local SP	= TLevel * 100
	local money	= 120 * TLevel
	ConsumeTelergy(SP, money, 1)
end

--无色无相、李代桃僵
function UpdateTelergy6008(TLevel)
	local SP	= 110 * 1.045^(TLevel - 1)
	local money	= 120 * TLevel
	ConsumeTelergy(SP, money, 1)
end

function UpdateTelergy6009(TLevel)
	local SP	= 110 * 1.045^(TLevel - 1)
	local money	= 120 * TLevel
	ConsumeTelergy(SP, money, 1)
end

--白手入刃、脱泡卸甲
function UpdateTelergy6010(TLevel)
	local SP	= 110 * 1.045^(TLevel - 1)
	local money	= 120 * TLevel
	ConsumeTelergy(SP, money, 1)
end

function UpdateTelergy6011(TLevel)
	local SP	= 110 * 1.045^(TLevel - 1)
	local money	= 120 * TLevel
	ConsumeTelergy(SP, money, 1)
end

--心法提升附加属性值
function TelergyProperty6000(TLevel)
	local value = 10

	--函数回调 ，第一个参数，属性类型，第二个参数，属性值, 第三个参数，提升的属性概率，没有的传入0
	--类型编号：0、增加攻击力，1、增加防御力，2、增加生命值，3、增加内力值，4、增加体力值，5、增加闪避值，6、增加暴击值，
	--         7、增加吸血百分比，8、增加扣内百分比，9、增加扣体力百分比，10、增加扣攻击力的数量，11、增加扣防御力的数量，
	ConsumeTelergyProperty(0, value, 0)
end

function TelergyProperty6001(TLevel)
	local value = 7
	ConsumeTelergyProperty(1, value, 0)
end

function TelergyProperty6002(TLevel)
	local value = 80
	ConsumeTelergyProperty(2, value, 0)
end

function TelergyProperty6003(TLevel)
	local value = 15
	ConsumeTelergyProperty(3, value, 0)
end

function TelergyProperty6004(TLevel)
	local value = 2
	ConsumeTelergyProperty(4, value, 0)
end

function TelergyProperty6005(TLevel)
	local value = 6
	ConsumeTelergyProperty(5, value, 0)
end

function TelergyProperty6006(TLevel)
	local value = 4
	ConsumeTelergyProperty(6, value, 0)
end

function TelergyProperty6007(TLevel)
	local value = (TLevel - 1) * 0.005 + 0.005
	local rate = (TLevel - 1) * 50 + 50
	ConsumeTelergyProperty(7, value, rate)
end

function TelergyProperty6008(TLevel)
	local value = (TLevel - 1) * 0.001 + 0.001
	local rate  = (TLevel - 1) * 50 + 50
	ConsumeTelergyProperty(8, value, rate)
end

function TelergyProperty6009(TLevel)
	local value = (TLevel - 1) * 0.003 + 0.003
	local rate = (TLevel - 1) * 50 + 50
	ConsumeTelergyProperty(9, value, rate)
end

function TelergyProperty6010(TLevel)
	local value = (TLevel - 1) * 0.005 + 0.005
	local rate = (TLevel - 1) * 50 + 50
	ConsumeTelergyProperty(10, value, rate)
end

function TelergyProperty6011(TLevel)
	local value = (TLevel - 1) * 0.005 + 0.005
	local rate = (TLevel - 1) * 50 + 50
	ConsumeTelergyProperty(11, value, rate)
end
