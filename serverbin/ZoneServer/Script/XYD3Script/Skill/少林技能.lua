-- AddBuff
-- param_1	 1 -- 玩家自己 2 -- 队友 3 -- 攻击目标
-- param_2	 buffIndex


function InAttack3(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		if LuaRandRange(1,100) > 50 then
			AddFightBuff(3, 30005)	-- 昏迷目标
		end	
	end
end

function InAttack5(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		--AddFightBuff(3, 30000)	-- 昏迷目标
		--rfalse("InAttack5")
	end
end

function InAttack303(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		--AddFightBuff(1, 1)	-- 定身目标
	end
end

function InAttack307(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		--AddFightBuff(3, 30000)	-- 昏迷目标
	end
end



function InAttack309(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 30000)	-- 定身目标
	end
end

function InAttack2010(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 30000)	-- 昏迷目标
	end
end

function InAttack3010(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 30000)	-- 昏迷目标
	end
end

function InAttack5010(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 30000)	-- 昏迷目标
	end
end

function InAttack104()
	AddFightBuff(3,30000)	-- 昏迷目标
end

--[[function InAttack2000(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(3, 30004)	-- 昏迷目标
	end
end]]

--[[ 天龙护象
function InAttack3009(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(1, 30006)	-- 增加外功防御
		AddFightBuff(1, 30007)	-- 增加内功防御
		AddFightBuff(1, 30008)	-- 降低外功攻击
	end
end

-- 佛光普照
function InAttack3010(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(1, 30005)	-- 增加血上限
	end
end

-- 罗汉劲
function InAttack3011(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(2, 30009)	-- 队友增加外功防御
	end
end

-- 金刚身
function InAttack3012(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(1, 30004)	-- 100%吸收伤害
	end
end

-- 佛言正心
function InAttack3013(AtkTime, SkillLevel)
	if (1 == AtkTime) then
		AddFightBuff(1, 30010)	-- 抗毒
		AddFightBuff(1, 30011)	-- 抗眩晕
	end
end--]]

--[[ 被动技能永久Buff
--大金刚力
function AttachPasstiveSkillBuff3002(SkillLevel)
	AddFightBuff(3, 30010)--击退
end

--不动如山
function AttachPasstiveSkillBuff3003(SkillLevel)
	AddFightBuff(1, 30010)--抵抗击退
end

--佛音贯耳
function AttachPasstiveSkillBuff3005(SkillLevel)
	AddFightBuff(3, 30010)--定身
end

--明镜非台
function AttachPasstiveSkillBuff3006(SkillLevel)
	AddFightBuff(1, 30010)--抵抗定身
end

--天人五衰
function AttachPasstiveSkillBuff3007(SkillLevel)
	AddFightBuff(3, 30010)--减速
end

--一苇渡江
function AttachPasstiveSkillBuff3008(SkillLevel)
	AddFightBuff(1, 30010)--抵抗减速
end--]]



