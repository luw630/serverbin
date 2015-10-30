-- AddBuff
-- 1 -- 玩家自己 2 -- 队友 3 -- 攻击目标

--枯木生华
function InAttack3001(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 60000)--吸血
	end
end

--九转星罗
function InAttack3001(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 60001)--减内
	end
end

--云缭雾绕
function InAttack3001(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 60002)--减体
	end
end

--碧海潮生
function InAttack3001(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 60003)--减攻
	end
end

--凌空裂帛
function InAttack3001(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 60004)--减防
	end
end

--毒攻击
function InAttack12004(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 1001)--减防
	end
end


--add 2014/3/7 ly  用于技能升级消耗
function UpdateSkill(level, BaseSp, BAseMoney)
		--local sp =  BaseSp * 2.0 ^ (level - 1)
		local sp =  BaseSp * (level - 1)
		local money = BAseMoney * (level - 1)
		ConsumeTelergy(sp, money, 2)
end


--技能升级消耗
--[[
	1  近身技能
	2  远程技能
	3  范围技能
	4  辅助主动技能
	5  辅助抵抗技能
	6  被动技能
	7   (没有)冲锋技能，需要验证路径
	8  特殊技能(暂时没用了 2011.08.26 by dj)

	ConsumeTelergy(SP, money, 1) 函数说明

	第一个参数：消耗的真气
	第二个参数： 消耗的金钱
	第三个参数： 表示跟新的类型，1 表示心法，2 表示技能
--]]

function UpdateSkill1(level)
		local sp = 128 * 1.045 ^ (level - 1)
		local money = 100 * level
		ConsumeTelergy(sp, money, 2)
end

function UpdateSkill2(level)
		local sp = 120 * 1.045 ^ (level - 1)
		local money = 100 * level
		ConsumeTelergy(sp, money, 2)
end

function UpdateSkill3(level)
		local sp = 112 * 1.045 ^ (level - 1)
		local money = 100 * level
		ConsumeTelergy(sp, money, 2)
end

function UpdateSkill4(level)
		local sp = 102 * 1.045 ^ (level - 1)
		local money = 90 * level
		ConsumeTelergy(sp, money, 2)
end

function UpdateSkill5(level)
		local sp = 124 * 1.045 ^ (level - 1)
		local money = 95 * level
		ConsumeTelergy(sp, money, 2)
end

function UpdateSkill6(level)
		local sp = 107 * 1.045 ^ (level - 1)
		local money = 85 * level
		ConsumeTelergy(sp, money, 2)
end

function UpdateSkill8(level)
		local sp = 124 * 1.045 ^ (level - 1)
		local money = 110 * level
		ConsumeTelergy(sp, money, 2)
end
