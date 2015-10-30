--dofile("XYD3Script\\Skill\\五岳技能.lua")
--dofile("XYD3Script\\Skill\\蜀山技能.lua")
--dofile("XYD3Script\\Skill\\少林技能.lua")
--dofile("XYD3Script\\Skill\\慈航技能.lua")
--dofile("XYD3Script\\Skill\\日月技能.lua")
--dofile("XYD3Script\\Skill\\公用技能.lua")
dofile("XYD3Script\\Skill\\心法.lua")
dofile("XYD3Script\\Skill\\playerskill.lua")
dofile("XYD3Script\\Skill\\monsterskill.lua")
dofile("XYD3Script\\Skill\\skillhurtconfig.lua")
dofile("XYD3Script\\Skill\\HurtCalculate.lua")
dofile("XYD3Script\\Skill\\skill.lua")


function CheckAttackByClient(DefencerID,SkillID,SkillSubProperty)
  -- 冲锋路径的验证
	CheckWindMove(SkillSubProperty,DefencerID,SkillID)		
end


function InAttackBefore(DefencerID, SkillID,SkillSubProperty)
  -- 开始冲锋
	StartWindMove(SkillSubProperty,DefencerID,SkillID)		
end


function InAttackSkill(DefencerID, SkillID)
  if (2008 == SkillID) then		--蜀山:万剑诀
		return
	end
	
	SendAttackMsg();	
end

